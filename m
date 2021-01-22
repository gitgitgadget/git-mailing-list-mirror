Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 227F0C433E0
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 02:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4900230FC
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 02:27:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbhAVC1M (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jan 2021 21:27:12 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64527 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbhAVC1L (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jan 2021 21:27:11 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 87FD910AF30;
        Thu, 21 Jan 2021 21:26:26 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SzLY69XuIVx6BKKNEf4/urHPTbc=; b=Ex7izL
        BIGyP0+aj2ozVyjp05elZWcVve/zmsXHvFldIZpquIWC1WukMYPqWGZasHGweNpo
        gFRcg68G1jAR4rOiMRiDmFDf32wOd8IkBuANrihhy5x25VUx0JZyKz7xNym/vJRx
        wVQ7Ko12VD2/uC5+9+E/rv1A3LNdJ1j6M5QpQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ReG4BH9gyNNrtpvbrGFG04L+wq18p9PB
        QtezHKnz26rG0pnqTmCEKHq1/Kogh8Vx1L3iWPemFsy6wNCSQ3xqbbhsrLLOSTA2
        QBtHpbMbwz0M/FdIYwYVgb6W39GNYp/rd6IHlhUAaSLmyLCAOJoqiWQH6L5uhhX6
        7jgyM0qlux8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8009610AF2F;
        Thu, 21 Jan 2021 21:26:26 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C9F4410AF2E;
        Thu, 21 Jan 2021 21:26:23 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Seth House <seth@eseth.com>
Cc:     David Aguilar <davvid@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: automerge implementation ideas for Windows
References: <X/onP6vFAHH8SUBo@camp.crustytoothpaste.net>
        <20210109224236.50363-1-davvid@gmail.com>
        <20210109225400.GA156779@ellen>
        <xmqqmtxhd1zx.fsf@gitster.c.googlers.com>
        <xmqqa6thcn1n.fsf_-_@gitster.c.googlers.com>
        <20210110072902.GA247325@ellen>
        <xmqqh7np9gqn.fsf@gitster.c.googlers.com>
        <20210116042454.GA4913@ellen> <20210120232447.GA35105@ellen>
        <xmqqk0s5c3bv.fsf@gitster.c.googlers.com>
        <20210122010902.GA48178@ellen>
Date:   Thu, 21 Jan 2021 18:26:22 -0800
In-Reply-To: <20210122010902.GA48178@ellen> (Seth House's message of "Thu, 21
        Jan 2021 18:09:02 -0700")
Message-ID: <xmqqh7n9aer5.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 38B8F2BA-5C59-11EB-B5FB-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Seth House <seth@eseth.com> writes:

> On Thu, Jan 21, 2021 at 02:50:12PM -0800, Junio C Hamano wrote:
>> I'd rather not to see us do "text processing" in shell
>
> Agreed. What are your thoughts on the #2 approach?
>
> I noticed the comment in `git/xdiff-interface.h` about xdiff's gigabyte
> limit so I created a 973 MB text file with a conflict and ran #2 through
> a few mergetools to see how it went. I put /usr/bin/time in front of the
> two `git merge-file` invocations. I know one person's machine is not
> a benchmark but perhaps it's a discussion point?
>
> Each `git merge-file` call took ~11 seconds on my middle-tier laptop and
> did not use enough RAM to hit swap.
>
> Writing the near-gigabyte LOCAL, BASE, REMOTE, & BACKUP files went
> pretty quick. The mergetools themselves had mixed results:
>
> - vimdiff took several minutes (and a lot of swap) to open all four
>   files but did eventually work.
> - tkdiff crashed.
> - Meld spun for ~10 minutes and never opened.
>
> My takeaway: when trying to use a mergetool on a very large file, the
> two `git merge-file` invocations are not likely to be where the
> performance concern is. #2 is my preferred approach so far.

Yeah, I am no expert about Windows, but at least I know how well
"git merge-file" should work _anywhere_ (as opposed to "read -r"
plus shell loop that I would not trust on a platform where even
basic things like "sed" behaves differently from what we expect
X-<), so from that point of view, it is vastly more preferrable,
if the choices were only between #1 and #2.
