Return-Path: <SRS0=G1/z=CD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E270C433DF
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 22:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 060A120706
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 22:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="oDKBzq24"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgHYWBO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Aug 2020 18:01:14 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53140 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgHYWBO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Aug 2020 18:01:14 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2D54FE4F03;
        Tue, 25 Aug 2020 18:01:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wWsuz3srgKbQqlgb+WvKDJB7BSM=; b=oDKBzq
        24wBXVkVbiGeMSdo2c3Fup2Lzt86YkDd+xXZsfNTA1A2gPWhEwzjQrKMsVSmtk9D
        dv4lzPzS8Nh4hWvuHH1oW8bcFWDkCJA0JH2gPETn5mg4m/2s2HFaDSRg2olPslJE
        m/qenA+0aIiFrtKyTzZXBEB2M4xEygLLRGeyY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vGsjNz1nGc1KtumH0nnEyxVeTNXq2hrO
        7X7o+nAF1RsBrCfiytDtdW0+4k8rSeevIk5HYRwT3HAt6eYbT+ruEKWN5CzGcsd4
        XMjFM2je01IE02JClqnY+ZL4y1YdSqMPiqYWgvHQCPgT607ElwUX4cJQ7bO/7CAo
        znvcUu2b7U0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 24984E4F01;
        Tue, 25 Aug 2020 18:01:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9505CE4EFF;
        Tue, 25 Aug 2020 18:01:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        steadmon@google.com, jrnieder@gmail.com, peff@peff.net,
        congdanhqx@gmail.com, phillip.wood123@gmail.com,
        emilyshaffer@google.com, sluongng@gmail.com,
        jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 3/7] maintenance: add --scheduled option and config
References: <pull.680.git.1597857408.gitgitgadget@gmail.com>
        <pull.680.v2.git.1598380805.gitgitgadget@gmail.com>
        <c728c57d85b17035d42313260620a7de5756b0c3.1598380805.git.gitgitgadget@gmail.com>
Date:   Tue, 25 Aug 2020 15:01:06 -0700
In-Reply-To: <c728c57d85b17035d42313260620a7de5756b0c3.1598380805.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Tue, 25 Aug 2020
        18:40:00 +0000")
Message-ID: <xmqqd03ez8pp.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7B91209A-E71E-11EA-B25D-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> A user may want to run certain maintenance tasks based on frequency, not
> conditions given in the repository. For example, the user may want to
> perform a 'prefetch' task every hour, or 'gc' task every day. To assist,
> update the 'git maintenance run --scheduled' command to check the config
> for the last run of that task and add a number of seconds. The task
> would then run only if the current time is beyond that minimum
> timestamp.
>
> Add a '--scheduled' option to 'git maintenance run' to only run tasks
> that have had enough time pass since their last run. This is done for
> each enabled task by checking if the current timestamp is at least as
> large as the sum of 'maintenance.<task>.lastRun' and
> 'maintenance.<task>.schedule' in the Git config. This second value is
> new to this commit, storing a number of seconds intended between runs.
>
> A user could then set up an hourly maintenance run with the following
> cron table:
>
>   0 * * * * git -C <repo> maintenance run --scheduled

The scheme has one obvious drawback.  An hourly crontab entry means
your maintenance.*.schedule that is finer grained than an hour
increment will not run as expected.  You'd need to take all the
schedule intervals and take their GCD to come up with the frequency
of the single crontab entry.  

Wouldn't it make more sense to have N crontab entries for N tasks
you want to run periodically, each with their own frequency
controlled by crontab?  That way, you do not need to maintain
maintenance.*.schedule configuration variables and the --scheduled
option.  It might make maintenance.*.lastrun timestamps unneeded,
which would be an added plus to simplify the system quite
drastically.  Most importantly, that would be the way crontab users
are most used to in order to schedule their periodical jobs, so it
is one less thing to learn.



