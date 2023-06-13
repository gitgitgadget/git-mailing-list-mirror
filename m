Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E12BC7EE29
	for <git@archiver.kernel.org>; Tue, 13 Jun 2023 09:47:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241930AbjFMJrX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jun 2023 05:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241567AbjFMJrD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2023 05:47:03 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B5F1997
        for <git@vger.kernel.org>; Tue, 13 Jun 2023 02:46:44 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 655125C0231;
        Tue, 13 Jun 2023 05:46:35 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute6.internal (MEProxy); Tue, 13 Jun 2023 05:46:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm1; t=1686649595; x=1686735995; bh=bSgsqVa69p3apO7q+rbn6MGmj
        pn09+Edw+iAw1l9Uw8=; b=j05JoRIBlf3pVZvWlRfM6Ppx88KmWWD5U64kvP2z9
        sVaCqSrIIwPJ9Ur+LolTZT3HzK3HJ+S4Yu1sa7UDylk4U0Jt7Ultq4zIEcWpjRfD
        kGjDIs0z8e9t/U9WixjcC/shNw7WowQ2aD9XmMgHKLK8NsjOE5yQz1iaEJVSBfIp
        9JXQj9dqzpaiSiN6MhOgLCZYtGxAQJMtTZ4FS0EtIvfeEniTmVWQTfsqXLWQSQr3
        hXRcMiMvm33JJ/CTqHPVzYaO3IfT/tSkmZx+GQ9m1UDTdvPeOtRoWrSflNMcCwQm
        XVdrSWFE8Ez5KKCFJAQEO/j8d9SmTTIzykE+vUuQ6GUGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1686649595; x=1686735995; bh=bSgsqVa69p3apO7q+rbn6MGmjpn09+Edw+i
        Aw1l9Uw8=; b=E5x3SigUBZB5U8rGAPAKFW1d0KL5MAaRTZriBLRliBhkKmo5NiK
        MXOSJemfrQqDCqJ1EAAQ74p6rPPcsoh1c2iJOgY6u1puRo6ajPCY0KJnQtCVC3PM
        yH2CeiFgiJ9WQPrOaE5zrwOp8pIokgBLzMph11BC00x/IcUGE4wzPtQdrNifZ0cv
        ThIDNiGD+KASypGd8lhKnRRBLg7sYjAup6+YE9Gqy5fZ2fj0F1OnPEW5kTuPm4kr
        V8oleIz3MycOMarTkEF5UKtccnad44djhPCP939oCMcsW/TTESUJY/5qQBnfzIRY
        as/6keMQ0nNwj/n0q1lYHUD9dszCbkVGydg==
X-ME-Sender: <xms:-zqIZBsw3j8-mpWVnAcbSuoVEpbpenXqv6KjzZN577R4RudnxXfnWwU>
    <xme:-zqIZKfZrNsaebgDDPxe76U_V4fc3CzcYRVY42aHpqhdkiX3LZkls7r2cU3qr1OGj
    mQizJssxMj3GIkL6A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedujedgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfm
    rhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrg
    hkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpedvveehiedufeehffdvteeuveekhefh
    leeigfektdeifeduteeuheeufeetffefudenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:-zqIZEwOeUMyWB7BQ2sfGhffuN0xBKvlEx7djWChoc1Bu9uO6TrjFA>
    <xmx:-zqIZIPKVtgiDhVRHTeO53oUDnEj9LjGh4rfL6EbprHnCd603tN-VA>
    <xmx:-zqIZB-w7Z2rI4yDUXYcQX6jpnqRE_q_Aj-feVq3T-0iK27xHjtPdA>
    <xmx:-zqIZDICTW7HDoR-I4i_gdbIpRFN_1y3C5Vy8XELHeHL-Fx56M91KA>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 1444715A008E; Tue, 13 Jun 2023 05:46:35 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-492-g08e3be04ba-fm-20230607.003-g08e3be04
Mime-Version: 1.0
Message-Id: <70f3907f-5afd-40aa-bd02-9435a515e074@app.fastmail.com>
In-Reply-To: <xmqqbkhk724x.fsf@gitster.g>
References: <cover.1685441207.git.code@khaugsbakk.name>
 <cover.1686505920.git.code@khaugsbakk.name>
 <9141f5a86e66276b672fc54783afe3b48b6227cf.1686505920.git.code@khaugsbakk.name>
 <xmqqbkhk724x.fsf@gitster.g>
Date:   Tue, 13 Jun 2023 11:46:14 +0200
From:   "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To:     "Junio C Hamano" <gitster@pobox.com>
Cc:     git@vger.kernel.org, "Jeff King" <peff@peff.net>,
        "Denton Liu" <liu.denton@gmail.com>,
        "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v1 3/3] revision: comment `--no-standard-notes` as deprecated
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 13, 2023, at 00:21, Junio C Hamano wrote:
>> [snip]
>> diff --git a/revision.c b/revision.c
>> index a0ab7fb784..24219c741a 100644
>> --- a/revision.c
>> +++ b/revision.c
>> @@ -2529,6 +2529,7 @@ static int handle_revision_opt(struct rev_info =
*revs, int argc, const char **arg
>>  		enable_default_display_notes(&revs->notes_opt,
>>  					     &revs->show_notes);
>>  		revs->notes_opt.use_default_notes =3D -1;
>> +		/* Deprecated */
>>  	} else if (!strcmp(arg, "--no-standard-notes")) {
>>  		revs->notes_opt.use_default_notes =3D 0;
>>  	} else if (!strcmp(arg, "--oneline")) {
>
> With the placement of this new comment, it is unclear which one
> between "--standard-notes" and "--no-standard-notes" is getting
> deprecated (actually, the comment is placed inside the block for the
> former, so it may be more natural to interpret that the comment
> marks the former as deprecated).
>
> 	} else if (!strcmp(arg, "--no-standard-notes")) {
> +		/* Deprecated */
> 		revs->notes_opt.use_default_notes =3D 0;
> 	}

Thanks, I=E2=80=99ll use that in the next version if this patch is still
included.

> I am not commenting if it makes sense to declare that the option is
> deprecated here---I'll leave it to others to argue for/against it.
> The usual reasoning to add/maintain "--no-foo" is so that we can get
> "cmd --foo --no-foo" to naturally work, but it does not apply here?

Yeah, because I decided to piggyback on a deprecated command in order to
make the change. So this change moves `--standard-notes` from
=E2=80=9Cdeprecated=E2=80=9D to =E2=80=9Cfor internal use=E2=80=9D, whil=
e `--no-standard-notes`=E2=80=99s status
remains the same, which is =E2=80=9Cdeprecated=E2=80=9D.

Unless the symmetry of `--[no-]standard-notes` turns out to be useful.

Like I=E2=80=99ve said before, I would have preferred to find a way to s=
olve
this issue without using an internal switch. But I wasn=E2=80=99t able t=
o.

Cheers

--=20
Kristoffer Haugsbakk
