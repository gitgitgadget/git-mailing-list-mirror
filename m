Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A758C43219
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 22:37:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233684AbhK2WkW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 17:40:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234051AbhK2Wjy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 17:39:54 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D233C126285
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 09:50:58 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id t19so36144268oij.1
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 09:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=tVbBLphu9mUdJtXcVZ2RnH2R3mGH3MuA9JpJs1qyey4=;
        b=CLNtht7zhNw66zi8uvenfzQ/bXD1JCKOe4G2jatg3XojjyzouQc1UcLnrZtmlSZUsO
         2fD9NYK7TebrLllAIev3l18FnI+OFTBMb/4lZvnllyJvVRlNpMlpDcu7oCSiEbFJbi6f
         lji8s6mTohrBJL0YQ7OTBQN7lqM6T7o4fB1115A13t1r7bQT5GKIbP03ZOVimoeZR6mP
         jYi+6qDIBXb7zGotH8o88aNT77LFbjK5zNSZ8JgqDSySF+6+BYyhZV3HmDKQrDCAbE7r
         DbMvjzNDiid3dje9SYioscsdDFjvgIuGQkbDY0DF18SGa97+17ehaQR6uqwF2UL5uG6I
         kl7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tVbBLphu9mUdJtXcVZ2RnH2R3mGH3MuA9JpJs1qyey4=;
        b=XIwNak7mVJq7U5vuZaUKjQr/2P45FejOBdk4Nki3bOps4I5saLxxQGqwYd4pZnkQzr
         XeyNCuY71ecBHaNPbmnheYT/tWQ+T1PgwjBiCwFy9eNA4Ux+OvEy1sJSW2u0AaruXvW/
         YZQEraeXyJc9Je2TxrpTE3Oq1R5MbbkoHw+E52VDwjIv3bXoZxtX7fNE1NlpTEyd1du9
         ssjZQedV8w/OuI1nI8d2UOJPdxLR52VBV+TXWVfCBXNL23prz4ZySnlgNHqN/hB9sEJc
         pIqT4yeoKCtNM7b8LTY/Nshl3XeffavY39/453b0mN505bFkKg4GpniY1jHzRX7jMCnw
         krFw==
X-Gm-Message-State: AOAM530B3i2eJbPJqJ8lkmBC1WUUrTtd5ArzyVt9RUYd62whiLlCkYdX
        ckQocchcL5Z1FEV2xCjWRwg6GfQjR8M=
X-Google-Smtp-Source: ABdhPJz8rS12wRzwjKSVO+eHR2GlkK1P09EcLZ6deIm2Iz/jdurgNIsos07LrTvwHOf/PF8nyadqPA==
X-Received: by 2002:a54:4402:: with SMTP id k2mr8234698oiw.141.1638208257499;
        Mon, 29 Nov 2021 09:50:57 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:3085:654c:eb81:848b? ([2600:1700:e72:80a0:3085:654c:eb81:848b])
        by smtp.gmail.com with ESMTPSA id bh12sm3214620oib.25.2021.11.29.09.50.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Nov 2021 09:50:57 -0800 (PST)
Message-ID: <7d90bf61-59c6-045e-1987-81d50454c260@gmail.com>
Date:   Mon, 29 Nov 2021 12:50:55 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v3 07/11] rebase: do not attempt to remove
 startup_info->original_cwd
Content-Language: en-US
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Philip Oakley <philipoakley@iee.email>
References: <pull.1140.v2.git.git.1637829556.gitgitgadget@gmail.com>
 <pull.1140.v3.git.git.1637966463.gitgitgadget@gmail.com>
 <39b1f3a225ec74a79320503eff04ba47ae4259fd.1637966463.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <39b1f3a225ec74a79320503eff04ba47ae4259fd.1637966463.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/26/2021 5:40 PM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> Since rebase spawns a `checkout` subprocess, make sure we run that from
> the startup_info->original_cwd directory, so that the checkout process
> knows to protect that directory.
> 
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  sequencer.c          | 3 +++
>  t/t2501-cwd-empty.sh | 4 ++--
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index ea96837cde3..b71f7b8a0a6 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -4228,6 +4228,9 @@ static int run_git_checkout(struct repository *r, struct replay_opts *opts,
>  
>  	cmd.git_cmd = 1;
>  
> +	if (startup_info->original_cwd &&
> +	    !is_absolute_path(startup_info->original_cwd))
> +		cmd.dir = startup_info->original_cwd;

I was initially confused by the "!is_absolute_path()" because
it seemed to me like it would be natural to store an absolute
path there, but I see this comment in patch 2:

+	 * For convience, we would like to have the path relative to the
+	 * worktree instead of an absolute path.

So it seems that we won't store it as an absolute path. Is
there any value in this condition, then?

This assignment of cmd.dir to the relative path has a lot
of baked-in knowledge of this variable _and_ the current
state (Git chdir()'d to the root of the worktree). If the
path is always relative, then it should be a BUG() if we
see an absolute path. Also, it seems like we would want
cmd.dir to be a concatenation of the worktree root and the
original_cwd.

Or perhaps I'm being overly cautious and this could all be
resolved with a comment about the expected state of the
working directory and original_cwd. The tests will catch if
any of those expectations change.

Thanks,
-Stolee
