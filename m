Return-Path: <SRS0=/7R8=BN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0588C433E0
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 12:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95F70204EC
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 12:16:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mattmccutchen.net header.i=@mattmccutchen.net header.b="qCT/xuYj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbgHCMQM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 08:16:12 -0400
Received: from lavender.maple.relay.mailchannels.net ([23.83.214.99]:11358
        "EHLO lavender.maple.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725945AbgHCMQF (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 3 Aug 2020 08:16:05 -0400
X-Sender-Id: dreamhost|x-authsender|matt@mattmccutchen.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 308EB1E038F
        for <git@vger.kernel.org>; Mon,  3 Aug 2020 12:16:03 +0000 (UTC)
Received: from pdx1-sub0-mail-a73.g.dreamhost.com (100-96-22-23.trex.outbound.svc.cluster.local [100.96.22.23])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 7501A1E016A
        for <git@vger.kernel.org>; Mon,  3 Aug 2020 12:16:02 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|matt@mattmccutchen.net
Received: from pdx1-sub0-mail-a73.g.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
        by 0.0.0.0:2500 (trex/5.18.8);
        Mon, 03 Aug 2020 12:16:03 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|matt@mattmccutchen.net
X-MailChannels-Auth-Id: dreamhost
X-Belong-Quick: 12a030e17a0092ca_1596456962910_2106795365
X-MC-Loop-Signature: 1596456962910:2574089114
X-MC-Ingress-Time: 1596456962910
Received: from pdx1-sub0-mail-a73.g.dreamhost.com (localhost [127.0.0.1])
        by pdx1-sub0-mail-a73.g.dreamhost.com (Postfix) with ESMTP id 29982A7F71
        for <git@vger.kernel.org>; Mon,  3 Aug 2020 05:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=mattmccutchen.net; h=
        message-id:subject:from:to:date:content-type:mime-version
        :content-transfer-encoding; s=mattmccutchen.net; bh=hC+avWJ4fF/P
        bg/rZQYMWl4c+Gw=; b=qCT/xuYjjwbxZPyI3Qu3FVHU12RklADwdoxKl2zHBWzx
        CpwdhOSrK938BeiDU2z0/PK8LxHju4FyA0wa7xX86EdJcrQG7K+Zt0DXVatEBTTo
        liAgAiAZsI7r/ZNx8QXw//Ui+igeTu8cUUPr0gWTgYKU6QFDvTI7WCdVVGyG6cI=
Received: from main (pool-100-15-89-198.washdc.fios.verizon.net [100.15.89.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: matt@mattmccutchen.net)
        by pdx1-sub0-mail-a73.g.dreamhost.com (Postfix) with ESMTPSA id 8FA6CA7F59
        for <git@vger.kernel.org>; Mon,  3 Aug 2020 05:16:01 -0700 (PDT)
Message-ID: <ec960483f5008e9948271c678d51876920ab62c9.camel@mattmccutchen.net>
Subject: Renaming the "master" branch without breaking existing clones
X-DH-BACKEND: pdx1-sub0-mail-a73
From:   Matt McCutchen <matt@mattmccutchen.net>
To:     git@vger.kernel.org
Date:   Mon, 03 Aug 2020 08:15:58 -0400
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-VR-OUT-STATUS: OK
X-VR-OUT-SCORE: 50
X-VR-OUT-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrjeeggdehtdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucggtfgfnhhsuhgsshgtrhhisggvpdfftffgtefojffquffvnecuuegrihhlohhuthemuceftddtnecuogfvvgigthfqnhhlhidqqdetfeejfedqtdegucdlhedtmdenucfjughrpefkuffhvffftggfggfgsehtjeertddtreejnecuhfhrohhmpeforghtthcuofgtvehuthgthhgvnhcuoehmrghtthesmhgrthhtmhgttghuthgthhgvnhdrnhgvtheqnecuggftrfgrthhtvghrnhepgfegvedtvdeijedufeejteefkeejudelvdeufeetgfduieeiveegtdelkeefteejnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepuddttddrudehrdekledrudelkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdphhgvlhhopehmrghinhdpihhnvghtpedutddtrdduhedrkeelrdduleekpdhrvghtuhhrnhdqphgrthhhpeforghtthcuofgtvehuthgthhgvnhcuoehmrghtthesmhgrthhtmhgttghuthgthhgvnhdrnhgvtheqpdhmrghilhhfrhhomhepmhgrthhtsehmrghtthhmtggtuhhttghhvghnrdhnvghtpdhnrhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[Apologies if there is an existing thread about this; I searched hard
and wasn't able to find one.]

I've just become aware of the discussion that the name of the "master"
branch should be changed.  I'm not taking a position on this now, but
it seems enough people want to make the change that we should resolve
the technical problems, of which I see several:

1. Allowing tools to be configured to change the default name for new
repositories.  Work on this appears to be well underway with no
fundamental obstacles.

2. Renaming the branch in existing repositories.  I've seen a number of
guides for how to do it in the central repository, and they all seem to
expect users with existing clones to manually reconfigure them all at
once.  To me, that amount of disruption would be unacceptable for
central repositories I'm in charge of (admittedly few with few users,
so I imagine some will argue I should leave it to the bigger players to
complain about this), whether or not one believes that the social
justice benefit of changing the branch name in personal clones merits
the work at all.  I found only one guide that addresses this problem:

https://github.com/chancancode/branch-rename#gradual-migration

It includes a procedure to mirror the "master" branch from the new
default branch so that readers of the central repository don't need to
reconfigure anything.  Writers need to be reconfigured.  That seems
reasonable to me.

Unfortunately, the mirroring method seems to be specific to the
repository hosting service being used.  If services supported standard
git hooks, that would probably work, but I can understand if the
services don't because it's unwieldy to execute shell scripts without
introducing security risks.

This guide seems well thought out to me on a first read, but I suspect
there may be aspects that could benefit from a lot more scrutiny from
experts, and I want to encourage them to provide it.

3. Ensuring that tools detect the default branch of a given repository
in an appropriate way rather than assuming "master".  Where applicable,
the remote HEAD symref is probably the best thing to use.  See for
example:

https://github.com/chancancode/branch-rename#packages-considerations

This category would also include git's feature of leaving the target
branch name out of the merge message, for example.  I believe the
necessary work on git itself is underway; other tools may lag.

For read-only tools, this mainly matters for central repositories that
eventually delete their "master" branch, which may not be all of them,
but again, it sounds like there will be enough such repositories that
we should consider the problem.  I don't see any fundamental obstacle,
but this may benefit from more scrutiny as well.

I'm aware that asking others to do work is often poorly received.  This
message is just to get people's attention so they can do the work if
they wish.

Thanks for reading.

Matt

