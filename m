Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92192207D6
	for <e@80x24.org>; Tue,  2 May 2017 03:57:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751167AbdEBD5b (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 23:57:31 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35471 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751135AbdEBD53 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 23:57:29 -0400
Received: by mail-pf0-f193.google.com with SMTP id o68so11286827pfj.2
        for <git@vger.kernel.org>; Mon, 01 May 2017 20:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=+07kvmrziPD7qFrt8SGVH20UCxR+8ha7Uowm8dVsm5M=;
        b=WEn8glg4EdGWIofHnm6YPGCyHujh87UFgge6Rsm4rBMKS6PU7tB/weoUEWWkjZf2+N
         f9KbZO9QrwldfJNN9wVlVefKPJiFHAYXPSV7VQXCegQCnI+yDft4GHRVsfzh1J05d+hP
         r+RKq1ZRY+FYtflyZEhRvBhagJiMwH4BcMje7qh2/OPLaweKbDuMzDtt/wLZGIz6lHTf
         tdnqM5mpQbpxC7+6HvzlYjKWicZ7H4Nq2rLRg8xY3TejGppDSzyyOg9vIBoeaCZ6H9Gs
         8Fr54u69yqyCUp85LfFq1rYr7sCL23iyNcrB2XMSi5JzU48iJtymAikuJQm942KdKmb2
         7phA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=+07kvmrziPD7qFrt8SGVH20UCxR+8ha7Uowm8dVsm5M=;
        b=UR1iL7kTHU7DWkPoEUhph2tfZv+R5fsIaFiJ1wLPVEMMh+eblL6NtFqP8TRgUCFEpe
         THsoqtOu5RDNTdM4iHg9+WKgoCtTRQT6nu5LyUmFDcX91ca5ukHb1o5eiwMRM30gQxf2
         sRjjqL9qVzNeUMgQ0I6YMjdATG8RmlvAqB6LzRgGJhL4UC83EBQNailDAlvkwrXKiU3Q
         WVElwwc0D64JrrURMVttLgKHiFkQjuz78ILRgf+wTEHQDHTSSpcRfnGYsire9AQdzpLj
         d+pXzWKYX6tIz8XbEhNl0iD9KrPXA1M9zuGGm3InGUAfCGE+h63LILFpJVmmxfpZy/AA
         t7/Q==
X-Gm-Message-State: AN3rC/6UBECU4/+CFoRDwqEsis/C9f+dbEBD1WWFl2+CkEGIgA0ajH+H
        rXcIvZCj1iGeLA==
X-Received: by 10.99.177.75 with SMTP id g11mr15695538pgp.8.1493697448998;
        Mon, 01 May 2017 20:57:28 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3c5e:d1c1:579c:ef99])
        by smtp.gmail.com with ESMTPSA id t187sm24151182pfb.116.2017.05.01.20.57.28
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 01 May 2017 20:57:28 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 14/25] setup_discovered_git_dir(): help static analysis
References: <cover.1493237937.git.johannes.schindelin@gmx.de>
        <cover.1493387231.git.johannes.schindelin@gmx.de>
        <cbd8e917f1318190d9f979f4cc9b62dcd838bbb0.1493387231.git.johannes.schindelin@gmx.de>
Date:   Mon, 01 May 2017 20:57:27 -0700
In-Reply-To: <cbd8e917f1318190d9f979f4cc9b62dcd838bbb0.1493387231.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Fri, 28 Apr 2017 16:03:22 +0200
        (CEST)")
Message-ID: <xmqq4lx3ewrc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Coverity reported a memory leak in this function. However, it can only
> be called once, as setup_git_directory() changes global state and hence
> is not reentrant.
>
> Mark the variable as static to indicate that this is a singleton.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---

Does something different from what is explained above.  Rebase gotcha?

>  setup.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/setup.c b/setup.c
> index 0320a9ad14c..12efca85a41 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -703,11 +703,16 @@ static const char *setup_discovered_git_dir(const char *gitdir,
>  
>  	/* --work-tree is set without --git-dir; use discovered one */
>  	if (getenv(GIT_WORK_TREE_ENVIRONMENT) || git_work_tree_cfg) {
> +		char *p = NULL;
> +		const char *ret;
> +
>  		if (offset != cwd->len && !is_absolute_path(gitdir))
> -			gitdir = real_pathdup(gitdir, 1);
> +			gitdir = p = real_pathdup(gitdir, 1);
>  		if (chdir(cwd->buf))
>  			die_errno("Could not come back to cwd");
> -		return setup_explicit_git_dir(gitdir, cwd, nongit_ok);
> +		ret = setup_explicit_git_dir(gitdir, cwd, nongit_ok);
> +		free(p);
> +		return ret;
>  	}
>  
>  	/* #16.2, #17.2, #20.2, #21.2, #24, #25, #28, #29 (see t1510) */
