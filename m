Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 548FBC77B7A
	for <git@archiver.kernel.org>; Thu, 18 May 2023 14:34:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbjEROeh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 May 2023 10:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbjEROeg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2023 10:34:36 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B91795
        for <git@vger.kernel.org>; Thu, 18 May 2023 07:34:35 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 779ED320069B;
        Thu, 18 May 2023 10:34:32 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute6.internal (MEProxy); Thu, 18 May 2023 10:34:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1684420472; x=
        1684506872; bh=XoAM4gb8Uv9GTEmkuBB5M58eGcqpo65hqs/BNCiEF4Y=; b=N
        B9yDj2qaouFCQjxszKHznuRUo97hRaHarJb5iONWNMCpk/sCbHrcKvDWn39pQ7Yd
        pon+d2Ckr/FEMGvKUyXbCDLrs2oby28R8SCwlG2eTQdz2SoYlDVKCw5anp5LoEBX
        qMPhiA0G8lQAWVoH7mP3XbK+bT01Qrcsb8Ccz3itFUILyAETSM7t0LyicHLaE+ZD
        QHO4Awb0iTlw/Ab7Ki0LrJ0F8owzJppX6gWcfCw7R1rh6GFfp/it5YW4zbNAy7xt
        F9+yC9LYPJLjZTyKCStxbrPRERwYfJvmJYFM/pJEQkAXrnxpsQYO4sqtQFUnBoVQ
        Iy9zaUB0XD6pBXNCiybNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1684420472; x=1684506872; bh=XoAM4gb8Uv9GT
        EmkuBB5M58eGcqpo65hqs/BNCiEF4Y=; b=w+MBNNsvqJfAWVAVo4Yt8RC9KTwZF
        OpiYjCS4CnWMCf+X1aDympdk9EvdG29oijv2c+uKLOM0qnjKev22+6KZRUmYJNRd
        MTzAF5EhFAQyZVls2QEo4i37KJXjdJbEOpvtl6HdWmEn+mVAnJgsRhkte9+QfmjJ
        mAHKqK+4Y4UAaxOzWi35m9vCnJ8VwTZamErkjr+fnaBvU3kXnETjQdvOrwXH/iZ+
        d6hUWO+eAH/10hjkCRNQJzNnAJi3tnCON6jnq8xKrQD42NPI0curcIHv/GFx/mux
        xfh351YzJpwbcEZlFDWOiaPQtsfI3gElxHA78+9QxtHgIEm4KMOICH6qw==
X-ME-Sender: <xms:dzdmZA6vXNgA0wsSJNNK7V5UtzA0PbMd2DfdwJKEzwMBxrsKI-xW1es>
    <xme:dzdmZB45mzFfeLCqzaXV6JYxsiRwAWKKJqe89UiIxS8BrVXxd3QLevfij4sbl6Q3O
    OnGlIkXiKNaJOAPug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeifedgjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfmfhr
    ihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoegtohguvgeskhhhrghughhssggrkh
    hkrdhnrghmvgeqnecuggftrfgrthhtvghrnheptdektdejieffleetffehieehueffgfeh
    leeufedtjeekueffgfeihfegkeffffeunecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:dzdmZPedcDen3i82iUU0IB11JprrOfSWIoC0C_Gi8PIuJfZSy-dxQw>
    <xmx:dzdmZFKYdt9d_FCWCAia5RXtAlSw6JTpqLDZo2ttHbW0QauDBdtEAQ>
    <xmx:dzdmZEJLNHYHOOHMLJsH-NTu5jKfgwGllEyWqrKN8djQAggWOPg_jQ>
    <xmx:eDdmZI3aEqLgb9clQIaM6isTf1BAJ93SZfTetCHegFlM_hd-CiI-4Q>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B952215A008E; Thu, 18 May 2023 10:34:31 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-431-g1d6a3ebb56-fm-20230511.001-g1d6a3ebb
Mime-Version: 1.0
Message-Id: <51690df7-1788-469f-aabe-84fc7a576951@app.fastmail.com>
In-Reply-To: <820dda0458994fdf7ff37870736ce6ed7871720c.1684411136.git.dyroneteng@gmail.com>
References: <cover.1684411136.git.dyroneteng@gmail.com>
 <820dda0458994fdf7ff37870736ce6ed7871720c.1684411136.git.dyroneteng@gmail.com>
Date:   Thu, 18 May 2023 16:34:11 +0200
From:   "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To:     "Teng Long" <dyroneteng@gmail.com>
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org,
        "Junio C Hamano" <gitster@pobox.com>,
        "Eric Sunshine" <sunshine@sunshineco.com>,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v10 4/6] notes.c: introduce
 '[--[no-]separator|--separator=<paragraph-break>]' option
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi

On Thu, May 18, 2023, at 14:02, Teng Long wrote:
> From: Teng Long <dyroneteng@gmail.com>
>
> When adding new notes or appending to an existing notes, we will
> insert a blank line between the paragraphs, like:

I was wondering why it acts this way. So of minor historical note (may
be obvious to everyone else): it was in order to mirror how `git commit
-m` works. From commit d9246d4303f (Teach "-m <msg>" and "-F <file>" to
"git notes edit", 2009-10-09):

> Teach "-m <msg>" and "-F <file>" to "git notes edit"
>
> The "-m" and "-F" options are already the established method
> (in both git-commit and git-tag) to specify a commit/tag message
> without invoking the editor. This patch teaches "git notes edit"
> to respect the same options for specifying a notes message without
> invoking the editor.
>
> Multiple "-m" and/or "-F" options are concatenated as separate
> paragraphs.

-- 
Kristoffer Haugsbakk
