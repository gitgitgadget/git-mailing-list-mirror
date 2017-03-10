Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCE0F1FC43
	for <e@80x24.org>; Fri, 10 Mar 2017 20:40:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755449AbdCJUkK (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Mar 2017 15:40:10 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65229 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750897AbdCJUkI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2017 15:40:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 43F3469C4D;
        Fri, 10 Mar 2017 15:40:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bL4Mc+TTtuOmDs+dcmfRp62bwc8=; b=GALh4j
        YF7AHU7d/TTfTV8awyJ/Mx3WFZ9MbNc1AaZhWk1qrZ+GPxxC0Gi0e4LO5jHS4drL
        iBNrRGQAIVSGIQzXytNHy7Ql5kJOmRNzPdgLOzSQ/272+nzlpTnkXZZwFHoDSk6o
        avFaVqcwrfBUHOLLar7siL1umOZGnI4Pu8Ij8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mJYBRt5gKsocmpLKxtMU+FeaRQTwJa5u
        NQkGAd2pJsLxVWBwV5mEQEWmm4tPR0OPxY9yAVslBUZE1yCOi051PTyXCBnI9Cqx
        MTEO74SF2hVfaoarNWCKUckhsVpxVYR1NaqeE94KjRJXWIwL71BXusHp+2jpVLbO
        Cop7s980ObM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3AAC369C4B;
        Fri, 10 Mar 2017 15:40:06 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 781EE69C4A;
        Fri, 10 Mar 2017 15:40:05 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Valery Tolstov <me@vtolstov.org>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] submodule--helper.c: remove duplicate code
References: <20170309003858.GB153031@google.com>
        <20170309012734.21541-1-me@vtolstov.org>
        <20170309012734.21541-3-me@vtolstov.org>
        <20170309181837.GF153031@google.com>
        <xmqqvargyl39.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kbhG9XhRccqA555Zp-FENJ5Q6Nd+LnNTZno1J_=cGQctQ@mail.gmail.com>
Date:   Fri, 10 Mar 2017 12:40:04 -0800
In-Reply-To: <CAGZ79kbhG9XhRccqA555Zp-FENJ5Q6Nd+LnNTZno1J_=cGQctQ@mail.gmail.com>
        (Stefan Beller's message of "Fri, 10 Mar 2017 11:49:40 -0800")
Message-ID: <xmqq7f3wyifv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BE2E3EC4-05D1-11E7-A5D2-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Fri, Mar 10, 2017 at 11:42 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Brandon Williams <bmwill@google.com> writes:
>>
>>> On 03/09, Valery Tolstov wrote:
>>>> Remove code fragment from module_clone that duplicates functionality
>>>> of connect_work_tree_and_git_dir in dir.c
>>>>
>>>> Signed-off-by: Valery Tolstov <me@vtolstov.org>
>>>
>>> Looks good.
>>
>> I'll queue with your Reviewed-by: added.
>>
>> If sb/checkout-recurse-submodules is going to be rerolled, I'd
>> appreciate if it includes this patch inserted at an appropriate
>> place in the series, instead of me having to remember re-applying
>> this patch every time it happens.
>
> Instead of mixing these two series, can you just take Valerys series as is,
> and sb/checkout-recurse-submodules builds on top of that when rerolled?

That's fine by me, too, but that still means I need to keep an eye
on two independent topics that interact each other.  Is a single
patch 2/2 that important to be on a separate topic?  Expressed in
another way, is it expected that sb/checkout-recurse-submodules
would take forever to mature relative to these two patches?
