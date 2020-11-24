Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BEAAC63777
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 17:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0704D20643
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 17:22:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mR6Bylfb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389846AbgKXRWo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 12:22:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726929AbgKXRWn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 12:22:43 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6BCC0613D6
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 09:22:42 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id b144so6881234qkc.13
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 09:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OhSkyF9H2yPjsyhCBTF1HBl0qTbDqPNZNrT6SSKaN3Q=;
        b=mR6Bylfb6vFXMcn6BL6iudJDVeiQcRsmxPovRqOyoSgw6Klg0DKoXqfhdW+cg9HAxe
         mH0NvVacyZRxnDVMus70ZbnfDIN5n38tR/Sqs7Hh6oKSB8gf+q6PjZOD7ROPXWezQWHD
         2NWDbmKI9mt3m+WzQKRDDmIdn8/GnlyktLpA8w+o2aG5+OVQxcR3W004OzqojYZ3KQpR
         j5/cl25zhQoaXIwvddMtBQYtVN0kU9kfnzdbMmMVvwVh/N/R6Fk1F7nWqN769LyxbKMI
         l2DitXyjS4qITDXj+5myNUyHUw34eHG8C2C5vaFWhmZxXKbOSoTQxezR55HBF2t0ytXL
         XKLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OhSkyF9H2yPjsyhCBTF1HBl0qTbDqPNZNrT6SSKaN3Q=;
        b=OmWk0DhHVAastguGEe6dsrAde8SZv1e9frTBsdVyQSgp3QWHAEbVeOiXAW45f115Ua
         YlhkL605fL7TnkGXXPb7QmaMLnaab8627QWb5l97ODiczOkVIUcqx1IYgQtCahNRrDE5
         a0yaQk/MjrAHcb8mu8id2fvTRRy4bLc7aTo1gfm1BXuB8cQO5XtzKhzW0nD9jN1S0Dzi
         rbeuMtPNce45FrqZ9ECUoh66ebgFWZ6gcNmUZ5pl7YylDMZBsN/WgVur2G656U1Ew+3B
         3/Cp5HaaP/0PQAg80q/F+lSD9Ac/3nTihWq05+6QCEAbeb5KQuXFJN9eShpyLE2b9Yf9
         vfxw==
X-Gm-Message-State: AOAM530xZYU5kfrIEHZPIwrUdrDSkazoTHO7lCcXZSw94RTRJ4oLo3eR
        ZoowNXlR0EN+DxLeU6xlFaU=
X-Google-Smtp-Source: ABdhPJzENgLStniJMqpeIES7FjmffwbMHmKCc9LrYCrBhrSZgaf1pzYEEL0ncTlQCIXmC70QZd+zsQ==
X-Received: by 2002:a05:620a:148d:: with SMTP id w13mr5480362qkj.299.1606238561365;
        Tue, 24 Nov 2020 09:22:41 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id b64sm13309661qkg.19.2020.11.24.09.22.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2020 09:22:40 -0800 (PST)
Subject: Re: [PATCH 1/1] maintenance: fix a SEGFAULT when no repository
To:     Rafael Silva <rafaeloliveira.cs@gmail.com>, git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>
References: <20201124164405.29327-1-rafaeloliveira.cs@gmail.com>
 <20201124164405.29327-2-rafaeloliveira.cs@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <1bfd84da-5b74-be10-fc2c-dee80111ee2d@gmail.com>
Date:   Tue, 24 Nov 2020 12:22:40 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:84.0) Gecko/20100101
 Thunderbird/84.0
MIME-Version: 1.0
In-Reply-To: <20201124164405.29327-2-rafaeloliveira.cs@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/24/2020 11:44 AM, Rafael Silva wrote:
> The "git maintenance run" and "git maintenance start" commands holds a
> file-based lock at the .git/maintenance.lock and .git/schedule.lock
> respectively. These locks are used to ensure only one maintenance process
> is executed at the time as both operations involves writing data into
> the git repository.
> 
> The path to the lock file is built using the "the_repository->objects->odb->path"
> that results in SEGFAULT when we have no repository available as
> "the_repository->objects->odb" is set to NULL.
> 
> Let's teach the maintenance_run_tasks() and update_background_schedule() to return
> an error and fails the command when we have no repository available.

Thank you for noticing this problem, and for a quick fix.

While I don't necessarily have a problem with this approach, perhaps
it would be more robust to change the options in git.c to require a
GIT_DIR, as in this diff?

-- >8 --

diff --git a/git.c b/git.c
index 1cab64b5d1..c3dabd2553 100644
--- a/git.c
+++ b/git.c
@@ -530,7 +530,7 @@ static struct cmd_struct commands[] = {
        { "ls-tree", cmd_ls_tree, RUN_SETUP },
        { "mailinfo", cmd_mailinfo, RUN_SETUP_GENTLY | NO_PARSEOPT },
        { "mailsplit", cmd_mailsplit, NO_PARSEOPT },
-       { "maintenance", cmd_maintenance, RUN_SETUP_GENTLY | NO_PARSEOPT },
+       { "maintenance", cmd_maintenance, RUN_SETUP | NO_PARSEOPT },
        { "merge", cmd_merge, RUN_SETUP | NEED_WORK_TREE },
        { "merge-base", cmd_merge_base, RUN_SETUP },
        { "merge-file", cmd_merge_file, RUN_SETUP_GENTLY },

-- >8 --

If the above code change fixes your test (below), then that would
probably be a safer change.

The reason to use RUN_SETUP_GENTLY was probably due to some thought
of modifying the background maintenance schedule without being in a
Git repository. However, we currently run the [un]register logic
inside of the stop|start subcommands, so a GIT_DIR is required there,
too.

> diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> index d9e68bb2bf..bb3556888d 100755
> --- a/t/t7900-maintenance.sh
> +++ b/t/t7900-maintenance.sh
> @@ -441,4 +441,9 @@ test_expect_success 'register preserves existing strategy' '
>  	test_config maintenance.strategy incremental
>  '
>  
> +test_expect_success 'run and start command fails when no git repository' '
> +	test_must_fail git -C /tmp/ maintenance run &&
> +	test_must_fail git -C /tmp/ maintenance start
> +'
> +
>  test_done

Thanks,
-Stolee

