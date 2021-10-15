Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6980BC433F5
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 17:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45458600CD
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 17:18:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242130AbhJORUG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Oct 2021 13:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238020AbhJORUF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Oct 2021 13:20:05 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB85C061570
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 10:17:58 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id 187so8894885pfc.10
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 10:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=R1Fg3Tzt6R+gIFaO6FQA+ywgnYI0Acz1N3AqjqZkdrE=;
        b=QElTyUydsyYIlaBjrwfvOSHjqMs0yyuQnc+y2HcOhBmVyAs7ze+tokP50wOtDlEts5
         VEEakXw5KaIFgnVwtK4zjKLQUQw5C17KA/lKO8HngKN4lsd0u/2Lzn2IpxTRiYLST+Di
         LX+APuybAuUYh5qrRrd8Zd6DTSi3eOUI89o1072OdwhD0/sEi5c1Rkfjvc0kzmp1Vqbt
         tVX/EH9c0d5uK8YUXmySd4YcbyB013BXsUo8eY5oSYP9gc+7QiV7lC4GF24ATNvJ8j5e
         HAE+/5kvoCvxGPGF9uBw8yMuftRUL9AKfzpuEeVZdkBNRdtl9XRlBayQlWSqW/M3unqZ
         gyng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=R1Fg3Tzt6R+gIFaO6FQA+ywgnYI0Acz1N3AqjqZkdrE=;
        b=3BOEwJtESt2JNTbWkN031Bs78ExQylQR3mroUaSOW4GBBevbHIBbFcX0dFdmAHbFUR
         G+JQheq5pt8fjAErIt8M1k9p9yVA/4zQsl8E2HgFBS49vzJnwjRs26CensPXaoP3f2SS
         qYDgp1xA6Fed14rHWazepeg1kU9PHbV+BwgPySc0LHUVMmidr8uJCULtbhYf9AkS4uQZ
         t8oRixHbs4cRGlX/LvLuVEYVHGSQ4/RpUyOraRhvuf+RLaFLUWJaLfJM7pNCcmlMrciy
         woybGtCrzqRYUSbJILSIpFW5ggJcViQKcNjIEmsAvMaSf81jPlP5PZ1IiQlvRWGa9QK7
         lGwQ==
X-Gm-Message-State: AOAM531x4eLTRSZhv7W/ycifXg8AGl/L/+9t5OJMo2C8MERBcKNlJS1f
        dOP+lvqRPnOnhHDPA5gyO/++Yw==
X-Google-Smtp-Source: ABdhPJzASTBDaMeXCATch5Jtn0wz9WSNhAhq4qD6SyA040/rBJxrdXtSAzY18xmqf9I097InuBX4iQ==
X-Received: by 2002:a63:5914:: with SMTP id n20mr9969149pgb.164.1634318277878;
        Fri, 15 Oct 2021 10:17:57 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cc2f:afb0:ab09:f218])
        by smtp.gmail.com with ESMTPSA id y24sm5359103pfo.69.2021.10.15.10.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 10:17:57 -0700 (PDT)
Date:   Fri, 15 Oct 2021 10:17:52 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v2 11/13] read-cache: convert post-index-change to use
 hook.h
Message-ID: <YWm3wF4GOWAua2MZ@google.com>
References: <cover-v2-00.13-00000000000-20211015T093918Z-avarab@gmail.com>
 <patch-v2-11.13-58b7689e4af-20211015T093918Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v2-11.13-58b7689e4af-20211015T093918Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 15, 2021 at 11:43:39AM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> 
> Move the post-index-change hook away from run-command.h to and over to
> the new hook.h library.
> 
> This removes the last direct user of "run_hook_ve()" outside of
> run-command.c ("run_hook_le()" still uses it). So we can make the
> function static now. A subsequent commit will remove this code
> entirely when "run_hook_le()" itself goes away.

\o/

> 
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

Reviewed-by: Emily Shaffer <emilyshaffer@google.com>

> ---
>  read-cache.c  | 10 +++++++---
>  run-command.c |  2 +-
>  run-command.h |  1 -
>  3 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/read-cache.c b/read-cache.c
> index 9773118d078..84cc3d88196 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -3087,6 +3087,7 @@ static int do_write_locked_index(struct index_state *istate, struct lock_file *l
>  {
>  	int ret;
>  	int was_full = !istate->sparse_index;
> +	struct run_hooks_opt hook_opt = RUN_HOOKS_OPT_INIT;
>  
>  	ret = convert_to_sparse(istate, 0);
>  
> @@ -3115,9 +3116,12 @@ static int do_write_locked_index(struct index_state *istate, struct lock_file *l
>  	else
>  		ret = close_lock_file_gently(lock);
>  
> -	run_hook_le(NULL, "post-index-change",
> -			istate->updated_workdir ? "1" : "0",
> -			istate->updated_skipworktree ? "1" : "0", NULL);
> +	strvec_pushl(&hook_opt.args,
> +		     istate->updated_workdir ? "1" : "0",
> +		     istate->updated_skipworktree ? "1" : "0",
> +		     NULL);
> +	run_hooks_oneshot("post-index-change", &hook_opt);
> +
>  	istate->updated_workdir = 0;
>  	istate->updated_skipworktree = 0;
>  
> diff --git a/run-command.c b/run-command.c
> index 7ef5cc712a9..d92e670c8ed 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -1323,7 +1323,7 @@ int async_with_fork(void)
>  #endif
>  }
>  
> -int run_hook_ve(const char *const *env, const char *name, va_list args)
> +static int run_hook_ve(const char *const *env, const char *name, va_list args)
>  {
>  	struct child_process hook = CHILD_PROCESS_INIT;
>  	const char *p;
> diff --git a/run-command.h b/run-command.h
> index 49878262584..3fa7454cf8a 100644
> --- a/run-command.h
> +++ b/run-command.h
> @@ -239,7 +239,6 @@ int run_command(struct child_process *);
>   */
>  LAST_ARG_MUST_BE_NULL
>  int run_hook_le(const char *const *env, const char *name, ...);
> -int run_hook_ve(const char *const *env, const char *name, va_list args);
>  
>  /*
>   * Trigger an auto-gc
> -- 
> 2.33.1.1338.g20da966911a
> 
