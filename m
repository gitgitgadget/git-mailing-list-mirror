From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/3] index-pack: use RUN_SETUP_GENTLY
Date: Mon,  8 Mar 2010 23:50:33 +0700
Message-ID: <1268067033-25199-3-git-send-email-pclouds@gmail.com>
References: <1268067033-25199-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 08 17:54:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NogDn-0007MJ-5p
	for gcvg-git-2@lo.gmane.org; Mon, 08 Mar 2010 17:54:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752463Ab0CHQyP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Mar 2010 11:54:15 -0500
Received: from mail-ew0-f216.google.com ([209.85.219.216]:45653 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751656Ab0CHQyN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Mar 2010 11:54:13 -0500
Received: by mail-ew0-f216.google.com with SMTP id 8so220474ewy.28
        for <git@vger.kernel.org>; Mon, 08 Mar 2010 08:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=7B/I8vhvcVgxlCdZieJA1imHqi/WnCnEk4iJjJprwvU=;
        b=RkwZs1AC2RhBEYeDVLrTQCimvdxqrz9Arc/7s7Rm45Fc8E/+WQiEMiQTz8QB5uVIGF
         lPxfhnLs6SUtftxZbY8fhvvCqDyQcYnjh1lgKbz/8CLG3M+6pgEWNi8SwBjtdguW5LAy
         1nkvwN/WoPfphX79kVqwnYclq0rHm2mZkld10=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=JNax+93MHmwuH0XZC3aByGQEVwroH8Fv+Qt7InH6nifceQhlSItx+PVVVtUmg5keLP
         Xk1E6cXHDrRLCz4drsQyIvPw3s/j67o9r6YVfrIxPf2ecoMzUYsgRi4o0YkgVrLmYjdD
         8zZ4GODrQqPG0Fbb40++mJ9ExxI1Xu2SnN4X4=
Received: by 10.213.109.203 with SMTP id k11mr3175525ebp.47.1268067252567;
        Mon, 08 Mar 2010 08:54:12 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.196.130])
        by mx.google.com with ESMTPS id 13sm2432442ewy.5.2010.03.08.08.54.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 08 Mar 2010 08:54:11 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon,  8 Mar 2010 23:50:52 +0700
X-Mailer: git-send-email 1.7.0.1.384.g6abcaa
In-Reply-To: <1268067033-25199-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141773>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/index-pack.c |    2 --
 git.c                |    2 +-
 2 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 2a6359d..9aa6a13 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -879,7 +879,6 @@ int cmd_index_pack(int argc, const char **argv, con=
st char *prefix)
 	char *index_name_buf =3D NULL, *keep_name_buf =3D NULL;
 	struct pack_idx_entry **idx_objects;
 	unsigned char pack_sha1[20];
-	int nongit;
=20
 	if (argc =3D=3D 2 && !strcmp(argv[1], "-h"))
 		usage(index_pack_usage);
@@ -889,7 +888,6 @@ int cmd_index_pack(int argc, const char **argv, con=
st char *prefix)
 	 * However if the cwd was inside .git/objects/pack/ then we need
 	 * to go back there or all the pack name arguments will be wrong.
 	 */
-	prefix =3D setup_git_directory_gently(&nongit);
 	git_config(git_index_pack_config, NULL);
 	if (prefix && chdir(prefix))
 		die("Cannot come back to cwd");
diff --git a/git.c b/git.c
index 88408c8..746470f 100644
--- a/git.c
+++ b/git.c
@@ -332,7 +332,7 @@ static void handle_internal_command(int argc, const=
 char **argv)
 		{ "grep", cmd_grep, RUN_SETUP_GENTLY | USE_PAGER },
 		{ "hash-object", cmd_hash_object, RUN_SETUP_GENTLY },
 		{ "help", cmd_help, RUN_SETUP_GENTLY },
-		{ "index-pack", cmd_index_pack },
+		{ "index-pack", cmd_index_pack, RUN_SETUP_GENTLY },
 		{ "init", cmd_init_db },
 		{ "init-db", cmd_init_db },
 		{ "log", cmd_log, RUN_SETUP | USE_PAGER },
--=20
1.7.0.1.384.g6abcaa
