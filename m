Return-Path: <SRS0=/SyM=B5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A82EC433DF
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 19:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73A0A207DA
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 19:07:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hbsXpI5F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgHSTHi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Aug 2020 15:07:38 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54398 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726861AbgHSTHh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Aug 2020 15:07:37 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8A91685ADE;
        Wed, 19 Aug 2020 15:07:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=st/V+PVV1TTUgC0nq/M8KM90+30=; b=hbsXpI
        5FhvL7LbWqrqyXjlCGMpFLyijq56KSix4nMu/M/MxNVIr9M333MLqRgdAfhkchPo
        gxkmD1K8btXHDEuHIHT3p/Ndo4XFONBBw8x0h3WyT2aPIBtahJ+ztNSpDK45bOu/
        9JnbQvigydcqFs5+RsX4GkVUtiELvDInwMPl0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KfAFJwhQJfPSTbUdS8Nz4Gydpa1Eo1TI
        gtdwiclfgSgiZqjAs38qjAkh27Yiuk+m+LjNVK0n9wTepktJE33QxfZoUMHKbM84
        2tJNNeMybLzArDouQH4rLW3SSOQxRCvL6xJfOu7zt3EDKx4CWrRVkz8DO4yBo28d
        DLhYDZad+yE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8305F85ADD;
        Wed, 19 Aug 2020 15:07:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0948785ADC;
        Wed, 19 Aug 2020 15:07:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Hariom Verma <hariom18599@gmail.com>
Subject: Re: [PATCH 2/2] ref-filter: 'contents:trailers' show error if `:` is missing
References: <pull.707.git.1597841551.gitgitgadget@gmail.com>
        <7daf9335a501b99c29e299f72823fcb7e549e748.1597841551.git.gitgitgadget@gmail.com>
        <xmqqv9hettag.fsf@gitster.c.googlers.com>
Date:   Wed, 19 Aug 2020 12:07:30 -0700
In-Reply-To: <xmqqv9hettag.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 19 Aug 2020 10:55:03 -0700")
Message-ID: <xmqqmu2qtpxp.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3BBA17C0-E24F-11EA-8614-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: Hariom Verma <hariom18599@gmail.com>
>>
>> The 'contents' atom does not show any error if used with 'trailers'
>> atom and semicolon is missing before trailers arguments.
>>
>> e.g %(contents:trailersonly) works, while it shouldn't.
>>
>> It is definitely not an expected behavior.
>>
>> Let's fix this bug.
>>
>> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
>> Mentored-by: Heba Waly <heba.waly@gmail.com>
>> Signed-off-by: Hariom Verma <hariom18599@gmail.com>
>> ---
>
> Nice spotting.  7a5edbdb (ref-filter.c: parse trailers arguments
> with %(contents) atom, 2017-10-01) talks about being deliberate
> about the case where skip_prefix(":") does not find a colon after
> the "trailers" token, but from the message it is clear that it
> expected that the case happens only when "trailers" is at the end of
> the string.
>
> The new helper that is overly verbose and may be overkill.
>
> Shouldn't this be clear enough, equivalent and sufficient?
>
> 	else if (skip_prefix(arg, "trailers", &arg) &&
> 		 (!*arg || *arg == ':'))) {
> 		if (trailers_atom_parser(...);

Ah, no, even with "*arg++ == ':'.  This moves arg past "trailers" if
given "trailersandsomegarbage" and the next one in "else if" cascade
would look at "andsomegarbage"---which is not what we want.

>> +static int check_format_field(const char *arg, const char *field, const char **option)
>> +{
>> +	const char *opt;
>> +	if (skip_prefix(arg, field, &opt)) {
>> +		if (*opt == '\0') {
>> +			*option = NULL;
>> +			return 1;
>> +		}
>> +		else if (*opt == ':') {
>> +			*option = ++opt;
>> +			return 1;
>> +		}
>> +	}
>> +	return 0;
>> +}

And the helper does not have such a breakage.  It looks good.

Thanks.
