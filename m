Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76D561F461
	for <e@80x24.org>; Tue, 20 Aug 2019 09:00:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729384AbfHTJAv (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Aug 2019 05:00:51 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55097 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729381AbfHTJAv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Aug 2019 05:00:51 -0400
Received: by mail-wm1-f67.google.com with SMTP id p74so1898276wme.4
        for <git@vger.kernel.org>; Tue, 20 Aug 2019 02:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZxFid3dusbJ6CV1dUjH9gt/HTt+jJjeFe2ZxgPM1seU=;
        b=kKwJsmT4kiVpLDdmsd2XgdvArzx5wX4WhpgLe6gee8uJmwHM6JT2g9q8pmuMZhxeqm
         gzvf2xUQOMSy0KXY3I4Pplbrxrp2Hbdi6TIajFYfhktSC2t8xhRSFoRXJzCsonKwOyyf
         oPh1cwdkTI8e0Fj2Rcjlnw0al2NRfg63jF6To4wJjVN/Lj0LPC7QacyR6BaLNJ8qO4kE
         IEjEcxMgVZ3JPp023bt/9xMWZ7LEoFvq+czk4/LoI6tE34Knse+2aee72BH4hy+dt2iX
         s0n35WWbpzRfRd6G6LQxNlvffnEjaU6zsWarumFVwVG0a9BSRph1+2t8z1xl7T34mCMg
         P/Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ZxFid3dusbJ6CV1dUjH9gt/HTt+jJjeFe2ZxgPM1seU=;
        b=m+RuBCbBS15ov5KTib0HsG/6ykIgsCnEt8BIZo9voIDh1UcZD8xjmcy7wffBQLr3+y
         JiJGHIhEJzj5riZrLEkqikv72MtaV31gFynWN5zvP0pxc60LXQkqvWN5LXDgna9mClgY
         Vt2WLR9J8C9MzSULWtgE/eo6opn7liOT4HwA3MLjBuWQyngThKNIDj//cfFRya9/qIlZ
         UU4BLQyTBZM2bcpOyiOgVwUJvRKyQRa6KQiQqHM6ov3phgUUr0dAdP8RZkSh79TVtw5o
         z+QsWqaZsXHOuBUJShIzFdHJxmVIz4VriJJcJxC8K5lqhgIjTwRRtdiRfX3Bvk7m4WPQ
         B0qg==
X-Gm-Message-State: APjAAAW8XnE8TNOGwjEM3lhoRCmcDd7psdBE/27WjmTV9Vo2PK6gXWib
        nqcahKUGTIQSMkfHG5zUwok7Rw02
X-Google-Smtp-Source: APXvYqxZIefLWZQhugVQLpiC7Qi739fDdgqBHnHD4tJkxT36daAEefNzRib/6ndoDhHGkMxTFK2RlA==
X-Received: by 2002:a1c:7a14:: with SMTP id v20mr20619053wmc.75.1566291648437;
        Tue, 20 Aug 2019 02:00:48 -0700 (PDT)
Received: from [192.168.2.240] (host-92-22-12-34.as13285.net. [92.22.12.34])
        by smtp.gmail.com with ESMTPSA id u130sm34511368wmg.28.2019.08.20.02.00.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2019 02:00:47 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/2] rebase.c: make sure current branch isn't moved when
 autostashing
To:     Ben Wijen <ben@wijen.net>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Pratik Karki <predatoramigo@gmail.com>
References: <20190818095349.3218-1-ben@wijen.net>
 <20190818095349.3218-3-ben@wijen.net>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <ff239cf8-f46e-82c5-788a-3484deff51cd@gmail.com>
Date:   Tue, 20 Aug 2019 10:00:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190818095349.3218-3-ben@wijen.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ben

I need to have a longer look at this (I don't understand why we're 
calling reset --hard after we've stashed the changes) but I notice that 
the test lines you're changing predate the switch to the builtin rebase 
so those changes are not related to the branch switching problem.

Best Wishes

Phillip

On 18/08/2019 10:53, Ben Wijen wrote:
> The rebase --autostash incorrectly moved the current branch to orig_head, where
> orig_head -- commit object name of tip of the branch before rebasing
> 
> It seems this was incorrectly taken over from git-legacy-rebase.sh
> 
> Signed-off-by: Ben Wijen <ben@wijen.net>
> ---
>   builtin/rebase.c            | 18 ++++++------------
>   t/t3420-rebase-autostash.sh |  4 ----
>   2 files changed, 6 insertions(+), 16 deletions(-)
> 
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 670096c065..a928f44941 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -1968,9 +1968,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>   				state_dir_path("autostash", &options);
>   			struct child_process stash = CHILD_PROCESS_INIT;
>   			struct object_id oid;
> -			struct commit *head =
> -				lookup_commit_reference(the_repository,
> -							&options.orig_head);
>   
>   			argv_array_pushl(&stash.args,
>   					 "stash", "create", "autostash", NULL);
> @@ -1991,17 +1988,14 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>   				    options.state_dir);
>   			write_file(autostash, "%s", oid_to_hex(&oid));
>   			printf(_("Created autostash: %s\n"), buf.buf);
> -			if (reset_head(&head->object.oid, "reset --hard",
> +
> +			/*
> +			 * We might not be on orig_head yet:
> +			 * Make sure to reset w/o switching branches...
> +			 */
> +			if (reset_head(NULL, "reset --hard",
>   				       NULL, RESET_HEAD_HARD, NULL, NULL) < 0)
>   				die(_("could not reset --hard"));
> -			printf(_("HEAD is now at %s"),
> -			       find_unique_abbrev(&head->object.oid,
> -						  DEFAULT_ABBREV));
> -			strbuf_reset(&buf);
> -			pp_commit_easy(CMIT_FMT_ONELINE, head, &buf);
> -			if (buf.len > 0)
> -				printf(" %s", buf.buf);
> -			putchar('\n');
>   
>   			if (discard_index(the_repository->index) < 0 ||
>   				repo_read_index(the_repository) < 0)
> diff --git a/t/t3420-rebase-autostash.sh b/t/t3420-rebase-autostash.sh
> index 867e4e0b17..2ea1909881 100755
> --- a/t/t3420-rebase-autostash.sh
> +++ b/t/t3420-rebase-autostash.sh
> @@ -37,7 +37,6 @@ test_expect_success setup '
>   create_expected_success_am () {
>   	cat >expected <<-EOF
>   	$(grep "^Created autostash: [0-9a-f][0-9a-f]*\$" actual)
> -	HEAD is now at $(git rev-parse --short feature-branch) third commit
>   	First, rewinding head to replay your work on top of it...
>   	Applying: second commit
>   	Applying: third commit
> @@ -48,7 +47,6 @@ create_expected_success_am () {
>   create_expected_success_interactive () {
>   	q_to_cr >expected <<-EOF
>   	$(grep "^Created autostash: [0-9a-f][0-9a-f]*\$" actual)
> -	HEAD is now at $(git rev-parse --short feature-branch) third commit
>   	Applied autostash.
>   	Successfully rebased and updated refs/heads/rebased-feature-branch.
>   	EOF
> @@ -57,7 +55,6 @@ create_expected_success_interactive () {
>   create_expected_failure_am () {
>   	cat >expected <<-EOF
>   	$(grep "^Created autostash: [0-9a-f][0-9a-f]*\$" actual)
> -	HEAD is now at $(git rev-parse --short feature-branch) third commit
>   	First, rewinding head to replay your work on top of it...
>   	Applying: second commit
>   	Applying: third commit
> @@ -70,7 +67,6 @@ create_expected_failure_am () {
>   create_expected_failure_interactive () {
>   	cat >expected <<-EOF
>   	$(grep "^Created autostash: [0-9a-f][0-9a-f]*\$" actual)
> -	HEAD is now at $(git rev-parse --short feature-branch) third commit
>   	Applying autostash resulted in conflicts.
>   	Your changes are safe in the stash.
>   	You can run "git stash pop" or "git stash drop" at any time.
> 
