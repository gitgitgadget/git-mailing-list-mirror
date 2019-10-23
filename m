Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3F171F4C0
	for <e@80x24.org>; Wed, 23 Oct 2019 03:02:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387769AbfJWDCW (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Oct 2019 23:02:22 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63666 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727831AbfJWDCW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Oct 2019 23:02:22 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5AEFFAFF4D;
        Tue, 22 Oct 2019 23:02:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0OkjPzfebKx6dhkRrKzIRJ8Ismk=; b=EBEEx1
        frkxrm6cRMpvqkuacLqdeXSWw1D03WG6eSbwmVUrw70SWoMWPQsqrPMaSoKZGlJ6
        x6psyjFBtoUZhedGrnqvmAjGjr0XZwAxCZvvzLmpcRZbKehtlLJFiMRuMN5L4nUQ
        ArxT6ffL0DZkE9GAK9imJ8LkvyxhRzM7BfKVs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bliDITvjeEuEc+K7cRWYTLAChH60Yvkg
        VmanCStFw9GeVj7wNaewa/7ltV9BUB9/KXB40I1OZi+ybU9VdUblzCKreKek4mX1
        uxPkcOkCfhDAmN9vuwbQiYVP2czSNhm0nxTkCp+KVk+VJHf3cTXkjKEHSwEIYAXz
        Jv5AtA3VcDc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 52E57AFF4C;
        Tue, 22 Oct 2019 23:02:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 80380AFF4B;
        Tue, 22 Oct 2019 23:02:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/3] commit: fix advice for empty commits during rebases
References: <pull.417.git.1571787022.gitgitgadget@gmail.com>
Date:   Wed, 23 Oct 2019 12:02:15 +0900
In-Reply-To: <pull.417.git.1571787022.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Tue, 22 Oct 2019 23:30:19
        +0000")
Message-ID: <xmqqr234i2q0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 85A5C056-F541-11E9-9631-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> In dcb500dc16c (cherry-pick/revert: advise using --skip, 2019-07-02), we
> introduced a helpful message that suggests to run git cherry-pick --skip 
> (instead of the previous message that talked about git reset) when a
> cherry-pick failed due to an empty patch.
>
> However, the same message is displayed during a rebase, when the patch
> to-be-committed is empty. In this case, git reset would also have worked,
> but git cherry-pick --skip does not work. This is a regression introduced in
> this cycle.
>
> Let's be more careful here.
>
> Johannes Schindelin (3):
>   cherry-pick: add test for `--skip` advice in `git commit`
>   sequencer: export the function to get the path of `.git/rebase-merge/`
>   commit: give correct advice for empty commit during a rebase

Overall they looked nicely done.  The last one may have started its
life as "let's fix advice for empty", but no longer is.

The old code used the sequencer_in_use boolean to tell between two
states ("are we doing a single pick, or a range pick?"), but now we
have another boolean rebase_in_progress, and depending on the shape
of the if statements existing codepaths happen to have, these two
are combined in different ways to deal with new states.  E.g. some
places say

	if (rebase_in_progress && !sequencer_in_use)
		we are doing a rebase;
	else
		we are doing a cherry-pick;

and some others say

	if (sequencer_in_use)
		we are doing a multi pick;
	else if (rebase_in_progress)
		we are doing a rebase;
	else
		we are doing a single pick;

I wonder if it makes the resulting logic simpler to reason about if
these combination of two variables are rewritten to use a single
variable that enumerates three (or is it four, counting "we are
doing neither a cherry-pick or a rebase"?) possible state.

Other than that, looked sensible.  Will queue.

Thanks.
