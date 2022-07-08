Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A887EC433EF
	for <git@archiver.kernel.org>; Fri,  8 Jul 2022 22:37:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237884AbiGHWh5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jul 2022 18:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237841AbiGHWhz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jul 2022 18:37:55 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8573C13B46C
        for <git@vger.kernel.org>; Fri,  8 Jul 2022 15:37:54 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id D1F2E3200915;
        Fri,  8 Jul 2022 18:37:51 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 08 Jul 2022 18:37:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=u92.eu; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1657319871; x=1657406271; bh=y+vEnugj98
        Dm6q8RhLgvDBz9gp73DPn/GSNn9bZOiYM=; b=SOWNwgoRS/z08UgMXCLygC956I
        l1bqTKe+966lS/aFZl7gYJe/A9K8lzFKn8Ej+yNo2Gq5A2JmDxk+a7TxdVrUVrQ/
        OJ94iPpLvG7gJnscLdlgtnykXeKcAdrwsJJEdbmRoiFRgKds+xCavCNhDG7KwVyO
        1pNRgxxGKJ10U30vrAttU5MxEr7Vb+XVD6YManb8ApH2Z4j0/n8WiO+RtOqayg8k
        RsC1Ze+Ndh+RfPxQmrg2wJhOcTUm8vxSxitT4diTL1LiWctb8ppue2/K2zzVvc/x
        pqFDRhacM+E18SWATqxvEtuRJxN/fso/3FhdsQK5qhJnF3gR8427sjshSB+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1657319871; x=1657406271; bh=y+vEnugj98Dm6q8RhLgvDBz9gp73
        DPn/GSNn9bZOiYM=; b=yrgcUSTnBw0d4yYgwlwS6aLFwcwMhdl8D2EAOXCWgSaP
        24rYk73/e+p32VfX0SgXOk9adzBQ7LL5Jqk9RUtkX1e+ouIS9ui/Y2/D+uw7Ap6F
        0VPRLF9og4X1afOvyCBpEP4MDb9u7NS7FlDs2UcOdQBNCpxRVXhQGOnwpVyqfZaf
        /VShaTfd4F9XVWbvftvSnlvmNY6/vsRT/4BaneTB8nfiFsIrI8gCDi6F18dXP0Z4
        db4ShxZULLIOUx6z4QMWKfjyaou42AeXpdhKtG4L5smKzg9jk1drig9k62BsKyQn
        sqXnuyH7YqVV8pgnTqYJ+PqGHb/radxSgkkgZOo38A==
X-ME-Sender: <xms:v7HIYuDoLEqbVfEIUYC3BihynCJ0vyuGUS6x5k0YabegWyMeshQp5g>
    <xme:v7HIYoiDziQs8TDqM7dPgwd6v4v_c0yMGc4cdyAKnRZkE1t9Af56af0a8i5_lKQsc
    h3XQVvTa-2O1m1Juw>
X-ME-Received: <xmr:v7HIYhmJ2l5qZ9iW77UxpgRWY_dP7NpJlA7r3SbvYSUGawrpVUvEWJu9x3CEtHunKwd331TCbfI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudeikedguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttd
    ertddttdejnecuhfhrohhmpefhvghrnhgrnhguohcutfgrmhhoshcuoehgrhgvvghnfhho
    ohesuhelvddrvghuqeenucggtffrrghtthgvrhhnpeffheevteefjeevieekheeujeeive
    fguedvieefleeuiefgtddtleelheevledvjeenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvvghnfhhoohesuhelvddrvghu
X-ME-Proxy: <xmx:v7HIYsxBKBCt6igtzuivCyBAS7XVK3_sjKiDgbM8cL63wmdvRGaniw>
    <xmx:v7HIYjQQldiVLGZRMkeHLXeMawMWty9hhkMAg8hw9xtenoqZUPGiFQ>
    <xmx:v7HIYnY63azD7CG1HuiCC5s4ggNcaoi9UHy7PoXUaUUsDdGDTQiNSw>
    <xmx:v7HIYqI64WdGsdAuiU1FMpxz5GCSps4yEBlqFYepfw_gRQuU1YQncg>
Feedback-ID: i96f14706:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 Jul 2022 18:37:50 -0400 (EDT)
Date:   Sat, 9 Jul 2022 00:37:47 +0200
From:   Fernando Ramos <greenfoo@u92.eu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, mklein994@gmail.com
Subject: Re: [PATCH] vimdiff: make layout engine more robust against user vim
 settings
Message-ID: <YsixuwhSwTCapW5L@zacax395.localdomain>
References: <20220708181024.45839-1-greenfoo@u92.eu>
 <xmqqsfnbuzrl.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqsfnbuzrl.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/07/08 01:15PM, Junio C Hamano wrote:
>
> Interesting.  Does that mean that the end-user setting that was
> problematic with the new layout engine would have also broken the
> layout before your series?

Surprisingly enough, no. Turns out the commands used before the new layout
engine was introduced did *not* use 'split' nor 'vertical split' (which are the
commands affected by those two global settings).

Instead, it relayed on the fact that 'vim -d' always opens splits vertically and
then readjusted window positions with 'wincmd [HJKL]'.

The old way was limited in the amount of things that could be achieved and
that's why it was changed... but I completely missed those two global settings
capable of changing the behaviour of the new commands.


> > In order to fix this we can append special keyword 'letfabove' to each
> 
> Presumably "leftabove" was meant here.

You are right. Sorry.


> Will queue.  Thanks.

Thank you!
