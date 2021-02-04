Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD2BAC433E0
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 22:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 760B664FAA
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 22:43:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbhBDWn3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Feb 2021 17:43:29 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56641 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbhBDWnZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Feb 2021 17:43:25 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5B80A1240A5;
        Thu,  4 Feb 2021 17:42:43 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=g6iScX+7RO2NTogWc14DTeNT+kw=; b=UKV9Cn
        ZJ6HlgiHPGDqigU8bWOUxkvl076uc4KgoOsVUSPD/S7sSZfGW02yC5R5+wDXnC3z
        MZrp8dNMyul0IQOoTOUdACkx8o0Ln3qXFeRGmmJlC6xi+a/wT+u63dr/AQIuuem+
        UnfswXL8l2cT3G8Gv6RzISPv913ZzAttYr2pQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TrJrD4iuKOm5fBUBzilnvpVLge50ZHNH
        mYib/Lvh+gSQcZeasvjnPi0WC3PLg+azkGHpxqS1xunTmFv+XFr82OE7r/XNfevz
        CscnSTylszo1psRczqnXCPTEOwvqlHmTQQwnr5RKbdiZOksmIf6NH3OS8XiS0RyP
        vtPzBUc/Fus=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5409C1240A4;
        Thu,  4 Feb 2021 17:42:43 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9DE441240A1;
        Thu,  4 Feb 2021 17:42:40 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 3/3] range-diff(docs): explain how to specify commit
 ranges
References: <pull.841.v3.git.1611765444.gitgitgadget@gmail.com>
        <pull.841.v4.git.1612431093.gitgitgadget@gmail.com>
        <295fdc1cd32cffcef145d9dd0ac76d29580fa6de.1612431093.git.gitgitgadget@gmail.com>
        <xmqq35yb7jhn.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2102042257130.54@tvgsbejvaqbjf.bet>
Date:   Thu, 04 Feb 2021 14:42:39 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2102042257130.54@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Thu, 4 Feb 2021 22:58:21 +0100 (CET)")
Message-ID: <xmqqpn1f4fq8.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 49AA7210-673A-11EB-8F84-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> As I said before, this _is_ a symmetric range that has commits
>> reachable from rev1 but not from rev2 on the left hand side, and
>> commits reachable from rev2 but not from rev1 on the right hand
>> side, not just something else that resembles a symmetric range.
>
> If we were talking about one commit range instead of two, I would agree
> with you.

It is one symmetric commit range A...B that has two sides, i.e. B..A
on the left side and A..B on the right side.
