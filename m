Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E309EC433EF
	for <git@archiver.kernel.org>; Mon, 10 Jan 2022 10:04:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243605AbiAJKEv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jan 2022 05:04:51 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:42513 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243572AbiAJKEq (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 10 Jan 2022 05:04:46 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 50C825C00AF;
        Mon, 10 Jan 2022 05:04:46 -0500 (EST)
Received: from imap46 ([10.202.2.96])
  by compute3.internal (MEProxy); Mon, 10 Jan 2022 05:04:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=artagnon.com; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type:content-transfer-encoding; s=fm1; bh=duGRB
        MzDsMjbf6ma/IiZLjdBpjm53WYNU25Fu6/pXOQ=; b=CCpv8+0+sbLJOdgfKNI6y
        E3pOBtHL3ujkH7dz83mJVINsvIRXomZIlCI8CKZWlCf+0GIbwlolmXrgvCNKyJC2
        HE3AODA3Q6oOePRURZs4tjM41stOI58NLyB9XMVMeJB05GkWHuyZS62QdCFo75sY
        9GRIKVBOOJKrO6fnUoZLZprnQaEuEmRdTOQQMIB6PpSnrceuXfiI+JExRtfpU75N
        mCFu/FsZMBguv8dU0evyJwbJ2MXaSBBJbU8Q8CNksoFwJ5Kw4ztGNufyZs+J39Pv
        6SxX8i/bp1h34+ZmU146ABTFVpZ6IfI+Mm7nfkzgM8OQqsdWWiH4xeI9yx9q0J6h
        w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=duGRBMzDsMjbf6ma/IiZLjdBpjm53WYNU25Fu6/pX
        OQ=; b=SePTck/uTNjutG+PKUcYm+Fb9ML9SjX6au5+3+Roaf9Yck0rMcm1bmHCC
        3gEjUwX5Wmj64ccNFwtLGHsFymIcLK0KonxIwdw/GQf0joFKkcWWZMgGSViiRaGW
        0UrJ6Bbp/UobMkSxg14fQTHM4i3CNDsb2tcuYBdWsw0KrYNH/Sc8H18hUJOkM04k
        A7tAaRvh1C8FEvrZcdCVuRJaaLQVHWelQ+ddKpd67MAYLKfVnv0WXv3Ug4+vi1G0
        0KRi46XjQ9XN0esLsgXqB4D7wm5ZKKi8pux5zeWkE1UOU85TUktfUTLOEhMSqKiL
        ChSegCCqzxgSvLuzdWlfB9S0ZfdmA==
X-ME-Sender: <xms:vgTcYblVwQfBZYMxx5pcn4cyED4viC_8TdDtPotHczY_9BI-R0OFug>
    <xme:vgTcYe3R17yOxA0uRNGMeyzArwRLe_UQRZTHpXdhyCQQUXFbZpNdR-PTjSb_U5Vvq
    QV-sZSXIjuwTj6ePaw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudehtddguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgfgsehtqhertderreejnecuhfhrohhmpedftfgr
    mhhkuhhmrghrucftrghmrggthhgrnhgurhgrfdcuoehrsegrrhhtrghgnhhonhdrtghomh
    eqnecuggftrfgrthhtvghrnhepkeevueekieduleekgfelteduheffkeegveffheeljeeg
    keevteeiteekvedvvdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomheprhesrghrthgrghhnohhnrdgtohhm
X-ME-Proxy: <xmx:vgTcYRqoW1Ip8MCN0syUwWdPRK0TAMla2rT-79bVCZ80Cs6cR17iPw>
    <xmx:vgTcYTlb6TJRLDynkE7sw52C1sjOqCHBq9HjKHZCTpbJEEXJSCq3HA>
    <xmx:vgTcYZ3RIBgHJ1Nn5ehU96vUZyQFvi0Yp6lKcaUzsc0AGxHsFn5TEw>
    <xmx:vgTcYa80UTFe3mtidnQFLupFg6L3tcEbrV-BG8G36RW8w6-jmY1ZQg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 34DCE1EE007B; Mon, 10 Jan 2022 05:04:46 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4527-g032417b6d6-fm-20220109.002-g032417b6
Mime-Version: 1.0
Message-Id: <570bd7cb-ab03-41ec-9bc5-8bcc261990b9@www.fastmail.com>
In-Reply-To: <5d8c8a72-6c4f-35e4-a6a4-4ed7d6f23c4e@web.de>
References: <1edfc6ff-4db8-447f-9eb7-85843258a286@www.fastmail.com>
 <xmqqilus3ctf.fsf@gitster.g>
 <fead25d6-6f5f-487a-ad4c-0657fe9785fd@www.fastmail.com>
 <5d8c8a72-6c4f-35e4-a6a4-4ed7d6f23c4e@web.de>
Date:   Mon, 10 Jan 2022 11:04:24 +0100
From:   "Ramkumar Ramachandra" <r@artagnon.com>
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        "Junio C Hamano" <gitster@pobox.com>
Cc:     "Git List" <git@vger.kernel.org>,
        "Tanushree Tumane" <tanushreetumane@gmail.com>
Subject: Re: [PATCH] bisect: report actual bisect_state() argument on error
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe wrote:
> This doesn't fix your problem, only replace the "(null)" in the error
> messages with the actual state name -- which may be useful for
> diagnosing its cause, though.

Thanks Ren=C3=A9! As a next step, perhaps we can also abbreviate the SHA=
s in the error messages?

Warm regards,
Ram
