Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9670AC433E6
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 13:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45B6264EE2
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 13:18:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbhBINSv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 08:18:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbhBINSg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 08:18:36 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D51FEC061788
        for <git@vger.kernel.org>; Tue,  9 Feb 2021 05:17:55 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id h16so12829382qth.11
        for <git@vger.kernel.org>; Tue, 09 Feb 2021 05:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=6uvQGWr8qWB933IHVA/sitRFHl8xMjzIAFMugUxgnw8=;
        b=pXhJspT7yKs3S3U0RA6WW6BE8g3bLGyXHx0Sl8JiIn/Tf1cIzzCWf7JHG72EWom0Th
         bh7AIEtygUt+7yuYWlqHmlTo4F9dDCAehDpKdST/X6e6MDCE00yMKbl0E5uUzTCrxqKU
         xovAScrTsYyNd1kt86hqQ38h8pV572JLgEwXBG+FnUpZLSxkMdSZ98Oo8vki4Urz87Bl
         0b0lIW8yMR+dY2mN4VyREY0zqYmhmiHVwEYb0yfXa6wq1ltrxEBt9aenW5AUL2mxjYub
         WpDUZHngw03Yj3MZl43nLb4zL42nDqJz46w6DYWIqNcBKWTUcWObJkqdSb1Piy7BmLP3
         BA8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6uvQGWr8qWB933IHVA/sitRFHl8xMjzIAFMugUxgnw8=;
        b=tSP+6kWJky/sj7OnyPS3Vr5xjOzHisHDfoUW4RnTK4YasEF+m+3KszATR0EznpeYqo
         dIwb2Niu1babBQT7LtX0ZgbD6xfWDSCTymNMvQjn/KBpwevX/lxGQI8MIcQ6RjRSKSvJ
         nli56/6D4I7mqY/M2UosHBliARKPm5yeo9vJEgspEEWsm56GJGaQOLsRXNyuioIO9mk+
         ld4it2pt12Wiz7gV/bSIcemlezRPLQE7zJfVJUDHzpsUDegjdDcvTvbkhDsMcHwqgPSo
         BKcZddsT+hTFkkiCA8q0x1s2wW5NB40owqS+o0VLOnGTLznNCebOKV0rfQN4DZk4Z8fF
         y9dw==
X-Gm-Message-State: AOAM531RPJV4tw1CWC7jBhrY5tNZTxNYyy9+XY243FaXYA5kXHhlhwHv
        18NBqzyeTP+qZzfYmZAMlqQ=
X-Google-Smtp-Source: ABdhPJxQQHHbkG4qPtL4H1fCPMyZgDCGnHbzWDepRUMJSCB9cIAPcDdWTcIVLUcOgDCtGqhnmCMl4Q==
X-Received: by 2002:a05:622a:149:: with SMTP id v9mr18870695qtw.50.1612876675011;
        Tue, 09 Feb 2021 05:17:55 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:7c18:1f04:a165:5ea0? ([2600:1700:e72:80a0:7c18:1f04:a165:5ea0])
        by smtp.gmail.com with UTF8SMTPSA id q25sm19084345qkq.32.2021.02.09.05.17.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Feb 2021 05:17:54 -0800 (PST)
Message-ID: <dfbffe97-51de-9e8b-37a4-417909358323@gmail.com>
Date:   Tue, 9 Feb 2021 08:17:53 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101
 Thunderbird/86.0
Subject: Re: [PATCH v2 1/4] diffcore-rename: compute basenames of all source
 and dest candidates
Content-Language: en-US
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
References: <pull.843.git.1612651937.gitgitgadget@gmail.com>
 <pull.843.v2.git.1612870326.gitgitgadget@gmail.com>
 <381a45d239bb52a70373c385d8978005c9cb4800.1612870326.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <381a45d239bb52a70373c385d8978005c9cb4800.1612870326.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/9/2021 6:32 AM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> We want to make use of unique basenames to help inform rename detection,
> so that more likely pairings can be checked first.  (src/moduleA/foo.txt
> and source/module/A/foo.txt are likely related if there are no other
> 'foo.txt' files among the deleted and added files.)  Add a new function,
> not yet used, which creates a map of the unique basenames within
> rename_src and another within rename_dst, together with the indices
> within rename_src/rename_dst where those basenames show up.  Non-unique
> basenames still show up in the map, but have an invalid index (-1).
> 
> This function was inspired by the fact that in real world repositories,
> most renames often do not involve a basename change.  Here are some
> sample repositories and the percentage of their historical renames (as of
> early 2020) that did not involve a basename change:

I found this difficult to parse. Perhaps instead

  "the percentage of their renames that preserved basenames".

We might also need something stronger, though: which percentage of renames
preserved the basename but also had no other copy of that basename in the
scope of all add/deletes?

Is this reproducible from a shell command that could be documented here?

> +MAYBE_UNUSED
> +static int find_basename_matches(struct diff_options *options,
> +				 int minimum_score,
> +				 int num_src)
> +{
> +	int i;
> +	struct strintmap sources;
> +	struct strintmap dests;
> +
> +	/* Create maps of basename -> fullname(s) for sources and dests */
> +	strintmap_init_with_options(&sources, -1, NULL, 0);
> +	strintmap_init_with_options(&dests, -1, NULL, 0);

Initially, I was wondering why we need the map for each side, but we will need
to enforce uniqueness in each set, so OK.

> +	for (i = 0; i < num_src; ++i) {
> +		char *filename = rename_src[i].p->one->path;
> +		char *base;
> +
> +		/* exact renames removed in remove_unneeded_paths_from_src() */
> +		assert(!rename_src[i].p->one->rename_used);
> +
> +		base = strrchr(filename, '/');
> +		base = (base ? base+1 : filename);

nit: "base + 1"

Also, this is used here and below. Perhaps it's worth pulling out as a
helper? I see similar code being duplicated in these existing spots:

* diff-no-index.c:append_basename()
* help.c:append_similar_ref()
* packfile.c:pack_basename()
* replace-object.c:register_replace_ref()
* setup.c:read_gitfile_gently()
* builtin/rebase.c:cmd_rebase()
* builtin/stash.c:do_create_stash()
* builtin/worktree.c:add_worktree()
* contrib/credential/gnome-keyring/git-credential-gnome-keyring.c:usage()
* contrib/credential/libsecret/git-credential-libsecret.c:usage()
* trace2/tr2_dst.c:tr2_dst_try_auto_path()

There are other places that use strchr(_, '/') but they seem to be related
to peeling basenames off of paths and using the leading portion of the path.

> +		/* Record index within rename_src (i) if basename is unique */
> +		if (strintmap_contains(&sources, base))
> +			strintmap_set(&sources, base, -1);
> +		else
> +			strintmap_set(&sources, base, i);
> +	}
> +	for (i = 0; i < rename_dst_nr; ++i) {
> +		char *filename = rename_dst[i].p->two->path;
> +		char *base;
> +
> +		if (rename_dst[i].is_rename)
> +			continue; /* involved in exact match already. */
> +
> +		base = strrchr(filename, '/');
> +		base = (base ? base+1 : filename);
> +
> +		/* Record index within rename_dst (i) if basename is unique */
> +		if (strintmap_contains(&dests, base))
> +			strintmap_set(&dests, base, -1);
> +		else
> +			strintmap_set(&dests, base, i);
> +	}
> +
> +	/* TODO: Make use of basenames source and destination basenames */
> +
> +	strintmap_clear(&sources);
> +	strintmap_clear(&dests);
> +
> +	return 0;
> +}

Thanks,
-Stolee
