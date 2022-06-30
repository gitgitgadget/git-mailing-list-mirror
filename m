Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE0EC43334
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 13:35:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233029AbiF3Nfm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 09:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232771AbiF3Nfl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 09:35:41 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFFA528E0F
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 06:35:39 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id r18so18735257edb.9
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 06:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=D1uR4q5vQcj/ACZ90xq52MEXs8EzZfTS/7C1TTfw1M0=;
        b=NHVLn8t3OM5zEVBKxbf4M4KINr22BnQRyC9GYBhaqwg7pBxXS8yavxIv7J7fyJJewH
         PbOBXsHja28kNW4K/Z4QPz6tRND3yr8qjGgjsjdMRjvgK4QjjTtBFCgsUY6g12pXsd8W
         Xq/ZlAEWNi9+roIC++B0b1vrx6Lknni7SV1BGVx4zO9O0/UGdp9rF2Si26wSKn7YUhRc
         liyFOzB9706QRo+pTth9uUZxYic3XPg69Bbh1kUN8dR1rj3A20JgRTzqXfSuV9pmjCGa
         2fG+0AJhPaAnLeyySEtXONfEzW3va4AdTaINBuZ9mMQ2ZE5pFVrhRvXPAmr4x4ejgV1Y
         qP7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=D1uR4q5vQcj/ACZ90xq52MEXs8EzZfTS/7C1TTfw1M0=;
        b=t4Hbds7tmLKyC6Zn+HV1miVu0y3MhVSvrNeu07g4sRwiquY+LyhnPxP4sZEjVy/ynd
         +4hBw5WJhDFYZCOZXgLk5VoIKk7eARYrF8Y7NeJ0LGraz1y8iJ44yIDdp1L5l4Y9SuLP
         ocPNmFOeJ2Rv7FEwV3EofahUoeJ7rAx+AXL1Z5JsFAH6Jruvdz5KTSDlPpfbWasQOok1
         vAdLtsXJc04ewljY9BziAiybmm3dO+IMrWs44C/nZrvQJU0Sn1LNj3IqwioQ09mnF1FS
         8WI0aqypjXTyaEw8sgnNOZjDtm3NbB2HL7S3OFLzhik9dQuMNFTEBFNLHFeRkkBqmo+2
         KwpA==
X-Gm-Message-State: AJIora/LdRo4K839OeDbYwGes9h3Wk4jEssjp2N0FUMaRObAS8hok4gC
        +rFBA6zwKhQrVK3uj47VdViwsbkqvNjfLg==
X-Google-Smtp-Source: AGRyM1uokqqUqvpn7xMDMZkgE2/Rd5n3mHRKOovMVksWQIilckcwiDiBelsPYBvKW2Z/bWz+82kn/g==
X-Received: by 2002:a05:6402:1597:b0:435:88fb:5b1d with SMTP id c23-20020a056402159700b0043588fb5b1dmr11586284edv.316.1656596138444;
        Thu, 30 Jun 2022 06:35:38 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id b9-20020aa7d489000000b004358243e752sm13096639edr.5.2022.06.30.06.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 06:35:37 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o6uKX-002L9M-CN;
        Thu, 30 Jun 2022 15:35:37 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     phillip.wood@dunelm.org.uk,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 3/3] xdiff: introduce XDL_ALLOC_GROW()
Date:   Thu, 30 Jun 2022 15:25:46 +0200
References: <pull.1272.git.1656516334.gitgitgadget@gmail.com>
 <da996677f0730ec7a50d399524fb58c44dad468a.1656516334.git.gitgitgadget@gmail.com>
 <220630.86czeqe74c.gmgdl@evledraar.gmail.com>
 <5734b393-57c8-dc63-282e-221ee1937351@gmail.com>
 <0a1650bf-a7f5-0cc5-e6c9-0e02d1f542bf@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <0a1650bf-a7f5-0cc5-e6c9-0e02d1f542bf@gmail.com>
Message-ID: <220630.86zghuclzq.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jun 30 2022, Phillip Wood wrote:

> On 30/06/2022 13:03, Phillip Wood wrote:
>> On 30/06/2022 11:54, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>>
>>> On Wed, Jun 29 2022, Phillip Wood via GitGitGadget wrote:
>>>
>>>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>>>
>>>> Add a helper to grow an array. This is analogous to ALLOC_GROW() in
>>>> the rest of the codebase but returns =E2=88=921 on allocation failure =
to
>>>> accommodate other users of libxdiff such as libgit2.
>>>
>>> Urm, does it? I just skimmed this, so maybe I missed something, but I
>>> don't see where you changed the definition of xdl_malloc(),
>>> xdl_realloc() etc.
>
> Oh I think I might have misunderstood your question. For git.git it
> will still die() but for other users that arrange for xdl_realloc() to
> return NULL on failure it will return -1. The same applies to the
> comments in the previous two patches about XDL_[CM]ALLOC_ARRAY()
> returning NULL on allocation failure.

Yes, I meant that the "but returns =E2=88=921 on allocation failure to
accommodate other users of libxdiff such as libgit2" is really more of
a:

	...but *allows for* dropping in another xmalloc(), xrealloc()
	etc. implementation that doesn't die on failure.

So I think the rest of my upthread question still stands, i.e.:

	"So if that's the plan why would we need an XDL_ALLOC_ARRAY(),
	can't you just check that it [I mean ALLOC_ARRAY()] returns
	non-NULL?"

I.e. if the plan is to replace the underlying x*() functions with
non-fatal variants can't you use ALLOC_ARRAY() instead? I haven't tried
that, but I don't see a reason we couldn't do that in principle...

Anyway, I'm all for the end goal here, but the way to get there seems to
be a bit of an exercise in running with scissors the more I think about
it.

I.e. the reason we're using these x*alloc() wrappers at all is because
we're lazy and want to write stuff like:

	struct stuff *foo =3D xmalloc(...);
	foo->bar =3D "baz";

Which the compiler is helpfully not yelling at us about, as opposed to
doing the same with "malloc()", where it would spot the potential null
pointer dereference.

(I'm using "compiler" here to be inclusive of extended gcc/clang options
to detect this sort of thing, & other similar analyzers).

But re "scissors": if we're doing to be maintaining the xdiff code
in-tree to be defined as our usual x*alloc() functions we're going to be
carrying code that can't have test or analysis coverage.

Which I think brings me back to my suggestion of whether we can't just
have non-fatal versions of these helper macros, define our own currently
fatal versions in terms of those, and use the non-fatal versions in the
xdiff/ code.


