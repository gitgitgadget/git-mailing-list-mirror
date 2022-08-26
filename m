Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B10ECAAA3
	for <git@archiver.kernel.org>; Fri, 26 Aug 2022 15:53:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343602AbiHZPxy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Aug 2022 11:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237300AbiHZPxw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2022 11:53:52 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93BA0220D0
        for <git@vger.kernel.org>; Fri, 26 Aug 2022 08:53:51 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 258FC5C02CE;
        Fri, 26 Aug 2022 11:53:49 -0400 (EDT)
Received: from imap46 ([10.202.2.96])
  by compute3.internal (MEProxy); Fri, 26 Aug 2022 11:53:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hurrell.net; h=
        cc:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1661529229; x=1661615629; bh=EQswOZSY31
        7d3psFSt3SVgJbkSqTgFymg1nKfobPFoY=; b=WHM8rvD8qHx1F0L9UWtNJINj1I
        SmjzgSRy5FIhA/2z6ledS85Yb/+alf94n1I2hpDeQizaFcuilZgt38PBIHeIVPgd
        k38Oextdh4feIJbSozSVKzoYtwg+k4m+DvxVY6/mHhWpj1Mr2W1jcrDAeNm3SQ5w
        hT96hZyV/3A7HSxs1djNfh6+o42aDSwVNJcMQKmaewrFzycIBZrAthijjuixPXiO
        eFhDIY3BhhqiAnwD9SM2gB9DpEIXiEG64nBC3eW1MuzWECg8X7DY4enYNrIhGSUa
        V69b3wqvM1QDSxP5flwAlF6WfMM5pESE3aJMBJq2DhMrouC1OUM2Ak9oaZ5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1661529229; x=1661615629; bh=EQswOZSY317d3psFSt3SVgJbkSqT
        gFymg1nKfobPFoY=; b=FIWpFQavEj9d/ajzUXg3Wo9BWCXJL4frfC1SqOD+G1sE
        Tag9C+E8XeaeQFO17dXU9a17iQeUcC9WitkL+JbjAHddFHhzAueN5ao/cruc3pYi
        8pK1J+K8eqmj2y8a5w7MXqaN6JMj4nLn+zTiR9p2MDLlBw7uAHsnWmXxsLG77Jr0
        clWUoobkJlJI7Dn/ifBm1ATaeG74rzX9qFcxHGE34ZB9uwNZGSXMdbxugp5MBHtQ
        FpDJ4jIdRwNzOLvguP3F45Xy7TIvJqcx5HGtu5xZPiNc8M4BMLycuhHwDHucq5ta
        X6MLQPDbGb5Itqg3sZ/PL15Cg3NoPh4zNPshx7GpWw==
X-ME-Sender: <xms:jOwIY3l0cSMchMVLB0NeAPh0GcX8_fYwPo0UMdAMIkHFle80Hauv3g>
    <xme:jOwIY61pdZtekeVUuvGQ9G-2FrmQRe2uP8A7EaoxYsSZWtw8Y84ClJm9bpMevuMGL
    DvbISwafg91dttG_OA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdejhedgleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    goufhushhpvggtthffohhmrghinhculdegledmnecujfgurhepofgfggfkjghffffhvfev
    ufgtsehttdertderredtnecuhfhrohhmpedfifhrvghgucfjuhhrrhgvlhhlfdcuoehgrh
    gvgheshhhurhhrvghllhdrnhgvtheqnecuggftrfgrthhtvghrnhepteduvddtffeltddt
    feekfedugedtjeeufeevjeefhfetteegtdeludfhieeugfffnecuffhomhgrihhnpehgih
    htrdhiohdpphhusghlihgtqdhinhgsohigrdhorhhgnecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehhuhhrrhgvlhhlrdhnvght
X-ME-Proxy: <xmx:jOwIY9rEyxbIMcm53aqY3ZB4pIDmWeiSUw1HcOal8aP6Jzarpc9FEg>
    <xmx:jOwIY_kYepFBqhVG_Ggoq9xHGybAV6-4ynHJij_Sq5DnfPp-ACUb6A>
    <xmx:jOwIY10cPNMEGQibLBXdrkjS1ro3knjABtFMEWwNW3yU5qJOms0x1g>
    <xmx:jewIYyhFih-Z0z7Ag4WKeCUW3STEB18qIb0QR_AXHqJUqqZVmPn0Sg>
Feedback-ID: i12114735:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 742B82A20075; Fri, 26 Aug 2022 11:53:48 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-841-g7899e99a45-fm-20220811.002-g7899e99a
Mime-Version: 1.0
Message-Id: <70e68b28-73fa-4d16-a135-cbb03ea09d35@betaapp.fastmail.com>
In-Reply-To: <4e0eff48-4a3e-4f0e-9ed2-d01ec38442a5@www.fastmail.com>
References: <4e0eff48-4a3e-4f0e-9ed2-d01ec38442a5@www.fastmail.com>
Date:   Fri, 26 Aug 2022 17:53:28 +0200
From:   "Greg Hurrell" <greg@hurrell.net>
To:     git@vger.kernel.org
Cc:     "Phillip Wood" <phillip.wood@dunelm.org.uk>
Subject: Re: Bad behavior in xhistogram.c in the face of hash collisions?
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 16, 2021, at 2:40 PM, Greg Hurrell wrote:
> 
> I think I may have found a bug in the histogram diff algorithm that
> manifests when there is a hash collision.  This behavior seems to exist
> in the JGit implimentation (https://git.io/J0Ud8) too, and was brought
> across with the port-to-C in 8c912eea94a2.

Thought I had better bump the thread as I did a fire-and-forget on it
a year ago and never followed up because I wasn't super confident
about my findings.

I'd be interested in corroboration of my analysis, to see whether there
really is a bug there. Not quoting my entire email here so as to keep
things brief, but the original can be seen at:

https://public-inbox.org/git/4e0eff48-4a3e-4f0e-9ed2-d01ec38442a5@www.fastmail.com/

(Phillip, CC'ing you for an opinion because I see you have made a few
changes to xdiff/xhistogram.c relatively recently.)

Best wishes,
Greg
