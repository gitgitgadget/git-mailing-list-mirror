Return-Path: <SRS0=YYoh=45=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D14FEC10DCE
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 04:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B748320724
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 04:04:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=jramsay.com.au header.i=@jramsay.com.au header.b="HE95yuUr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pe8lFZiZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387657AbgCLEEs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Mar 2020 00:04:48 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:58831 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726023AbgCLEEs (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 12 Mar 2020 00:04:48 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 093A021F18
        for <git@vger.kernel.org>; Thu, 12 Mar 2020 00:04:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Thu, 12 Mar 2020 00:04:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jramsay.com.au;
         h=from:to:subject:date:message-id:in-reply-to:references
        :mime-version:content-type:content-transfer-encoding; s=mesmtp;
         bh=Y/kgafgvHYVMGGG+bU5h5zCTkPtk5cUyqmODhol4X9E=; b=HE95yuUrjj6k
        YGw35IJzeRB6GI7P61phv/OKRGEksRB4q8k6FRgC3OcMwofY4Y8FeCbZdsBs0unL
        Gjzt8nCzNN1Hfdb5nSkHZQdJ/oKrh1CC88//oGXd0kgP6d6/IDFZREOl/aoLMy88
        QtEffTIrxXHVfS9BEwwjTDA/9PXYX38=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=Y/kgafgvHYVMGGG+bU5h5zCTkPtk5cUyqmODhol4X
        9E=; b=pe8lFZiZeMpexSiIWVVm/HGWJRW5zdNKZ++2ZFFXwXxVYTi9S670HU6cd
        K7yQzq34CgI/mzHuKRk8iKDEa35gkDIQE5kh2IgGWZ5MPZi27+M1IeHUlsJY3umg
        w27mUVeePVl7xNwZN5u20ybK/kHUBIvx3e/8ZPQZPTaGdRNWvfysJD0a+p9mbuyK
        1HDLTYGuej7Cfwnxsd2fRSpQHQ6Np+t3tfhoTkxkqOuIprp/iiXcjQttM6K1ZnCK
        AFy7L1n3lhjF/MhZEdx+ValpREZhoLXivOYNUyfskKImT4BaCahe9zuDbqo1ZEEW
        aekU2xi1MLhmhJnye9YqUAbZtmxwA==
X-ME-Sender: <xms:37RpXv7FQrZfnUU64Pags0tkzr0aYkvmhAgBK_zQnR90Nqq4JsUXJg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedruddvgedgjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffokfgjfhggtgfgsehtke
    hmtdertdejnecuhfhrohhmpedflfgrmhgvshcutfgrmhhsrgihfdcuoehjrghmvghssehj
    rhgrmhhsrgihrdgtohhmrdgruheqnecukfhppeduvddurddvtddtrdeirdduuddtnecuve
    hluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepjhgrmhgvshes
    jhhrrghmshgrhidrtghomhdrrghu
X-ME-Proxy: <xmx:37RpXsT3gHCbrGJzSlzu58lFxvKQ-mMokJHIoNY5LiZxUfBxXZDw5Q>
    <xmx:37RpXsCaASUcst5Tlw6PAMEJgINZHocU6kyFuMPrta6do3nNRZfZiw>
    <xmx:37RpXsE_-0aHsr4876vWyHyumvoMtxFax0gkXZs48mhAernfHkQFdQ>
    <xmx:37RpXoSaZ4j8vPGSaxfzVM2GFaSnZdp0duCNEaHeCa0HvT-B-Wzdjg>
Received: from [192.168.1.38] (121-200-6-110.79c806.syd.nbn.aussiebb.net [121.200.6.110])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2C2C93280060
        for <git@vger.kernel.org>; Thu, 12 Mar 2020 00:04:46 -0400 (EDT)
From:   "James Ramsay" <james@jramsay.com.au>
To:     git@vger.kernel.org
Subject: [TOPIC 9/17] Obsolescence markers and evolve
Date:   Thu, 12 Mar 2020 15:04:44 +1100
X-Mailer: MailMate (1.13.1r5671)
Message-ID: <9CE46D29-4BCD-4E95-B2DA-939EA10D7934@jramsay.com.au>
In-Reply-To: <AC2EB721-2979-43FD-922D-C5076A57F24B@jramsay.com.au>
References: <AC2EB721-2979-43FD-922D-C5076A57F24B@jramsay.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

1. Brandon: I thought it would be interesting to have a similar feature 
as Mercurial has. Mercurial evolve will help you do a big rebase commit 
by commit. Giving you more insights how commits change over time.

2. Peff: This has been discussed a lot of time on the list already.

3. Jonathan N: It will help with Googlers productivity, but it’s 
smaller compared to other performance fixes.

4. Brian: It’s a great feature and I would like to have it, but I’m 
not sure it gives enough value to someone to sit down and implement it.

5. Emily: Is it a good candidate for GSoC?

6. Brian: If we have a good design.

7. Stolee: It should be easier to use than interactive rebase.

8. Stolee: It would be nice to have instead of fixup commits I would 
send to you new commits which mark your original commits are obsolete.
