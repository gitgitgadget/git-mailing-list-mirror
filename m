Return-Path: <SRS0=W4Po=BO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2269EC433E0
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 07:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 154102086A
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 07:40:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yxejamir.net header.i=@yxejamir.net header.b="dCdKy2kj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ULLc8pcV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729934AbgHDHkr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Aug 2020 03:40:47 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:54329 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726808AbgHDHkq (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 4 Aug 2020 03:40:46 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id AAE781678
        for <git@vger.kernel.org>; Tue,  4 Aug 2020 03:40:45 -0400 (EDT)
Received: from imap3 ([10.202.2.53])
  by compute2.internal (MEProxy); Tue, 04 Aug 2020 03:40:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yxejamir.net; h=
        mime-version:message-id:date:from:to:subject:content-type
        :content-transfer-encoding; s=fm3; bh=6WQeId2gLMKSRhMGrH4YGfLqw6
        t9GSUg5/9nWD2nw7k=; b=dCdKy2kjOwQrQhWtoRtpjLCObkpco0Ef7cgcUgJ8Tv
        zd5rILrkMwsYA9647xua8fGFCPJv2MbP0IjpGamEFajNb+KysuPY2Entt0BKZ9pg
        Luu3q2phukh1KSZ/FfKCdNycIYn+ynpvoJwQE8DIXNUe81IP7GpUCVM+cdFlIXKH
        UjX/FxYodZ9WnycyruuerD8gKRZY2GaD4canJ1CdloYacSP3nNIeWzXv58oLSuLc
        H3BNOFX7tnE02AOFm+kot8rzu6oI9Tfs9L6TAjtV4bXrHW2+kwcjPhPFkCstVn/y
        RGEsNMRg859WornwTZRmOB8aV62RgY+DbGbG56nlZy5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=6WQeId
        2gLMKSRhMGrH4YGfLqw6t9GSUg5/9nWD2nw7k=; b=ULLc8pcVdyY5SVAKSbbACA
        QdvKnPknfQQYf3dWr9MbA399XpmhFDmEHRiR225rajyW8iPMHJ/WUx+cUlWv9I9V
        nHIHRm9uUjvfVE9jcLZv0WQsdugH9XHDJNd7mz+DnbvN8Co61uQpDtYleyjbJf/P
        CBUFg8x1dueGHoJggNkNbmEMjTBggXBkIJZqFRbYvdIpUF4Aa82JQcw3VJKMe8C9
        jFWWtdKe6SQBGsoW2cTES2H4G8Wv9oiSY8seoIjL2lLYSCURgNxnD7rkvf31H4ik
        xyG0Jv5maM3vN0rS7HTO2/hRonj1upNYRD28cPC7baoqIlK8MS0O1/R7yJL2xTCQ
        ==
X-ME-Sender: <xms:_RApX0nIVI5jxhcfT-IGfxu0trreLf9eisD1olP7TKa-IAzOCdN-WA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrjeehgdduvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfffhffvufgtgfesthhqre
    dtreerjeenucfhrhhomhepfdetmhhirhcujggrlhhonhdfuceorghmihhrhigrlhdqmhhl
    jhifnhhlthigmhhoseihgigvjhgrmhhirhdrnhgvtheqnecuggftrfgrthhtvghrnhepie
    ekhfevffduledtkefgfeekhfekveejffevgeegieegtdfhjeejjedtudffudfhnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghmihhrhigrlh
    dqmhhljhifnhhlthigmhhoseihgigvjhgrmhhirhdrnhgvth
X-ME-Proxy: <xmx:_RApXz35TP8ZoADzze2tNwsCBHjiibWJ8ZAlJKxIJimhG4mhCVexOQ>
    <xmx:_RApXypFT31k59kz3OlKeX3Ki7K0NL8drBU5v-mfvFrgKayqUlzX2A>
    <xmx:_RApXwmbfwY0rOp6DJ3vk0ury_sssubKOTAwH7lEqSH0l5c3zA27rw>
    <xmx:_RApX11NuqizWO3-W6KFPMZ3y41Ghj5bKRQRPEZZmomaakARChjxXg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 13FEC4E009F; Tue,  4 Aug 2020 03:40:45 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.3.0-136-gc39b634-fm-20200803.001-gc39b6340
Mime-Version: 1.0
Message-Id: <9e184f84-9658-4562-88ea-50039b19aea7@www.fastmail.com>
Date:   Tue, 04 Aug 2020 10:40:16 +0300
From:   "Amir Yalon" <amiryal-mljwnltxmo@yxejamir.net>
To:     git@vger.kernel.org
Subject: git blame --ignore-rev to accept tree objects
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear list members,

In the manual entry for blame.ignoreRevsFile in git-config(1) it says =E2=
=80=9Cunabbreviated object name=E2=80=9D, which misled me into thinking =
I could specify tree objects rather than commit objects. This got me thi=
nking, how useful it could be, to be able to include detailed instructio=
ns how to ignore a particular commit *in its own commit message*. Right =
now, it is practically impossible to do, because one can=E2=80=99t know =
the commit object name in advance. However, once the tree object name is=
 known, it=E2=80=99s easy to include in the commit message.

How practical would it be to implement this feature? How bad could it be=
, if some unrelated commits with the same tree would be skipped unintent=
ionally by git-blame as a result?

Regards,
Amir
