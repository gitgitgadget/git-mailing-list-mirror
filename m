Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06E3B1F516
	for <e@80x24.org>; Mon, 25 Jun 2018 22:14:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752755AbeFYWOj (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Jun 2018 18:14:39 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36220 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752625AbeFYWOi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jun 2018 18:14:38 -0400
Received: by mail-wr0-f195.google.com with SMTP id f16-v6so15193698wrm.3
        for <git@vger.kernel.org>; Mon, 25 Jun 2018 15:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=6gOyY2QF34iIetzdikK4ZHO2siW29si5wev+JCj0LiY=;
        b=O50xMcni0B3RF1zwj9b7f9wGR+CKG9H2Y+/UXm6rZzQiqoNOtaz+cDGaeNWQYiqCmU
         29TowugtZ9ncUCzPHxoMgJr5uXZZlv3tHBxqCxr/oQ1N5//B8qSJxqglpvA8IMDPf1sm
         sBcv8xtEu/t/ehA3QhR8CvPVwViOFpm08IvFzjJKCLp1AmRPQ1HFmDO2bL55YM7g3OUo
         5fAvWeGGcYYlQo3QsvSCvap/4GFWllU0POlgwVFiu8LTbbIkx4+h6UUpo6CeSU/C2ikO
         cReWAZOX9lmq+q1C8gKUl355oZUdknTTwbYOuFDl+wwRyplkAMM/XQmbHN+/T+iQ7+zl
         xCdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=6gOyY2QF34iIetzdikK4ZHO2siW29si5wev+JCj0LiY=;
        b=n5PjEoECdzcnMiJa3ARl1MZ0VJbh2896O1fnmDEzaBsy2LhAhELEoWMWmDjU+0Q31r
         AWuoycDwtV2oYYdMRWzsEuVi02W4qwM3SNZgIr/ELGprQwZp+0TTy3agoGXd4outEAGH
         4JwkMAwBRuynjLDGidS/BQyHTq01BGhpASHbBHYXyNkmF5GikgfosBGFjvLT/nx+lMOU
         FnN33l382SEQtd/8ZQsAbVLPvUWk6Th9ad/WrCCfNb9ggGmtOnUuZs1EwZ8dKW2J8sHi
         hFdk8sQQkOFn0W+JdB7j2ULBAVnVJK3D34Q1jrazeEjl/4xmDnU5T/QQXG1dW1Mjrnb/
         Y/Hw==
X-Gm-Message-State: APt69E1cDPe5UR3gQlv5yQ8tR8U4t8gQ/ZtldaZ3M14hT8HKXzZm3mLJ
        bZ76ldy285dbXnqvNR014iE=
X-Google-Smtp-Source: AAOMgpfZYjcfQRAHAT6Rc2r48a7VccBz8AHJjeoD95IMsAcjgK6au6BCtdDSVxWbNkdxoY85uff8uA==
X-Received: by 2002:adf:8f23:: with SMTP id p32-v6mr11249673wrb.193.1529964876928;
        Mon, 25 Jun 2018 15:14:36 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id p5-v6sm12628wre.83.2018.06.25.15.14.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 15:14:35 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael Barabanov <michael.barabanov@gmail.com>
Cc:     git@vger.kernel.org, ijc@hellion.org.uk
Subject: Re: [PATCH] filter-branch: skip commits present on --state-branch
References: <20180623043639.7727-1-michael.barabanov@gmail.com>
Date:   Mon, 25 Jun 2018 15:14:35 -0700
In-Reply-To: <20180623043639.7727-1-michael.barabanov@gmail.com> (Michael
        Barabanov's message of "Fri, 22 Jun 2018 21:36:39 -0700")
Message-ID: <xmqqmuvims38.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Barabanov <michael.barabanov@gmail.com> writes:

> The commits in state:filter.map have already been processed, so don't
> filter them again. This makes incremental git filter-branch much faster.
>
> Also add tests for --state-branch option.
>
> Signed-off-by: Michael Barabanov <michael.barabanov@gmail.com>
> ---
>  git-filter-branch.sh     |  3 +++
>  t/t7003-filter-branch.sh | 15 +++++++++++++++
>  2 files changed, 18 insertions(+)
>
> diff --git a/git-filter-branch.sh b/git-filter-branch.sh
> index ccceaf19a..2df7ed107 100755
> --- a/git-filter-branch.sh
> +++ b/git-filter-branch.sh
> @@ -372,6 +372,9 @@ while read commit parents; do
>  	git_filter_branch__commit_count=$(($git_filter_branch__commit_count+1))
>  
>  	report_progress
> +	if test -r "$workdir/../map/$commit"; then
> +		continue
> +	fi

The original script is so much of a mess that I needed quite some
time to find enough evidence to convince myself that this change is
in line with what is already happening in the program.  We have

	test -f "$workdir"/../map/$sha1 && continue

in the codepath for remap-to-ancestor prostprocessing to do
pretty-much the same skipping.

I think the new code should follow suit, i.e.

	if test -f "$workdir/../map/$commit"
	then
		continue
	fi

to check just the existence for consistency.

It would have been reviewer friendly if the proposed commit log
message said how this change does *not* break the progress output
and count.  A possible alternative optimization could be not to add
these already mapped commits in ../revs file in the first place (so
they are not even counted as part of $commits), and such a change
would give different meaning to the progress output (which may or
may not be a good change).  Instead, the posted patch counts the
commits to be filtered the same way as before, and merely pretends
that it filtered those commits to their mapped counterparts without
spending any cycle (simply because we already _know_ what they are
mapped to), so the meaning of the numbers in the progress display
does not change at all---just they appear to progress much faster,
which is a welcome change ;-)



