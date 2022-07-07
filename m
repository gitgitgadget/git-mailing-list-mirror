Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA34C433EF
	for <git@archiver.kernel.org>; Thu,  7 Jul 2022 11:45:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235430AbiGGLpZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jul 2022 07:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235412AbiGGLpX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jul 2022 07:45:23 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1424F67C
        for <git@vger.kernel.org>; Thu,  7 Jul 2022 04:45:22 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id dn9so26658435ejc.7
        for <git@vger.kernel.org>; Thu, 07 Jul 2022 04:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=9H8MaeDNNrvuHrbw1/66RTPOUEpJ9RRnYDo1WeEdgGA=;
        b=kOlA7MdXFhBktxX1SZofxNtAoVkd5WKRDxtzllGq5iopLk7Zq+G8XgHG/P55m12Prt
         XLYGfbVhcF5sOJEAeFWe7sOuMPxoZ1F4JzqHipj7wSVvFpQZP6JYFEygbs8ASzGYEVBp
         I6veOycn6hoJps/xevNayllmGtxEs56KSIN3la7Si1G+klEgVX9IruqdZ2k7oPBkhUuu
         FVeFtMU+aAJkiW6kDbYdNjgeT8MxxVMimR10i8A9oHWvCguVNOIoE/gwWQvZNNeL3/Wf
         VAIctUA9upNc2LANWa6E1V1hAqineVDSOIsUlyOBSmF5r0HcHtL9iC+y5tvfu4D13hJE
         QQYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=9H8MaeDNNrvuHrbw1/66RTPOUEpJ9RRnYDo1WeEdgGA=;
        b=Zs/JeJBE8mQwUHcMZ2sHNVgL7Xfx1PDB8C+A2eyUpEmYmrSlIPZKStOVRnAVltHb4H
         ygws20tNVEtTFVYbmDxhapZ+smft6mCDfwvts3DZXY7Sz3WOMEOX7VxsbC6yVgQ6SETa
         4grFJCf+OFzBBRHPMDdXbRGFD3zhmNy8gWVAjhuPgwex2zBJHLib4hkkV8xxfKV+ONL5
         1Q0rSRU8yk/8/4voSUEm3WJF80OV0P9CromsErf1ttEehsdOfgm6MhZQGlR46xw8HZ88
         PjTEmbQ8SVyj42gNkZ8KaXsRULppKkwYDKQdBpCKzhzLdKJeBMw99/t9DggcIUT/9vhn
         G/aw==
X-Gm-Message-State: AJIora+Shixam2D2ZBZ9CCI5hthK1c5xqYg+Cu/lBHS7/EhH+xcBOGAb
        lddqF0a48XpitwwcdKJrKTY=
X-Google-Smtp-Source: AGRyM1uVLUf7ojZYhhT0d9kLAqK4fwnfXBBBlJ6XL7xCpS6U0NK/5SvVh7bh8zyYPYWZOYrMYcU/rA==
X-Received: by 2002:a17:907:7b95:b0:6f4:ff03:981a with SMTP id ne21-20020a1709077b9500b006f4ff03981amr44202425ejc.653.1657194321063;
        Thu, 07 Jul 2022 04:45:21 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id y14-20020a170906448e00b0072737733f9asm12199929ejo.106.2022.07.07.04.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 04:45:20 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o9Pwd-004G02-L3;
        Thu, 07 Jul 2022 13:45:19 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     phillip.wood@dunelm.org.uk,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 3/3] xdiff: introduce XDL_ALLOC_GROW()
Date:   Thu, 07 Jul 2022 13:17:35 +0200
References: <pull.1272.git.1656516334.gitgitgadget@gmail.com>
 <da996677f0730ec7a50d399524fb58c44dad468a.1656516334.git.gitgitgadget@gmail.com>
 <220630.86czeqe74c.gmgdl@evledraar.gmail.com>
 <5734b393-57c8-dc63-282e-221ee1937351@gmail.com>
 <0a1650bf-a7f5-0cc5-e6c9-0e02d1f542bf@gmail.com>
 <220630.86zghuclzq.gmgdl@evledraar.gmail.com>
 <fa543f66-6e86-9f95-f164-20a68705cecd@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <fa543f66-6e86-9f95-f164-20a68705cecd@gmail.com>
Message-ID: <220707.8635fd9meo.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jul 06 2022, Phillip Wood wrote:

> Hi =C3=86var
>
> On 30/06/2022 14:25, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Thu, Jun 30 2022, Phillip Wood wrote:
>>=20
>>> On 30/06/2022 13:03, Phillip Wood wrote:
>>>> On 30/06/2022 11:54, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>>>>
>>>>> On Wed, Jun 29 2022, Phillip Wood via GitGitGadget wrote:
>>>>>
>>>>>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>>>>>
>>>>>> Add a helper to grow an array. This is analogous to ALLOC_GROW() in
>>>>>> the rest of the codebase but returns =E2=88=921 on allocation failur=
e to
>>>>>> accommodate other users of libxdiff such as libgit2.
>>>>>
>>>>> Urm, does it? I just skimmed this, so maybe I missed something, but I
>>>>> don't see where you changed the definition of xdl_malloc(),
>>>>> xdl_realloc() etc.
>>>
>>> Oh I think I might have misunderstood your question. For git.git it
>>> will still die() but for other users that arrange for xdl_realloc() to
>>> return NULL on failure it will return -1. The same applies to the
>>> comments in the previous two patches about XDL_[CM]ALLOC_ARRAY()
>>> returning NULL on allocation failure.
>> Yes, I meant that the "but returns =E2=88=921 on allocation failure to
>> accommodate other users of libxdiff such as libgit2" is really more of
>> a:
>> 	...but *allows for* dropping in another xmalloc(), xrealloc()
>> 	etc. implementation that doesn't die on failure.
>> So I think the rest of my upthread question still stands, i.e.:
>> 	"So if that's the plan why would we need an XDL_ALLOC_ARRAY(),
>> 	can't you just check that it [I mean ALLOC_ARRAY()] returns
>> 	non-NULL?"
>> I.e. if the plan is to replace the underlying x*() functions with
>> non-fatal variants can't you use ALLOC_ARRAY() instead? I haven't tried
>> that, but I don't see a reason we couldn't do that in principle...
>
> As the cover letter says, the aim of this series is not to replace
> xmalloc() etc with non-fatal variants, it is just to make the xdiff
> code more readable.

I don't think it's more readable to carry code in-tree that's
unreachable except when combined with code out-of-tree. I.e. this series
leaves us with the equivalent of:

	ptr =3D xmalloc(...);
        if (!ptr)
		/* unreachable in git.git ... */

I don't think it's more readable to have code that rather trivial
analysis will show goes against the "__attribute__((noreturn))" we're
placing on our die() function.

Which is what I'm pointing out with "running with scissors". I.e. I'm
fully on-board with the end goal, but that can be accomplished in a way
that doesn't confuse humans & analyzers alike.

> (One can already use a non-fatal allocation
> function for xdl_malloc()) [...]

That just seems inviting a segfault or undefined/untested behavior
(whether in the sense of "undefined by C" or "untested by git.git's
codebase logic"). Everything around xmalloc() now assumes "never returns
NULL", and you want to:

 * Make it return NULL when combined with out-of-tree-code
 * Maintain the code in git.git, where it never returns NULL, but in a
   way where we won't have bugs when combined with a new macro that
   behaves differently, in a way we never even test ourselves.

Isn't that correct, or am I missing something?

> I don't think that using ALLOC_ARRAY() in
> xdiff is helpful for other users as they would have to define their
> own array allocation macros, rather than just providing their own
> allocation functions. I would like to reduce the friction others have
> upstreaming xdiff patches to us, not increase it.

Yes, I'm totally on-board with reducing the friction in others using
xdiff, and would like to see more of that sort of out-of-tree use in
general (although for things outside of xdiff GPL v.s. LGPL concerns
come into play).

I'd even like for us to explicitly make that much easier. I.e. if you
want to use xdiff now you search for it, and find the at this point
unmaintained upstream, and if you find that git has a "newer" version
you'll have some trouble extracting it already.

After this series you'll need to start writing & maintaining your own
non-trivial alloc wrapper logic if you're doing that. If you get it
subtly wrong you'll have a buggy xdiff, and most likely users will just
copy/paste the git.git version from our git-compat-util.h & cache.h,
which is rather silly.


Which is why I'm saying we could/should do this in a much easier way,
i.e.:

 * Factor out the now only-fatal-on-NULL ALLOC_GROW() such that we can
   have a non-fatal version (ALLOC_GROW) and a non-fatal one.

   I don't know what we'd call it. we usually have X*() meaning "fatal",
   but these are fatal by default, maybe G* for gently? So
   GALLOC_GROW().  Urgh, anyway, continuing with that ugly name...

 * Have xdiff/ use that GALLOC_GROW() & malloc(), not ALLOC_GROW() &
   xmalloc(), as we really want to have the appropriate code flow
   analysis etc. spot for us that we should handle NULL returns,
   otherwise combining this code with libgit2 will be buggy/broken.

This makes it much easier for libgit2 to use this, as it won't need to
do anything special at all. Since our GALLOC_GROW() will eventualy use
malloc() instead of xmalloc() you don't need to define anything that
re-implements the GALLOC_GROW() or whatever other non-fatal versions of
our only-fatal helpers we have.

This assumes that we'd move these macros out of git-compat-util.h and a
new git-exernal-compat.h, or that instead of *just* copying the xdiff/
directory your import script would need to run some small bit of cc -E
and or perl/sed to one-off extract the smell bits of
git-exernal-compat.h or cache.h that we need.
