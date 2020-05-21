Return-Path: <SRS0=Ny9l=7D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF5EFC433DF
	for <git@archiver.kernel.org>; Thu, 21 May 2020 04:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76D4D207F9
	for <git@archiver.kernel.org>; Thu, 21 May 2020 04:30:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=iskunk.org header.i=@iskunk.org header.b="QmUdlLsW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KHoRPkzK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbgEUEaR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 May 2020 00:30:17 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:46309 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726282AbgEUEaR (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 21 May 2020 00:30:17 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 36A1F109A;
        Thu, 21 May 2020 00:30:14 -0400 (EDT)
Received: from imap36 ([10.202.2.86])
  by compute7.internal (MEProxy); Thu, 21 May 2020 00:30:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iskunk.org; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm3; bh=r7Nac3Ckfh79Cs8dhnW8af+wAVvrbQs
        ip5pUYD8qJTY=; b=QmUdlLsWasmKD5BrPK3Qj1FhYtwhj6llFlIg9M8RKYsCtlQ
        KQrV754LsUZ6rRiyKMqRfLj3qD2J/YQNahQS7ZH//zeyNXUndOwxQwcy0Wdkk17C
        8z0YjH1Mct4G4Y9JSD/Rwti4ft7rLKx5cTtbeopBSiqA+bEM/tMua1JCxRYvEgo3
        EGhaCUofqmXD/D3rYi7ZYWUVvB0+XOmKV8DeJhlIDpqNupv/wdl9f96r9ZYhBVm0
        N195vyvqH4NMcUp+IGMPWqcel7I80Z/EJI10N2VJmDygQw3OT7l5mAo/9KaNmobn
        GIeGPwBvh4gJUarmo3SGCRT1E9kwqhlTKM8uK4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=r7Nac3
        Ckfh79Cs8dhnW8af+wAVvrbQsip5pUYD8qJTY=; b=KHoRPkzK4K3JwsO6p2jeiJ
        XjBvmU3JQy6ppTRQc1lo8W9yKPQibOSQu5GrP9DooojN9Lt6CdsmXZww8sRjzr5Y
        nUoIBSGiwxqEe3AMONr/isHW0rPHoUJd4TBa4HWdnqcYHo6Kz/jHyLDvUZvgiWVT
        QKVeCa8OMxld3K5ZKXhedtF+pSCJi57bovSVu5mSbFBNsdgjtGB2jNASh5AHqLWB
        5WlLPmsAUsMOhxqrLV7gQeK4wk60B+G8/Env0S4yf6u+zMgUK8xcOZ3BfajysKdE
        UIcLI18/t7Gz8aP/VVmq0nI/SwTKw3XwFL9dVNGguDsi04HzOKD3YTeowX/BLNeQ
        ==
X-ME-Sender: <xms:1QPGXjhwZAYp22BPZj8OAW3UPeVQMq7B8iiDUGgxAlp2AeMi5XFsLQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddutddgkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfgjfhffhffvufgtsehttd
    ertderredtnecuhfhrohhmpedfffgrnhhivghlucftihgthhgrrhguucfirddfuceoshhk
    uhhnkhesihfumfgfpffmrdfqtffiqeenucggtffrrghtthgvrhhnpeekvdehgeegvedtje
    egudelvdeghfejuddujeekhfethfdtfedvieekgfejgffhueenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehskhhunhhksehiuffmfgfpmfdrqf
    ftif
X-ME-Proxy: <xmx:1QPGXgA0LEF1mNZbUbvpG6U1Jhyu6OQ3y1ZCp-9mwln8GXnKhwTuAw>
    <xmx:1QPGXjF86l2-cc9_khVc3Qz8P-_8CyHBYbqsK71TJstU_CrmsTl1Sw>
    <xmx:1QPGXgRTeugdGdW87qVDvHwl8avy_Boq6747q-XKQ-tNH3tnUBb86g>
    <xmx:1QPGXv-pDcFLwdJrewYYxFbo2bnvIbCBRh0vS_bFnqtbw8D4S8c6cg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 0E847188006D; Thu, 21 May 2020 00:30:12 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.3.0-dev0-487-g38013f6-fm-20200519.001-g38013f6c
Mime-Version: 1.0
Message-Id: <86f751ac-b7c1-43fd-ada5-a8e2e9c4ebc9@www.fastmail.com>
In-Reply-To: <20200520042838.GA102274@coredump.intra.peff.net>
References: <7422404e-7fc8-4961-aae4-3f0adb71bb3a@www.fastmail.com>
 <20200519024945.GB70483@coredump.intra.peff.net>
 <40a42f1d-61bd-46fb-8946-5588df7b044b@www.fastmail.com>
 <20200520042838.GA102274@coredump.intra.peff.net>
Date:   Thu, 21 May 2020 00:29:18 -0400
From:   "Daniel Richard G." <skunk@iSKUNK.ORG>
To:     "Jeff King" <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: Minor portability issues + fixes
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 2020 May 20 00:28-04:00, Jeff King wrote:
>
> > I've confirmed that this works. But would it not be safe to #include
> > both inttypes.h and stdint.h explicitly if both are present, rather than
> > cater to AIX specifically? I could see this similarly arising in, say,
> > an old version of Solaris.
> 
> Yes, as long as we check that both are present, I think that would do
> the right thing. And the autoconf check could cover that. I don't think
> there's an easy way to have a general Makefile knob that can check which
> files are present, though (and we generally consider the Makefile and
> its knobs to be the primary mechanism; autoconf to turn those knobs is
> generally implemented on top).

Okay, I see, so the whole phalanx of HAVE_BLAH_H symbols from Autoconf
isn't available.

> So probably we'd want something like (in this order):
> 
>   - NEEDS_EXPLICIT_STDINT gets passed from the Makefile into the
>     compiler via -D, which then triggers stdint.h being included
>     unconditionally in git-compat-util.h
> 
>   - optionally set that in config.mak.uname for AIX (checking uname_R
>     since it sounds like only old versions need it)
> 
>   - add an autoconf rule that sets it, either strictly (when a
>     test-program decides it's needed) or loosely (when we see that it's
>     available at all)
> 
> Even just the first one would let you build by setting the knob
> manually; the rest is gravy on top, if you or somebody else chooses to
> do it.

Hmm... that's a fairly specific knob, which I would think is less than
ideal. The rest is reasonable, but would have to be written in terms
of the knob.

I can put something together, knowing that this is the approach you'd
want to see, but it'll need some more work. Eventually, I'll need to get
Git up and running on a few other old systems I have here, so that will
undoubtedly figure into it.

Thanks for sketching out how this should work, however; this is helpful
to keep in mind.

> > The applicable value for CC_LD_DYNPATH on AIX is "-Wl,-blibpath:".
> > However, have a look at the description for this option in the
> > ld(1) man page:
> 
> OK, gross. :) I agree it's not worth going too far into this rabbit
> hole. I do wonder if you could just be using GNU ld along with gcc, but
> maybe that's not practical.

Using the GNU linker can help in some cases, and hurt in others. We try
to avoid it unless necessary.

> You should be able to build with:
> 
>   make CC_LD_DYNPATH=-L
> 
> as a workaround

Yep, this works handily as a no-op :)

> but it would be nice if the Makefile handled this correctly. It looks
> like CC_LD_DYNPATH gets used in a lot of places, so I suspect we'd
> want a Makefile function to help out. Something like:
> 
>   # usage: $(call linker_lib,PATH)
>   # Create linker args for looking for libraries in PATH at both link-time
>   # and run-time.
>   linker_lib = -L$1 $(if $(CC_LD_DYNPATH),$(CC_LD_DYNPATH)$1)
> 
> which would allow:
> 
>   EXTLIBS += $(call linker_lib,$(LIBPCREDIR)/$(lib))
> 
> etc. This would be our first foray into Makefile functions, but I think
> we've determined that most platforms have a recent enough GNU make for
> it to be OK (and we already require GNU make).

Why not just a variable to wrap the conditional? Something like

    CC_LD_DYNPATH_flag = $(if $(CC_LD_DYNPATH),$(CC_LD_DYNPATH),-L)

    ...

    EXTLIBS += -L$(ZLIB_PATH)/$(lib) $(CC_LD_DYNPATH_flag)$(ZLIB_PATH)/$(lib)

Makefile functions are quite powerful, but they feel like a sledgehammer
to this fly. (I've used them in the past to generate Make rules
programmatically. It wasn't pretty, but it sure beat writing out
makefile fragments and then include-ing them afterward!)


--Daniel


-- 
Daniel Richard G. || skunk@iSKUNK.ORG
My ASCII-art .sig got a bad case of Times New Roman.
