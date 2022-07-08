Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFDBCC433EF
	for <git@archiver.kernel.org>; Fri,  8 Jul 2022 21:43:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240086AbiGHVnX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jul 2022 17:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbiGHVnW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jul 2022 17:43:22 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E32A23BA
        for <git@vger.kernel.org>; Fri,  8 Jul 2022 14:43:20 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id k30so74067edk.8
        for <git@vger.kernel.org>; Fri, 08 Jul 2022 14:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=2hdVrq4bjokrGLm12WE7urqj5ozVjylR0FBx6ZcZrmI=;
        b=OC4Ee3Ps/BZmV1JWRpm5yGbVIn+TIGGaNDOEGRs4zqLtj+oFDxhaUTk3NPS7MEAu7T
         4x6kYbqNBUP0QT3hr/+vcSdiyTKDyHkep4b0Z2+Zs6e4o37njeiNUnN2IYdFrzFhsV3O
         cBWItkduWihbKxiX2hSChgLYDebwBeaX0H9yLXuhOLKSlDBCXCFTN651SnuPM61ZHs+H
         cDv0NAaCP5piDKllNI/fx3TbxpkQxvXQurJvnCG0DyWC4wQgCvOqOtnUdKhc/tUl2Xdx
         EiIYSoIntlIoJcg3MQ3xaBQFtavzdf5tWI7qrsTLifFlnzr2SvvbTKQatpy+5M01uwRX
         6aMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=2hdVrq4bjokrGLm12WE7urqj5ozVjylR0FBx6ZcZrmI=;
        b=fcI70WI6/mzhifXT+vU+v8iRwKf2ZnVLf0ITZtbhfth0qe59Qq9LHavI2za6Js7SxK
         9ocRTh3neJUcEBP7LOLgiTdvaUEfentEfJMxddfd9jPz8VfjTbQEwik1VcnbKKuSN93Y
         3d48iB4FwV4svf7Ql6bdj5cMVbNyfOqZlJLwbGcQYuCSrmuBvJsbjzA8AE79lu4ZdYi2
         KEoGt6Jz6bpraiZCTL+DsR1yGYgWhGro5GCpBPho+RuI1dHNq7GnynEApCkVrawvEsqJ
         p/QHz3DiuZy9fDB6Su5BGKFK7FfpkEBpa4kuyR5LAZkKrd2FtyBC13Zv6+stQXhMPEPY
         AOTw==
X-Gm-Message-State: AJIora84hiixGQnX+mKIPE0qXpywPE4YC2IEwMad4xaWyBwEojycOuJk
        RLAmeh1nuZte6Y1CF+TZs18=
X-Google-Smtp-Source: AGRyM1uPbi1RrrTmKtbtyCx6uFOfbOnzx0qq9IR7o8HMt4fP0KT/gpSZ5+UL64Wt67ij5EiiB1+qwA==
X-Received: by 2002:a05:6402:2a08:b0:437:cdc9:d120 with SMTP id ey8-20020a0564022a0800b00437cdc9d120mr7479176edb.129.1657316599331;
        Fri, 08 Jul 2022 14:43:19 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id g3-20020a170906594300b006f3ef214daesm20531923ejr.20.2022.07.08.14.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 14:43:18 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o9vkr-0002Kt-G6;
        Fri, 08 Jul 2022 23:43:17 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 7/7] xdiff: remove xdl_free(), use free() instead
Date:   Fri, 08 Jul 2022 23:26:59 +0200
References: <b34dcb93-df73-f5de-3c7c-7ab6c3250afe@gmail.com>
 <cover-0.7-00000000000-20220708T140354Z-avarab@gmail.com>
 <patch-7.7-a1bf9a94f0a-20220708T140354Z-avarab@gmail.com>
 <6b8fc0e8-c446-1275-12f3-e6520de9584d@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <6b8fc0e8-c446-1275-12f3-e6520de9584d@gmail.com>
Message-ID: <220708.86czef9t6y.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jul 08 2022, Phillip Wood wrote:

> Hi =C3=86var
>
> On 08/07/2022 15:20, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> Remove the xdl_free() wrapper macro in favor of using free()
>> directly. The wrapper macro was brought in with the initial import of
>> xdiff/ in 3443546f6ef (Use a *real* built-in diff generator,
>> 2006-03-24).
>> As subsequent discussions on the topic[1] have made clear there's no
>> reason to use this wrapper.
>
> That link is to a message where you assert that there is no reason for
> the wrapper, you seem to be the only person in that thread making that=20
> argument. The libgit2 maintainer and others are arguing that it is
> worth keeping to make it easy to swap the allocator.

Arguing that it's not needed for a technical reason, but an "aesthetic
and ergonomic one", per:
https://lore.kernel.org/git/20220217225804.GC7@edef91d97c94/;

Perhaps I misread it, but I took this as Junio concurring with what I
was pointing out there:
https://lore.kernel.org/git/xmqqfsohbdre.fsf@gitster.g/

>> Both git itself as well as any external
>> users such as libgit2 compile the xdiff/* code as part of their own
>> compilation, and can thus find the right malloc() and free() at
>> link-time.
>
> I'm struggling to see how that is simpler than the current situation
> with xdl_malloc().

It's simpler because when maintaining that code in git.git it's less of
a special case, e.g. we have coccinelle rules that match free(), now
every such rule needs to account for the xdiff special-case.

And it's less buggy because if you're relying on us always using a
wrapper bugs will creep in, current master has this:
=09
	$ git -P grep '\bfree\(' -- xdiff=20
	xdiff/xdiff.h:#define xdl_free(ptr) free(ptr)
	xdiff/xmerge.c:         free(c);
	xdiff/xmerge.c: free(next_m);

> Perhaps you could show how you think libgit2 could=20
> easily make xdiff use git__malloc() instead of malloc() without
> changing the malloc() calls (the message you linked to essentially
> suggests they do a search and replace). If people cannot swap in
> another allocator without changing the code then you are imposing a
> barrier to them contributing patches back to git's xdiff.

I was suggesting that if libgit2 wanted to maintain a copy of xdiff that
catered to the asthetic desires of the maintainer adjusting whatever
import script you use to apply a trivial coccinelle transformation would
give you what you wanted. Except without a maintenance burden on
git.git, or the bugs you'd get now since you're not catching those two
free() cases (or any future such cases).

But just having the code use malloc() and free() directly and getting
you what you get now is easy, and doesn't require any such
search-replacement.

Here's how:

I imported the xdiff/*.[ch] files at the tip of my branch into current
libgit2.git's src/libgit2/xdiff/, and then applied this on top, which is
partially re-applying libgit2's own monkeypatches, and partially
adjusting for upstream changes (including this one):
=09
	diff --git a/src/libgit2/xdiff/git-xdiff.h b/src/libgit2/xdiff/git-xdiff.h
	index b75dba819..2e00764d4 100644
	--- a/src/libgit2/xdiff/git-xdiff.h
	+++ b/src/libgit2/xdiff/git-xdiff.h
	@@ -14,6 +14,7 @@
	 #ifndef INCLUDE_git_xdiff_h__
	 #define INCLUDE_git_xdiff_h__
=09=20
	+#include <regex.h>
	 #include "regexp.h"
=09=20
	 /* Work around C90-conformance issues */
	@@ -27,11 +28,10 @@
	 # endif
	 #endif
=09=20
	-#define xdl_malloc(x) git__malloc(x)
	-#define xdl_free(ptr) git__free(ptr)
	-#define xdl_realloc(ptr, x) git__realloc(ptr, x)
	+#define malloc(x) git__malloc(x)
	+#define free(ptr) git__free(ptr)
=09=20
	-#define XDL_BUG(msg) GIT_ASSERT(msg)
	+#define BUG(msg) GIT_ASSERT(msg)
=09=20
	 #define xdl_regex_t git_regexp
	 #define xdl_regmatch_t git_regmatch
	@@ -50,4 +50,17 @@ GIT_INLINE(int) xdl_regexec_buf(
	 	return -1;
	 }
=09=20
	+static inline size_t st_mult(size_t a, size_t b)
	+{
	+	return a * b;
	+}
	+
	+static inline int regexec_buf(const regex_t *preg, const char *buf, size_=
t size,
	+			      size_t nmatch, regmatch_t pmatch[], int eflags)
	+{
	+	assert(nmatch > 0 && pmatch);
	+	pmatch[0].rm_so =3D 0;
	+	pmatch[0].rm_eo =3D size;
	+	return regexec(preg, buf, nmatch, pmatch, eflags | REG_STARTEND);
	+}
	 #endif
	diff --git a/src/libgit2/xdiff/xdiff.h b/src/libgit2/xdiff/xdiff.h
	index a37d89fcd..5e5b525c2 100644
	--- a/src/libgit2/xdiff/xdiff.h
	+++ b/src/libgit2/xdiff/xdiff.h
	@@ -23,6 +23,8 @@
	 #if !defined(XDIFF_H)
	 #define XDIFF_H
=09=20
	+#include "git-xdiff.h"
	+
	 #ifdef __cplusplus
	 extern "C" {
	 #endif /* #ifdef __cplusplus */
	diff --git a/src/libgit2/xdiff/xinclude.h b/src/libgit2/xdiff/xinclude.h
	index a4285ac0e..79812ad8a 100644
	--- a/src/libgit2/xdiff/xinclude.h
	+++ b/src/libgit2/xdiff/xinclude.h
	@@ -23,7 +23,8 @@
	 #if !defined(XINCLUDE_H)
	 #define XINCLUDE_H
=09=20
	-#include "git-compat-util.h"
	+#include "git-xdiff.h"
	+#include "git-shared-util.h"
	 #include "xmacros.h"
	 #include "xdiff.h"
	 #include "xtypes.h"

If you then build it and run e.g.:

	gdb -args ./libgit2_tests -smerge::files

You'll get stack traces like this if you break on stdalloc__malloc
(which it uses for me in its default configuration):
=09
	(gdb) bt
	#0  stdalloc__malloc (len=3D144, file=3D0x87478d "/home/avar/g/libgit2/src=
/libgit2/xdiff/xutils.c", line=3D101) at /home/avar/g/libgit2/src/util/allo=
cators/stdalloc.c:14
	#1  0x00000000006ec15c in xdl_cha_alloc (cha=3D0x7fffffffcaa8) at /home/av=
ar/g/libgit2/src/libgit2/xdiff/xutils.c:101
	#2  0x00000000006eaee9 in xdl_prepare_ctx (pass=3D1, mf=3D0x7fffffffcc98, =
narec=3D13, xpp=3D0x7fffffffcca8, cf=3D0x7fffffffc7d0, xdf=3D0x7fffffffcaa8)
	    at /home/avar/g/libgit2/src/libgit2/xdiff/xprepare.c:194

IOW this was all seamlessly routed to your git__malloc() without us
having to maintain an xdl_{malloc,free}().

Now, I think that's obviously worth adjusting, e.g. the series I've got
here could make this easier for libgit2 by including st_mult() at least,
I'm not sure what you want to do about regexec_buf().

For the monkeypatching you do now of creating a "git-xdiff.h" I think it
would be very good to get a patch like what I managed to get
sha1collisiondetection.git to accept for our own use-case, which allows
us to use their upstream code as-is from a submodule:

	https://github.com/cr-marcstevens/sha1collisiondetection/commit/b45fcef
