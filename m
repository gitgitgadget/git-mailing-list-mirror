Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F602C433E0
	for <git@archiver.kernel.org>; Sun, 28 Feb 2021 11:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3ED5B64E07
	for <git@archiver.kernel.org>; Sun, 28 Feb 2021 11:25:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbhB1LY5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Feb 2021 06:24:57 -0500
Received: from mout.web.de ([212.227.15.14]:59661 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230045AbhB1LYz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Feb 2021 06:24:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1614511368;
        bh=EQL3rxTtFitMuuxhbfxDEsYRPZlNdSdwpgM2Lx2K3G4=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=psh8AI0w1ESaoqojrHX17ouQ48oDrWzP7MjmZdr5wblgf9lDwx7JmKAYVgtJgjdYf
         WzBv2rT9kmzDeuaJGG+3iyQb71JF0noObixJW3ISybLloLuAj2GCw+Ae97TBQ1I7pF
         8zWCTXntq4ZXAFha5zugT2uQ11KWm0zEmWatfqt4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.24.70]) by smtp.web.de
 (mrweb004 [213.165.67.108]) with ESMTPSA (Nemesis) id
 0Le8Ca-1lbIRw0CEe-00ppwM; Sun, 28 Feb 2021 12:22:48 +0100
Subject: Re: [PATCH 2/2] pretty: add merge and exclude options to %(describe)
To:     Jeff King <peff@peff.net>
Cc:     Eli Schwartz <eschwartz@archlinux.org>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
References: <7418f1d8-78c2-61a7-4f03-62360b986a41@archlinux.org>
 <5561d11b-08c3-bcf7-5d37-a7d6c6bfb715@web.de>
 <b7bd37c4-ab13-0297-da46-716e26de10d6@web.de>
 <YC1hHYeCmC6+heWZ@coredump.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe=2e?= <l.s.r@web.de>
Message-ID: <b7e1f6c0-6b13-efe4-74b5-ec8249855644@web.de>
Date:   Sun, 28 Feb 2021 12:22:47 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YC1hHYeCmC6+heWZ@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8b+BseGg1cwRqyDgp7yTcHhT2Ng9xDrm7yMqaSyox+yOHkFDBzS
 cwtJTy7ufLuZwlnArfRox4xji/gGFNaH7FqKwwLzKKnkv7TZZ2WlEnJlMQ7ItgL51B1u4OE
 RMahSzkcineYbgdQ8OHld2MV9zyB6wNrMCXMGPADvIcgouD9gRi4WzRTiD5oZErdRYHfprX
 Xg51X84c8GtURz5LLC/gA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:z6bxS5ZHKw8=:UEK7L39AqrnHTR7nUlSGTA
 +uzTvvfmoUXc/vQMIyuzDVtkS/Ou6EwrOlP1ybAJYwJ4AubpBjbu5oJPU6h/Up02gJprlHc/e
 /tzLp5n2rDx9WmIxpJBVv7ROekY71uJMsopUxnNofWYLQvMPJSOvyjoRNMs1eHKV5xajU3iVV
 4BeTMVRUboKIBmQh021X2pC6IVDjxmpS2IbGIchvhAzxWsWOoti5Vnnc1W1UYxCekuCuXdgSS
 y73/UG6+IyFKs+QpW1dSDjxQ64pkFlj46dxzIKJT1KVdZzje/7btDz+umlGuCEhlTTzg/FmK7
 NGtArbTE2KOd7pd2HyAkJpNsr6XT4r0s/BaQR4Qzb46IA+Y+7ZoFVD3x9MixtlviRspjOMzGr
 dtRxsJ3Ikkg2msZ6ckv9lT7UdksV7v71mB4x/boWztMGPn6HMiQ2EDajmPD9ispZXPy40mOa4
 gRw05swJxztgxNsm6QLveIyxvtHHO9570iEvtdNX/6Q/wAZSG06SMM9onsEstXChpM0b9uIdh
 lxzW/aOA+X4acoFdOYBJ09ld3bwR/O9HgaFbnvq1rXAQkttfhnfjOwwhaOQF07eeSk6Ayl7ui
 RF4ELR6N7lGu8WRBMVdsZmeAkFl9HgNphRdXZTSPXOxKsUQLGF9YITUgROvHosckRO0h7qM3o
 7G9bWI0x5Lkv+hqZWjzKmYMw70NTxtC7ctfIPRtD12JgmKxCrUq+6L+mneH/W8UNehx7CXr+8
 7fxmT3aanL+5wf810maZkpCFBxkiE9cfzdXz0X2X/9EiqZcOrfNaYCaIC54qbob1ku/QpRzkU
 teCWShJEVcgIz1SMOhJiAW88aGnrvK3+rd3Fi/kAKAeeScrVowpwVKQZ3pUttNjAVd616uU2b
 YpzjlJ7DyJiVY8emz0+g==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 17.02.21 um 19:31 schrieb Jeff King:
> On Sun, Feb 14, 2021 at 11:10:57AM +0100, Ren=C3=A9 Scharfe. wrote:
>
>> Allow restricting the tags used by the placeholder %(describe) with the
>> options match and exclude.  E.g. the following command describes the
>> current commit using official version tags, without those for release
>> candidates:
>>
>>    $ git log -1 --format=3D'%(describe:match=3Dv[0-9]*,exclude=3D*rc*)'
>
> An interesting side effect of this series is that it allows remote users
> asking for archives to fill in this data, too (by using export-subst
> placeholders). That includes servers allowing "git archive --remote",
> but also services like GitHub that will run git-archive on behalf of
> clients.
>
> I wonder what avenues for mischief this provides. Certainly using extra
> CPU to run git-describe.

A repository can contain millions of files, each file can contain
millions of $Format:...$ sequences and each of them can contain millions
of %(describe) placeholders.  Each of them could have different match or
exclude args to prevent caching.  Allowing a single request to cause
trillions of calls of git describe sounds excessive.  Let's limit this.

=2D- >8 --
Subject: [PATCH] archive: expand only a single %(describe) per archive

Every %(describe) placeholder in $Format:...$ strings in files with the
attribute export-subst is expanded by calling git describe.  This can
potentially result in a lot of such calls per archive.  That's OK for
local repositories under control of the user of git archive, but could
be a problem for hosted repositories.

Expand only a single %(describe) placeholder per archive for now to
avoid denial-of-service attacks.  We can make this limit configurable
later if needed, but let's start out simple.

Reported-by: Jeff King <peff@peff.net>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 Documentation/gitattributes.txt |  3 ++-
 archive.c                       | 16 ++++++++++------
 archive.h                       |  2 ++
 pretty.c                        |  8 ++++++++
 pretty.h                        |  5 +++++
 t/t5001-archive-attr.sh         | 14 ++++++++++++++
 6 files changed, 41 insertions(+), 7 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes=
.txt
index e84e104f93..0a60472bb5 100644
=2D-- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -1174,7 +1174,8 @@ tag then no replacement will be done.  The placehold=
ers are the same
 as those for the option `--pretty=3Dformat:` of linkgit:git-log[1],
 except that they need to be wrapped like this: `$Format:PLACEHOLDERS$`
 in the file.  E.g. the string `$Format:%H$` will be replaced by the
-commit hash.
+commit hash.  However, only one `%(describe)` placeholder is expanded
+per archive to avoid denial-of-service attacks.


 Packing objects
diff --git a/archive.c b/archive.c
index 5919d9e505..2dd2236ae0 100644
=2D-- a/archive.c
+++ b/archive.c
@@ -37,13 +37,10 @@ void init_archivers(void)

 static void format_subst(const struct commit *commit,
 			 const char *src, size_t len,
-			 struct strbuf *buf)
+			 struct strbuf *buf, struct pretty_print_context *ctx)
 {
 	char *to_free =3D NULL;
 	struct strbuf fmt =3D STRBUF_INIT;
-	struct pretty_print_context ctx =3D {0};
-	ctx.date_mode.type =3D DATE_NORMAL;
-	ctx.abbrev =3D DEFAULT_ABBREV;

 	if (src =3D=3D buf->buf)
 		to_free =3D strbuf_detach(buf, NULL);
@@ -61,7 +58,7 @@ static void format_subst(const struct commit *commit,
 		strbuf_add(&fmt, b + 8, c - b - 8);

 		strbuf_add(buf, src, b - src);
-		format_commit_message(commit, fmt.buf, buf, &ctx);
+		format_commit_message(commit, fmt.buf, buf, ctx);
 		len -=3D c + 1 - src;
 		src  =3D c + 1;
 	}
@@ -94,7 +91,7 @@ static void *object_file_to_archive(const struct archive=
r_args *args,
 		strbuf_attach(&buf, buffer, *sizep, *sizep + 1);
 		convert_to_working_tree(args->repo->index, path, buf.buf, buf.len, &buf=
, &meta);
 		if (commit)
-			format_subst(commit, buf.buf, buf.len, &buf);
+			format_subst(commit, buf.buf, buf.len, &buf, args->pretty_ctx);
 		buffer =3D strbuf_detach(&buf, &size);
 		*sizep =3D size;
 	}
@@ -633,12 +630,19 @@ int write_archive(int argc, const char **argv, const=
 char *prefix,
 		  const char *name_hint, int remote)
 {
 	const struct archiver *ar =3D NULL;
+	struct pretty_print_describe_status describe_status =3D {0};
+	struct pretty_print_context ctx =3D {0};
 	struct archiver_args args;
 	int rc;

 	git_config_get_bool("uploadarchive.allowunreachable", &remote_allow_unre=
achable);
 	git_config(git_default_config, NULL);

+	describe_status.max_invocations =3D 1;
+	ctx.date_mode.type =3D DATE_NORMAL;
+	ctx.abbrev =3D DEFAULT_ABBREV;
+	ctx.describe_status =3D &describe_status;
+	args.pretty_ctx =3D &ctx;
 	args.repo =3D repo;
 	args.prefix =3D prefix;
 	string_list_init(&args.extra_files, 1);
diff --git a/archive.h b/archive.h
index 33551b7ee1..49fab71aaf 100644
=2D-- a/archive.h
+++ b/archive.h
@@ -5,6 +5,7 @@
 #include "pathspec.h"

 struct repository;
+struct pretty_print_context;

 struct archiver_args {
 	struct repository *repo;
@@ -22,6 +23,7 @@ struct archiver_args {
 	unsigned int convert : 1;
 	int compression_level;
 	struct string_list extra_files;
+	struct pretty_print_context *pretty_ctx;
 };

 /* main api */
diff --git a/pretty.c b/pretty.c
index c612d2ac9b..032e89cd4e 100644
=2D-- a/pretty.c
+++ b/pretty.c
@@ -1247,6 +1247,14 @@ static size_t format_commit_one(struct strbuf *sb, =
/* in UTF-8 */
 		struct child_process cmd =3D CHILD_PROCESS_INIT;
 		struct strbuf out =3D STRBUF_INIT;
 		struct strbuf err =3D STRBUF_INIT;
+		struct pretty_print_describe_status *describe_status;
+
+		describe_status =3D c->pretty_ctx->describe_status;
+		if (describe_status) {
+			if (!describe_status->max_invocations)
+				return 0;
+			describe_status->max_invocations--;
+		}

 		cmd.git_cmd =3D 1;
 		strvec_push(&cmd.args, "describe");
diff --git a/pretty.h b/pretty.h
index 7ce6c0b437..27b15947ff 100644
=2D-- a/pretty.h
+++ b/pretty.h
@@ -23,6 +23,10 @@ enum cmit_fmt {
 	CMIT_FMT_UNSPECIFIED
 };

+struct pretty_print_describe_status {
+	unsigned int max_invocations;
+};
+
 struct pretty_print_context {
 	/*
 	 * Callers should tweak these to change the behavior of pp_* functions.
@@ -44,6 +48,7 @@ struct pretty_print_context {
 	int color;
 	struct ident_split *from_ident;
 	unsigned encode_email_headers:1;
+	struct pretty_print_describe_status *describe_status;

 	/*
 	 * Fields below here are manipulated internally by pp_* functions and
diff --git a/t/t5001-archive-attr.sh b/t/t5001-archive-attr.sh
index e9aa97117a..1c9ce3956b 100755
=2D-- a/t/t5001-archive-attr.sh
+++ b/t/t5001-archive-attr.sh
@@ -128,4 +128,18 @@ test_expect_success 'export-subst' '
 	test_cmp substfile2 archive/substfile2
 '

+test_expect_success 'export-subst expands %(describe) once' '
+	echo "\$Format:%(describe)\$" >substfile3 &&
+	echo "\$Format:%(describe)\$" >>substfile3 &&
+	echo "\$Format:%(describe)${LF}%(describe)\$" >substfile4 &&
+	git add substfile[34] &&
+	git commit -m export-subst-describe &&
+	git tag -m export-subst-describe export-subst-describe &&
+	git archive HEAD >archive-describe.tar &&
+	extract_tar_to_dir archive-describe &&
+	desc=3D$(git describe) &&
+	grep -F "$desc" archive-describe/substfile[34] >substituted &&
+	test_line_count =3D 1 substituted
+'
+
 test_done
=2D-
2.30.1
