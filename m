Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D2BC47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 09:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1305A6124B
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 09:02:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbhFHJEb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 05:04:31 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:60673 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230280AbhFHJEb (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 8 Jun 2021 05:04:31 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 6C0491695;
        Tue,  8 Jun 2021 05:02:38 -0400 (EDT)
Received: from imap38 ([10.202.2.88])
  by compute5.internal (MEProxy); Tue, 08 Jun 2021 05:02:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hurrell.net; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm2; bh=nU9ZWsBtILp+Tdt+7XfyaRtoIKqXdb4
        bHt6Cwo83XOU=; b=EBnEIuZo4W1w0SjFHCgDhKS+C3pNpBfKeyIuZeetRIKWTeY
        LFMtwrzHNSAye3dAS5sAH5v6cW0G0+bKnSqFi1ceA8ctlzhB5Nu6e3I/Hch/Cm7/
        xkDBFn6uEprzOwXDr7h3IRlXUQAwH4/hIgVscxXP9OvLWRuKdCM2zCsHHIPDIXQM
        onQv9SKRdn8kugqMrcQpYVmzyuVTDxyp/IGrJXRNcjd6cN/w21XfmgQCo3klzv/p
        c2iifxaFLynNlJcQ0MjnCqXLSqnRfF5hsHFcmaGdCBx6ouwjJGfSsglb7R3ZMgKm
        zOYkdn6zpBsQp7unxGm9nSXzJhHlg33iQyZG6oA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=nU9ZWs
        BtILp+Tdt+7XfyaRtoIKqXdb4bHt6Cwo83XOU=; b=Kc5DBIKpS+rXoBsMar98HD
        V+bh2tpTOIb2uKJBSJnsYJmui1l832FNSKGBIFyFZ4cRiMunS587vHVLtNqqy35G
        9vS28O4NhZTpcTz7cX5LHZvzp6SyRfx9RmMv3CEDsz4d3bE4R+6+2ZMIz1hId9Ne
        b+wFqI9ZRdE8EYthg3TnrGVnLF1PMOQhIlmUqDjDyH4On6YPYmiGXfFEry93dFc6
        PQ0hWziOZylagnjRaqfSy8CX+wx3Wa41mdcSeYPsPaBL3zkcgMkc7VbiCJPgI6BX
        hUCIw1m7yIVhH+ROH8qjh77lo1Ix/eqqsPIRZYF8DX6WbvIaXAplF7nQgBAq0rfg
        ==
X-ME-Sender: <xms:LTK_YBjJg2Y78oIceFVhAv67U_w2RdI0K8JsDSzclrd5mqVD2IerCg>
    <xme:LTK_YGBL3obRtPW7gpZaHk0Wust-4xRZ5a2kyYBv2hK2rp04Y1RGNkgKU6Ih8x72D
    4hYYQgOKOdJc4zFRkk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfedtledgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfgjfhffhffvufgtsehttd
    ertderreejnecuhfhrohhmpedfifhrvghgucfjuhhrrhgvlhhlfdcuoehgrhgvgheshhhu
    rhhrvghllhdrnhgvtheqnecuggftrfgrthhtvghrnhepieelhfdvieffueejteejfeeihe
    evieejueevjedugffgkeetieehudetgffhleehnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehhuhhrrhgvlhhlrdhnvght
X-ME-Proxy: <xmx:LTK_YBGwPth9OBSxwafkvB9a_E3O6Y71l-MPcOQPi35H0wX2JidnGQ>
    <xmx:LTK_YGSpb7fwfs6Pa0ZO9L_xuH5RWjECaHGLdI8N3QRuZo9kWHR5PA>
    <xmx:LTK_YOy7LolfiG7cx51rCrTpzni-IMEKA2zRVHksWRyTJQ9VVdX-Fg>
    <xmx:LjK_YDuKHGgDBxO2bdTCgIU42-7Te5vFhcR7lRIElgDLkalAHe-PLQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id A36D7CA005E; Tue,  8 Jun 2021 05:02:37 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-519-g27a961944e-fm-20210531.001-g27a96194
Mime-Version: 1.0
Message-Id: <f04ffea4-ff37-432a-a0c6-abe11721060b@www.fastmail.com>
In-Reply-To: <YL8rjeKQPOtQSyzT@coredump.intra.peff.net>
References: <20210606085116.13739-1-greg@hurrell.net>
 <20210606085732.15001-1-greg@hurrell.net>
 <YL8rjeKQPOtQSyzT@coredump.intra.peff.net>
Date:   Tue, 08 Jun 2021 11:02:15 +0200
From:   "Greg Hurrell" <greg@hurrell.net>
To:     "Jeff King" <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: =?UTF-8?Q?Re:_[RFC_PATCH]_gitweb:_use_HEAD_as_primary_sort_key_in_git=5F?=
 =?UTF-8?Q?get=5Fheads=5Flist()?=
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 8, 2021, at 10:34 AM, Jeff King wrote:
> 
> In your earlier example, it sounded like you were primarily concerned
> with breaking ties. But here it sounds like you're proposing putting the
> HEAD first _regardless_ of the committer timestamp.

I arrived there organically. My initial goal was merely to find out why
"master" was sorting ahead of "main" even after I switched HEAD, as it
seemed arbitrary and possibly hard-coded.

Adding `--sort=-HEAD` wallpapers over the problem by forcing HEAD to the
top, but it doesn't address the underlying arbitrariness/non-determinism
of how refs with equal committerdate get treated.

So I like your idea of splitting this into two separate changes much
better:

>   1. break ties by name, like:
> 
>        git for-each-ref --sort=refname --sort=-committerdate
> 
>   2. emphasize the HEAD branch, even if it isn't the newest:
> 
>        git for-each-ref --sort=refname --sort=-committerdate --sort=-HEAD

I think adding "1" is a clear improvement. "2" is more debatable (I
think it would be of practical use, but as you said, HEAD is very often
going to be the most recently committed thing anyway). In my specific
use case (where "main" is the HEAD but "master" is kept in sync with it
automatically so as not to break existing clones), sorting by refname
_happens_ to mean that "main" will come before "master"; but that is of
course a quirk of my branch naming choices and not something that should
be relied upon.

In any case, splitting this into two pieces sounds good: we have the
option of taking one or both (or none).

Cheers,
Greg
