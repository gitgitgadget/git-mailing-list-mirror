Return-Path: <SRS0=YYoh=45=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E452C10DCE
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 04:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54F5820724
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 04:02:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=jramsay.com.au header.i=@jramsay.com.au header.b="MxPm7kAs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SiuUk3eG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbgCLECx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Mar 2020 00:02:53 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:57479 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725980AbgCLECx (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 12 Mar 2020 00:02:53 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 168EB21FA7
        for <git@vger.kernel.org>; Thu, 12 Mar 2020 00:02:52 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Thu, 12 Mar 2020 00:02:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jramsay.com.au;
         h=from:to:subject:date:message-id:in-reply-to:references
        :mime-version:content-type:content-transfer-encoding; s=mesmtp;
         bh=WxTHbiev3t0qzyEj3Q81AEMRo0deiRrCnFCCB+q5FeM=; b=MxPm7kAs1B1c
        jWA4EVW5U5jM1RTEemhrqKdLoE/qU1AWvaHg1vKAByZ8ba1oTwAN3bhxwZPHLzrk
        xsceQJnUHXgJ4jmZE0OAnf/O3KSxAwR6ewFtl1Hmx1F3F3OBvB4H/j/n+/sI+Trl
        bBxU0+KwMe3E6PXvPo7xuBOdUDpU2Ao=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=WxTHbiev3t0qzyEj3Q81AEMRo0deiRrCnFCCB+q5F
        eM=; b=SiuUk3eGXQOTRmfOaD0nHDCQI0I3yoZEyItbY+SOirpAjR+EuBMAGJDsS
        xH6RGYez1jlmosefw2IlsEvs7oT/lt7v4XU8xCyDvyC9DpG0DTIVVHLCrEZQ5tcl
        njHHb1pmxVDDaeDghQS4TVgEzbXpvpcxpxi0pWuhbsggUsIv/a1qztAIy8lpcT1Y
        cVDLzrz4Cd1LSv05KZqSISoM6fckX7wXqdTmU2gCcww2hI7ZUt4uLW1M30LSgrQc
        z8hJ+Y0xkV5w/TYVNAR8Bor+UpTbnO4DSiYbzAe0WsU2tTxaKaZj9gsL0YjgYA8x
        2dTSAJhVeiQAN9rldlTbocEoC2xsg==
X-ME-Sender: <xms:a7RpXl4bKi1QAW4zpr9aNOkBaCxjmsHImxB4UX3X7KupxlnTNIlAJQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedruddvgedgjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffokfgjfhggtgfgsehtke
    hmtdertdejnecuhfhrohhmpedflfgrmhgvshcutfgrmhhsrgihfdcuoehjrghmvghssehj
    rhgrmhhsrgihrdgtohhmrdgruheqnecukfhppeduvddurddvtddtrdeirdduuddtnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhgrmhgvshes
    jhhrrghmshgrhidrtghomhdrrghu
X-ME-Proxy: <xmx:a7RpXsVQbXvh7FcknA2o6tg3Sgl7il_A39UsvqYq13uJd9NgdOVAsw>
    <xmx:a7RpXsCvTl7tYIOuAHYDEosIWbK-ND-tJZJaVg989gNrnlJzzPoCxw>
    <xmx:a7RpXj5oUuYkHqCAVPGn6SsBMIdqZmlw28YF767OeWtzKODjOWBYaQ>
    <xmx:bLRpXkYG-32BrduFXpu1Zim8-Rkwh4BMNlMaRuHg8C5-4zvubR6Pzw>
Received: from [192.168.1.38] (121-200-6-110.79c806.syd.nbn.aussiebb.net [121.200.6.110])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6A568328005E
        for <git@vger.kernel.org>; Thu, 12 Mar 2020 00:02:51 -0400 (EDT)
From:   "James Ramsay" <james@jramsay.com.au>
To:     git@vger.kernel.org
Subject: [TOPIC 7/17] Background operations/maintenance
Date:   Thu, 12 Mar 2020 15:02:48 +1100
X-Mailer: MailMate (1.13.1r5671)
Message-ID: <35FDF767-CE0C-4C51-88A8-12965CD2D4FF@jramsay.com.au>
In-Reply-To: <AC2EB721-2979-43FD-922D-C5076A57F24B@jramsay.com.au>
References: <AC2EB721-2979-43FD-922D-C5076A57F24B@jramsay.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

1. Stolee: Are we interested in having a background process doing 
things?

2. Emily: There are a lot of different ways to do this. Even only 
looking at Linux there are different ways.

3. Stolee: Without looking at how? What background operations would we 
like to have?

4. Emily: Is it a good candidate for `git undo`? To keep track of what 
the user was doing and to make it possible to roll back?

5. Brian: It can run into scalability issues. Also there might be repos 
on my disk that never change and don’t need background processing. At 
GitHub we do maintenance based on the number of pushes.

6. Stolee: Kind of maintenance will differ from client and server, 
interests are different. For Scalar we have this one process looking at 
all repos and will do operations on them.

7. Peff: On server-side you’ll have millions of repos and even one 
process looking at all processes have impact on the system. Most hosting 
providers already have services taking care of this, so I think this 
feature is only interesting for client-side.

8. Brian: We should be careful. For example I’m constantly creating 
test repos in /tmp.

9. Stolee: Thanks for the input, we’ll do research and come back to 
this.
