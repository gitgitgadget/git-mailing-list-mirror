Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB8BC4332F
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 01:16:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbiJUBQo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 21:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiJUBQn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 21:16:43 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E7A202703
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 18:16:42 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 3311132008FC;
        Thu, 20 Oct 2022 21:16:40 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 20 Oct 2022 21:16:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mcclimon.org; h=
        cc:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1666314999; x=1666401399; bh=VJ7MSQ3Aez
        QaHPTNxrj7gt+4vEfgAatVbyGUB3fvZq8=; b=cTPfY1hub6hyoPTjURGK2qeGNx
        MSjSTdL6KoOQryv85NX9/xUwHjZcQt6W29EDrXXPRMF97aCMPkdi2oBOxHtGjpsC
        uP3SjIMN+QM3ApSMl3CTPtyAmAFAqfMf7Cnwbu5CkZqd4IO+JAT/dxEMikhTDRJM
        M6tnHLPsitx0EG/Bwmnp/ffdvnrqMg30f0aOvFnZVAmCqDzAo+ZeTH7jPVfZo7Rk
        mFtaRKnS4aK4hGorPizAAUxMfbqi1wsdHmHDOPF1bGEUTNuPuxHorK4JdBzUucN8
        CYZoqPFlw1N6tdKTYjsdxtT9LKCG+xX2lPsd0vvMM1NVxzcJTSedIt0nNCvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1666314999; x=1666401399; bh=VJ7MSQ3AezQaHPTNxrj7gt+4vEfg
        AatVbyGUB3fvZq8=; b=NdHcmVDUxdBijxUGXD8epWMYoKc3o3c+zyxsd/oAurZL
        nJyjFTubhcW4b1LolqtaNTexeKz59wRoBVDaT8baq1QXS2QAhn74TP8rjl1/pyxI
        j3wa7fxzEgqMDYu2GB2xv1Afzd4OT0knXN9eGFHSdhWGnLb8bhrFGDB7hOUS8JUE
        ApQnnNe+MXJ5/M9BnC/dz+iCLdXag8EQVVIDCOoBbleg6mzPKg5GRwqaoId9+ANj
        x2+MuuU6xJVaN2xr4NWZOwerBCfNRndcbQ+9oibkihSZPryuTQBcVgjVQNUZ1bP+
        ryd5hEmzgeaStNAC7UPsnwiq6HVZZtBSq3WlQ4h9mw==
X-ME-Sender: <xms:9_JRY-ZPwVwTY7TVhf4B1YP1W1-NtJTQs9_luaFuCq6ATraSeNcfxA>
    <xme:9_JRYxbFFZBhUYMT6ewjtRlFePV_KUfe5TKlxvA7C6dQs0Ts0AMr2P4N1FahIXv9M
    78JkOe7AXwj3psZ7KU>
X-ME-Received: <xmr:9_JRY48G_6OQ0AZR0cn09wcDq4MPOmukX4DPngGc1USnyNbKg4SX-MLIZu3BpU0Y0tiQOzVs1swHdRwvkx2pnlrzYIA7Liv-pvKcA7Bw9z2l>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeeljedggeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttd
    ertddttddvnecuhfhrohhmpefoihgthhgrvghlucfotgevlhhimhhonhcuoehmihgthhgr
    vghlsehmtggtlhhimhhonhdrohhrgheqnecuggftrfgrthhtvghrnhepueelledtheejfe
    eiuedtvdehgeetvefghfekfffguefgkeetiedukeekheefledtnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhhitghhrggvlhesmhgttghlih
    hmohhnrdhorhhg
X-ME-Proxy: <xmx:9_JRYwqxMUZylqYJKb-D6B8Dt9LEpbsbqqY2qcR0MMCaCjI4MHm3yg>
    <xmx:9_JRY5ohs6XHIPMqkLInWp-Fj8FK3Qdj-Wti99PvO5PhDPdFCro4ig>
    <xmx:9_JRY-RGVIQTKa3X3yLnNT54GvxgmERdOCQdRX1S2EfEnli7VYG3KQ>
    <xmx:9_JRY4TG6nQhNLjTKVbvppSLzh86DM2e_qGPJEQrn8AsYs1ee8_Tvw>
Feedback-ID: i9dc944d1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Oct 2022 21:16:39 -0400 (EDT)
Date:   Thu, 20 Oct 2022 21:16:38 -0400
From:   Michael McClimon <michael@mcclimon.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2022, #06; Wed, 19)
Message-ID: <Y1Hy9n7E1/yWKkYv@newk>
References: <xmqqa65rnuvv.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqa65rnuvv.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> * mm/git-pm-try-catch-syntax-fix (2022-10-17) 1 commit
>  - Git.pm: add semicolon after catch statement
> 
>  Fix a longstanding syntax error in Git.pm error codepath.
> 
>  Will merge to 'next'??
>  source: <20221016212236.12453-2-michael@mcclimon.org>

I am not totally sure what these question marks mean, but I'm happy for
this to go to next, for what it's worth. (There was an outstanding
question about the general behavior of Git.pm in bare unsafe
repositories, but I certainly am not planning to solve it in this
series.) Thanks!

-- 
Michael McClimon
michael@mcclimon.org
