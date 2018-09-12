Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56C4C1F404
	for <e@80x24.org>; Wed, 12 Sep 2018 21:23:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbeIMCaJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Sep 2018 22:30:09 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38647 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727736AbeIMCaJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Sep 2018 22:30:09 -0400
Received: by mail-wm0-f67.google.com with SMTP id t25-v6so3910828wmi.3
        for <git@vger.kernel.org>; Wed, 12 Sep 2018 14:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Yia7AQHRPC5L1c8gdQgHw/3FXKRRda6JlxPcJ24gFh4=;
        b=a4cYGGfLX6prtccAyhI1xT9jEPYX1VK0uWcKp5b+AgBgCfHWD21TeAZ87I5RQyU57U
         Y3429t7NTfWfgqB/i2MYPjivhpqteM33C/SJ986ZII0gVki7t/5mKr4i9FM+cOSiLeB2
         UondrfG9HbuHawKd6rRtDp+vYVp/BrqmFpiSFZTei1XA2nMwigCaag25u/lwKNb0AdYy
         xnindAFaVbVmX7YqkJZJ/qy3az5I9wuq0ITkJj6bAkJW6lKZyaQJRNead04I/CUJK5LX
         frnx5zyyHUPpwjhjNAheabU6xd0MZeLALEXcb/5Y1RPcHLwOZ9VYtAFsXf72LN9nMVb/
         Xr2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Yia7AQHRPC5L1c8gdQgHw/3FXKRRda6JlxPcJ24gFh4=;
        b=SUcOTiNOV2cWEH2Fb1wU5xRr1B+IQANI4VHu7H8Y0bpcmYJfh8Fa5Rwx6ge5jq8sKg
         oh4b0aNc4bwbmY2WjmXJD6HJFUE+TFbwGWpYqbUZGh4+ROPOso6CfhLUhzj0GE3Ff9+K
         FxIkca20HI3YlAEs//joOuMPsZP1HmAAMbVWLQFHROmR1wcYUXNkSWr7VMZHuT9chjMo
         WtRktPRE+FgdJoI97eTKKTH4qOl6duLu8t3UngUZFbkP3W/7Iy3KQAD6MFsj1yW5jHw3
         /IJIcvh9eJX2ZPFhf6IV6cH3gJ9QQ7qNntkbA1Qv1vRbe2PZzItReYXU7Q7B57/7rPy5
         BWuQ==
X-Gm-Message-State: APzg51CohckfmBQM3OrBm5BFcxSQQE98+D+9tIzzCFxxoD6oms0/UO1z
        HQkUMGNx2B6R8JeHmHXsdkc=
X-Google-Smtp-Source: ANB0VdbS70OWNZd+r6wQDSgtus6i1PVpKHRzZEU2fGmVp0udH33R/MIXrhlPF+Sw+fLYN7bKvLketA==
X-Received: by 2002:a1c:6782:: with SMTP id b124-v6mr3052162wmc.30.1536787424305;
        Wed, 12 Sep 2018 14:23:44 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id v46-v6sm2943908wrc.63.2018.09.12.14.23.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 14:23:43 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/1] commit-reach: properly peel tags
References: <pull.39.git.gitgitgadget@gmail.com>
        <948e222228d2f2868b85a425142382e63a17773a.1536762173.git.gitgitgadget@gmail.com>
Date:   Wed, 12 Sep 2018 14:23:42 -0700
In-Reply-To: <948e222228d2f2868b85a425142382e63a17773a.1536762173.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Wed, 12 Sep 2018
        07:22:56 -0700 (PDT)")
Message-ID: <xmqqpnxijtpd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/commit-reach.c b/commit-reach.c
> index 86715c103c..6de72c6e03 100644
> --- a/commit-reach.c
> +++ b/commit-reach.c
> @@ -544,20 +544,31 @@ int can_all_from_reach_with_flag(struct object_array *from,
>  {
>  	struct commit **list = NULL;
>  	int i;
> +	int nr_commits;
>  	int result = 1;
>  
>  	ALLOC_ARRAY(list, from->nr);
> +	nr_commits = 0;
>  	for (i = 0; i < from->nr; i++) {
> -		list[i] = (struct commit *)from->objects[i].item;
> +		struct object *from_one = from->objects[i].item;
>  
> -		if (parse_commit(list[i]) ||
> -		    list[i]->generation < min_generation)
> -			return 0;
> +		from_one = deref_tag(the_repository, from_one,
> +				     "a from object", 0);
> +		if (!from_one || from_one->type != OBJ_COMMIT) {
> +			from->objects[i].item->flags |= assign_flag;

I wondered why this is not futzing with "from_one->flags"; by going
back to the original from->objects[] array, the code is setting the
flags on the original tag object and not the non-commit object that
was pointed at by the tag.

> +			continue;
> +		}
> +
> +		list[nr_commits] = (struct commit *)from_one;
> +		if (parse_commit(list[nr_commits]) ||
> +		    list[nr_commits]->generation < min_generation)
> +			return 0; /* is this a leak? */
> +		nr_commits++;
>  	}

In the original code, the flags bits were left unchanged if the loop
terminated by hitting a commit whose generation is too young (or
parse_commit() returns non-zero).  With this updated code, flags bit
can be modified before the code notices the situation and leave the
function, bypassing the "cleanup" we see below that clears the
"assign_flag" bits.

Would it be a problem that we return early without cleaning up?

Even if we do not call this early return, the assign_flag bits added
to the original tag in from->objects[i].item won't be cleaned in
this new code, as "cleanup:" section now loops over the list[] that
omits the object whose flags was smudged above before the "continue".

Would it be a problem that we leave the assign_flags without
cleaning up?

> -	QSORT(list, from->nr, compare_commits_by_gen);
> +	QSORT(list, nr_commits, compare_commits_by_gen);
>  
> -	for (i = 0; i < from->nr; i++) {
> +	for (i = 0; i < nr_commits; i++) {
>  		/* DFS from list[i] */
>  		struct commit_list *stack = NULL;
>  
> @@ -600,7 +611,7 @@ int can_all_from_reach_with_flag(struct object_array *from,
>  	}
>  
>  cleanup:
> -	for (i = 0; i < from->nr; i++) {
> +	for (i = 0; i < nr_commits; i++) {
>  		clear_commit_marks(list[i], RESULT);
>  		clear_commit_marks(list[i], assign_flag);
>  	}
