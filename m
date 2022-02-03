Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C798C433F5
	for <git@archiver.kernel.org>; Thu,  3 Feb 2022 07:49:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232950AbiBCHtD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 02:49:03 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:50739 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229746AbiBCHtD (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 3 Feb 2022 02:49:03 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 998935C018A;
        Thu,  3 Feb 2022 02:49:02 -0500 (EST)
Received: from imap46 ([10.202.2.96])
  by compute2.internal (MEProxy); Thu, 03 Feb 2022 02:49:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hurrell.net; h=
        cc:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; bh=9U37CiIfKSKlgL4iTQU8nKo4jtosavV2qS8Q6z
        bXDSQ=; b=VsqUMDzcLlrH+OskZY1zkeNKuBHCiV2MEqJl/3E2MosbufYozo4G7E
        KCg9r4JWoQbjPSF4C0AfcJ9e0lzzMCtHNzZ75qxL6IS6IRoZQ8ApAltS6s7SCCnI
        xTv6+Txkjf4BHTIkKDlekYUpYY4d7U4Q1jcK4TJsYmz2CUycUETPKbzZPeQImxSt
        F8kDW9TuDINhnMD2CmqnuU4cb1IekOdj7uwRd5LktJ/5nxU4gVvcHadx1EX9ewNp
        VjZdQlEUEp3W9NLiFwcQ94ykRQ0CbK8xRkejG0B6QuNwNpBa5pqNdt97kJTn5qfj
        VKhAgg60qhhJCPTieJQdw3T7j51qrmqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=9U37CiIfKSKlgL4iT
        QU8nKo4jtosavV2qS8Q6zbXDSQ=; b=V9oeXgcDbqS5Q77jtw09mcOh98jiHQX7p
        9KPQzDEpcWhidmYNmmI1+/UVoupXxFRyKaM8agJ3WxrBOm7aFYk8bWLe2uLY5qY2
        iU23z3cKcHSunFHqJzXoP3hck2a0cqGLGo5anDt8OiFJ5ypLlHom6XJFjvry5gsm
        d3AirP0DQkL3czd/xIQ8cIsHr6Q6//+m6FsMUwmfRHR5mxMcRRCcWZX9tlM3AAlx
        3tgBgtDTn1PLLTAPg7wYHviy4edBCUdsoJewRDJMBd2MnQqAP+sLdrqCv5ZeEJYq
        CS+g2SL3vPkRJLlFX+uBmw2cxpd16qGY1axSJrKvdYxAo+rdfSfFg==
X-ME-Sender: <xms:7oj7YanSwVWm2wBFinj1xV7wbCohLGkHbMj8xMF2uN2qHwqNcMfq1w>
    <xme:7oj7YR2kjLAzORM5Qbuqksb7sQ62MDzvNlVGojswp2IAjFY7Qkz1Po3RgYkluSYsx
    2Qd28ADcqHUd6f2QdY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrgeeigdduuddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfgjfhffhffvufgtsehttd
    ertderredtnecuhfhrohhmpedfifhrvghgucfjuhhrrhgvlhhlfdcuoehgrhgvgheshhhu
    rhhrvghllhdrnhgvtheqnecuggftrfgrthhtvghrnhepuedttdevtdejiedtgfefveevfe
    elkeetudeljedtjeeuhffhkeekveetfeevvdehnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehhuhhrrhgvlhhlrdhnvght
X-ME-Proxy: <xmx:7oj7YYpGcO-YLFjvs5qs2YDNl31Kop6JA_w_VK-Ln_Wj4BfrM1IkGw>
    <xmx:7oj7YelwScqb-rc0zlddtKtqi2go78TyLkGYrfRrQ2d1CBYsWIqNfQ>
    <xmx:7oj7YY0txn0k3T7k4MmR___dN1dB6GOA2yGjh9-FI2hMMogM0NKBGQ>
    <xmx:7oj7YZhdBEcHbzzR29oj64nB4lIRiBVhYrB9wjtc5eIZUxIwl6lPNw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 4B9631EE043A; Thu,  3 Feb 2022 02:49:02 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4585-ga9d9773056-fm-20220113.001-ga9d97730
Mime-Version: 1.0
Message-Id: <6a898459-ee74-49b1-96cb-98fd766d082d@beta.fastmail.com>
In-Reply-To: <YfsMYTo1tND5JKNx@camp.crustytoothpaste.net>
References: <ee1dd453-e698-440a-911b-d14389e33715@beta.fastmail.com>
 <YfsMYTo1tND5JKNx@camp.crustytoothpaste.net>
Date:   Thu, 03 Feb 2022 08:48:42 +0100
From:   "Greg Hurrell" <greg@hurrell.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org
Subject: Re: git-checkout doesn't seem to respect config from include.path
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 2, 2022, at 11:57 PM, brian m. carlson wrote:
> This definitely doesn't sound like the expected behavior here.  It's not
> clear to me why this is happening, but it probably shouldn't be.  It
> doesn't appear that we fail to call the config callback, since we've
> been doing that since 2010.
> 
> What version of Git are you using that's not working?

Initially noticed on v2.30.2, but you can reproduce it to similar
effect on v2.35.0 (ie. add an invalid "merge.conflictStyle" value
like "fizzbuzz" to ~/.gitconfig, and a valid one like "diff3" to
a file pulled in via "include.path", and you'll see the same
behavior).

Cheers,
Greg
