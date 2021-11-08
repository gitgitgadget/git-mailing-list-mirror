Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F8C7C433EF
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 20:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E6D1619EE
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 20:36:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235180AbhKHUjE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Nov 2021 15:39:04 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:37317 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229832AbhKHUjA (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 8 Nov 2021 15:39:00 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 764693201DEC;
        Mon,  8 Nov 2021 15:36:14 -0500 (EST)
Received: from imap44 ([10.202.2.94])
  by compute3.internal (MEProxy); Mon, 08 Nov 2021 15:36:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=birktj.no; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type:content-transfer-encoding; s=fm2; bh=BXXOP
        HdKPZDC1yaDXokf3gQSNfIpcMvM2KbhZu+V77w=; b=eWZB26vuaA4kvqQ1yVX7U
        AFBhGaIkiQDcQeBvjlIrmIxTsgJjWTXssBzt9Hrpd+KVe6A36p33Z56aud8iczvO
        tWszegi+svT/whPuAPta5jGdJa7ZTfXBXMp0k/zS2vWr3Ia4XxOfWVJOkES9I4JZ
        UIlnF/onFhGNjiysmAA6p/lmYJ8jHQi3tK9tYOZpnGJtzFBl2fkGYPsNJ9nz1pK9
        DtyiVmrzKQdqKa1rSvQybsSQj6Kdk62OFm94nAkCoojvcm82yYGtgslLinEdLqex
        T2107Jo/F5WkWeTGLNedVBxA+AsyFMGiI+fjNUw5LjsOxe+YFJhriJPZmHv0VYM2
        w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=BXXOPHdKPZDC1yaDXokf3gQSNfIpcMvM2KbhZu+V7
        7w=; b=AgcNgaIr0Mk5D2w1gRAsG6yS316NwY+J63N9iKTwEukv9H7zNAzZOp65n
        YQw0Y+gcrywLm08+HKvXNdR0rHpnjWFKcb19UvXO1Tv1BSHJdFpGNll07JVTPt3J
        lL/eBAL3ZpT0yqG1LNJ1gKYnoNIU9iz/5Rx+OxDk3UPOs53YDUW0DP7DSQB/2Jh6
        gOmaqPjWfXdabOfBsnMRT2g5P2HMqIhGeHXw0IJuDent2b9UQqVlzVsvBCY5AASr
        eNkBNT+lmldvrzUXJdsw/fw4SkWjjWe8eDXfb7AiMMGCgXrECTeX2zrrySUdyI0h
        VC1cEFcOWvzpVsazKmysaLPX5X7bQ==
X-ME-Sender: <xms:PYqJYe025OCXcTLxImKWN5f9aP_xSYOGInTebiJqpxh09mZPulT2yw>
    <xme:PYqJYRFt9jqTsEdhko-S-aAgcZuXtjn9ilaljTL_pTZL1YSTXCj3u7tkWBAlOOEiL
    XrcyyxJsOEuFNuDcYc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddruddvgddufeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfgjfhffhffvufgtgfesth
    hqredtreerjeenucfhrhhomhepfdeuihhrkhcuvfhjvghlmhgvlhgrnhgufdcuoehgihht
    segsihhrkhhtjhdrnhhoqeenucggtffrrghtthgvrhhnpedvveehffekiefgffdvfedtte
    fffedvffelfeekgffhieefffetuefgleeiffelffenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtsegsihhrkhhtjhdrnhho
X-ME-Proxy: <xmx:PYqJYW4O9sGr6GRTgoFmhoiFl2KvlObMjbbwLmLfSbT5nyz8QCfFDg>
    <xmx:PYqJYf1kBp2GhSbw7xrOS2B9L_f3I6lIlKtex9zHCNUSXo-jQCWokA>
    <xmx:PYqJYRES9FUfmEj4m3Wpm0BfyC__91giD00j1dSY4Dt-gvRINq41qg>
    <xmx:PoqJYfMydA1j6oN26APTfC954JXxQwtCjk_-do9MwfqFE5l1kOEXyg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 6FE0AFA0AA6; Mon,  8 Nov 2021 15:36:13 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1369-gd055fb5e7c-fm-20211018.002-gd055fb5e
Mime-Version: 1.0
Message-Id: <0777e271-d5cc-45b2-97b2-7597cf75ad86@www.fastmail.com>
In-Reply-To: <xmqqsfw6tnu7.fsf@gitster.g>
References: <20211107213012.6978-1-git@birktj.no>
 <YYiXw41upJfPS7l0@nand.local> <xmqqlf1zunqe.fsf@gitster.g>
 <211108.868rxyfote.gmgdl@evledraar.gmail.com> <xmqqsfw6tnu7.fsf@gitster.g>
Date:   Mon, 08 Nov 2021 21:35:01 +0100
From:   "Birk Tjelmeland" <git@birktj.no>
To:     "Junio C Hamano" <gitster@pobox.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Cc:     "Taylor Blau" <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [PATCH] stash: show error message when lockfile is present
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I would think the "fix" should look more like this:
>
>  	read_cache_preload(NULL);
> 	if (refresh_and_write_cache(REFRESH_QUIET, 0, 0))
> - 		return -1;
> + 		return error(_("failed to refresh the index"));

This is how the other callsites of refresh_and_write_cache (the ones
outside of stash.c) solve this problem, however I agree with =C3=86var t=
hat
this error is not as useful as the one given by
LOCK_REPORT_ON_ERROR (which is why I wrote the patch this way
to begin with, although I do see that it is not exactly the most elegant
solution to the problem)

> If the change were to (1) extend the flag word to make it more uniform,
> so that it does not special case ONLY the lock-related errors

Would adding a REFRESH_REPORT_ERRORS flag which could then be
used with repo_refresh_and_write_index be a more acceptable solution?=20
Then various functions in read-cache.c could check for this flag and
output errors but not progress when it is present.

Regards,
Birk
