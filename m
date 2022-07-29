Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF96C00144
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 07:22:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234601AbiG2HWf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 03:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234103AbiG2HWd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 03:22:33 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF43167D0
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 00:22:31 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id rq15so1027432ejc.10
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 00:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc;
        bh=lZTGS1hl4QonGC0u03Eh00M29IunEojuiM+Qpvqy/Nc=;
        b=nkLfWquWFwFKrFOLDOzGWoPQ7I6bBYcAO3UEYnrVbZ+1t1y+mct8lsJOUGbTUJr2/g
         A3pNgVmN6knYV/7zhuIzR14NN+MDgBI2+nHtf9qNNiGPUUHGZ8dsch6l4uNb1d99ppD6
         lieeWyjtj6hdQOHl7CF9BETAM+QFzHDUyXVMQw5ZgZla5H1DOliRedo2oFldchn+bbtq
         r3xtOkh7KmLCbDtHhrTXxfTERQrRQAxUFQLr1R2LaFEDWjODiRmsY3uyZ+Wi6qKlbt/q
         DxN36aBzI/esj0dXy73zPPQgXgkFQmswgk4gUXxY0eOtqsR+p1+aI/T98F7rhWlyn4eR
         jc1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc;
        bh=lZTGS1hl4QonGC0u03Eh00M29IunEojuiM+Qpvqy/Nc=;
        b=h25mYCAqVxrrdRXC50803A+Lwz1GXBnlg37uZAVBuCS5MHdJVAhPEbY1kteGbsyTXf
         tIjqVb2eTX166J+7Efu2Sw8dm8wZGslZWE1kjv3Nad3cQ6oxU4kSDSNMEnOxGA59cfyD
         Az+XnDODjXVwvNXjh9kk4O4yvwLJUO6J++HdJqPTrHcYMsOvA6CXVShCj33fQYTwuQMG
         5ta23Mtw68AnjrpeeMBSS957hocEBttbVlpZ/zsalEGBCPJtnF6syTF3ReaZ43Kzp51W
         oHlFyGwyMHHg4hGtAGHt2kNuCyFa5bxa63JHcsai8iWcLZIhQ6DOA58DwcqdXJdbf6yL
         wAUw==
X-Gm-Message-State: AJIora8yKNXnjvoNcMIAOV2+nmbh8f0yEQ2NEYU+fElvVfN8gQEtvsam
        5ChBqENzETqoqDPXvkyFbNktZEI0JiFJQA==
X-Google-Smtp-Source: AGRyM1uGmyjweOmghxxuKsPfjwxOxEXLBNHVbrLKZlBwtP4Z2L8w8dM6FafELB+hEq+FkwUaO2n3gg==
X-Received: by 2002:a17:907:734a:b0:72b:7c72:e6b3 with SMTP id dq10-20020a170907734a00b0072b7c72e6b3mr1830481ejc.608.1659079349365;
        Fri, 29 Jul 2022 00:22:29 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id bm4-20020a0564020b0400b0043ac761db43sm1873111edb.55.2022.07.29.00.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 00:22:28 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oHKKK-007OLL-03;
        Fri, 29 Jul 2022 09:22:28 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/6] revisions API: don't leak memory on argv elements
 that need free()-ing
Date:   Fri, 29 Jul 2022 09:07:40 +0200
References: <cover-0.6-00000000000-20220713T130511Z-avarab@gmail.com>
 <patch-6.6-4a581a4a6ce-20220713T130511Z-avarab@gmail.com>
 <YtV4KmrTBkmcx6m3@coredump.intra.peff.net>
 <220718.86zgh6wiwa.gmgdl@evledraar.gmail.com>
 <YtWAMP0ROFseFs6B@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <YtWAMP0ROFseFs6B@coredump.intra.peff.net>
Message-ID: <220729.86pmhoidsc.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jul 18 2022, Jeff King wrote:

> On Mon, Jul 18, 2022 at 05:13:05PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> > But if you went just a little further and made the option "rev should
>> > own its own argv", then I think you can simplify life for callers even
>> > more. They could construct a strvec themselves and then hand it off to
>> > the rev_info, to be cleaned up when release_revisions() is called (and
>> > of course freeing the "--" when we overwrite it in the interim, as you
>> > do here).
>> >
>> > Then all of the bisect callers from the previous patch could avoid
>> > having to deal with the strvec at all. They'd call bisect_rev_setup(),
>> > which would internally attach the memory to rev_info.
>>=20
>> Yes, I experimented with this, and it's a solid approach.
>>=20
>> But it's a much larger change, particularly since we'd also want to
>> update the API itself to take take "const" in the appropriate places to
>> do it properly.
>
> Hmm. I was thinking that we'd just have rev_info.we_own_our_argv, and
> then release it in release_revisions(). But actually, rev_info does not
> hold onto the argv at all! It's totally processed in setup_revisions().
>
> And there it either:
>
>   - becomes part of prune_data (in which case a copy is made)
>
>   - is passed to handle_revisions_opt(), etc, in which case it is parsed
>     but not held onto (it's possible that some string option holds onto
>     a pointer, but the only one I found is --filter, which makes a
>     copy).
>
>   - is passed to handle_revision_arg(), but these days
>     add_rev_cmdline(), etc, make copies. As they must, otherwise --stdin
>     would be totally buggy.
>
> So I actually wonder if the comment in bisect_rev_setup() is simply
> wrong. It was correct in 2011 when I wrote it, but things changed in
> df835d3a0c (add_rev_cmdline(): make a copy of the name argument,
> 2013-05-25), etc.
>
> In that case, we could replace your patch 5 in favor of just calling
> strvec_clear() at the end of bisect_rev_setup().

5/6 is doing that, or rather at the end of check_ancestors() and
bisect_next_all(), but those call bisect_rev_setup() and pass it the
strvec, so in terms of memory management it amounts to the same thing.

> It's possible there's a
> case I'm missing that makes this generally not-safe, but in the case of
> bisect_rev_setup() there's a very limited set of items in our argv in
> the first place. Doing so also passes the test suite with
> SANITIZE=3Daddress, though again, this is just exercising the very limited
> bisect options here.

I think what you're missing is that this code is basically doing this,
which is a common pattern in various parts of our codebase:

	struct strvec sv =3D STRVEC_INIT;
	strvec_push(&sv, "foo"); // sv.v[0]=20
	strvec_push(&sv, "bar"); // sv.v[1]=20
	sv.v[1] =3D NULL; // the code in revisions.c
	strvec_clear(&sv);

I.e. you can't fix this by simply having revision.c having its own
strvec, because it would just .. proceed to do the same thing.

Of course we could alter its argv-iterating state machine to not clobber
that "argv" element to NULL, and have other subsequent code know that it
should stop at a new lower "argc" etc. etc., but that's getting at the
much more invasive API changes 6/6 notes as the path not taken.

And, in the general case for things that do this to the strvec what
we're explicitly doing is having the caller then operate on that munged
argv, i.e. it's important that we change *its* argv. That's not going on
here, but e.g. various parse_options() callers rely on that.

I've experimented a bit with how to solve this more generally, the below
is some very rough WIP code I have laying aroun to try to do that.

IIRC this fails SANITIZE=3Daddress or was otherwise broken, I didn't test
it now, but that's not the point...

... I'm just including it by way of explanation. I.e. for at least
*some* callers (IIRC the below mostly works, and I can't remember where
it's broken) it would suffice to just keep around a list of "here's
stuff we should free later".

In case below I opted to do that with a string_list, but it could be
another strvec or whatever.

-- >8 --
From: =3D?UTF-8?q?=3DC3=3D86var=3D20Arnfj=3DC3=3DB6r=3DC3=3DB0=3D20Bjarmaso=
n?=3D
 <avarab@gmail.com>
Date: Fri, 10 Jun 2022 13:05:05 +0200
Subject: [PATCH] string-list API: add utility to help free "struct strvec"
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

The "struct strvec" has its own strvec_clear(), but unfortunately it's
a very common pattern to pass its "v" member to parse_options(),
setup_revisions() etc.

Those APIs will then change the "argv" so that strvec_clear() can't do
anything useful with its members, e.g. parse_options_end() will NULL
out the dereferenced elements of the "argv" that's passed in to
indicate how much of it was consumed.

One way to deal with that would be to change all of those APIs to
accept some "in_argv" which they'd then copy, but that would be a very
large change.

This is a less invasive way of doing it, we'll now maintain a "struct
string_list" on the side, whose "util" members point to the elements
of the "struct strvec" that we should free() later, which we can
helpfully do with string_list_clear(list, 1). See the added API
documentation for more details.

As a result we can mark more tests as passing with SANITIZE=3Dleak using
"TEST_PASSES_SANITIZE_LEAK=3Dtrue". We'll be able to use this API for a
lot more callers, but let's start with "am"'s run_apply().

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
---
 builtin/am.c                  |  3 +++
 string-list.c                 | 16 ++++++++++++++++
 string-list.h                 | 15 +++++++++++++++
 t/t0023-crlf-am.sh            |  1 +
 t/t4152-am-subjects.sh        |  2 ++
 t/t4254-am-corrupt.sh         |  2 ++
 t/t4256-am-format-flowed.sh   |  1 +
 t/t5403-post-checkout-hook.sh |  1 +
 8 files changed, 41 insertions(+)

diff --git a/builtin/am.c b/builtin/am.c
index 93bec62afa9..d927fea128a 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1476,6 +1476,7 @@ static int run_apply(const struct am_state *state, co=
nst char *index_file)
 	int res, opts_left;
 	int force_apply =3D 0;
 	int options =3D 0;
+	struct string_list to_free =3D STRING_LIST_INIT_NODUP;
=20
 	if (init_apply_state(&apply_state, the_repository, NULL))
 		BUG("init_apply_state() failed");
@@ -1483,6 +1484,7 @@ static int run_apply(const struct am_state *state, co=
nst char *index_file)
 	strvec_push(&apply_opts, "apply");
 	strvec_pushv(&apply_opts, state->git_apply_opts.v);
=20
+	string_list_append_strvec_nodup(&to_free, &apply_opts);
 	opts_left =3D apply_parse_options(apply_opts.nr, apply_opts.v,
 					&apply_state, &force_apply, &options,
 					NULL);
@@ -1512,6 +1514,7 @@ static int run_apply(const struct am_state *state, co=
nst char *index_file)
=20
 	strvec_clear(&apply_paths);
 	strvec_clear(&apply_opts);
+	string_list_clear(&to_free, 1);
 	clear_apply_state(&apply_state);
=20
 	if (res)
diff --git a/string-list.c b/string-list.c
index 549fc416d68..ecbfb3065a8 100644
--- a/string-list.c
+++ b/string-list.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "string-list.h"
+#include "strvec.h"
=20
 void string_list_init_nodup(struct string_list *list)
 {
@@ -325,3 +326,18 @@ int string_list_split_in_place(struct string_list *lis=
t, char *string,
 		}
 	}
 }
+
+void string_list_append_strvec_nodup(struct string_list *list,
+				     const struct strvec *vec)
+{
+	size_t i;
+
+	if (list->strdup_strings)
+		BUG("need .strdup_strings =3D 0 for string_list_append_strvec_nodup()");
+
+	for (i =3D 0; i < vec->nr; i++) {
+		const char *p =3D vec->v[i];
+
+		string_list_append_nodup(list, (char *)p)->util =3D (void *)p;
+	}
+}
diff --git a/string-list.h b/string-list.h
index d5a744e1438..e740f3f29be 100644
--- a/string-list.h
+++ b/string-list.h
@@ -266,4 +266,19 @@ int string_list_split(struct string_list *list, const =
char *string,
  */
 int string_list_split_in_place(struct string_list *list, char *string,
 			       int delim, int maxsplit);
+
+/**
+ * Given a STRING_LIST_INIT_NODUP-initialized "struct string_list"
+ * takes a "struct strvec" and "copies" it, the "string" members will
+ * be the elements of the "struct strvec", and more importantly so
+ * will the "util" members.
+ *
+ * This is intended to squirrel away pointers to "argv" to
+ * string_list_clear(list, 1) them later, in cases where a "struct
+ * strvec" is passed to an API like parse_options(), setup_revisions()
+ * etc.
+ */
+struct strvec;
+void string_list_append_strvec_nodup(struct string_list *list,
+				     const struct strvec *vec);
 #endif /* STRING_LIST_H */
diff --git a/t/t0023-crlf-am.sh b/t/t0023-crlf-am.sh
index f9bbb91f64e..575805513a3 100755
--- a/t/t0023-crlf-am.sh
+++ b/t/t0023-crlf-am.sh
@@ -2,6 +2,7 @@
=20
 test_description=3D'Test am with auto.crlf'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 cat >patchfile <<\EOF
diff --git a/t/t4152-am-subjects.sh b/t/t4152-am-subjects.sh
index 4c68245acad..9f2edba1f83 100755
--- a/t/t4152-am-subjects.sh
+++ b/t/t4152-am-subjects.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
=20
 test_description=3D'test subject preservation with format-patch | am'
+
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 make_patches() {
diff --git a/t/t4254-am-corrupt.sh b/t/t4254-am-corrupt.sh
index 54be7da1611..45f1d4f95e5 100755
--- a/t/t4254-am-corrupt.sh
+++ b/t/t4254-am-corrupt.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
=20
 test_description=3D'git am with corrupt input'
+
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 make_mbox_with_nul () {
diff --git a/t/t4256-am-format-flowed.sh b/t/t4256-am-format-flowed.sh
index 2369c4e17ad..1015273bc82 100755
--- a/t/t4256-am-format-flowed.sh
+++ b/t/t4256-am-format-flowed.sh
@@ -2,6 +2,7 @@
=20
 test_description=3D'test format=3Dflowed support of git am'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_expect_success 'setup' '
diff --git a/t/t5403-post-checkout-hook.sh b/t/t5403-post-checkout-hook.sh
index 978f240cdac..cfaae547398 100755
--- a/t/t5403-post-checkout-hook.sh
+++ b/t/t5403-post-checkout-hook.sh
@@ -7,6 +7,7 @@ test_description=3D'Test the post-checkout hook.'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_expect_success setup '


