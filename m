Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED372C433E0
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 11:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C18D664E81
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 11:26:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbhCOL0G (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 07:26:06 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:44175 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230118AbhCOLZt (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 15 Mar 2021 07:25:49 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 4D22FE22;
        Mon, 15 Mar 2021 07:25:48 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 15 Mar 2021 07:25:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=/AkgTnmi1tByuDACtg0lg60CT/m
        Nfib6JMTCkc285Yo=; b=RDZ7tsdfeFak/yRqekYaZtEFNkdLpC89hhuPLbeh2Qh
        xZWcFZTaFBS47DNwtHrEztiCCSLvFf6+CBn4fhCYr+aMPrmyxVS+9iZHeMlHaygS
        tjKCigq94bmUtJn4S8BK6tdo+DAcpgTDHr4/fHTCKm9c1HNVDqgUXsQ2gtaKfeyj
        yqydpLEqmmmV7Cu0qKZ9DIqM2Srqcea0/DMEd9DH7RZu1+gSZBGTzQc7/ldqJTrk
        7x6y/vKZM39zqKaq3MpjMUWRnEumXjNCOmDKnUgJIIIfgk8R079KT4bDopacqZDu
        WVgz9WqNCTGrusC73ffmsMypD5enQDpNBD6TptsobpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=/AkgTn
        mi1tByuDACtg0lg60CT/mNfib6JMTCkc285Yo=; b=o80OBqKW6k3+U5Ltw/AQS1
        spt9Ol8P3Qa6kGqjc/96BmgfcPu+wMySlCPJCe3b32mQCuNINhOO+i0Ef5rP8Exn
        WXeDJX09tVTHHkTewCrYqXR4Vz+hAwbn2ILMUs3SQOQCyHPOaOD4/KmEEO0yHMTU
        gPL9DpuIw/q6mY8RqGYUjaifV+T0te/hsHXWtry+C1Swu0r3m7IOC82zwFpjsJfM
        YRQbFFv02zb+kA306pMow9EP7OsvGJlXdqgNg7ROZNAf33zxrlZvcKdbxWANKu6+
        xgFaWZM9TO5ZiaJEFCwNejS9dwlU043LaDb0muM0Ipq21HE7sqE1T4lpyCcjERmw
        ==
X-ME-Sender: <xms:O0RPYJ-i3dmH7S878Po9dRr4VgYP0OMnWOsAI9hUnJcXMcVsX4SjZQ>
    <xme:O0RPYNszA_g51RqMFdRttbzIwrzj1PvoE5UcyX6gvMSHic_vqoDd_9AoCBGfP21pR
    LwyEbL6zs48RROxJg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledruddvledgvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehkeeffeeggedvgedvfeefheettddtffejuefflefggfehfeelffeljedvfeehieen
    ucfkphepkeelrddugedrleeirddvgedunecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:O0RPYHAuOCnPtiGaeL_VEppgbuZyB9ZufmR-xojy75NBa3n7pc4SJQ>
    <xmx:O0RPYNfRxzqjocMP-duMWs0AsMtQjx6WBp5nn3QUgBn4efSuQFrCAQ>
    <xmx:O0RPYONGE67enPvSkO8cqHG3Ybo9bs_m40R1Qmg14MPW2bz-a_Fhdw>
    <xmx:O0RPYIWpkqNruX2303xrC8eyCBxdlVv0ZKILj3hCcvke7vLZzL_bUw>
Received: from vm-mail.pks.im (dynamic-089-014-096-241.89.14.pool.telefonica.de [89.14.96.241])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0C16A1080054;
        Mon, 15 Mar 2021 07:25:46 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 8e690153 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 15 Mar 2021 11:25:41 +0000 (UTC)
Date:   Mon, 15 Mar 2021 12:25:40 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 0/7] rev-parse: implement object type filter
Message-ID: <YE9ENGKkKRbzUL7I@ncase>
References: <cover.1614600555.git.ps@pks.im>
 <YEk8iiDf/FMxzhIF@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YEk8iiDf/FMxzhIF@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 10, 2021 at 04:39:22PM -0500, Jeff King wrote:
> On Mon, Mar 01, 2021 at 01:20:26PM +0100, Patrick Steinhardt wrote:
> 
> > Altogether, this ends up with the following queries, both of which have
> > been executed in a well-packed linux.git repository:
> > 
> >     # Previous query which uses object names as a heuristic to filter
> >     # non-blob objects, which bars us from using bitmap indices because
> >     # they cannot print paths.
> >     $ time git rev-list --objects --filter=blob:limit=200 \
> >         --object-names --all | sed -r '/^.{,41}$/d' | wc -l
> >     4502300
> > 
> >     real 1m23.872s
> >     user 1m30.076s
> >     sys  0m6.002s
> > 
> >     # New query.
> >     $ time git rev-list --objects --filter-provided \
> >         --filter=object:type=blob --filter=blob:limit=200 \
> >         --use-bitmap-index --all | wc -l
> >     22585
> > 
> >     real 0m19.216s
> >     user 0m16.768s
> >     sys  0m2.450s
> 
> Those produce very different answers. I guess because in the first one,
> you still have a bunch of tree objects, too. You'd do much better to get
> the actual types from cat-file, and filter on that. That also lets you
> use bitmaps for the traversal portion. E.g.:
> 
>   $ time git rev-list --use-bitmap-index --objects --filter=blob:limit=200 --all |
>          git cat-file --buffer --batch-check='%(objecttype) %(objectname)' |
> 	 perl -lne 'print $1 if /^blob (.*)/' | wc -l
>   14966
>   
>   real	0m6.248s
>   user	0m7.810s
>   sys	0m0.440s
> 
> which is faster than what you showed above (this is on linux.git, but my
> result is different; maybe you have more refs than me?). But we should
> be able to do better purely internally, so I suspect my computer is just
> faster (or maybe your extra refs just aren't well-covered by bitmaps).
> Running with your patches I get:
> 
>   $ time git rev-list --objects --use-bitmap-index --all \
>              --filter-provided --filter=object:type=blob \
> 	     --filter=blob:limit=200 | wc -l
>   16339
> 
>   real	0m1.309s
>   user	0m1.234s
>   sys	0m0.079s
> 
> which is indeed faster. It's quite curious that the answer is not the
> same, though! I think yours has some bugs. If I sort and diff the
> results, I see some commits mentioned in the output. Perhaps this is
> --filter-provided not working, as they all seem to be ref tips.
[snip]

I've found the issue: when converting filters to a combined filter via
`transform_to_combine_type()`, we reset the top-level filter via a call
to `memset()`. So for combined filters, the option wouldn't have taken
any effect because it got reset iff the `--filter-provided` option comes
before the second filter.

Patrick
