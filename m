Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D02251F453
	for <e@80x24.org>; Mon, 28 Jan 2019 18:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbfA1SZT (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Jan 2019 13:25:19 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52409 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727100AbfA1SZS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jan 2019 13:25:18 -0500
Received: by mail-wm1-f65.google.com with SMTP id m1so15088930wml.2
        for <git@vger.kernel.org>; Mon, 28 Jan 2019 10:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=0XxsYzk9HBO6VVo0d/G1A1BaqEf8VUA8eON0s2QPvl4=;
        b=ZOx+2ul7aSuxfUR6TIDylteluGPRxyZoJqOIBKMLy+PdYnuBPiV6b3vw4bVlMibVZh
         C8ZnTe91/sFy8HbKkw7jAzwU+JruzPEwXgREfKEbVCIXeQKJ2IWXETpVMsEPRyIlz/nT
         /37ne0EAsHqqV8ln3JEhm4ZHLNxEd7+ah3rCGUsTG+r1G4C8dt8kpU/kJZSDR9FIh1lp
         IBrQOrM7uvP0G4iQxURelX62m58yNYst2R2giq97AhC4qcu/Xo9CVC7yNOEEuBSX+D3I
         JvPMJmYssfDSDayHTBar4wnMvYnrYHKnQW9R9SIHOEj1+9iD7pYdb41Sv2rxVi2hBJUI
         9N8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=0XxsYzk9HBO6VVo0d/G1A1BaqEf8VUA8eON0s2QPvl4=;
        b=e0eUXEwHUqn+XdbrWsK6CaUlwH2jhPVL1ZBGJPoHy/WwpY7FQkfxJVIW52PabOt1CF
         0jy1kSHctGPWY26QN2l2VNnOpGATXJUzyANyktdPs/Tm6xllco3KOvUfxwal1CkyvC0h
         UlGuNNhVBbAtQsCvpb4HLyjNzvhu3dkPXEjHOQerKscF8J9KlmJ/lAsNyBHoFVRqzw/g
         uw+d6tq9vmu98q/mlRWOiXjNBY/V9NfO5FnXhjk/45qXzUgTWJhLRz2Z0yls6b29fQ54
         hCnbzJzFEMf2gb1ch9FESc8XQ1NChrn76rztW4zgdIlKRMnp2vs7YF1RSExehR2Gs9Jk
         HQ0w==
X-Gm-Message-State: AJcUukdpvWZIPgdrP7Qq7I6CERQGuqjRkHbtP5KuI7+auWCaNhAlozy+
        uIsmwkvUc6pzhgjZp1S96YQ=
X-Google-Smtp-Source: ALg8bN5Da7SwSzj8LKqoz3SErkIk+IWg3G5wNDNF6PrJW8I02CuLzwflumhZ5Tdq8xHll4leSIkGkQ==
X-Received: by 2002:a7b:ce8e:: with SMTP id q14mr19179947wmj.10.1548699915791;
        Mon, 28 Jan 2019 10:25:15 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id t4sm89141816wrb.64.2019.01.28.10.25.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 10:25:15 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] implicit interactive rebase: don't run sequence editor
References: <20190128102756.19152-1-phillip.wood@talktalk.net>
Date:   Mon, 28 Jan 2019 10:25:14 -0800
In-Reply-To: <20190128102756.19152-1-phillip.wood@talktalk.net> (Phillip
        Wood's message of "Mon, 28 Jan 2019 10:27:56 +0000")
Message-ID: <xmqq8sz4bpx1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood@talktalk.net> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> If GIT_SEQUENCE_EDITOR is set then rebase runs it when executing
> implicit interactive rebases which are supposed to appear
> non-interactive to the user. Fix this by setting GIT_SEQUENCE_EDITOR=:
> rather than GIT_EDITOR=:. A couple of tests relied on the old behavior
> so they are updated to work with the new regime.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---

Good eyes, and an excellent execution to override the more specific
one ;-)

>  builtin/rebase.c                   |  5 +++--
>  git-legacy-rebase.sh               |  4 ++--
>  t/t3404-rebase-interactive.sh      |  5 +++++
>  t/t3430-rebase-merges.sh           |  2 +-
>  t/t7505-prepare-commit-msg-hook.sh | 10 +++++-----
>  5 files changed, 16 insertions(+), 10 deletions(-)
>
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 00de70365e..7c11b4ac7f 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -354,7 +354,8 @@ static int run_specific_rebase(struct rebase_options *opts)
>  		argv_array_pushf(&child.env_array, "GIT_CHERRY_PICK_HELP=%s",
>  				 resolvemsg);
>  		if (!(opts->flags & REBASE_INTERACTIVE_EXPLICIT)) {
> -			argv_array_push(&child.env_array, "GIT_EDITOR=:");
> +			argv_array_push(&child.env_array,
> +					"GIT_SEQUENCE_EDITOR=:");
>  			opts->autosquash = 0;
>  		}
>  
> @@ -475,7 +476,7 @@ static int run_specific_rebase(struct rebase_options *opts)
>  	if (is_interactive(opts) &&
>  	    !(opts->flags & REBASE_INTERACTIVE_EXPLICIT)) {
>  		strbuf_addstr(&script_snippet,
> -			      "GIT_EDITOR=:; export GIT_EDITOR; ");
> +			      "GIT_SEQUENCE_EDITOR=:; export GIT_SEQUENCE_EDITOR; ");
>  		opts->autosquash = 0;
>  	}
