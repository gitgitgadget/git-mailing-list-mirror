Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F15C433EF
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 21:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EBD760D42
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 21:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347331AbhIXVXM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 17:23:12 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56932 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233640AbhIXVXL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 17:23:11 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 39650167CFE;
        Fri, 24 Sep 2021 17:21:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Fs+4yHPGjmxB
        r0BURLnUQk8QxQkATm3wiWJAW1HAvSw=; b=PDpR31tH4q5P8AuO32vD2/+RfYCi
        +VSbQBQJ+qVUALFUoiZZ4Go0p0eCXnQg53f7hQE330WF1v4BIssKNhP8NYytT3Vn
        BNqHOgVhs1bU1R15newjmifl7NJkl3kF7jGvPDjYhRZL/zDls57/JyWVsVTi6W1k
        tZycaVGLrusVrSE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 32A64167CFD;
        Fri, 24 Sep 2021 17:21:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 95F3A167CFC;
        Fri, 24 Sep 2021 17:21:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org,
        Ignacy Gawedzki <ignacy.gawedzki@green-communications.fr>
Subject: Re: [PATCH 1/3] show-ref: remove unused custom handling of -h
References: <20210924141920.ezfpyf4uutob2h5z@zenon.in.qult.net>
        <cover-0.3-00000000000-20210924T164820Z-avarab@gmail.com>
        <patch-1.3-c79a3907a27-20210924T164820Z-avarab@gmail.com>
        <xmqq8rzlu697.fsf@gitster.g>
        <b0b1c64d-9b53-a64f-73db-b8552c7b66a2@web.de>
Date:   Fri, 24 Sep 2021 14:21:34 -0700
In-Reply-To: <b0b1c64d-9b53-a64f-73db-b8552c7b66a2@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Fri, 24 Sep 2021 22:53:56 +0200")
Message-ID: <xmqqfsttsm8x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 65B7BEF0-1D7D-11EC-9D59-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Am 24.09.21 um 21:24 schrieb Junio C Hamano:
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>>
>>> Since b92891f9783 (parseopt: add PARSE_OPT_NO_INTERNAL_HELP,
>>> 2009-03-08) parse_options() has handled "-h" unless told not to, so
>>> when show-ref was migrated to parse_options() in
>>> 69932bc6117 (show-ref: migrate to parse-options, 2009-06-20) the
>>> custom "-h" handling that was retained did nothing.
>>>
>>> The option was then hidden in e62b3935056 (Show usage string for 'git
>>> show-ref -h', 2009-11-09), but that OPT_BOOLEAN didn't do
>>> anything. Let's just remove this dead code.
>>>
>>> Reported-by: Ignacy Gawedzki <ignacy.gawedzki@green-communications.fr=
>
>>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.c=
om>
>>> ---
>>>  builtin/show-ref.c | 2 --
>>>  1 file changed, 2 deletions(-)
>>
>> While this is a fine no-op, I am not sure this "fixes" complaint
>> in Ignacy's report.  "git show-ref -h" would (and should) show the
>> short-help, no?
>>
>
> It would, but -h is not a no-op without this patch.  The option is
> equivalent to --heads as long as it's not the only argument.  E.g. it
> has an effect in "git show-ref -h HEA." or "git show-ref -hh".

Ah, so this actively breaks the command?  Yeah, thanks---I smelled
something fishy in the change.

