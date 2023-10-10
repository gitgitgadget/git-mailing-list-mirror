Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F54CD80D3
	for <git@archiver.kernel.org>; Tue, 10 Oct 2023 13:40:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232494AbjJJNkX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Oct 2023 09:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232526AbjJJNj1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2023 09:39:27 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91621BE
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 06:39:15 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 207065C0335;
        Tue, 10 Oct 2023 09:39:12 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Tue, 10 Oct 2023 09:39:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1696945152; x=
        1697031552; bh=HmDJFyn6274Hws0mwICdxoLUsL3OoEVEXduOLByjkEs=; b=i
        N/RSHydZb2wtGuzR5bpFGTQT2HE6v2NYrOHlgQPyN8V+afihilv+xtxJwOtdRPON
        6abWtHHPx936+XBDgSdoOTkpyiQRmFdhWmco9ycyvOAb9QaeShoNTE7pVjUVKbkQ
        WRcnTDwDmLGjQDniI/PwpINdpX9cLpjLnIR/vvuZw3h5wLldfOjENxZcdrC0qIoj
        DOHsrBxv6LHUOUmNQtzbBmzcmDer0LPPqtTNKouNcM5YRKHz+6c8L0JFSasyxub3
        Jk7wS0F8DsK/Bo26FG1HS0T/gIR7PwGpdGW6LnM8wUtzXhod+zEXhFtknWoMCxqq
        TuoOm8oKQ5a2mr9zpieBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1696945152; x=1697031552; bh=HmDJFyn6274Hw
        s0mwICdxoLUsL3OoEVEXduOLByjkEs=; b=hr4TBjIciMKPHUiA05eX7F0liLx++
        UHaXdwfrfJQjapTBwAtCzXyzii79cwIq+/mEtd6Q2uFDusZJPCRteztI+n6v2SJD
        ME0Be1koOq71gjA0fzOdpJ/xkvDgM4rCs6HfH6KlCE2SXBzEx9NY91KXwXau713n
        AEzycEIdznnEdhhpqXzfBj+DHqa8mqXsX4/EqzAQEQmgJG0U84lF4NYNQDseNf9K
        11ZWH8iPgvCtZpGUajQGk+MLCHTnBH74Oq7a2bWHoW/5w3zxZJ9OUDQAt2q6j6kU
        vUBUuMQPwOhuVOwF2dagZjHsQnNU4vFXPy/0gQv+49OdZDpV/nXC/5XSg==
X-ME-Sender: <xms:_1MlZSb719Znvm3_FZMyw-oH4BhRez9XlalD3mnqDhXIrgtn-AGJtmQ>
    <xme:_1MlZVYvmEjIK4en4pfEuQ9EkWOb6LB5_YIXEB2LG5mPfNYsSxDHjatQGO-4iLn7Q
    fCjLRpvqOtA4aQ_gg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrheehgdeiiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdfmrhhi
    shhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrghkkh
    drnhgrmhgvqeenucggtffrrghtthgvrhhnpedtkedtjeeiffelteffheeiheeufffgheel
    ueeftdejkeeufffgiefhgeekffffueenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:_1MlZc_D-9Hcnbo04B5fm9Febb16HXUyo5PacZCXhBsA1G1R68pT1w>
    <xmx:_1MlZUrF1eMJeTMkPUDEk9sQbIXxBmJre-YAQ7dMy9CR_PWOGct8Mg>
    <xmx:_1MlZdpAwVnJSUrSvrXRVAlR2YJhOmUvgnCHxsVgMQ8agKnA1EK5Jw>
    <xmx:AFQlZcTrSXbX2quYRKJjkML7Zc-qE-12ymnQr7kUtovMNyq--5ciUQ>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id C47AF15A0092; Tue, 10 Oct 2023 09:39:11 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-958-g1b1b911df8-fm-20230927.002-g1b1b911d
MIME-Version: 1.0
Message-Id: <98387b86-1732-42bc-9ac5-d64a6617b2db@app.fastmail.com>
In-Reply-To: <79901E6C-9839-4AB2-9360-9EBCA1AAE549@icloud.com>
References: <79901E6C-9839-4AB2-9360-9EBCA1AAE549@icloud.com>
Date:   Tue, 10 Oct 2023 15:38:51 +0200
From:   "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To:     "Sebastian Thiel" <sebastian.thiel@icloud.com>
Cc:     "Josh Triplett" <josh@joshtriplett.org>, git@vger.kernel.org
Subject: Re: [RFC] Define "precious" attribute and support it in `git clean`
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sebastian

On Tue, Oct 10, 2023, at 14:37, Sebastian Thiel wrote:
> This highlights precious files by calling them out, but doesn't change the
> behaviour of existing flags.  Instead, the new flag `-p` is added which lets
> `git clean` spare precious files.

Why can't `clean` preserve precious files by default? And then delete them
as well with something like `--no-keep-precious`? Is there some backwards
compatibility concern?
