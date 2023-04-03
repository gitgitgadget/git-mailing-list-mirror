Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65C1BC76196
	for <git@archiver.kernel.org>; Mon,  3 Apr 2023 19:29:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjDCT3y (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Apr 2023 15:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232240AbjDCT3s (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2023 15:29:48 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54A1E7E
        for <git@vger.kernel.org>; Mon,  3 Apr 2023 12:29:47 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 2B9813200319;
        Mon,  3 Apr 2023 15:29:47 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute6.internal (MEProxy); Mon, 03 Apr 2023 15:29:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm1; t=1680550186; x=1680636586; bh=KUVgYp+H/z0EAvb2aHJSrGTOW
        T9D/Qtw9NVhamunEhw=; b=Mscw9n14sHvDrY7o6Atwn4w5V3F00hQqZ+P9IWrGx
        w7dqWOaisfThYNJxKxCZcWOYNBCP4OpMhqn2si77gY8x/PR7QFtOjISlg2O2lGui
        4S4UafaaDh/Ukl6/RADAfW9mHSIglafeTJ3GALiAx5Strrx08Ff5iINFIjj9Y7hL
        VQiirj3t5n6X8s/r7XuH5K1KHyNO9q+nY74Ge9qv1KuUb9b8HPLLEVUWfWsjLLF0
        VZS/VIgQNWO2GjNVHHtiN6KnSZNdCv3MlKYuzMaBcdY/BBz7Rknm9AyFFVEOAY86
        dKBJKiki3bNVPnMn5ktjTzjqGuc1VesfZavh2p7xtBJtA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1680550186; x=1680636586; bh=KUVgYp+H/z0EAvb2aHJSrGTOWT9D/Qtw9NV
        hamunEhw=; b=aLovdLGiOK6c31mDePA0ASjCXDi2b/fQ/bcPC+YUi8dcY78ScDa
        2QD8PJFRGNHPK/4UcZu+Rf5Zplp8qXDsglDNClSqIXcmFfYRtEpKIVXcvQniBPoU
        HatgzuDSwW9tSMYqsfC5FrvfvppBCIhFrt+tv1tOUisBAABmd5ENLFvqVKCc5OeU
        gmVoCDsXQW3HJTYU/Mo8eq1XqdnClaahtkXIwYYqQaD78EqepCnJhaKV8eY4eXHE
        JsnMnJVPAO/xmqLQfMW/sxjlEF9ovzbzzl5VFatJ88MTA43Dzu63mPCxryM373Do
        KEV1L/Rgs69aZokE+yuh6HEPrCNEC0wZMfQ==
X-ME-Sender: <xms:KikrZDAunF6seHzq38yZe3NqJJWE20Zc6x0P_zDm-fLrSObcEQxxwhs>
    <xme:KikrZJjmNBZVE1-QiY7buUbx6KIg3O5HEiQfY8r0aqLlKf-Yn7ZOUarh2zXCG6A9_
    gvdkv230R5EvtDV2Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeijedgudefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    mfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoegtohguvgeskhhhrghughhssg
    grkhhkrdhnrghmvgeqnecuggftrfgrthhtvghrnhepvdevheeiudefheffvdetueevkeeh
    hfeliefgkedtieefudetueehueeftefffedunecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:KikrZOkWM1fR3q54VfxP-TkUdQ_HWOO2eIBK-lMGuvRXq-RMjxG-WA>
    <xmx:KikrZFyDBXmxfJjUPWbyPsft4DCVGfYmD5RfWka8NOba2Ni513BVIA>
    <xmx:KikrZIRacZg_E0FlR6LrlYdBDLWF_qqP8tVYqbTR9TxT2T2ImfsMew>
    <xmx:KikrZHNUxuPQHXGofYINA8NPXkpC_t_KWTAHUXprefU6Op1gyrQQDg>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 94E0E15A0096; Mon,  3 Apr 2023 15:29:46 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-238-g746678b8b6-fm-20230329.001-g746678b8
Mime-Version: 1.0
Message-Id: <de43cd37-bfa5-4dbc-84d5-9362e9af6a9a@app.fastmail.com>
In-Reply-To: <818b3ad0-df43-3484-8c19-d95026f6b2b1@gmx.de>
References: <b93934a2-91e7-4645-9a24-4f2354172f31@app.fastmail.com>
 <818b3ad0-df43-3484-8c19-d95026f6b2b1@gmx.de>
Date:   Mon, 03 Apr 2023 21:29:17 +0200
From:   "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To:     "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: range-diff: slight usability problem with mistyped ref
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes and thanks for your reply

On Tue, Mar 28, 2023, at 13:37, Johannes Schindelin wrote:
> So even making the exact error message depend on the number of
> arguments could result in misleading error message.

Yeah, I see. It seems that the variadic nature of the command makes it
difficult to guess what the user might have meant in all cases.

> Do you have any splendid idea how to phrase the error message (or
> adapt it to the concrete invocation)?

No. I was going to look more closely at that if-else chain, but given
the fact that I don=E2=80=99t know C and all the cases that would need t=
o be
covered (=E2=80=9Cwhat if the third argument happens to match both a ref=
 and a
file?=E2=80=9D) I wouldn=E2=80=99t get anywhere.

--=20
Kristoffer Haugsbakk
