Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3339C43381
	for <git@archiver.kernel.org>; Sun, 14 Mar 2021 22:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFEBA64E7C
	for <git@archiver.kernel.org>; Sun, 14 Mar 2021 22:43:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbhCNWnQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Mar 2021 18:43:16 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60993 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbhCNWnJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Mar 2021 18:43:09 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 23D2EBF4B0;
        Sun, 14 Mar 2021 18:43:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KTuvRRCmz/rtrdzt0Ri2GJJzoVw=; b=MP4a3N
        QlrQa1AdeBPhncycEdKDc/d7M6W0UM6clzpGIbm5rgyk7lQdEnrgvatA6iblkmAp
        FHuYFj5fpHgg7ZChJYkNMjSe5VfHwKfgf8xJHLc3Ot+oATlFn4fCRSPcobZHoQ2P
        3W59WBR9Z8obkJMOW7BvXew5Fo348ya6FEzP8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qLzAODf/+qWW724mh1rn/a11JMgto4ny
        dSx/vOXa1rNW/OO+uLtznMKTn0W6XSZghRC9yvHi5kIvRxkizppaxMMo9uBL+1Bp
        8F73qTF9jMakUvv093VphIU+42FGPfUirHRDUPQigo9kvYTOYweqZp6rPm8gekgk
        YfpbEO4qSUg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0D601BF4AF;
        Sun, 14 Mar 2021 18:43:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 84776BF4AE;
        Sun, 14 Mar 2021 18:43:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Charvi Mendiratta <charvi077@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v4 2/6] commit: add amend suboption to --fixup to create
 amend! commit
References: <20210301084512.27170-1-charvi077@gmail.com>
        <20210310194306.32565-3-charvi077@gmail.com>
        <CAPig+cRxZFV7DDtnYOxRqEYU4PwXK8gb2HSehDyGorqdgsmoNQ@mail.gmail.com>
        <CAPSFM5c8saGs=+OvXvZw-T2jPpdUfkmm9_BZOmZwUo=WO1sdQg@mail.gmail.com>
        <CAPig+cTBXBjZkJoGFYpzWBnEOmV52dnoBHxceuoe3pu3F0BnYw@mail.gmail.com>
        <xmqqft0y4gl5.fsf@gitster.g>
        <CAPSFM5f_=+S5XbE928a-q+OmaPi0iVQXZbJnHVy=ycGwdd8tGA@mail.gmail.com>
Date:   Sun, 14 Mar 2021 15:43:07 -0700
In-Reply-To: <CAPSFM5f_=+S5XbE928a-q+OmaPi0iVQXZbJnHVy=ycGwdd8tGA@mail.gmail.com>
        (Charvi Mendiratta's message of "Sun, 14 Mar 2021 19:28:38 +0530")
Message-ID: <xmqqblbl4aro.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A5FDF376-8516-11EB-9D1B-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Charvi Mendiratta <charvi077@gmail.com> writes:

> On Sun, 14 Mar 2021 at 07:55, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Eric Sunshine <sunshine@sunshineco.com> writes:
>>
>> > The one thing that does bother me, however, is the name of the
>> > function, get_alpha_len(), which tells you (somewhat) literally what
>> > it does but doesn't convey to the reader its actual purpose (which is
>> > something we should strive for when naming functions and variables).
>>
>> I actually think the helper function that is used as a building
>> block the "subcommand parser" uses should be named more directly
>> to represent what it does (i.e. look for a run of alphas) than
>> what it means (i.e. look for a run of letters allowed in a
>> subcommand name).  IOW
>>
>>         char *end = skip_alphas(ptr);
>>         if (*end == ':' && ptr != end) {
>>                 /*
>>                  * ptr..end could be a subcommand in
>>                  * "--fixup=<subcommand>:"; see if it is a known one
>>                  */
>>                 *end = '\0';
>>                 if (!strcmp(ptr, "amend"))
>>                         ... do the amend thing ...
>>                 else if (!strcmp(ptr, "reword"))
>>                         ... do the reword thing ...
>>                 else
>>                         ... we do not know such a subcommand yet ...
>>         } else {
>>                 /* assume it is --fixup=<command> form */
>>                 ...
>>         }
>>
>> conveys more information to readers than a variant where you replace
>> "skip_alphas" with "skip_subcommand_chars" without losing any
>> information.
>>
>
> I thought to just rename get_alpha_len() to skip_alpha() that returns
> alpha length. But even removing the "len" variable and implementing as
> suggested above seems a better and clear alternative. I also agree to
> update it.
>
> Thanks for the suggestions.

FWIW I am also fine with Eric's simpler "open code it right there"
suggestion in this case.  Just like the "skip alphas" suggestion, it
makes the logic to parse subcommand name out isolated to a single
place without asking readers to refer to the implementation of a
helper, and it would be short enough.

Thanks.
