Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E29C77B75
	for <git@archiver.kernel.org>; Mon, 15 May 2023 19:57:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244565AbjEOT5B (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 May 2023 15:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243628AbjEOT47 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2023 15:56:59 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D54658D
        for <git@vger.kernel.org>; Mon, 15 May 2023 12:56:57 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 2F9875C0139;
        Mon, 15 May 2023 15:56:55 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute6.internal (MEProxy); Mon, 15 May 2023 15:56:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1684180615; x=1684267015; bh=QBEe41avTCjxr0oe7wWPcYSVt
        iCUicNNk4irCO57vSc=; b=LAUMJhEfVTWQFjRqgIxgvC5wcJ7Br6p7pLtuBj/eC
        jLpSCLr81O5jtQEpgbSkgVwrVw5xI6WK95fJ67vfyeO0mTCWXpHH2H4fufKnWFo5
        o12fb59hJPGq4/eW0OiFy5ZgMKo4q7WOQrlqKGpnIhLXIhi6sQyZ23KOXztD6LUX
        AD1TUm//GCvApyylCupvL8yvLJv+bdaSfIIpsDP1JF5jGpwTIQEqxW/yzYMcFxFa
        i7d621BSysQQnHXJeAx4DZn6IKeKUvzWe7iBK3VzsRMe+wZJzEBY0j7BzqUI+Dl8
        iq5LhCaHZNXbzhVIGd7siF7eIOrVFQYc2UsY2EfVwFfOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1684180615; x=1684267015; bh=QBEe41avTCjxr0oe7wWPcYSVtiCUicNNk4i
        rCO57vSc=; b=epxgcGYjXI8fOSrw/LPxccxzsMicIwd5LX9n/lLI6i+mNCnRIkx
        cFziHnBILIM+5HsWFIZM6Pv2BgQ4pSR1cxh15PXOUmJe7Tank+Z2taB7T/JRFgMd
        vW0H9dY0zojVDUJpQFWUu2r9vmdv1MybtI6e59WgJj2F5gQU0fXR4H6r6tJusv29
        mMfOSqyJiQHa9mLZi7vMgCLVHftWUP135ZmjIMYCcZcpOGHo5dCjTFTXkAaCk8Zu
        5Fy5WS+H/eBZlOZeBqV00wSUGYGe+3wErX7NFKEDmpKp8+9got9EwAaePzX34iQs
        /XJSlzcWk3tizVTrg0Rx1Kt85cBIJN4de3w==
X-ME-Sender: <xms:ho5iZA7ThYdjgM5Fvekwj64UDL-7j8SsAYhsN7hPweCg6_YdOOLYs98>
    <xme:ho5iZB6Nd-xhVW4wEFV1OZm68LDH1JbMUkL31LFcM5_4vAg7GDlNkOAYRGg7K9v0S
    uKC6JOqDxJNNGHEFg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeehjedgudeghecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepofgfggfkjghffffhvfevufgtgf
    esthhqredtreerjeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghk
    khdfuceotghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvqeenucggtffrrghtthgvrh
    hnpedvveehiedufeehffdvteeuveekhefhleeigfektdeifeduteeuheeufeetffefuden
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegtohguvg
    eskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:h45iZPdhuCoZstHUZqiq-cbkrcRuhYHI_ckwZersqiF7kXZfsfIALw>
    <xmx:h45iZFIMHZ8HFgVewnOD5-ri8u0YD4RL3l_xAsbx3ZhxJhkSYHS95w>
    <xmx:h45iZEKvS4wtYxKw8JHhpw1-72rqADlrnvWW6tuGWGHddYs81gohGQ>
    <xmx:h45iZOwmncBDc8X1yne9T8cfMfKUWXmzQWeAWL777uKnDwERJGiJ_Q>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D9E9715A008E; Mon, 15 May 2023 15:56:54 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-415-gf2b17fe6c3-fm-20230503.001-gf2b17fe6
Mime-Version: 1.0
Message-Id: <bdd8ae5b-9ef8-4d71-b14a-363ef66241a0@app.fastmail.com>
In-Reply-To: <xmqqa5y6axk9.fsf@gitster.g>
References: <cover.1684067644.git.code@khaugsbakk.name>
 <1f24aa43f70b16381ef0cfb4f1d482706161554d.1684067644.git.code@khaugsbakk.name>
 <xmqqa5y6axk9.fsf@gitster.g>
Date:   Mon, 15 May 2023 21:56:34 +0200
From:   "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To:     "Junio C Hamano" <gitster@pobox.com>
Cc:     git@vger.kernel.org, "Jeff King" <peff@peff.net>
Subject: Re: [PATCH 2/3] t/t7004-tag: add failing tag message file test
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 15, 2023, at 09:00, Junio C Hamano wrote:
> Does this document the current behaviour, i.e. before applying the
> patch [3/3]?  Or is this a new test designed to fail until [3/3] is
> applied?
>
> If the latter, please don't [*].

Yep, I was going for the latter. I=E2=80=99ll combine [2/3] and [3/3].

> Imitate other tests that expect a controlled failure from our
> command, and write something like
>
> 	test_must_fail env GIT_EDITOR=3D./fakeeditor git tag -a foo
>
> so that a segfaulting "git tag" will not count as "failing as
> expected".

Ah, I was wondering how to use `test_must_fail` on a command with an
environment variable. Thanks.

--=20
Kristoffer Haugsbakk
