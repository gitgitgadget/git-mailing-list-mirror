Return-Path: <SRS0=w+PN=DX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73507C433DF
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 20:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EABF520874
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 20:02:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dDEaAHPq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391990AbgJPUCX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Oct 2020 16:02:23 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56825 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391817AbgJPUCW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Oct 2020 16:02:22 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E4044FDBBE;
        Fri, 16 Oct 2020 16:02:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NUKDcHXtG+30Vc/Uq1ZRJbiGlzo=; b=dDEaAH
        Pq6gbl05QipJSrQkIGM6dpXHBYmxN+n+NC2Ev7H4mm3LhnhpceP6l+4ySooj1AE4
        Nmw22G8aD5TbPfiir08wcxhobl2NmxUyZVspoWAHj5LGdZcCTMfpdaB/huXp7SGC
        q2B6ZjPvZiKE+9If7tAHLskKQiPcMtUMG94is=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=b0KF1G8rjAUV6SnXI3P9DsIUqeCwTktw
        N+TJYr+jQ8CCZIqDaWMMh5mwOh41LbXzdf65aoFlgmav/kbTkys3d2EJyaMvY00K
        vMRC8Wv6praaiJ5bNtDSOVWHOIGYOZ3M6DgGV/G0YCNHfVVDqswPTe/HUApCtsAV
        KL7Buy8hLqU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DCF13FDBBD;
        Fri, 16 Oct 2020 16:02:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2C5E8FDBBA;
        Fri, 16 Oct 2020 16:02:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 1/3] test-lib: allow selecting tests by
 substring/glob with --run
References: <pull.878.v2.git.git.1602616786.gitgitgadget@gmail.com>
        <pull.878.v3.git.git.1602710025.gitgitgadget@gmail.com>
        <9c8b6a1a943261635fa09bed22ae36e368686f15.1602710025.git.gitgitgadget@gmail.com>
        <2b757512-793d-a6e0-0a50-368061e122dd@gmail.com>
        <CABPp-BHkykWh8L_FYhLR1BCCpPDmc_2q+Tccg_yZ7W8ZHZ4WsA@mail.gmail.com>
Date:   Fri, 16 Oct 2020 13:02:16 -0700
In-Reply-To: <CABPp-BHkykWh8L_FYhLR1BCCpPDmc_2q+Tccg_yZ7W8ZHZ4WsA@mail.gmail.com>
        (Elijah Newren's message of "Fri, 16 Oct 2020 10:27:56 -0700")
Message-ID: <xmqqd01iaqif.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7E60C3DA-0FEA-11EB-A665-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Given that t/README explicitly shows examples of space-separated lists
> of numbers, I'm worried we're breaking long-built expectations of
> other developers by changing IFS here.  Perhaps I could instead add
> the following paragraph to t/README:

Unlike something that would affect end-users, I think it is OK to
break backward compatibility one-way.  If you suddenly forbid spaces
and force our developers to use comma and nothing else, in muscle
memory of their fingers and/or in their scripts, in a version merged
to 'master', as long as their new habit and updated scripts use
comma consistently, they work fine on 'maint', right?

If there is no such "works on both sides of the flag day" choice, it
is a different story, of course, but comma should work fine for us
in this case.

Thanks.
