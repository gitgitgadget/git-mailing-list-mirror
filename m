Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E8DC433F5
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 11:12:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234148AbiCALNS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 06:13:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234471AbiCALNQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 06:13:16 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED641AD99
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 03:12:34 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 21C0310ECAE;
        Tue,  1 Mar 2022 06:12:33 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=eigHy1dll3y4Dd25DT0nKxqAm4YVyow7VXvlfuhus70=; b=snue
        i/+m/NGlfORd8O5+VcAzuIqX5y0FbD/qjKh69A9WEg3FE1acSHuS2uOdCqJfSf+c
        aoJ+f42dxZI00HbMra3bIY12N8bRwtHJBavfuY4snljP+bYQPIXqdQsScE7yw7wm
        DBtO1ONjnRmK1f3wTtDVzYChSwsuZRPYi1KTZjc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 165BB10ECAD;
        Tue,  1 Mar 2022 06:12:33 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3801F10ECAC;
        Tue,  1 Mar 2022 06:12:32 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] parse-options.c: add style checks for usage-strings
References: <xmqqzgma287n.fsf@gitster.g>
        <20220301063801.26732-1-chakrabortyabhradeep79@gmail.com>
Date:   Tue, 01 Mar 2022 03:12:30 -0800
Message-ID: <xmqqsfs2rko1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7D6F185A-9950-11EC-9A85-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com> writes:

>>  (2) Rethink if parse_options_check() can be made optional at
>> ...
>>  (3) While (2) is ongoing, we can let people also explore static
>>      analysis possibilities.
>
> I agree with you. But I think these two points(specially (2)) deserve
> a dedicated discussion/patch thread. Because, the latest version of this
> patch series (actually this patch series itself) only cares about the
> `usage strings`.

Yes, absolutely.  So applying [2/2] in haste is not a good idea at
all.  Before we accumulate more cruft on top, we should stop and
think if the approach we are taking is sensible to begin with, or
we'll make an already bad situation even worse.

