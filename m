Return-Path: <SRS0=YYoh=45=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81504C10DCE
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 04:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5083C20736
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 04:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=jramsay.com.au header.i=@jramsay.com.au header.b="W8u20mx1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Bo9fmKpJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbgCLEHq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Mar 2020 00:07:46 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:32773 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725978AbgCLEHq (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 12 Mar 2020 00:07:46 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 74470220F8
        for <git@vger.kernel.org>; Thu, 12 Mar 2020 00:07:45 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Thu, 12 Mar 2020 00:07:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jramsay.com.au;
         h=from:to:subject:date:message-id:in-reply-to:references
        :mime-version:content-type:content-transfer-encoding; s=mesmtp;
         bh=nIB/IxO5oC182hffw2MOI+HEfqaR3o4MY/j1ze8B7as=; b=W8u20mx1cv7d
        9ayMFgx68S/BcQYeRK+sfiGizaxw6Ujqh99Cl6CNMOUClHdaUvqIEbFrLaMBffLU
        oDYf0D2RtTv8MaNo3RNMbycuCuA+LVaNXm80Ya+qL26YJV6Vk4dmhrxIJlyg61Ay
        4TTmBnZ+czLe+55OHX4koOjEC0UiY30=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=nIB/IxO5oC182hffw2MOI+HEfqaR3o4MY/j1ze8B7
        as=; b=Bo9fmKpJyyQjIyk1IRUAazBv9FGjRv705EsvZKAiVUaZITPWc7aATzdGz
        FmLH1GBT6YJn07gtD1N1i3y5lJjcf+x9Bh6yQceajswLw3k5rMsHDU4Ja/vz36dj
        P1OdDrMWGKBqXGCqB8xwuLSBaumqXjGQZ4xlZ6laLJNblFZqKZHz0VQ0zKgSruc8
        hc0OIyIuIGUZBilGoSrUL+IWvYEdo76o94l0X/ndLbEpF58Ww/X7zdv0e0wo6LKl
        a19PnHZRLFvANAmCQxp6PpQH/kiqYAqdW3Qk3Trq0IH67OglVq+HG9ggV1XQ0Qbl
        2n8Zjv791TM9LTdFPApRi0MSt3aVw==
X-ME-Sender: <xms:kbVpXs-7ybRs-J82QXWoexOiwUgT6FWdYmJZy246_eVM-_BN1588TQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedruddvgedgjeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffokfgjfhggtgfgsehtke
    hmtdertdejnecuhfhrohhmpedflfgrmhgvshcutfgrmhhsrgihfdcuoehjrghmvghssehj
    rhgrmhhsrgihrdgtohhmrdgruheqnecukfhppeduvddurddvtddtrdeirdduuddtnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhgrmhgvshes
    jhhrrghmshgrhidrtghomhdrrghu
X-ME-Proxy: <xmx:kbVpXhqvAXG_BtZsBBovxAic6oXTnKybi53KtunVUbtwICeqqOIF0w>
    <xmx:kbVpXtoH6g32SdcuK9DXtRfXkV7xJji4vzfdMQc-eSdGyxDevo8Zjw>
    <xmx:kbVpXk3C6aCaJbjD5mdZ_y5zL3uzbByf5zwuAxuXDruioUe8RMLCVw>
    <xmx:kbVpXkyRE9_qvwpkY8ngTjovG2_RiELNsdt8-22U03zjruB6rQH6Xg>
Received: from [192.168.1.38] (121-200-6-110.79c806.syd.nbn.aussiebb.net [121.200.6.110])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9866830612AF
        for <git@vger.kernel.org>; Thu, 12 Mar 2020 00:07:44 -0400 (EDT)
From:   "James Ramsay" <james@jramsay.com.au>
To:     git@vger.kernel.org
Subject: [TOPIC 11/17] GPL enforcement
Date:   Thu, 12 Mar 2020 15:07:41 +1100
X-Mailer: MailMate (1.13.1r5671)
Message-ID: <9D605928-2112-4EDB-85CB-806E4F895449@jramsay.com.au>
In-Reply-To: <AC2EB721-2979-43FD-922D-C5076A57F24B@jramsay.com.au>
References: <AC2EB721-2979-43FD-922D-C5076A57F24B@jramsay.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

1. Peff: Hypothetically if a company would not distribute the sources of 
a modified version of git they ship. What should we do about it? Should 
we take legal actions and make them aware that they are doing something 
they should not do? Making sure they also treat other projects better.

2. Brandon: Would we gather together with other projects affected by 
this company?

3. Peff: How hard do we want to take it on this company?

4. Ed: I’m also bothered by this. And they just send me a tar ball. At 
Microsoft we are aggressive about doing this right.

5. Jonathan N: Can we make it really easy to comply, e.g. by making a 
build target that contains everything?

6. ZJ: They could just push to GitHub. That would be fine.

7. Peff: I brought this up, because we were made aware of this by the 
Conservancy. So I wanted to hear how people are feeling about it.

8. Brian: A more aggressive approach would be appropriate if we have 
made them aware of the issue and they decided to not comply on purpose.

9. Peff: Code change doesn’t matter, whether it’s a security fix or 
feature. And I’m fine giving them a bit of lag time, like a day. Not a 
day.

10. Peff: You’re not obliged to send the source code, but you should 
provide the offer to share the source. In this case, they sent us a tar 
ball, but the sources are not on their open-source. So they probably do 
not yet apply.

11. CB: But everyone on Mac can request to send you the source code. We 
could release a form somewhere to give people an easy option to request 
this.
