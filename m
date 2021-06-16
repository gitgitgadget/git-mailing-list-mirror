Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C1A4C48BE5
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 00:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34B7E61107
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 00:40:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbhFPAmq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 20:42:46 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64888 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231779AbhFPAmq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 20:42:46 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3847DCF987;
        Tue, 15 Jun 2021 20:40:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=LjYtFc1sPyws
        vlbVEvcbMz9eNe5qmLriVYHrtzaxFpE=; b=qrHFtciDcmpk1+jJlXaanxYuR9dM
        O0G+WBOW7WEb63pcCUDwJsBZXDulOujdQKi5X5kJFxBixmV9Jd5W/4Hboku6c0pg
        mucsIgU2xPOHOsLXzlDv95YapjVu67tmnGwB1HDvgzPSl+j/llXF5UOKrl7AbDma
        zEwrP/1NKe1R4OE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2953ECF983;
        Tue, 15 Jun 2021 20:40:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A464ECF982;
        Tue, 15 Jun 2021 20:40:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
        Luke Shumaker <lukeshu@lukeshu.com>
Subject: Re: [PATCH 0/2] extra: new concept of extra components
References: <20210614043450.1047571-1-felipe.contreras@gmail.com>
        <87tum0zfub.fsf@evledraar.gmail.com>
Date:   Wed, 16 Jun 2021 09:40:38 +0900
In-Reply-To: <87tum0zfub.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Mon, 14 Jun 2021 16:18:30 +0200")
Message-ID: <xmqqim2evdyx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7936522A-CE3B-11EB-8A29-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Sun, Jun 13 2021, Felipe Contreras wrote:
>
>> This patch series introduces the concept of extra components. These ar=
e
>> components which are not yet part of the core but are good enough for
>> distributions to ship, and in fact, they already do.
>
> I like this direction.

I do not mind change, but it is fuzzy to me what direction you are
in favor of.  Is the gist of the idea to split what is in contrib/
into two bins, ones that are closer to "official" and others?  If
so, I see sort-of merit in such a distinction, but whom is this
trying to help?

Distros would rather see what they use unmoved, and would not care
where those that they do not use move to, I would imagine.  So I
suspect that it would help them more if we kept the ones that are
closer to "official" in contrib/ and moved the rest to a new
hierarchy?

> I have a CI failure in one series of mine that seems to be a lack of
> updating to CMake in contrib/buildsystems, perhaps we should be adding
> that to extra/ too, i.e. extending this to the "make test" run by CI?
>
> Not something that should hinder or necessarily be included in this
> series, just a note about a related component.

I think that is more or less independent.  contrib/buildsystems (or
anything else that currently do not have test coverage) can be
taught to CI before or after sifting what is contrib/ into two
classes.  If the usable and testable ones stay in contrib/ instead
of getting moved, such a task can go in parallel.  We declare the
split, interested parties work on adding the part they are interested
in to the test framework, and the parts that are not updated to be
tested will be dropped to a "less than contrib" status.

So, in short, I like the general idea of sifting the contrib/
material into two bins, but I may not agree with (1) the execution
of these patches, or (2) the higher level goal of what such a split
wants to achieve (i.e. "whom are we helping?" question).

Thanks.

