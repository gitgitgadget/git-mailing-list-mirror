From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 4/6] Initialize gettext for test programs that may use it
Date: Fri, 24 Aug 2012 12:43:04 +0700
Message-ID: <1345786986-10826-5-git-send-email-pclouds@gmail.com>
References: <1345786986-10826-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 24 07:44:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4mgu-0000qC-6e
	for gcvg-git-2@plane.gmane.org; Fri, 24 Aug 2012 07:44:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752159Ab2HXFoO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Aug 2012 01:44:14 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:58122 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753275Ab2HXFoL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Aug 2012 01:44:11 -0400
Received: by dady13 with SMTP id y13so783950dad.19
        for <git@vger.kernel.org>; Thu, 23 Aug 2012 22:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=PZoZ8DjhwT10kcAXkZFNcfVq2UD+Z1chpEejvMOiPTk=;
        b=EzZm7DXjEORPkC4PSs9tNFWnUe1kkuIngNipB+ahq4czYJnSjtmwGQdH+GF0zbjyLR
         Mn1+zMPC0PvyHdZgDlCaAml79L/2mxOqua8uoHZX+IWx9i9YgxlfzARW6SelTe4NfwBp
         ViFEePssGu8oAVk0O2t+lWmL2NizZFRJgAjAbT5PYgVq1vxbUhBjHOyC13TFrEb5+rLi
         H2/cjqk4IcAoND6IVBu7A2UYwV/tV4jYQ9yVT9qXtarPEz/Y7c22iAySEmS8jenLG5tL
         A240rE6QDNAeo8jWN1DAssmzf7rHD5lzgqaCNxpMd3jNYksTLtGTWLnvdZabrNnG/2TQ
         0Krg==
Received: by 10.68.132.41 with SMTP id or9mr9988842pbb.115.1345787050667;
        Thu, 23 Aug 2012 22:44:10 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id wh7sm7580042pbc.33.2012.08.23.22.44.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 23 Aug 2012 22:44:10 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 24 Aug 2012 12:43:52 +0700
X-Mailer: git-send-email 1.7.12.rc2
In-Reply-To: <1345786986-10826-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204185>

Gettext poison was a macro and _() always returned
"# GETTEXT POISON #". Now that we use real gettext(),
it has to be initialized or it won't work.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 test-date.c             | 1 +
 test-delta.c            | 1 +
 test-dump-cache-tree.c  | 5 ++++-
 test-index-version.c    | 1 +
 test-match-trees.c      | 1 +
 test-mergesort.c        | 1 +
 test-parse-options.c    | 1 +
 test-path-utils.c       | 1 +
 test-revision-walking.c | 1 +
 test-scrap-cache-tree.c | 4 +++-
 test-sha1.c             | 1 +
 test-subprocess.c       | 1 +
 12 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/test-date.c b/test-date.c
index 10afaab..3881d33 100644
--- a/test-date.c
+++ b/test-date.c
@@ -48,6 +48,7 @@ int main(int argc, char **argv)
 	struct timeval now;
 	const char *x;
=20
+	git_setup_gettext();
 	x =3D getenv("TEST_DATE_NOW");
 	if (x) {
 		now.tv_sec =3D atoi(x);
diff --git a/test-delta.c b/test-delta.c
index af40a3c..ac86cae 100644
--- a/test-delta.c
+++ b/test-delta.c
@@ -22,6 +22,7 @@ int main(int argc, char *argv[])
 	void *from_buf, *data_buf, *out_buf;
 	unsigned long from_size, data_size, out_size;
=20
+	git_setup_gettext();
 	if (argc !=3D 5 || (strcmp(argv[1], "-d") && strcmp(argv[1], "-p"))) =
{
 		fprintf(stderr, "Usage: %s\n", usage_str);
 		return 1;
diff --git a/test-dump-cache-tree.c b/test-dump-cache-tree.c
index a6ffdf3..2023475 100644
--- a/test-dump-cache-tree.c
+++ b/test-dump-cache-tree.c
@@ -56,7 +56,10 @@ static int dump_cache_tree(struct cache_tree *it,
=20
 int main(int ac, char **av)
 {
-	struct cache_tree *another =3D cache_tree();
+	struct cache_tree *another;
+
+	git_setup_gettext();
+	another =3D cache_tree();
 	if (read_cache() < 0)
 		die("unable to read index file");
 	cache_tree_update(another, active_cache, active_nr, WRITE_TREE_DRY_RU=
N);
diff --git a/test-index-version.c b/test-index-version.c
index bfaad9e..703f4bd 100644
--- a/test-index-version.c
+++ b/test-index-version.c
@@ -5,6 +5,7 @@ int main(int argc, const char **argv)
 	struct cache_header hdr;
 	int version;
=20
+	git_setup_gettext();
 	memset(&hdr,0,sizeof(hdr));
 	if (read(0, &hdr, sizeof(hdr)) !=3D sizeof(hdr))
 		return 0;
diff --git a/test-match-trees.c b/test-match-trees.c
index a3c4688..5299292 100644
--- a/test-match-trees.c
+++ b/test-match-trees.c
@@ -6,6 +6,7 @@ int main(int ac, char **av)
 	unsigned char hash1[20], hash2[20], shifted[20];
 	struct tree *one, *two;
=20
+	git_setup_gettext();
 	if (get_sha1(av[1], hash1))
 		die("cannot parse %s as an object name", av[1]);
 	if (get_sha1(av[2], hash2))
diff --git a/test-mergesort.c b/test-mergesort.c
index 3f388b4..2289cb1 100644
--- a/test-mergesort.c
+++ b/test-mergesort.c
@@ -27,6 +27,7 @@ int main(int argc, const char **argv)
 	struct line *line, *p =3D NULL, *lines =3D NULL;
 	struct strbuf sb =3D STRBUF_INIT;
=20
+	git_setup_gettext();
 	for (;;) {
 		if (strbuf_getwholeline(&sb, stdin, '\n'))
 			break;
diff --git a/test-parse-options.c b/test-parse-options.c
index 3c9510a..4a94327 100644
--- a/test-parse-options.c
+++ b/test-parse-options.c
@@ -81,6 +81,7 @@ int main(int argc, const char **argv)
 	};
 	int i;
=20
+	git_setup_gettext();
 	argc =3D parse_options(argc, argv, prefix, options, usage, 0);
=20
 	printf("boolean: %d\n", boolean);
diff --git a/test-path-utils.c b/test-path-utils.c
index 3bc20e9..f3b4cee 100644
--- a/test-path-utils.c
+++ b/test-path-utils.c
@@ -2,6 +2,7 @@
=20
 int main(int argc, char **argv)
 {
+	git_setup_gettext();
 	if (argc =3D=3D 3 && !strcmp(argv[1], "normalize_path_copy")) {
 		char *buf =3D xmalloc(PATH_MAX + 1);
 		int rv =3D normalize_path_copy(buf, argv[2]);
diff --git a/test-revision-walking.c b/test-revision-walking.c
index 3ade02c..5f476c0 100644
--- a/test-revision-walking.c
+++ b/test-revision-walking.c
@@ -47,6 +47,7 @@ static int run_revision_walk(void)
=20
 int main(int argc, char **argv)
 {
+	git_setup_gettext();
 	if (argc < 2)
 		return 1;
=20
diff --git a/test-scrap-cache-tree.c b/test-scrap-cache-tree.c
index 4728013..67234e1 100644
--- a/test-scrap-cache-tree.c
+++ b/test-scrap-cache-tree.c
@@ -6,7 +6,9 @@ static struct lock_file index_lock;
=20
 int main(int ac, char **av)
 {
-	int fd =3D hold_locked_index(&index_lock, 1);
+	int fd;
+	git_setup_gettext();
+	fd =3D hold_locked_index(&index_lock, 1);
 	if (read_cache() < 0)
 		die("unable to read index file");
 	active_cache_tree =3D NULL;
diff --git a/test-sha1.c b/test-sha1.c
index 80daba9..9a02ce8 100644
--- a/test-sha1.c
+++ b/test-sha1.c
@@ -7,6 +7,7 @@ int main(int ac, char **av)
 	unsigned bufsz =3D 8192;
 	char *buffer;
=20
+	git_setup_gettext();
 	if (ac =3D=3D 2)
 		bufsz =3D strtoul(av[1], NULL, 10) * 1024 * 1024;
=20
diff --git a/test-subprocess.c b/test-subprocess.c
index f2d4c0d..9cf8e29 100644
--- a/test-subprocess.c
+++ b/test-subprocess.c
@@ -6,6 +6,7 @@ int main(int argc, const char **argv)
 	struct child_process cp;
 	int nogit =3D 0;
=20
+	git_setup_gettext();
 	setup_git_directory_gently(&nogit);
 	if (nogit)
 		die("No git repo found");
--=20
1.7.12.rc2
