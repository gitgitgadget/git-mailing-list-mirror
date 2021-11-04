Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC1BC433EF
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 17:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E60260F5A
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 17:46:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbhKDRtI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Nov 2021 13:49:08 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59410 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbhKDRtH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Nov 2021 13:49:07 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 64BFE16DC25;
        Thu,  4 Nov 2021 13:46:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=/PP1PQj0+7ex
        IynUgY5TqhGDrX7Z5lTaVF8wkaz3OiM=; b=WNMD8yd/FRgDeMSh8PnSXF8u+dWj
        1rJG2TOVs5Up+lJcCAByWBibrjbb3w0zohhLab5R6JqeNRmx/6oSDFy180af38qT
        dKkdeamhvDOf/Sq/0nIeyy4nn0QFAUszDoNqZuSZJU9EmPPlJrLGoljZpdhEcaUo
        9d6FV4Lq3ZWfNdk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5DCDB16DC24;
        Thu,  4 Nov 2021 13:46:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0DE9816DC21;
        Thu,  4 Nov 2021 13:46:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, philipoakley@iee.email,
        eschwartz@archlinux.org, Carlo Arenas <carenas@gmail.com>,
        Jeff King <peff@peff.net>, Victoria Dye <vdye@github.com>
Subject: Re: [PATCH v2] async_die_is_recursing: work around GCC v11.x issue
 on Fedora
References: <pull.1072.git.1635990465854.gitgitgadget@gmail.com>
        <pull.1072.v2.git.1635998463474.gitgitgadget@gmail.com>
        <xmqqzgqk2zsl.fsf@gitster.g>
        <211104.86v918i78r.gmgdl@evledraar.gmail.com>
        <29114bd7-1c81-7580-c8c0-88904dd013db@gmail.com>
Date:   Thu, 04 Nov 2021 10:46:24 -0700
In-Reply-To: <29114bd7-1c81-7580-c8c0-88904dd013db@gmail.com> (Derrick
        Stolee's message of "Thu, 4 Nov 2021 09:08:00 -0400")
Message-ID: <xmqqcznf3jbj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 21F5A4AE-3D97-11EC-A101-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> Having our CI go red because the 'latest' feed changed something is
> probably the best "feed" to subscribe to, since we only get notified
> if it matters.
>
> Better to have automation go red than for us to not realize our code
> doesn't work on newer platforms because our CI hasn't been updated.

I consider this a better implementation of what =C3=86ver suggested ;-)

And an incident like this is one of the reasons why I like the "CI
does not stop after seeing the first problem" behaviour.  In a short
term, people can ignore a particular known failure and ensure they
do not introduce any new ones.

Thanks.
