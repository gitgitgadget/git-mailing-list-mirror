Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7605FC433EF
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 16:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376681AbiBDQ4r (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Feb 2022 11:56:47 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61025 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233699AbiBDQ4q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Feb 2022 11:56:46 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D445E172B56;
        Fri,  4 Feb 2022 11:56:46 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=rKHjNrEbjJst
        OPuOyfN60+/CQjuHTYhrOn0BtfnYsoI=; b=DhYFsE8FaO94L1ZuY2v3u2jMh9lM
        9GJdKjckG6rLXjn0sShSiK2gC7A9q+OR0bgumphK7F23ASp7W1w/Gcg+xeOpDKa3
        ktG0jpWrLc5k4R6sX0WRt49GufiVMstsHix99sstvaEiOvnLs1yaXlIdLTIuiRmm
        TcroUFNGHbDVbms=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CC982172B55;
        Fri,  4 Feb 2022 11:56:46 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 315DB172B54;
        Fri,  4 Feb 2022 11:56:43 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Subject: Re: ja/i18n-common-messages
References: <xmqqr18jnr2t.fsf@gitster.g>
        <220204.86iltu3jbm.gmgdl@evledraar.gmail.com>
Date:   Fri, 04 Feb 2022 08:56:42 -0800
In-Reply-To: <220204.86iltu3jbm.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 04 Feb 2022 13:29:11 +0100")
Message-ID: <xmqq5ypuo9it.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6E0AC9DC-85DB-11EC-BC66-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Thu, Feb 03 2022, Junio C Hamano wrote:
>
>> * ja/i18n-common-messages (2022-01-31) 5 commits
>>  - i18n: fix some misformated placeholders in command synopsis
>>  - i18n: remove from i18n strings that do not hold translatable parts
>>  - i18n: factorize "invalid value" messages
>>  - SQUASH???
>>  - i18n: factorize more 'incompatible options' messages
>>
>>  Unify more messages to help l10n.
>>
>>  Will merge to 'next' after squashing the fix-up in.
>>  source: <pull.1123.v4.git.1643666870.gitgitgadget@gmail.com>
>
> I had a comment on the API direction in parse-options.c, which I think
> should be done differently, but I also think it would be fine to just
> change it up later:
>
> https://lore.kernel.org/git/220201.86a6fa9tmr.gmgdl@evledraar.gmail.com=
/
>
> I replied to v2 instead of v4 due to some (now fixed) mail delays at th=
e
> time, but that comment still applies to the latest version.

I do not think the change at the parse-options level would mix well
with what this topic wants to do.  Large parts of the code this
series touches will have to be rewritten once again.

It will open us to new complaints we would not hear with this series
from users who first say "git cmd -a -b -c", get stopped with "a and
b are incompatible", then say "git cmd -a -c", get stopped again
with "a and c are incompatible", and utter "well you could have told
me upfront that these three are not to be used together" in
frustration.

I do not mind waiting for a few days to see what Jean-No=C3=ABl would
say, but my take on this is that between starting from the current
code base and from the state after applying this series, there will
not be much difference in amount of the effort necessary to extend
CMDMODE to mark and detect combinations of incompatible options at
parse-options level. So I am inclined to merge this series down.


