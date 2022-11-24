Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B17C43217
	for <git@archiver.kernel.org>; Thu, 24 Nov 2022 13:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbiKXNhV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Nov 2022 08:37:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiKXNhT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Nov 2022 08:37:19 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C636D5A6F3
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 05:37:18 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 2EF4C32009C6;
        Thu, 24 Nov 2022 08:37:18 -0500 (EST)
Received: from imap45 ([10.202.2.95])
  by compute1.internal (MEProxy); Thu, 24 Nov 2022 08:37:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=owlfolio.org; h=
        cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1669297037; x=1669383437; bh=S5dOCP4MiC
        8/ZMsjHFawdWzRrEfOMHpfS/qORcmAPzA=; b=w4YH0y4Yuv7DA9TYCg1hkF5Rf8
        HYmGFA6mMJ3ayANOsPOGfTBsmn9FZg3MNNwrrQ+deYrEvp/Gg0Z0wU0z1G5AxHEF
        /PSN4C65m9k0C3qwXBa7Q+qB7O8FRqp6Y9YrugOeo5gA+eVx9IpPih9M3EKuCYCh
        kxLlsnnpmd9+GjWj3le2WJQ4XyRtbbKzuRXGD+IRw4I2wf8ad1uuJZNBPwRW6PWK
        KmvKliZmw4ArzNT7ykyzjVk8n0Bv0FhVMaWyrXUSNEyUUYjbRny1oHzXjtD10s5i
        3xrzNgjR0StWZnRhHtk7GmaFvF8J6Hch6RRNLL/huyKsZ3ory/5yrLoKEYcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1669297037; x=1669383437; bh=S5dOCP4MiC8/ZMsjHFawdWzRrEfO
        MHpfS/qORcmAPzA=; b=pLR9daauxLAxvYO9WCUAdrtNc8PWyV4ewTzbBZ7KlQA1
        Jjp2Qeogm/VQx1szOhnzXqUmKke9twNJE1nFmnXr7X1GQY44ne+wHZuMbiVxTl+q
        0TE3SLyHpQApmhMLPby3X+oZTLA8lWuxTQ35zfxNzKoCAHg9UrrPTcdvK+gcN+Wo
        CjB2d8b+x3NWcfFBRnaSGp08ngqQFbFStN2xjCUiMJvrJ8FAYz8bMDu3lQlNlsMW
        SlzxrdnRNgA61z6/+9czXTQhY957CGDm6miAmnw8ZkByQWGFrF4s9MWcu6c8eT9Y
        3b0R6pSFTAwu3wbsD5uPi+fzC47aMItcf71JAVZdkQ==
X-ME-Sender: <xms:jHN_YyPyqldimS8QGDtJvnhG8FIGuf-EFHikP469OmTcZ5LjNLXazA>
    <xme:jHN_Yw-njsPM-_ONPvrhPgtftuc6RDGDA2YIBBD-ycXO64uZG1WFjpmBewrxonVDa
    gxJsJWtThqV6NS6VKw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrieefgdehhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepofgfggfkjghffffhvffutgesthdtre
    dtreertdenucfhrhhomhepfdgkrggtkhcuhggvihhnsggvrhhgfdcuoeiirggtkhesohif
    lhhfohhlihhordhorhhgqeenucggtffrrghtthgvrhhnpefhuefhveeuffetfffgjeetgf
    ekkeehfedtfeelgfehffffveehkeelfefgheffudenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpeiirggtkhesohiflhhfohhlihhordhorhhg
X-ME-Proxy: <xmx:jXN_Y5TzCGm7pa9icLM4QUya7irGgrYoq_yIxiTPRFQbdY5ouNep-g>
    <xmx:jXN_Yysa-uz0zLb-UgwheRY_s0uSvPYkCKV8zEkHoMYpSmrD-M6Exw>
    <xmx:jXN_Y6eK5z9Yropel7047QoOhBEYwBGLmQcq7G2jE70NtLAfnK1iEA>
    <xmx:jXN_Y8oMFbWg_gSYvwjlaahxNEVcxwpPxTwTvIP7t9RJlWcwA_-n5w>
Feedback-ID: i876146a2:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id EF3D4272007A; Thu, 24 Nov 2022 08:37:16 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1115-g8b801eadce-fm-20221102.001-g8b801ead
Mime-Version: 1.0
Message-Id: <cfbd647e-0e66-4417-8c94-c8cac905a78a@app.fastmail.com>
In-Reply-To: <909b0770-2ac2-1a87-498b-0537a94e94ac@dunelm.org.uk>
References: <71fcf215-101e-4398-bffa-4ed7e286d9c8@app.fastmail.com>
 <909b0770-2ac2-1a87-498b-0537a94e94ac@dunelm.org.uk>
Date:   Thu, 24 Nov 2022 08:36:55 -0500
From:   "Zack Weinberg" <zack@owlfolio.org>
To:     phillip.wood@dunelm.org.uk, git@vger.kernel.org
Subject: Re: [bug] git log --invert-grep --grep=[sufficiently complicated regex] prints
 nothing
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 24, 2022, at 5:31 AM, Phillip Wood wrote:
> I think the problem is that you are excluding the commit that renames 
> the file and that stops --follow from following the rename. See below 
> for a simple reproduction using git's test suite.

Yes, I can confirm.  Both of the "incorrect output" examples I gave
involved excluding a commit that renames the file.  If I don't do that
there is no problem with an `a|b|c` regex.

> I'm afraid I'm not 
> familiar with the --follow code so I've no idea how to fix this.

I'm honestly unsure what the right behavior _should_ be, now.  I
expected --grep to be applied very late in the process, after the
set of commits touching the specified file had already been computed
(including all of its previous names, because of --follow) but the
documentation is ambiguous.

zw
