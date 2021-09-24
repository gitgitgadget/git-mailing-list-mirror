Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04351C433EF
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 19:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8ABD610CB
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 19:24:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346487AbhIXTZl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 15:25:41 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56568 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344513AbhIXTZk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 15:25:40 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 58A28D1397;
        Fri, 24 Sep 2021 15:24:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=t+ehtzRholRr
        cKs+Dq2SjfRUTX9Ps2skyk5j5lu1cSE=; b=vEWMvqIeGufkZWasxjxQvVxr6RqG
        TstaxwiLeSwCKUwGxAnZv7Xt46tAm275J+i7fxapg7+9SRSjWIxA0R5z4yrkvpgR
        Z9bnGxobW/mj4ujHOQ7SUWZj6ppc2MA5gmulqNKpOahlZxdxVjtLvd1v5MmPcIye
        Tsd4c3iL7abNy9o=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4EAECD1396;
        Fri, 24 Sep 2021 15:24:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A3168D1393;
        Fri, 24 Sep 2021 15:24:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Ignacy Gawedzki <ignacy.gawedzki@green-communications.fr>
Subject: Re: [PATCH 1/3] show-ref: remove unused custom handling of -h
References: <20210924141920.ezfpyf4uutob2h5z@zenon.in.qult.net>
        <cover-0.3-00000000000-20210924T164820Z-avarab@gmail.com>
        <patch-1.3-c79a3907a27-20210924T164820Z-avarab@gmail.com>
Date:   Fri, 24 Sep 2021 12:24:04 -0700
In-Reply-To: <patch-1.3-c79a3907a27-20210924T164820Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 24 Sep
 2021 18:51:44 +0200")
Message-ID: <xmqq8rzlu697.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: FB9FBEE2-1D6C-11EC-B0E7-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Since b92891f9783 (parseopt: add PARSE_OPT_NO_INTERNAL_HELP,
> 2009-03-08) parse_options() has handled "-h" unless told not to, so
> when show-ref was migrated to parse_options() in
> 69932bc6117 (show-ref: migrate to parse-options, 2009-06-20) the
> custom "-h" handling that was retained did nothing.
>
> The option was then hidden in e62b3935056 (Show usage string for 'git
> show-ref -h', 2009-11-09), but that OPT_BOOLEAN didn't do
> anything. Let's just remove this dead code.
>
> Reported-by: Ignacy Gawedzki <ignacy.gawedzki@green-communications.fr>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  builtin/show-ref.c | 2 --
>  1 file changed, 2 deletions(-)

While this is a fine no-op, I am not sure this "fixes" complaint
in Ignacy's report.  "git show-ref -h" would (and should) show the
short-help, no?

