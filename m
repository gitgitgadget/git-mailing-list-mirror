From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 11/21] list-files: -u does not imply showing stages
Date: Sun,  8 Feb 2015 16:01:29 +0700
Message-ID: <1423386099-19994-12-git-send-email-pclouds@gmail.com>
References: <1423386099-19994-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 08 10:03:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKNm4-00067q-2A
	for gcvg-git-2@plane.gmane.org; Sun, 08 Feb 2015 10:03:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755674AbbBHJDV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Feb 2015 04:03:21 -0500
Received: from mail-pd0-f170.google.com ([209.85.192.170]:38887 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754599AbbBHJDT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2015 04:03:19 -0500
Received: by pdbft15 with SMTP id ft15so24362764pdb.5
        for <git@vger.kernel.org>; Sun, 08 Feb 2015 01:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=uRuVzRv7uDXednpCMPyz8FrjCww2I6ALBV7U4x7SQBg=;
        b=hiRawQEGInEyuJShB3bTSVtJxuD/iso8bYi981wK97LugjRsV+stN1sk7RJ9iyufo4
         a4hNnix0ouCjAWtj4B7kDszk54IsiWHn/byrpT6ML78qNgh9eVzKUP/mTOFyi5vLWLGV
         AKL6bQLU0SRj6qYkLxA31xrQqoaRa1xO9TxWr87bmisNWXY0Np6PY35bQZoqcPuJI3q1
         hM2+JUCN/VYEOiqHE069nb8+tbZ4toIh6U3aOTYHt9x0ad86HXDWaSP17NkgmZn3k8T5
         VUTCCY8XKuJjg3TXnhcIP4rKi9AZqPm+SgQwcv6Rg59qFmZ97xTACouIWTZ2PgZ4DI6A
         bjxQ==
X-Received: by 10.66.219.35 with SMTP id pl3mr19553142pac.32.1423386199590;
        Sun, 08 Feb 2015 01:03:19 -0800 (PST)
Received: from lanh ([115.73.243.52])
        by mx.google.com with ESMTPSA id lq2sm13049921pab.34.2015.02.08.01.03.16
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Feb 2015 01:03:19 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 Feb 2015 16:03:27 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1423386099-19994-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263498>

Showing full index entry information is something for ls-files
only. The users of "git list-files" may just want to know what entries
are not unmerged.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/ls-files.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index d55b5e7..c5468c7 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -656,7 +656,7 @@ int cmd_ls_files(int argc, const char **argv, const=
 char *cmd_prefix)
 	}
 	if (show_modified || show_others || show_deleted || (dir.flags & DIR_=
SHOW_IGNORED) || show_killed)
 		require_work_tree =3D 1;
-	if (show_unmerged)
+	if (show_unmerged && !porcelain)
 		/*
 		 * There's no point in showing unmerged unless
 		 * you also show the stage information.
--=20
2.3.0.rc1.137.g477eb31
