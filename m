Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C82C433DF
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 21:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48E63207DA
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 21:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="qh6xYhRR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgHUVy1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 17:54:27 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58003 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbgHUVy0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 17:54:26 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2E5D3871AB;
        Fri, 21 Aug 2020 17:54:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=B7pLfncfDDXC3DdI+I4MxIhiKeQ=; b=qh6xYh
        RRuLZksakudRIGkv1LsszAesFFRCvEh2sQBs0UkzDhq6Yjyo1/U8ZWcNzNlp8CIi
        Jx6so5B0Li03J5GbJ6KoPvpdTff35ZcNC27MfmLk6+LMoxk41fJvOBVd/2wLiffJ
        +3ZCgPhHMYzml05Oveq36xavHmxvLqwJZBEpQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=k9ki6sm37Nbfb8TeI075uGFhORyj35Ca
        8nkJsrSz5GlLc1IP9ttyGWKnsuZMFAryE+G95spSw6bb4zFX3cWKAdhR4+Ehfbx6
        GmSriw12hRa6W2hJ8Xgq7loBoLGZfEbvUdNkfWLlJtga4Spdfuqm+8DzjG10Zbs+
        nSkPQOI1zM8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 25F28871AA;
        Fri, 21 Aug 2020 17:54:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AC7A9871A9;
        Fri, 21 Aug 2020 17:54:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Hariom Verma via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Hariom Verma <hariom18599@gmail.com>
Subject: Re: [PATCH v3 2/4] ref-filter: 'contents:trailers' show error if `:` is missing
References: <pull.707.v2.git.1598004663.gitgitgadget@gmail.com>
        <pull.707.v3.git.1598043976.gitgitgadget@gmail.com>
        <659b9835dcd0b38ac3972eb19c08c3bf26dccc80.1598043976.git.gitgitgadget@gmail.com>
        <CAPig+cSxjRoBE9FNqBW_xSkct6F23HmVSPhta_b4YD+MJERcTA@mail.gmail.com>
Date:   Fri, 21 Aug 2020 14:54:22 -0700
In-Reply-To: <CAPig+cSxjRoBE9FNqBW_xSkct6F23HmVSPhta_b4YD+MJERcTA@mail.gmail.com>
        (Eric Sunshine's message of "Fri, 21 Aug 2020 17:13:09 -0400")
Message-ID: <xmqqk0xr7jht.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DFF85CA2-E3F8-11EA-B66B-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Fri, Aug 21, 2020 at 5:06 PM Hariom Verma via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> The 'contents' atom does not show any error if used with 'trailers'
>> atom and colon is missing before trailers arguments.
>>
>> e.g %(contents:trailersonly) works, while it shouldn't.
>>
>> It is definitely not an expected behavior.
>>
>> Let's fix this bug.
>>
>> Acked-by: Eric Sunshine <sunshine@sunshineco.com>
>
> I didn't "ack" this patch. If you think some sort of attribution with
> my name is warranted, then a "Helped-by:" would be more appropriate.

Yes, I did exactly that after moving it just above Hariom's sign-off.

>> Signed-off-by: Hariom Verma <hariom18599@gmail.com>
>> ---
>> diff --git a/ref-filter.c b/ref-filter.c
>> @@ -345,9 +345,11 @@ static int contents_atom_parser(const struct ref_format *format, struct used_ato
>> -       else if (skip_prefix(arg, "trailers", &arg)) {
>> -               skip_prefix(arg, ":", &arg);
>> -               if (trailers_atom_parser(format, atom, *arg ? arg : NULL, err))
>> +       else if (!strcmp(arg, "trailers")) {
>> +               if (trailers_atom_parser(format, atom, NULL, err))
>> +                       return -1;
>> +       } else if (skip_prefix(arg, "trailers:", &arg)) {
>> +               if (trailers_atom_parser(format, atom, arg, err))
>>                         return -1;
>
> This looks better and easier to reason about (but I may be biased in
> thinking so).
>
>> diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
>> @@ -823,6 +823,14 @@ test_expect_success '%(trailers) rejects unknown trailers arguments' '
>> +test_expect_success 'if arguments, %(contents:trailers) shows error if semicolon is missing' '
>
> This still needs a s/semicolon/colon/ (mentioned in my previous review).

Yup.  Tweaked while queueing.

Thanks always for sharp eyes.
