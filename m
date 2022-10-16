Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C250DC433FE
	for <git@archiver.kernel.org>; Sun, 16 Oct 2022 21:22:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbiJPVWr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Oct 2022 17:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiJPVWp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Oct 2022 17:22:45 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB48D2AE37
        for <git@vger.kernel.org>; Sun, 16 Oct 2022 14:22:43 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 08DE732003CE;
        Sun, 16 Oct 2022 17:22:40 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sun, 16 Oct 2022 17:22:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mcclimon.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1665955360; x=1666041760; bh=F6FFyatXGDSMwOuARyLZXvtqX
        smBTYsOTHOkw1VL8CU=; b=Hr7xpij9E5aRlNQ5F8blTLCRvhH7MTuXi34BbQtz2
        TiShxUXruOFQPMRyNH3gYcOnKWJjAVg3Cg3lUEHm0wqsdRxlt+pBLgLslS4zkE3L
        BM+6ENar5e/9W3ed0REzp1AYlHAfb+qns1qitbYVqR98/Pz1fERKnYOuPwDUDDMA
        fa/pOCIYeYYOGEe9R0Z2CDGJiE2xy/ZRneL4nGnVPtACpF915vPDehlriHZxi1H/
        oXU1jGi8P5jbz1kQ0S8OfqD37CXaRuQhtBZloKEvgv2ZfIfwip/lK7yGnjQUklYE
        pDAmNpqk32DGwzum+pKscE3KHmbXQH931YbShnpFdw1Aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1665955360; x=1666041760; bh=F6FFyatXGDSMwOuARyLZXvtqXsmBTYsOTHO
        kw1VL8CU=; b=uWOua+GHnr6cONNlFzQr6JXnOPG79uk/Q9RBCbjAsnofScDWKwu
        GAV/4vnDueQbwDGPwc/GBhB9oZqW4WOqz4lHyjTmmo+6+I9r5jypWxM+7Odfr9Mw
        IVAvK/l1rkFa7SPLgNDGqFo2yNt1iLVhWGIn4Mt9wjPa4TmUJWudd+8+mPRy/pPj
        GDlbgT6hgzEpjMeguF9zr51M93p5d5vc1iSVeVaMH8w/4vfAMwNAQgh4zmTf0+a/
        JU1ZIe5OV3fue4P6pF8aeviYja3wRDAFJdSdLzV1qInvrSIkkhP2sByw+dPIqTAV
        59rldKIrKotiglTwuIOdsYjlBvfhVrIvG2w==
X-ME-Sender: <xms:IHZMY6zrhOYvc_CJzVz1a1ynSaPDHMw4UkBnnKWuK5mgI54BupCQbQ>
    <xme:IHZMY2T82kSShZ7WTmYE4rkc1YLMMwBL7CMPEcp3lRx0ZreItM4x8qNQReHpanPll
    4lvKNorHX6KgkTjfmI>
X-ME-Received: <xmr:IHZMY8Wmj2v3M9vINBa4qPK3Y6npsywYbEBZvV392eIgSTyCcmWUApf5Kmpzxc-38q2egm46L2v2iuKQSukQLBWAJz0Jg679Y9cghnupap-W>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeekjedgudeivdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekre
    dtredttdenucfhrhhomhepofhitghhrggvlhcuofgtvehlihhmohhnuceomhhitghhrggv
    lhesmhgttghlihhmohhnrdhorhhgqeenucggtffrrghtthgvrhhnpedvleekfeeiheefge
    duhfeiudekgffgvdfhjedtveehudduhfefkeetgfektdetveenucffohhmrghinhepkhgv
    rhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepmhhitghhrggvlhesmhgttghlihhmohhnrdhorhhg
X-ME-Proxy: <xmx:IHZMYwhsfrSdwZiKNKGb4OXE8LXmk1QCrGvvxOshq9-LW8kCu0dhWw>
    <xmx:IHZMY8DzhjLDq5dPUgNhQIyhaPMtP2_FPQUDa0oLxbe69mQ5dm_ugA>
    <xmx:IHZMYxLlWniQSvkvO_k4THrTMXWq3Owy-3vGL4VLYnRoRR9F4boikA>
    <xmx:IHZMY3r33rP8jb_KPLqHEbO8qBKnd67FrxKzueqCf2lExLmATh6cEQ>
Feedback-ID: i9dc944d1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Oct 2022 17:22:40 -0400 (EDT)
From:   Michael McClimon <michael@mcclimon.org>
To:     git@vger.kernel.org
Cc:     Michael McClimon <michael@mcclimon.org>
Subject: [PATCH 0/1] Git.pm: add semicolon after catch statement
Date:   Sun, 16 Oct 2022 17:22:35 -0400
Message-Id: <20221016212236.12453-1-michael@mcclimon.org>
X-Mailer: git-send-email 2.38.0.83.gd420dda0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When looking into a bug about Git.pm's handling of unsafe repositories [1],
I found the immediate cause of the error, which this patch fixes. This
patch doesn't do anything about the actual problem (Git.pm happily
continues to work in unsafe repositories), but it at least fixes the
runtime error.

[1] https://lore.kernel.org/git/20221011182607.f1113fff-9333-427d-ba45-741a78fa6040@korelogic.com/


Michael McClimon (1):
  Git.pm: add semicolon after catch statement

 perl/Git.pm | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.38.0.83.gd420dda0

