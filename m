Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 707EAC76195
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 06:05:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjC1GFM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 02:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbjC1GFK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 02:05:10 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D935D1B7
        for <git@vger.kernel.org>; Mon, 27 Mar 2023 23:05:07 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 590FE3200975;
        Tue, 28 Mar 2023 02:05:04 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute6.internal (MEProxy); Tue, 28 Mar 2023 02:05:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm1; t=1679983503; x=1680069903; bh=oAliISEKlvHVkvlhtx4fcLFDT
        63bdN7V3mY2srejWQY=; b=TGU/oQwIdXiUNrWveaWCTsuwKhtSztjwQYCGkYUY+
        wxKtg/hqHfYQJdUNX4GeJaTrMesdZgy81B+mwYZBbtC3nw1LWrRBenn5QxLW+btQ
        G8W/5XltRi8LD68KlTW2BhGBB05DIPTIfB3AeWF08/mo/3QWSmVnZYGzyB1wwtV5
        KjP/LcEASlmrb1kTonKkcfaMdYBIfQBhuwRHKEfZWdToo2jGGETcknh9M6I5czWN
        Md2L+jPmF8Bd/Xek4nxmhQrWjoF4GDIWvyEIcAcVZXKYBcsvl66uQJXnf+C3ibzQ
        736ezoRvQIBPrSVPh3G4TYs+NGAiU87C46JtKVFQHTwyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1679983503; x=1680069903; bh=oAliISEKlvHVkvlhtx4fcLFDT63bdN7V3mY
        2srejWQY=; b=YdszCp4qPhBiNZOjS8tRsjx0PxnuyX/JtoNHBCbY9GMARJCBmLD
        pWC6DT/wF6o8sq+dvAmAIzfiNUz71bTrppalUsWuliHcsx42JGcbSgI0XOKTj4Pc
        ubJBfUPJI+g5y6EtIS6HQJ00wXGUfMQgdRvCf6nfWYtOBAOd7z/HMPeHIfN2gh7c
        sPdu20d+iH7x8e4p6iJJtL5rz2JKIKwOHyqdIdOnEgLiIx2WTiSBHMQkDWwj9Dq6
        3vu+WNlTg2ZrVHLLJMFD6pjUj8q3KJRdj07nXSvoGbguK/3+H8acLUNqNHXzd8wb
        MsWmP2nobhS2FsS/d9k/BpR0uZJJYjY4Ntg==
X-ME-Sender: <xms:j4MiZFev7bHAu7CDaOMrzmhvH2TxTGhbTUyUhwypQpc0w2J7W7Z-XJM>
    <xme:j4MiZDPu5auz4SjIivK7HBpbkS36hIiK5zhv_b-gF54uODt0NI8MYb_fI5ZIuL27J
    QwoiIC_nHM_0bg-Tg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdehfedguddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    mfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoegtohguvgeskhhhrghughhssg
    grkhhkrdhnrghmvgeqnecuggftrfgrthhtvghrnhepvdevheeiudefheffvdetueevkeeh
    hfeliefgkedtieefudetueehueeftefffedunecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:j4MiZOiVTI3CEHWdqHz97WC_5jnW4st1PzWespf79Z0awM2jDxftNQ>
    <xmx:j4MiZO-vDZ_AwOwOTtMvpL59N21NfraRwa0Cv8plrFvOPQ4IIkkxwQ>
    <xmx:j4MiZBtnfLPrP6I7bL9VC6dBQvTchH3b8mShAMJ28g2FjGh-W15N7A>
    <xmx:j4MiZP2Hz7IJk_Gr89aYHii9QOjvCnc89ArehQsMogNGPm9QlEMKTw>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id CE49215A008E; Tue, 28 Mar 2023 02:05:03 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-236-g06c0f70e43-fm-20230313.001-g06c0f70e
Mime-Version: 1.0
Message-Id: <4f570b05-036d-45a1-8caa-cebfce3026c9@app.fastmail.com>
In-Reply-To: <xmqqa5zxn85r.fsf@gitster.g>
References: <20230323162234.995465-1-oswald.buddenhagen@gmx.de>
 <210376fb-f830-4883-b576-2936dabc09cc@app.fastmail.com>
 <xmqqa5zxn85r.fsf@gitster.g>
Date:   Tue, 28 Mar 2023 08:04:43 +0200
From:   "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To:     "Junio C Hamano" <gitster@pobox.com>
Cc:     "Oswald Buddenhagen" <oswald.buddenhagen@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH] sequencer: beautify subject of reverts of reverts
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 28, 2023, at 00:25, Junio C Hamano wrote:
> ""Revert^4 "A change" the other thread proposed start to look less hor=
rible.
> So, I dunno.

That looks good. And the transformations are just:

    Revert " =E2=86=92 Reapply "
    Reapply " =E2=86=92 Revert^3 "
    Revert^<n> " =E2=86=92 Revert^<n+1> "

--=20
Kristoffer Haugsbakk
