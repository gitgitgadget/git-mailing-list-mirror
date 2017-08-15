Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4EC9208B8
	for <e@80x24.org>; Tue, 15 Aug 2017 17:07:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751767AbdHORHW (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 13:07:22 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52294 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751482AbdHORHV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 13:07:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D6EEA97DBD;
        Tue, 15 Aug 2017 13:07:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iOsXY/uBSSiNrQNgTc1+De9ARLA=; b=RU+muJ
        bP2b65kfFiyK4cp36FIhN7hTStn+WDSKyz5GFKpp3FhjbY4CI56J1AsWm7lbpex7
        70r9NqqS1h+ON8ipe5EfVw9R81b+NKEdbxLqXfs49zFGsHPa+W4bDRrCHrNqIIOV
        ze0rYQoIMD7qklMUBUdg2mn6RlE+lk3aMyfJo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qbJhohlb0IJn7f+subQ7rQhKGpWj7dhx
        TcAAGzw9WggbgYJNKOklmI1SEPsy76+pR8+mCeb3LY/oiEjLpBcTB9brpealjkOX
        k2A29LB2FvTO47IHaCCwwXGb4f9BxX+ai9luYKjNXED8DA5AqWHNuxNjlaEvmInG
        PQOtKjepPQA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CE7B797DBC;
        Tue, 15 Aug 2017 13:07:13 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 37D6697DB9;
        Tue, 15 Aug 2017 13:07:13 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [RFC PATCH 0/3] Fixes to "diff --color-moved" MIN_BLOCK_LENGTH handling
References: <cover.1502491372.git.jonathantanmy@google.com>
        <xmqqk229y5zd.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kadqx3PcchM6h_U5U6nsMVf3wHSUHt1XpD_XWxYdoYudg@mail.gmail.com>
        <xmqqbmniuei9.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kYHW3bpexhiDnoNfyp=etBJ6nPhyLYR09+4jMpw25hR_A@mail.gmail.com>
Date:   Tue, 15 Aug 2017 10:07:11 -0700
In-Reply-To: <CAGZ79kYHW3bpexhiDnoNfyp=etBJ6nPhyLYR09+4jMpw25hR_A@mail.gmail.com>
        (Stefan Beller's message of "Mon, 14 Aug 2017 12:51:56 -0700")
Message-ID: <xmqqinhosqtc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2E95B256-81DC-11E7-AD87-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>> I see what I wrote can be misread, especially due to its lack of
>> ",instead", that I want to keep the broken one as-is, with neither
>> reroll nor fixup.  That is not what I meant.
>>
>>  - If you choose to squash so that the resulting history after the
>>    series graduates to 'master' will be simpler to read (due to lack
>>    of "oops, that was a mistake"), I do not mind a reroll.
>>
>>  - On the other hand, as the topic has been in 'next' for some time
>>    and presumably people tried it in their real daily work when
>>    needed, keeping what is queued as-is has a value---we have a
>>    fixed reference point that we can go back to to compare the code
>>    with and without the fix.
>>
>> I do not have a strong preference, but if I were asked to choose,
>> I'd choose the latter.
>
> We'll go with the latter then. Thanks!
>
> Other reasons for the latter that I want to add:

Yup, we are on the same page.  You articulated what I meant in the
"On the other hand" bullet point in a better way.

Even though we generally do not tolerate stupid mistakes and design
errors to clutter the history if they are found early in the review
process while the patches are still in flight, code that have been
"in" for extended period of time and then found it has room for
improvement is a different matter.  There is a reason why we thought
it was good enough initially, and there is a reason why we later
found it needing improvement.  Doing the latter as an incremental
fix-up is a good way to leave records for both in our history.  

And to make that kind of incremental refinement useful, it helps to
keep the history clean from an initial attempt riddled with trivial
issues that are found early in the review is also important.
