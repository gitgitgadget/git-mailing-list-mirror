Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C544E95A82
	for <git@archiver.kernel.org>; Sun,  8 Oct 2023 14:37:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344520AbjJHOh5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Oct 2023 10:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234341AbjJHOh4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Oct 2023 10:37:56 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1ECDA4
        for <git@vger.kernel.org>; Sun,  8 Oct 2023 07:37:54 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id AA24D5C025E;
        Sun,  8 Oct 2023 10:37:52 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute1.internal (MEProxy); Sun, 08 Oct 2023 10:37:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm1; t=1696775872; x=1696862272; bh=bGfPAYkbPoKZpHX6M3K7+6E9N
        dCJukFIQJZAJm+i/6U=; b=mXGN595/j+q8DuLvL7HyTjjOIII76r0Ywh4THpohP
        DtxE160tLjNO79w8eF4Yp4tr5P1F3imZmKEq/MGNvOXGnDpRi17fgJQMEXVv4QhL
        spq5J3vPAmBPbGsdWbeuz4Ws7E44TZtAJ6BJsICvvsEmm6PC6Ef2mx9FG63fNuWd
        LjsPPjhmXrU2dwi7yopLg9en/ARa/cMh+yPIBFfj5nnu6WTNbIGOwkgMIjp2fGIm
        sQn8Hizi7OeBBh07TkP550a7IzneH7qunLZbm2r9hS5+WhPUnZuP5dGlU5Bt6oVp
        xw9ednHQIw906clZiDBC7S0MpNlGCB55H/R70ll87lc3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1696775872; x=1696862272; bh=bGfPAYkbPoKZpHX6M3K7+6E9NdCJukFIQJZ
        AJm+i/6U=; b=AElndfiwec9hpEdPnXbDVoGGGGmeDNebIqfCxziec/l0Z/OFGGw
        iGHx/5sotGOgQTH5RXTPNU+r+mG9ep5+jMN1Z+kkXisx/d2dah1AQY+ZdIwL694q
        HYEJFAStOVLiaIwy7xrp70XjtaKbKkb1OYPVo+4VYHKB1hlsbUqKQz9lndkqo2sq
        p9v9v5liXLRAIU5/4VrssEvyKCnzPnEILCgGTORsgRsQg0wxsS4c/wekSFXDel1+
        AnLb+Vmsq49JA9RdPh4tEF3QqW7B5I851Cd3KaFfE4OnRQqzlRGBflzQR+bzajmf
        GGQBn+pZ2XfgxIjS7SFHo90mnrdgM0nXX5A==
X-ME-Sender: <xms:wL4iZVkOj0nxhaoRZaRf7rRUnaDnzS73955wiZiTr8nTGUGYXUuSCUQ>
    <xme:wL4iZQ0uz4gA4XERrUTiRQ3qTmuuGGkL36xQh9DVrU5eZ39pznmKluyE67w6pwmxO
    eesJInO52PHjQRqug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrhedugdejlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepofgfggfkjghffffhvfevufgtgfesth
    hqredtreerjeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdf
    uceotghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpe
    dvveehiedufeehffdvteeuveekhefhleeigfektdeifeduteeuheeufeetffefudenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskh
    hhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:wL4iZbqh8hSxDewAhFjolV_k_7nUd95SjW4p9Cp752CsJPMqdgB1uQ>
    <xmx:wL4iZVlk95Ci1yLmE9OZE4fGNC4du6qpqLnKOYwCCDol4MLYsoaJqA>
    <xmx:wL4iZT10zemTwz1R-zawjtN4ZZQBnL922mbKxhGv94lmmi4vF6uIjg>
    <xmx:wL4iZQ986HM0UfyRnABa5d20UFUs4_Kee6YZTHYG8Z7LV1MlgKdk4A>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 690551700089; Sun,  8 Oct 2023 10:37:52 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-958-g1b1b911df8-fm-20230927.002-g1b1b911d
MIME-Version: 1.0
Message-Id: <e1d1c573-28ee-44f4-bd90-3fad445a2dca@app.fastmail.com>
In-Reply-To: <pull.1585.git.git.1696774217058.gitgitgadget@gmail.com>
References: <pull.1585.git.git.1696774217058.gitgitgadget@gmail.com>
Date:   Sun, 08 Oct 2023 16:37:13 +0200
From:   "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To:     "Josh Soref" <gitgitgadget@gmail.com>
Cc:     =?UTF-8?Q?=E8=AC=9D=E8=87=B4=E9=82=A6_=28XIE_Zhibang=29?= 
        <Yeking@Red54.com>, git@vger.kernel.org
Subject: Re: [PATCH] doc: correct the 50 characters soft limit (+)
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi =E8=AC=9D=E8=87=B4=E9=82=A6

On Sun, Oct 8, 2023, at 16:10, =E8=AC=9D=E8=87=B4=E9=82=A6 (XIE Zhibang)=
 via GitGitGadget wrote:
> This is an addition to commit c2c349a15c0430a2ef9f858d69d095a00693379c
> ("doc: correct the 50 characters soft limit").

I think the =E2=80=9Creference=E2=80=9D format is nice:

    c2c349a15c (doc: correct the 50 characters soft limit, 2023-09-28)

See `Documentation/SubmittingPatches` at `commit-reference`.

--=20
Kristoffer Haugsbakk
