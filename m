Return-Path: <SRS0=YYoh=45=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D0CC1975A
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 04:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EAD820724
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 04:03:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=jramsay.com.au header.i=@jramsay.com.au header.b="RgI+Oq3V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sOnD3XlL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387453AbgCLEDs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Mar 2020 00:03:48 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:37703 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725978AbgCLEDs (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 12 Mar 2020 00:03:48 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 80DC521F18
        for <git@vger.kernel.org>; Thu, 12 Mar 2020 00:03:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Thu, 12 Mar 2020 00:03:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jramsay.com.au;
         h=from:to:subject:date:message-id:in-reply-to:references
        :mime-version:content-type:content-transfer-encoding; s=mesmtp;
         bh=5QbWcY+Rgxxkcqz26lKoLZ6aPHorIf/Hk3+nb3O0K2Y=; b=RgI+Oq3Vr9f2
        E8cGfhyRnfYnGPhsqnfNpoWLqPfslKWZrBOb4jV4XezUA+7iyJOh9ffzaXEsk8YA
        n++ctwBDe3kHYPFhayoSgMQZUcV0OifA9Dq5qJJ1iyII+Og2Muqrdst38zAWqSFC
        Eo1iiKd1U73YPZjWNWd0stQP5N4kn2c=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=5QbWcY+Rgxxkcqz26lKoLZ6aPHorIf/Hk3+nb3O0K
        2Y=; b=sOnD3XlLs5sRyoPLEsR0vF9EY+mNxPj+xKD3AUXogNpPtvscbin+IJ1Bl
        l+kc+GDQSY7K6HIVxu/ztuPxPNXus34tDP/7vvOguhGBzImpwCMv0JIELwPnq2OH
        HWHM9eRpwunCOvJGrE1JKd2DGPFmp99dq0Ka9+8MnQE7Gh6duMVp23uD0s/KHO2L
        KwenYunPmVaJwjM7FbWkCQMFrAkdKnDFInNlYA1zl0AUPrjcOh0aCCHW5YvEbMgT
        iiOlStXqeLkoHHRq5eBD3w9ot4JxieDd/YcrQiUC6ogqZPxhDjEYw7D5/k19xytx
        v4O9XZvli338DbDkl4CgmPhAIvdZw==
X-ME-Sender: <xms:o7RpXl8L7-k-G0Z4hrIHRlqFJ8QcPLMB8Afh5zHVZ3mKnirpv9Un_Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedruddvgedgjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffokfgjfhggtgfgsehtke
    hmtdertdejnecuhfhrohhmpedflfgrmhgvshcutfgrmhhsrgihfdcuoehjrghmvghssehj
    rhgrmhhsrgihrdgtohhmrdgruheqnecukfhppeduvddurddvtddtrdeirdduuddtnecuve
    hluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepjhgrmhgvshes
    jhhrrghmshgrhidrtghomhdrrghu
X-ME-Proxy: <xmx:o7RpXg9_CgSdxlP6DxEgdA7W0xoN9EHcugYsV3pPYlw65SJwz9CklA>
    <xmx:o7RpXt7a83piYoJk8CbkvPrDYVGvFCAaxnWoSvlV7N6y21flyqmuEg>
    <xmx:o7RpXpYsitjCY3WfHlv1abIEGglidNFb0MHQgIbSzjG5NT-L2mwx8w>
    <xmx:o7RpXiRH_jKmmOSUpVuH1Oxonx8zD74UMGuFaarSqRK0_CUN57NhJQ>
Received: from [192.168.1.38] (121-200-6-110.79c806.syd.nbn.aussiebb.net [121.200.6.110])
        by mail.messagingengine.com (Postfix) with ESMTPA id BA860328005D
        for <git@vger.kernel.org>; Thu, 12 Mar 2020 00:03:46 -0400 (EDT)
From:   "James Ramsay" <james@jramsay.com.au>
To:     git@vger.kernel.org
Subject: [TOPIC 8/17] Push performance
Date:   Thu, 12 Mar 2020 15:03:44 +1100
X-Mailer: MailMate (1.13.1r5671)
Message-ID: <E13E6610-10BA-4394-A8BE-AE91D621A0E8@jramsay.com.au>
In-Reply-To: <AC2EB721-2979-43FD-922D-C5076A57F24B@jramsay.com.au>
References: <AC2EB721-2979-43FD-922D-C5076A57F24B@jramsay.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

1. Terry: Chrome has 500MB file pushed up. Using Gerrit, feature work 
becomes stale over a few days, then push. For a few months pushes would 
push gigabytes of data.

2. Stolee: where we do the tree walk, we are doing it from the merge 
base.
Jonathan N: Minh rescued us by advertising more .have refs to avoid it 
being pushed. In protocol V2 for push there are 3 major changes 
proposed: one, abbreviating ref advertisement; two, adding negotiation; 
three, push to fast moving ref if you don’t care if its a fast 
forward. Are there other cases?

3. Minh: performance on reachability. Would help to know what branch you 
are pushing.

4. Peff: I might be pushing a random sha, without a branch.

5. Brian: I’ve seen cases with 80k refs, we tried then to send minimal 
amounts of objects. We spend a lot of time negotiating, to eventually 
only send 4 objects. It’s not very efficient, you could just spend 
less time on that and send a few more objects.

6. Minh: can we invert the pattern? Just send the new thing, and then 
the server says give me more.

7. Peff: You’ll get N+1 issues.

8. Jonathan N: I like Jeff Hostetler’s idea in Zoom chat. You can look 
at the branch and see when the author changes and use that as a crude 
heuristic to ask the server if they have that commit.
