Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4EC6C433EF
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 18:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9EB161078
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 18:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350161AbhIHSqy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 14:46:54 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58653 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240231AbhIHSqx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 14:46:53 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 54096166BFB;
        Wed,  8 Sep 2021 14:45:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lIITj4E+uZLPYznPT4fZ3F81Id9YRJtVNIvth8
        n1o1Y=; b=ZDs5WUlGQ4zozNd/vPMT4dGBmzGOvnN4+XmLJsFjAOo1GXfGxhog1X
        AGaTwtmOdbY6f/v+tzMTMuSw0p1QKXjDOhAV14grBlRW7ZRXkBbVYjDAHDsaEnW7
        sQxRbg9pjfp4NTJQou+qDgFDr53F/paxCW8bQT31zfd4NrGUWcoWA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4BF13166BFA;
        Wed,  8 Sep 2021 14:45:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 92CCD166BF9;
        Wed,  8 Sep 2021 14:45:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git <git@vger.kernel.org>
Subject: Re: [PATCH v3 0/8] In grep, no adding submodule ODB as alternates
References: <cover.1628618950.git.jonathantanmy@google.com>
        <cover.1629148153.git.jonathantanmy@google.com>
        <xmqq8s079al1.fsf@gitster.g>
        <CAHd-oW5VBzZ+mgzsQ65eTD70q53+-Yri=pFW7ffvt95AmC7rVQ@mail.gmail.com>
Date:   Wed, 08 Sep 2021 11:45:40 -0700
In-Reply-To: <CAHd-oW5VBzZ+mgzsQ65eTD70q53+-Yri=pFW7ffvt95AmC7rVQ@mail.gmail.com>
        (Matheus Tavares Bernardino's message of "Wed, 8 Sep 2021 12:31:51
        -0300")
Message-ID: <xmqqee9y52jv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F8476514-10D4-11EC-B411-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matheus Tavares Bernardino <matheus.bernardino@usp.br> writes:

> On Tue, Sep 7, 2021 at 9:26 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Jonathan Tan <jonathantanmy@google.com> writes:
>>
>> > Thanks for reviewing, everyone. Here are the requested changes.
>> >
>> > Jonathan Tan (8):
>> >   submodule: lazily add submodule ODBs as alternates
>> >   grep: use submodule-ODB-as-alternate lazy-addition
>> >   grep: typesafe versions of grep_source_init
>> >   grep: read submodule entry with explicit repo
>> >   grep: allocate subrepos on heap
>> >   grep: add repository to OID grep sources
>> >   submodule-config: pass repo upon blob config read
>> >   t7814: show lack of alternate ODB-adding
>>
>> I didn't see anybody comment on this round (and do not think I saw
>> anything glaringly wrong).
>>
>> Is everybody happy with this version?  I am about to mark it for
>> 'next' in the next issue of "What's cooking" report, so please
>> holler if I should wait.
>
> I think it's ready for 'next'. Jonathan addressed all my comments
> from previous rounds; I also just read the patches again and all
> looks good to me. Feel free to include my:
>
> Reviewed-by: Matheus Tavares <matheus.bernardino@usp.br>

Thanks, both.
