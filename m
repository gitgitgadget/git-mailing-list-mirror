Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC18CC433ED
	for <git@archiver.kernel.org>; Mon, 17 May 2021 05:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF99E6109F
	for <git@archiver.kernel.org>; Mon, 17 May 2021 05:51:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbhEQFxG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 01:53:06 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:33627 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229628AbhEQFxF (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 17 May 2021 01:53:05 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 73B775C009B;
        Mon, 17 May 2021 01:51:49 -0400 (EDT)
Received: from imap35 ([10.202.2.85])
  by compute7.internal (MEProxy); Mon, 17 May 2021 01:51:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hockersten.se;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type:content-transfer-encoding; s=fm3; bh=3o
        0rc56bsHRE23kdFyOZkYKqD3WVzrQibHQkRFD881k=; b=FbugMvz0mfYO9gqOsw
        O+vg0cNqxKEXgwRALoU36J3Fex90NOOsAe59s46qCOJJYSzh6O3kMDHtPPPh0oQ2
        RJXb/xhD7WQvn3/+aUA+7q89ufuDcFCFKeHleNE7EMQuXl0iRIpm0CRRcbyOTw8s
        DahkLLRotD5zsWtrfTg7zsUvrg8Ix0xoL9be0DK+vU7S+L0kWrTFiio6sT+Su8Ws
        jzlpiPoN325617QqrPAVzu/wDkoh9p9CalFXBTp93eOFvpbMOvPPIEMNrGX8Ctw7
        pS1ee6VkZE6LjvbGLh55U851tbuTzfxoB5anxj1qXZfbBEEdgoYxErqDXp3PbQlO
        FvHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=3o0rc56bsHRE23kdFyOZkYKqD3WVzrQibHQkRFD88
        1k=; b=ExFtAqVRGgSq2aMU8mZzn3ibStN2RRpf6y39VT15z2ymL94xOO818CMTr
        FnmXakaCsPObJWXAkRVRo92B2uCHPtZ0zTZWzFVF3nOPGl0h/UBl3BwzPObjgKUi
        5EyW8wyDt8jKgbk9HvcoUQGQwnGj35nT2mlpg8JanSMNXIuH+WXVFxwIKBMIhNQK
        OrafWpKMzxLnC4GVPkCG8QzDn9+oeyl0nWiMVH5kPYBaaVld0fDvqth4+VzEslvV
        CyENCMmbaa/Z0gKu7mLF0HuxRgYFxotv3WavxKgwcMvsB9/J2SdDiYt9H/mpTkp9
        Vg8yk3Wi9ZuWUSQYAY6ri703UuzMA==
X-ME-Sender: <xms:dQSiYPT8FNcP_5bKOqK_KmvBABfnOB4aQjKUa-LY_UBqnMidopAC4g>
    <xme:dQSiYAwIGYCKnDkCma0QU_7c997JxWVxSu1a9Bpp5YfURKKbrilmSXNNlSVSCN6Ka
    2KHEsNionqdQk-0mQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdeigedguddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtgfesthhqredtreerjeenucfhrhhomheptehn
    uggvrhhspgfjnpgtkhgvrhhsthgvnhcuoegrnhguvghrsheshhhotghkvghrshhtvghnrd
    hsvgeqnecuggftrfgrthhtvghrnhepvedvtefghfdujeegjeeivdduvdekteefgfegheet
    geduudeghfffteeitddttdevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghnuggvrhhssehhohgtkhgvrhhsthgvnhdrshgv
X-ME-Proxy: <xmx:dQSiYE2NU9KXi0V05nf3kpwyzqluTSRtU8jTxX-bvxyHPWWiOwXgcw>
    <xmx:dQSiYPDDZeylekyXHnOpv3y_nyo92bf3Tl1VZ8zvnV1gaw9SEqG24Q>
    <xmx:dQSiYIjR4RLfvk8avoTgzjEKpC3RlrbiiiSYoERJUQhnWY7R1_kqgw>
    <xmx:dQSiYEZd1yrqj4-4jDBFyFVUNnVScqgAKSdikjdfPVB2RUtVi_gjdw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id C87A515A005F; Mon, 17 May 2021 01:51:48 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-448-gae190416c7-fm-20210505.004-gae190416
Mime-Version: 1.0
Message-Id: <6306f894-4fda-4412-9b1b-6fcd9eed8e77@www.fastmail.com>
In-Reply-To: <xmqqo8da6dk4.fsf@gitster.g>
References: <pull.1026.git.git.1621150366442.gitgitgadget@gmail.com>
 <1dc7877e-adb4-e3f5-3b59-bd45f9673596@gmail.com>
 <8cad4c4b-a923-43f2-9bb7-6ce418cfb0fc@www.fastmail.com>
 <xmqqo8da6dk4.fsf@gitster.g>
Date:   Mon, 17 May 2021 07:51:28 +0200
From:   =?UTF-8?Q?Anders_H=C3=B6ckersten?= <anders@hockersten.se>
To:     "Junio C Hamano" <gitster@pobox.com>
Cc:     "Bagas Sanjaya" <bagasdotme@gmail.com>,
        =?UTF-8?Q?Anders_H=C3=B6ckersten_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] describe-doc: clarify default length of abbreviation
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On Sun, May 16, 2021, at 14:58, Junio C Hamano wrote:
> Anders H=C3=B6ckersten <anders@hockersten.se> writes:
>=20
> > The explanation was mostly copied from the 2.11.0 release notes,
> > but mentioning the birtday paradox is unnecessary. I suggest
> > changing this sentence to: "The length of the abbreviation scales
> > as the repository grows using the approximate number of objects in
> > the repository, and by default the minimum length is 7."
>=20
> Heh.  In my priate review, I said that I very much liked the way the
> new description was phrased with "a bit of math around the birthday
> paradox".  Now I know why I liked that phrasing---it turns out to be
> my own ;-)
>=20
> I don't mind with or without mention of the birthday math.  Thanks
> for working on this.

Actually, changed my mind again. I like the phrasing and it's in the "ex=
amples" section so a bit of verbosity doesn't hurt. Will submit a new pa=
tch with the other changes mentioned + whitespace fixes momentarily.

/A
