Return-Path: <SRS0=3/hf=DT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F5AC433DF
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 16:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91C8B206CB
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 16:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="P9oWhujY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390574AbgJLQNA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Oct 2020 12:13:00 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56359 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390043AbgJLQNA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Oct 2020 12:13:00 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 26D688BB37;
        Mon, 12 Oct 2020 12:12:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iXlp2ukgdTZyPrg4O53ApM9jKsc=; b=P9oWhu
        jY72h0wldB4JKbrGF0UzXLOfxdkm2u8mNoACZCbjsCUhJY55PGCsMEl6gwfQta9H
        95Jnex7ij+l35kHFngylRNpgHrNYruTT+Ug174rcTTmQXStZ1qZYaotHCv5OxK4k
        WjVjpf5XCczO9cdKCUB63xq6/GOUp2O0ALi8w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BVHLLslpZlFApv5mv9iGgETcTdO2GoWp
        sUQqTVWAcPEEAVk2im8clJ54EV9gqypsoyuBiFk/wMYrhr1s27NofYYRK/s5sIz+
        SEvTcA1BQCAu5TnmGXsTUhwXJk6swOugkhvg4u4Jn3t/JDfKBfgMtgvQduKb9m9V
        jxS2PoCmlDw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1E4758BB36;
        Mon, 12 Oct 2020 12:12:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 89CA08BB35;
        Mon, 12 Oct 2020 12:12:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 1/2] ci: skip GitHub workflow runs for already-tested
 commits/trees
References: <pull.619.git.1587748660308.gitgitgadget@gmail.com>
        <pull.619.v2.git.1602170976.gitgitgadget@gmail.com>
        <914868d558b1aa8ebec6e9196c5ae83a2bd566bf.1602170976.git.gitgitgadget@gmail.com>
        <20201009072922.GC24813@szeder.dev>
        <nycvar.QRO.7.76.6.2010091254180.50@tvgsbejvaqbjf.bet>
        <20201010072508.GD24813@szeder.dev>
        <nycvar.QRO.7.76.6.2010111221350.50@tvgsbejvaqbjf.bet>
Date:   Mon, 12 Oct 2020 09:12:56 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2010111221350.50@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Sun, 11 Oct 2020 12:28:33 +0200 (CEST)")
Message-ID: <xmqqy2kbqv7b.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CAC24DCC-0CA5-11EB-A964-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Also, the patch specifically adjusts the GitHub workflow itself.
> Therefore, unlike the `skip_good_tree()` function, it does not pretend to
> be generic (which `skip_good_tree()` really is not, as pointed out above).

I think skip_good_tree aspired to be a generic one, by having the
"if we are not in travis nor GitHub actions, return early" at its
very beginning.  The person who adds support to GitHub workflow
could have done one of two things.  

One is to recognise the aspiration, and restructure existing
skip_good_tree from

    skip_good_tree () {
	return if not travis and if not github actions

	bunch of code that happens to work only on travis
    }

to

    skip_good_tree () {
	if travis
	then
	    bunch of code that happens to work only on travis
	else if github actions
	    bunch of code that happens to work only with github
	fi
    }

without touching the caller.  That lets skip_good_tree to be
generic.

Another is to completely ignore that aspiration, maybe doing all
that inside the workflow script (which by definition works only with
github).

I think the latter (i.e. what the patch choose to do, which is not
to bother with the ci/*.sh scripts at all) would be cleaner in this
particular case, but then it would have made the intention more
clear if the conditional at the beginning of skip_good_tree() were
adjusted, perhaps?
