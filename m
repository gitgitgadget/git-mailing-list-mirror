From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 8/8] checkout --to: do not touch existing target directory
Date: Tue, 29 Jul 2014 20:50:31 +0700
Message-ID: <1406641831-2390-9-git-send-email-pclouds@gmail.com>
References: <1406115795-24082-1-git-send-email-pclouds@gmail.com>
 <1406641831-2390-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Max Kirillov <max@max630.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	git@drmicha.warpmail.net,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 29 15:53:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XC7qI-0005uf-FC
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 15:53:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753835AbaG2NxT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Jul 2014 09:53:19 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:59710 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753831AbaG2NxQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2014 09:53:16 -0400
Received: by mail-pa0-f48.google.com with SMTP id et14so12326138pad.7
        for <git@vger.kernel.org>; Tue, 29 Jul 2014 06:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=UkqxDb8oWaqz4rS4N8lnlXI85sHvZiTKgvfjEnxDGSU=;
        b=tBzXGHfcPFYAj2P1gt/UwWhGZTJRLr8k5bMtabxVy+yBBQMG+j+EARk2Tz8X6fGGSx
         zDo0enm1GzmweS45y0ujWo7KwSH9eNE9O1Z83qCSN5FIXaB29I0WNpO2vU75l9F2dXT2
         LddXoWmeJuK/IIHyuMo8guVH0GKsQTvaGCZBSVw5w8CCYN9iBlIkqKWUcqqw0DD5yRHb
         K75/OLkL2T2B2Bu6pIxYX/9TKihC9xa5EkIRwgQLx39wKYN6H2JIu72IQVBYoTx2ocaq
         JbabnwfTuwGmUusY8OVfQXIJaaoa7Lszo3we45nfHeb9C3b6xz/k6RCiRaQUgCtFwwa/
         taEQ==
X-Received: by 10.70.90.7 with SMTP id bs7mr2131935pdb.141.1406641996293;
        Tue, 29 Jul 2014 06:53:16 -0700 (PDT)
Received: from lanh ([115.73.243.195])
        by mx.google.com with ESMTPSA id tg9sm20841219pbc.29.2014.07.29.06.53.13
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jul 2014 06:53:15 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 29 Jul 2014 20:53:19 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1406641831-2390-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254441>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/checkout.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 4fbb9c1..3dc416c 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -861,6 +861,8 @@ static int prepare_linked_checkout(const struct che=
ckout_opts *opts,
=20
 	if (!new->commit)
 		die(_("no branch specified"));
+	if (file_exists(path))
+		die(_("%s already exists"), path);
=20
 	len =3D strlen(path);
 	while (len && is_dir_sep(path[len - 1]))
--=20
2.1.0.rc0.78.gc0d8480
