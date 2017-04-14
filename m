Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC692209FA
	for <e@80x24.org>; Fri, 14 Apr 2017 20:13:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752597AbdDNUNb (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Apr 2017 16:13:31 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:36324 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751470AbdDNUNa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2017 16:13:30 -0400
Received: by mail-pg0-f47.google.com with SMTP id g2so47037352pge.3
        for <git@vger.kernel.org>; Fri, 14 Apr 2017 13:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=bwHNjwV2558cAndghYejtPFTldgi134jaaG4iVJdslQ=;
        b=o5MlweToEqONBC0PQmlWWwL+kDU/79wSgygbwExSupoAB9VQXrVBlxVy364rOSQAsW
         3cbpT+16s10eWEdtMUW4Zex69r7V4htA8rPRrj0vu2LC8JSychxgJwtYe2Fxe1iUcsYY
         UDhAm0rPtn/RAlllzaUglUat0+Mm/fqU5r6LVwtl+eWo9Irdcdmd7m2rGBpSxmTgEVWE
         QxcLoR5S15e21rUNP3N1tGN+mYteAMXZs/no7xVYzQ4Ct8+HxGPUonRBIuJZTGprwzUg
         NKe96wk9BLEhlQxm0FGEWs0MJ7FVgN+iDzrY2QFxntUK0HPV5nYmrIqRmVYXCib8YHSe
         I5Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=bwHNjwV2558cAndghYejtPFTldgi134jaaG4iVJdslQ=;
        b=VvzaxFuBHPIQqneJ8GU1dAT2sgkrcr6CCdwvVCGlxsIjuuwfvhdGU+Kh62HWIKa83S
         tuRYtkxhotQpFMlbVfJio4ScGm3T8IWEmWjcOKvunkAsjweBcDpiFjw2/xm4qAfY6GDw
         TA4LXEwPeahh9cIRIrAWjUzGLgPXfBDS36RbdiqMbHCWyVD4jT7tRE66MlJoOL3xKqmU
         TCajQCty52JVcLctkpvueAhSMOA2XVXNdVngbbqm7yO3pwdBLzl75CU9aepmBEUN7RTw
         x+GCI3sg6NKE6NQpnbbCFy9pG1uIJQCLuI2oUSE5efQIGY1krLpdDQCQqspY0o7JPdYE
         U22w==
X-Gm-Message-State: AN3rC/4tTxdWRRbau468vNAqeUfgwct8koVZwEyYmhR+IjchIctWWlWG
        qvP5X3Z0De5XKQmL
X-Received: by 10.84.129.3 with SMTP id 3mr11095018plb.150.1492200809291;
        Fri, 14 Apr 2017 13:13:29 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([2620:0:1000:5b10:89f1:c9fd:6430:a29d])
        by smtp.gmail.com with ESMTPSA id y29sm4728763pfj.90.2017.04.14.13.13.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Apr 2017 13:13:27 -0700 (PDT)
Subject: Re: [PATCH 3/4] submodule.c: harden submodule_move_head against
 broken submodules
To:     Stefan Beller <sbeller@google.com>, bmwill@google.com
References: <20170411234923.1860-1-sbeller@google.com>
 <20170411234923.1860-4-sbeller@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, gitster@pobox.com
From:   Jonathan Tan <jonathantanmy@google.com>
Message-ID: <5441277f-8d8a-23dc-2c1a-d637286f007c@google.com>
Date:   Fri, 14 Apr 2017 13:13:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170411234923.1860-4-sbeller@google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I think "harden" is the wrong word to use in the subject - to me, 
"harden" implies that you're defending against an invalid use. But here, 
not only is the use valid, but this patch also takes steps to support it.

On 04/11/2017 04:49 PM, Stefan Beller wrote:
> Early on in submodule_move_head just after the check if the submodule is
> initialized, we need to check if the submodule is populated correctly.
>
> If the submodule is initialized but doesn't look like populated, this
> is a red flag and can indicate multiple sorts of failures:
> (1) The submodule may be recorded at an object name, that is missing.
> (2) The submodule '.git' file link may be broken and it is not pointing
>     at a repository.
>
> In both cases we want to complain to the user in the non-forced mode,
> and in the forced mode ignoring the old state and just moving the
> submodule into its new state with a fixed '.git' file link.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  submodule.c               | 17 +++++++++++++++++
>  t/lib-submodule-update.sh | 23 ++++++++++++++++++++---
>  2 files changed, 37 insertions(+), 3 deletions(-)
>
> diff --git a/submodule.c b/submodule.c
> index 2fa42519a4..dda1ead854 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -1331,10 +1331,19 @@ int submodule_move_head(const char *path,
>  	int ret = 0;
>  	struct child_process cp = CHILD_PROCESS_INIT;
>  	const struct submodule *sub;
> +	int *errorcode, error_code;

Maybe call it error_code_ptr?

>
>  	if (!is_submodule_initialized(path))
>  		return 0;
>
> +	if (flags & SUBMODULE_MOVE_HEAD_FORCE)
> +		errorcode = &error_code;
> +	else
> +		errorcode = NULL;
> +
> +	if (old && !is_submodule_populated_gently(path, errorcode))

This behavior of the null-ness of the pointer controlling whether the 
function dies upon error or not is quite confusing to me, so I would add 
a comment (e.g. under the "errorcode = &error_code" statement, saying 
"Pass a non-null pointer to make is_submodule_populated_gently report 
errors to use instead of die()-ing").

> +		return 0;
> +
>  	sub = submodule_from_path(null_sha1, path);
>
>  	if (!sub)
> @@ -1361,6 +1370,14 @@ int submodule_move_head(const char *path,
>  			/* make sure the index is clean as well */
>  			submodule_reset_index(path);
>  		}
> +
> +		if (old && (flags & SUBMODULE_MOVE_HEAD_FORCE)) {
> +			struct strbuf sb = STRBUF_INIT;
> +			strbuf_addf(&sb, "%s/modules/%s",
> +				    get_git_common_dir(), sub->name);
> +			connect_work_tree_and_git_dir(path, sb.buf);
> +			strbuf_release(&sb);

xstrfmt might be simpler, but I don't have a strong preference either way.

> +		}
>  	}
>
>  	prepare_submodule_repo_env_no_git_dir(&cp.env_array);
> diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
> index 22dd9e060c..f0b1b18206 100755
> --- a/t/lib-submodule-update.sh
> +++ b/t/lib-submodule-update.sh
> @@ -1213,14 +1213,31 @@ test_submodule_forced_switch_recursing () {
>  		)
>  	'
>  	# Updating a submodule from an invalid sha1 updates
> -	test_expect_success "$command: modified submodule does not update submodule work tree from invalid commit" '
> +	test_expect_success "$command: modified submodule does update submodule work tree from invalid commit" '
>  		prolog &&
>  		reset_work_tree_to_interested invalid_sub1 &&
>  		(
>  			cd submodule_update &&
>  			git branch -t valid_sub1 origin/valid_sub1 &&
> -			test_must_fail $command valid_sub1 &&
> -			test_superproject_content origin/invalid_sub1
> +			$command valid_sub1 &&
> +			test_superproject_content origin/valid_sub1 &&
> +			test_submodule_content sub1 origin/valid_sub1
> +		)
> +	'
> +
> +	# Old versions of Git were buggy writing the .git link file
> +	# (e.g. before f8eaa0ba98b and then moving the superproject repo
> +	# whose submodules contained absolute paths)
> +	test_expect_success "$command: updating submodules fixes .git links" '
> +		prolog &&
> +		reset_work_tree_to_interested add_sub1 &&
> +		(
> +			cd submodule_update &&
> +			git branch -t modify_sub1 origin/modify_sub1 &&
> +			echo "gitdir: bogus/path" >sub1/.git &&
> +			$command modify_sub1 &&
> +			test_superproject_content origin/modify_sub1 &&
> +			test_submodule_content sub1 origin/modify_sub1
>  		)
>  	'
>  }
>
