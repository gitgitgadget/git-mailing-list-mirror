Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E630C433F5
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 23:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B71561152
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 23:06:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343582AbhIQXHd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Sep 2021 19:07:33 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61196 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233207AbhIQXHc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Sep 2021 19:07:32 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2F0C51594E0;
        Fri, 17 Sep 2021 19:06:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=vZIr+099e+Ov
        t0w4Pn8odudiJRuhGl5SPLiVjf2pw3k=; b=L8IiES7iQqpYxjNO15B/CEToH8f6
        Pm0/N46h76X9OGbSkasfUcFwr0hw2iOdFYeaXPXT21GiRmPREGLIXQWmYFGp0bwu
        9Px8p3L4rJo0+u0mBxoKJ6v5Gjx16Iwm5XA2OoOWmisfw6HQi4QCnDXO13MbRM9d
        gmjZgtp4qOxmLRs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 288421594DF;
        Fri, 17 Sep 2021 19:06:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 73DF01594DE;
        Fri, 17 Sep 2021 19:06:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     Jeff King <peff@peff.net>, gitmailinglist.bentolor@xoxy.net,
        git@vger.kernel.org
Subject: Re: Should `@` be really a valid git tag name?
References: <0c68d628-e093-1cbd-e3bd-38a827545418@gmx.net>
        <CAPUEspjbiNtffXatzNUUFYyZKRjcqetOTVqQX+MgZf_AJq9hnA@mail.gmail.com>
        <xmqq4kaihqjj.fsf@gitster.g>
        <YUUM5VqTEtjhnfjj@coredump.intra.peff.net>
        <YUUdjNDkL7Uy5erG@carlos-mbp.lan>
Date:   Fri, 17 Sep 2021 16:06:05 -0700
In-Reply-To: <YUUdjNDkL7Uy5erG@carlos-mbp.lan> ("Carlo Marcelo Arenas
 =?utf-8?Q?Bel=C3=B3n=22's?=
        message of "Fri, 17 Sep 2021 15:58:20 -0700")
Message-ID: <xmqqr1dmg5uq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D68C8A2E-180B-11EC-BA60-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com> writes:

> I was leaning towards something like that plus a Documentation update, =
but
> noticed that the current behaviour was inconsistent, and the confusion
> pointed out by Junio seems to indicate it is better if fully restricted=
.

That is a bad move, as existing repositories may have a ref with
such a name.

If we tighten anything retroactively, we probably should forgid '@'
short-hand that stands for HEAD, I would think.
