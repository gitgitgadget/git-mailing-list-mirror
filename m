Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58AAAC433B4
	for <git@archiver.kernel.org>; Sun,  9 May 2021 18:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CBD7613FA
	for <git@archiver.kernel.org>; Sun,  9 May 2021 18:45:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbhEISqw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 May 2021 14:46:52 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:54307 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229662AbhEISqv (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 9 May 2021 14:46:51 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id C9727183C;
        Sun,  9 May 2021 14:45:47 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sun, 09 May 2021 14:45:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wfchandler.org;
         h=date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=XEqb8lr2D0/cMrS70FH2gdBGoCU
        /W5MKIzplSVP8fF0=; b=tfzhmb+bAN181OWQT/4d/2P6srdjzPzEGljDPmQ+yfq
        lB3mCBj/IOSmFT7jZQq61oyKhByYGuDC+OeI7x+NSbQsSxhY4v8dHFkia8UpiZlP
        glP685xuyD7w2qVAnHCKYo5B6I4OHJ62addh883eNsdqKndAywLkluw6V9cygUsf
        IU37UHfNEtFNEjYODXiVWLIYIGseGQfrxfC1XGEp7Swpo90H7BLBzIDkkNSWxtw7
        SJBzeuF1YWDAHXxDvgjoK1JIuTZKtOidBn5vsEbRm5yr5Ns6AG4CTRUosriaQO/P
        2TTy9GfRSKt5oE+o68JRl8/H8Rm3qZK9qZoS2d+z7ug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=XEqb8l
        r2D0/cMrS70FH2gdBGoCU/W5MKIzplSVP8fF0=; b=AhU3mNh56wqLa2LL867eSB
        Qz1kdkC6LUKkZZSi0WAQuP+/prZ1GoI3JAjlhuT+bd1JPm4izURDWGHFlIbxtBZg
        XVZlOyzUyp4kQBt5nXoHOvi+FBa60SUK8dgplHC2oCVMicS7aQXE3qGMYEv8uchq
        WZvwoSwaVDbQ6hN0WYGyUIRXU0mJ6kP9QeC1aHwjCcCS4OeD7KKLN4mIMTMrt1Q6
        m2HRBDfUgU3+5TZTRpLiQ4hpJWu017LqcM0obTeM6nEjFKs+bEMUXnMqwFpDMjT7
        cmilJ1eaK5c7Ho3vBzLloOXxf6qkNJ/5WQ+GohOi9Gis1jgWvAn4SKpdZHqSfLrQ
        ==
X-ME-Sender: <xms:2i2YYD5Vu_VW09dlUqrqs0cO48GeV1aYLaUpLU_noUSWFtfqqfmTCQ>
    <xme:2i2YYI4bd5CnRK-aH5RiYhjlzPaLU14pHokDNhV48zUyceo6t5q0L11ks3Aocyicp
    4imJdNIDjVRDGMnn7w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdegiedgudefudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesthdtredttddtjeenucfhrhhomhephghilhhl
    ucevhhgrnhgulhgvrhcuoeiffhgtseiffhgthhgrnhgulhgvrhdrohhrgheqnecuggftrf
    grthhtvghrnhepgfdttefggfeludfgffeutdfhueetvdeikeehgeeihfeugffgueeutdeu
    heduieeinecukfhppeejhedruddukedrfedrudegleenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiffhgtseiffhgthhgrnhgulhgvrhdrohhr
    gh
X-ME-Proxy: <xmx:2i2YYKenwAfkBSwxjDWXyrseJ-UiVPMZo51mANLIjYCVfQ77XXGr1w>
    <xmx:2i2YYELYfgjsExu_eqKBI5v8s3htsYxMXexkTaQGVppNcLsRpF8XeQ>
    <xmx:2i2YYHIkaWlNmkpINKXaQHa7z0J57o_uXRcSSQE-3Sknfj_9AQMmYA>
    <xmx:2y2YYP0xpHpJdBOhItcU8sfF4L3gq51gLgXawUT5tmXHZTq6CuDeDw>
Received: from mini.wfchandler.org (d118-75-149-3.try.wideopenwest.com [75.118.3.149])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Sun,  9 May 2021 14:45:46 -0400 (EDT)
Date:   Sun, 9 May 2021 14:45:45 -0400
From:   Will Chandler <wfc@wfchandler.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Jeff King <peff@peff.net>, git@vger.kernel.org, ps@pks.im
Subject: Re: [PATCH] refs: cleanup directories when deleting packed ref
Message-ID: <YJgt2UzAdhFfrDHm@mini.wfchandler.org>
References: <YJVQpaDwkQH/aCee@mini.wfchandler.org>
 <YJW3n6lVWVAuLQap@coredump.intra.peff.net>
 <YJW46fsdKaUv2Fln@coredump.intra.peff.net>
 <YJXF4xA0GFx2/2v4@coredump.intra.peff.net>
 <YJYTQYk5q8g6HaIm@mini.wfchandler.org>
 <YJYa+7yUyt2YD16r@mini.wfchandler.org>
 <1bb65e54-a18d-852d-bb01-130cc57cce1b@gmail.com>
 <xmqqmtt5vj2x.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmtt5vj2x.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you, Junio. Would it be helpful if I sent a separate '[PATCH v2]'
email?

Apologies for not following the correct procedure for the revised patch.
I was relying on 'SubmittingPatches', but I've since found the detailed
instructions on submitting revisions in 'MyFirstContribution.txt'.
