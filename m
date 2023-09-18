Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B415CD13D2
	for <git@archiver.kernel.org>; Mon, 18 Sep 2023 11:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241235AbjIRLg3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Sep 2023 07:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241818AbjIRLgR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2023 07:36:17 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D24E42
        for <git@vger.kernel.org>; Mon, 18 Sep 2023 04:34:30 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id B972E5C0064;
        Mon, 18 Sep 2023 07:34:29 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute6.internal (MEProxy); Mon, 18 Sep 2023 07:34:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1695036869; x=
        1695123269; bh=vGf42IGZbCY9m7mpbVb7+QdmdTgFmuyqqFQjs4Vo148=; b=f
        AFTQGiKC9MlLtNiH/Qr+o0qKpExeiPxtaPI75wSoY0lyhkA5x+yzg+jAojKAf+PP
        2FmrhgCdogHWBSLnhEd313eJsbzQoh+DX+MGfWjREufPYloAV/u2qTL0rIHgqEjj
        1eZ56IZlo1x5mcTg+XSpCMCur+705SRoLwerp2COIxtMHGrj0xQ4edIbzGS1Mm7B
        xr7M/2YmCSQzxZu727y+tNrkt4gGa+7vA9+MFdRqFzGu2s0UbSa7NYoOef4Xvm0u
        LPQ7lqDT+X8DJcqagAfdo6IDooZftpRtsiQbhfzlOqGZmf5V9XgGeKFDU/6W7O8G
        mIt5V72fJrSFB65fP3JLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1695036869; x=1695123269; bh=vGf42IGZbCY9m
        7mpbVb7+QdmdTgFmuyqqFQjs4Vo148=; b=PDMbBti0LnPDTgUMi4eNzq+3/jY5k
        97VWK0RPoTBpH4uMTME+SXgmEcConrRdPJodpWYkY5UAmMrv7xRs8sb4uhw99gxI
        2KQa2GE7t0/5x98gPVq7SMCY9ahU2XIE+auVLeRlZr6s4yd4bEItBWrpJGPV/FOc
        +briUTzeEqtCvtBNkNx/4Up99/qjUXWV3ZZ7cv7zIvmXXfcMagvdxnN60BHoLWOO
        YfQzgEf3B5hly43H39ZL8V6By6nd8mAUs3FaPmlnM0iyVlv9gh8M8wnOP9Vldtn5
        SNohQrZQhqyEVlFOiPiPHuuY4A2jGd3IAIlx99q95RnYl4/89TIJzvorA==
X-ME-Sender: <xms:xTUIZVcEOnimVSRh_HhX05mWs_oeYxjgcHXJe085KkoW73H3LYTebAw>
    <xme:xTUIZTMfxAo8K2aOh3I6nabLFFCywxRkPjdHTFn0ymRByvEo0udF0CVGC_xnuaEDl
    -77ueYBShsRDL9X-A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudejkedggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfmfhr
    ihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoegtohguvgeskhhhrghughhssggrkh
    hkrdhnrghmvgeqnecuggftrfgrthhtvghrnhepueekvdejffeuudegueelteeufeevhefh
    gffhjedtheeludfffeehiedvteelfffhnecuffhomhgrihhnpehkvghrnhgvlhdrohhrgh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegtohgu
    vgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:xTUIZehy7b3lO3k-HKoFZLgNHT4eAVrKC_Obcf2FCWgefDAOCFv4hQ>
    <xmx:xTUIZe_IGZYww3_iZkcpsE1iZ0IH-GovlDqIUiQD48NyvrMK9q_eVg>
    <xmx:xTUIZRsMGc4gZyot13n_kPmb0ciJKoEzD8Wts3U6mzYs2GlbrtxU3g>
    <xmx:xTUIZZL0b1qucmc8KCt6R1DdvAPQ7brNrJpbswATF4k6tdbuC6JDkA>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 5EE0915A0091; Mon, 18 Sep 2023 07:34:29 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-745-g95dd7bea33-fm-20230905.001-g95dd7bea
Mime-Version: 1.0
Message-Id: <29780299-b3a2-4f4a-b236-ba6fbd24b6a3@app.fastmail.com>
In-Reply-To: <ZP+UgvIon1lrIFa+@ugly>
References: <2d6f3d74-687a-2d40-5c0c-abc396aef80f@web.de>
 <ZP4NrVeqMtFTLEuf@nand.local> <xmqq7cowv7pm.fsf@gitster.g>
 <ZP+UgvIon1lrIFa+@ugly>
Date:   Mon, 18 Sep 2023 13:34:09 +0200
From:   "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To:     "Oswald Buddenhagen" <oswald.buddenhagen@gmx.de>
Cc:     "Taylor Blau" <me@ttaylorr.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        "Git List" <git@vger.kernel.org>, "Jeff King" <peff@peff.net>,
        "Junio C Hamano" <gitster@pobox.com>
Subject: Re: [PATCH 1/2] parse-options: add int value pointer to struct option
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 12, 2023, at 00:28, Oswald Buddenhagen wrote:
> i'd go the opposite way and make it an anonymous union.
> that would require c11, though. imo not exactly an outrageous 
> proposition in 2023, but ...

Moving to C11 would get pushback because not all platforms 
that people care about support that compiler.[1]

[1] https://lore.kernel.org/git/004601d8ed6b$13a2f580$3ae8e080$@nexbridge.com/ 
-- 
Kristoffer Haugsbakk

