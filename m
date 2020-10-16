Return-Path: <SRS0=w+PN=DX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8FABC433DF
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 17:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D40F21527
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 17:30:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RoQHoy8v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390560AbgJPRaA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Oct 2020 13:30:00 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60410 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730241AbgJPRaA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Oct 2020 13:30:00 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 02FD88037F;
        Fri, 16 Oct 2020 13:29:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=3KXtC8Lo4fV7
        cpbQE49M2ANYrGQ=; b=RoQHoy8vmWXUkEBy+RUkpCqWUQb77hICf8DyZxQM6FC9
        UikjVJTsWVyqkXCVkX6V+aC40yZOKeGzAC86UPsAqw5p47gJTeNvatPxe1YSHmU2
        VWCC3bPBx95Vj6DoyZRKPjsnhPxSRPV4ynRwixFqwRqC70Ss2H1DokZJ/EpSijE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=gvz44G
        zZJkvUqp6VGsxbW/bnBCWSxDAL0+XbucDDGhVzC0QcLLgwj9Zv8eCHUXDf1dQfbO
        Ub0mDLxSFxMrKk7zJBJ5xnlbx0sSBU/8T8qN8De71oIDnP46eHGdK1HQFYcYU5wh
        hapzs1YSfBV0tudWzb4cgWCbko4SvN0nvskVo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EFB9D8037E;
        Fri, 16 Oct 2020 13:29:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6BECD8037C;
        Fri, 16 Oct 2020 13:29:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v5 1/8] doc: propose hooks managed by the config
References: <20201014232447.3050579-1-emilyshaffer@google.com>
        <20201014232447.3050579-2-emilyshaffer@google.com>
        <87d01jih7w.fsf@evledraar.gmail.com>
Date:   Fri, 16 Oct 2020 10:29:57 -0700
In-Reply-To: <87d01jih7w.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Thu, 15 Oct 2020 18:31:15 +0200")
Message-ID: <xmqqimbacc4q.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 36AC0992-0FD5-11EB-A451-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Thu, Oct 15 2020, Emily Shaffer wrote:
>
>> Notes:
>>     Since v4, addressed comments from Jonathan Tan about wording.
>
> I had some extensive comments on the v4 here:
> https://lore.kernel.org/git/87mu0ygzk1.fsf@evledraar.gmail.com/
>
> Your CL & this patch don't mention it. I'd be interested in
> collaborating on this depending on if/how our goals/wants align, but I'=
d
> lke to get your thoughts on that feedback first.

True.

It seems that it wasn't responded (not even a single-liner "Thanks,
I'll get to it later" or "Thanks, but the goal I am aiming is
different from yours and your experience does not translate directly
here") and I can only conclude that it somehow was overlooked?

Emily?

Side note: perhaps it is just me, but after making a review and
giving extensive comments and suggestions, it is often disorienting
to read the next round without getting any hint on which parts of
the comments were heard and which other parts were dismissed (and
why).  I think your earlier review is a kind that deserves a
separate response before the updated patchset.

Thanks.


