Return-Path: <SRS0=C4D3=4R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA9BC3F2CD
	for <git@archiver.kernel.org>; Sat, 29 Feb 2020 23:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 251A2222C4
	for <git@archiver.kernel.org>; Sat, 29 Feb 2020 23:31:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XMw9zkOw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbgB2XbK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Feb 2020 18:31:10 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33586 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbgB2XbK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Feb 2020 18:31:10 -0500
Received: by mail-ot1-f65.google.com with SMTP id w6so6210516otk.0
        for <git@vger.kernel.org>; Sat, 29 Feb 2020 15:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6p8k8cqU42P146eRPlAT7NClbZVeBH0tFCuBWtpzEGQ=;
        b=XMw9zkOwxfPGU/nJJosgABSG3E8V2TgRko+UJlzpB9zU2dBlrji7duYRf/durtAp82
         TrbaGUsiqTqLf+q4tznZgh43+OvWadiDweeJ7eJqEc88B0Feb0CnDXljzeOcpTJqcEeA
         zJDvU4hw/5MCBo1Vwzcrsg3De48RyHH1gKs8p6Qjtycj2m4854MRwlDnG88cGPQVCWSO
         vPS9QlBrfLzZWd5+7r2yT2pIqiKikEAnsDjKg6hzOZbt+hwDzhAjH2MTBu/ORx3KXPtH
         CqdqVeBOn+gt1miCNDjZR/U0IJQ/IcCy7rEOX8GRd//jqx1RNuVzkGTeCaIMbRXKxl3a
         523A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6p8k8cqU42P146eRPlAT7NClbZVeBH0tFCuBWtpzEGQ=;
        b=H6z0FPgkmvtaHGH4VBr87G72nGo/XGp/7JM9IaiyK3g3KPwEM+7AQShAxaPt27O3xY
         XaqMit1aB11SQrjaIwwyhm8FM4I9URIQ+daQZjvqNdKqIuLwf6azpQ/cCELuf6sRAL8N
         ZZXQIsN8vqgZiOB9qDY+UgpHhrc7QjD/aqETplBLeKpf5Utl5OLwK94L9B5jJr4Y2WtX
         X9jcyMWVVRulRZ3kWfvg44q8srms5C2zO4ucn7OtFrdhKd9MtbTUY0yBKMEwQ5swI3D8
         9RymbbWFgs3Hi/sw5eC6DiUuo9cXknhnwUu2sMdZ5AS+fhLhC4PwJudH3sjph1gR2QFV
         sJCQ==
X-Gm-Message-State: APjAAAUJK5AFD4tRD4HZuXeBTvrz/iEgE+KFeILhYMNiYpNiTRzYScPT
        j8eP2ThlwHkAW+1JABaNwJA6JZ1V7UB58icFBRjdhq/5
X-Google-Smtp-Source: APXvYqzWBNPpQcJN1n1+LYl7ODQk/B+9yR3iTqBP0GHPQKUKy4q/FCxVB0yOPQGpLaRta/x7DnTi5+0lzxtOJ3+2woc=
X-Received: by 2002:a9d:6457:: with SMTP id m23mr8402102otl.162.1583019069425;
 Sat, 29 Feb 2020 15:31:09 -0800 (PST)
MIME-Version: 1.0
References: <20200229212258.373891-1-alexhenrie24@gmail.com>
In-Reply-To: <20200229212258.373891-1-alexhenrie24@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 29 Feb 2020 15:30:58 -0800
Message-ID: <CABPp-BEewypPoDrWesk=6twgj2TMGFYdaYzdrg5p4K+mExHqeg@mail.gmail.com>
Subject: Re: [PATCH v3] pull: warn if the user didn't say whether to rebase or
 to merge
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Robert Dailey <rcdailey.lists@gmail.com>,
        rsbecker@nexbridge.com, Junio C Hamano <gitster@pobox.com>,
        annulen@yandex.ru, Theodore Tso <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alex,

On Sat, Feb 29, 2020 at 1:23 PM Alex Henrie <alexhenrie24@gmail.com> wrote:
>
> Often novice Git users forget to say "pull --rebase" and end up with an
> unnecessary merge from upstream. What they usually want is either "pull
> --rebase" in the simpler cases, or "pull --ff-only" to update the copy
> of main integration branches, and rebase their work separately. The
> pull.rebase configuration variable exists to help them in the simpler
> cases, but there is no mechanism to make these users aware of it.
>
> Issue a warning message when no --[no-]rebase option from the command
> line and no pull.rebase configuration variable is given. This will
> inconvenience those who never want to "pull --rebase", who haven't had
> to do anything special, but the cost of the inconvenience is paid only
> once per user, which should be a reasonable cost to help a number of new
> users.

Thanks for working on this.

> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
> ---
> v3:
> - Fix segfault if opt_ff is NULL
> - Don't say that the behavior will change in a future version of Git
> (that hasn't been decided yet)
> - Mention that pull.ff=only is also an option
> - Mention git config's --global option
> - Make the warning message longer and more clear in general
> ---
>  builtin/pull.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/builtin/pull.c b/builtin/pull.c
> index 3e624d1e00..a93ee489f6 100644
> --- a/builtin/pull.c
> +++ b/builtin/pull.c
> @@ -327,6 +327,20 @@ static enum rebase_type config_get_rebase(void)
>         if (!git_config_get_value("pull.rebase", &value))
>                 return parse_config_rebase("pull.rebase", value, 1);
>
> +       if (!opt_ff || strcmp(opt_ff, "--ff-only")) {
> +               warning(_("Pulling without specifying how to reconcile divergent branches\n"
> +                       "is discouraged. You can squelch this message by running one of the\n"
> +                       "following commands sometime before your next pull:\n"
> +                       "\n"
> +                       "  git config pull.rebase false  # merge (the default strategy)\n"
> +                       "  git config pull.rebase true   # rebase\n"
> +                       "  git config pull.ff only       # fast-forward only\n"
> +                       "\n"
> +                       "You can replace \"git config\" with \"git config --global\" to set a default\n"
> +                       "preference for all repositories. Alternatively, you can pass --rebase,\n"
> +                       "--no-rebase, or --ff-only on the command line every time you pull.\n"));

Ick; we don't need the warning to regurgitate large sections of the
manual, we only need to provide pointers and then they can look up the
details in their favorite way (google, stackoverflow, looking at the
actual manpage, etc.)  How about something more like

> +               warning(_("Pulling without specifying how to reconcile divergent branches\n"
> +                       "is discouraged. You can squelch this message by setting pull.rebase,\n"
> +                       "or by passing any of --rebase, --no-rebase, or --ff-only\n"));
