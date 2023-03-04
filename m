Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83589C678DB
	for <git@archiver.kernel.org>; Sat,  4 Mar 2023 13:58:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbjCDN6t (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Mar 2023 08:58:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjCDN6s (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Mar 2023 08:58:48 -0500
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12DEA13DD9
        for <git@vger.kernel.org>; Sat,  4 Mar 2023 05:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1677938321; i=l.s.r@web.de;
        bh=poa10+5gN72zBoxYL67R5tmBaGjAbzrzdvD5J3ru8TI=;
        h=X-UI-Sender-Class:Date:From:Subject:To:References:In-Reply-To;
        b=sHg39YshyNmw8k9U2XRocB5UbTfkQ5p8tkzvvERdPLHrIuQjwPH5WztZmAvvLKcuq
         9C5H/Gf47aFrJjnKnpFUok8CGP5FzxK2aGl2QUW3geYYI7MvAG6aCRYEhE8fZBHP+U
         LMtWXjwS/nP3Et0KNW54ZCg9/miSEVMZ50K2VYYD4hMt+VcFQoVkWTiZXlYFB5kCxF
         TBeBdd4xdWmw6pV8SQcZAEZ/9/oW1JDm760+YGLLOO1/8bEOa14ktsIe9yrclsVjwn
         ctmjM7avveZzQ/hV88pUjA/G/69AG9ps+cNgAcYkxpU1AxjtLO9nDvnJzp0LENiHac
         9cKE3Q6HYVHTA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.21.51]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MjgXH-1qHzVi0Lkp-00lFPQ; Sat, 04
 Mar 2023 14:58:41 +0100
Message-ID: <70f10864-2cc7-cb9e-f868-2ac0011cad58@web.de>
Date:   Sat, 4 Mar 2023 14:58:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: Re: Bug in git archive + .gitattributes + relative path
To:     Cristian Le <cristian.le@mpsd.mpg.de>, git@vger.kernel.org
References: <42f13cda-9de6-bfc6-7e81-64c94f5640db@mpsd.mpg.de>
 <c7b21faa-68dd-8bd9-4670-2cf609741094@web.de>
 <8d04019d-511f-0f99-42cc-d0b25720cd71@mpsd.mpg.de>
Content-Language: en-US
In-Reply-To: <8d04019d-511f-0f99-42cc-d0b25720cd71@mpsd.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6Argg0SWGV1tRvVKVmBQvIOlRZUDwMMXBIkCr+JlCG07CWxK1xp
 5iv9+H4wu0tEVCIIj/3lG05AHbZLz5uiM6b8l1ZCzYkBGC2kq+MeoHu0lZOyWDjfTjEu+wn
 hLLV7GMrfDQR6ngrVyLA0lfSKh71WVFO2t7S+0NX60BYF+EvCch+rzgwGi8wP37mjniCeAz
 JZ32NfNJCIG2hAqLFi9uA==
UI-OutboundReport: notjunk:1;M01:P0:pc7OXPuEWGQ=;xqHcw4gkgkkg1Jj3gnyQSj2Dg3f
 KX6vJIHKTjVVV/MRVIi5rGNJMpr1sJtsjiNf89xf12slT0fejPXO6pXoUGO8idzzjAcnYbs9q
 Pk68TpYViLCvR5InjIBSt4jm2+N12XngI696ceyHwWBfDszqrMSX7iDYDQKC+/Dt3eZFpILqd
 dF58swyZo2EbMDS4HSExSElCt36BG1v4mJOF0SOHsc7kx2r9azGdrc1ri8WWHy9HexIgKbH5B
 9IlyrnXRWPuudoBQ7ZbFKaw3y3L9o50sFiQ7DZx7o0WsqeYdem71aOThjZp66o8FCqG8FXTaL
 3O3qjpGAW4lwFDAwFEzDT8YFI5fMvKGuYJjutmfAF+MEhsJwUKTrSKBsTpoW2/D934YQe/IYR
 RJtgZJG+D3GHtvI6fULOLk+hkrbChssCtAAghEUXeqJhPyqvueqOM2DpQXbMprXAKruHbgiLl
 3PYkz47GAy3bqxFFgwJUbY2gCYkVtjWsqFJkzIg6S1wLxoLrfmJENFaynihEb4LZxL0/eirgx
 zYQC5SYgx1bOJgYijnd3KFq0WBPPimk7HQ7B/nY+ousIqhIoZrRTgaPDWXtFqDsXyCWXXnXxD
 U8wLGgWaJ6ftsQmo6o4lrXeckdH1C5u35xmpqF3TYhtimr/mUeI7kYFsAseh9g2/AjDrqqT/n
 JL2v2RaJmiuamVYvezcZAfKRq6OUByp0az2b1n0QPeTguZNF6oj0eDTR7D3bqiK0gpizYzuWx
 BnG+paHyqnYHMCjOuGpNPgkibbc4lHk25E+ArCz0IhLX47DuhdHowcm+X92uuUS3mS3NoSzoq
 s3G8/cQLyEmTmlRPTF6d/1/X5uu6EA9r0mJBBLKYdO9+QQ6jZOEd2/ktPF03LW196jtfGb12J
 EKKDCtZOp+QgJNOZQNNkjfA0Rg+wdrXJVxHHqGruAlPQZyC5lHoVm2IrTh72gfQmu6ZmQxsS3
 EfEWJw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 03.03.23 um 16:38 schrieb Cristian Le:
>> In your issue #444 you write that "git archive HEAD" works, but
>> "git archive HEAD:./" doesn't. Why do you need to use the latter?
>
> Specifically we want to allow for `HEAD:./sub_dir` where `./sub_dir`
> contains `.gitattributes` and `.git_archive.txt`.
>
> Alternatively, it would be helpful if we can pass `--transform`
> commands of `tar` directly so that we can change the paths.
>
> Overall what we are doing in tito is that the source would be in
> `./src` and outside is metadata like `./my_package.spec`. We are
> using `git archive HEAD:./src --prefix=3Dmy_package-1.0.0` to pass the
> appropriate form that the rpm spec file can locate. In a tar command
> we can use `--transform=3Ds|^src/|my_package-1.0.0/|` to achieve the
> equivalent.

What is Tito?  https://github.com/rpm-software-management/tito says:
"Tito is a tool for managing RPM based projects using git for their
source code repository."  It supports Git repositories containing
multiple projects.  I suppose that means e.g. for Git's own repo that
Tito would allow creating a separate RPM file for e.g. git-gui.

Side note: Tito features include: "Create reliable tar.gz files with
consistent checksums from any tag."  That's achieved by compressing
using "gzip -n -c".  Avoiding the native tgz support of git archive --
probably only because the code predates it -- shields Tito from the
change to use our internal gzip implementation discussed recently in
https://lore.kernel.org/git/a812a664-67ea-c0ba-599f-cb79e2d96694@gmail.com=
/

Note, however, that the tar output of git archive is not guaranteed to
be stable between Git versions, either.  Recently adding such a stable
format was proposed in
https://lore.kernel.org/git/20230205221728.4179674-1-sandals@crustytoothpa=
ste.net/

The code for calling git archive with a tree was present in Tito's
initial commit, which says that it was taken from Spacewalk:
https://github.com/rpm-software-management/tito/commit/e87345d7b7.
There it was introduced along with a script that changes the mtime
of archive entries from the current time to the commit timestamp by
https://github.com/spacewalkproject/spacewalk/commit/34267e39d472.

I don't fully understand the explanation in its commit message
("make it possible to call make srpm even if the directory of the
package has changed"); perhaps it requires more domain knowledge.
But I can understand the need for archiving sub-directories in the
context of supporting multi-project repositories.

> However we cannot use the `tar` directly because that would affect
> the timestamps and permissions of the file that are set by `git
> archive`.

GNU tar has the options --mode and --mtime to chose permissions and
modifications of files added to an archive.

git archive is going to get an --mtime option as well in the next
release, by the way.

> So allowing for something like `git archive HEAD
> --transform=3Ds|^src/|my_package-1.0.0/|`, where the transform is done
> after `.gitattributes` is performed would solve this issue.

GNU tar has this --transform option, bsdtar similarly has -s.  Both
also have --strip-components (GNU tar only for extraction, though),
which is a bit simpler and should suffice for your use case.

=2D-- >8 ---
Subject: [PATCH] archive: add --strip-components

Allow removing leading elements from paths of archive entries.  That's
useful when archiving sub-directories and not wanting to keep the
common path prefix, e.g.:

   $ git archive --strip-components=3D1 HEAD sha1dc | tar tf -
   .gitattributes
   LICENSE.txt
   sha1.c
   sha1.h
   ubc_check.c
   ubc_check.h

The same can be achieved by specifying a tree instead of a commit and
a pathspec:

   $ git archive HEAD:sha1dc | tar tf -
   .gitattributes
   LICENSE.txt
   sha1.c
   sha1.h
   ubc_check.c
   ubc_check.h

However, this doesn't support the export-subst attribute, doesn't
include the commit hash as an archive comment and uses the current time
instead of the commit date as mtime for archive entries.

The new option is adapted from bsdtar.  GNU tar provides it as well, but
only for extraction.

The new option does not affect the paths of entries added by --add-file
and --add-virtual-file because they are handcrafted to their desired
values already.  Similarly, the value of --prefix is not subject to
component stripping.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 Documentation/git-archive.txt |  6 ++++++
 archive.c                     | 16 ++++++++++++++++
 archive.h                     |  1 +
 t/t5000-tar-tree.sh           | 13 +++++++++++++
 4 files changed, 36 insertions(+)

diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.txt
index 6bab201d37..5dad917e7b 100644
=2D-- a/Documentation/git-archive.txt
+++ b/Documentation/git-archive.txt
@@ -55,6 +55,12 @@ OPTIONS
 	rightmost value is used for all tracked files.  See below which
 	value gets used by `--add-file` and `--add-virtual-file`.

+--strip-components=3D<n>::
+	Remove the specified number of leading path elements.  Pathnames
+	with fewer elements will be silently skipped.  Does not affect
+	the prefix added by `--prefix`, nor entries added with
+	`--add-file` or `--add-virtual-file`.
+
 -o <file>::
 --output=3D<file>::
 	Write the archive to <file> instead of stdout.
diff --git a/archive.c b/archive.c
index 9aeaf2bd87..8308d4d9c4 100644
=2D-- a/archive.c
+++ b/archive.c
@@ -166,6 +166,18 @@ static int write_archive_entry(const struct object_id=
 *oid, const char *base,
 		args->convert =3D check_attr_export_subst(check);
 	}

+	if (args->strip_components > 0) {
+		size_t orig_baselen =3D baselen;
+		for (int i =3D 0; i < args->strip_components; i++) {
+			const char *slash =3D memchr(base, '/', baselen);
+			if (!slash)
+				return S_ISDIR(mode) ? READ_TREE_RECURSIVE : 0;
+			baselen -=3D slash - base + 1;
+			base =3D slash + 1;
+		}
+		strbuf_remove(&path, args->baselen, orig_baselen - baselen);
+	}
+
 	if (args->verbose)
 		fprintf(stderr, "%.*s\n", (int)path.len, path.buf);

@@ -593,12 +605,15 @@ static int parse_archive_args(int argc, const char *=
*argv,
 	int verbose =3D 0;
 	int i;
 	int list =3D 0;
+	int strip_components =3D 0;
 	int worktree_attributes =3D 0;
 	struct option opts[] =3D {
 		OPT_GROUP(""),
 		OPT_STRING(0, "format", &format, N_("fmt"), N_("archive format")),
 		OPT_STRING(0, "prefix", &base, N_("prefix"),
 			N_("prepend prefix to each pathname in the archive")),
+		OPT_INTEGER(0, "strip-components", &strip_components,
+			N_("remove leading path elements")),
 		{ OPTION_CALLBACK, 0, "add-file", args, N_("file"),
 		  N_("add untracked file to archive"), 0, add_file_cb,
 		  (intptr_t)&base },
@@ -675,6 +690,7 @@ static int parse_archive_args(int argc, const char **a=
rgv,
 	args->baselen =3D strlen(base);
 	args->worktree_attributes =3D worktree_attributes;
 	args->mtime_option =3D mtime_option;
+	args->strip_components =3D strip_components;

 	return argc;
 }
diff --git a/archive.h b/archive.h
index 7178e2a9a2..e9becbd57d 100644
=2D-- a/archive.h
+++ b/archive.h
@@ -23,6 +23,7 @@ struct archiver_args {
 	unsigned int worktree_attributes : 1;
 	unsigned int convert : 1;
 	int compression_level;
+	int strip_components;
 	struct string_list extra_files;
 	struct pretty_print_context *pretty_ctx;
 };
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 918a2fc7c6..629d2e78d7 100755
=2D-- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -271,6 +271,19 @@ test_expect_success 'git get-tar-commit-id' '
 	test_cmp expect actual
 '

+test_expect_success 'git archive --strip-components' '
+	git archive --strip-components=3D3 HEAD >strip3.tar &&
+	(
+		mkdir strip3 &&
+		cd strip3 &&
+		"$TAR" xf ../strip3.tar &&
+		find . | grep -v "^\.\$" | sort >../strip3.lst
+	) &&
+	sed -ne "s-\([^/]*/\)\{3\}-./-p" a.lst >expect &&
+	test_cmp expect strip3.lst &&
+	diff -r a/long_path_to_a_file/long_path_to_a_file strip3
+'
+
 test_expect_success 'git archive with --output, override inferred format'=
 '
 	git archive --format=3Dtar --output=3Dd4.zip HEAD &&
 	test_cmp_bin b.tar d4.zip
=2D-
2.39.2
