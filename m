Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E34C04FF3
	for <git@archiver.kernel.org>; Fri, 21 May 2021 23:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA9E0613F5
	for <git@archiver.kernel.org>; Fri, 21 May 2021 23:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbhEUXYN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 May 2021 19:24:13 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58917 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhEUXYM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 May 2021 19:24:12 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 46F95C9D68;
        Fri, 21 May 2021 19:22:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KTdswwt7S8neydEgJO1JqUOq2H3A6CtGl/k3Jx
        ReEPU=; b=ChWTszi1ShggRbH1cnyREOPCfmNh1pb2CQgWM0Qd0Edp/cyJAGRsYl
        Pq1WdDm1QP2YVcUI69ff70ue55H4N9LsEvi27e1/naLeXJtqPfZjcPT27WlofEix
        SoUnqnZgVXd6nBVJeTEykSITV2jhIGweA18N08FILNyWwndgRklr8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3D81AC9D67;
        Fri, 21 May 2021 19:22:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B2B39C9D66;
        Fri, 21 May 2021 19:22:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v2] tr2: log parent process name
References: <20210520210546.4129620-1-emilyshaffer@google.com>
        <xmqqpmxksuqa.fsf@gitster.g> <YKgDxahhwK/zYznH@google.com>
Date:   Sat, 22 May 2021 08:22:46 +0900
In-Reply-To: <YKgDxahhwK/zYznH@google.com> (Emily Shaffer's message of "Fri,
        21 May 2021 12:02:29 -0700")
Message-ID: <xmqqwnrrr7sp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7430A474-BA8B-11EB-B766-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

>> > we will need to discover the name another way. However, the process ID
>> > should be sufficient regardless of platform.
>> 
>> Not a strong objection, but I wonder if seeing random integer(s) is
>> better than not having cmd_ancestry info at all.  The latter better
>> signals that the platform does not yet have the "parent process
>> name" feature, I would think.
>
> Hm, we could...

Please don't.  There is a misreading here.

You mentioned "However, the process ID should be sufficient" and I
read it as "In the worst case we can emit the process ID if we do
not know how to turn it into name", and to that I said "showing
process IDs is not all that useful as they are random integers
without extra info on processes that were running back when the log
entry was taken".  Similarly, my later "OK, we do not show pid as a
placeholder." is "Contrary to what I thought you said earlier, you
do not give raw process IDs and instead honestly say we do not have
that information by omitting the record.  I am happy to see what the
actual patch does".

Thanks.
