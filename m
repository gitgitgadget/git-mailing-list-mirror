Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3156DC7EE43
	for <git@archiver.kernel.org>; Tue, 13 Jun 2023 05:43:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbjFMFn5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jun 2023 01:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233747AbjFMFny (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2023 01:43:54 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F90F9
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 22:43:53 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 02EF632008C0;
        Tue, 13 Jun 2023 01:43:49 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute6.internal (MEProxy); Tue, 13 Jun 2023 01:43:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm1; t=1686635029; x=1686721429; bh=1TauBS+iqHylRi6RU2/E0qgBs
        kOB3xzhmiw2utljZrQ=; b=XTomVWIW3s4/ugxv2MM7RVBGf41gPV6oYcTIqv2pM
        fKjl1w4iZgU6ncynjnoFmsbmoRX5Zfp9URoQ4L6iAkj03X3RbTI5k3/jnB0vv8/x
        Lag904z6S14lmXmWBLuy47Qdg4EkRJDp2nm3k3scXHcuK7Po9k3Uq0SfZc8mAXqQ
        KYACIlwWPHwrFyC9H8R2xu46h1i74FMPDZqQeZeIjricmGsFjZjSTFzv2Aw3AyH7
        ncz0/Iz1kpSvaFW4wWpzEW78myXdAlDeBQa72hvMwCLTUsO1Oa8ZwEUb6EXJQUvZ
        Sms2jn+IfSRQKdpGkKBlTuomAaZmRSBYjbpMhrh5zWsqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1686635029; x=1686721429; bh=1TauBS+iqHylRi6RU2/E0qgBskOB3xzhmiw
        2utljZrQ=; b=PZyqXHYkZXa73K5nt0tExkRT3OeMWR5hbBTgAnNecUNrrzrH5lU
        nGTW4hGLY43W5+inLUXx8x4tMLLeaZaPhHm+EcspZtxPXXsk9ifDT7TcFsS3JWWe
        wd4GfCy/IE3XANED+vLCjYVlEnhbGMGbvK60vFS0IvwYTMdNySVi7bgysuIhEweA
        aQaBvt9aTkmLiYDsJZa7O7gpAD4aX0uNqk+Qjkyzm6k/n/XQ4a8RxkV4jADTt8DT
        9hYRq2Sw86ZpLZR8IiDevzGL4jKUjCU6FgJPsl9cCXCBY99xTrstMM1PX0jg3v9H
        rv1IP23ey7wlmpvFyw4yLW8vYGvhpmFgEiw==
X-ME-Sender: <xms:FQKIZHRKZEvJycVjeVIfsYwaAjNxYJdRk4qEIRwbkdrOI8C3Ru-3tjQ>
    <xme:FQKIZIwHfrdrFgiAcPOz_WRJM3T9cxxmdbpVN4hIcthsyWIr--LhcWEcL6dTkDcWT
    gTdeNO4IWCTbJ5ZEg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeduiedguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    mfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoegtohguvgeskhhhrghughhssg
    grkhhkrdhnrghmvgeqnecuggftrfgrthhtvghrnhepvdevheeiudefheffvdetueevkeeh
    hfeliefgkedtieefudetueehueeftefffedunecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:FQKIZM1W4a8Qh1bJvcdGceKwuioETln_9fliC6CzsrLOfYN1DyhFWg>
    <xmx:FQKIZHCPzWZNTz_RRgByoQ1yQKl_f7qPNTdsc97aN8u0yPahr7e-Uw>
    <xmx:FQKIZAh36At3SgcTsp7f9XM0qfTYu-b3xgFERRz_fyCd-vcxlrSuIw>
    <xmx:FQKIZDtd2NMBETHfUG4se6Z-53rC4MoMX0sF2jew3uc6OQQTHC9YYg>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 69B7D15A008E; Tue, 13 Jun 2023 01:43:49 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-492-g08e3be04ba-fm-20230607.003-g08e3be04
Mime-Version: 1.0
Message-Id: <765971e5-fa3e-42bf-88df-9614c3b7e8dc@app.fastmail.com>
In-Reply-To: <xmqq7cs871ys.fsf@gitster.g>
References: <cover.1685441207.git.code@khaugsbakk.name>
 <cover.1686505920.git.code@khaugsbakk.name> <xmqq7cs871ys.fsf@gitster.g>
Date:   Tue, 13 Jun 2023 07:43:29 +0200
From:   "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To:     "Junio C Hamano" <gitster@pobox.com>
Cc:     git@vger.kernel.org, "Jeff King" <peff@peff.net>,
        "Denton Liu" <liu.denton@gmail.com>,
        "Johannes Schindelin" <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v1 0/3] range-diff: treat notes like `log`
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 13, 2023, at 00:25, Junio C Hamano wrote:
> Kristoffer Haugsbakk <code@khaugsbakk.name> writes:
>
>> This is the first normal (not RFC) version of this series. The follow=
ing
>> cover letter is identical to the previous one up to but not including
>> section =E2=80=9CRFC and version 1=E2=80=9D.
>
> I have no strong opinion on the topic and did not comment on the RFC
> version, either, so I am puzzled to be CC'ed, especially when the
> primary author of the feature is not.

The CC list is the output of `contrib/contacts/git-contacts master..HEAD=
`.

I=E2=80=99ll include Dscho if I make another series that touches this pa=
rt of
the tree.

Cheers

--=20
Kristoffer Haugsbakk
