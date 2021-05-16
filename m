Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF794C433ED
	for <git@archiver.kernel.org>; Sun, 16 May 2021 03:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9821E611BE
	for <git@archiver.kernel.org>; Sun, 16 May 2021 03:48:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232426AbhEPDtz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 May 2021 23:49:55 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57626 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232288AbhEPDty (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 May 2021 23:49:54 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0F9EBB8461;
        Sat, 15 May 2021 23:48:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Q/ej7hp+Q719
        Y169iirHI9EyQxtD+ckfxkSu/9mpvpc=; b=jMHjI3oV92DuwBcEsnv+xzUoLTCC
        tScDdKIJsW5xeMGwyu/nsr/c64TEF2+QpwLoNHAt8EU2R+Yl4Vl0jwoEGBxqrYgU
        syintMd0/tg+5XbFDC6Htdzz5ermztvZ+QcaTfHOtqWBjnFhTJx4kMRDALSyTCrm
        XC9rzTQhYrtfni8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 07090B8460;
        Sat, 15 May 2021 23:48:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6A485B845F;
        Sat, 15 May 2021 23:48:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] tr2: log parent process name
References: <20210507002908.1495061-1-emilyshaffer@google.com>
        <87im3qu4gy.fsf@evledraar.gmail.com> <YJ70g0Nd1W1f6BIx@google.com>
Date:   Sun, 16 May 2021 12:48:37 +0900
In-Reply-To: <YJ70g0Nd1W1f6BIx@google.com> (Emily Shaffer's message of "Fri,
        14 May 2021 15:06:59 -0700")
Message-ID: <xmqqo8db72zu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 9911CE30-B5F9-11EB-84D0-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> On Mon, May 10, 2021 at 02:29:15PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:
>
>> We already have the nest-level as part of the SID, so isn't it
>> sufficient (and portable) at the top-level to log what isatty says + s=
et
>> the initial SID "root" in the IDE (which presumably knows about git).
>
> If you already know all the IDEs and scripts which invoke Git, sure, yo=
u
> could set the SID root - we do this with 'repo' tool today. But actuall=
y
> we want this because we aren't sure exactly who at Google is invoking
> Git in their tooling, how, why, etc. - this logline was supposed to hel=
p
> with that. Chicken, egg, etc.

I agreed with =C3=86ver's suggestion exectly because I failed to read the
above motivation from the patch.  If you are trying to find out who
called, then you'd need to do the "find the parent process" dance
when your parent did not give you their SID to append your ident to.

Perhaps it was obvious to the author of the patch, but it was
unclear from the point of view of readers.  Perhaps the first
paragraph of the proposed message wants a bit of rephrasing.  "we
aren't sure exactly ... how, why, etc." part of the above really
helped.

Thanks.

