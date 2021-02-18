Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07116C433E0
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 23:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74D6964EC4
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 23:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbhBRXaf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Feb 2021 18:30:35 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60511 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbhBRXaf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Feb 2021 18:30:35 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 84A319B273;
        Thu, 18 Feb 2021 18:29:51 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NwMCkaXXtMOZJqN0k/qh277fe0A=; b=XJYTQm
        nEAVBmips1eOE7M/0/BAnQ5VfwFY6kaZqN5U1S1gZS8FSILVCHZmguREivldeLko
        I2P36AuJnznz5TI1O4E/zRvikix8P4dZu97MY5V3GJc5skK8UfI8n8yVlTFKqQVI
        jQ9o3i6cjYwnhepvl6Dh4i9YQpGROup7FvLNw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=n9i5ramCLenugPgYL2Gd+SGImXnnMrMG
        CUZnnykAN9jFQAooKdtGNHRNVO+uIBaewx5FhpRF46Nv7BeD+xK4xlxcRortERRn
        RxhbFtu1LWZG9hM8duFqohUwVZeHqFinIzmblInNCBnA4aGlr2+5+Zkxh4XdIvDL
        junvK4wWReE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7A51C9B272;
        Thu, 18 Feb 2021 18:29:51 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 07CE09B270;
        Thu, 18 Feb 2021 18:29:51 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] rebase: add a config option for --no-fork-point
References: <20210120044435.53509-1-alexhenrie24@gmail.com>
        <xmqqturbdxi2.fsf@gitster.c.googlers.com>
        <CAMMLpeQM7JCP0=TMqf0DxDCVJvkCGDEPSKN6vYTU_xc7+QaA1Q@mail.gmail.com>
        <xmqqo8hiaptn.fsf@gitster.c.googlers.com>
        <CAMMLpeQ5ga_e5-YeVuArYBrui+ps7HWzNjWNQgeJK3sEjo2zhA@mail.gmail.com>
        <YAoSIkCecZU98QD2@generichostname>
        <CAMMLpeTDNLUz9UVnL3aVK=J7X50Sq8L-OVGaoEsT5AY6EQON-g@mail.gmail.com>
Date:   Thu, 18 Feb 2021 15:29:50 -0800
In-Reply-To: <CAMMLpeTDNLUz9UVnL3aVK=J7X50Sq8L-OVGaoEsT5AY6EQON-g@mail.gmail.com>
        (Alex Henrie's message of "Thu, 21 Jan 2021 16:51:52 -0700")
Message-ID: <xmqq4ki9c5u9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 327DC1B6-7241-11EB-ADC0-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie <alexhenrie24@gmail.com> writes:

> On Thu, Jan 21, 2021 at 4:45 PM Denton Liu <liu.denton@gmail.com> wrote:
>>
>> On Thu, Jan 21, 2021 at 04:25:25PM -0700, Alex Henrie wrote:
>> > I didn't see any fork-point tests in the current codebase, but I can
>> > work on adding some. Do you want them in a separate patch (that would
>> > make the most sense to me), or squashed into the rebase.forkPoint
>> > patch?
>>
>> The fork-point tests should be in t3431.
>
> Derp! For some reason I thought that t3431 only tested --fork-point
> with an ambiguous refname and that the other tests were unrelated.
> Maybe we should make copies of some of those tests that set
> rebase.forkPoint instead of passing --fork-point or --no-fork-point on
> the command line.

Ping.

Any progress on this topic?  It's been almost a month without seeing
any activity.

Thanks.
