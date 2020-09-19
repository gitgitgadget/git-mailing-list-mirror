Return-Path: <SRS0=5dtp=C4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57CCCC43463
	for <git@archiver.kernel.org>; Sat, 19 Sep 2020 21:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 026D5222BB
	for <git@archiver.kernel.org>; Sat, 19 Sep 2020 21:23:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="TTsCR9dR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbgISVXt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Sep 2020 17:23:49 -0400
Received: from mout.web.de ([212.227.17.11]:41065 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726528AbgISVXs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Sep 2020 17:23:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1600550623;
        bh=rfr+VkvdZ9atojVNNx7DBcKKgrzoxtRmnIGIQm0/d1w=;
        h=X-UI-Sender-Class:Subject:From:To:References:Date:In-Reply-To;
        b=TTsCR9dRLxs0qa/uUmbd+QMWVaFp64b7C3GrW+5dvZSVsUH7Bub6nCPspqgITpWzB
         9oVtTUVCArFr1omactV04x/+eLr+SYAyjisc6aoRTlbLtxtL9X+y43kbNkrtQFI/R4
         XnDhpTFjyox51Yg2lC14Rak8leZ2WB6SLU9CKLo8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.149.245]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LdF4n-1kkWVi26ZV-00iWoV; Sat, 19
 Sep 2020 23:23:43 +0200
Subject: [PATCH 2/3] archive: add --add-file
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqwo0qk0fw.fsf@gitster.c.googlers.com>
 <b7ef3952-872a-40af-0f2e-c392b031a280@web.de>
Message-ID: <1c03ea9b-ec91-9a07-781f-626530ac5a8d@web.de>
Date:   Sat, 19 Sep 2020 23:23:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <b7ef3952-872a-40af-0f2e-c392b031a280@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lZgNEVe79xOYG+MbeIk7jBEW7ebJYEcJtLjZ4nP79Gx3jzMK4Md
 SM4uN64cVBYnDoq2+o6Nxb+W6S90RSnMbzL5HxTmMXOO7Eg4XJha1BIa5pKNRDWu3AUlMyN
 YXTRYAdrxxz0OQf5urv5gr0dkQX8deNAU0cEgn1v1uK183K+bsHU1o4hEnFuNOMWvATA7ye
 HLTDIUZZp9uaiq86fa4wg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KqXirrGr9TE=:jkFphmRQuST09W/CCTVjkM
 F4K6GQfyanj97yrJI+KuxKzq+TDjBCnLfVkUqH/MhiC2r2/Rv0hz1vuF4TFtXgwAiHdpzfxnJ
 vivykvQ+LkRm+wmm6rFrZAbSNm0wEx/6dWlOLbsEdNrHCeMrYY9KkDmrgiTs60HRtJDVkQLpu
 dw6z/ox4xdTDCDXeCUldbXeIY0waNLFXzJ4H8fdaeqoyUJKUNlgT7AetX6NUgVgYqDkpZBjdi
 a0D4mJ5ZXtU1ZP8j/g6gDk6Y3PixQ4CZLkLC2FFOhKSVfw3Y3EK9u1TCIZR371HYe+SY0hO0b
 vdlsUJw1uQkgQ5PovcjPdP6chfbvBFDrUBPTH4OTynvDd0OL1fjjB2LgUIXJh5yoTSQMAZBw7
 kdR6AEcw3RMf3kxFtTWHJl/nrpxcpEmpc/bDDepbbI8dgixLhqBvG9P4iTmwPRF7j+PYqrwB9
 ZSFdv4ba/ICwfm8mUjhXttralMdVBpzqCAKhUtu6TA98RVB9+VZnkycPFspOWprtlMtYPpKQu
 bjXB/yB4rw5907X1uuIXNWrJ8PtZ8ouRD0jV7NBQxNSNdT4mKmCBn0iIVuZxlpyE2B8GtPiL9
 3r1Ex91baQGr7i3A5sLjbu/1rgG9mDCtc2Vku7EFTa3W1V+3k8jRFM9ZoDXUROquPtQ1k0YZ9
 IuuYbltk/rRLeAtmsHB3ZBmJbw4ziSPgCA9O8rayc4urNd1n37lFP0+kPdmVHSvNEmOFxLYFs
 ZjzyAnDNM/2gfbGcJ8Dex1fUagWshOCP652sVuCzoFCpAQKrHPDLUnfb2k0i1etIlgB5UusWr
 TMXXVIsoScr6xTHsfpnMxe7YOc3Z8tu5xE3W/sFUf8c4Qz9AjEYy5QxagLVI95RzZRKO3bM8v
 s94Lctm9E04NxagDHFtBkJ1GqQAvu7IlAC1dmlgr+Bih6l4dizfAKS8CdHhU+jJHVt1TvveqL
 VOQSSOsB8Y56C5d6JGcjxNo8Q9LIewl2MbvebabobgUfNcCORXh6wOTv/u2DZijKKb/9Kc9HP
 CYY7B21NmgcLDWYAgB7mefSgoeuKXZ0p6AhiOYiTfwqP4ubaRSeaxPE8xB3ZNmAftIJJJ9bqN
 ViNSFk52iyHo9R9gryQpV88MBn0n9uiJN3AeeINnvKcTAAcM6f4wQN5LgJlZrIbFKJavnP4St
 HCKhNtjRO5UVNsaF0s+6oGP3Q4gJF9WkJXzkiIjl/cIc4wDki4h/oMDJa9PdrfbRaaDyIYPIk
 hy+/Pik2/AWVa8+Ol
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Allow users to append non-tracked files.  This simplifies the generation
of source packages with a few extra files, e.g. containing version
information.  They get the same access times and user information as
tracked files.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 Documentation/git-archive.txt |  6 +++
 archive.c                     | 86 ++++++++++++++++++++++++++++++++++-
 archive.h                     |  2 +
 t/t5000-tar-tree.sh           | 29 ++++++++++++
 t/t5003-archive-zip.sh        | 28 ++++++++++++
 5 files changed, 150 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.txt
index cfa1e4ebe4..9f8172828d 100644
=2D-- a/Documentation/git-archive.txt
+++ b/Documentation/git-archive.txt
@@ -55,6 +55,12 @@ OPTIONS
 --output=3D<file>::
 	Write the archive to <file> instead of stdout.

+--add-file=3D<file>::
+	Add a non-tracked file to the archive.  Can be repeated to add
+	multiple files.  The path of the file in the archive is built
+	by concatenating the value for `--prefix` (if any) and the
+	basename of <file>.
+
 --worktree-attributes::
 	Look for attributes in .gitattributes files in the working tree
 	as well (see <<ATTRIBUTES>>).
diff --git a/archive.c b/archive.c
index 4fbe5329c5..3c1541af9e 100644
=2D-- a/archive.c
+++ b/archive.c
@@ -266,6 +266,11 @@ static int queue_or_write_archive_entry(const struct =
object_id *oid,
 				   stage, context);
 }

+struct extra_file_info {
+	char *base;
+	struct stat stat;
+};
+
 int write_archive_entries(struct archiver_args *args,
 		write_archive_entry_fn_t write_entry)
 {
@@ -273,6 +278,10 @@ int write_archive_entries(struct archiver_args *args,
 	struct unpack_trees_options opts;
 	struct tree_desc t;
 	int err;
+	struct strbuf path_in_archive =3D STRBUF_INIT;
+	struct strbuf content =3D STRBUF_INIT;
+	struct object_id fake_oid =3D null_oid;
+	int i;

 	if (args->baselen > 0 && args->base[args->baselen - 1] =3D=3D '/') {
 		size_t len =3D args->baselen;
@@ -318,6 +327,33 @@ int write_archive_entries(struct archiver_args *args,
 		free(context.bottom);
 		context.bottom =3D next;
 	}
+
+	for (i =3D 0; i < args->extra_files.nr; i++) {
+		struct string_list_item *item =3D args->extra_files.items + i;
+		char *path =3D item->string;
+		struct extra_file_info *info =3D item->util;
+
+		put_be64(fake_oid.hash, i + 1);
+
+		strbuf_reset(&path_in_archive);
+		if (info->base)
+			strbuf_addstr(&path_in_archive, info->base);
+		strbuf_addstr(&path_in_archive, basename(path));
+
+		strbuf_reset(&content);
+		if (strbuf_read_file(&content, path, info->stat.st_size) < 0)
+			err =3D error_errno(_("could not read '%s'"), path);
+		else
+			err =3D write_entry(args, &fake_oid, path_in_archive.buf,
+					  path_in_archive.len,
+					  info->stat.st_mode,
+					  content.buf, content.len);
+		if (err)
+			break;
+	}
+	strbuf_release(&path_in_archive);
+	strbuf_release(&content);
+
 	return err;
 }

@@ -457,6 +493,42 @@ static void parse_treeish_arg(const char **argv,
 	ar_args->time =3D archive_time;
 }

+static void extra_file_info_clear(void *util, const char *str)
+{
+	struct extra_file_info *info =3D util;
+	free(info->base);
+	free(info);
+}
+
+static int add_file_cb(const struct option *opt, const char *arg, int uns=
et)
+{
+	struct archiver_args *args =3D opt->value;
+	const char **basep =3D (const char **)opt->defval;
+	const char *base =3D *basep;
+	char *path;
+	struct string_list_item *item;
+	struct extra_file_info *info;
+
+	if (unset) {
+		string_list_clear_func(&args->extra_files,
+				       extra_file_info_clear);
+		return 0;
+	}
+
+	if (!arg)
+		return -1;
+
+	path =3D prefix_filename(args->prefix, arg);
+	item =3D string_list_append_nodup(&args->extra_files, path);
+	item->util =3D info =3D xmalloc(sizeof(*info));
+	info->base =3D xstrdup_or_null(base);
+	if (stat(path, &info->stat))
+		die(_("File not found: %s"), path);
+	if (!S_ISREG(info->stat.st_mode))
+		die(_("Not a regular file: %s"), path);
+	return 0;
+}
+
 #define OPT__COMPR(s, v, h, p) \
 	OPT_SET_INT_F(s, NULL, v, h, p, PARSE_OPT_NONEG)
 #define OPT__COMPR_HIDDEN(s, v, p) \
@@ -481,6 +553,9 @@ static int parse_archive_args(int argc, const char **a=
rgv,
 		OPT_STRING(0, "format", &format, N_("fmt"), N_("archive format")),
 		OPT_STRING(0, "prefix", &base, N_("prefix"),
 			N_("prepend prefix to each pathname in the archive")),
+		{ OPTION_CALLBACK, 0, "add-file", args, N_("file"),
+		  N_("add untracked file to archive"), 0, add_file_cb,
+		  (intptr_t)&base },
 		OPT_STRING('o', "output", &output, N_("file"),
 			N_("write the archive to this file")),
 		OPT_BOOL(0, "worktree-attributes", &worktree_attributes,
@@ -515,6 +590,8 @@ static int parse_archive_args(int argc, const char **a=
rgv,
 		die(_("Option --exec can only be used together with --remote"));
 	if (output)
 		die(_("Unexpected option --output"));
+	if (is_remote && args->extra_files.nr)
+		die(_("Options --add-file and --remote cannot be used together"));

 	if (!base)
 		base =3D "";
@@ -561,11 +638,14 @@ int write_archive(int argc, const char **argv, const=
 char *prefix,
 {
 	const struct archiver *ar =3D NULL;
 	struct archiver_args args;
+	int rc;

 	git_config_get_bool("uploadarchive.allowunreachable", &remote_allow_unre=
achable);
 	git_config(git_default_config, NULL);

 	args.repo =3D repo;
+	args.prefix =3D prefix;
+	string_list_init(&args.extra_files, 1);
 	argc =3D parse_archive_args(argc, argv, &ar, &args, name_hint, remote);
 	if (!startup_info->have_repository) {
 		/*
@@ -579,7 +659,11 @@ int write_archive(int argc, const char **argv, const =
char *prefix,
 	parse_treeish_arg(argv, &args, prefix, remote);
 	parse_pathspec_arg(argv + 1, &args);

-	return ar->write_archive(ar, &args);
+	rc =3D ar->write_archive(ar, &args);
+
+	string_list_clear_func(&args.extra_files, extra_file_info_clear);
+
+	return rc;
 }

 static int match_extension(const char *filename, const char *ext)
diff --git a/archive.h b/archive.h
index d83b41a01f..82b226011a 100644
=2D-- a/archive.h
+++ b/archive.h
@@ -9,6 +9,7 @@ struct repository;
 struct archiver_args {
 	struct repository *repo;
 	const char *refname;
+	const char *prefix;
 	const char *base;
 	size_t baselen;
 	struct tree *tree;
@@ -20,6 +21,7 @@ struct archiver_args {
 	unsigned int worktree_attributes : 1;
 	unsigned int convert : 1;
 	int compression_level;
+	struct string_list extra_files;
 };

 /* main api */
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 37655a237c..3ebb0d3b65 100755
=2D-- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -94,6 +94,16 @@ check_tar() {
 	'
 }

+check_added() {
+	dir=3D$1
+	path_in_fs=3D$2
+	path_in_archive=3D$3
+
+	test_expect_success " validate extra file $path_in_archive" '
+		diff -r $path_in_fs $dir/$path_in_archive
+	'
+}
+
 test_expect_success 'setup' '
 	test_oid_cache <<-EOF
 	obj sha1:19f9c8273ec45a8938e6999cb59b3ff66739902a
@@ -164,6 +174,25 @@ test_expect_success 'git-archive --prefix=3Dolde-' '

 check_tar with_olde-prefix olde-

+test_expect_success 'git archive --add-file' '
+	echo untracked >untracked &&
+	git archive --add-file=3Duntracked HEAD >with_untracked.tar
+'
+
+check_tar with_untracked
+check_added with_untracked untracked untracked
+
+test_expect_success 'git archive --add-file twice' '
+	echo untracked >untracked &&
+	git archive --prefix=3Done/ --add-file=3Duntracked \
+		--prefix=3Dtwo/ --add-file=3Duntracked \
+		--prefix=3D HEAD >with_untracked2.tar
+'
+
+check_tar with_untracked2
+check_added with_untracked2 untracked one/untracked
+check_added with_untracked2 untracked two/untracked
+
 test_expect_success 'git archive on large files' '
     test_config core.bigfilethreshold 1 &&
     git archive HEAD >b3.tar &&
diff --git a/t/t5003-archive-zip.sh b/t/t5003-archive-zip.sh
index 3b76d2eb65..1e6d18b140 100755
=2D-- a/t/t5003-archive-zip.sh
+++ b/t/t5003-archive-zip.sh
@@ -72,6 +72,16 @@ check_zip() {
 	"
 }

+check_added() {
+	dir=3D$1
+	path_in_fs=3D$2
+	path_in_archive=3D$3
+
+	test_expect_success UNZIP " validate extra file $path_in_archive" '
+		diff -r $path_in_fs $dir/$path_in_archive
+	'
+}
+
 test_expect_success \
     'populate workdir' \
     'mkdir a &&
@@ -188,4 +198,22 @@ test_expect_success 'git archive --format=3Dzip on la=
rge files' '

 check_zip large-compressed

+test_expect_success 'git archive --format=3Dzip --add-file' '
+	echo untracked >untracked &&
+	git archive --format=3Dzip --add-file=3Duntracked HEAD >with_untracked.z=
ip
+'
+
+check_zip with_untracked
+check_added with_untracked untracked untracked
+
+test_expect_success 'git archive --format=3Dzip --add-file twice' '
+	echo untracked >untracked &&
+	git archive --format=3Dzip --prefix=3Done/ --add-file=3Duntracked \
+		--prefix=3Dtwo/ --add-file=3Duntracked \
+		--prefix=3D HEAD >with_untracked2.zip
+'
+check_zip with_untracked2
+check_added with_untracked2 untracked one/untracked
+check_added with_untracked2 untracked two/untracked
+
 test_done
=2D-
2.28.0

