Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E2AC48BE5
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 00:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49BA7613B9
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 00:45:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbhFQArr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Jun 2021 20:47:47 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64643 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbhFQArr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jun 2021 20:47:47 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4F90B12C162;
        Wed, 16 Jun 2021 20:45:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Ev1JAMnj84Mk
        ZZNFIAK3NCGzLpLy1VDnp+jHe5I1SFg=; b=KJAXL34kSsjYraCSrl4/YsiwDdwk
        jkXFuvWkUyoeQEfDGfi0Z8XrssJuBh596tJvMOtYdJnwBjtLJuo2jKUx7gx37EiW
        N7EOQ7KnjaFjIovkLeKAWBd5JGjMSicZ0FyDwnAyPW4KD5NmTTtjUGsGm/7tqajF
        shU4AIn53d9uXj0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 47AF012C161;
        Wed, 16 Jun 2021 20:45:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 952EC12C160;
        Wed, 16 Jun 2021 20:45:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Bruno Albuquerque <bga@google.com>
Subject: Re: [PATCH 1/5] serve: mark has_capability() as static
References: <cover-0.5-00000000000-20210616T141332Z-avarab@gmail.com>
        <patch-1.5-4f74d7d34c4-20210616T141332Z-avarab@gmail.com>
        <CAPig+cQLRGL+jUkJi9n8_6LUpzxn-1XiCyvzCgiY38wjTi+TbQ@mail.gmail.com>
Date:   Thu, 17 Jun 2021 09:45:35 +0900
In-Reply-To: <CAPig+cQLRGL+jUkJi9n8_6LUpzxn-1XiCyvzCgiY38wjTi+TbQ@mail.gmail.com>
        (Eric Sunshine's message of "Wed, 16 Jun 2021 12:28:01 -0400")
Message-ID: <xmqqczslnwsw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5534D480-CF05-11EB-B16B-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Wed, Jun 16, 2021 at 10:16 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>> The has_capability() function introduced in ed10cb952d3 (serve:
>> introduce git-serve, 2018-03-15) has never been used anywhere except
>> serve.c, so let's mark it as static.
>>
>> It was later changed from "extern" in 554544276a6 (*.[ch]: remove
>> extern from function declarations using spatch, 2019-04-29), but we
>> could have simply marked it as "static" instead.
>>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.co=
m>
>> ---
>> diff --git a/serve.h b/serve.h
>> @@ -2,9 +2,6 @@
>>  struct strvec;
>> -int has_capability(const struct strvec *keys, const char *capability,
>> -                  const char **value);
>> -
>
> `strvec` isn't used anywhere in this header following removal of
> has_capability(), so the forward declaration could be dropped, as
> well.

Good eyes.

