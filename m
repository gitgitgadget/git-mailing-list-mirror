Return-Path: <SRS0=WOg5=AS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ACBCC433E0
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 18:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29D712065F
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 18:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BkprkY2e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbgGGSM6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jul 2020 14:12:58 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59815 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728182AbgGGSM5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jul 2020 14:12:57 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E6A4AD377D;
        Tue,  7 Jul 2020 14:12:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=8k48WLQUlBVt
        s8dVmv0T6Mvy/mU=; b=BkprkY2e741J8auGumc7lrEdklB/Ln/IHAzvmMMxct25
        sufpWi+5CgOp+oWaJB6SzaFkXrKrzIiLR5yujdk2oyMia5R4gbK8VW0jJMrPVIzS
        Hu5MTr5mc86yi8BlEj5H4asPu8okjIYAUG8m4MsR44MzLq1RDyZav1qQo/N2xeU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=vDYni3
        w2urxqUKnYdf2YG1rVxT+FZPpmfNKIJKnx53O5MuUPf9yD+ee3v0KsUmyl0Kexqs
        0ZISP/nmXP4zbQr/f+8BCSSekh3X9QEN3rdW766+oEmtmYS17+VsY2M/dCGmD8uU
        rF1FHQDNWM/XQprp6oyQNV39zH5iT4IAi/W8k=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DE0D4D377B;
        Tue,  7 Jul 2020 14:12:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2CC57D3779;
        Tue,  7 Jul 2020 14:12:53 -0400 (EDT)
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
Date:   Tue, 07 Jul 2020 11:12:51 -0700
In-Reply-To: <20200707172123.GD11341@szeder.dev> ("SZEDER =?utf-8?Q?G?=
 =?utf-8?Q?=C3=A1bor=22's?= message of
        "Tue, 7 Jul 2020 19:21:23 +0200")
Message-ID: <xmqqa70b5h3w.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 799CD9CC-C07D-11EA-A3B5-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> On Tue, Jul 07, 2020 at 09:45:21AM -0700, Junio C Hamano wrote:
>> Derrick Stolee <stolee@gmail.com> writes:
>>=20
>> >> Oops, I am not sure what happened here.  There I thought were issue=
s
>> >> pointed out at least on the latter series but was I hallucinating?
>> >
>> > I believe I have resolved all the open comments in both series.
>>=20
>> OK, then I do not have to be worried.
>>=20
>> Let's merge it down before -rc0.
>
> I think it was merged to next too soon.  I haven't even done with
> reporting all the issues that were already in v2.27.0, let alone
> looking through these followup series...

Oh, so what's your preference?  Reverting all the commit-graph stuff
that is not in 2.26 may be tempting but is not practically feasible
this late in the cycle.  It sounded like Derrick was OK to leave
them in 'next', and I am fine with keeping them out of the upcoming
release.
