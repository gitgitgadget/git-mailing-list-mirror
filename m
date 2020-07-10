Return-Path: <SRS0=TxkB=AV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA2DC433E1
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 21:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91B922075D
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 21:38:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DrOMBvj9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgGJVig (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jul 2020 17:38:36 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64860 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbgGJVig (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jul 2020 17:38:36 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 872336C121;
        Fri, 10 Jul 2020 17:38:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=tHWM0HBYFziu
        9TE4JoNBTf3ROoA=; b=DrOMBvj9qJqsS5sAcQghZU5q7hlgFn87GEn48zjPtBaj
        +c0kmEGl7EdH8sOSjvZE1OI3c+7gxRUs3NXYAxgclJ02vjGZiuJYVIVfguG1csb5
        d7Rb3iwmDBqfLurPk0Pc/jKyiq7rFjkDS9yFC3fME75Bq+wvtsxSR/Zbwt9TVwg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=NMzo+p
        O0APTjpbqJXHgElOCr6egtdRM9KftWhBlaA5c1Wttf5lP9RCk8N2JKKcrxVXT7wp
        5PPntpg4V7x9fuXpHs2AuPFf+EYC9OremyugUg3vATF3f6cAi8AcANRaknDVVAQp
        w/UjwYxzix/ShnATmkDR/mDhoLfApXiKngJ94=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7E9B56C120;
        Fri, 10 Jul 2020 17:38:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 04D006C11E;
        Fri, 10 Jul 2020 17:38:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org
Subject: Re: sg/commit-graph-cleanups (was Re: What's cooking in git.git (Jul 2020, #01; Mon, 6))
References: <xmqqh7uj7tqn.fsf@gitster.c.googlers.com>
        <90cf9ac2-1ab0-1c9b-706b-6c5176ab47dd@gmail.com>
        <xmqqzh8b5pgv.fsf@gitster.c.googlers.com>
        <7ce9163b-eafe-20a8-bd8e-7042807c98f0@gmail.com>
        <xmqqimez5l5q.fsf@gitster.c.googlers.com>
        <20200707172123.GD11341@szeder.dev>
        <xmqqa70b5h3w.fsf@gitster.c.googlers.com>
        <20200710211342.GE11341@szeder.dev>
Date:   Fri, 10 Jul 2020 14:38:30 -0700
In-Reply-To: <20200710211342.GE11341@szeder.dev> ("SZEDER =?utf-8?Q?G?=
 =?utf-8?Q?=C3=A1bor=22's?= message of
        "Fri, 10 Jul 2020 23:13:42 +0200")
Message-ID: <xmqqeepjrqy1.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B35FDA90-C2F5-11EA-8E35-01D9BED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> On Tue, Jul 07, 2020 at 11:12:51AM -0700, Junio C Hamano wrote:
>> SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:
>>=20
>> > On Tue, Jul 07, 2020 at 09:45:21AM -0700, Junio C Hamano wrote:
>> >> Derrick Stolee <stolee@gmail.com> writes:
>> >>=20
>> >> >> Oops, I am not sure what happened here.  There I thought were is=
sues
>> >> >> pointed out at least on the latter series but was I hallucinatin=
g?
>> >> >
>> >> > I believe I have resolved all the open comments in both series.
>> >>=20
>> >> OK, then I do not have to be worried.
>> >>=20
>> >> Let's merge it down before -rc0.
>> >
>> > I think it was merged to next too soon.  I haven't even done with
>> > reporting all the issues that were already in v2.27.0, let alone
>> > looking through these followup series...
>>=20
>> Oh, so what's your preference?  Reverting all the commit-graph stuff
>> that is not in 2.26 may be tempting but is not practically feasible
>> this late in the cycle.  It sounded like Derrick was OK to leave
>> them in 'next', and I am fine with keeping them out of the upcoming
>> release.
>
> Yeah, I think it's sensible to leave them out from the upcoming
> release, because that would give us the possibility (and me the time)
> to go over them once more.  Glancing through it, I see that Derrick
> kept most of my commit messages as-is, but some of them contain
> forward references to later patches in my modified path Bloom filters
> series that don't make sense on their own.  There are also some
> missing tests, a missing "Reported-by: me", missing updates to the
> format specs, and even a missing(?) patch.

OK, thanks.
