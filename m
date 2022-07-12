Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1138FC433EF
	for <git@archiver.kernel.org>; Tue, 12 Jul 2022 05:56:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbiGLF4a (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jul 2022 01:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiGLF43 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jul 2022 01:56:29 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8553134F
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 22:56:28 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 02D5C32006F2;
        Tue, 12 Jul 2022 01:56:25 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 12 Jul 2022 01:56:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=u92.eu; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1657605385; x=1657691785; bh=BjVKsvp6Rt
        wMb9gBQNy/rXpcdf5a2O3LCbbL+y3Ommw=; b=GKZ8zOzkh12IP8jb8b6QB4bxCS
        ocvnXH95mbmYQbEhf059oikDuj1qHQ0w2xqyu8zjMw0s8nciSoeN0E/tPtPw6rWz
        MoubtKjTOOPMvoyC615dV4bR1+ee9hnA5KU117OPQquVTgd421ctUe2GiK9YySXN
        kKnBeibPpS4hzVPK6F2S4HyNeJzVhJFGUC+L9nHErFEm7s6F+fVJQIewNZDqmAo9
        CiniuEe0fYr/ywlkQXMfndTQv2wJJ6PGh4/UdbSWyEGfuEKMW/Q3Rapcz5Zb977t
        qOnEdsLIOeNSYN3R0gT7yW+yPu7eTPTRcFzAHGXJdW7jYUfJSV5wEJCNTREw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1657605385; x=1657691785; bh=BjVKsvp6RtwMb9gBQNy/rXpcdf5a
        2O3LCbbL+y3Ommw=; b=n0H47tHbMf3h7cdrpBnpin+CR7nUkh+YOBIUK/jUw0V0
        vQH5gDCsvhYJkSdbdKU3hqeduV4iojVvteJJQLSU0AaVtN4LT0JQDANv3uEwJwm8
        pps+9oruGsfv558vFtnHxNJPWI8K7tjQ5afcSMWbWZrw3kjhYuC7PjanPj83uoOl
        ulsweFXj18aHdJFhPitBv7jAGMsPVjz84IMiM7rmnHPTtZjljZ5oIZjUXvMxrQRq
        vW2/AsLljMg5pVx0FdcCUbSZZxA+MFXzB2tU8kIW6TyuZ/I/7SBtp5JWib6DT21z
        v/mxArpEU0r7zcGquZVbh9aptj0704HereiWfgJq2g==
X-ME-Sender: <xms:CQ3NYjezFGOoG0DhtzgPm6cFiLHBVkPlluLB25ylq6IAsJHOnQYi_w>
    <xme:CQ3NYpPUffm2HUyFdrLu3qLClbl3J9HndCRuUZkBXWSTG5EHWbEK178d5BoAkFluJ
    i05rpBNzLTFV_329w>
X-ME-Received: <xmr:CQ3NYsjsc7Dv4BC5lbI1XkcOsc89GH9g1XFSKPQr4b6lR4af2uQg46OXNBS6XfURpvk1PqULkoo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudejgedguddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttdejnecuhfhrohhmpefhvghr
    nhgrnhguohcutfgrmhhoshcuoehgrhgvvghnfhhoohesuhelvddrvghuqeenucggtffrrg
    htthgvrhhnpeffheevteefjeevieekheeujeeivefguedvieefleeuiefgtddtleelheev
    ledvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgrhgvvghnfhhoohesuhelvddrvghu
X-ME-Proxy: <xmx:CQ3NYk_tWkWiAkSmoUvGGtqG3PpmdT28NkVaF_c11RCi2l1ntcbu7w>
    <xmx:CQ3NYvvIA7xG93Cpo0O6_uuA_XnhVzmDyWMP1h1bkKpjIXRZgQ26iA>
    <xmx:CQ3NYjGxeOZam1LgWNl1j9ddb6bdq58RSJvAXMM6e0FuoIpzPBKhww>
    <xmx:CQ3NYt3aNlgF8HuFLCbIQdfMqXKoIn1DW0XfUIP4iYx8KMUrgWhVFA>
Feedback-ID: i96f14706:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Jul 2022 01:56:24 -0400 (EDT)
Date:   Tue, 12 Jul 2022 07:56:21 +0200
From:   Fernando Ramos <greenfoo@u92.eu>
To:     Andrew Oates <andrew@andrewoates.com>
Cc:     git@vger.kernel.org
Subject: Re: vimdiff mergetool diff mode detection in vimrc broken by commit
 0041797449
Message-ID: <Ys0NBXe76q6Ls6OI@zacax395.localdomain>
References: <CAAVLcG42wom6Rf=6YZoc+iUnXDxshBfGOjqQPryGkzXxRxb-hA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAAVLcG42wom6Rf=6YZoc+iUnXDxshBfGOjqQPryGkzXxRxb-hA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I check &diff in my vimrc to set various settings specifically when doing a
> diff/merge.

Hi Andrew, could using an auto command on the "DiffUpdated" event work for you?

Example: add this to .vimrc:

    au DiffUpdated * if &diff | colorscheme darkblue | endif

This function will be executed every time "diff mode" is updated in any way and
seems to work both when running vimdiff directly and when entering diff mode
interactively (as it is the case now when running "git mergetool").

It has the added benefit that you can also use this same "trick" to toggle the
settings off when *exiting* diff mode:

    au DiffUpdated * if !&diff | colorscheme desert | endif

Let me know if this is enough for your use case.

Thanks!

