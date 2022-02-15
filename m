Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FAFBC433F5
	for <git@archiver.kernel.org>; Tue, 15 Feb 2022 02:14:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233473AbiBOCOj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Feb 2022 21:14:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232846AbiBOCOh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Feb 2022 21:14:37 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2B520B
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 18:14:28 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A13E0114102;
        Mon, 14 Feb 2022 21:14:27 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=JMdKm/N3+lRipvFdAtoHfkq70
        q8jLmwS7whdZ72OSb4=; b=I00Fz23+wDNN/h9Xi1AX/Bd0/jm+VTXzFEnlYfHT7
        L/bjKTM2DqACQmEaCvFKhCRWHmbXNRbVSMB0H6sI/gPU3RL6+bS9KxTR1bWwNvR/
        7okEf0Q+onL/wnE110rvy1HJqQv1CI0uq/cEQXfhMl2DlXG0521Qcak6gjpA/YNh
        Kg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 99283114101;
        Mon, 14 Feb 2022 21:14:27 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EC921114100;
        Mon, 14 Feb 2022 21:14:26 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/5] date API: add basic API docs
References: <YZQHEiFnOdyxYX5t@coredump.intra.peff.net>
        <cover-0.5-00000000000-20220202T195651Z-avarab@gmail.com>
        <patch-4.5-aab2ae9cc72-20220202T195651Z-avarab@gmail.com>
Date:   Mon, 14 Feb 2022 18:14:25 -0800
Message-ID: <xmqqtud0zxj2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0021CFBA-8E05-11EC-B7DF-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> +/**
> + * Show the date given an initialized "struct date_mode" (usually from
> + * the DATE_MODE() macro).
> + */
>  const char *show_date(timestamp_t time, int timezone, const struct dat=
e_mode *mode);

It's a bit of wasted bytes to explain "show_date()" as "show".  In
the context of this function, the verb "show" in its name does not
mean emitting to any output stream, but return a short-lived memory
stuffed with a  date string formatted according to the date mode
that the caller needs to either immediately consume or strdup() away
if it wants to use it later, which is a lot more helpful thing to
tell to the readers.

    /**
     * Format <'time', 'timezone'> into static memory according to
     * 'mode' and return it.
     */

or something along that line?
