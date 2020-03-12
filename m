Return-Path: <SRS0=YYoh=45=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99785C10DCE
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 04:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BE8A206F7
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 04:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=jramsay.com.au header.i=@jramsay.com.au header.b="dmiSWUkU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="1JNbDTTx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbgCLEJl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Mar 2020 00:09:41 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:51305 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725980AbgCLEJl (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 12 Mar 2020 00:09:41 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 5BB1521F5A
        for <git@vger.kernel.org>; Thu, 12 Mar 2020 00:09:40 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Thu, 12 Mar 2020 00:09:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jramsay.com.au;
         h=from:to:subject:date:message-id:in-reply-to:references
        :mime-version:content-type:content-transfer-encoding; s=mesmtp;
         bh=tH9pR5VONzoaTq8OSl9I2Y8uECKyagNjFI0hN0ZR9Qo=; b=dmiSWUkUp1Vc
        3VLkGjcXszfRW/T/b2PibDfcv30n7joy9PGZOYRMehzlPQro/VM0deN0BASJalpb
        FfPFxxJdHQM+DolphvbjTO4jaWLT/F5EFu2sQIRo/NXzhJPKHG1dvkWYoUgUdK69
        Zm+UmAayRQeDHbNlrZK/1D0GVVS7Ag0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=tH9pR5VONzoaTq8OSl9I2Y8uECKyagNjFI0hN0ZR9
        Qo=; b=1JNbDTTx73M6/6VS93yba7/WK3kHf64nkBh9+YB/bgprtJRP9Vo85rAc/
        pgGpOJeQT9wcewW5+9+iUpTw9i+oTkYdVv3ante1g28oC5EQy/eR0Ey7Ham3mjsB
        1LreIjdL6ABRincqe4HqsjRW6ogtuve9MI7B4KIkS1mBPIQIzqRX5n7b7vLzSXZh
        8UNavGWufYhmDnySt25s9domkRXEQn4L2C8ZD1CQS3le/LD84zxOG/BJ8w4CsHXm
        oioy+yvM4pnAQ28GNYWXQ3bYfheOoKr7mb/bvBXUpDnNB57djbjNgEGX7qaxJja1
        R1wA+4HqIsRwlKAjzvZJTkwnSNghg==
X-ME-Sender: <xms:BLZpXpZQ_bdRgOqGFCrF91ACoLU8D5AFZOyP695LW-DURvDqKojBXA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedruddvgedgjeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffokfgjfhggtgfgsehtke
    hmtdertdejnecuhfhrohhmpedflfgrmhgvshcutfgrmhhsrgihfdcuoehjrghmvghssehj
    rhgrmhhsrgihrdgtohhmrdgruheqnecukfhppeduvddurddvtddtrdeirdduuddtnecuve
    hluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepjhgrmhgvshes
    jhhrrghmshgrhidrtghomhdrrghu
X-ME-Proxy: <xmx:BLZpXrYkZr2hozIMwcciStqzlGbF74NornIYzjj2F1SJVsAM6fTxpw>
    <xmx:BLZpXil4CeS18ttu4LFV1n-dNSDqtnI3ktKToiHWoz2F6JCb4VHnqw>
    <xmx:BLZpXlQREu1T4aTfElVl0k1-q_clMnUyroHWp1rPOK61nsyAkP-DYg>
    <xmx:BLZpXjrM1cs4JtnXvfnDNVxZ3RBGM0_b66tdRYw2ruCP-UlqU5jdrQ>
Received: from [192.168.1.38] (121-200-6-110.79c806.syd.nbn.aussiebb.net [121.200.6.110])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9C2C13060F09
        for <git@vger.kernel.org>; Thu, 12 Mar 2020 00:09:39 -0400 (EDT)
From:   "James Ramsay" <james@jramsay.com.au>
To:     git@vger.kernel.org
Subject: [TOPIC 13/17] Cross implementation test suite
Date:   Thu, 12 Mar 2020 15:09:36 +1100
X-Mailer: MailMate (1.13.1r5671)
Message-ID: <66774F5B-E37F-4676-9274-0066EC38CC48@jramsay.com.au>
In-Reply-To: <AC2EB721-2979-43FD-922D-C5076A57F24B@jramsay.com.au>
References: <AC2EB721-2979-43FD-922D-C5076A57F24B@jramsay.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

1. Carlos: some aspects are under specified, or work in very specific 
ways, but need agreement of correct behaviour. For example implementing 
a command line tool that will have expectations, or expected repo state 
so another tool can generate the right output. For example libgit2 
keeping up with ignore rules. How does JGit handle this?

2. Jonathan N: JGit has some tests of matching behavior which I do not 
like. Invokes git-grep, generate patterns and compare output. Having 
non-deterministic tests is not great. I like the idea of table driven 
tests, common data, but different manifestations of how you test those 
things.

3. Patrick: config formatted tests, need to write drivers for other 
projects. Stopped because writing all the tests in this format was not 
fun. Basics work though. Spoke to Peff 2 years ago, likely easy to write 
drivers for Git.

4. Peff: already replaced tests with table driven, and prefer that. 
There are table driven tests for attribute matching.

5. Brian: valuable for LFS. Know attribute matching is not up to spec. 
Could benefit from the tests to help identify gaps. We are MIT licensed, 
so we can’t just drop them in, but we could import them in CI.

6. Peff: make whatever is in Git as authority, add tables, and then 
these can be used by other projects.

7. Jonathan N: example is diff tests
