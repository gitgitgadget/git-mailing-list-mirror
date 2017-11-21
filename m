Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50BA92036D
	for <e@80x24.org>; Tue, 21 Nov 2017 19:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751309AbdKUTZg (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 14:25:36 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:46689 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751154AbdKUTZf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 14:25:35 -0500
Received: by mail-it0-f66.google.com with SMTP id 187so1578349iti.5
        for <git@vger.kernel.org>; Tue, 21 Nov 2017 11:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Kr2vDYlTS12ds65cRHVkcctHrOnoKV60AJCkdXAT2OY=;
        b=mDcl8rZqu6OaQIJlMCiydg1KmMOOCk4vLxj8TLcE5VI88VUKqrqjkvEWEjDzQxazyB
         uHMUmU8fT9n/ruEN03LkW3YphGbgEZoCdAbNcwNYbqGm98jyUoNoVtTlhGI59dPDqvRL
         WOmQWzqpF/OTOR3fGwveeEjCKv5TmabNd9UY7bNIIhgrM9zTZKqntQQY6F8SVG21swX5
         8V1FQf8+mXgAA+SZmf1WlJTliP9dpu7QnrFGUlWqQVSVOw/YpOXxfM+ZDItbTV0Npr6Y
         LgHM9onIcYzrmI/4/i4uzycXqyyw7aV3yJ3X2uG4PK48upuNDBsUVvZuvVpibJ2iGver
         9jfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Kr2vDYlTS12ds65cRHVkcctHrOnoKV60AJCkdXAT2OY=;
        b=TBBOt3VgUA8AFnMtLtAACC2h1hgvWkRiwAhlwEirfE2LvxYyV6qpiRVEktt6NxiqdX
         4JGUAHoWw9rdM8mlS6HCFcNRzEab+tGLrno0yUlnUZ0jQBaSo3lc5Abvm5J0Oj45q4EN
         xpZc5C14fW/RvNNmFOwqfysTRDVoq2zN4rZ/uD/ulVrSV8rXzgqATQqGRiT4gruPtjWm
         +0mSCZxrWpE+O0fS4bxC+hF17TRldKeMVXXNEEg553TXvBd3q7zgeyzNL8TV17JOLzYj
         Ad0amnRTZIea68Ddw3ToMkR6dTS3LhqTzRDlEauyKQeVejj5qcG5ur4iEl1KauVcvQ5L
         /TUA==
X-Gm-Message-State: AJaThX55Fpd7auEyoNMF5gIXwAyP/yTTFxqBbQrR0+BO8CztFgitm2Ue
        fQW65Fi5WfSH6urHGLHMWuU=
X-Google-Smtp-Source: AGs4zMaftimQvbKRQwuxm4hK3GsI/zTE69ypXl4pVoaBaLI+Ncj/tBI/TwZSvECE+Xy5+xlXX/TBpw==
X-Received: by 10.36.116.214 with SMTP id o205mr3321694itc.126.1511292334864;
        Tue, 21 Nov 2017 11:25:34 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id z188sm997819itb.28.2017.11.21.11.25.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Nov 2017 11:25:34 -0800 (PST)
Date:   Tue, 21 Nov 2017 11:25:32 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] notes: correct 'git notes prune' options to '[-n] [-v]'
Message-ID: <20171121192532.GF3429@aiede.mtv.corp.google.com>
References: <alpine.LFD.2.21.1711211414290.5204@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1711211414290.5204@localhost.localdomain>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Robert P. J. Day wrote:

> Currently, 'git notes prune' in man page and usage message
> incorrectly lists options as '[-n | -v]', rather than '[-n] [-v]'.
>
> Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>
> ---

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Thanks.

> diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
> index 43677297f..e8dec1b3c 100644
> --- a/Documentation/git-notes.txt
> +++ b/Documentation/git-notes.txt
> @@ -18,7 +18,7 @@ SYNOPSIS
>  'git notes' merge --commit [-v | -q]
>  'git notes' merge --abort [-v | -q]
>  'git notes' remove [--ignore-missing] [--stdin] [<object>...]
> -'git notes' prune [-n | -v]
> +'git notes' prune [-n] [-v]
>  'git notes' get-ref
> 
> 
> diff --git a/builtin/notes.c b/builtin/notes.c
> index d7754db14..892e37a03 100644
> --- a/builtin/notes.c
> +++ b/builtin/notes.c
> @@ -33,7 +33,7 @@ static const char * const git_notes_usage[] = {
>  	N_("git notes merge --commit [-v | -q]"),
>  	N_("git notes merge --abort [-v | -q]"),
>  	N_("git notes [--ref <notes-ref>] remove [<object>...]"),
> -	N_("git notes [--ref <notes-ref>] prune [-n | -v]"),
> +	N_("git notes [--ref <notes-ref>] prune [-n] [-v]"),
>  	N_("git notes [--ref <notes-ref>] get-ref"),
>  	NULL
>  };
> 
