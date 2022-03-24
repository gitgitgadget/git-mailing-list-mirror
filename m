Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 264B3C433EF
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 20:50:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354064AbiCXUwR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 16:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355231AbiCXUwI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 16:52:08 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6665539BB7
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 13:50:35 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id F39555C023C;
        Thu, 24 Mar 2022 16:50:32 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 24 Mar 2022 16:50:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=u92.eu; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; bh=+w/NnEAmzT0osd2ZsmK8eIcNY5QDZtBXO60BqZ
        Eyq8I=; b=SHI65bkz6ilPbyylX1nM8Wh5+oI2DgpKuSNOUiZN30k9izcgL6U0vX
        ob87T3DW3EoUe5YUoSH/D4jDf14HZh0huXoS3ft7dyroZ7nPlyqkYGz7qbW29Bek
        DcSZq+Fu2A/FdI1VtOU3Eh0QZMlsJCynJ/R6oYZpHp4Xv/2fM+xr9q8vlBl8xe96
        z/kIW5ipEqmebn0EPkwu2dS1nKrn74B3vIUP+oqa/j+SScSiYO/2OHDlRcs7AKkw
        plY0mFczGxK/h1ZU3FwLizIzPE0cEPxD20p1cG87k5XFugqugpv14jDu91AWYMjD
        JUB+MYlGM6ETLTmqNWn2kp5Fw3qwDRyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=+w/NnEAmzT0osd2Zs
        mK8eIcNY5QDZtBXO60BqZEyq8I=; b=d7IUe48Fe8M5uDDMKyEdJIsmgBDpHAqXk
        RLnH6tENQyUiUtevcUNzMXoavpVSr6/Cbu+WV6H/V7CcMnObVCyIEGjBwwp5x1q8
        P2lJG5kv6wI13zJusV7NFbAV7LtYuJYknWWwjMA8AQFuthi0O9H0ibnRRfDGxxwc
        PY3j4GQZYqBAeVLUs0ByzcGS7dvEPhvM0U6gf+/6TZLZNSfM1iLnyV0dIy7DUCpJ
        ZAtsX6PP9A/hd7+hkVt80ukq4tAcOAUUGxGG4ZfhiARJYxtCcrG1v8pOx7dY4RxR
        ajOXAgSeKXagZtURaYtI2+RFzwRFXuChI9YoyYEkJMIiHk4zGtYcg==
X-ME-Sender: <xms:mNk8YpeocRz84FxTB5uuSj8fJ4-AlEhdktHDYIzhOP9IVP5u73ntIA>
    <xme:mNk8YnOOBt8kaZKZw770mhOqvOF-McXrQqC6uDDp8IpOd-Nl_WUFFKNxRUMm4zT-9
    KiDC2hMyXucedXenQ>
X-ME-Received: <xmr:mNk8YihRKt2c6WCwsvMT5wSoOS0Ctq1md3JNQBLKjs1xww73KLLHAcvreiGJ0-WxOW3M5fipQ9Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudegledgudeflecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehttd
    ertddttdejnecuhfhrohhmpefhvghrnhgrnhguohcuoehgrhgvvghnfhhoohesuhelvddr
    vghuqeenucggtffrrghtthgvrhhnpeffgeetveeuieekvdefffefgfdvtdeuueeiheevie
    ekfefhgedujeefgfduvedtleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehgrhgvvghnfhhoohesuhelvddrvghu
X-ME-Proxy: <xmx:mNk8Yi_qsfWV0bQjSmu1crzqhm93cLmIh9QrzQcyXT1EmHt-Q0n_RA>
    <xmx:mNk8Ylu0vlaylIUq-y-VML0aD3RmYfLZejjMpgiRmR-Z3oMV7arPfw>
    <xmx:mNk8YhEpB_ThHAUKvYRzm3T0pqLPX3pjzzGLpqAZ6oEuMuaz3f-L6A>
    <xmx:mNk8YjV0MxFg1QxKUYWu-wZ-f_VLxBgGWwhnC2_JwBYT3D_9m3EbAw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Mar 2022 16:50:30 -0400 (EDT)
Date:   Thu, 24 Mar 2022 21:50:28 +0100
From:   Fernando <greenfoo@u92.eu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, davvid@gmail.com, sunshine@sunshineco.com,
        seth@eseth.com, levraiphilippeblain@gmail.com,
        rogi@skylittlesystem.org
Subject: Re: [PATCH v5 1/3] vimdiff: new implementation with layout support
Message-ID: <YjzZlAqlH6bXh8+4@zacax395.localdomain>
References: <20220319091141.4911-1-greenfoo@u92.eu>
 <20220319091141.4911-2-greenfoo@u92.eu>
 <xmqqsfr8sjpl.fsf@gitster.g>
 <29c787c2-8916-4d04-85c1-a4c0597b9848@www.fastmail.com>
 <xmqqee2rl2cg.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqee2rl2cg.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > In any case, if anyone knows how we could achieve the same without using
> > external commands, please let me know and I'll change it (in the meantime I'll
> > keep searching for alternatives too). If after a reasonable amount of time none
> > of us manages to find a solution I suggest to leave it as it is now.
> 
> I already said that this is good enough for now, didn't I?  But see
> below, and do not use it, it should work but it is uglier than a
> simple single liner pipe.

Hats off to the clever usage of "???..." as a regex to remove the characters
that are not part of the desired substring.


> > Should this be considered enough test for backwards compatibility?
> 
> Yes, with a bit to extend the proposed log message to help #1, and a
> bit of comments next to the test cases to help #2.

Good idea. I'll add both to v6.

Thanks for your feedback!

