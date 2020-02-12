Return-Path: <SRS0=D6Hn=4A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD52C2BA83
	for <git@archiver.kernel.org>; Wed, 12 Feb 2020 17:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B57F62082F
	for <git@archiver.kernel.org>; Wed, 12 Feb 2020 17:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ohBrg4Iw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728776AbgBLR2T (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Feb 2020 12:28:19 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57306 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727600AbgBLR2S (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Feb 2020 12:28:18 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CC43FB32C3;
        Wed, 12 Feb 2020 12:28:17 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6+jji/vYzYspCFvEOLgqQJd5NfQ=; b=ohBrg4
        IwQNqQcVKMl+zAK/Thbkqtr/3nvl7wGDqmx38NS/KYa/t4Dy+wVUfOTYPU5x5u0c
        PUIMjDBDiJ24UfHS/G4Etw9dXKaMM3MCwwddPJcUWp5f5iZFggp6LkS5Cmdj4uw7
        Ym4Ck5wfPtZ7NrYDLp34Cg6yz2Vvl5CbHtvo8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Swiay8GjEH5RqBQtV0rGmS8wA5U+WGLQ
        cTqpPBWEHey2WYtBheXzdkudMHt92J4tYM0lRDlskuVWw70+MDXm4+B+MDeCKT1I
        9xG8kMYzwe7tffEzv7MlBLdBQXkJG55XNeiBgYcU8SkyG9iE8fTcbLMO6HDYIABx
        7RR6Nx4Nz4U=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C2CF7B32C2;
        Wed, 12 Feb 2020 12:28:17 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E74D6B32BF;
        Wed, 12 Feb 2020 12:28:14 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Jeff King <peff@peff.net>, Aleksey Midenkov <midenok@gmail.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Git tedious verbosity
References: <CAHk66ftUsKU2+Uhy-a7V5QcRdO7ShcYUk28qz7WAm28wGFmPOg@mail.gmail.com>
        <CAF8BazCpFyr_tpayWVtbk7V2LAtXaVmEKTCRQbgLYg4AvmvLvQ@mail.gmail.com>
        <20200211195549.GE2127797@coredump.intra.peff.net>
        <20200211195627.GF2127797@coredump.intra.peff.net>
        <87k14se849.fsf@osv.gnss.ru>
Date:   Wed, 12 Feb 2020 09:28:11 -0800
In-Reply-To: <87k14se849.fsf@osv.gnss.ru> (Sergey Organov's message of "Wed,
        12 Feb 2020 07:34:46 +0300")
Message-ID: <xmqqblq3vhp0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0CF327AA-4DBD-11EA-A0EA-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> It says:
>
>    All advice.* variables default to true, and you can tell Git that you
>    do not need help by setting these to false:
>
> If there were an option to set that default to 'false' (advice.default
> maybe?), it'd have answered the demands of the experts, I think.
>
> -- Sergey

This was recently discussed.  A quick search in the list archive
would have found this thread, for example:

  https://lore.kernel.org/git/xmqqwoa122h1.fsf@gitster-ct.c.googlers.com/

