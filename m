Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB39C433FE
	for <git@archiver.kernel.org>; Sat, 22 Oct 2022 01:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbiJVBTx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 21:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiJVBTw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 21:19:52 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703D7564FA
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 18:19:49 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 7C4EB5C00DB;
        Fri, 21 Oct 2022 21:19:48 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 21 Oct 2022 21:19:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mcclimon.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1666401588; x=1666487988; bh=5H
        C9ZnoYCMtyR56zcNACSDrGFbj16enHjY9Mnp1sLN4=; b=OLWx3GXihvSce/dc4g
        LZNZbtejk8o3RiIvQFnglRikkZZFXJO7pszw5t9e/5KzVm8exvPtjw6xo3p7GeXE
        /hIz/9Y8q4HVnRda6s2n1IU1lyIg8MA1Hds3cqVHmgjs44wotby1m+R93HwnmQum
        lZpcrcmcSt2rsDb5C1nr/KMxcPz3A4YQ35VzyHaEFt2/AKj+fJF8v8FQWZgizD6/
        8KKydGEnW1OGKvU6c+q7DekMCr8DooUkwkD/JKXlMMD2+JbQRCEB09CFq3QnNcJR
        M968tLKlIbKPgZce/rca+XE35vH4YH4peEmLE2zTJj7dCYpW19Evgs1lT0OgiRGM
        dnrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1666401588; x=1666487988; bh=5HC9ZnoYCMtyR
        56zcNACSDrGFbj16enHjY9Mnp1sLN4=; b=jIN9vHuL/UEHAEtmeJhGsfbhyYJLO
        XX9q2nI5z/a1hmlQREQ8m/guei5yQTBSr8IbBPXXo/N6tBmYdqcqEoBhF5ihjdV3
        1gsBJCtLYf4bWl5179OT0exyqVn8nVRejNDnhzxBuJZCqkUXrDf+ecFpHbBbM+xx
        AaXW08z8UFIjW8hLtR/GpT2cH8UxOlYKtshcpTuL/oiDQJAM7479yyxGVl5Te8vA
        hKIl4o/bJOBxTMZ2MtFay9eAyETut7oa7psBvjtNQLwHokty94nsq33UFsR5vGFY
        xJOm/uvtzoDbFSYrhKP7mWO56wosssz4WTAAcuR0CRBj+Bwn1DVXArdcg==
X-ME-Sender: <xms:NEVTY4jAl-5UoIaZ3lJGjg9Co76UnUldUZzNnO11sgsUzRcWNKutKA>
    <xme:NEVTYxBG7aJnJ9TqyjTwDAnAefmle_n4K-lqkRzTOmuvSg-sWoCxS5meyn9VLh2oX
    97t9Mm6SFHVeUcb3Ck>
X-ME-Received: <xmr:NEVTYwGNGfrc7w19apndGvOmuyP0_emkdf8ldM-T6jXDz78NRy1NZ5SRvax6nO-05KN010FFF2mpmAnxPpTskt9nSpJfPc8PiSvweGlHsGoF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeelledgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofhitghh
    rggvlhcuofgtvehlihhmohhnuceomhhitghhrggvlhesmhgttghlihhmohhnrdhorhhgqe
    enucggtffrrghtthgvrhhnpeeggfeuheeivefhvdeufedufeeuieehtdehveefhfduheef
    geevieejjeekffehvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhhitghhrggvlhesmhgt
    tghlihhmohhnrdhorhhg
X-ME-Proxy: <xmx:NEVTY5RbX5HmjkmB5bYfodmZiTcErJeQum7G1VkdXLvTwP_d6CPuQw>
    <xmx:NEVTY1y6lJLaQ24GR4yjwEJ5I5ruRZI2Tnp0lgwOWswrAJGJfZ3MOA>
    <xmx:NEVTY36deB77Jf8cL_XJGgksZdkw_m5WpkzRbv29DPOruMKjquEV8g>
    <xmx:NEVTYw83AhV3Gbr5z_dxj-TKAsuouAK8k0S4Tra0nXxwI3kPSiJBMQ>
Feedback-ID: i9dc944d1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Oct 2022 21:19:48 -0400 (EDT)
From:   Michael McClimon <michael@mcclimon.org>
To:     git@vger.kernel.org
Cc:     Michael McClimon <michael@mcclimon.org>, Jeff King <peff@peff.net>,
        Glen Choo <chooglen@google.com>
Subject: [PATCH v2 0/2] Fix behavior of Git.pm in unsafe bare repositories
Date:   Fri, 21 Oct 2022 21:19:29 -0400
Message-Id: <20221022011931.43992-1-michael@mcclimon.org>
X-Mailer: git-send-email 2.38.1.130.g45c9f05c
In-Reply-To: <20221016212236.12453-1-michael@mcclimon.org>
References: <20221016212236.12453-1-michael@mcclimon.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This adds one commit on top of the last version, to avoid the security problem
mentioned by Peff at [1]. It's possible this isn't the best way to go about
this (and I would not really call myself a C programmer), but it's a minimal
patch that seems to fix the problem.

I'm not sure if I need to document the new environment variable somewhere or
not; it's really an internal-only thing, so I didn't do so this time around,
but happy to if needed. Thanks!

[1] https://lore.kernel.org/git/Y1ImS1Muvk1MAQeC@coredump.intra.peff.net/

Michael McClimon (2):
  Git.pm: add semicolon after catch statement
  setup: allow Git.pm to do unsafe repo checking

 perl/Git.pm         |  3 ++-
 setup.c             |  3 +++
 t/t9700-perl-git.sh |  4 ++++
 t/t9700/test.pl     | 18 ++++++++++++++++++
 4 files changed, 27 insertions(+), 1 deletion(-)

Range-diff against v1:
1:  1337c855 = 1:  1337c855 Git.pm: add semicolon after catch statement
-:  -------- > 2:  273f77d1 setup: allow Git.pm to do unsafe repo checking
-- 
2.38.1.130.g45c9f05c

