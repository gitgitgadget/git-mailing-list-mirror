Return-Path: <SRS0=YYoh=45=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F3BC10DCE
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 04:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B92820724
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 04:08:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=jramsay.com.au header.i=@jramsay.com.au header.b="fY//0q3b";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YeiHXcuU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbgCLEIy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Mar 2020 00:08:54 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:43195 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726023AbgCLEIy (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 12 Mar 2020 00:08:54 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id E31CF220DB
        for <git@vger.kernel.org>; Thu, 12 Mar 2020 00:08:52 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Thu, 12 Mar 2020 00:08:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jramsay.com.au;
         h=from:to:subject:date:message-id:in-reply-to:references
        :mime-version:content-type:content-transfer-encoding; s=mesmtp;
         bh=jVcUQ2F+Y1d6n29jJZyJWJZqHCoRL3UMz5R5ckiUp9c=; b=fY//0q3bx0ps
        ymkq8W7TkfCAwNekdt0I4UUU199BvA99hihiZo5Z+kDKSzJGf1KYoNw71FTKk7bc
        LvI3oaD+hmQGTgMc4hqHtbNP9YD/bFetOLh0HoJZRBUC6yetb/YJ1U3qe7XdyZ10
        zKd6bBkCbVn2gBvMRIPyn5EeviVBqV4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=jVcUQ2F+Y1d6n29jJZyJWJZqHCoRL3UMz5R5ckiUp
        9c=; b=YeiHXcuU8u1mtd0i+h9dcsSkvVUMX6wJWXFbCUtcBN5ZEpncWBoGRNTaZ
        ESbBymGRbmkouAaTsTDeKXFQ5TsBxShzcXBG08hKzeK+G+020qBoveUuNhf8+Jbx
        +mVumFik008AazPo/nN5sGiE34zA58RK7Ms83Nxt7n5MRjWsFKcpukhWb+qpEl3d
        7p5KdbNVGWao/FCls2+6ICanVMFsQR6xq6Z4TZdgKgqgUtcmjDgcXMzXWt/LBbBE
        0Iinve9jIQOUt4TYasjZ3TV7aj72JWNlggxZ3u7Q1xUaUDih9CigP+bb3n4w6TSI
        GKmIWMsRLtnERocjw+FjeJJFDvtNQ==
X-ME-Sender: <xms:1LVpXmO9Yny14hxu0zxIv6GdQPZMjNRhPbmYf_oihdD--7i7oTxKjg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedruddvgedgjeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffokfgjfhggtgfgsehtke
    hmtdertdejnecuhfhrohhmpedflfgrmhgvshcutfgrmhhsrgihfdcuoehjrghmvghssehj
    rhgrmhhsrgihrdgtohhmrdgruheqnecukfhppeduvddurddvtddtrdeirdduuddtnecuve
    hluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepjhgrmhgvshes
    jhhrrghmshgrhidrtghomhdrrghu
X-ME-Proxy: <xmx:1LVpXk0UWD7vfs8NClEhJx8k2pAv_ls2xPex1qNffnHKQdYVNvVwgg>
    <xmx:1LVpXqnZkYHDsRzDHayms0-PZg5yz8anbiakXM_x2DTSXJGdNLuafA>
    <xmx:1LVpXi46JFLst2KUkV9whMuyLi2N_ePEN8oaanG-zzwYxMm12OQZlg>
    <xmx:1LVpXlPUtvpX5NTnLUQmb2PT-iKg6pVcEZ_1qViBvCcMaEnbCkNBWw>
Received: from [192.168.1.38] (121-200-6-110.79c806.syd.nbn.aussiebb.net [121.200.6.110])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2F7273061363
        for <git@vger.kernel.org>; Thu, 12 Mar 2020 00:08:51 -0400 (EDT)
From:   "James Ramsay" <james@jramsay.com.au>
To:     git@vger.kernel.org
Subject: [TOPIC 12/17] Test harness improvements
Date:   Thu, 12 Mar 2020 15:08:49 +1100
X-Mailer: MailMate (1.13.1r5671)
Message-ID: <A39F6554-8D11-4181-A615-C6562D851716@jramsay.com.au>
In-Reply-To: <AC2EB721-2979-43FD-922D-C5076A57F24B@jramsay.com.au>
References: <AC2EB721-2979-43FD-922D-C5076A57F24B@jramsay.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

1. Jonathan N: Test harness is an important part of the development 
process, shapes what kinds of tests people write. What can we improve?

2. Peff: I love our test harness

3. Brian: It’s amazing for integration tests. For our C code it’s a 
lot harder to do unit tests. We sometimes have a portability issue, 
about POSIX shell vs others.

4. ZJ: I like how it also acts as a piece of documentation.

5. Jonathan N: If we had more unit tests: if I am working on refs, I 
might like to run all tests related to that. And now we have this lack 
of dependency graph between this

6. Peff: I’m super nervous about that. Tools like code coverage could 
do this. But I’ve seen cases where all new tests are green, and tests 
in the area I expected they succeed. But at some far corner it seems to 
fail. So you’re optimizing for speed, might be losing in correctness. 
I’m biased because I can run all tests on my computer in 1 minute. But 
for Windows this doesn’t seem to work that.

7. Peff: We can spend time on speeding up things, making it better 
parallelized for example. I’ll send some patches out on this.

8. Jonathan N: Really nice contribution to Git by David Barr, whose 
background was as a Java developer and thus the code was written in a 
Java way with clear API boundaries and unit tests.

9. Brian: Yes if your function is doing too much, it should be split up 
making it possible to test the separate pieces and then have a function 
that calls those and tests the end result.
