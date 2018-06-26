Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63C3F1F597
	for <e@80x24.org>; Tue, 26 Jun 2018 20:15:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933368AbeFZUPg (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 16:15:36 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:38689 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932218AbeFZUPf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 16:15:35 -0400
Received: by mail-wr0-f195.google.com with SMTP id e18-v6so18472788wrs.5
        for <git@vger.kernel.org>; Tue, 26 Jun 2018 13:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=150VXKp7V+qLiJYRKbogiSVq09uxAsUjtxpHAmwcgME=;
        b=arA9nrqdXSJakay5PoBBePe5Do+6ACYQt7gSd+1uAVdbXngUwlG1erJKEx5dtGInAc
         U/40gTduymDEMAXgbcrpxSTcDM46peogNsGUIiC6pECsPYTWHv1T+ByQ/E7Bu81jOq9f
         A3t4dro9tnXyLHhTXpbTaVPhkqhzWfAMUXTwvYAHdlhJhMx2mWXPoiOMYTRiFhmQZblz
         FBCYd15KucIST35rogkKqKXNt0EE+Psm5x8YX8k/F1VupoxXhbHBgAQm+CZtMJXzE4vU
         RWjFiILOFH5qR2+6TxJUaxkLJ8ZhKUm/ADZGsadmO+PHCJBtKhBJFxUEcYmpMBt3WNvD
         w1nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=150VXKp7V+qLiJYRKbogiSVq09uxAsUjtxpHAmwcgME=;
        b=a06iPACesJbPJsaeuhbvnFLannJn5mW5k6DQrP/pEtDoE6h3CFggOWqusZ430lh+s4
         q3hFqXNxf60CCPJE9v3x7CUkuAu1muAtXRWTsF1bu82tNaFVVVsP9imp3B+fBxrVtOL7
         Fkh9XZBd/q8HuOB72rEYCSyF6Sd+SyL8zaH+mDhEqgb2yBAsLQeMqtkyVqenRWH7QfcB
         YzcW5+dg3/+hRekGCgFdjGRaZ30VKgAdf9yi6b5vG9uO1WcBDv3XTg3PpwDlp627yPlm
         gnvvGdwMcqZoUrIfa4l2VwqJ4oayNc/Aehfp8SYgueReSbl9c+NeVRiAstRWYx2+Iqaq
         AxEQ==
X-Gm-Message-State: APt69E3RlFeN9EuvsoTzqPX3znYioiDc7OofAX+HiGEU7mBolCtb+V62
        B92r9nMfimpuF2MRzcmq2GA=
X-Google-Smtp-Source: AAOMgpeihRgwyqtF+jMqdAwsrFlGZwWOhQY4TjDxrkXUCeFyDxm0nXnALh16+1wMkaGj0E8nYmiTEw==
X-Received: by 2002:adf:fb43:: with SMTP id c3-v6mr2780790wrs.32.1530044134365;
        Tue, 26 Jun 2018 13:15:34 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id e63-v6sm3964289wma.46.2018.06.26.13.15.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jun 2018 13:15:33 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Antonio Ospite <ao2@ao2.it>
Cc:     git@vger.kernel.org, Brandon Williams <bmwill@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 5/6] submodule-config: pass repository as argument to config_from_gitmodules
References: <20180626104710.9859-1-ao2@ao2.it>
        <20180626104710.9859-6-ao2@ao2.it>
Date:   Tue, 26 Jun 2018 13:15:33 -0700
In-Reply-To: <20180626104710.9859-6-ao2@ao2.it> (Antonio Ospite's message of
        "Tue, 26 Jun 2018 12:47:09 +0200")
Message-ID: <xmqq7emljod6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Antonio Ospite <ao2@ao2.it> writes:

> Generlize config_from_gitmodules to accept a repository as an argument.

generalize???

>
> This is in preparation to reuse the function in repo_read_gitmodules in
> order to have a single point where the '.gitmodules' file is accessed.
>
> Signed-off-by: Antonio Ospite <ao2@ao2.it>
> ---
>  submodule-config.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/submodule-config.c b/submodule-config.c
> index cd1f1e06a..602c46af2 100644
> --- a/submodule-config.c
> +++ b/submodule-config.c
> @@ -680,10 +680,10 @@ void submodule_free(struct repository *r)
>   * Runs the provided config function on the '.gitmodules' file found in the
>   * working directory.
>   */
> -static void config_from_gitmodules(config_fn_t fn, void *data)
> +static void config_from_gitmodules(config_fn_t fn, struct repository *repo, void *data)
>  {
> -	if (the_repository->worktree) {
> -		char *file = repo_worktree_path(the_repository, GITMODULES_FILE);
> +	if (repo->worktree) {
> +		char *file = repo_worktree_path(repo, GITMODULES_FILE);
>  		git_config_from_file(fn, file, data);
>  		free(file);
>  	}
> @@ -714,7 +714,7 @@ void fetch_config_from_gitmodules(int *max_children, int *recurse_submodules)
>  		.max_children = max_children,
>  		.recurse_submodules = recurse_submodules
>  	};
> -	config_from_gitmodules(gitmodules_fetch_config, &config);
> +	config_from_gitmodules(gitmodules_fetch_config, the_repository, &config);
>  }
>  
>  static int gitmodules_update_clone_config(const char *var, const char *value,
> @@ -728,5 +728,5 @@ static int gitmodules_update_clone_config(const char *var, const char *value,
>  
>  void update_clone_config_from_gitmodules(int *max_jobs)
>  {
> -	config_from_gitmodules(gitmodules_update_clone_config, &max_jobs);
> +	config_from_gitmodules(gitmodules_update_clone_config, the_repository, &max_jobs);
>  }
