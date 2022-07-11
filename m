Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D1EC43334
	for <git@archiver.kernel.org>; Mon, 11 Jul 2022 09:56:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234141AbiGKJ4P (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jul 2022 05:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234099AbiGKJzm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jul 2022 05:55:42 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F631B1971
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 02:26:24 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id v14so6180791wra.5
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 02:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jmCETG4FXfKC1VEEaEHZtC5kbFOUHIzP81CzjGlltnA=;
        b=MZB0VAxLwACFVi8iUkVTpfJ0e6eJBQr4UQ6Y/ooWI9lMp06SkeWqzF2SxPhUFRzFZC
         eWxUnd/yoL5SnRn0H7nsw4lBKLS0kBk4NVNCgC/tJGoieXyzQn9ccpTYZ2eVzLhH1ms2
         3JnH6Rq7SlPTlgvn5NjEyEYDNTQKweDOPOXquDghSofF36sd5x2lhoFcPZxMbA3IpfOr
         vkQwbwz2PV5+a7KnUMwKU+XESMjxeJ7rj1Kk7CzCj5fp6EhUAuYguD6/AsPNbAtS3Kes
         3K9WSIVARfRK6nlSPLsHYnq0YSz9cmZ1pBEWPX9u5/SOQeTbgdDjBdxUrknr3B67awEX
         4Alw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jmCETG4FXfKC1VEEaEHZtC5kbFOUHIzP81CzjGlltnA=;
        b=m+IYwrLIiyPl9Gs/ilBT5/vuTVkf8GFEQqIdjr05lc4pBny4l7XSpj/Ol/nMtCLzmG
         ATDIsQUNxCRvMbsmEvRgPzhdx5iR56TxtUibEeWy0TZr4mgvRNNtyLB+4w9z+TvFacme
         cxkAdesZ6nde3XQcP7t3bg/Th1k4tV6fqgca8L8m/B+kpXq5Ma/ALslkoywAVFdU4Mew
         /xWydPYHr9R9RRlhAoF7rvx7pp6f5IbRpxBnphDs62Y8LJeeuwuinCsxbYVjB1glv8I4
         y8aCF+bejCzcaaQBG3t41EyL5XlAf0zGwuDQ3uqWLxIJfY8Ul2jYy1rbSRmlxx0Sg8Qu
         X+Lw==
X-Gm-Message-State: AJIora/BuRBiI029Q9ExVUqhzjKpUbv1tPXm/k5rZjcOdQWhh67koYtv
        puddmHJh0Q8v7SQx96NumXMunUqMhAk=
X-Google-Smtp-Source: AGRyM1uo5HFBb2IvZuFzOxQxlqLWSAkFefNIPWAgjfYevCHRMbYthaqnBGKCU7BLtMInFBqGPa6Y4Q==
X-Received: by 2002:adf:e30b:0:b0:21d:8f3e:a370 with SMTP id b11-20020adfe30b000000b0021d8f3ea370mr15610334wrj.124.1657531581908;
        Mon, 11 Jul 2022 02:26:21 -0700 (PDT)
Received: from [192.168.1.201] ([31.185.185.192])
        by smtp.googlemail.com with ESMTPSA id n3-20020a7bcbc3000000b003a05621dc53sm6162521wmi.29.2022.07.11.02.26.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 02:26:21 -0700 (PDT)
Message-ID: <dcde61a3-4d96-6cd5-f05e-45781599f8bd@gmail.com>
Date:   Mon, 11 Jul 2022 10:26:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 7/7] xdiff: remove xdl_free(), use free() instead
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
References: <b34dcb93-df73-f5de-3c7c-7ab6c3250afe@gmail.com>
 <cover-0.7-00000000000-20220708T140354Z-avarab@gmail.com>
 <patch-7.7-a1bf9a94f0a-20220708T140354Z-avarab@gmail.com>
 <6b8fc0e8-c446-1275-12f3-e6520de9584d@gmail.com>
 <220708.86czef9t6y.gmgdl@evledraar.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <220708.86czef9t6y.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar

On 08/07/2022 22:26, Ævar Arnfjörð Bjarmason wrote:
> 
> On Fri, Jul 08 2022, Phillip Wood wrote:
> 
>> Hi Ævar
>>
>> On 08/07/2022 15:20, Ævar Arnfjörð Bjarmason wrote:
>>> Remove the xdl_free() wrapper macro in favor of using free()
>>> directly. The wrapper macro was brought in with the initial import of
>>> xdiff/ in 3443546f6ef (Use a *real* built-in diff generator,
>>> 2006-03-24).
>>> As subsequent discussions on the topic[1] have made clear there's no
>>> reason to use this wrapper.
>>
>> That link is to a message where you assert that there is no reason for
>> the wrapper, you seem to be the only person in that thread making that
>> argument. The libgit2 maintainer and others are arguing that it is
>> worth keeping to make it easy to swap the allocator.
> 
> Arguing that it's not needed for a technical reason, but an "aesthetic
> and ergonomic one", per:
> https://lore.kernel.org/git/20220217225804.GC7@edef91d97c94/;
> 
> Perhaps I misread it, but I took this as Junio concurring with what I
> was pointing out there:
> https://lore.kernel.org/git/xmqqfsohbdre.fsf@gitster.g/
> 
>>> Both git itself as well as any external
>>> users such as libgit2 compile the xdiff/* code as part of their own
>>> compilation, and can thus find the right malloc() and free() at
>>> link-time.
>>
>> I'm struggling to see how that is simpler than the current situation
>> with xdl_malloc().
> 
> It's simpler because when maintaining that code in git.git it's less of
> a special case, e.g. we have coccinelle rules that match free(), now
> every such rule needs to account for the xdiff special-case.
> 
> And it's less buggy because if you're relying on us always using a
> wrapper bugs will creep in, current master has this:
> 	
> 	$ git -P grep '\bfree\(' -- xdiff
> 	xdiff/xdiff.h:#define xdl_free(ptr) free(ptr)
> 	xdiff/xmerge.c:         free(c);
> 	xdiff/xmerge.c: free(next_m);
> 
>> Perhaps you could show how you think libgit2 could
>> easily make xdiff use git__malloc() instead of malloc() without
>> changing the malloc() calls (the message you linked to essentially
>> suggests they do a search and replace). If people cannot swap in
>> another allocator without changing the code then you are imposing a
>> barrier to them contributing patches back to git's xdiff.
> 
> I was suggesting that if libgit2 wanted to maintain a copy of xdiff that
> catered to the asthetic desires of the maintainer adjusting whatever
> import script you use to apply a trivial coccinelle transformation would
> give you what you wanted. Except without a maintenance burden on
> git.git, or the bugs you'd get now since you're not catching those two
> free() cases (or any future such cases).
> 
> But just having the code use malloc() and free() directly and getting
> you what you get now is easy, and doesn't require any such
> search-replacement.
> 
> Here's how:
> 
> I imported the xdiff/*.[ch] files at the tip of my branch into current
> libgit2.git's src/libgit2/xdiff/, and then applied this on top, which is
> partially re-applying libgit2's own monkeypatches, and partially
> adjusting for upstream changes (including this one):
> 	
> 	diff --git a/src/libgit2/xdiff/git-xdiff.h b/src/libgit2/xdiff/git-xdiff.h
> 	index b75dba819..2e00764d4 100644
> 	--- a/src/libgit2/xdiff/git-xdiff.h
> 	+++ b/src/libgit2/xdiff/git-xdiff.h
> 	@@ -14,6 +14,7 @@
> 	 #ifndef INCLUDE_git_xdiff_h__
> 	 #define INCLUDE_git_xdiff_h__
> 	
> 	+#include <regex.h>
> 	 #include "regexp.h"
> 	
> 	 /* Work around C90-conformance issues */
> 	@@ -27,11 +28,10 @@
> 	 # endif
> 	 #endif
> 	
> 	-#define xdl_malloc(x) git__malloc(x)
> 	-#define xdl_free(ptr) git__free(ptr)
> 	-#define xdl_realloc(ptr, x) git__realloc(ptr, x)
> 	+#define malloc(x) git__malloc(x)
> 	+#define free(ptr) git__free(ptr)
> 	
> 	-#define XDL_BUG(msg) GIT_ASSERT(msg)
> 	+#define BUG(msg) GIT_ASSERT(msg)
> 	
> 	 #define xdl_regex_t git_regexp
> 	 #define xdl_regmatch_t git_regmatch
> 	@@ -50,4 +50,17 @@ GIT_INLINE(int) xdl_regexec_buf(
> 	 	return -1;
> 	 }
> 	
> 	+static inline size_t st_mult(size_t a, size_t b)
> 	+{
> 	+	return a * b;
> 	+}
> 	+
> 	+static inline int regexec_buf(const regex_t *preg, const char *buf, size_t size,
> 	+			      size_t nmatch, regmatch_t pmatch[], int eflags)
> 	+{
> 	+	assert(nmatch > 0 && pmatch);
> 	+	pmatch[0].rm_so = 0;
> 	+	pmatch[0].rm_eo = size;
> 	+	return regexec(preg, buf, nmatch, pmatch, eflags | REG_STARTEND);
> 	+}
> 	 #endif
> 	diff --git a/src/libgit2/xdiff/xdiff.h b/src/libgit2/xdiff/xdiff.h
> 	index a37d89fcd..5e5b525c2 100644
> 	--- a/src/libgit2/xdiff/xdiff.h
> 	+++ b/src/libgit2/xdiff/xdiff.h
> 	@@ -23,6 +23,8 @@
> 	 #if !defined(XDIFF_H)
> 	 #define XDIFF_H
> 	
> 	+#include "git-xdiff.h"
> 	+
> 	 #ifdef __cplusplus
> 	 extern "C" {
> 	 #endif /* #ifdef __cplusplus */
> 	diff --git a/src/libgit2/xdiff/xinclude.h b/src/libgit2/xdiff/xinclude.h
> 	index a4285ac0e..79812ad8a 100644
> 	--- a/src/libgit2/xdiff/xinclude.h
> 	+++ b/src/libgit2/xdiff/xinclude.h
> 	@@ -23,7 +23,8 @@
> 	 #if !defined(XINCLUDE_H)
> 	 #define XINCLUDE_H
> 	
> 	-#include "git-compat-util.h"
> 	+#include "git-xdiff.h"
> 	+#include "git-shared-util.h"
> 	 #include "xmacros.h"
> 	 #include "xdiff.h"
> 	 #include "xtypes.h"
> 
> If you then build it and run e.g.:
> 
> 	gdb -args ./libgit2_tests -smerge::files
> 
> You'll get stack traces like this if you break on stdalloc__malloc
> (which it uses for me in its default configuration):
> 	
> 	(gdb) bt
> 	#0  stdalloc__malloc (len=144, file=0x87478d "/home/avar/g/libgit2/src/libgit2/xdiff/xutils.c", line=101) at /home/avar/g/libgit2/src/util/allocators/stdalloc.c:14
> 	#1  0x00000000006ec15c in xdl_cha_alloc (cha=0x7fffffffcaa8) at /home/avar/g/libgit2/src/libgit2/xdiff/xutils.c:101
> 	#2  0x00000000006eaee9 in xdl_prepare_ctx (pass=1, mf=0x7fffffffcc98, narec=13, xpp=0x7fffffffcca8, cf=0x7fffffffc7d0, xdf=0x7fffffffcaa8)
> 	    at /home/avar/g/libgit2/src/libgit2/xdiff/xprepare.c:194
> 
> IOW this was all seamlessly routed to your git__malloc() without us
> having to maintain an xdl_{malloc,free}().

Thanks for showing this, it is really helpful to see a concrete example. 
I was especially interested to see how you went about the conversion 
without redefining standard library functions or introducing 
non-namespaced identifiers in files that included xdiff.h. Unfortunately 
you have not done that and so I don't think the approach above is viable 
  for a well behaved library.

> Now, I think that's obviously worth adjusting, e.g. the series I've got
> here could make this easier for libgit2 by including st_mult() at least,
> I'm not sure what you want to do about regexec_buf().
> 
> For the monkeypatching you do now of creating a "git-xdiff.h" I think it
> would be very good to get a patch like what I managed to get
> sha1collisiondetection.git to accept for our own use-case, which allows
> us to use their upstream code as-is from a submodule:
> 
> 	https://github.com/cr-marcstevens/sha1collisiondetection/commit/b45fcef

Thanks for the link, That's a really good example where all the 
identifiers are namespaced and the public include file does not pollute 
the code that is including it. If you come up with something like that 
where the client code can set up same #defines for malloc, calloc, 
realloc and free that would be a good way forward. I do not think we 
should require projects to be defining there own versions of 
[C]ALLOC_*() and BUG() just to use xdiff.

Best Wishes

Phillip

