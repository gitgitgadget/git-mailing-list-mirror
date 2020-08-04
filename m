Return-Path: <SRS0=W4Po=BO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1CE8C433DF
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 00:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D66D72076E
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 00:37:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mattmccutchen.net header.i=@mattmccutchen.net header.b="YNk+KAap"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbgHDAhn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 20:37:43 -0400
Received: from lavender.maple.relay.mailchannels.net ([23.83.214.99]:17163
        "EHLO lavender.maple.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726130AbgHDAhn (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 3 Aug 2020 20:37:43 -0400
X-Sender-Id: dreamhost|x-authsender|matt@mattmccutchen.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 14CBC401A31;
        Tue,  4 Aug 2020 00:37:42 +0000 (UTC)
Received: from pdx1-sub0-mail-a94.g.dreamhost.com (100-96-5-127.trex.outbound.svc.cluster.local [100.96.5.127])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 45C524017E2;
        Tue,  4 Aug 2020 00:37:41 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|matt@mattmccutchen.net
Received: from pdx1-sub0-mail-a94.g.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
        by 0.0.0.0:2500 (trex/5.18.8);
        Tue, 04 Aug 2020 00:37:41 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|matt@mattmccutchen.net
X-MailChannels-Auth-Id: dreamhost
X-Wipe-Skirt: 5ba63c3731ed8ab0_1596501461709_665990555
X-MC-Loop-Signature: 1596501461709:2774176068
X-MC-Ingress-Time: 1596501461709
Received: from pdx1-sub0-mail-a94.g.dreamhost.com (localhost [127.0.0.1])
        by pdx1-sub0-mail-a94.g.dreamhost.com (Postfix) with ESMTP id 0827FB2B9E;
        Mon,  3 Aug 2020 17:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=mattmccutchen.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=
        mattmccutchen.net; bh=p5zbW+2+AmrB3o4y/HpSSm97BLw=; b=YNk+KAapaQ
        o2SWFxiAqlSrZiRYNEiJCp1bMIGPhrJULaTJYO+p+brxysmspffUpMQUF90zF2gb
        3GshP6ozqRUO4Fh+gFw+ZDO9WY2o6znNFEZnq8+hdCd0Z7Xk56kP1QSUGGvr1bvn
        l4VR3XgPMqdWsy3UidceBIwDgxct2GZOo=
Received: from main (pool-100-15-89-198.washdc.fios.verizon.net [100.15.89.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: matt@mattmccutchen.net)
        by pdx1-sub0-mail-a94.g.dreamhost.com (Postfix) with ESMTPSA id 2770DB2B9C;
        Mon,  3 Aug 2020 17:37:39 -0700 (PDT)
Message-ID: <baea11c61973ff4be5ad33499d80f8629e2e1261.camel@mattmccutchen.net>
Subject: Re: Renaming the "master" branch without breaking existing clones
X-DH-BACKEND: pdx1-sub0-mail-a94
From:   Matt McCutchen <matt@mattmccutchen.net>
To:     Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Date:   Mon, 03 Aug 2020 20:37:36 -0400
In-Reply-To: <20200803194006.GA2715275@coredump.intra.peff.net>
References: <ec960483f5008e9948271c678d51876920ab62c9.camel@mattmccutchen.net>
         <20200803160051.GA50799@syl.lan>
         <20200803194006.GA2715275@coredump.intra.peff.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-VR-OUT-STATUS: OK
X-VR-OUT-SCORE: 0
X-VR-OUT-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrjeehgdefjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucggtfgfnhhsuhgsshgtrhhisggvpdfftffgtefojffquffvnecuuegrihhlohhuthemuceftddtnecunecujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomhepofgrthhtucfotgevuhhttghhvghnuceomhgrthhtsehmrghtthhmtggtuhhttghhvghnrdhnvghtqeenucggtffrrghtthgvrhhnpeeviefguefftddujeeihfevtdfffefhleevkeekteeitdegjefhudeugfdvvdehtdenucffohhmrghinhepghhithhhuhgsrdgtohhmpdgrthhlrghsshhirghnrdgtohhmpdhgihhtlhgrsgdrtghomhenucfkphepuddttddrudehrdekledrudelkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdphhgvlhhopehmrghinhdpihhnvghtpedutddtrdduhedrkeelrdduleekpdhrvghtuhhrnhdqphgrthhhpeforghtthcuofgtvehuthgthhgvnhcuoehmrghtthesmhgrthhtmhgttghuthgthhgvnhdrnhgvtheqpdhmrghilhhfrhhomhepmhgrthhtsehmrghtthhmtggtuhhttghhvghnrdhnvghtpdhnrhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 2020-08-03 at 15:40 -0400, Jeff King wrote:
> The real trick is that you can't create or update symbolic refs on the
> server side using a client. So this would have to be something that
> hosting providers allow (and there might be some security implications;
> I'm not sure what happens if you create a loop in the symref
> resolution).

Right, repository administrators need some kind of support for the
hosting provider (whether symrefs or something custom), otherwise the
best they can do is develop their own process to mirror the new branch
to the old branch.

GitHub mentions a plan to support a branch rename that would redirect
at least fetches of the old name, though it is short on details:

https://github.com/github/renaming#later-this-year-seamless-move-for-existing-repositories-

I've just filed feature requests for BitBucket and GitLab:

https://jira.atlassian.com/browse/BCLOUD-20349
https://gitlab.com/gitlab-org/gitlab/-/issues/233427#related-issues

Anyone want to check on other major providers?

Matt

