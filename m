Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09859C64EC4
	for <git@archiver.kernel.org>; Mon,  6 Mar 2023 21:32:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbjCFVcf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Mar 2023 16:32:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjCFVc1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2023 16:32:27 -0500
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FACC2313A
        for <git@vger.kernel.org>; Mon,  6 Mar 2023 13:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1678138327; i=l.s.r@web.de;
        bh=DRTZDcXO+oVVVaQphRt0jJEGOEVH4aUNRpS0ajYAiO8=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=t3aFOoEEjEc40Of3K5/kBnl7H+deTZVbYc424FrMCnk5dC6Yra58D3b5hu1lQ66c3
         uxLpzGw7J3VrzW6aur8kdncCLuN6eutXEzBmD3da7lZr6O4FXrXeuF5YFjeYu8J3o8
         6SiK45XZK8Lqx9ssxRWSk44cCuKjy4CtZekupcVpCVvyjNolZHHVXlhGelRR1CEx6/
         8I5EljmHBslv0+8srdau9mEE/u6Kf6UbT8pL+lwXMK5RzdOzN8KEPFmi1zhgm4sVVz
         IY9Uy+5j2nMhVKSukvOPeVPZbvxZ1Rzt+MPrlrbqvy+KLdsfqh840fS6OK18DgVFro
         4G3nvc1CEo6yw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.29.151]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MvKXV-1qQR1S1Kd7-00qynA; Mon, 06
 Mar 2023 22:32:07 +0100
Message-ID: <3da35216-ca42-9759-d4f9-20451a44c231@web.de>
Date:   Mon, 6 Mar 2023 22:32:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: Bug in git archive + .gitattributes + relative path
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Cristian Le <cristian.le@mpsd.mpg.de>, git@vger.kernel.org,
        =?UTF-8?Q?Matthias_G=c3=b6rgens?= <matthias.goergens@gmail.com>
References: <42f13cda-9de6-bfc6-7e81-64c94f5640db@mpsd.mpg.de>
 <c7b21faa-68dd-8bd9-4670-2cf609741094@web.de>
 <8d04019d-511f-0f99-42cc-d0b25720cd71@mpsd.mpg.de>
 <70f10864-2cc7-cb9e-f868-2ac0011cad58@web.de> <xmqqcz5lbxiq.fsf@gitster.g>
 <d16c6a22-05d8-182c-97b4-53263d22eaa6@web.de> <xmqqo7p59049.fsf@gitster.g>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqo7p59049.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1K6qeGfrhsBCqqo0uA/124bLJtuSulidHb3SWou+NEkkuoJpbHA
 NRVKyeTvF+1NeS81tOHA45SrrIQfkmxonl32zGkioDV9+tXDpD0x9a4x2Cv/tPMTwLPsBOG
 XsOZHVwWLYL3Tso9U/3BmWRkzf2zelO8Cnc6E6jQFjWQfIM7pSydnZ39cQgbUcPpMH67Luj
 kSFa7LRtlCUNSkdHCUuyQ==
UI-OutboundReport: notjunk:1;M01:P0:O1nfWm5hh1c=;Zc52N0yJXXRxaG1XqCs9DHzLZRB
 6QLkZXh9DdLpNzekNDhR4cwm0BoiOLquDm9XqWGs8NMrXoQWLRxblWXY150hklu7zLVQlXdZ8
 4597aHKyW5Ohw4w7FTGdM4qtx7t5lh14M9rainecCUBPGRPiGlRGkv72kJYYETgAZfMzLQwb3
 OEUDb5Z8ea+zqwoj9XLNwXjz6QQqVtThgTfeCBYrdsCOnVbNHaYCvLsylg9vw3tc3plkQV7xF
 5J0D9+WDkujVq1hxnKY1SdLj+GI0XiMFpPZYi0eU2AgmHyfyHwKLQcBIeweB0t62I7VqKBXsN
 k7ipVzz2B3KvT+CO3zs+8liFKYHgCh0aG9d1xuLuF15+7lCjFBTyU7zJhUZ6sp2MRT5jwyS9i
 n+xT7QF2tuW6YJnK5nUE86hcjW/XJYTraavDKy1KU6Bir6bXJtxeOfUfC3AXZemzOkSlE4ADQ
 j3kHL1H6NK2d85OIdp2/unPYzbWaMtGAzycp2keAwd8E20nGJWBjPoemQkNjzoToSwHuJruI6
 Pf4iBXQpR0/62EkzYQbLnKTrcUIX5kY3wXPMgu1l7t+nC/8+e7lhexy9aqcSSDrDxfjxJ+X4j
 NGlb4HkH+tgVAoaxdH3T/J9omhShf2GrlcRvf6GdTfJ+WzBnj/WcmJivx8J0l9b3c+w3TJq0k
 30ADlwiYUmqXuAG/z8FRru5t+PdwmLX2n7mAcv+ek4THidjHxhgcVdEoc3TZVhi87cN+tk3ID
 QhbnJXheRGuytdea/Pe8xK2KJLDh6KAC0su6eWyCjx3/PVAz1ObzLDEa5RKaUzhCTKGZhLyct
 TttGlGv/fikos1R1grnPCudFKHZZDuxAyjZqufDz+cTOEPcultsGCi5HGLw4pbMDVSMh7InUf
 6gkPw+rE115h/b4LncfqZGFlpW3KBvbeIGwUUstzIFU6svEWBDNnRVChvpx7e4rw5jVVaIWEk
 SAlnfJNQjVyfPwb7FyBp2oRdJj8=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 06.03.23 um 19:59 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
> It somehow feels that the use of pathspec in "git archive" is
> somewhat iffy, e.g.
>
>    $ cd sha1dc && git archive HEAD :/ | tar tf -
>
> does not compare very well with
>
>    $ cd sha1dc && git ls-tree -r HEAD :/
>
> For that matter, replacing ":/" (full tree) with ".." (we know one
> level above is the root of the working tree) has the same "why don't
> they work the same way???" confusion.

Right,
https://lore.kernel.org/git/CA+X7ob8DWGmoVTxSVvrFN68V=3DpcaZripfP=3Ds+LpWv=
XN-6L7W7Q@mail.gmail.com/
reports the second one as well.

It's a consequence of effectively cd'ing into the prefix tree in
archive.c::parse_treeish_arg() and using the empty string as prefix from
then on.  If we stop doing that then we're getting much closer (path at
the end):

   $ git -C xdiff ls-files '../sha1dc/*.c' '../xdiff/*.c'
   ../sha1dc/sha1.c
   ../sha1dc/ubc_check.c
   xdiffi.c
   xemit.c
   xhistogram.c
   xmerge.c
   xpatience.c
   xprepare.c
   xutils.c


   $ git -C xdiff archive HEAD '../sha1dc/*.c' '../xdiff/*.c' | tar tf -
   ../sha1dc/
   ../sha1dc/sha1.c
   ../sha1dc/ubc_check.c
   xdiffi.c
   xemit.c
   xhistogram.c
   xmerge.c
   xpatience.c
   xprepare.c
   xutils.c

Not sure if we want those leading double dots.  bsdtar has them:

   $ (cd xdiff && tar cf - ../sha1dc/*.c ../xdiff/*.c) | tar tf -
   ../sha1dc/sha1.c
   ../sha1dc/ubc_check.c
   ../xdiff/xdiffi.c
   ../xdiff/xemit.c
   ../xdiff/xhistogram.c
   ../xdiff/xmerge.c
   ../xdiff/xpatience.c
   ../xdiff/xprepare.c
   ../xdiff/xutils.c

... but GNU tar strips them off and warns about them:

   $ (cd xdiff && gtar cf - ../sha1dc/*.c ../xdiff/*.c) | tar tf -
   gtar: Removing leading `../' from member names
   gtar: Removing leading `../' from hard link targets
   sha1dc/sha1.c
   sha1dc/ubc_check.c
   xdiff/xdiffi.c
   xdiff/xemit.c
   xdiff/xhistogram.c
   xdiff/xmerge.c
   xdiff/xpatience.c
   xdiff/xprepare.c
   xdiff/xutils.c

Neither of them resolves "../$PWD/" parts to "" like git ls-tree does,
but I can accept that difference.  And then we'd need to keep leading
"../", I suppose.  Still unsure.

And I don't know why PATHSPEC_PREFER_CWD is necessary.

So no sign-off, yet.


 archive.c | 60 +++++++++++++++++++++++++++++++++++-----------------------=
--
 1 file changed, 35 insertions(+), 25 deletions(-)

diff --git a/archive.c b/archive.c
index 9aeaf2bd87..c7e9f58b02 100644
=2D-- a/archive.c
+++ b/archive.c
@@ -139,6 +139,7 @@ static int write_archive_entry(const struct object_id =
*oid, const char *base,
 		void *context)
 {
 	static struct strbuf path =3D STRBUF_INIT;
+	static struct strbuf scratch =3D STRBUF_INIT;
 	struct archiver_context *c =3D context;
 	struct archiver_args *args =3D c->args;
 	write_archive_entry_fn_t write_entry =3D c->write_entry;
@@ -148,6 +149,14 @@ static int write_archive_entry(const struct object_id=
 *oid, const char *base,
 	void *buffer;
 	enum object_type type;

+	/*
+	 * NEEDSWORK: variable names could be clearer:
+	 * - args->prefix is the current working directory,
+	 * - args->base with args->baselen is the --prefix value,
+	 * - base with baselen is the path of the current tree,
+	 * - args->base + base + filename is the path in the archive,
+	 * - path_without_prefix is base + filename.
+	 */
 	args->convert =3D 0;
 	strbuf_reset(&path);
 	strbuf_grow(&path, PATH_MAX);
@@ -166,6 +175,15 @@ static int write_archive_entry(const struct object_id=
 *oid, const char *base,
 		args->convert =3D check_attr_export_subst(check);
 	}

+	if (args->prefix) {
+		const char *rel =3D relative_path(path_without_prefix,
+						args->prefix, &scratch);
+		if (!strcmp(rel, "./"))
+			return S_ISDIR(mode) ? READ_TREE_RECURSIVE : 0;
+		strbuf_setlen(&path, args->baselen);
+		strbuf_addstr(&path, rel);
+	}
+
 	if (args->verbose)
 		fprintf(stderr, "%.*s\n", (int)path.len, path.buf);

@@ -401,14 +419,15 @@ static int reject_entry(const struct object_id *oid =
UNUSED,
 	return ret;
 }

-static int path_exists(struct archiver_args *args, const char *path)
+static int path_exists(struct archiver_args *args, const char *prefix,
+		       const char *path)
 {
 	const char *paths[] =3D { path, NULL };
 	struct path_exists_context ctx;
 	int ret;

 	ctx.args =3D args;
-	parse_pathspec(&ctx.pathspec, 0, 0, "", paths);
+	parse_pathspec(&ctx.pathspec, 0, 0, prefix, paths);
 	ctx.pathspec.recursive =3D 1;
 	ret =3D read_tree(args->repo, args->tree,
 			&ctx.pathspec,
@@ -417,30 +436,35 @@ static int path_exists(struct archiver_args *args, c=
onst char *path)
 	return ret !=3D 0;
 }

-static void parse_pathspec_arg(const char **pathspec,
+static void parse_pathspec_arg(const char **pathspec, const char *prefix,
 		struct archiver_args *ar_args)
 {
+	const char *match_all[] =3D { ".", NULL };
+
+	if (prefix && !*pathspec)
+		pathspec =3D match_all;
+
 	/*
 	 * must be consistent with parse_pathspec in path_exists()
 	 * Also if pathspec patterns are dependent, we're in big
 	 * trouble as we test each one separately
 	 */
 	parse_pathspec(&ar_args->pathspec, 0,
-		       PATHSPEC_PREFER_FULL,
-		       "", pathspec);
+		       PATHSPEC_PREFER_CWD,
+		       prefix, pathspec);
 	ar_args->pathspec.recursive =3D 1;
 	if (pathspec) {
 		while (*pathspec) {
-			if (**pathspec && !path_exists(ar_args, *pathspec))
+			if (**pathspec &&
+			    !path_exists(ar_args, prefix, *pathspec))
 				die(_("pathspec '%s' did not match any files"), *pathspec);
 			pathspec++;
 		}
 	}
 }

-static void parse_treeish_arg(const char **argv,
-		struct archiver_args *ar_args, const char *prefix,
-		int remote)
+static void parse_treeish_arg(const char **argv, struct archiver_args *ar=
_args,
+			      int remote)
 {
 	const char *name =3D argv[0];
 	const struct object_id *commit_oid;
@@ -479,20 +503,6 @@ static void parse_treeish_arg(const char **argv,
 	if (!tree)
 		die(_("not a tree object: %s"), oid_to_hex(&oid));

-	if (prefix) {
-		struct object_id tree_oid;
-		unsigned short mode;
-		int err;
-
-		err =3D get_tree_entry(ar_args->repo,
-				     &tree->object.oid,
-				     prefix, &tree_oid,
-				     &mode);
-		if (err || !S_ISDIR(mode))
-			die(_("current working directory is untracked"));
-
-		tree =3D parse_tree_indirect(&tree_oid);
-	}
 	ar_args->refname =3D ref;
 	ar_args->tree =3D tree;
 	ar_args->commit_oid =3D commit_oid;
@@ -710,8 +720,8 @@ int write_archive(int argc, const char **argv, const c=
har *prefix,
 		setup_git_directory();
 	}

-	parse_treeish_arg(argv, &args, prefix, remote);
-	parse_pathspec_arg(argv + 1, &args);
+	parse_treeish_arg(argv, &args, remote);
+	parse_pathspec_arg(argv + 1, prefix, &args);

 	rc =3D ar->write_archive(ar, &args);


