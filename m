Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA2DC25B08
	for <git@archiver.kernel.org>; Wed, 17 Aug 2022 14:23:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239770AbiHQOX2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Aug 2022 10:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240092AbiHQOXV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Aug 2022 10:23:21 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9CE21141
        for <git@vger.kernel.org>; Wed, 17 Aug 2022 07:23:19 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id 62so668513iov.5
        for <git@vger.kernel.org>; Wed, 17 Aug 2022 07:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=Blz9IFetp/D362R6ztXYLRMfapEHNZWl94J8yL06qnY=;
        b=iXoFjQQmwy1wA7FPqRpWN8xz6U969XOwRGY25QThQaooutDDJR10GFR49G4tnLAy3K
         8DSzR3zqbP0vC/RJtTvZy19CBgDgDxaSjRAYYTZtEK47p1Clp11E4RR4xzqI4teSyhzF
         intP2hLkPbeGT/ct53rdtx6sxBGyrwF11lsesUdcNJ6fCL3h3fUAAfPISJ03GA7rmdaG
         2clD4ObD+ldMWdBzy29JzyJfqbJ+Tq831J5gRjmhqhGg/3rrfPradOzgmLL0aiEyGBCc
         HO5EieyCJq8qKga7fylbfEoZOGrrLDkq3T02DhmEMdSrpoG2BYxgDskfoRYFuALTLeAf
         gXIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=Blz9IFetp/D362R6ztXYLRMfapEHNZWl94J8yL06qnY=;
        b=hUpkKUgsimzibJC9pT+o5JFB9+3eHiZMShtV6k9dwWFUiZYXsygOWXu/LEstM6/bsB
         wdapFKsWg7Mn0ZG8PCES+A+Nc0UOtTM4dWPHiMtiZFBZ/tbFGczjkfwmuQnBexBGfL0i
         AmlNS6Of0beXrxZ0wfJyIaQY0JTwXD1ZsEEsqNFgDSN+zTrUhhI+f2DTccvwgy0+Kg3L
         Z6BlwjcR9ONsIsRV6l+8mIqWPn0Lj0TQwiI99v/lS9jZ6/Gxroa2hSIlwKjYiJbGQih5
         B5OJ5pPOgZzoaLU5Sh7YwvbIl6T/6Y3d1C3D9Grrb1qcszOebKYa4Q+jXKPYTfZvIK1N
         UBYw==
X-Gm-Message-State: ACgBeo1sjsskV/HVM/SDa88etHPeV7+qzhL3s47EJ4EcuEHvKKEKGK08
        BgJWAByiQsoIn8bIejMnh1tKyfSxF2EX
X-Google-Smtp-Source: AA6agR5H4FpjGEDMTlRJt+FeZ2nJJrxTS9zUoVfRHd/6iMRZ2jCcuL+YMCX6anKLWRdiEO77fi+Aqw==
X-Received: by 2002:a5d:8ac9:0:b0:684:b389:b38b with SMTP id e9-20020a5d8ac9000000b00684b389b38bmr10897555iot.138.1660746198136;
        Wed, 17 Aug 2022 07:23:18 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:f8cc:7049:fd75:5ebd? ([2600:1700:e72:80a0:f8cc:7049:fd75:5ebd])
        by smtp.gmail.com with ESMTPSA id c20-20020a056e020bd400b002e0f21f0be4sm5923610ilu.27.2022.08.17.07.23.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Aug 2022 07:23:17 -0700 (PDT)
Message-ID: <19dea639-389a-7258-e424-4912bde226df@github.com>
Date:   Wed, 17 Aug 2022 10:23:15 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v1 2/2] builtin/grep.c: integrate with sparse index
Content-Language: en-US
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>, git@vger.kernel.org
Cc:     vdye@github.com
References: <20220817075633.217934-1-shaoxuan.yuan02@gmail.com>
 <20220817075633.217934-3-shaoxuan.yuan02@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <20220817075633.217934-3-shaoxuan.yuan02@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/17/2022 3:56 AM, Shaoxuan Yuan wrote:
> Turn on sparse index and remove ensure_full_index().
> 
> Change it to only expands the index when using --sparse.
> 
> The p2000 tests demonstrate a ~99.4% execution time reduction for
> `git grep` using a sparse index.
> 
> Test                                           HEAD~1       HEAD
> -----------------------------------------------------------------------------
> 2000.78: git grep --cached bogus (full-v3)     0.019        0.018  (-5.2%)
> 2000.79: git grep --cached bogus (full-v4)     0.017        0.016  (-5.8%)
> 2000.80: git grep --cached bogus (sparse-v3)   0.29         0.0015 (-99.4%)
> 2000.81: git grep --cached bogus (sparse-v4)   0.30         0.0018 (-99.4%)

Good results.

I think we could get interesting results even with the --sparse
option if you go another step further (perhaps as a patch after
this one).

> 
> Optional reading about performance test results
> -----------------------------------------------
> Notice that because `git-grep` needs to parse blobs in the index, the
> index reading time is minuscule comparing to the object parsing time.
> And because of this, the p2000 test results cannot clearly reflect the
> speedup for index reading: combining with the object parsing time,
> the aggregated time difference is extremely close between HEAD~1 and
> HEAD.
> 
> Hence, the results presenting here are not directly extracted from the
> p2000 test results. Instead, to make the performance difference more
> visible, the test command is manually ran with GIT_TRACE2_PERF in the
> four repos (full-v3, sparse-v3, full-v4, sparse-v4). The numbers here
> are then extracted from the time difference between "region_enter" and
> "region_leave" of label "do_read_index".

This is a good point, but I don't recommend displaying them as if they
were the output of a "./run HEAD~1 HEAD -- p2000-sparse-operations.sh"
command. Instead, point out that the performance test does not show a
major improvement and instead you have these "Before" and "After" results
from testing manually and extracting trace2 regions.

> @@ -519,11 +519,15 @@ static int grep_cache(struct grep_opt *opt,
>  		strbuf_addstr(&name, repo->submodule_prefix);
>  	}
>  
> +	prepare_repo_settings(repo);
> +	repo->settings.command_requires_full_index = 0;
> +

The best pattern is to put this in cmd_grep() immediately after parsing
options. This guarantees that we don't parse and expand the index in any
other code path.

>  	if (repo_read_index(repo) < 0)
>  		die(_("index file corrupt"));
>  
> -	/* TODO: audit for interaction with sparse-index. */
> -	ensure_full_index(repo->index);
> +	if (grep_sparse)
> +		ensure_full_index(repo->index);
> +

As mentioned before, this approach is the simplest way to make the case
without --sparse faster, but the case _with_ --sparse will still be slow.
The way to fix this would be to modify this portion of the loop:

	if (S_ISREG(ce->ce_mode) &&
	    match_pathspec(repo->index, pathspec, name.buf, name.len, 0, NULL,
			   S_ISDIR(ce->ce_mode) ||
			   S_ISGITLINK(ce->ce_mode))) {

by adding an initial case

	if (S_ISSPARSEDIR(ce->ce_mode)) {
		hit |= grep_tree(opt, &ce->oid, name.buf, 0, name.buf);
	} else if (S_ISREG(ce->ce_mode) &&
		   match_pathspec(repo->index, pathspec, name.buf, name.len, 0, NULL,
				  S_ISDIR(ce->ce_mode) ||
				  S_ISGITLINK(ce->ce_mode))) {

and appropriately implement "grep_tree()" to walk the tree at ce->oid to
find all matching files within, then call grep_oid() for each of those
paths.

Bonus points if you recognize that the pathspec uses prefix checks that
allow pruning the search space and not parsing all of the trees
recursively. But that can definitely be delayed for a future enhancement.

> +test_expect_success 'grep expands index using --sparse' '
> +	init_repos &&
> +
> +	# With --sparse and --cached, do not ignore sparse entries and
> +	# expand the index.
> +	test_all_match git grep --sparse --cached a
> +'

Here, you're testing that the behavior matches, but not testing that the
index expands. (It does describe why you didn't include it in the later
ensure_not_expanded tests.)

> +
> +test_expect_success 'grep is not expanded' '
> +	init_repos &&
> +
> +	ensure_not_expanded grep a &&
> +	ensure_not_expanded grep a -- deep/* &&
> +	# grep does not match anything per se, so ! is used

It can be helpful to say why:

	# All files within the folder1/* pathspec are sparse,
	# so this command does not find any matches.

> +	ensure_not_expanded ! grep a -- folder1/*
> +'

Thanks,
-Stolee
