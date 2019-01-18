Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE8141F453
	for <e@80x24.org>; Fri, 18 Jan 2019 23:18:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730013AbfARXSQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 18:18:16 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40974 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729903AbfARXSQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 18:18:16 -0500
Received: by mail-wr1-f66.google.com with SMTP id x10so16971713wrs.8
        for <git@vger.kernel.org>; Fri, 18 Jan 2019 15:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=q5fKjctpu98FUxj5l3KFMjCiTEox1ITdne0OIirSPf4=;
        b=fHrlX/27jqtzL6f7h0vKDxT7IVWm1IFM4NGpFXGp+RcVSg2EA5FjLs+tPD3GTAQu+s
         WqDWLUzb7n3WuzPdjPXdDeXdJ91yyz4N191SgF4kEfsSNM93N0hF+lkgtfIVl7aWkYZt
         9ts5WJC2IQfGV/rV5irh+Mxcdi0eP3zD8Ckzdvq694N7lfenSMPgVXqk13TCNrTDsZoR
         n8FHabDlRIg2oLxxjOp7PVsU23C2UBYsyJ4+OM3kiE99QsiBN/LqZy9h4Kt8zjb5dYN+
         Z2uKUHeDvGKCUyQDzL5SZeahoQnol/ISbRZXeaQNVxg5a2L7IsgFzGqH3XawL48/y+AD
         kE4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=q5fKjctpu98FUxj5l3KFMjCiTEox1ITdne0OIirSPf4=;
        b=R83zQUXsfl3xe1LpT0xXFXlgjI6s+HOThxoVkBiILARUqR5i8PYPUyJ1vcWpyj2GAV
         3Bdxx/a3zoSXPb/vQrEe4VV1i679T8ZMKxhM1XC/U4ceFfXwjkf7JHDpBAHh2XKpABTr
         jnogJF8sAbE5jIJhs3hfUVya6WGfuCjojp/ttgN2FNebJk+b/vVLD9DDoJ447h6KXj14
         qBgkK0nBDcGfJ+cdZTaSY43Yd21yBC0Kz4cYp2afeTVt9JOWZztx9o+m0WJGk9hWn20/
         II+vmEg7MKazmqCO1LpE+SKMB4YU15HmhMTGhCABTVaGYpNKshg3s2oVDM6JhuwT0F67
         B3vg==
X-Gm-Message-State: AJcUukdo+ySq0ccbgcTWuYQTXD3wi47KmPdDlJHtB4XsBZcmFMS4Efjm
        ZEZb4L20DcP0RwKnhmGi4U4=
X-Google-Smtp-Source: ALg8bN6P4cgGkPONIBQNew8Dj1q/YEapPSJu+O4I83gTvYRuVP5od9qf9qf592EJizbUe635z0mL2A==
X-Received: by 2002:adf:9f10:: with SMTP id l16mr19144926wrf.206.1547853493679;
        Fri, 18 Jan 2019 15:18:13 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id x15sm95900617wrs.27.2019.01.18.15.18.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 18 Jan 2019 15:18:12 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] git-submodule: abort if core.worktree could not be set correctly
References: <20190118215519.107700-1-sbeller@google.com>
Date:   Fri, 18 Jan 2019 15:18:11 -0800
In-Reply-To: <20190118215519.107700-1-sbeller@google.com> (Stefan Beller's
        message of "Fri, 18 Jan 2019 13:55:19 -0800")
Message-ID: <xmqqlg3himh8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> 74d4731da1f (submodule--helper: replace connect-gitdir-workingtree by
> ensure-core-worktree, 2018-08-13) forgot to exit the submodule operation
> if the helper could not ensure that core.worktree is set correctly.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  git-submodule.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 5e608f8bad3..02a0d728174 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -548,7 +548,7 @@ cmd_update()
>  	do
>  		die_if_unmatched "$quickabort" "$sha1"
>  
> -		git submodule--helper ensure-core-worktree "$sm_path"
> +		git submodule--helper ensure-core-worktree "$sm_path" || exit 1

Good to have more places check errors from underlying command.

Thanks.

Out of curiousity, was this found by code inspection, or was there a
real-world breakage episode?

