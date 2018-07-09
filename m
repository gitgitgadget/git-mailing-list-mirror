Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EF131F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 21:34:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933115AbeGIVeJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 17:34:09 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55934 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933060AbeGIVeH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 17:34:07 -0400
Received: by mail-wm0-f66.google.com with SMTP id v128-v6so4961627wme.5
        for <git@vger.kernel.org>; Mon, 09 Jul 2018 14:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=a+42wp3YaMvEHpX+boSDI9/l/HzwOo/gBlo1SuVjKiU=;
        b=bKKUb3u2qSyQLtP7Yf04pCB8pHglZPqntIRSbowL46xyYnE+N0HcZ/AOj3aT5Kj1G4
         lLR2i0weBYkz05YbvnyhykxlsHj0RS02bQi/Cusro6Jwos/yWz5o0z/svg6qTjTZOatm
         YvSZjvwOd6kL654md9d8ljHzxdaJNGm/d6t9UlSZ0EDqoaP72/4JuuJXo95EUqaDDic9
         1hfhlP1fh8NYeGs0Lgf4Am3ktRixaYJb+iqInp1o2XV5S4RicBh4avkF+PDhjBcugtEx
         ssKqAmswCjALG9+eqwgG4I+/BFLLRybrqBbMTBAWyvlOKFc7skTT+5B+VhU1YxFBwcpf
         Ujiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=a+42wp3YaMvEHpX+boSDI9/l/HzwOo/gBlo1SuVjKiU=;
        b=hpEK5u1yxKeUoosCbbjeGaBEDyPB2+KwMtJ4bYgEHfvGEQwPbMyEeD02u/FEOJPDXv
         7JAphRgRb07Ag4L+hQBLXXhbo2e+hCrp8n862Bcp0xbHEGFXU0Po3lLZB1VGTG3MHCnS
         QJQ3kJhnew69aQLnBFwJ+1FPdjGGaiCc+yHnJyaXtRNbsfb0yIFtCEI6V62Mx8XMXxy3
         kvJzzcl5LuRNm2RTfpt8+1UXgAgKw+AJJMXQlvRfDI3Ik6z2ghE3/ArS3626wU6aop+r
         TzwNYGozpc/kc++myYlcMZ+50/8U3BoZ3NAIOrQQl2ngW28Y30Dej/qWVXNyKCQSIhlJ
         xj3A==
X-Gm-Message-State: APt69E1bdN3tzMwGvK8SWACVie+0vUQwbms+jVb+5ljwccz6LPeJdIm3
        fvZnhquzByZMS4ITWEZrk3E=
X-Google-Smtp-Source: AAOMgpcNhBfTGTPGQf8QXuX/R5qk6I+C7wztyd8NKzOttLiAp8zoVgzy7ojYYwswG5/EIq7X6DzNOw==
X-Received: by 2002:a1c:9809:: with SMTP id a9-v6mr8447745wme.15.1531172046474;
        Mon, 09 Jul 2018 14:34:06 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id e12-v6sm3973890wrt.29.2018.07.09.14.34.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 14:34:05 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Beat Bolli <dev+git@drbeat.li>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 4/6] sequencer.c: avoid empty statements at top level
References: <20180708144342.11922-1-dev+git@drbeat.li>
        <20180708144342.11922-5-dev+git@drbeat.li>
Date:   Mon, 09 Jul 2018 14:34:05 -0700
In-Reply-To: <20180708144342.11922-5-dev+git@drbeat.li> (Beat Bolli's message
        of "Sun, 8 Jul 2018 16:43:40 +0200")
Message-ID: <xmqqo9fgayb6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Beat Bolli <dev+git@drbeat.li> writes:

> The marco GIT_PATH_FUNC expands to a complete statement including the
> semicolon. Remove two extra trailing semicolons.

Wait a bit.  The observation in the log message and the
implementation of GIT_PATH_FUNC() do not match.

        #define GIT_PATH_FUNC(func, filename) \
                const char *func(void) \
                { \
                        static char *ret; \
                        if (!ret) \
                                ret = git_pathdup(filename); \
                        return ret; \
                }

The code generated does "include semicolon" but that is not why the
caller should place semicolon after the closing parens.  Perhaps
replace "including the semicolon." with something else, like ", and
adding a semicolon after it not only is unnecessary but is wrong."
or soemthing like that?

It is a bit unfortunate that we need to live with a slight uglyness
of the resulting source code, unlike e.g. define_commit_slab() that
can (and must) end with a semicolon, which gives us a more natural
look.  But that is a separate issue.

>
> Signed-off-by: Beat Bolli <dev+git@drbeat.li>
> ---
>  sequencer.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index 5354d4d51e..66e7073995 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -62,12 +62,12 @@ static GIT_PATH_FUNC(rebase_path_done, "rebase-merge/done")
>   * The file to keep track of how many commands were already processed (e.g.
>   * for the prompt).
>   */
> -static GIT_PATH_FUNC(rebase_path_msgnum, "rebase-merge/msgnum");
> +static GIT_PATH_FUNC(rebase_path_msgnum, "rebase-merge/msgnum")
>  /*
>   * The file to keep track of how many commands are to be processed in total
>   * (e.g. for the prompt).
>   */
> -static GIT_PATH_FUNC(rebase_path_msgtotal, "rebase-merge/end");
> +static GIT_PATH_FUNC(rebase_path_msgtotal, "rebase-merge/end")
>  /*
>   * The commit message that is planned to be used for any changes that
>   * need to be committed following a user interaction.
