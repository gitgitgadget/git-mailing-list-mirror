Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99546C433E0
	for <git@archiver.kernel.org>; Sat, 30 Jan 2021 23:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BC1164E13
	for <git@archiver.kernel.org>; Sat, 30 Jan 2021 23:28:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbhA3X1r (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Jan 2021 18:27:47 -0500
Received: from forward1-smtp.messagingengine.com ([66.111.4.223]:43637 "EHLO
        forward1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230168AbhA3X1q (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 30 Jan 2021 18:27:46 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailforward.nyi.internal (Postfix) with ESMTP id 2D5731954011;
        Sat, 30 Jan 2021 18:26:58 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Sat, 30 Jan 2021 18:26:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=xzAsjEufhCZAY2xO/bQ07jJyuublBqjq4yDNCqI2t
        T0=; b=DlDMXr5cJTOVJ3LUJAY/2/uhUtXIcBMjQmZf5D4tCC9TQDpfRzAKyHp3S
        OJlyhPju+iIuP5LeLm0c5wwZhLDTPErHr2nID57uRMueyIAk7Vbh6vo+QUUrP3Ao
        r50aXaac1Z9O2k9b5s4Zgq4aY7NCTFbuOm6wmQTPHYSXV1gDsBcvneaQCHwv/mva
        uGXY1w9jLCLSiRRhx006MjMtCIzPCYm77uyEF3JOk7uTyR46RyWlYIRsOWHI+3A/
        kBfeAbjfT0uoJQtwMPEThIppM7dFDewL91RY2oVBHYIF924p0Yop7YNppFsRNb5O
        QY5PuA8Yl8EUBPPAsfwA8c5o2NLZw==
X-ME-Sender: <xms:QesVYMv8lvZbajDKL3XpWflI3bffmWvicbXHK_2pBRkWsEKz6zbFpA>
    <xme:QesVYJcgggJJGH7E8BgWv4YNfpBSfJhsH37vaObUjM-4idd2xZr3S4cZPR-ojSxBM
    t-B9ebAjQHjTuDq6w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeehgddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfgjufhfkfgtgfggffesthejmhdttddtvdenucfhrhhomhepfdfmhihlvgcu
    lfdrucfotgfmrgihfdcuoehmrggtkhihlhgvsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehgeejhfduieeigfeikeejhfdttdehheetkeffteevleettdekhfetteev
    jeehudenucfkphepjeeirddukedruddvvddrvdefvdenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrggtkhihlhgvsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:QesVYHziQ--aBEScRtxKaPUXuDesozB4dEyuv0Vux8QFjkzjeQvdGQ>
    <xmx:QesVYPNClnT11qV76MTVDYC8VsHThvrx0zZHADthVzSDgfUpOqZnYg>
    <xmx:QesVYM-XaFIO59ziDaTsqVZ59xwnxBIAYNiPbnkbGPebxZbT6qbS3g>
    <xmx:QusVYAaJJXd3e5DejXNaHfuoGGJ4-9stcQ_t_pkJAb2v91awVADapw>
Received: from [172.16.16.105] (unknown [76.18.122.232])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4D45F108005B;
        Sat, 30 Jan 2021 18:26:57 -0500 (EST)
From:   "Kyle J. McKay" <mackyle@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
In-Reply-To: <xmqqa6sqp827.fsf@gitster.c.googlers.com>
Subject: Re: [PATCH 1/2] t/t1417: test symbolic-ref effects on ref logs
References: <7c7e8679f2da7e1475606d698b2da8c@72481c9465c8b2c4aaff8b77ab5e23c> <fec7ef37962da584a89012234ae4a1a@72481c9465c8b2c4aaff8b77ab5e23c> <xmqqa6sqp827.fsf@gitster.c.googlers.com>
Message-Id: <81AEEED6-26EC-4F32-AA65-B028435D812D@gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Apple Message framework v936)
Date:   Sat, 30 Jan 2021 16:26:55 -0700
Cc:     Git mailing list <git@vger.kernel.org>,
        Han-Wen Nienhuys <hanwen@google.com>
X-Mauler: Craptastic (2.936)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Jan 30, 2021, at 11:56, Junio C Hamano wrote:

>> Add a new set of tests to exercise and demonstrate this change
>> in preparation for correcting it (at which point the failing tests
>> will be flipped from `test_expect_failure` to `test_expect_success`).
>
> We usually prefer not to do the two-step "expect_failure first and
> then in a separate patch flip that to _success", as it makes it hard
> to see the "fix" step (because the change in the test would be shown
> only 3 lines before and after _failure->_success line, and what the
> test is doing cannot be seen in the patch by itself).

I'm having a bit of trouble parsing that into expectations.  A little  
help please.

Given the scenario that a bug is found that is not being caught by a  
test (irrespective of whether or not the outcome of this particular  
series discussion results in it being determined to be a "bug").

Further, if the fix is simple enough that it warrants only a single  
patch, what is the preferred order of patches then?

I would like the patch series to demonstrate:

1) that the test actually catches the bug (in case it comes back in  
the future)
2) the fix isolated (as much as possible) in a patch distinct from the  
test
3) that the test now passes, preferably with minimal changes to be  
sure that it hasn't accidentally been rendered ineffective

All the while, at no point after commits for (1), (2), or (3) is the  
test suite allowed to generate extra failures (that are not marked  
"expect failure").

patch 1/2 accomplishes (1)
patch 2/2 does both (2) and (3)

Are you suggesting that (1) just be omitted?  Or that it be modified  
so that it's an "expect success" patch?  But then (2) would break it  
and introduce a failing test into the test suite.  Should (2) then  
just flip the test from test_expect_success to test_expect_failure and  
then a separate commit flip it back to test_expect_success along with  
the minor change to the test itself to make it start passing again?   
In that case, there's always a risk that changing the test itself  
could accidentally make it no longer detect the problem anymore and  
just always succeed even if the problem comes back.

Without an initial expect_failure step (1), there's no commit in the  
repository that can demonstrate that the test actually catches the  
problem.

I understand that when new code is added, the tests come after, but it  
seems to me that when fixing a pre-existing problem, the test that  
demonstrates the problem should come first and be an expect failure  
since it is considered to be a problem.

What exactly is the order of test/fix changes that you're expecting to  
see here?

Thanks.
