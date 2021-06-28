Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3827C49EA7
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 05:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC65A61A0F
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 05:29:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbhF1Fbk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 01:31:40 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:54929 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229692AbhF1Fbg (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 28 Jun 2021 01:31:36 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 769DC32004AE;
        Mon, 28 Jun 2021 01:29:07 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 28 Jun 2021 01:29:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=beshr.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=M6ribsrRkWWxsxvWyy9Il9BsBl
        ovybyefr3dpZO8WEw=; b=G7VnH153zlzgKpKtXdNzTRK2kJv+KnUJuFwn1/R16l
        599lTN890I2arTl3YYaU1zV4AJcin22IQ8EB7GZoXM86tOokt9OERZLrU8xP99/D
        Xidag1csJzTBMj4gDVQqBJMXunhCl+DvbaIJj0WwYw740bgQM/zVNO1ioVCx4o+O
        ZyqHs/YyHSnJltZ4M0STogzAL9JGV+OWNhL0T7qkS9+SjTIywVlJY7C5hZuK5a6C
        8xlRGfPyFCancKKI4PTyi7k9GvSJ7vClas2bS4pt7cR8jupgIqlYsQh2IHfRLTkX
        2WU9kwVyCBuKLHlyxjqDA6+QWmzqzJ6V5OWa7HsxVw4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=M6ribsrRkWWxsxvWy
        y9Il9BsBlovybyefr3dpZO8WEw=; b=ahtVP05m29I4BTTfrVN8tGHSHqzRbwwhd
        KxmhEwtANq/CqnRDIwTCRFffCGYWN278ncJ7RqqZMHw1+vtdxIHPVV6Ma+knXUU6
        LdoGc7A9RRpsukPjDVEO4T5gUj+v07BvH7ZFl+8z9bJWud02DWrOKMx2TN6cYrbK
        jCGm2b8dgHfnc6LefV/JL85E2edowhakqDr8jH9MbeqTcr9/C/46wWDi3nC3EA/q
        CR2+wV2UwXLGkYayQP0NhfLFWHkBmae71IdBvnSq89GcEgrVOCc0BjT2XT8RC43q
        4TW/lUwwNOWplDmdGWWxcucIsfyY3e0DhC8hXqV/6iiLHDbj4A3xQ==
X-ME-Sender: <xms:Il7ZYFUCHR_H8-XrCakn1Qy616You6hT5-vSaeG7QUXCo1h4qZJveg>
    <xme:Il7ZYFl4xHNo0WK1ai82lgL9FUgiCXU5FMDqjhYjVekGTyyCtHL2CHLbHRN3TwMFS
    oORFxwCdSaJhKmBlMU>
X-ME-Received: <xmr:Il7ZYBaMM-YKRECrWFo_MxIgo39E3jb5iRLZBxI5dAykHHU8IAIhGh5EHwH2nLEBuF1Ie-MJmPtjAsxHbaYo51xtL_6-FKw0V-fFYUS1X2pBTy1RqA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeehfedgledvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomhepuegvshhhrhcumfgrhigrlhhiuceomhgvsegsvghshhhrrdgtohhm
    qeenucggtffrrghtthgvrhhnpeduveettdekheejleejjedvteeigfefffeuheegudefke
    ekffetjeeiveeugfduudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehmvgessggvshhhrhdrtghomh
X-ME-Proxy: <xmx:Il7ZYIXV-dA2UaJQXxk0Q7KpsX6699Z5e39MMZLyHF2D19RACcX2Zw>
    <xmx:Il7ZYPkrFdkWCjcYZPFLlEKQI1I_OSnnTi5uAFdexJPEvpunA7nsoA>
    <xmx:Il7ZYFcL-GsI6x7u2KLt6Yy5E5ZvyE9ufQhP9K7W3HjiYTGpMizXSg>
    <xmx:I17ZYOvVIcK__OwfSFCSDag6q9MZMW6IQVVs0ZVzxypgMPRh62MayA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Jun 2021 01:29:06 -0400 (EDT)
From:   Beshr Kayali <me@beshr.com>
To:     git@vger.kernel.org
Cc:     Beshr Kayali <me@beshr.com>
Subject: [PATCH 0/1] fix a typo in patch option of the commit command
Date:   Mon, 28 Jun 2021 07:26:30 +0200
Message-Id: <20210628052631.345601-1-me@beshr.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Simple typo fix (chose -> choose) in the documentation of the patch option under the commit command.

Beshr Kayali (1):
  Documentation: commit patch typo

 Documentation/git-commit.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.32.0

