Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C84CA0EC7
	for <git@archiver.kernel.org>; Tue, 12 Sep 2023 00:58:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbjILA64 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Sep 2023 20:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbjILA6w (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Sep 2023 20:58:52 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C6D1817BC
        for <git@vger.kernel.org>; Mon, 11 Sep 2023 17:52:00 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id BB1733200992;
        Mon, 11 Sep 2023 20:40:52 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 11 Sep 2023 20:40:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=schrab.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1694479252; x=1694565652; bh=hk
        2ny3Ia4LQ2JmMF/vCmIpKlpTcXJMyWVwV8hT/VjNE=; b=dWbgUIVDAmYs/E/QVx
        EocxhcM0CskrcBwh/ApLp8ZapQL1KKMkfwKqTHYVGM72rqNMD2sWCQ6DtBJj8dRR
        TwXiSat6O+mjjx52cvhRBE9gyLkZaR2Ad7h3WbigTNaCORf6WI3yXGfvLpkULpSw
        cps8qLbp+4JUqNlCsQpXAx6tuQzqaN11m8Cx9GZxTjviaBcl1oCNrv0RZKqW/7D/
        7ysr13VeuUz/wSoTZp1/YCH08bjcDOvuPGihLIsbCJgxL3b4kq+majGVm5E/RP5S
        qjowZig3Hlo0ogA7WekPf+0aAx5O8rbitfzZwactdj6PTrzCjSreNTX/IBAM2PE2
        8meg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1694479252; x=1694565652; bh=hk2ny3Ia4LQ2J
        mMF/vCmIpKlpTcXJMyWVwV8hT/VjNE=; b=pBheURKeDZKMOjDgfxHtKxi5e1drf
        YjXUD2tY0wGFbCkfGTmePqMcUENH/CUZBIe7xfDzbDwjMDZvbbm/39GtLiTPFzI6
        R2JOFxYFlEnbFlqHwLDDYoJDxUluZIo3u1S7PxvMu3byMGk18ddTKB/hBqflngAz
        aGwR2NUaJ8dhA6a2lRj0Y+z9ePH3ZoxUH0OoDuE+VMZ5jSJiFT0NyJLd7NPoD7FI
        tQVDV+/BLuyK4HdLX0+SYDKBdExE+K/7pR2wptmEmQzAt1AG5PwngJgoscjwISgh
        Brvw0BNgb1SR1VBLPj4O00ytlcrfWWY+zlwPL8rMXJVWJnRLzzfFjh4IQ==
X-ME-Sender: <xms:lLP_ZNBa7wp7WcCtgZIkzNgWnfaCQ8k5afOtNDMDZ0swWV0YhVArVw>
    <xme:lLP_ZLimNhNr5eh8rjE0hlAtoOpf-J4pU8hnufhcAXcQbolVuPCY8VQi-jfN7GoAa
    vgxNaYWippCN_wo6XA>
X-ME-Received: <xmr:lLP_ZImkDoF9EK2M6Ckq0q1prfa42QqnIfFWmTKB1u-fO8uTySLriMS24U6xQ6gTNQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeihedgfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheptegrrhho
    nhcuufgthhhrrggsuceorggrrhhonhesshgthhhrrggsrdgtohhmqeenucggtffrrghtth
    gvrhhnpefhtdefvdeivdfhieehueeuteelveekhedvuedvhfffgefhieevgeekudevgeet
    ueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrg
    hrohhnsehstghhrhgrsgdrtghomh
X-ME-Proxy: <xmx:lLP_ZHyQPtz6CATF0ZM2g9cP2L8nS9nDv58s3dR2EszlChEBiQ4VKQ>
    <xmx:lLP_ZCSxBvNDag5QcyxIwd510uJiIUoI0u6L5MaT-l-FnmZVjLik-g>
    <xmx:lLP_ZKZgFoPhB4RVYHj3z3OPKmu4n6CJl1Poq4BQ8EGwa4KuFx11Sg>
    <xmx:lLP_ZIM9d2ehYnhcLGmWgmyfaCXc5oVoFdYeVuyyc5vb40Gd5IVbcA>
Feedback-ID: i1fd14616:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Sep 2023 20:40:51 -0400 (EDT)
Date:   Mon, 11 Sep 2023 20:40:49 -0400
From:   Aaron Schrab <aaron@schrab.com>
To:     Max Amelchenko <maxamel2002@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>, git@vger.kernel.org,
        Hideaki Yoshifuji <hideaki.yoshifuji@miraclelinux.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [bug] git clone command leaves orphaned ssh process
Message-ID: <20230912T004049Z.jiWw7xuK7fiT@pug.qqx.org>
Mail-Followup-To: Max Amelchenko <maxamel2002@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Bagas Sanjaya <bagasdotme@gmail.com>,
        git@vger.kernel.org,
        Hideaki Yoshifuji <hideaki.yoshifuji@miraclelinux.com>,
        Junio C Hamano <gitster@pobox.com>
References: <CAN47KsV0E+XC2F+TVKXnnJnkATRp7eM7=-ZJFyZcoTz9SJmcHQ@mail.gmail.com>
 <ZP2DaQMA_aFvjQiR@debian.me>
 <CAN47KsUe=qicr4wZWd33EV+cciUr8ztP2veoOkcw0JBtvsBGjw@mail.gmail.com>
 <ZP4PO+HkbsbuKact@nand.local>
 <CAN47KsX5cpo5oD7PAwAQzjR4oocST6uSkJe2SzAYPxxqy7dGtg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAN47KsX5cpo5oD7PAwAQzjR4oocST6uSkJe2SzAYPxxqy7dGtg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

At 13:11 +0300 11 Sep 2023, Max Amelchenko <maxamel2002@gmail.com> wrote:
>Maybe it's connected also to the underlying infrastructure? We are
>getting this in AWS lambda jobs and we're hitting a system limit of
>max processes because of it.

Running as a lambda, or in a container, could definitely be why you're 
seeing a difference. Normally when a process is orphaned it gets adopted 
by `init` (PID 1), and that will take care of cleaning up after orphaned 
zombie processes.

But most of the time containers just run the configured process 
directly, without an init process. That leaves nothing to clean orphan 
processes.

Although for that to really be a problem, would require hitting that max 
process limit inside a single container invocation. Of course since 
containers usually aren't meant to be spawning a lot of processes, that 
limit might be a lot lower than on a normal system.

I know that Docker provides a way to include an init process in the 
started container (`docker run --init`), but I don't think that AWS 
Lambda does.
