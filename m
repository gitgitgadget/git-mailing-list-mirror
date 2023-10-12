Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B8BBCDB46E
	for <git@archiver.kernel.org>; Thu, 12 Oct 2023 20:03:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442549AbjJLUDt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Oct 2023 16:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442540AbjJLUDs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2023 16:03:48 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8C8DD
        for <git@vger.kernel.org>; Thu, 12 Oct 2023 13:03:45 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 9454C5C023C;
        Thu, 12 Oct 2023 16:03:43 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Thu, 12 Oct 2023 16:03:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm1; t=1697141023; x=1697227423; bh=xAh1cxYaabr+CVxj3UNeXpdq7
        mVTEATxCmRiXWPII/0=; b=Uk4BS9PJ2uFF0xvB9qcr7w6X9SLSBgtMjtHUOzfvS
        n3lGUIqPW9thxCE/I+iEhslNBErGaZJYZYkc2/h+ek2QG8Al84CgXsvQ7ry04cc0
        AEFgnkKbrljLeIn6C7uSd/mbyiDluOtAdGBuu0cJt3iZBxnxOI7Zn/0z3iXpkM8X
        rszYgMdl1ehjPYNGMd2oUCZXsJjOdQuLei11yUlK1S5qbTqFb1QwGweljlQ4sxfF
        EKoP47iJ7MqjkuYDjFwgsuHh4h3mRbjkGrR6p9DQH2jJbja3KMQfzwUGp6wwKpjs
        IhIye/m2tiWtKCaWeGvHCnVCtoQPp4TH8PAM6n7aBhhxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1697141023; x=1697227423; bh=xAh1cxYaabr+CVxj3UNeXpdq7mVTEATxCmR
        iXWPII/0=; b=pJWG29BX24nrBomU/psUI2oTqEuuZf3+OyazHTZCzSMAVcRprwy
        d4je4WaMZwTNJeNjTQKBeG/d+NQXrrUW2s+9gg9uWSgY6JTP8mJ3zJp/e/hlAZB0
        +Pt1nBkXYeq+EYghhhXAypjEySUQVxI3jlj0Vrwxg+MY2L1S1fg2na5am0G/NMwy
        K/KpSiiWKOx9iutv+zfGkPA3U9rKXjawEtc1BcfBHz2eC9Gp2hh/4V+sB3hNcDPg
        uzcNUgfhbAbThlnnFjWOq0H2ynRbN2x5qGLHk8emnxSDXuZ5JEoDRkguQIPS8bfq
        7eMgCa5qnT7xDPalapjTZ+VgkDDccg1QBGw==
X-ME-Sender: <xms:H1EoZXsXMIYn5CIT0g3rdTTX1-i3_Geqt-KjC3t-WOe7O4o9syQsM9A>
    <xme:H1EoZYed7O62FVrpZbEqQdXcF_kBIIELt5XWYSUIWcACKom1aAGzKR75AMxZlXQLl
    RI4iDFbM-tAemvBJg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedriedtgddufeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfm
    rhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrg
    hkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpedvveehiedufeehffdvteeuveekhefh
    leeigfektdeifeduteeuheeufeetffefudenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:H1EoZay0GpKvF8FQW_J9wnANN1rVRsuPuQK64oyW4wT8zesYCcVS5Q>
    <xmx:H1EoZWPhJC8LIfOCpYhIk0xci2qVSWcwzL4FvA2Os7qdPwt6NiNPCQ>
    <xmx:H1EoZX-tuhLtEHp-wc4lWzENDdw7DkDJkNno4Kt24om6Lgru8-mmJA>
    <xmx:H1EoZUE70YTzizY_Yt1V1Tb-yJR7clJkTYgysqEUJ1iA03-w4LCk_Q>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 3CFF415A0092; Thu, 12 Oct 2023 16:03:43 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1019-ged83ad8595-fm-20231002.001-ged83ad85
MIME-Version: 1.0
Message-Id: <277a80c5-40c9-4f1e-a68f-96673380012b@app.fastmail.com>
In-Reply-To: <20231012112743.2756259-1-ben.dooks@codethink.co.uk>
References: <20231012112743.2756259-1-ben.dooks@codethink.co.uk>
Date:   Thu, 12 Oct 2023 22:03:23 +0200
From:   "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To:     "Ben Dooks" <ben.dooks@codethink.co.uk>
Cc:     git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>
Subject: Re: [PATCH] send-email: add --compose-cover option
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ben

On Thu, Oct 12, 2023, at 13:27, Ben Dooks wrote:
> Adding an option to automatically compose a cover letter would be
> helpful to put the whole process of sending an series with a cover
> into one command.

I didn't manage to apply the patch so I haven't tried it out. Some
questions:

1. There is already `--compose` which is clearly different. What's the
   difference between a cover letter an an introduction? That's a more
   immediate question now with two similar-looking options.
2. This would be really useful in `format-patch`. One could write the
   cover letter immediately instead of either (1) editing the generated
   one (placeholders) or (2) providing a file.
   - Personally I don't use `send-email` immediately=E2=80=94I use `form=
at-patch`
     to generate everything so that I can review it before any
     sending. But there are many different workflows.
3. Does this editor only deal with the subject and the message part befo=
re
   the diffstat and all the auto-generated stuff? And then it applies it
   after the user closes the editor (to make the complete cover letter)?

--=20
Kristoffer Haugsbakk
