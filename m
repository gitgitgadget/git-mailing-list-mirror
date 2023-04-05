Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1926C76188
	for <git@archiver.kernel.org>; Wed,  5 Apr 2023 09:11:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237014AbjDEJLp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Apr 2023 05:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbjDEJLn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2023 05:11:43 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761E790
        for <git@vger.kernel.org>; Wed,  5 Apr 2023 02:11:42 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 50E5B5C00FD;
        Wed,  5 Apr 2023 05:11:39 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute6.internal (MEProxy); Wed, 05 Apr 2023 05:11:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm1; t=1680685899; x=1680772299; bh=KURhENeqjTVI/C00MaR43N7Gj
        S/bRd2LRQmbtpc1abg=; b=FaccYQ70XwY4G8ZSc65w5aKywybT36Gf9SjZBPzlZ
        TjCfIcXB8YmSnxJKy9uy2at9rXRtR1Dp/4doGu1FLZGnLk+wqruUBh6iS8YIjf4O
        k3+6+Ej9sG55aeRbZh1hBo3JtZWrx06LE2xIdZ1RZtqWbUxCLxRAAPSu0F7zzfsf
        r0TBKNAYxdvFnp/K1Js56sq1uXRGdsx0Jgw9/mZWot/RP2pGixLVbLiv/8ysqdV4
        mjcZixHOUp8PXDLqBRGHAAltm88a1Ra5w9SjMzZcwgWi74Z05UIhIdfOWoTTqnQi
        Mjg3XyaEts+ZrcsmPmkv/CLXSYmqeXoAUUkTGf4KeSDxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1680685899; x=1680772299; bh=KURhENeqjTVI/C00MaR43N7GjS/bRd2LRQm
        btpc1abg=; b=vMGWp+zVppv/s+bSQ7iRbAc4TDJ+d3Iv0x15TgdgEgBDWjTOz4T
        Yf9QwcG86sDSdjAFUKcg29huO1gQlnSw2fpiuIougSplFxjvDfUpQHjcLP7DNqiI
        XMQYRa0N2J4WYKmDvFCy4YDYp1brQhsHLUKs8I3XHMZCj/ukMLK18gIHPPaUdeiD
        lnZq7N5wBNGFcOukb9q6FkMI99mGeDdQAorBLayeT7TaSszoz3DloiKzItI2Wpn5
        yWvIG2pWEkRF30NSW6rn95buktxRr+8TcGLzBVVfMQ5X8/mqVKQWrFATwDjAyrdC
        k9W/dly9HPQ7vQidgZ06hISvrya4jVtlvxQ==
X-ME-Sender: <xms:SzstZMLHLz5onFOJa1tj_W66-2BtzkB1XsXtv-XwDkc9wBIoMYlYRWw>
    <xme:SzstZMJ1nhJUl_VipWPZ9N_zVSs3IWzyMJaRl2iZk76Wnc0EUh3I5Do2vHJtsZbSH
    MskuJDCY84MEfjM8Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdejuddgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfm
    rhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrg
    hkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpedvveehiedufeehffdvteeuveekhefh
    leeigfektdeifeduteeuheeufeetffefudenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:SzstZMvHfA3EnZZAYFYYfoAudhdLyYAyzijQ0oeSDRaQwyeoWiFFig>
    <xmx:SzstZJbfqFdI6ZjhP6PsollCRm23nV-q4wTDP2B4bMTn1-ukBA8krQ>
    <xmx:SzstZDa7U3qG-2J5ZDObTwgef35mpdARpI7q-a1Ofl8rLk0jwXqbdQ>
    <xmx:SzstZEDz0FqHjV8-Pob5aeSafTl-6RkTl-QrvUF_p8WcP-eRjTIpJg>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 0B2A815A009A; Wed,  5 Apr 2023 05:11:38 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-334-g8c072af647-fm-20230330.001-g8c072af6
Mime-Version: 1.0
Message-Id: <7941ae15-a29c-4163-8170-02fd96a80048@app.fastmail.com>
In-Reply-To: <CAOLTT8QJYumrv1G1SQ8005n2ab1Ycyoc6T_YyFHunJM5=6ZmtQ@mail.gmail.com>
References: <20230331181229.15255-1-code@khaugsbakk.name>
 <cover.1680548650.git.code@khaugsbakk.name>
 <ea06be8f5ac77e5be64ab674f5a4fbe0b7e56c0e.1680548650.git.code@khaugsbakk.name>
 <CAOLTT8QJYumrv1G1SQ8005n2ab1Ycyoc6T_YyFHunJM5=6ZmtQ@mail.gmail.com>
Date:   Wed, 05 Apr 2023 11:09:12 +0200
From:   "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To:     "ZheNing Hu" <adlternative@gmail.com>
Cc:     git@vger.kernel.org, "Andrei Rybak" <rybak.a.v@gmail.com>
Subject: =?UTF-8?Q?Re:_[PATCH_v2_2/3]_doc:_interpret-trailers:_don=E2=80=99t_use_?=
 =?UTF-8?Q?deprecated_config?=
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 5, 2023, at 09:45, ZheNing Hu wrote:
> Changing these examples from command -> cmd makes sense.
> So users will tend to use 'cmd' instead of 'command' as much as
> possible when referring to examples.

Thanks ZheNing. I=E2=80=99ll add an =E2=80=9Cack=E2=80=9D trailer to thi=
s patch. :)

--=20
Kristoffer Haugsbakk
