Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD7CCCDB46E
	for <git@archiver.kernel.org>; Thu, 12 Oct 2023 07:28:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347114AbjJLH20 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Oct 2023 03:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234125AbjJLH2Z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2023 03:28:25 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BFAD90
        for <git@vger.kernel.org>; Thu, 12 Oct 2023 00:28:22 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 420F532009AA;
        Thu, 12 Oct 2023 03:28:20 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 12 Oct 2023 03:28:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emailplus.org;
         h=cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1697095699; x=1697182099; bh=ubaU9p1JOaN4PjVR99IPG+BRxIc1kIo0+M6
        kIdubRQc=; b=Q8LOaCQsHFOJDldLSzZXEenssxocliiOCHpgFXPXqImVkARygz5
        t7SCS1WAlrptR1v8EPfpc+ProyWjq8Mbzpjo61G3R1Brt8u/IpIvXl5o5vjzWYoF
        mp43DgzUnBFKBnLI5ry9qNXzRhcnQVski2Do9uBUvxi+sTleqfDG0RP3ku212Rzr
        vdHBunkV2hqNLUZe+9/X3apeBt/GvL3LtI16wQ6btYMf5yZYlT4ad/SjrqTn1ghS
        Y7o1XEACIVXjNCfG6xm9RFpw3N3isdf6EdZbr/rsPfeH6hycuQu12GsG6QCqWlTV
        6GaXWiz43ZWKu8qlqGEE4rcDa6OcnIOMfBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1697095699; x=
        1697182099; bh=ubaU9p1JOaN4PjVR99IPG+BRxIc1kIo0+M6kIdubRQc=; b=U
        B7Rifoo7B5DRugoX0BweeAO7PfMtO78xa3VuCXZBCBjDGZ9LJwwvbITjvhYu17iw
        0aNdDmVg3ZmgiBkaIlWumvSDtFt4TAZFTKv2P/T09SwxT+Lv+QaTcvNVpEZQceRo
        MYMRbrdNuVLsJAcymz7BZ298r4d01oDuXE+ZiWYtpi4T+tmD1O/sjEPis3tyPi9H
        fv0Q1hng7PnvFHfY8D2totbCjbM5pORGeD6fbbtqdgaVkkrTSol1NPk1E1cLqHUx
        vLljYw3IFn3D8+/4pZK2oKfFUrSQXUC0apjFqOMvoTq1XqYb6kel2rJ8WxOVqowr
        EBF1mwp6q1E6GjBsFGVKg==
X-ME-Sender: <xms:E6AnZWeFezbpC8EbeMKu6We-wLWHz5dj-zCiYZEMcwM0SAj6nLhFTQ>
    <xme:E6AnZQNzXMF5CnQGaxI_t5bBR3odIyrECebbyVpfnJ2tzE6bdsNsOyZ1KzUNQdI7q
    hg1b1dFHk-c0zMg>
X-ME-Received: <xmr:E6AnZXgC1vvQGSZ1T8EM16YMmIHjGKQYKpnWfpOjYt8XLSCBTu1s5hQoMTyxtliFv1d_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrheelgdduudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvfhfhjggtgfesthejredttdefjeenucfhrhhomhepuegvnhhs
    ohhnucfouhhithgvuceosggvnhhsohhnpghmuhhithgvsegvmhgrihhlphhluhhsrdhorh
    hgqeenucggtffrrghtthgvrhhnpeetveettdegfedvgfevtdetvdefgfejudfhvedufeek
    vedtvedvgeekueetfeelteenucffohhmrghinheptghurhhlrdhsvgenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvghnshhonhgpmhhuihht
    vgesvghmrghilhhplhhushdrohhrgh
X-ME-Proxy: <xmx:E6AnZT9J2hsikhYyXyg39L1EsQEC1amn03NHPmPgMO0w0jCJXGbCiA>
    <xmx:E6AnZSuOF17P8fcFjpD_5a-15pfYGg3pck9_UCoJ0PQ2Jl2wTNZUsg>
    <xmx:E6AnZaHGTBRXHKpMS9RisP-tjJftNA_-JPfq1Y3GmbF4kl2dpb4F9g>
    <xmx:E6AnZY32w221aJeQtDMlaobLKq8wj984SkeRsmETEoU6V39Aw_YrOg>
Feedback-ID: ic1e8415a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Oct 2023 03:28:17 -0400 (EDT)
Message-ID: <4c5fef38-a671-dd6b-4b10-a531e1ae254a@emailplus.org>
Date:   Thu, 12 Oct 2023 10:28:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [Outreachy]Introduction and Problem while installing Git
To:     Dorcas Litunya <anonolitunya@gmail.com>, git@vger.kernel.org
References: <ZSeYzdx07Cj67lR4@dorcaslitunya-virtual-machine>
Content-Language: en-US
From:   Benson Muite <benson_muite@emailplus.org>
In-Reply-To: <ZSeYzdx07Cj67lR4@dorcaslitunya-virtual-machine>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/12/23 09:57, Dorcas Litunya wrote:
> Hello everyone,
> My name is Dorcas Litunya. I am excited to contribute to the git
> community, I am a first time contributor through the Outreachy program.
> I am excited to learn and grow through this project. I am currently
> installing Git and I have been faced with this error once I run the make
> command:
> In file included from http.c:2:
> git-curl-compat.h:3:10: fatal error: curl/curl.h: No such file or directory
>     3 | #include <curl/curl.h>
>       |          ^~~~~~~~~~~~~
You will need to have curl libraries and development headers.
https://curl.se/libcurl/
You maybe able to get these from a package manager, for example on Ubuntu
sudo apt-get install curl-dev
Fedora
sudo dnf install libcurl-devel
