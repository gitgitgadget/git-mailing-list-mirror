Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E62BC433F5
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 16:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8179B61100
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 16:21:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbhJMQXo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 12:23:44 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:47281 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229903AbhJMQXm (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 13 Oct 2021 12:23:42 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 15F435C00F9;
        Wed, 13 Oct 2021 12:21:38 -0400 (EDT)
Received: from imap42 ([10.202.2.92])
  by compute6.internal (MEProxy); Wed, 13 Oct 2021 12:21:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=waite.eu; h=
        mime-version:message-id:in-reply-to:references:date:from:to
        :subject:content-type; s=fm1; bh=ukHMpstXxwlycHAROrO6Nk/uW3cnCKP
        3/SwHOmJlubY=; b=C88fe7UXc54MRc1o4g1/fZ8qsvlHkd9564kRoiqhnwV9Mdd
        d63FPOwH8qXXC3lzKQg95gtiSq8o84lNNQ4k9iMKuntJG3uOkMg5q3Np9FtiyU/5
        6Q9YZTilVNWy4Fv9zm2zYjvbbVuLilKUxuLN4l6AIDtE82BPjj0iHCSNYtwNXBQN
        Knx+98VKe4yqrm7sxiESc04jEyneVUcqEU4OR35qNQVssiN7wREsZkLJbpGaonLo
        engt5/vd+GoGY+YA8SGe2OYdzmKU83NuTRrAgr3cZGz94Y0Mjh6evXk1FvRjBBmB
        I5YMbdhgwjfp7IBaco8ulfgPkDVXxsbLGvOLSZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=ukHMps
        tXxwlycHAROrO6Nk/uW3cnCKP3/SwHOmJlubY=; b=byzRkDBEFbecmVK1QAjTn1
        /rfcAjREn2ichMMCBblvmiDChashA8NWAZAG+ha88+XB2BRUHmhg4jP5575+oyv0
        bLStNA+6N63qxTYkbfF/vg56cdJy1SKTZWcQgshAJ0kzV3RM/CcX0TqO+D1OHpwW
        iccIHG0cQtmtYzD9EeKTxr7Y7HkxtZlJdIYtaRZJpn5o35vk6WTDH8+ywkjXQl2T
        64xVPcNAQQ48Er+YWTVnBRWiqEQ2/IR9ga4De+pyrg7n8bF6bHFZ7LLbwgIEbneF
        eKZT69rAoDhyqpf16j6BJCtIZGXO+Vlefdkc+NQr5bO8WglphwGJx/mQu2NZ2b2w
        ==
X-ME-Sender: <xms:kQdnYS7LaWTkNaqTTW7WmP6P_73O-TNYTFgKhNMq-HhgPlS_1YVAAw>
    <xme:kQdnYb7y9EdPWpJlYZ9t9qYwY-TtVWFJCh6R32uwlezvslrOwgWrY1JF4ZF0xqjHr
    zqaXIWmcks7YeyNpg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvddutddgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetlhgv
    gicuhggrihhtvgdfuceorghlvgigseifrghithgvrdgvuheqnecuggftrfgrthhtvghrnh
    epgfejgeetgfekveffveelteelkedvfeejvdffhfduueffueeijeeuteekvdegffdtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlvgigse
    ifrghithgvrdgvuh
X-ME-Proxy: <xmx:kQdnYRdn6jdOxoosAt_SlpUDtuL6P-VYa5YGKj32KdUenmBUj_3lJg>
    <xmx:kQdnYfL6g6eYikdB1oBAWi0a6yXmpBxWOmQWJz2tDUvTAmqjha0FfA>
    <xmx:kQdnYWIJA1ZkNxvZb41-i85fSMy2s_jZGu-SAf6G_Wl7-po9jljLOQ>
    <xmx:kgdnYdUgLe9zbZnZdGCmd9YpEB59HB6CLKIyr3w9Mb7dpfAtEbJCqw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 9711E2180075; Wed, 13 Oct 2021 12:21:37 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1345-g8441cd7852-fm-20211006.001-g8441cd78
Mime-Version: 1.0
Message-Id: <c84ef8d0-0ed7-4267-9952-d9a2bc053ad6@www.fastmail.com>
In-Reply-To: <YWYLRvUEkoudH5n0@pug.qqx.org>
References: <28ff3572-1819-4e27-a46d-358eddd46e45@www.fastmail.com>
 <xmqqk0ii3zl6.fsf@gitster.g> <YWXzGeiUSMeq5Key@coredump.intra.peff.net>
 <YWX8d/VTrkOz5tga@camp.crustytoothpaste.net>
 <YWX+6OgzN4CDzomO@coredump.intra.peff.net>
 <YWYCh3+37d27QNjW@camp.crustytoothpaste.net>
 <YWYE2LZp/EfoBpN/@camp.crustytoothpaste.net> <YWYLRvUEkoudH5n0@pug.qqx.org>
Date:   Wed, 13 Oct 2021 18:21:16 +0200
From:   "Alex Waite" <alex@waite.eu>
To:     "Aaron Schrab" <aaron@schrab.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Jeff King" <peff@peff.net>, "Junio C Hamano" <gitster@pobox.com>,
        git@vger.kernel.org
Subject: Re: [BUG] credential wildcard does not match hostnames containing an
 underscore
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2021.10.13, aaron@schrab.com:
> At 21:57 +0000 12 Oct 2021, "brian m. carlson" 
> <sandals@crustytoothpaste.net> wrote:
>>I also just checked, and RFC 5280 specifies the rules for RFC 1123
>>regarding host names in certificates.  So even if we did accept this, no
>>publicly trusted CA could issue a certificate for such a domain, because
>>to do so would be misissuance.  So this at best could help people who
>>are either using plain HTTP or an internal CA using broken tools,
>>neither of which I think argue in favor of supporting this.
>
> Or people using a wildcard certificate.

I didn't expect to kick off such a big discussion with this bug. ;-)

Just to add my 2 cents: the environment where I bumped into this is using a wildcard cert. It's among a fleet of (busy) internal domains that host data for scientific analysis. Lots of tools talk with those domains, and this is the first time I've been made aware of something struggling with the domains containing an underscore.

I'm not saying whether git should or should not change its behavior here. But the above is why I was surprised to learn the an underscore is not valid. Because everything (DNS servers, dig, Apache, and git itself) seems to happily use it.

In my view, the primary bug is how difficult it was to debug what was going wrong. This is most easily solved by improving the git docs to specify which characters will be matched. Even better if GIT_TRACE (or something similar) can inform/warn the user about matching.

In any case, thanks everyone for looking into this. :-)

---Alex
