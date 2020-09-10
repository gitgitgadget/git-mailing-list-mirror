Return-Path: <SRS0=4khD=CT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E79C433E2
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 21:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8CAB221E2
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 21:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qhJctRjH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbgIJVdb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Sep 2020 17:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730977AbgIJNun (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Sep 2020 09:50:43 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A7AC061796
        for <git@vger.kernel.org>; Thu, 10 Sep 2020 06:50:43 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id w2so134147wmi.1
        for <git@vger.kernel.org>; Thu, 10 Sep 2020 06:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DG6tO9QbG2my9NLWqPew93FdSbZ4Q4hsAVjL8RciML8=;
        b=qhJctRjHvOg/BDcg2D6lD25I2TgBOanBibnBp78kyS5CxFkrb5xXmDI8BMgYEl6Sfu
         dCjnAY4jrvjAP4FeOYzDMWZ5JwYkB9z0+eFtR2YQEhJP4HJ4RiQraM2AoJAwsnYJPR33
         dS8Esnfp3mbTfc3+GaYENm3+4OdQTW56sXNMfCUVeY0ofL1ythpxVOLFxWjw/W5RLv43
         5jWD//So3CA0Hj9LV6uq+YsLNfBsKRNWDU/lRWJGcostUzRNr2G43FhsD9fjX+UfuVMK
         83Ppnj2VrHBKvMNG6RllS9TqsBShG/OqEmX19WlbsMbywHL7FsrtcYwkIVJZXJ3v+5LX
         whIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DG6tO9QbG2my9NLWqPew93FdSbZ4Q4hsAVjL8RciML8=;
        b=Ia+haC/7s3FKkSheQ15j9IYvrJ7CXTX4aykl9pYMh/KB8bhnJroHdzoU9+Lest2tld
         d+t342PbdFYFi7YmlDR6b8AK+cxU2opMcrao9VmyBU5gaJBIabMjv7kAGWwNTxIhv+Xg
         xrrHODXpj4Tw6qE39pQUgtIXNo623W8VvEYNcXA0JKZfOu0/ikBNaZzzxv0XEOrcWyBz
         uTEP5FxbS/vNKLTnVhBUXfzfwsjg0HzzCr/VnvCtS2Zohipg752TzFdDU1ZuWb+J6tmP
         w0bc98OOAlAM/36tPSNrpUZte1xdeDYTe7QANUVg10W6Ewx50DXCX1WhLd0QI4yl5BVw
         yZ4Q==
X-Gm-Message-State: AOAM532qap741MIpqaZLDAylXdKQLY3c3BS1nu3gGkzO/0jwe8sDk965
        6GlI/vzdsOYgxwmi3qRAe8uVWgc2WXo=
X-Google-Smtp-Source: ABdhPJyT3o8Ojh3xflbludHzcIUOmzg5S4lQaK/w2b8XNWnJjq+qWf3IJ9rI159JjjryP3QF79/TqA==
X-Received: by 2002:a1c:3588:: with SMTP id c130mr106386wma.94.1599745841795;
        Thu, 10 Sep 2020 06:50:41 -0700 (PDT)
Received: from [192.168.1.240] (151.252.189.80.dyn.plus.net. [80.189.252.151])
        by smtp.gmail.com with ESMTPSA id h5sm8748204wrt.31.2020.09.10.06.50.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2020 06:50:41 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 8/9] commit: use config-based hooks
To:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
References: <20200909004939.1942347-1-emilyshaffer@google.com>
 <20200909004939.1942347-9-emilyshaffer@google.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <a81b058c-b193-7020-30c9-9238407889ba@gmail.com>
Date:   Thu, 10 Sep 2020 14:50:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200909004939.1942347-9-emilyshaffer@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Emily

On 09/09/2020 01:49, Emily Shaffer wrote:
> As part of the adoption of config-based hooks, teach run_commit_hook()
> to call hook.h instead of run-command.h. This covers 'pre-commit',
> 'commit-msg', and 'prepare-commit-msg'. Additionally, ask the hook
> library - not run-command - whether any hooks will be run, as it's
> possible hooks may exist in the config but not the hookdir.
> 
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
>   builtin/commit.c                                 |  3 ++-
>   builtin/merge.c                                  |  3 ++-
>   commit.c                                         | 13 ++++++++++++-
>   t/t7503-pre-commit-and-pre-merge-commit-hooks.sh | 13 +++++++++++++
>   4 files changed, 29 insertions(+), 3 deletions(-)
> 
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 69ac78d5e5..a19c6478eb 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -36,6 +36,7 @@
>   #include "help.h"
>   #include "commit-reach.h"
>   #include "commit-graph.h"
> +#include "hook.h"
>   
>   static const char * const builtin_commit_usage[] = {
>   	N_("git commit [<options>] [--] <pathspec>..."),
> @@ -985,7 +986,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>   		return 0;
>   	}
>   
> -	if (!no_verify && find_hook("pre-commit")) {
> +	if (!no_verify && hook_exists("pre-commit")) {
>   		/*
>   		 * Re-read the index as pre-commit hook could have updated it,
>   		 * and write it out as a tree.  We must do this before we invoke
> diff --git a/builtin/merge.c b/builtin/merge.c
> index 74829a838e..c1a9d0083d 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -41,6 +41,7 @@
>   #include "commit-reach.h"
>   #include "wt-status.h"
>   #include "commit-graph.h"
> +#include "hook.h"
>   
>   #define DEFAULT_TWOHEAD (1<<0)
>   #define DEFAULT_OCTOPUS (1<<1)
> @@ -829,7 +830,7 @@ static void prepare_to_commit(struct commit_list *remoteheads)
>   	 * and write it out as a tree.  We must do this before we invoke
>   	 * the editor and after we invoke run_status above.
>   	 */
> -	if (find_hook("pre-merge-commit"))
> +	if (hook_exists("pre-merge-commit"))
>   		discard_cache();
>   	read_cache_from(index_file);
>   	strbuf_addbuf(&msg, &merge_msg);
> diff --git a/commit.c b/commit.c
> index 4ce8cb38d5..c7a243e848 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -21,6 +21,7 @@
>   #include "commit-reach.h"
>   #include "run-command.h"
>   #include "shallow.h"
> +#include "hook.h"
>   
>   static struct commit_extra_header *read_commit_extra_header_lines(const char *buf, size_t len, const char **);
>   
> @@ -1632,8 +1633,13 @@ int run_commit_hook(int editor_is_used, const char *index_file,
>   {
>   	struct strvec hook_env = STRVEC_INIT;
>   	va_list args;
> +	const char *arg;
> +	struct strvec hook_args = STRVEC_INIT;
> +	struct strbuf hook_name = STRBUF_INIT;
>   	int ret;
>   
> +	strbuf_addstr(&hook_name, name);

Seeing this makes me wonder if it would be better for run_hooks() to 
take a string for the name rather than an strbuf, I suspect that 
virtually all callers have a fixed hook name.

Best Wishes

Phillip

>   	strvec_pushf(&hook_env, "GIT_INDEX_FILE=%s", index_file);
>   
>   	/*
> @@ -1643,9 +1649,14 @@ int run_commit_hook(int editor_is_used, const char *index_file,
>   		strvec_push(&hook_env, "GIT_EDITOR=:");
>   
>   	va_start(args, name);
> -	ret = run_hook_ve(hook_env.v, name, args);
> +	while ((arg = va_arg(args, const char *)))
> +		strvec_push(&hook_args, arg);
>   	va_end(args);
> +
> +	ret = run_hooks(hook_env.v, &hook_name, &hook_args);
>   	strvec_clear(&hook_env);
> +	strvec_clear(&hook_args);
> +	strbuf_release(&hook_name);
>   
>   	return ret;
>   }
> diff --git a/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh b/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh
> index b3485450a2..cef8085dcc 100755
> --- a/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh
> +++ b/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh
> @@ -103,6 +103,19 @@ test_expect_success 'with succeeding hook' '
>   	test_cmp expected_hooks actual_hooks
>   '
>   
> +# NEEDSWORK: when 'git hook add' and 'git hook remove' have been added, use that
> +# instead
> +test_expect_success 'with succeeding hook (config-based)' '
> +	test_when_finished "git config --unset hook.pre-commit.command success.sample" &&
> +	test_when_finished "rm -f expected_hooks actual_hooks" &&
> +	git config hook.pre-commit.command "$HOOKDIR/success.sample" &&
> +	echo "$HOOKDIR/success.sample" >expected_hooks &&
> +	echo "more" >>file &&
> +	git add file &&
> +	git commit -m "more" &&
> +	test_cmp expected_hooks actual_hooks
> +'
> +
>   test_expect_success 'with succeeding hook (merge)' '
>   	test_when_finished "rm -f \"$PREMERGE\" expected_hooks actual_hooks" &&
>   	cp "$HOOKDIR/success.sample" "$PREMERGE" &&
> 
