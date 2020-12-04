Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA16C4361A
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 02:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96622224DE
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 02:57:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbgLDC5h (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Dec 2020 21:57:37 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:54671 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727378AbgLDC5h (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 3 Dec 2020 21:57:37 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 49F39CA7;
        Thu,  3 Dec 2020 21:56:31 -0500 (EST)
Received: from imap4 ([10.202.2.54])
  by compute3.internal (MEProxy); Thu, 03 Dec 2020 21:56:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=HhL2Yk
        UeevwdmcxaA4S/mmK/gkBTz1HhjZLlC2rdZBU=; b=EebhXAO4uE7izriUoo2eb2
        8yyxhBncZQuD6IMzIbQ/b6Crd4YFfcwFLxB6bkkNxFoNITRSXkzzOGBFNRhZtnf1
        DbYWyFT95LkV0/KVrzIK0A/qweuMuD33qLPRBX+8QKgQUa9eMs7aLCKL7TTDTM3z
        y8VYNn9+9OrkJ7FnRZOuHIv+WxckVh1wtsFiFU9QcyQkZ5qObmLsXR5fpN0Ekw6p
        Kps7SZQM41XavVf6XkaAFdqgM9mGP/j6Lrq98w//LzwcumMm28lfU5/gHPFZCjXp
        qc7nnHcVN1fKXvE61j8UnW8ejiWJHj88JK/GaYKUCYtYG3ZGahJXgupQv6cp+BMg
        ==
X-ME-Sender: <xms:XqXJX-9op7Vq4bCgrEoAmr1L0jRBODM09BblUA6s0GmRZ17Jn7HBFw>
    <xme:XqXJX-uD2AbLWS7ilBYzqG0p8Ec9QafzhoeNBCeyfn-fISRKZGIGIfUa8bnRRi6qd
    4-3R2I9Q6n6LuA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudeijedgheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdludehmdenucfjughrpefofgggkfgjfhffhffvufgtsehttdertder
    reejnecuhfhrohhmpedfffgrnhhivghlucfjvggrthhhfdcuoegurghnihgvlheshhgvrg
    hthhdrtggtqeenucggtffrrghtthgvrhhnpeefteejtdekudffledtkeettdegleejudei
    hfdtueehgeejkeetvdefffekvedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegurghnihgvlheshhgvrghthhdrtggt
X-ME-Proxy: <xmx:XqXJX0Cluc4DXLPQFwgrUKVGVofia2ONgYjf0Vd-ddC1RyzLkzD0WQ>
    <xmx:XqXJX2dIZuu10WzkRR1JVQxD2FQ-SvARE_6WzZCNUvSdJfvCTkEk0w>
    <xmx:XqXJXzMi0WxDojy-kI4W0mkxFzJLlWxDJMGH0YOtZm69jl3uKdnnog>
    <xmx:XqXJX5ZinIxkpTA5tjGYdQ27UIXdrLLlfCC5jjCgiPVUYp3BXRRv8w>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id A7FD23C00A1; Thu,  3 Dec 2020 21:56:30 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.3.0-622-g4a97c0b-fm-20201115.001-g4a97c0b3
Mime-Version: 1.0
Message-Id: <c41cbbd9-d395-41fe-9013-8a1bac68d491@www.fastmail.com>
In-Reply-To: <CAPig+cT-Tf2ray+j9b45vz-qoiSZ4MkTyGVDr6PRJCXsvbx0=Q@mail.gmail.com>
References: <147444de-7653-d067-596a-9448ae6b8cac@heath.cc>
 <CAPig+cT-Tf2ray+j9b45vz-qoiSZ4MkTyGVDr6PRJCXsvbx0=Q@mail.gmail.com>
Date:   Fri, 04 Dec 2020 13:56:07 +1100
From:   "Daniel Heath" <daniel@heath.cc>
To:     "Eric Sunshine" <sunshine@sunshineco.com>
Cc:     "Git List" <git@vger.kernel.org>
Subject: =?UTF-8?Q?Re:_Bug:_git_log_-L_manpage_claims_regexes_are_supported,_but_?=
 =?UTF-8?Q?they_are_not?=
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks very much! 

I was thrown by `git blame` having an almost-identical but opposite interface (must use a space and not a colon).

Thanks,
Daniel Heath

On Fri, Dec 4, 2020, at 1:54 PM, Eric Sunshine wrote:
> On Thu, Dec 3, 2020 at 9:50 PM Daniel <daniel@heath.cc> wrote:
> >    $ git log -L ^/bootstrap-sass/,+2 Gemfile
> > fatal: -L argument not 'start,end:file' or ':funcname:file':
> > ^/bootstrap-sass/,+2
> >
> > $ git help log
> >         -L <start>,<end>:<file>, -L :<funcname>:<file>
> 
> You're missing the colon between <end> and <file> in your example. It should be:
> 
>     $ git log -L ^/bootstrap-sass/,+2:Gemfile
>
