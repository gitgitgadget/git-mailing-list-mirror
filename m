From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 25/26] worktree move: accept destination as directory
Date: Tue, 16 Feb 2016 20:29:26 +0700
Message-ID: <1455629367-26193-26-git-send-email-pclouds@gmail.com>
References: <1454492150-10628-1-git-send-email-pclouds@gmail.com>
 <1455629367-26193-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 16 14:31:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVfjP-00049f-QJ
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 14:31:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932468AbcBPNbr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Feb 2016 08:31:47 -0500
Received: from mail-pf0-f180.google.com ([209.85.192.180]:33855 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932262AbcBPNbn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2016 08:31:43 -0500
Received: by mail-pf0-f180.google.com with SMTP id x65so105419409pfb.1
        for <git@vger.kernel.org>; Tue, 16 Feb 2016 05:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=802CxMYXHNEtMMVjJ05yPzIgzCXHmfLJ5EWZw332Bzs=;
        b=V0YC7vIzDlSFAGjl1miJ7XHgOJWcl0KY4yauSXKVEtlzo3Mxzy63zQjZINR1ysJWQQ
         Yta9Qr/50H8kea1uAXLkKELXnJpWBCKuaTDbGsBnMf9kUDJPqVHXSkAj+u79PZHUz7tU
         aAS9jUZNhbjDaR9/AiVILK7ps7ujFygcMRTEhYT6JkOtfAgyv1+tRI7fsxW9ijfvTMWF
         CpqSKW76tJ1AOLnJKZY0KfO52tCS9h3FU4u8fDEnrrOhwi2M8RFEXo+1UN9qB2WXPuBk
         AUrVTl2rYbGjhjUaCSIZy/2qQf1XH7RrlE0rTlDepYWWUs7rlv3sZ9xVC8FiF9iY5yTG
         1GaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=802CxMYXHNEtMMVjJ05yPzIgzCXHmfLJ5EWZw332Bzs=;
        b=llsyk3wWAu9lJ5cncP4z4lTttYkf/qTWRMFTTDhdVw0b+4/VzWpRXkqZEwDIuiZXyu
         f3Pv8UED7Lkb/JCR/cVljDUm6el9+v3ZaN+/xccm3Hkm2ia85yZjpoxMBg7MGwLl/oRC
         PpmtmRh0S1tmiAor2sGhosL1uuPnKDuDHPR/HJfuEVnAv+HkjaHyVkbpZBCLaylAG4xv
         Vs5zEKpPESD6+TsMwXS+Quf4uS19L19esNyf9rbLiWdE1hppWQy+KRMBYtvVQzh19bJJ
         KVwT5KzWtQTQ3bOZq55ilvdnf+ztnMwhRZ+MjQabF0D2MtYeQMf9W/Ln++SjRrh0mlVX
         j5Aw==
X-Gm-Message-State: AG10YOTYWS8JICo4QFliFvHN3nmGHvkZQWWuvm4cQaTBMH6eb/VsIT0BrnmK18vatD9T9w==
X-Received: by 10.98.19.22 with SMTP id b22mr31210433pfj.17.1455629503285;
        Tue, 16 Feb 2016 05:31:43 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id 144sm45944063pfa.83.2016.02.16.05.31.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Feb 2016 05:31:41 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 16 Feb 2016 20:32:06 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <1455629367-26193-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286392>

Similar to "mv a b/", which is actually "mv a b/a", we extract basename
of source worktree and create a directory of the same name at
destination if dst path is a directory.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/worktree.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index acd49da..d4ce987 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -531,7 +531,13 @@ static int move_worktree(int ac, const char **av, =
const char *prefix)
 	strbuf_addstr(&dst, prefix_filename(prefix,
 					    strlen(prefix),
 					    av[1]));
-	if (file_exists(dst.buf))
+	if (is_directory(dst.buf))
+		/*
+		 * keep going, dst will be appended after we get the
+		 * source's absolute path
+		 */
+		;
+	else if (file_exists(dst.buf))
 		die(_("target '%s' already exists"), av[1]);
=20
 	worktrees =3D get_worktrees();
@@ -551,6 +557,17 @@ static int move_worktree(int ac, const char **av, =
const char *prefix)
 	if (validate_worktree(wt, 0))
 		return -1;
=20
+	if (is_directory(dst.buf)) {
+		const char *sep =3D strrchr(wt->path, '/');
+
+		if (!sep)
+			die(_("could not figure out destination name from '%s'"),
+			    wt->path);
+		strbuf_addstr(&dst, sep);
+		if (file_exists(dst.buf))
+			die(_("target '%s' already exists"), dst.buf);
+	}
+
 	/*
 	 * First try. Atomically move, and probably cheaper, if both
 	 * source and target are on the same file system.
--=20
2.7.0.377.g4cd97dd
