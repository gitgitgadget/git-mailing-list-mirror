From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 11/21] list-files: -u does not imply showing stages
Date: Sun, 25 Jan 2015 19:37:46 +0700
Message-ID: <1422189476-7518-12-git-send-email-pclouds@gmail.com>
References: <1422189476-7518-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 25 13:28:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YFMIU-0002hd-Bo
	for gcvg-git-2@plane.gmane.org; Sun, 25 Jan 2015 13:28:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753553AbbAYM2G convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Jan 2015 07:28:06 -0500
Received: from mail-pd0-f169.google.com ([209.85.192.169]:58049 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753337AbbAYM2E (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2015 07:28:04 -0500
Received: by mail-pd0-f169.google.com with SMTP id g10so6876919pdj.0
        for <git@vger.kernel.org>; Sun, 25 Jan 2015 04:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Rye5QEudmdgrM0PPI3aNQmF40it6tQfQqE2ZQRj3GqM=;
        b=HZcJiar0I3AUyljjzsw8/N42F3YOWSVftG2vIXMU238nlts4RiXco4onb8TJavenKv
         OKHEh7URSqNB4oJTkpzIKtqbcxSl+R2ctoP7DTMP/oYm3t/aPbccR7PRo+1j/BjhDBAz
         BEC+w3cgNrDXdp+iAcjzAts9xB1duC0x8xlGWmF/J3y/MIW6wWDkycRX2TKh6SixhQ9h
         JsGiUYFtAH4RZyl4VTq8HJ6FyaHvhs78fTsNzz338rJU/HeVJJdn1WaS3yafmIy4byWk
         +saGd33xEkgdCgLx/dhD7qUVUwW/4bp5zYHfHdzRlBR0J23XkdOINMCQQ/q+JdVJlGF/
         B7EQ==
X-Received: by 10.68.65.77 with SMTP id v13mr26781037pbs.56.1422188884507;
        Sun, 25 Jan 2015 04:28:04 -0800 (PST)
Received: from lanh ([115.73.204.104])
        by mx.google.com with ESMTPSA id fu1sm7098917pdb.80.2015.01.25.04.28.01
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Jan 2015 04:28:03 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 25 Jan 2015 19:39:29 +0700
X-Mailer: git-send-email 2.2.0.84.ge9c7a8a
In-Reply-To: <1422189476-7518-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263008>

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
index eca9407..f2c29ce 100644
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
2.2.0.84.ge9c7a8a
