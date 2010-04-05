From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 36/43] builtins: utilize startup_info->help where possible
Date: Mon,  5 Apr 2010 20:41:21 +0200
Message-ID: <1270492888-26589-37-git-send-email-pclouds@gmail.com>
References: <1270492888-26589-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 05 20:44:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyrHC-0000ps-Eg
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 20:43:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756131Ab0DESnv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Apr 2010 14:43:51 -0400
Received: from mail-fx0-f227.google.com ([209.85.220.227]:44752 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756129Ab0DESns (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Apr 2010 14:43:48 -0400
Received: by mail-fx0-f227.google.com with SMTP id 27so1251549fxm.28
        for <git@vger.kernel.org>; Mon, 05 Apr 2010 11:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=z/s/qhTInkBa9YfNAJ/VPwu4RpAdsklxCJNN5F5YEug=;
        b=NcrhWb40oEWpXu6vTmVLLkCKKh0wOEc0lwdYCuznHYP5oM2WfEofnQVIFlxCeFYzJM
         eJwgufQ/Ywumkk7b3BQz8MhzA3q4CnPRXb2wx7DFjA3KN3YnohtdqZKgZLO0hkkBt3lq
         LVewE/qlvvou1tJiGBf3nDGP6hQlkCF2AyQZc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=TREZ3OWVhy2jS9ajk/4p/y9l7uplDWbgRhp84YZFhMYuwaeawLpmxhOeGeVzBMnM2M
         L7Es+ohgF2B+NahZXJnqnxxARZBy0Fw3yM+CcJEGNWINNGnLB68jIWDXf+31YN6Hq/j6
         FiGlJ6UXDAcG8O95mJ1wIJY+ezqfKmyVaWXL0=
Received: by 10.223.15.21 with SMTP id i21mr6153638faa.58.1270493028028;
        Mon, 05 Apr 2010 11:43:48 -0700 (PDT)
Received: from dektop ([212.247.124.209])
        by mx.google.com with ESMTPS id 21sm1173448fks.23.2010.04.05.11.43.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 05 Apr 2010 11:43:47 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Mon,  5 Apr 2010 20:43:45 +0200
X-Mailer: git-send-email 1.7.0.rc1.541.g2da82.dirty
In-Reply-To: <1270492888-26589-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144031>

It helps reduce false alarms while I'm looking for "git foo -h" code
path that accesses repository. Anyway it looks like a good thing to
do.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/check-ref-format.c |    2 +-
 builtin/grep.c             |    2 +-
 builtin/index-pack.c       |    2 +-
 builtin/log.c              |    6 +-----
 builtin/merge-ours.c       |    2 +-
 builtin/pack-redundant.c   |    2 +-
 builtin/show-ref.c         |    2 +-
 7 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/builtin/check-ref-format.c b/builtin/check-ref-format.c
index b106c65..c13f90a 100644
--- a/builtin/check-ref-format.c
+++ b/builtin/check-ref-format.c
@@ -35,7 +35,7 @@ static void collapse_slashes(char *dst, const char *s=
rc)
=20
 int cmd_check_ref_format(int argc, const char **argv, const char *pref=
ix)
 {
-	if (argc =3D=3D 2 && !strcmp(argv[1], "-h"))
+	if (startup_info->help)
 		usage(builtin_check_ref_format_usage);
=20
 	if (argc =3D=3D 3 && !strcmp(argv[1], "--branch")) {
diff --git a/builtin/grep.c b/builtin/grep.c
index a4ea0c9..7b5e416 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -871,7 +871,7 @@ int cmd_grep(int argc, const char **argv, const cha=
r *prefix)
 	 * 'git grep -h', unlike 'git grep -h <pattern>', is a request
 	 * to show usage information and exit.
 	 */
-	if (argc =3D=3D 2 && !strcmp(argv[1], "-h"))
+	if (startup_info->help)
 		usage_with_options(grep_usage, options);
=20
 	memset(&opt, 0, sizeof(opt));
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 9aa6a13..44375a2 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -880,7 +880,7 @@ int cmd_index_pack(int argc, const char **argv, con=
st char *prefix)
 	struct pack_idx_entry **idx_objects;
 	unsigned char pack_sha1[20];
=20
-	if (argc =3D=3D 2 && !strcmp(argv[1], "-h"))
+	if (startup_info->help)
 		usage(index_pack_usage);
=20
 	/*
diff --git a/builtin/log.c b/builtin/log.c
index 542ecc7..294402b 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -50,11 +50,7 @@ static void cmd_log_init(int argc, const char **argv=
, const char *prefix,
 	if (default_date_mode)
 		rev->date_mode =3D parse_date_format(default_date_mode);
=20
-	/*
-	 * Check for -h before setup_revisions(), or "git log -h" will
-	 * fail when run without a git directory.
-	 */
-	if (argc =3D=3D 2 && !strcmp(argv[1], "-h"))
+	if (startup_info->help)
 		usage(builtin_log_usage);
 	argc =3D setup_revisions(argc, argv, rev, opt);
=20
diff --git a/builtin/merge-ours.c b/builtin/merge-ours.c
index 6844116..8e0777b 100644
--- a/builtin/merge-ours.c
+++ b/builtin/merge-ours.c
@@ -20,7 +20,7 @@ static const char *diff_index_args[] =3D {
=20
 int cmd_merge_ours(int argc, const char **argv, const char *prefix)
 {
-	if (argc =3D=3D 2 && !strcmp(argv[1], "-h"))
+	if (startup_info->help)
 		usage(builtin_merge_ours_usage);
=20
 	/*
diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index 41e1615..3f090b2 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -601,7 +601,7 @@ int cmd_pack_redundant(int argc, const char **argv,=
 const char *prefix)
 	unsigned char *sha1;
 	char buf[42]; /* 40 byte sha1 + \n + \0 */
=20
-	if (argc =3D=3D 2 && !strcmp(argv[1], "-h"))
+	if (startup_info->help)
 		usage(pack_redundant_usage);
=20
 	for (i =3D 1; i < argc; i++) {
diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index 17ada88..59f90df 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -204,7 +204,7 @@ static const struct option show_ref_options[] =3D {
=20
 int cmd_show_ref(int argc, const char **argv, const char *prefix)
 {
-	if (argc =3D=3D 2 && !strcmp(argv[1], "-h"))
+	if (startup_info->help)
 		usage_with_options(show_ref_usage, show_ref_options);
=20
 	argc =3D parse_options(argc, argv, prefix, show_ref_options,
--=20
1.7.0.rc1.541.g2da82.dirty
