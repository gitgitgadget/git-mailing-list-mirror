Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C48C6FD18
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 13:46:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232532AbjC1Nqp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 09:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbjC1Nqi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 09:46:38 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CECBB462
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 06:46:14 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 7406F3200033;
        Tue, 28 Mar 2023 09:46:04 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute6.internal (MEProxy); Tue, 28 Mar 2023 09:46:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm1; t=1680011164; x=1680097564; bh=zR2iqP9iIyWPQyryaTzycg/Al
        wuzBdtVFuMJ5yc8lhk=; b=fbtW487IhSybRLZC+4soMe/+z8dc/agttFejcjZzU
        MqKQu62HygwQ0b2M9DJgNm3Q79GwnzYUz40aYoTmrkp5WBpLvRZmu2DFPix/OJSy
        ZZhkkRf2xb37oJ86s3mFejpA7RXNVW2m4JNNOFTH2NHZRfRVL8Xjyt9WmZx2Q5rj
        Jl9B4r3+RzhrAW9vYCcU8R1IJpXerWMpdwNS8DPZBdddFDItZP1KUrOT1hLwFZyj
        GUiNiva60nXgef2eY/N5aQYFSC3MdkyK6nSraQJivCgFRNv0t1beoHq/4/ijb2AT
        1xefvzkQC9J6c548TVeAhhOzaPlxFD8XdIIcRufNe2bIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1680011164; x=1680097564; bh=zR2iqP9iIyWPQyryaTzycg/AlwuzBdtVFuM
        J5yc8lhk=; b=Mun72Ec2dpNP0OaVAhuuoOf+bn8GsURI7u/52T+VhFC6hE8gbjb
        qCgicWscBMie99gxQlcezJm0AwCSMfIuQA0TEUKW4vv1C095C2h91YrD6Z0oh8fx
        oNtLJPXso0HctPv2o1LTyRtic1L8RJHqKINy7aGuklDXMo6vSbfODYBeJ4uF02Vv
        T2bKZKs39vYac7Yb/RddQxCpVSrr7CGMWKKYza7dnWwTHx1OwEcOOADW13+4z1Ey
        q+ruDYH21o+7coIOjfZoI7Lz0vkupaJrsV0zmkMFmBb3VN9BcgImizIfHMd4eA2A
        tY+2GXszwGwNhePtYjq1+pjasak+fwcPdGQ==
X-ME-Sender: <xms:m-8iZB6OXz10S0loLVET8-JCcEy2IRzs5dcyCoTD1SB_9yKAVfkDPyE>
    <xme:m-8iZO6S_Eqmw0lBSQq0uNkrS7Skztpl6vFZ_ZUJv3IJfBq4yBccxF71PErnM-qZp
    5Te9d6ZDFB_ps10DQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdehgedgieekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfm
    rhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrg
    hkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpedvveehiedufeehffdvteeuveekhefh
    leeigfektdeifeduteeuheeufeetffefudenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:nO8iZIe7VKjT9ZX__vFpeYqDYSDbYxeZ368GQOlKTj5PFIaL0S3Syw>
    <xmx:nO8iZKKO5gONaikWRSS_0mGKIZ9u1rY0_oCmiN9dp9ACm8dR44aWNw>
    <xmx:nO8iZFIL7AKWC2vpc-lTF4sZi85CHBYMNQg2LgyJXu2GCr17CFBdIQ>
    <xmx:nO8iZHwiNW_Iwo9xTOAVDgLEQUk990u9jEezSJ7pFdFSHsgWiy61kQ>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id E782915A0092; Tue, 28 Mar 2023 09:46:03 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-237-g62623e8e3f-fm-20230327.001-g62623e8e
Mime-Version: 1.0
Message-Id: <5333b921-0be6-49c7-b2dd-7d6ee5700385@app.fastmail.com>
In-Reply-To: <ZCLqbmWsN/7Ihjg+@ugly>
References: <20230323162234.995465-1-oswald.buddenhagen@gmx.de>
 <210376fb-f830-4883-b576-2936dabc09cc@app.fastmail.com>
 <xmqqa5zxn85r.fsf@gitster.g>
 <4f570b05-036d-45a1-8caa-cebfce3026c9@app.fastmail.com>
 <ZCLqbmWsN/7Ihjg+@ugly>
Date:   Tue, 28 Mar 2023 15:43:46 +0200
From:   "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To:     "Oswald Buddenhagen" <oswald.buddenhagen@gmx.de>
Cc:     "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] sequencer: beautify subject of reverts of reverts
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 28, 2023, at 15:23, Oswald Buddenhagen wrote:
> i thought about that already, and concluded that it's getting a bit "t=
oo
> nerdy" and over-engineered.

I see that point too.

> the main motivation for me is to break the dogmatism with which some
> people are approaching the matter - "$tool did it, so it is _the_ way".
> set an example where the tool does something "humane", and you may
> change some minds.

Good thinking.

Your patch does something =E2=80=9Chumane=E2=80=9D without adding any in=
volved logic. A
good default for those who don=E2=80=99t want to change the provided rev=
ert
message. (Why? I would hope that they at least write something in the
body (after the subject) about why they are (reverting a
revert)/reapplying.)

--=20
Kristoffer Haugsbakk
Frequent reverter
