Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48DF0C433ED
	for <git@archiver.kernel.org>; Thu, 13 May 2021 14:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E25861260
	for <git@archiver.kernel.org>; Thu, 13 May 2021 14:51:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234647AbhEMOwz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 10:52:55 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:33109 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234793AbhEMOuq (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 13 May 2021 10:50:46 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id BF7BC276A;
        Thu, 13 May 2021 10:49:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 13 May 2021 10:49:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        linuxprogrammer.org; h=date:from:to:cc:subject:message-id
        :references:mime-version:content-type:in-reply-to; s=fm3; bh=sdF
        RuV5kwTeSW/0Z6g0ke+RK6DQNQDS/V8ob3pcAnlg=; b=ZxmSYT10CPoMoJMUQyo
        iBMTmOvaH1eqrhGdq9IsvlopQfUFbtXUXfTES2JfJ0k21G+nYnOgdAnFRpghLGbf
        C8dkWYdxWHfQUodQknGhilzW7GGigw9RkGYqXWtHqsT2WeIIMb/CwpSFj4IQXmOS
        FrmBbYrWcXpfDkrohSL7WUNv3aKTnFRJRr8kap6ITfpkoj6mIwMp6AA8531ws1Pn
        CaR+1B3hZiNFLliGYQZ6+IaTSXU9MbCgHuaCkMjgLPXsTV5t4BEz0IDVYIdFKjEK
        oK6RNLRnYe1nTdxOCNGWmwRRkCfl/Ap8U0Nr+SMT4NpZ+38yk8aMbnvBJzrO7heL
        r0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=sdFRuV
        5kwTeSW/0Z6g0ke+RK6DQNQDS/V8ob3pcAnlg=; b=Rvd6/LCae5L/e++KRNKC4l
        C7TV/sfTRkBZFEt6FwiIEaVnax+1A4uqODTlThbBUkTEVPpHiiGH8mpGapBwHtzw
        r7uURkUDcaNWAjEdtS5tD1eKme6mnwyJRa3GvLmE9aW1DYGp7QurbB1dT/9JQOKS
        RvCXxsP+OG1+IWh/h9rF6yXxugt0OjcmrqjyRwfdRaN7dQXx/jt2TMwQfUlv5ECA
        9Ma4+fekXeT7xfCaU36JWzCyvzyppR8zz6X54Lix6NgpzX+YPXTXjIniQ/pOqDBZ
        Y5pY2mXArvwabDlmoFiZ4lnYCMt8T2CjS4AlOBDVbkg11jVpp24YVCZ417oAea1w
        ==
X-ME-Sender: <xms:fTydYLEwgN-ISrRr5Xlk6u2KpbSNZ3dhk5axlQKOn-_JFEmBCFlC2A>
    <xme:fTydYIXddf7EK6wmPIotAkzMLQd-ZWnSGY_zl_znj5tIY9klDuERrf4zVaObtdrEJ
    pZPiPr-bAGbsy39>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdehgedgkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujggfsehttd
    ertddtreejnecuhfhrohhmpegufihhsehlihhnuhigphhrohhgrhgrmhhmvghrrdhorhhg
    necuggftrfgrthhtvghrnhepgfdtkedvkedtfeevheeifeeggfffheejkeffvdelhffffe
    efleehvdehheeileelnecukfhppedujeegrdehvddrudehrdefjeenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegufihhsehlihhnuhigphhroh
    hgrhgrmhhmvghrrdhorhhg
X-ME-Proxy: <xmx:fTydYNInMcH-5oMsEVU7zcvpEKEE11Ycm0lAkQMI4V20o3qUqhqE6g>
    <xmx:fTydYJEMMILLRp7P8tkHxXW8Dk-mkXf89QpVdwbU6azcmKWnE-BDmg>
    <xmx:fTydYBVkrykSy-sg8Ij_FeWmjJLMCEcSsl1VsYNu6zOZ5aS2HeYaUQ>
    <xmx:fTydYJigqfJE0Uy7jyUAsgRFcNLIv3uJvPl_Hibz5U8IIoERgOh1nQ>
Received: from localhost (c-174-52-15-37.hsd1.ut.comcast.net [174.52.15.37])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Thu, 13 May 2021 10:49:33 -0400 (EDT)
Date:   Thu, 13 May 2021 07:49:30 -0700
From:   dwh@linuxprogrammer.org
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Git Users <git@vger.kernel.org>
Subject: Re: [RFC doc] Tracking git.git
Message-ID: <20210513144930.GC11882@localhost>
References: <4591b3bd-1f35-55cb-6eb0-be97810d6e68@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <4591b3bd-1f35-55cb-6eb0-be97810d6e68@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13.05.2021 20:05, Bagas Sanjaya wrote:
>But tracking seen is more like tracking linux-next. We do NOT use git
>pull because often doing so will try to merge origin (upstream) with
>our local version, which are divergent and most likely will end with
>conflict.  Instead, we do git fetch first followed by resetting to
>upstream by git reset --hard origin/seen.
>
>Should the fact above be documented? And on what file the fact should
>be placed? In INSTALL?

I vote yes. I was trying out tracking the different branches and got
bitten by this very situation (tons of conflicts) when pulling seen.

Cheers!
Dave
