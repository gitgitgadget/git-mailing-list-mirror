Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C02CC433ED
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 23:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1F6061403
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 23:52:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234401AbhDTXwd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 19:52:33 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63057 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233992AbhDTXwc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 19:52:32 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1CE6DD185C;
        Tue, 20 Apr 2021 19:52:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=iTT+o54pvsDb
        xOj/HEI8ard4kb4=; b=s+bgmTekH97f+FN8FUQv+bnAta0pHCEsYHSUoq6iGyrf
        kvDSY34erU2/HY8SgXxEufoMylslFNKCRbihp7TS98+lmqWL4/9nMIa4aGtJwjhj
        b/KFDyVX3lXSLLLSq63uaD9BTHvsirW8kMv12KwFewLfXZnwTds+aLIPd5qcxp4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=deNivT
        7XBJcd9E3NDJWkDRArZu9UO1WTY8n9KcZzzdoPNCoL3cVbNm7RcIkrVqcAlJSPY1
        pzPj87vv5Vmk85WjgmA4ubxBza12TQyKWKnOOogcukpovXfi5Xuw2SCu5E+Gq9m+
        83ZsLkhit3QC1lvixRgHR1OlDPDHJUTDDZsxw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 11D8BD185B;
        Tue, 20 Apr 2021 19:52:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8C572D185A;
        Tue, 20 Apr 2021 19:51:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, Eric Wong <e@80x24.org>
Subject: Re: What's cooking in git.git (Apr 2021, #05; Mon, 19)
References: <xmqqtuo17t6t.fsf@gitster.g> <87mttt2hcu.fsf@evledraar.gmail.com>
Date:   Tue, 20 Apr 2021 16:51:58 -0700
In-Reply-To: <87mttt2hcu.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Tue, 20 Apr 2021 15:52:33 +0200")
Message-ID: <xmqqk0ow1plt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 65907748-A233-11EB-865F-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Tue, Apr 20 2021, Junio C Hamano wrote:
>
> Comments on my outstanding serieses and related (you've indicated that
> this summary was helpful, so I'll keep doing it).
>
>> * ab/unexpected-object-type (2021-04-14) 11 commits
>> ...
> I've just re-rolled these three at:
>
>  * https://lore.kernel.org/git/cover-00.10-0000000000-20210420T124428Z-=
avarab@gmail.com
>  * https://lore.kernel.org/git/cover-00.10-0000000000-20210420T125415Z-=
avarab@gmail.com
>  * https://lore.kernel.org/git/cover-0.8-0000000000-20210420T133218Z-av=
arab@gmail.com

Unfortunately, I didn't get to these three.  In the meantime, I'd
expect you to try merging these three into 'seen' once it gets
published today, and invite others who have topics not in 'next' but
in 'seen' to also do so.  By doing so, you'd see what interactions,
if any, are expected with the other topics in-flight.  I'd hope them
to be minimal---the old ab/unexpected-object-type had only one "yes,
that might be nice standalone if you are not working together with
other people, but we didn't have to make this change and we would
have saved having to do an evil merge to resolve this conflict if we
didn't"---as the old topic is tenatively ejected, the evil merge is
gone for now from 'seen', which is good ;-).

Anyway, without these three, but with the few topics that depends on
updated test-lib-updates topioc, the integration of the topics in
'seen' for today's cycle has been smooth.  The test-lib-updates
still had the same few niggles in its early parts I pointed out in
an earlier round, though.  Among the topics from you, I'd think that
one would be the highest priority, simply because many other topics
are taken hostage to it.  It matters to me a lot, as I'd be the one
who ends up having to remember what depends on what else, and having
to rebase them on top of each other.  The sooner that topic solidifies,
the better for other topics that depend on it.

Thanks.


