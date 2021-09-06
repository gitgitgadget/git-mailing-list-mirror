Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D88F9C433EF
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 21:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A76B76108D
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 21:55:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234543AbhIFV4W (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Sep 2021 17:56:22 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57065 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbhIFV4V (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Sep 2021 17:56:21 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 590D813BEC0;
        Mon,  6 Sep 2021 17:55:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+3EIKql2R7RUT0KxGXe95kTEOlFkBvQcSjnYWt
        8Nr4M=; b=ITqI8ldvpJPZapLiIhKUwokq9PmdHQJWNGGZYEaTB5csjMGURKzqUX
        Hj/SG+6mxu1ItQA1swJeN6sEqZSHQ2PkUWDegwIw3OTzm8C8bGRLa0gHR/yS0WvN
        s5VhugIH5iEEj8aP3287CKRz37d/qT4ORXgIIDbfSYmo5r/kHWv5g=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3F57313BEBF;
        Mon,  6 Sep 2021 17:55:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7595813BEBE;
        Mon,  6 Sep 2021 17:55:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2021, #01; Thu, 2)
References: <xmqq35qmiofp.fsf@gitster.g>
        <CAFQ2z_N8pUsp3cdBpybHBD-V9_1sARCZvSxr0UkMfcwCoQfCbw@mail.gmail.com>
Date:   Mon, 06 Sep 2021 14:55:10 -0700
In-Reply-To: <CAFQ2z_N8pUsp3cdBpybHBD-V9_1sARCZvSxr0UkMfcwCoQfCbw@mail.gmail.com>
        (Han-Wen Nienhuys's message of "Mon, 6 Sep 2021 12:36:41 +0200")
Message-ID: <xmqq4kaxe5dt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1C6D4B3A-0F5D-11EC-B862-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

> On Fri, Sep 3, 2021 at 12:48 AM Junio C Hamano <gitster@pobox.com> wrote:
>> * hn/reftable (2021-08-26) 29 commits
>>  - SQUASH??? https://github.com/git/git/runs/3439941236?check_suite_focus=true#step:5:700
>>  - reftable: fixup for new base topic 3/3
>>  - reftable: fixup for new base topic 2/3
>>  - reftable: fixup for new base topic 1/3
> ..
>>  The "reftable" backend for the refs API.
>
> I posted a subset of these patches as
> https://lore.kernel.org/git/pull.1081.git.git.1630335476.gitgitgadget@gmail.com/

Thanks for a ping.  I saw it but haven't read it.

> As discussed with AEvar, it will probably speed things up if we can
> focus on getting the base library submitted without hooking it up to
> Git. This would avoid cross-interactions with other pending topics,
> and reduce the size of the more controversial topic (hooking it up to
> Git).

My worry is that a "base library" that is not hooked up to anything
that works in the system would not be properly reviewed at all.  Of
course, without review, it would speed things up, but it is unclear
if that the kind of speed we want.

Anyway, I'll eject the old topic and replace them with the latest
one soonish.

Thanks.
