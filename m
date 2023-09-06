Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F8EEE14B9
	for <git@archiver.kernel.org>; Wed,  6 Sep 2023 18:08:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243669AbjIFSIt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Sep 2023 14:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234088AbjIFSIs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Sep 2023 14:08:48 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886AE1700
        for <git@vger.kernel.org>; Wed,  6 Sep 2023 11:08:45 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 7C0E332009FB;
        Wed,  6 Sep 2023 14:08:44 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute6.internal (MEProxy); Wed, 06 Sep 2023 14:08:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1694023724; x=
        1694110124; bh=H497tnJqik+RtMt0oGBCTX3UF8OjbUne9GFZGmawX2k=; b=w
        A33I9VtBUVEg+eGJTpi46H9tWGHebeS19EgQ3lKxiMozDr3ySXFGFG1nICmiLE6r
        wloU0Jd9mIUqITG6x08WUG7xtZ7SwJnGqUx+9nmoWqBFuiBOh6ZT8kKN1jaFBP1I
        V5LZrXCIE+M/plELOgmTE1QccUtuyTzFJH0LkYQgrqwNoZoihzf8bsPTlLhpcZOW
        X3Pq4G0uuYrY52k3fS15DXwLqvVk1Vg56zOPhKLCf4b+r6jBrWfAvR9lc2mfHuTP
        7naMnxvghR5IykW9AnEjiBVD3bsoNoYxe/fzpi/Ka6YEyuqE6EiSC/6O8OHeEjiW
        729j1ic3AwWEjAYT3sW6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1694023724; x=1694110124; bh=H497tnJqik+Rt
        Mt0oGBCTX3UF8OjbUne9GFZGmawX2k=; b=eWUVN0cO85IwwOgMfKqDiMrotZzTJ
        S4aQkluxHfAnFfkwkzQ7BG0epI+HuZjor30ptMZyyusObhTrYNTtsVJP1JPvlGt4
        IAfTUDOTo2LHmUl4v8vmJHX7edqgfWAxELMoDlCHC0XVRNOP2wR77Hv34Rktt/Fa
        aALHgf9tuEYLoOOopNu0cGgGa95Kx8yRNa0MMFfNudeU73C7zM068m/8owNdKN5Y
        3c58YX/4SR9cFcyI4zJs7X0H+R19iFAxic+wRuYoOMCDjggAFa2qyTXdjGZRLGcL
        tB4gwD79Fikjktyv48tr2WWgBEopZiteDFi87f0w7YAAutaZ/DlsJbhNQ==
X-ME-Sender: <xms:K8D4ZFjlCX9ZZ2846X0Y54namWxibcFlmghyv86MKS3ygUQroEpEJ_0>
    <xme:K8D4ZKDSWQAkMQVUh4Nh-YZyN2He_zvmLnqJ2ATgGigg9MQV4S9vyc4F0MDcK4a5r
    FpY1MTVHzW3E8CqXQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudehfedguddvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdfm
    rhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrg
    hkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpedtkedtjeeiffelteffheeiheeufffg
    heelueeftdejkeeufffgiefhgeekffffueenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:K8D4ZFHGWrz4u0FFb8zB27wJAieFN9lwGREx2ZNL0EvCxPfkfLG61Q>
    <xmx:K8D4ZKSiYhbD_Yae9LL5-q4LOXUHW2W5Ym24bz7DONm5lZ-E30rzzA>
    <xmx:K8D4ZCxckokpwYdw13bqhz76mUueV5PU1dAPrLy2RCoKSVeVAZ_PaQ>
    <xmx:LMD4ZMs0PMAM-XLDBHAJwRxdba_3RWUXiK3XVLhWhrT7NwfehcCvAA>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 5B42615A0091; Wed,  6 Sep 2023 14:08:43 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-711-g440737448e-fm-20230828.001-g44073744
Mime-Version: 1.0
Message-Id: <c3e11a9c-071a-42a9-83ca-b2b078495a45@app.fastmail.com>
In-Reply-To: <xmqq5y4nnq9b.fsf@gitster.g>
References: <CAPMMpoixKnr4BkKd8jeU+79Edhqtu4R7m8=BX4ZSYKdBHDzK=w@mail.gmail.com>
 <b5833396-7e04-465f-96f6-69d5280fa023@app.fastmail.com>
 <CAPig+cQoiqeZF52Jr45an+cZF+ZQbHPXtLVn+VmyegjMQaJqCg@mail.gmail.com>
 <2ba66542-9ae2-4b13-ae6b-f37dec6b72c7@app.fastmail.com>
 <xmqq5y4nnq9b.fsf@gitster.g>
Date:   Wed, 06 Sep 2023 20:08:22 +0200
From:   "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To:     "Junio C Hamano" <gitster@pobox.com>
Cc:     "Eric Sunshine" <sunshine@sunshineco.com>,
        "Tao Klerks" <tao@klerks.biz>,
        "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
        "Taylor Blau" <me@ttaylorr.com>, "Patrick Steinhardt" <ps@pks.im>,
        git <git@vger.kernel.org>
Subject: Re: Is "bare"ness in the context of multiple worktrees weird? Bitmap error in
 git gc.
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 6, 2023, at 19:52, Junio C Hamano wrote:
> I wrote that "(i.e. bare repository)" in 2df5387e (glossary:
> describe "worktree", 2022-02-09) but did not mean that way.
>
> A non-bare repository can reduce the number of its worktrees, but it
> cannot go below one, because the directory with working tree files
> and the .git/ subdirectory, i.e. its primary worktree, must exist
> for it to be a non-bare repository.  Consequently a repository with
> zero worktree is by definition a bare repository.
>
> But that does not have to mean all bare repositories can have no
> worktrees.

I see. Zero worktrees implies bare repository, but bare repository does
not imply zero worktrees. I got my logical connectives mixed up.

Thanks

-- 
Kristoffer Haugsbakk
