Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C13361F87F
	for <e@80x24.org>; Wed, 21 Nov 2018 00:22:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbeKUKyi (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Nov 2018 05:54:38 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60308 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbeKUKyh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Nov 2018 05:54:37 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 758E210CA54;
        Tue, 20 Nov 2018 19:22:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Jw9LiM7reYqtM+FNluoscdwcgt8=; b=u3hdTo
        cZXVesWQL7nK7R1tGzLkDkiCpAOEBp3Ogn/yTGbB0U019sqTJQjIIHuze9ATz2XS
        gy1J1jk9/9BPCSU/qnoXO+ajeiKA5XQImTrmnxrynVaXeSfbux8tf8kg62hOsCUv
        KiAg/FlWhELhbc/VhpT3pm9FIB4oWS3VC6kW0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dyIo9Y2yD+JsnyRy/pT4UuBNtnXzYfML
        LHQdFteIAJmNkEmJKWRY1qHWE52k6vlpvIUBaN3JvbBI4RH2E3kXkwF4sSAhy+39
        ccDM+x/eNH2WQXrVip7SK7HgGIV0brgYSDHMlisBkL0WuvLNWc+0Gyqta3G+fmTy
        qXQHw7diY3A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6CB1D10CA53;
        Tue, 20 Nov 2018 19:22:38 -0500 (EST)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D4DAB10CA52;
        Tue, 20 Nov 2018 19:22:37 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        pclouds@gmail.com, Ben Peart <benpeart@microsoft.com>,
        jonathantanmy@google.com
Subject: Re: [PATCH 5/5] index: offer advice for unknown index extensions
References: <20180823154053.20212-1-benpeart@microsoft.com>
        <20181010155938.20996-1-peartben@gmail.com>
        <20181113003817.GA170017@google.com>
        <20181113003938.GC170017@google.com>
        <f2f8cec8-d770-a1e9-b5a1-83653575122e@gmail.com>
        <xmqqo9asqrxu.fsf@gitster-ct.c.googlers.com>
        <20181120060920.GA144753@google.com>
        <20181120061544.GF144753@google.com>
        <87sgzwyu94.fsf@evledraar.gmail.com>
        <cabd2e37-7389-ac74-6626-629eab7da53f@gmail.com>
Date:   Wed, 21 Nov 2018 09:22:36 +0900
In-Reply-To: <cabd2e37-7389-ac74-6626-629eab7da53f@gmail.com> (Ben Peart's
        message of "Tue, 20 Nov 2018 08:30:50 -0500")
Message-ID: <xmqqefbf9t4j.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8CEE093A-ED23-11E8-94DF-063AD72159A7-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <peartben@gmail.com> writes:

>> This message should say something like "Index uses the mandatory %s
>> extension" to clarify and distinguish it from the below. We don't
>> understand the upper-case one either, but the important distinction is
>> that one is mandatory, and the other can be dropped. The two messages
>> should make this clear.
>>
>> Also, having advice() for that case is even more valuable since we have
>> a hard error at this point. So something like:
>>
>>      "This is likely due to the index having been written by a future
>>      version of Git. All-lowercase index extensions are mandatory, as
>>      opposed to optional all-uppercase ones which we'll drop with a
>>      warning if we see them".
>>
>
> I agree that we should have different messages for mandatory and
> optional extensions.  I don't think we should try and educate the end
> user on the implementation detail that git makes lower cases mandatory
> and upper case optional (ie drop the 'All-lowercase..." part).  They
> will never see the lower vs upper case difference and can't do
> anything about it anyway.

I agree that the "warn and continue" message should say "optional"
(meaning: safe to ignore but you would want to take note) while
"cannot continue" message should say something different.

I do not mind a more verbose error message when we saw unknown but
required extension, but unlike the "warn and continue" case, the
program will stop and die with such an error right there, so I am
not sure if it is worth allowing to tone it down by putting some
part of the verbosity behind the advise() mechanism.

>>>   		trace_printf("ignoring %.4s extension\n", ext);
>>> +		if (advice_unknown_index_extension) {
>>> +			warning(_("ignoring optional %.4s index extension"), ext);

So from that point of view, the distinction between this message and this one

>>>   			return error("index uses %.4s extension, which we do not understand",
>>>   				     ext);

is halfway there.  The message needs to anticipate and answer an
end-user reaction: "we do not understand" so what?

I am still puzzled by the insistence of 3/5 and this step that wants
to kill the coalmine canary.  But I am even more puzzled by the
first two steps that want to disable the two optional extensions.

What's so different this time with the new optional extensions?

The other early optional extensions like cache-tree or resolve-undo
were added unconditionally and by definition appeared much earlier
in git-core than any other Git reimplementations.  verbody who
recorded the fact that s/he resolved merge conflicts got REUC, and
we would have given warning when an older Git did not understand
these extensions [*1*].  We knudged users to more modern Git by
preparing the old Gits to warn when there are unknown extensions,
either by upgrading their Git themselves, or by bugging their
toolsmiths.  Nobody complained to propose to rip the messages like
this round.  This series has a strong smell of pushing back by the
toolsmiths who refuse to promptly upgrade to help their users, and
that is why I do not feel entirely happy with this series.


[Footnote]

 *1* A Git that did not understand TREE would have been silent, as
  it was the first extension and that was the first time we became
  aware of the need to warn unknown extensions.
