Return-Path: <SRS0=RpNG=6Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F69C54E8A
	for <git@archiver.kernel.org>; Sun, 10 May 2020 11:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1D7B2098B
	for <git@archiver.kernel.org>; Sun, 10 May 2020 11:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KYe8JAZ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728468AbgEJLOd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 May 2020 07:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726629AbgEJLOd (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 10 May 2020 07:14:33 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE7DC061A0C
        for <git@vger.kernel.org>; Sun, 10 May 2020 04:14:32 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id y24so15479908wma.4
        for <git@vger.kernel.org>; Sun, 10 May 2020 04:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BT6EcHRgVjMHXeVeJlLv/nVXwRvbPoyPEu/k3euSxzI=;
        b=KYe8JAZ+DF4qPTf1Zkpsv86VssGvzUFh1A3YSGGy9v627Hf4G75Mme/FCdQYojSKu/
         Em3IbqNlk5nkh2yMGkUSiFlxb0iO2ubXADzTTvuiTBkuPqQOl95n7S43RZiNjLg8aSoi
         RRs8g/JEickVijrbkOQQs97xJwbd9cTJVDUzt5sGfaPs01RtP9HexTSrV0gPumB4hySE
         FMPhiWHo00zHJb48YymgkCQfiDPedhiDoZ1jk3OPZADsJ+fD//SJD1k/ou7szjXUfvAe
         G/9K9r4R6sfHIbqAMvwKsNnhIKiXNAF10UREzSzOZawRIt3DPWbRbVv1+fXHd+tWVvOp
         LZrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BT6EcHRgVjMHXeVeJlLv/nVXwRvbPoyPEu/k3euSxzI=;
        b=mLYV3qc+mXVs8a0+9GtSOz7XQ7bCYpUuZiZlynDTp1UDcrjdOJmyNASYz/o2czoIJ8
         P+Ci1Z48DZ9RVuG+a9YFA7RSe3R4F1qGIKgRsN9vNPyW8Oo7mNt6cuaPH6wGc+nhcshx
         ozdzAAQWWgH3LPzvufWC1LPJiCUY3WXIG79h2JT3zFzTSzskRgH7poU/VaT1v39i3bDW
         s3oFRS2l96wyYw5q6DBTLdOG/nBN1WWavATpRpkB+TnBDBiAwKVbSSRuGXJcUjqTeQ++
         sez6dd2H6kdHDMBS+0wykuACggtE+BBxg8vep1KL2dc7/LC1ho92Uxc/8vvPHgtVEZvP
         lehw==
X-Gm-Message-State: AGi0PuZWxkZ4p0UhA/iV8E6fRXMaErOfw3+CN2glZ5DhwdXUPI54T+1N
        rBWzi00tO44DOt+lJO+wTup/w4iv
X-Google-Smtp-Source: APiQypJb/XvfOFpJevxKmh6OPye959ARjLQX+cqqaqf5/+8F/zsKllgrMmlBeFuqeKzHijdM3XUvHg==
X-Received: by 2002:a1c:8148:: with SMTP id c69mr16217250wmd.144.1589109271092;
        Sun, 10 May 2020 04:14:31 -0700 (PDT)
Received: from [192.168.0.104] (atoulouse-654-1-328-227.w86-199.abo.wanadoo.fr. [86.199.215.227])
        by smtp.gmail.com with ESMTPSA id o203sm4741690wme.12.2020.05.10.04.14.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 May 2020 04:14:30 -0700 (PDT)
Subject: Re: [PATCH v2 2/5] rebase -i: support --committer-date-is-author-date
To:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <20200407141125.30872-1-phillip.wood123@gmail.com>
 <20200429102521.47995-1-phillip.wood123@gmail.com>
 <20200429102521.47995-3-phillip.wood123@gmail.com>
From:   Alban Gruin <alban.gruin@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <83643a7f-ad5c-b1a0-0936-e32340cf259f@gmail.com>
Date:   Sun, 10 May 2020 13:14:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20200429102521.47995-3-phillip.wood123@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

Thank you for continuing this work.

Le 29/04/2020 à 12:25, Phillip Wood a écrit :
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
> 
> As part of the on-going effort to retire the apply rebase backend teach
> the merge backend how to handle --committer-date-is-author-date.
> 
> Original-patch-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  Documentation/git-rebase.txt           | 10 +++--
>  builtin/rebase.c                       | 16 ++++---
>  sequencer.c                            | 60 +++++++++++++++++++++++++-
>  sequencer.h                            |  1 +
>  t/t3422-rebase-incompatible-options.sh |  1 -
>  t/t3436-rebase-more-options.sh         | 56 ++++++++++++++++++++++++
>  6 files changed, 133 insertions(+), 11 deletions(-)
> 
> -%<-
>
> diff --git a/sequencer.c b/sequencer.c
> index 6fd2674632..3bb80d7414 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -149,6 +149,7 @@ static GIT_PATH_FUNC(rebase_path_refs_to_delete, "rebase-merge/refs-to-delete")
>   * command-line.
>   */
>  static GIT_PATH_FUNC(rebase_path_gpg_sign_opt, "rebase-merge/gpg_sign_opt")
> +static GIT_PATH_FUNC(rebase_path_cdate_is_adate, "rebase-merge/cdate_is_adate")
>  static GIT_PATH_FUNC(rebase_path_orig_head, "rebase-merge/orig-head")
>  static GIT_PATH_FUNC(rebase_path_verbose, "rebase-merge/verbose")
>  static GIT_PATH_FUNC(rebase_path_quiet, "rebase-merge/quiet")
> @@ -872,6 +873,22 @@ static char *get_author(const char *message)
>  	return NULL;
>  }
>  
> +static const char *author_date_from_env_array(const struct argv_array *env)
> +{
> +	int i;
> +	const char *date;
> +
> +	for (i = 0; i < env->argc; i++)
> +		if (skip_prefix(env->argv[i],
> +				"GIT_AUTHOR_DATE=", &date))
> +			return date;
> +	/*
> +	 * If GIT_AUTHOR_DATE is missing we should have already errored out when
> +	 * reading the script
> +	 */
> +	BUG("GIT_AUTHOR_DATE missing from author script");
> +}
> +

Since `GIT_AUTHOR_DATE' is set in read_env_script(), why not set
`GIT_COMMITTER_DATE' in this function too, instead of looping in the env
array just after setting it to get the value back?

>  static const char staged_changes_advice[] =
>  N_("you have staged changes in your working tree\n"
>  "If these changes are meant to be squashed into the previous commit, run:\n"
> @@ -938,6 +955,10 @@ static int run_git_commit(struct repository *r,
>  			     gpg_opt, gpg_opt);
>  	}
>  
> +	if (opts->committer_date_is_author_date)
> +		argv_array_pushf(&cmd.env_array, "GIT_COMMITTER_DATE=%s",
> +				 author_date_from_env_array(&cmd.env_array));
> +
>  	argv_array_push(&cmd.args, "commit");
>  
>  	if (!(flags & VERIFY_MSG))
> @@ -1321,7 +1342,6 @@ static int try_to_commit(struct repository *r,
>  
>  	if (parse_head(r, &current_head))
>  		return -1;
> -

Nit: don't remove this empty line?

>  	if (flags & AMEND_MSG) {
>  		const char *exclude_gpgsig[] = { "gpgsig", "gpgsig-sha256", NULL };
>  		const char *out_enc = get_commit_output_encoding();

Cheers,
Alban

