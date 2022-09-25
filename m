Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22200C04A95
	for <git@archiver.kernel.org>; Sun, 25 Sep 2022 13:59:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbiIYN7Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Sep 2022 09:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbiIYN7V (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Sep 2022 09:59:21 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B44724F1D
        for <git@vger.kernel.org>; Sun, 25 Sep 2022 06:59:20 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id n15so6623434wrq.5
        for <git@vger.kernel.org>; Sun, 25 Sep 2022 06:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=xdIBDWVn2lRhAkoPZy6yXtQy7jjNyq+qIlbA5St5b1E=;
        b=E5RJe2xFQ5UPwZpsVTdm1gjSmKEKq3xYXPOVzvpjvJo4Pvap1F8PkqZruC4EhwlK00
         ji/gMWFC5/XSC92+94f3+dvpkYWEtyAHWbNqzNDmmbWJmCABbzgpWbWGfH5N8c5ZHh4H
         ja9Zgbgk9B++WmfNI5wXw20bJaq2Rl9Qhy1fNsTGnWlmo6OGysp83oIJlTGCKgLs6UJM
         gxMi9KC/ISLDH370LjoXjbGi1hXKHToudNheOF029fpCvf0ZnX1rbtCgNVgOuPnGFQ8J
         gBQQuViBzPmJMTDdZ/iEtHHBNJm/1r8Zj7mgi+LD3yeXVLbgBdIAmMTXnFdYRXpFadKW
         5UNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=xdIBDWVn2lRhAkoPZy6yXtQy7jjNyq+qIlbA5St5b1E=;
        b=fSu+IXRsC89dcgenDIQh5QqyHT0Y65OmEQU+0cpgXJpaooXP6wT6g1ohNMM8IuGifP
         EI2eOoaZqJDkAf8+n1+1bTW307IP5gPngQmTfNb0DwOIR5hZgSw215MWXCDRep/GDlgT
         CzWZct/XMqcSMvuH2ULpKOJfFzsbGnxF/lZru0YAAn5uN7eZP5OIjDlMycjaWRDy7+YF
         FBxCo2t4n7AbmfpBiQNsiQ+StMlH3Qeu/8qaeDGCUI/1fzdhQGEYfn09Xd11tJJnGzUL
         k7Cjxz92Z1W558d/PqRUVoyIvLlZmfDs0dTHKsx0w7WUEHj5ZBDBYY5W66DL3tv6w7BV
         tBPg==
X-Gm-Message-State: ACrzQf0TFVTnHuawnaR8+w/N2qeTJ4thZzuMCiwZemk3SR4z0rcl3FPM
        bN5C7xoU9vfGn7uiyfjpQFU=
X-Google-Smtp-Source: AMsMyM5+FQGMR4mP+FgUZIJYEzg5JX9jxbrH1IWkSakMLiYG3RBYvtXaXDGKX5D8lYU0mvF2Z9/Oow==
X-Received: by 2002:a5d:4041:0:b0:22b:2f26:6355 with SMTP id w1-20020a5d4041000000b0022b2f266355mr10694672wrp.622.1664114358779;
        Sun, 25 Sep 2022 06:59:18 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.144])
        by smtp.gmail.com with ESMTPSA id g21-20020a05600c4c9500b003b476cabf1csm7983216wmp.26.2022.09.25.06.59.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Sep 2022 06:59:18 -0700 (PDT)
Message-ID: <88b194d9-7c78-c12e-1c29-95f768db7772@gmail.com>
Date:   Sun, 25 Sep 2022 14:59:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 4/4] diff-lib: parallelize run_diff_files for submodules
Content-Language: en-GB-large
To:     Calvin Wan <calvinwan@google.com>, git@vger.kernel.org
Cc:     emilyshaffer@google.com,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <20220922232947.631309-1-calvinwan@google.com>
 <20220922232947.631309-5-calvinwan@google.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20220922232947.631309-5-calvinwan@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Calvin

On 23/09/2022 00:29, Calvin Wan wrote:
> During the iteration of the index entries in run_diff_files, whenever
> a submodule is found and needs its status checked, a subprocess is
> spawned for it. Instead of spawning the subprocess immediately and
> waiting for its completion to continue, hold onto all submodules and
> relevant information in a list. Then use that list to create tasks for
> run_processes_parallel. Finished subprocesses pipe their output to
> status_finish which parses it and sets the relevant variables.
> 
> Add config option status.parallelSubmodules to set the maximum number
> of parallel jobs.

I suspect in the future we may want to parallelize other commands for 
submodules in which case a more general name such as submodules.threads 
might be a better choice. The speed up in the cover letter is 
impressive, could this be safely enabled by default?

> index fcf9c85947..c5147a7952 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1468,6 +1468,12 @@ static int git_status_config(const char *k, const char *v, void *cb)
>   		s->detect_rename = git_config_rename(k, v);
>   		return 0;
>   	}
> +	if (!strcmp(k, "status.parallelsubmodules")) {
> +		s->parallel_jobs_submodules = git_config_int(k, v);
> +		if (s->parallel_jobs_submodules < 0)
> +			die(_("status.parallelsubmodules cannot be negative"));

What does a value of zero mean?

> diff --git a/diff-lib.c b/diff-lib.c
> index 2e148b79e6..ec745755fc 100644
> --- a/diff-lib.c
> +++ b/diff-lib.c

> -int run_diff_files(struct rev_info *revs, unsigned int option)
> +int run_diff_files(struct rev_info *revs, unsigned int option, int parallel_jobs)

Another possibility would be to add a member to struct diff_opts, rather 
than changing the function signature here, I'm wondering what the trade 
offs of the two approaches are. Also seeing all the callers from other 
commands being changed made me wonder if they would benefit from 
parallelizing submodules as well. There aren't any tests - could we use 
GIT_TRACE2 to check that we are running the submodule diffs in parallel?

Best Wishes

Phillip
