Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09AF7C4361A
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 22:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C471E22CBE
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 22:21:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgLDWVj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 17:21:39 -0500
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:53495 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726810AbgLDWVj (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 4 Dec 2020 17:21:39 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 3C0E5A9C;
        Fri,  4 Dec 2020 17:20:53 -0500 (EST)
Received: from imap2 ([10.202.2.52])
  by compute1.internal (MEProxy); Fri, 04 Dec 2020 17:20:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sudoforge.com;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm2; bh=U18eUXDWY6OFCjTDm1XLgrbXLyl1
        ESC9ZdDxOPsPPuM=; b=yz+PyntPOLk7cMhFaLwv64uwMrdSZL9919KL365cT6o/
        2PhK1VuUs3+BbZZ9DjPJwepfHqHpJG/77AxxfhlG3JbLCGHY3FRoiJlluV7SBqWP
        GEmOScT1poiiD7OT1UKv5ArL4Xp5Hu3HQE1R+8Cru2PESA+v3K5Pj1VX168DG+xm
        XJg0P+PIDyObEXqpJYk9q90cTY1TRy1ucUKeIdDgYspV2xjBnRqQLm9tOybZ5Cwb
        IF2kjxreTeeo6AQLJ+9X1UmMhj1MeAvJ019/0Vw/m234oxZC50C0nCv4bEkigeg2
        f60SDv7LMkMq5CFheb8D30rRpp01nGhhDMD18fd+bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=U18eUX
        DWY6OFCjTDm1XLgrbXLyl1ESC9ZdDxOPsPPuM=; b=Ksn4v7lj/M02LP6goIDqUH
        z/NOrX/A7OADZlHGmucqkKVva1+dnQgKt7OJvDTvROYTi4xFQEC/Syaw78Gs+5ok
        nkZb7S5QKtJUCcIuXrf0tRExdpFvJFOWaW1d+KjSzCFulF/cEBjnnDdeg3TzNNi6
        qZSySsHKFvG/JOPuTXJ5/MJwevEWRNidlIvWBeIKS4aXJA90GyNoqp7HHSbdgKBS
        kI+ScD/Jd4cgFC/vdCWSCDnBh63rYLEuXfJM2F8Ef+eHmun8dsYgyMuZJVyIrhMw
        zIxN5kM5r5shLII9GYEF+o2Z4o3IxR7nI12lJxXULscRVRI51SMJheUX+kMB1nfw
        ==
X-ME-Sender: <xms:RLbKX0jvdYRBaUy1nu3Ggbbeagv3rzKCkRltmgCHKjGg1OjxiV5nbQ>
    <xme:RLbKX9Cth6k-ACXF0pxR5xqgn11T0D5GJhf1QbIYKOmegNTJwK8GSOQYslii7Fgt3
    x8CygbicDQqWTGStA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudeikedgudeitdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepofgfggfkjghffffhvffutgesth
    dtredtreertdenucfhrhhomhepfdeuvghnucffvghnhhgrrhhtohhgfdcuoegsvghnsehs
    uhguohhfohhrghgvrdgtohhmqeenucggtffrrghtthgvrhhnpefggfdtkeduleevjeduge
    ekueeuheeftdevveekkedvieeigfejheekkeevleejfeenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvghnsehsuhguohhfohhrghgvrdgtoh
    hm
X-ME-Proxy: <xmx:RLbKX8E5Dqio9ZYyHm_rasebNZwN9U2T07W0EhPhBfKjJp3JvUz1aw>
    <xmx:RLbKX1RpwTast_HeIn8Fo-6tJiaohFxTfD8ZDj53Kx-ynS84G_8xwA>
    <xmx:RLbKXxwVr0IJh6zZxaGtQzwCdGuHG5jf1jBzXFOGgzzbv1V0UdQ1Uw>
    <xmx:RLbKX_Zt5t_z2LhstaLtvTJCbyEh7mGbap3L_Zpx4hNGfO4hrWeWyg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 7F6AFE00BF; Fri,  4 Dec 2020 17:20:50 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.3.0-622-g4a97c0b-fm-20201115.001-g4a97c0b3
Mime-Version: 1.0
Message-Id: <64680dc3-1cae-4572-82ef-ed183aff1746@www.fastmail.com>
In-Reply-To: <X8qjVAGlrYJWO5fc@coredump.intra.peff.net>
References: <a4ae4e1a-b457-4b35-878c-2714ebfc415f@www.fastmail.com>
 <X8oL190Vl03B0cQ/@coredump.intra.peff.net>
 <112958f6-0eca-453d-86f3-52e7054a88f9@www.fastmail.com>
 <xmqq360lfios.fsf@gitster.c.googlers.com>
 <X8qjVAGlrYJWO5fc@coredump.intra.peff.net>
Date:   Fri, 04 Dec 2020 15:20:32 -0700
From:   "Ben Denhartog" <ben@sudoforge.com>
To:     "Jeff King" <peff@peff.net>, "Junio C Hamano" <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: Unexpected behavior with branch.*.{remote,pushremote,merge}
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I guess from my perspective, for these repositories, my fork _is_ the "origin"; I tend to mirror the repositories I contribute to (e.g. use the "fork" feature on Git{Hub,Lab}/etc), then clone my mirror, which lends itself to that mental model (origin is "mine"). 

-- 
  Ben Denhartog
  ben@sudoforge.com

On Fri, Dec 4, 2020, at 14:00, Jeff King wrote:
> On Fri, Dec 04, 2020 at 11:57:23AM -0800, Junio C Hamano wrote:
> 
> > > * Refactor away from usage of FETCH_HEAD
> > 
> > Yes, "fetch --all" is about updating the remote-tracking branches
> > and in retrospect, perhaps we might have avoided confusion if we
> > made it not to touch FETCH_HEAD, but it is not going to change now.
> 
> I think its behavior of appending all of the entries is sensible (or at
> least is the least-surprising thing). The only weird part is that it
> does not keep the "make sure heads for merging come before not-for-merge
> entries" property that individual ones have.
> 
> It could take a final pass after all of the sub-fetches have run and do
> that. I don't have any plans to work on it, but I'm tempted to call it a
> #leftoverbits candidate.
> 
> > > * Set `remote.pushdefault = origin`
> > > * Set `push.default = current` (instead of `simple`, and is what
> > > my global config sets this to)
> > 
> > I have a feeling that simple vs current does not make a difference
> > if you are pusing main to main, and if so, push.default could be
> > left to the default settings of 'simple'.  But the key to successful
> > use of the triangular workflow is to configure so that "fetch/pull"
> > goes to one place (i.e. your upstream) and "push" goes to another
> > (i.e. your publishing repository), and "remote.pushdefault" is a
> > good ingredient to do so.
> 
> I think my advice is just out-of-date (by quite a lot). In the early
> days, I remember being bitten by (or at least confused by) simple and
> how its use of upstream could work with multiple remotes. But we long
> ago fixed that, with ed2b18292b (push: change `simple` to accommodate
> triangular workflows, 2013-06-19), and these days it is explicitly
> documented to work the same as "current" when pushing to another remote.
> 
> > It is however more common to use 'origin' as the name of your
> > upstream repository (so that "git fetch" and "git pull" would grab
> > things from there by default) and set remote.pushdefault to the
> > remote you push into, though (iow, I found remote.pushdefault
> > pointing at 'origin' a bit unusual).  Doing so may make your
> > triangular workflow work smoother.
> 
> Yeah, I wasn't going to nitpick his remote names, but that's the same
> convention I use. :) If people have custom forks of a repository that I
> access, I usually just name the remote for them after their username
> (including my own).
> 
> -Peff
>
