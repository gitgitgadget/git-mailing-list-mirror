Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4197C433EF
	for <git@archiver.kernel.org>; Fri,  8 Jul 2022 09:35:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237165AbiGHJfk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jul 2022 05:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234105AbiGHJfk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jul 2022 05:35:40 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E295C9D3
        for <git@vger.kernel.org>; Fri,  8 Jul 2022 02:35:39 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id b26so29770791wrc.2
        for <git@vger.kernel.org>; Fri, 08 Jul 2022 02:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2Zjw1XSHUXPnOqBYw8BiROrflI7csy0giaIEhlFk6No=;
        b=MwFrwMorJovNeMhjIlrfjnTTURz4D0X7ThakVqUTO2ejRi9CC12y1yhCHmxRkYJR4E
         EER2JJBaHoiqFihHflHLZ7AnUUFcrasITxBQadx4vdGZ7EiXpU3uP6ZoO7YbKgRFUnkV
         DzNH+IgGtgwZca8LQQGfgIJ+IDnDss+0PYAMc1umNFKlfdiZo44akM3plWs27jygK4w/
         e+AgruoFF0yC3QjBvn/Cah33OsrZeg7uQqKa0RnX9Qre/WLh4A/LML9/8f1Me4Ur1b0D
         RXWFI5ah5DhfrPBqvqWp6NluZw6lkeTzp7fdouoG+zdoVojWOxXNv2IdUZQWONqXLzJ8
         uImQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2Zjw1XSHUXPnOqBYw8BiROrflI7csy0giaIEhlFk6No=;
        b=5Bq83xv+ciPMqJP7+X2uoTHoCvXSlHHM/JrHW0bTxXJekYBTnnvR9REyeK9ypIYxBy
         lTxsd72zvuoDuuWO4J02QhC3VC3i5mpL/7BNOZUaakkNFINJHTrjLUznzV9EP+66crpT
         i0OQLJLIE/ujTK3mYLVqPXRY9wrywDJnaiVIadoFRq79gA3iADhDPjALwxUjnrlxTLx/
         kzFoGBchMyXiHBmZGTK8CbJxwcH1Qr3XPmSHoDMr9WY+omcpnmiiMKJiZ/bzCgTxaVaG
         vqpDsCEFhnV7AVzRzedMq0ODf288JnQyMTl5LeRBihUgXCrujfyBVJpnVnTS7TJ/KRmr
         MTww==
X-Gm-Message-State: AJIora93Ou5mUGMCp1nF1KcDfRkcdNzDhimqOcHxDo9ascaoJIXparf2
        proP4i2UFopo1kQYLCq4eFMF5+MBhuA=
X-Google-Smtp-Source: AGRyM1se6pPw0vwN2uD9OgWxjwhWletMJZHpPvnr/rTX7ooUOOFXzdp8lRYriQnrirPaBk2ZMUnqWQ==
X-Received: by 2002:adf:e112:0:b0:21d:7195:3a8d with SMTP id t18-20020adfe112000000b0021d71953a8dmr2467275wrz.371.1657272937329;
        Fri, 08 Jul 2022 02:35:37 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.192])
        by smtp.gmail.com with ESMTPSA id h8-20020adff4c8000000b0021d808826fbsm5315053wrp.44.2022.07.08.02.35.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jul 2022 02:35:36 -0700 (PDT)
Message-ID: <b34dcb93-df73-f5de-3c7c-7ab6c3250afe@gmail.com>
Date:   Fri, 8 Jul 2022 10:35:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 3/3] xdiff: introduce XDL_ALLOC_GROW()
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     phillip.wood@dunelm.org.uk,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
References: <pull.1272.git.1656516334.gitgitgadget@gmail.com>
 <da996677f0730ec7a50d399524fb58c44dad468a.1656516334.git.gitgitgadget@gmail.com>
 <220630.86czeqe74c.gmgdl@evledraar.gmail.com>
 <5734b393-57c8-dc63-282e-221ee1937351@gmail.com>
 <0a1650bf-a7f5-0cc5-e6c9-0e02d1f542bf@gmail.com>
 <220630.86zghuclzq.gmgdl@evledraar.gmail.com>
 <fa543f66-6e86-9f95-f164-20a68705cecd@gmail.com>
 <220707.8635fd9meo.gmgdl@evledraar.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <220707.8635fd9meo.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/07/2022 12:17, Ævar Arnfjörð Bjarmason wrote:
> 
> On Wed, Jul 06 2022, Phillip Wood wrote:
> 
>> Hi Ævar
>>
>> On 30/06/2022 14:25, Ævar Arnfjörð Bjarmason wrote:
>>> On Thu, Jun 30 2022, Phillip Wood wrote:
>>>
>>>> On 30/06/2022 13:03, Phillip Wood wrote:
>>>>> On 30/06/2022 11:54, Ævar Arnfjörð Bjarmason wrote:
>>>>>>
>>>>>> On Wed, Jun 29 2022, Phillip Wood via GitGitGadget wrote:
>>>>>>
>>>>>>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>>>>>>
>>>>>>> Add a helper to grow an array. This is analogous to ALLOC_GROW() in
>>>>>>> the rest of the codebase but returns −1 on allocation failure to
>>>>>>> accommodate other users of libxdiff such as libgit2.
>>>>>>
>>>>>> Urm, does it? I just skimmed this, so maybe I missed something, but I
>>>>>> don't see where you changed the definition of xdl_malloc(),
>>>>>> xdl_realloc() etc.
>>>>
>>>> Oh I think I might have misunderstood your question. For git.git it
>>>> will still die() but for other users that arrange for xdl_realloc() to
>>>> return NULL on failure it will return -1. The same applies to the
>>>> comments in the previous two patches about XDL_[CM]ALLOC_ARRAY()
>>>> returning NULL on allocation failure.
>>> Yes, I meant that the "but returns −1 on allocation failure to
>>> accommodate other users of libxdiff such as libgit2" is really more of
>>> a:
>>> 	...but *allows for* dropping in another xmalloc(), xrealloc()
>>> 	etc. implementation that doesn't die on failure.
>>> So I think the rest of my upthread question still stands, i.e.:
>>> 	"So if that's the plan why would we need an XDL_ALLOC_ARRAY(),
>>> 	can't you just check that it [I mean ALLOC_ARRAY()] returns
>>> 	non-NULL?"
>>> I.e. if the plan is to replace the underlying x*() functions with
>>> non-fatal variants can't you use ALLOC_ARRAY() instead? I haven't tried
>>> that, but I don't see a reason we couldn't do that in principle...
>>
>> As the cover letter says, the aim of this series is not to replace
>> xmalloc() etc with non-fatal variants, it is just to make the xdiff
>> code more readable.
> 
> I don't think it's more readable to carry code in-tree that's
> unreachable except when combined with code out-of-tree. I.e. this series
> leaves us with the equivalent of:
> 
> 	ptr = xmalloc(...);
>          if (!ptr)
> 		/* unreachable in git.git ... */
> 
> I don't think it's more readable to have code that rather trivial
> analysis will show goes against the "__attribute__((noreturn))" we're
> placing on our die() function.

We're already in this situation. The code in xdiff is written to handle 
allocation failures and we use an allocation function that dies instead. 
This patch series does nothing to alter that situation.

> Which is what I'm pointing out with "running with scissors". I.e. I'm
> fully on-board with the end goal, but that can be accomplished in a way
> that doesn't confuse humans & analyzers alike.
> 
>> (One can already use a non-fatal allocation
>> function for xdl_malloc()) [...]
> 
> That just seems inviting a segfault or undefined/untested behavior
> (whether in the sense of "undefined by C" or "untested by git.git's
> codebase logic"). Everything around xmalloc() now assumes "never returns
> NULL", and you want to:
> 
>   * Make it return NULL when combined with out-of-tree-code

No I do not want to alter the behavior of xmalloc() at all, that is why 
this series does not alter the behavior of xmalloc()

>   * Maintain the code in git.git, where it never returns NULL, but in a
>     way where we won't have bugs when combined with a new macro that
>     behaves differently, in a way we never even test ourselves.

That describes the current situation with xdiff, this series does not 
alter that.

> Isn't that correct, or am I missing something?

You should note that libgit2 uses malloc() as it's default allocator, 
seeming without issue.

>> I don't think that using ALLOC_ARRAY() in
>> xdiff is helpful for other users as they would have to define their
>> own array allocation macros, rather than just providing their own
>> allocation functions. I would like to reduce the friction others have
>> upstreaming xdiff patches to us, not increase it.
> 
> Yes, I'm totally on-board with reducing the friction in others using
> xdiff, and would like to see more of that sort of out-of-tree use in
> general (although for things outside of xdiff GPL v.s. LGPL concerns
> come into play).
> 
> I'd even like for us to explicitly make that much easier. I.e. if you
> want to use xdiff now you search for it, and find the at this point
> unmaintained upstream, and if you find that git has a "newer" version
> you'll have some trouble extracting it already.
> 
> After this series you'll need to start writing & maintaining your own
> non-trivial alloc wrapper logic if you're doing that. If you get it
> subtly wrong you'll have a buggy xdiff, and most likely users will just
> copy/paste the git.git version from our git-compat-util.h & cache.h,
> which is rather silly.

This series does not alter what wrappers you need to write whereas your 
suggestion of using ALLOC_ARRAY() would force more work on potential 
xdiff users (though below I think you're suggesting we provide them in a 
separate header so they can be reused more easily).

> Which is why I'm saying we could/should do this in a much easier way,
> i.e.:
> 
>   * Factor out the now only-fatal-on-NULL ALLOC_GROW() such that we can
>     have a non-fatal version (ALLOC_GROW) and a non-fatal one.
> 
>     I don't know what we'd call it. we usually have X*() meaning "fatal",
>     but these are fatal by default, maybe G* for gently? So
>     GALLOC_GROW().  Urgh, anyway, continuing with that ugly name...

Further proof that naming is hard...

>   * Have xdiff/ use that GALLOC_GROW() & malloc(), not ALLOC_GROW() &
>     xmalloc(), as we really want to have the appropriate code flow
>     analysis etc. spot for us that we should handle NULL returns,
>     otherwise combining this code with libgit2 will be buggy/broken.
> 
> This makes it much easier for libgit2 to use this, as it won't need to
> do anything special at all. Since our GALLOC_GROW() will eventualy use
> malloc() instead of xmalloc() you don't need to define anything that
> re-implements the GALLOC_GROW() or whatever other non-fatal versions of
> our only-fatal helpers we have.
> 
> This assumes that we'd move these macros out of git-compat-util.h and a
> new git-exernal-compat.h, or that instead of *just* copying the xdiff/
> directory your import script would need to run some small bit of cc -E
> and or perl/sed to one-off extract the smell bits of
> git-exernal-compat.h or cache.h that we need.

I think there is an argument that we should change our xdiff wrapper to 
use malloc() rather than xmalloc() so we're able to test the error 
handling. That then begs the question as to how we actually get the 
allocation functions to fail when they're being tested. I also think 
that is an orthogonal change that could happen with or without this 
patch series.

Best Wishes

Phillip
