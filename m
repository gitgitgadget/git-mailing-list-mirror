Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB1041F42D
	for <e@80x24.org>; Tue, 27 Mar 2018 09:01:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751325AbeC0JBc (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Mar 2018 05:01:32 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:40547 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751185AbeC0JBb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Mar 2018 05:01:31 -0400
Received: by mail-qt0-f196.google.com with SMTP id g5so11788532qth.7
        for <git@vger.kernel.org>; Tue, 27 Mar 2018 02:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=r0ZwnqjRZ9nGYBMSoZAhYz0Z80o89uTmDDm1q1+hxec=;
        b=Xzi0uq4eTnhdnNzh229Nf1iFlhN4We2jGVFt4AfmktFDhrS+ncKMl0mSrbatj/wo05
         TAhr6+wsXmF8/0vqohuxRn3YF3NB38HvzijOMAQVg6rJvPtLCWfL+N4Qfek1t5xuFAcA
         E/wvz3RXmrjbTxtWgHQVA5Zj5pRCaUbwzKgVluR3rjR8jfNTVC8l+mH3p8T5PiFHZp4A
         XkQfFtG1B52CqO53yIL7WcZRPPOtii7C0aS0lI1VXHZ64P0VY32dOTBksce+a1l1SQ/f
         P1XXxnVoOZkP4eJiShKi7alZWrcVgc4jGsIyGnyhkVa02kZrB12D1eI9y6joE8ybL4QQ
         RxwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=r0ZwnqjRZ9nGYBMSoZAhYz0Z80o89uTmDDm1q1+hxec=;
        b=l0ReTg4tqMsfuFvJvVOkw6Dv6P3nrBRWgvpc+JDy5BBME6e8uSkRjMHAA7d22ZxXlO
         MrBV0RsPV2rbJ2O38gTkOnF4FVyx4ycJEoGUXT3JPMNpxxhovMzqc0sg1qJjSEYlAsh9
         JyAilH2HgjwNSbVSR44fv+gy6cyb+FXcHsUW9kXIiXacdTQFG4rsj6WmDk/V/Xl2K6iz
         Vk4h4/vn6C4cIVb2Ppsf3JQkQIngcsmAv7lzUrzfCftmRQU1160XKWehP8pBTgW+yrjN
         7EIb0k1i1TmDg5bYDY18fe2dM+ph/j+3W4jt/a2mo5MUdF3+0K1eEqV5yjMlmcEPV3qV
         +B3Q==
X-Gm-Message-State: AElRT7EsBU36xZOIwNNyQj6WObYmm7+BBHNtIXSY8X3BpU1uLRRFPBEY
        2w289UJnzQ9xbWc+djUCBZdlLFNtKUsns5Mpcpk=
X-Google-Smtp-Source: AG47ELs7aA8mBpUpwkfgzOVpSN4xeQBPapd1Aao3XbrNdDpWo3L9NgSdRNydIUXtty8+iOOY5kKEkmFidWN0zHwBgMQ=
X-Received: by 10.237.49.195 with SMTP id 61mr61161017qth.77.1522141287973;
 Tue, 27 Mar 2018 02:01:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Tue, 27 Mar 2018 02:01:19 -0700 (PDT)
In-Reply-To: <20180325134947.25828-5-t.gummerer@gmail.com>
References: <20180317222219.4940-1-t.gummerer@gmail.com> <20180325134947.25828-1-t.gummerer@gmail.com>
 <20180325134947.25828-5-t.gummerer@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 27 Mar 2018 05:01:19 -0400
X-Google-Sender-Auth: hpPFCRg555K_fwywk2jvjOmNNt0
Message-ID: <CAPig+cSYxGrhz2RDmHFXaEWC687BSiGb12cq8pZN_XYPGi7ejQ@mail.gmail.com>
Subject: Re: [PATCH v5 4/6] worktree: factor out dwim_branch function
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 25, 2018 at 9:49 AM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> Factor out a dwim_branch function, which takes care of the dwim'ery in
> 'git worktree add <path>'.  It's not too much code currently, but we're
> adding a new kind of dwim in a subsequent patch, at which point it makes
> more sense to have it as a separate function.
> [...]
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> @@ -417,16 +431,9 @@ static int add(int ac, const char **av, const char *prefix)
>         if (ac < 2 && !opts.new_branch && !opts.detach) {
> -               int n;
> -               const char *s = worktree_basename(path, &n);
> -               opts.new_branch = xstrndup(s, n);
> -               if (guess_remote) {
> -                       struct object_id oid;
> -                       const char *remote =
> -                               unique_tracking_name(opts.new_branch, &oid);
> -                       if (remote)
> -                               branch = remote;
> -               }
> +               const char *dwim_branchname = dwim_branch(path, &opts);
> +               if (dwim_branchname)
> +                       branch = dwim_branchname;

I don't care strongly but the name 'dwim_branchname' is awfully long
in a context where it's assigned the result of a call to
dwim_branch(). In this tiny code block, a short and sweet name 's'
would be easy to grok; there'd be no confusion.

Anyhow, it's subjective and not at all worth a re-roll.
