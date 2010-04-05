From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 16/43] ls-remote: use RUN_SETUP_GENTLY
Date: Mon,  5 Apr 2010 20:41:01 +0200
Message-ID: <1270492888-26589-17-git-send-email-pclouds@gmail.com>
References: <1270492888-26589-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 05 20:43:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyrH0-0000ps-Rl
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 20:43:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756062Ab0DESmg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Apr 2010 14:42:36 -0400
Received: from mail-fx0-f227.google.com ([209.85.220.227]:44752 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756048Ab0DESm1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Apr 2010 14:42:27 -0400
Received: by mail-fx0-f227.google.com with SMTP id 27so1251549fxm.28
        for <git@vger.kernel.org>; Mon, 05 Apr 2010 11:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=sN5/5kBfE5bW3KZO/9eO2JgqryxLJseTRXCKkNTvn6A=;
        b=evEgWuJlBIR4D+yAj/ygee/JuNXFWTecLeVe/gPEgUCKfOCzrD7EODQjaCtmqJlplZ
         RYOoT26OuYgMO4/BgjgEBohl6IDKa0BvlBKipCz2OfP3CPkC4yzzAlwtKt731iVDD9U/
         7wIZMaVFUP4X3EGndWNA3xe/+hWWHhaixVV80=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=JRzntkVO/WM5mOU8+giKbuxLKvCxORk0FBcmwIRDMSGXL1m7+LV57xMORqtjxnNmGc
         h+KOvLUu7soZamiTsOn7bd+4rLNdU/2ShvlfJrYcYQp6VCvoJ0GjghE+08dgSIfNkyoG
         +HtCRwAI2bi24wE9daCrhfZf/q1GG7nFzl9vs=
Received: by 10.223.50.193 with SMTP id a1mr6221135fag.34.1270492946548;
        Mon, 05 Apr 2010 11:42:26 -0700 (PDT)
Received: from dektop ([212.247.124.209])
        by mx.google.com with ESMTPS id 2sm8940949fks.42.2010.04.05.11.42.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 05 Apr 2010 11:42:25 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Mon,  5 Apr 2010 20:42:24 +0200
X-Mailer: git-send-email 1.7.0.rc1.541.g2da82.dirty
In-Reply-To: <1270492888-26589-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144014>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/ls-remote.c |    3 ---
 git.c               |    4 ++--
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index 70f5622..998f2c8 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -31,7 +31,6 @@ int cmd_ls_remote(int argc, const char **argv, const =
char *prefix)
 {
 	int i;
 	const char *dest =3D NULL;
-	int nongit;
 	unsigned flags =3D 0;
 	const char *uploadpack =3D NULL;
 	const char **pattern =3D NULL;
@@ -40,8 +39,6 @@ int cmd_ls_remote(int argc, const char **argv, const =
char *prefix)
 	struct transport *transport;
 	const struct ref *ref;
=20
-	setup_git_directory_gently(&nongit);
-
 	for (i =3D 1; i < argc; i++) {
 		const char *arg =3D argv[i];
=20
diff --git a/git.c b/git.c
index 02ba3b2..257ddde 100644
--- a/git.c
+++ b/git.c
@@ -338,7 +338,7 @@ static void handle_internal_command(int argc, const=
 char **argv)
 		{ "log", cmd_log, RUN_SETUP | USE_PAGER },
 		{ "ls-files", cmd_ls_files, RUN_SETUP },
 		{ "ls-tree", cmd_ls_tree, RUN_SETUP },
-		{ "ls-remote", cmd_ls_remote },
+		{ "ls-remote", cmd_ls_remote, RUN_SETUP_GENTLY },
 		{ "mailinfo", cmd_mailinfo, RUN_SETUP_GENTLY },
 		{ "mailsplit", cmd_mailsplit },
 		{ "merge", cmd_merge, RUN_SETUP | NEED_WORK_TREE },
@@ -359,7 +359,7 @@ static void handle_internal_command(int argc, const=
 char **argv)
 		{ "pack-objects", cmd_pack_objects, RUN_SETUP },
 		{ "pack-redundant", cmd_pack_redundant, RUN_SETUP },
 		{ "patch-id", cmd_patch_id },
-		{ "peek-remote", cmd_ls_remote },
+		{ "peek-remote", cmd_ls_remote, RUN_SETUP_GENTLY },
 		{ "pickaxe", cmd_blame, RUN_SETUP },
 		{ "prune", cmd_prune, RUN_SETUP },
 		{ "prune-packed", cmd_prune_packed, RUN_SETUP },
--=20
1.7.0.rc1.541.g2da82.dirty
