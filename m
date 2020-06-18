Return-Path: <SRS0=1Nmv=77=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 006E1C433DF
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 21:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F70B208D5
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 21:46:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="L43Ib+pF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731371AbgFRVp7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Jun 2020 17:45:59 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61184 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731336AbgFRVp7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jun 2020 17:45:59 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 151AD758DA;
        Thu, 18 Jun 2020 17:45:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=m8luw2jOXcHF9Lok93DSlibnwbQ=; b=L43Ib+
        pFgBEtGt76x1SMQYnxi36ZZE5O7m4L/vIXM+Uzw/Qx5kvKbIEF/+LBv9ufq2nPSB
        0v9j9hV+/r7FhDZvHv5AG1EWcRgrghT0n+opwFq0ga5ihg1f1BG3jAKwWWaUvVxW
        tjUPPFbdPS7ag5wvyoR0Q6KYQVlPgtm9XMvGg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GkfFnvUpHq3BX1ba9rrGGpcfamgPTq7H
        5f+GzQUO6+/GNOTqz9+Rn3pEcrr19OSCpoko6Xdsuw0XPAIg8GFDUKRJnD5AhMAR
        HfR2wkbJBeKmDmtq1nzD1rvd/ZHPi+dHZKysV7FZLHnIaaLGV9oBETo7oqcZjP1u
        QehEZtTtHyQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 072EF758D9;
        Thu, 18 Jun 2020 17:45:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 81BDA758D7;
        Thu, 18 Jun 2020 17:45:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 0/2] Sparse checkout status
References: <pull.808.git.git.1592350413.gitgitgadget@gmail.com>
        <pull.808.v2.git.git.1592513398.gitgitgadget@gmail.com>
Date:   Thu, 18 Jun 2020 14:45:55 -0700
In-Reply-To: <pull.808.v2.git.git.1592513398.gitgitgadget@gmail.com> (Elijah
        Newren via GitGitGadget's message of "Thu, 18 Jun 2020 20:49:56
        +0000")
Message-ID: <xmqqwo44kpyk.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 173BD2D0-B1AD-11EA-BDB0-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Some of the feedback of folks trying out sparse-checkouts at $dayjob is that
> sparse checkouts can sometimes be disorienting; users can forget that they
> had a sparse-checkout and then wonder where files went. This series adds
> some output to 'git status' and modifies git-prompt slightly as an attempt
> to help.
>
> Note that as per discussion on v1, we may want to later add a git
> sparse-checkout subcommand named something like 'stats' or 'info' or
> 'status' that provides more detailed information for users to dig deeper.
> That would be an additional improvement for helping users find out more
> information once they realize or remember they are in a sparse checkout,
> this is just aimed at giving them a simple reminder.
>
> Changes since v1:
>
>  * Replaced the -1 magic constant with SPARSE_CHECKOUT_DISABLED
>  * Fixed a possible division by 0 (when there are no entries in the index
>    AND sparse checkout is enabled; not sure when that'd ever happen but
>    still better to guard against...)
>  * Slight wording tweaks for the git-prompt commit message
>  * Removed the RFC label
>
> Elijah Newren (2):
>   wt-status: show sparse checkout status as well
>   git-prompt: include sparsity state as well
>
>  contrib/completion/git-prompt.sh |  7 +++++-
>  wt-status.c                      | 41 ++++++++++++++++++++++++++++++++
>  wt-status.h                      |  2 ++
>  3 files changed, 49 insertions(+), 1 deletion(-)

Any change to Documentation/git-status.txt?

