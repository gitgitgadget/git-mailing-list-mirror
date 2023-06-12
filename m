Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B0FC7EE25
	for <git@archiver.kernel.org>; Mon, 12 Jun 2023 08:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjFLILj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jun 2023 04:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjFLILh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2023 04:11:37 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C4DF10CC
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 01:11:07 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id E3ADB5C0116;
        Mon, 12 Jun 2023 03:25:38 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute6.internal (MEProxy); Mon, 12 Jun 2023 03:25:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm1; t=1686554738; x=1686641138; bh=43zfEdattPq03MRWWhRK6x197
        fFTNeRl2pkqB3HIrLk=; b=Mw2cqm7Zy9xZjqd0h6VIyIPdN7KaV9fDqYJnzIfL7
        kyrZ5yISlpex2HjCxV8CUvrX11C4re4TqeI3/XPZQug7wEx9MQ4yAUrbv067ukd4
        YHMABH5RtoWaqNvjRm92keOrtZ7OGWYVqrBWjjSCGdYO6PGyCJP/9tL8MbOHWg5w
        NS64ri1GhELSWy4IyTVs3025kpahj24Y1iKygsoOjt/RSCgzQ+C/v6MgJDAW2UwE
        39labmbGN6BuJ9Xus8dAaH1YZnHJSjYXEAKh3gDGT8Kv1IGXuPUjTVOvmNyhwmLg
        WryTfu8Qq7XLSJU11KT3M4mbzddfL0naYEfgvU4fNuYFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1686554738; x=1686641138; bh=43zfEdattPq03MRWWhRK6x197fFTNeRl2pk
        qB3HIrLk=; b=IK2OHgPxPhvOslGnjZLvkWZKS08BpxW17WE9EbC9O0aBa5Tl/n/
        1X9dsEngC0hzmZfwMMnqiuKyrz7chirBBbyZbwc/Vu4xlFXPZ5M5URN/2lxv+Zt3
        faZqalkj6haNdKEusdyoktrfQ60JfA7/d6a5KpQwSfOzrYmKjGQCRlPlTIl1n9rD
        bXkcNu8Aywz1fRpaRmBSshhGXaTFoYP0U70HNUsCsx1AmI80623/X9Y2TMDi+KyL
        /oL1qYuupaE7zUeTfDnzwU/BOvbEWbZ+fJ8tfgaY2Fu2fkDoGXwEhOWmqIOaOfV/
        46iotlnNsE8Cl6DQVSKBVquT2yvOXsnJ51g==
X-ME-Sender: <xms:csiGZExf7cOS_thQ4KqJCz9HaXHgDhWVBbXV4c4RLq9_4x19AUD-05Y>
    <xme:csiGZIT3tblBhnynsDW-D85b6oimag0MBi_5f702QtBbq3HrMaL5iifYukBcKwnet
    8mma5hUz_miOryn7g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedugedgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfm
    rhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrg
    hkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpeffheegueelgfefjefgieejuedtffdu
    veevgfffffefieeugfegkefhjeegveefffenucffohhmrghinhepghhithdqshgtmhdrtg
    homhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegt
    ohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:csiGZGVT6yuzlwBfbHro5uVo1j1mnjxA-uiRmKFnqVpxSWkJ3pJf8g>
    <xmx:csiGZCisHtyh_Fgn7hZ7H8c5SYH4dh60m3OTK6uAw2P1EyVxEtB-LA>
    <xmx:csiGZGAB3-hMplPLFnyQrL3JEhXIYcvzom-cx_9s90AT98OfMjBSWw>
    <xmx:csiGZN8WCCdDnN-6nSXBhMXVbVUInok4I-y4luEXnxvq4Jf3Q-rjOQ>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id A5BF315A008E; Mon, 12 Jun 2023 03:25:38 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-447-ge2460e13b3-fm-20230525.001-ge2460e13
Mime-Version: 1.0
Message-Id: <43c88a0d-2f35-4a9f-a6e9-a32360dfe42c@app.fastmail.com>
In-Reply-To: <CAJf_aa3Xz7t31bzWbvcAkNW=K7Qga_awLuiipE6MSe7Bgv5_Zw@mail.gmail.com>
References: <CAJf_aa3Xz7t31bzWbvcAkNW=K7Qga_awLuiipE6MSe7Bgv5_Zw@mail.gmail.com>
Date:   Mon, 12 Jun 2023 09:24:45 +0200
From:   "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To:     "Hazem Alrawi" <hazemalrawi7@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Newcomer
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi

On Mon, Jun 12, 2023, at 04:45, Hazem Alrawi wrote:
> Hello,
> My Name is Hazem Alrawi, CS student
> I want to deep dive into git codebase and begin contributing to open
> source but I encountered some problems and I have no idea how to solve
> them, so can you please guide me to fully understand what's going on?
> here is my prior background
> -C++
> -Data structures
> -Algorithms
> -OOP
> I used to solve Problems on different platforms like Codeforces and le=
etcode
> Codeforces Handle:HazemRawi
> LeetCode Username:HazemRawi
> I've solved more than 1500 problem on different algorithms and DS (You
> will find them listed on leetcode account)
> What is the prerequisite I have to learn in order to start fixing bugs
> and begin contributing to open source projects like git?

Here=E2=80=99s a tutorial: https://git-scm.com/docs/MyFirstContribution

--=20
Kristoffer Haugsbakk
