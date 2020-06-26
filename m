Return-Path: <SRS0=gJGs=AH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 650B0C433E1
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 14:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42D0920768
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 14:45:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nefTUDDB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgFZOpt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Jun 2020 10:45:49 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56698 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727097AbgFZOpt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jun 2020 10:45:49 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 15BEB6BD39;
        Fri, 26 Jun 2020 10:45:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=lcmx1JbqZjK2
        MCYeqOS03rxao3k=; b=nefTUDDB2wI729IMPHN1cYfj80VepKLRq8HzBicdFByc
        NF9wpq8yqt0A7UgQepqzFR5LKHFn9VcpHwIHn0xjOj4eA++59gDaFZB/wasCurgl
        KxjeIjFvx4hmKknwpmCjfyc5I8fm8ifp9kAUsXyD7yrRwQHV4qaPPJxV2QiMFAw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=xAZsJ5
        ClibAtywzzVoKm9YuYfiHQYwcchzpcIC1Ezsnm59nzlGbAvfeKntIZOdMyb9yOj9
        jdG0E/idtJyo5Vfc6RlL/j2N4AUqMBAlq+5EWzhE47GdtaTp8c4fKbLfvShgvyKr
        t3IX4NGVeoFXzXuY5lLAMMdVfTcICtjg3X2Ao=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0D7AB6BD38;
        Fri, 26 Jun 2020 10:45:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7D0586BD37;
        Fri, 26 Jun 2020 10:45:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jun 2020, #05; Thu, 25)
References: <xmqq1rm24ol3.fsf@gitster.c.googlers.com>
        <20200626070807.GA84491@Carlos-MBP>
        <xmqq1rm2i8qg.fsf@gitster.c.googlers.com>
        <20200626084315.GB84491@Carlos-MBP>
Date:   Fri, 26 Jun 2020 07:45:45 -0700
In-Reply-To: <20200626084315.GB84491@Carlos-MBP> ("Carlo Marcelo Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Fri, 26 Jun 2020 01:43:15 -0700")
Message-ID: <xmqqwo3thome.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B8324912-B7BB-11EA-9749-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com> writes:

>> Hmph, Does it break if it is merged alone to 'master' without these
>> other two topics?  I somehow thought I disentangled the topic from
>> unnecessary dependencies before queuing it, but it is possible that
>> I misremember...
>
> Doesn't break and applies perfectly on its own, or in any order with
> rs/pull-leakfix, but will conflict with rs/commit-reach-leakfix with
> the obvious conflict resolution needed:

Yes, that is what I meant.  I checked if it can graduate by itself
without getting taken hostage of other topics, while ensuring that
the conflict is simple enough that once done correctly while merging
to 'next', the resolution can be reused when merging to 'master'.
Which means that, as long as the resolution you see in 'next' is
correct, what is queued is good.

Thanks for double checking.
