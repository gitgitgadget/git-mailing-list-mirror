Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF77C433DB
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 14:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E4A364FE5
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 14:38:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233564AbhCKOiW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Mar 2021 09:38:22 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:39643 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233368AbhCKOiS (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 11 Mar 2021 09:38:18 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 83A015C0125;
        Thu, 11 Mar 2021 09:38:17 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 11 Mar 2021 09:38:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=fm3; bh=F
        DvvELMfjuWZCt8cVC53gjyJX2r+qmT20ntLmbfgWQs=; b=TyZ0FAGObdqFyprTy
        sNLFvjLcJJvSaZYSI9zf5eHJ1KMoRI8MDZUsnOP49cs2tTY+UtMxkOdIQNTX5fcR
        7IDnVdjjmZQg4FRy/ZoyqS+cgPeD0z/qR9WPSaI+Jord9ZLtBqC8KbarCMKRGEMc
        aeK2YXzCXr3VB+O8IvaHk4x2HlNjG3L5s1ZUQto6KGkxXnduCJYISryhoeBhrbrP
        z6UYiojGrxKQP7WYmZ4nt26dMX/mm36+Rb2kQL8W5UvuOrbhCiPXPHvUHLSJVpy8
        7a9sbVaGcaBLvahzJMNN1ApVjFcyfTETD+dauR7L/rPqNfcvxzoJCYqRiXI/Arol
        tJKlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=FDvvELMfjuWZCt8cVC53gjyJX2r+qmT20ntLmbfgW
        Qs=; b=CxFvkQE5D5+l9HAxTgm1BbqsQqTOOq6Vj6QF/aWk497NoDhcZQqDIgMB6
        8zu4KyfN1xAJEeVWRMxHnUC5hDrvqSi2OhH20v/6i2jk8QXDQ7VdzeRjbAjcsIEU
        T+iC5IsNxGgyEed1LRKGkRWKCGyonHHqwnB2UbfShaa4v/csxjF1tQlThyuOesPm
        XvK6U9/lTYTiNBBBIHKgnKSKU/SrwPP6jui1eMAYQ+HORVIPlglrt33suxRxSV8E
        C69nBz+v8jJr8TesWPopKaDVgKDt9Sjm2q6Jc48h2z70XOm1U3oQbTk35huG2UjB
        deGRztMHu8e11nB4vT5OiG6wGZhfA==
X-ME-Sender: <xms:WStKYOG2yXuL8nykeq4SOnRMYVzU5tA5xoOV9viZwGeU10qMNR8dDA>
    <xme:WStKYPUfk-xB7gTnVz8TyfJQbpCYunGu7StQXVAVSPdAN1qt9-a21df4JBTyrSa1_
    Rt3tfiYZ6EwScIHDQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledruddvtddgieejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtugfgjgesthhqredttddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepheekfeejgfdtieeutdejhfekteeftddtveekhfejjeetheffhfejkeegkedvgfef
    necukfhppeekledrudegrdejkedrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:WStKYIIRl8zpbEqq4QoovOkUfX5hm0HDW4yJ3OdSlCt9DHvYobhuAQ>
    <xmx:WStKYIGsyPpr5mIA99T-D1206wGFmWmf6EWBnzm-rI6S4Cmd6jlQDw>
    <xmx:WStKYEUdnTMOprsBfgO2twKXkViuw0CNd2BpJkNB_77gXjBpiG7Icg>
    <xmx:WStKYNcccKFPm6xiULE5kRX2p1LfaGpjqSS729fQmTtsXbUQEQb2GQ>
Received: from vm-mail.pks.im (dynamic-089-014-078-094.89.14.pool.telefonica.de [89.14.78.94])
        by mail.messagingengine.com (Postfix) with ESMTPA id 86122108005F;
        Thu, 11 Mar 2021 09:38:16 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id d54479f6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 11 Mar 2021 14:38:12 +0000 (UTC)
Date:   Thu, 11 Mar 2021 15:38:11 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 0/7] rev-parse: implement object type filter
Message-ID: <YEorU+rkX4sgMtKi@ncase>
References: <cover.1614600555.git.ps@pks.im>
 <YEk8iiDf/FMxzhIF@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <YEk8iiDf/FMxzhIF@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 10, 2021 at 04:39:22PM -0500, Jeff King wrote:
> On Mon, Mar 01, 2021 at 01:20:26PM +0100, Patrick Steinhardt wrote:
>=20
> > Altogether, this ends up with the following queries, both of which have
> > been executed in a well-packed linux.git repository:
> >=20
> >     # Previous query which uses object names as a heuristic to filter
> >     # non-blob objects, which bars us from using bitmap indices because
> >     # they cannot print paths.
> >     $ time git rev-list --objects --filter=3Dblob:limit=3D200 \
> >         --object-names --all | sed -r '/^.{,41}$/d' | wc -l
> >     4502300
> >=20
> >     real 1m23.872s
> >     user 1m30.076s
> >     sys  0m6.002s
> >=20
> >     # New query.
> >     $ time git rev-list --objects --filter-provided \
> >         --filter=3Dobject:type=3Dblob --filter=3Dblob:limit=3D200 \
> >         --use-bitmap-index --all | wc -l
> >     22585
> >=20
> >     real 0m19.216s
> >     user 0m16.768s
> >     sys  0m2.450s
>=20
> Those produce very different answers. I guess because in the first one,
> you still have a bunch of tree objects, too. You'd do much better to get
> the actual types from cat-file, and filter on that. That also lets you
> use bitmaps for the traversal portion. E.g.:

They do provide different answers, and you're right that `--batch-check`
would have helped to filter by type. Your idea doesn't really work in my
usecase though to identify LFS pointers, at least not without additional
tooling on top of what you've provided. There'd at least need to be two
git-cat-file(1) processes: one to do the `--batch-check` thing to
actually filter by object type, and one to then read the actual LFS
pointer candidates from disk in order to see whether they are LFS
pointers or not.

Actually, we currently are doing something similar to that at GitLab: we
list all potential candidates via git-rev-list(1), write the output into
`git-cat-file --batch-check`, and anything that is a blob then gets
forwarded into `git-cat-file --batch`.

>   $ time git rev-list --use-bitmap-index --objects --filter=3Dblob:limit=
=3D200 --all |
>          git cat-file --buffer --batch-check=3D'%(objecttype) %(objectnam=
e)' |
> 	 perl -lne 'print $1 if /^blob (.*)/' | wc -l
>   14966
>  =20
>   real	0m6.248s
>   user	0m7.810s
>   sys	0m0.440s
>=20
> which is faster than what you showed above (this is on linux.git, but my
> result is different; maybe you have more refs than me?). But we should
> be able to do better purely internally, so I suspect my computer is just
> faster (or maybe your extra refs just aren't well-covered by bitmaps).
> Running with your patches I get:

I've got quite a beefy machine with a Ryzen 3 5800X, and I did do a `git
repack -Adfb` right before doig benchmarks. I do have the stable kernel
repository added though, which accounts for quite a lot of additional
references (3938) and objects (9.3M).

>   $ time git rev-list --objects --use-bitmap-index --all \
>              --filter-provided --filter=3Dobject:type=3Dblob \
> 	     --filter=3Dblob:limit=3D200 | wc -l
>   16339
>=20
>   real	0m1.309s
>   user	0m1.234s
>   sys	0m0.079s
>=20
> which is indeed faster. It's quite curious that the answer is not the
> same, though! I think yours has some bugs. If I sort and diff the
> results, I see some commits mentioned in the output. Perhaps this is
> --filter-provided not working, as they all seem to be ref tips.

I noticed it, too, and couldn't yet find an answer why that is.
Honestly, I found the NOT_USER_GIVEN flag quite confusing and I'm not at
all sure whether I've got all cases covered correctly. The previous was
how this was handled (`USER_GIVEN` instead of `NOT_USER_GIVEN`) would've
been easier to figure out for this specific usecase. But I guess it was
converted due to specific reasons.

I'll invest some more time to figure out what's happening here.

> > To be able to more efficiently answer this query, I've implemented
> > multiple things:
> >=20
> > - A new object type filter `--filter=3Dobject:type=3D<type>` for
> >   git-rev-list(1), which is implemented both for normal graph walks and
> >   for the packfile bitmap index.
> >=20
> > - Given that above usecase requires two filters (the object type
> >   and blob size filters), bitmap filters were extended to support
> >   combined filters.
>=20
> That's probably reasonable, especially because it lets us use bitmaps. I
> do have a dream that we'll eventually be able to support more extensive
> formatting via log/rev-list, which would allow:
>=20
>   git rev-list --use-bitmap-index --objects --all \
>                --format=3D%(objecttype) %(objectname) |
>   perl -ne 'print $1 if /^blob (.*)/'
>=20
> That should be faster than the separate cat-file (which has to re-lookup
> each object, in addition to the extra pipe overhead), but I expect the
> --filter solution should always be faster still, as it can very quickly
> eliminate the majority of the objects at the bitmap level.

That'd be nice, even though it wouldn't help in my particular usecase: I
need to read each candidate blob to see whether it's an LFS pointer or
not anyway.

> > - git-rev-list(1) doesn't filter user-provided objects and always prints
> >   them. I don't want the listed commits though and only their referenced
> >   potential LFS blobs. So I've added a new flag `--filter-provided`
> >   which marks all provided objects as not-user-provided such that they
> >   get filtered the same as all the other objects.
>=20
> Yeah, this "user-provided" behavior was quite a surprise to me when I
> started implementing the bitmap versions of the existing filters. It's
> nice to have the option to specify which you want.
>=20
> -Peff

Patrick
