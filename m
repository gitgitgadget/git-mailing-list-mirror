Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2062FEB64D7
	for <git@archiver.kernel.org>; Wed, 28 Jun 2023 17:30:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbjF1Raj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jun 2023 13:30:39 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51119 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbjF1Rab (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jun 2023 13:30:31 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0108725153;
        Wed, 28 Jun 2023 13:30:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PV70RVRi2Ey6p9iWwawzOtJ1Tx0DwwqLR+CB6L
        Hk3lw=; b=uhiojlMMxLf3D2ej2cUZMWzr2xyAI7SUqipNoKVqnJbdfDRqoAjMZ6
        yeKWENp3LGkNYnhSb+d+BARTikcKAfEu7weyfsH+kzJjo4m0ehAfdNtvHqgzQnCw
        CdtoDxe5ytCivOe0hpOWhqj4sa3LBmRE0+Ry61neIT3H2FIM08Oj0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id ECA7025152;
        Wed, 28 Jun 2023 13:30:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.233.135.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0AEBA25151;
        Wed, 28 Jun 2023 13:30:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     Glen Choo <chooglen@google.com>, git@vger.kernel.org,
        nasamuffin@google.com, johnathantanmy@google.com
Subject: Re: [RFC PATCH 6/8] pager: remove pager_in_use()
References: <20230627195251.1973421-1-calvinwan@google.com>
        <20230627195251.1973421-7-calvinwan@google.com>
        <xmqq1qhwfr46.fsf@gitster.g>
        <kl6lv8f8qvhd.fsf@chooglen-macbookpro.roam.corp.google.com>
        <kl6lpm5fr19f.fsf@chooglen-macbookpro.roam.corp.google.com>
        <CAFySSZBBAatvBmfwn9vc=v2hdWX_0Q4g4txqLOwtqiFZFW7uiA@mail.gmail.com>
Date:   Wed, 28 Jun 2023 10:30:27 -0700
In-Reply-To: <CAFySSZBBAatvBmfwn9vc=v2hdWX_0Q4g4txqLOwtqiFZFW7uiA@mail.gmail.com>
        (Calvin Wan's message of "Wed, 28 Jun 2023 09:44:59 -0700")
Message-ID: <xmqqr0pvcx58.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7934094C-15D9-11EE-8E24-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

>> Glen Choo <chooglen@google.com> writes:
>>
>> >                      Could we add a is_pager/pager_in_use to that
>> > function and push the pager.h dependency upwards?
>>
>> Bleh, I meant "Could we add a new is_pager/pager_in_use parameter to
>> that function?"
>
> Refactoring the function signature to:
>
> parse_date_format(const char *format, struct date_mode *mode, int pager_in_use)
>
> as you suggested is a much better solution, thanks! I'll make that
> change in the next reroll.

Yeah, the date format "auto:" that changes behaviour between the
output medium feels a serious layering violation, but given the
constraints, it looks like the best thing to do.

Thanks.
