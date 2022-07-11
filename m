Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA68CCA47B
	for <git@archiver.kernel.org>; Mon, 11 Jul 2022 11:16:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbiGKLQi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jul 2022 07:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiGKLQV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jul 2022 07:16:21 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D065A477
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 03:37:47 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id r6so5672093edd.7
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 03:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=Ech1FNPxvanQh9s4HwnsGf4Ht3/l2WzITCffa/ZwFgs=;
        b=mhU5T5GzY2GFXws1iBdxW/Y9Fo6//dHPQSK9rjj74Bh4+gC9z5DYCeDADpyXU3PYKn
         BLjzjRsdfilgLJ/agLk7fNm5ONQ7hQEGVNNKo6gMGVwiuK7qy77bHujestDZ9sYlWAAB
         CE5Jln/+flmFGlMdvgSjN43YUy8/6Q034jAGtzE16/vM0AWw/0Er/Pt6kKBuJRpC06nM
         4JQ6Hc7jp7zfFZE2si9Rz/8Qwla5nWkxYuwxtGIHeferNsO2kEgatJ8IYtcwXo1k9vqW
         xVieiNZFBP0xZX2ByVbSM6Tykhigy4Awbfzxk2k+jUDcWG7Bs/kTech3qcfQxKADqJIW
         yD9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=Ech1FNPxvanQh9s4HwnsGf4Ht3/l2WzITCffa/ZwFgs=;
        b=13sk9SuWXhJWh20cp9GRpa9oSKJWRTKv7696jNaSQPakXHlaDJJQIs4s1ti3VmR9xp
         u997rSZsa+I0yg4bcZR+dQtqYpHzN3ZY407Bf5vusdFW9Pj5oaRvd1HvED1fK/rqqH+W
         H+2WyNp0JvCuHOWVxmuFRWQ4C6CkczIzm8q1VOC5WygzFjb9lmOsBSi6Zkiehl8ri9Gd
         c7cjIUy4Irj1YRiYbblM+/NdxAbGJiyE0boYe8jLjEs0qPDP2UG21SUlDqLyJ93E/xUT
         y70+HKG/f4JLylj5DCzQPFD69KZtRpb+ICAwlJwCC0GoUzBmapXEzHxUCcZVhcX5Qfdx
         NK5g==
X-Gm-Message-State: AJIora+22TsIxFuwnO5XeYAlYffCFqa9i+hrUuISvAZFVDaQ4wTcYx6K
        spsdg5Zd/OLgRiu4Rd0En+M=
X-Google-Smtp-Source: AGRyM1s2GUZB8Pz71S1AyB2vyowXflmjwMU5Xoek/KvbNCxxIWEhyhsjwQ1t+YRcotjFmgApqSlV7g==
X-Received: by 2002:a05:6402:2b8f:b0:43a:66d4:a025 with SMTP id fj15-20020a0564022b8f00b0043a66d4a025mr23704858edb.121.1657535865466;
        Mon, 11 Jul 2022 03:37:45 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id ch17-20020a170906c2d100b0072a55ebbc77sm2522416ejb.66.2022.07.11.03.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 03:37:44 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oAqnP-000mR8-2p;
        Mon, 11 Jul 2022 12:37:43 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 7/7] xdiff: remove xdl_free(), use free() instead
Date:   Mon, 11 Jul 2022 12:02:39 +0200
References: <b34dcb93-df73-f5de-3c7c-7ab6c3250afe@gmail.com>
 <cover-0.7-00000000000-20220708T140354Z-avarab@gmail.com>
 <patch-7.7-a1bf9a94f0a-20220708T140354Z-avarab@gmail.com>
 <6b8fc0e8-c446-1275-12f3-e6520de9584d@gmail.com>
 <220708.86czef9t6y.gmgdl@evledraar.gmail.com>
 <dcde61a3-4d96-6cd5-f05e-45781599f8bd@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <dcde61a3-4d96-6cd5-f05e-45781599f8bd@gmail.com>
Message-ID: <220711.865yk47x54.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jul 11 2022, Phillip Wood wrote:

> Hi =C3=86var
>
> On 08/07/2022 22:26, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Fri, Jul 08 2022, Phillip Wood wrote:
>>=20
>>> Hi =C3=86var
>>>
>>> On 08/07/2022 15:20, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>>> Remove the xdl_free() wrapper macro in favor of using free()
>>>> directly. The wrapper macro was brought in with the initial import of
>>>> xdiff/ in 3443546f6ef (Use a *real* built-in diff generator,
>>>> 2006-03-24).
>>>> As subsequent discussions on the topic[1] have made clear there's no
>>>> reason to use this wrapper.
>>>
>>> That link is to a message where you assert that there is no reason for
>>> the wrapper, you seem to be the only person in that thread making that
>>> argument. The libgit2 maintainer and others are arguing that it is
>>> worth keeping to make it easy to swap the allocator.
>> Arguing that it's not needed for a technical reason, but an
>> "aesthetic
>> and ergonomic one", per:
>> https://lore.kernel.org/git/20220217225804.GC7@edef91d97c94/;
>> Perhaps I misread it, but I took this as Junio concurring with what
>> I
>> was pointing out there:
>> https://lore.kernel.org/git/xmqqfsohbdre.fsf@gitster.g/
>>=20
>>>> Both git itself as well as any external
>>>> users such as libgit2 compile the xdiff/* code as part of their own
>>>> compilation, and can thus find the right malloc() and free() at
>>>> link-time.
>>>
>>> I'm struggling to see how that is simpler than the current situation
>>> with xdl_malloc().
>> It's simpler because when maintaining that code in git.git it's less
>> of
>> a special case, e.g. we have coccinelle rules that match free(), now
>> every such rule needs to account for the xdiff special-case.
>> And it's less buggy because if you're relying on us always using a
>> wrapper bugs will creep in, current master has this:
>>=20=09
>> 	$ git -P grep '\bfree\(' -- xdiff
>> 	xdiff/xdiff.h:#define xdl_free(ptr) free(ptr)
>> 	xdiff/xmerge.c:         free(c);
>> 	xdiff/xmerge.c: free(next_m);
>>=20
>>> Perhaps you could show how you think libgit2 could
>>> easily make xdiff use git__malloc() instead of malloc() without
>>> changing the malloc() calls (the message you linked to essentially
>>> suggests they do a search and replace). If people cannot swap in
>>> another allocator without changing the code then you are imposing a
>>> barrier to them contributing patches back to git's xdiff.
>> I was suggesting that if libgit2 wanted to maintain a copy of xdiff
>> that
>> catered to the asthetic desires of the maintainer adjusting whatever
>> import script you use to apply a trivial coccinelle transformation would
>> give you what you wanted. Except without a maintenance burden on
>> git.git, or the bugs you'd get now since you're not catching those two
>> free() cases (or any future such cases).
>> But just having the code use malloc() and free() directly and
>> getting
>> you what you get now is easy, and doesn't require any such
>> search-replacement.
>> Here's how:
>> I imported the xdiff/*.[ch] files at the tip of my branch into
>> current
>> libgit2.git's src/libgit2/xdiff/, and then applied this on top, which is
>> partially re-applying libgit2's own monkeypatches, and partially
>> adjusting for upstream changes (including this one):
>>=20=09
>> 	diff --git a/src/libgit2/xdiff/git-xdiff.h b/src/libgit2/xdiff/git-xdif=
f.h
>> 	index b75dba819..2e00764d4 100644
>> 	--- a/src/libgit2/xdiff/git-xdiff.h
>> 	+++ b/src/libgit2/xdiff/git-xdiff.h
>> 	@@ -14,6 +14,7 @@
>> 	 #ifndef INCLUDE_git_xdiff_h__
>> 	 #define INCLUDE_git_xdiff_h__
>>=20=09
>> 	+#include <regex.h>
>> 	 #include "regexp.h"
>>=20=09
>> 	 /* Work around C90-conformance issues */
>> 	@@ -27,11 +28,10 @@
>> 	 # endif
>> 	 #endif
>>=20=09
>> 	-#define xdl_malloc(x) git__malloc(x)
>> 	-#define xdl_free(ptr) git__free(ptr)
>> 	-#define xdl_realloc(ptr, x) git__realloc(ptr, x)
>> 	+#define malloc(x) git__malloc(x)
>> 	+#define free(ptr) git__free(ptr)
>>=20=09
>> 	-#define XDL_BUG(msg) GIT_ASSERT(msg)
>> 	+#define BUG(msg) GIT_ASSERT(msg)
>>=20=09
>> 	 #define xdl_regex_t git_regexp
>> 	 #define xdl_regmatch_t git_regmatch
>> 	@@ -50,4 +50,17 @@ GIT_INLINE(int) xdl_regexec_buf(
>> 	 	return -1;
>> 	 }
>>=20=09
>> 	+static inline size_t st_mult(size_t a, size_t b)
>> 	+{
>> 	+	return a * b;
>> 	+}
>> 	+
>> 	+static inline int regexec_buf(const regex_t *preg, const char *buf, si=
ze_t size,
>> 	+			      size_t nmatch, regmatch_t pmatch[], int eflags)
>> 	+{
>> 	+	assert(nmatch > 0 && pmatch);
>> 	+	pmatch[0].rm_so =3D 0;
>> 	+	pmatch[0].rm_eo =3D size;
>> 	+	return regexec(preg, buf, nmatch, pmatch, eflags | REG_STARTEND);
>> 	+}
>> 	 #endif
>> 	diff --git a/src/libgit2/xdiff/xdiff.h b/src/libgit2/xdiff/xdiff.h
>> 	index a37d89fcd..5e5b525c2 100644
>> 	--- a/src/libgit2/xdiff/xdiff.h
>> 	+++ b/src/libgit2/xdiff/xdiff.h
>> 	@@ -23,6 +23,8 @@
>> 	 #if !defined(XDIFF_H)
>> 	 #define XDIFF_H
>>=20=09
>> 	+#include "git-xdiff.h"
>> 	+
>> 	 #ifdef __cplusplus
>> 	 extern "C" {
>> 	 #endif /* #ifdef __cplusplus */
>> 	diff --git a/src/libgit2/xdiff/xinclude.h b/src/libgit2/xdiff/xinclude.h
>> 	index a4285ac0e..79812ad8a 100644
>> 	--- a/src/libgit2/xdiff/xinclude.h
>> 	+++ b/src/libgit2/xdiff/xinclude.h
>> 	@@ -23,7 +23,8 @@
>> 	 #if !defined(XINCLUDE_H)
>> 	 #define XINCLUDE_H
>>=20=09
>> 	-#include "git-compat-util.h"
>> 	+#include "git-xdiff.h"
>> 	+#include "git-shared-util.h"
>> 	 #include "xmacros.h"
>> 	 #include "xdiff.h"
>> 	 #include "xtypes.h"
>> If you then build it and run e.g.:
>> 	gdb -args ./libgit2_tests -smerge::files
>> You'll get stack traces like this if you break on stdalloc__malloc
>> (which it uses for me in its default configuration):
>>=20=09
>> 	(gdb) bt
>> 	#0  stdalloc__malloc (len=3D144, file=3D0x87478d "/home/avar/g/libgit2/=
src/libgit2/xdiff/xutils.c", line=3D101) at /home/avar/g/libgit2/src/util/a=
llocators/stdalloc.c:14
>> 	#1  0x00000000006ec15c in xdl_cha_alloc (cha=3D0x7fffffffcaa8) at /home=
/avar/g/libgit2/src/libgit2/xdiff/xutils.c:101
>> 	#2  0x00000000006eaee9 in xdl_prepare_ctx (pass=3D1, mf=3D0x7fffffffcc9=
8, narec=3D13, xpp=3D0x7fffffffcca8, cf=3D0x7fffffffc7d0, xdf=3D0x7fffffffc=
aa8)
>> 	    at /home/avar/g/libgit2/src/libgit2/xdiff/xprepare.c:194
>> IOW this was all seamlessly routed to your git__malloc() without us
>> having to maintain an xdl_{malloc,free}().
>
> Thanks for showing this, it is really helpful to see a concrete
> example. I was especially interested to see how you went about the
> conversion without redefining standard library functions or
> introducing non-namespaced identifiers in files that included
> xdiff.h. Unfortunately you have not done that and so I don't think the
> approach above is viable   for a well behaved library.

Why? Because there's some header where doing e.g.:

	#include "git2/something.h"

Will directly include git-xdiff.h by proxy into the user's program?

I admit I didn't check that, and assumed that these were only included
by other *.c files in libgit2 itself. I.e. it would compile xdiff for
its own use, but then expose its own API.

Anyway, if it is directly included in some user-exposed *.h file then
yes, you don't want to overwrite their "malloc", but that's a small
matter of doing an "#undef malloc" at the end (which as the below
linked-to patch shows we'd support by having macros like
SHA1DC_CUSTOM_TRAILING_INCLUDE_UBC_CHECK_C).

Aside from what I'm proposing here doing such "undef at the end" seems
like a good idea in any case, because if there is any macro leakage here
you're e.g. re-defining "XDL_BUG" and other things that aren't clearly
in the libgit2 namespace now, no?

>> Now, I think that's obviously worth adjusting, e.g. the series I've got
>> here could make this easier for libgit2 by including st_mult() at least,
>> I'm not sure what you want to do about regexec_buf().
>> For the monkeypatching you do now of creating a "git-xdiff.h" I
>> think it
>> would be very good to get a patch like what I managed to get
>> sha1collisiondetection.git to accept for our own use-case, which allows
>> us to use their upstream code as-is from a submodule:
>> 	https://github.com/cr-marcstevens/sha1collisiondetection/commit/b45fcef
>
> Thanks for the link, That's a really good example where all the
> identifiers are namespaced and the public include file does not
> pollute the code that is including it. If you come up with something
> like that where the client code can set up same #defines for malloc,
> calloc, realloc and free that would be a good way forward.

I don't need to come up with that, you've got the linker to do that.

I.e. for almost any "normal" use of xdiff you'd simply compile it with
its reference to malloc(), and then you either link that library that
already links to libc into your program.

So if you use a custom malloc the xdiff code might still use libc
malloc, or you'd link the two together and link the resulting program
with your own custom malloc.

As explained in the previous & linked-to threads this is how almost
everyone would include & use such a library, and indeed that's how git
itself can use malloc() and free() in its sources, but have options to
link to libc malloc, nedmalloc etc.

But instead of using the linker to resolve "malloc" to git__malloc you'd
like to effectively include the upstream *.[ch] files directly, and
pretend as though the upstream source used git__malloc() or whatever to
begin with.

I don't really understand why you can't just do that at the linker
level, especially as doing so guards you better against namespace
pollution. But whatever, the suggestion(s) above assume you've got a
good reason, but show that we don't need to prefix every standard
function just to accommodate that.

Instead we can just provide a knob to include a header of yours after
all others have been included (which the libgit2 monkeypatches to xdiff
already include), and have that header define "malloc" as "git__malloc",
"BUG" as "GIT_ASSERT" etc.=20

And yes, if you're in turn providing an interface where others will then
include your header that's doing that you'll need to apply some
namespacing paranoia, namely to "#undef malloc" etc.

But none of that requires git to carry prefixed versions of standard
functions you'd wish to replace, which the patches here show.

> I do not think we should require projects to be defining there own
> versions of [C]ALLOC_*() and BUG() just to use xdiff.

No, I don't think so either. I.e. the idea with these patches is that we
could bundle up xdiff/* and git-shared-util.h into one distributed
libgit, which down the road we could even roll independent releases for
(as upstream seems to have forever gone away).

Whereas the proposals coming out of libgit2[1] for generalizing xdiff/
for general use seem to stop just short of the specific hacks we need to
get it running for libgit2, but e.g. leave "xdl_malloc" defined as
"xmalloc".

That isn't a standard library function, and therefore the first thing
you'd need to do when using it as a library is to find out how git.git
uses that, and copy/paste it or define your own replacement.

Whereas I think it should be the other way around, we should e.g. ship a
shimmy BUG() that calls fprintf(stderr, ...) and abort(), but for
advanced users such as libgit2 guard those with "ifndef" or whatever, so
you can have it call GIT_ASSERT() and the like instead.

1. https://lore.kernel.org/git/20220209013354.GB7@abe733c6e288/
