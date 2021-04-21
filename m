Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8204AC433ED
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 02:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BB7F6140D
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 02:09:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234616AbhDUCKA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 22:10:00 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52408 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233824AbhDUCKA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 22:10:00 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6B16BD2401;
        Tue, 20 Apr 2021 22:09:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=XjLtAoItaiov
        XN1reQ8rRLWsJ+A=; b=bXbQ9ctkf3/KyooGmI8vcveec6tqc/+PL9y/GFn3DYpT
        +yoEBoC45BA93+pBkWqNZF4y9dZGPifZ8+h9z2Br93x9E82OYD/ktxMi0YV/jD7X
        HhUS8+fzDp7aIl7dTZdL6LfrDXGRh5hb+SZ7fUrgrQFEyanvOHbLjg49v2pCDrQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=KthCRS
        ylZcHxVS7BTKjQjPO5SsvJUSqpBrg4UHGcAx52sgxO6e/pqp5vcvB8LPcUyNLhjv
        AP3asflUwKzf/GAmXQW4LVok1gE5O5xfbUsFFAPiZOnskzLbHL63+/edLgw/iX5W
        v8FTQm0+OaDwl6AagH0UU50MBo/9/nrLlyR38=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 53A35D2400;
        Tue, 20 Apr 2021 22:09:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C21A0D23FF;
        Tue, 20 Apr 2021 22:09:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] mailinfo: strip CR from base64/quoted-printable email
References: <20210421013404.17383-1-congdanhqx@gmail.com>
Date:   Tue, 20 Apr 2021 19:09:25 -0700
In-Reply-To: <20210421013404.17383-1-congdanhqx@gmail.com> (=?utf-8?B?IsSQ?=
 =?utf-8?B?b8OgbiBUcuG6p24gQ8O0bmc=?=
        Danh"'s message of "Wed, 21 Apr 2021 08:34:04 +0700")
Message-ID: <xmqqy2dcz8ve.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 994A85F2-A246-11EB-957B-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> writes=
:

> When an SMTP server receives an 8-bit email message, possibly with only
> LF as line ending, some of those servers decide to change said LF to
> CRLF.
>
> Some other SMTP servers, when receives an 8-bit email message, decide t=
o
> encoding such message in base64 and/or quoted-printable instead.

encoding -> encode

>
> If an email is transfered through those 2 email servers in order, the
> final recipients will receive an email contains a patch mungled with
> CRLF encoded inside another encoding. Thus, such CR couldn't be dropped
> by mailsplit. Such accidents have been observed in the wild [1].
>
> Let's guess if such CR was added automatically and strip them in
> mailinfo.
>
> [1]: https://nmbug.notmuchmail.org/nmweb/show/m2lf9ejegj.fsf%40guru.gur=
u-group.fi
>
> Signed-off-by: =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh <congdanhqx@g=
mail.com>
> ---
>
>  I'm not sure if guessing the heuristic to strip CR is a good approach.
>  I think it's better to pass --keep-cr down from git-am.
>  Let's say --keep-cr=3D<yes|no|auto>

It matches my instinct to tie this with the existing --keep-cr
option, even though I admit that I haven't thought things through.

.
