Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75510C4338F
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 16:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 574D36103E
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 16:50:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233426AbhHLQu1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Aug 2021 12:50:27 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62029 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233425AbhHLQu1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Aug 2021 12:50:27 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6330614C964;
        Thu, 12 Aug 2021 12:50:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=I4AWB2JBi/HN1Sd55IVG/9e2+aCD3lZkKZjCr0
        4Yqxs=; b=ft9EK8cdCL7alQUV438YHS1CBnyTbl1kT/xVbXGaJar57JEfZ5zhJp
        dCngDeNPaZC88gcAbeiOIuU6kIjoyM/XUJ0IGrf577NHiTJiRkjmu4oYE9Un1YUj
        liXAHmHH6GVQJlchjpp02tMEIrmYpq0IcPKvNtyni5CVW9edal5F4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 41CDE14C963;
        Thu, 12 Aug 2021 12:50:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7817214C960;
        Thu, 12 Aug 2021 12:49:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git <git@vger.kernel.org>
Subject: Re: [PATCH 3/7] grep: typesafe versions of grep_source_init
References: <cover.1628618950.git.jonathantanmy@google.com>
        <e5e6a0dc1ef59b2ab419816e463814d93115e7f6.1628618950.git.jonathantanmy@google.com>
        <CAHd-oW4tLJf1VxWDOkzKtJCV9X_rqfWPg_yOONYo7S8O1kCjGQ@mail.gmail.com>
Date:   Thu, 12 Aug 2021 09:49:56 -0700
In-Reply-To: <CAHd-oW4tLJf1VxWDOkzKtJCV9X_rqfWPg_yOONYo7S8O1kCjGQ@mail.gmail.com>
        (Matheus Tavares Bernardino's message of "Wed, 11 Aug 2021 19:45:04
        -0300")
Message-ID: <xmqqwnoq6217.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 541CE3EE-FB8D-11EB-A6A3-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matheus Tavares Bernardino <matheus.bernardino@usp.br> writes:

> On Tue, Aug 10, 2021 at 3:29 PM Jonathan Tan <jonathantanmy@google.com> wrote:
>>
>> diff --git a/grep.c b/grep.c
>> index 424a39591b..ba3711dc56 100644
>> --- a/grep.c
>> +++ b/grep.c
>> @@ -1830,7 +1830,7 @@ int grep_buffer(struct grep_opt *opt, char *buf, unsigned long size)
>>         struct grep_source gs;
>>         int r;
>>
>> -       grep_source_init(&gs, GREP_SOURCE_BUF, NULL, NULL, NULL);
>> +       grep_source_init_buf(&gs);
>>         gs.buf = buf;
>>         gs.size = size;
>
> Small nit: perhaps `grep_source_init_buf()` could take `buf` and
> `size` too, so that all the fields get initialized by the same
> function.

Sounds sensible.  Thanks.
