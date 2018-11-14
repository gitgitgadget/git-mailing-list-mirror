Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D9EB1F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 23:07:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbeKOJMT (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Nov 2018 04:12:19 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:38712 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbeKOJMT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Nov 2018 04:12:19 -0500
Received: by mail-vs1-f66.google.com with SMTP id x64so10595819vsa.5
        for <git@vger.kernel.org>; Wed, 14 Nov 2018 15:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y8Ba1MRKJBK85WzIEiM15SR9O7A60O9HlFP+QehdCYE=;
        b=ANGhgMcUFJKYloVscYR9OJQY5TTVfcNHfZjXzOXrHtDKjGTWuxhc0W7u2Iw8bTgAjT
         yoyLo/jn87xrCWT3ysaR8bl4IQfLZVsPmIideBAl90GYufb+5Y115McCVpj7pAi1ty5Z
         HyYuyzBo0LxifdWAOP090Z95DDdP55mKTlijtqXaXO87lK3G9QvhqJutKuZzJM0eI5+8
         ZF9iE283/DFYiHDCGJknDtR2Xz27RFXdb4K9pYKKE6vla8bQJHfQoAGEimCLAGcScq9X
         l5bMim8iyjq/14MuegXNDcM8jUR92D3lTM5uIb5AOQ+A8cV4FXKIzq3kzXOx5e8EDRuL
         rprw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y8Ba1MRKJBK85WzIEiM15SR9O7A60O9HlFP+QehdCYE=;
        b=nhK9XKlQlm3nyQKulHMv+2IR1JJrTE0M68qTQYHpRVq+VjT2uREPXfkInsYVff+2kk
         Kxy2c5iqy4W0p1ACNL7w3u4BiuvJDgZQ+Ss+tVfu3xVkz/oPGzhgEajG8XUBuUgy2LYi
         FAF2lTJjzbU5FN43KIz+h+o7teGJ0yeikO0TywPR9ypnbEdtZc37M8B+GgNQ9AvJ469A
         xrZbKnOXAgmg9tBBKoVz2vSnZSD/x5GyTD4kvwpnUy+oFrnsP1Db1aZ1FmjRbuce3MLl
         eEWiXO2W5cKzzbhs2sG/7z4korjQ4d1CUyG9+w1RClUYKoLzlNbnTeoStIyyBflVOW3I
         NF9Q==
X-Gm-Message-State: AGRZ1gI65s+HLoZQX/7LDUWu8/i0xtEb8cpGU50IKxIjq8Xd6ay4iFem
        M9rjfOfeAX2hpP31IQUnhUs2GaDuTwmzvg4451Q=
X-Google-Smtp-Source: AJdET5fl9IBk8I5Fzr5h0NxRT4pnztqhZvv1h92piZZRK0KjTfq2D07kY/gWHrst+w4W32X3ZQfdt/DkPMTzM0rMpc4=
X-Received: by 2002:a67:e44f:: with SMTP id n15mr1806031vsm.116.1542236820851;
 Wed, 14 Nov 2018 15:07:00 -0800 (PST)
MIME-Version: 1.0
References: <20181108060158.27145-1-newren@gmail.com> <20181108060158.27145-3-newren@gmail.com>
 <nycvar.QRO.7.76.6.1811121614190.39@tvgsbejvaqbjf.bet> <f0231c21-8727-94cb-96aa-13ebfb5b7283@talktalk.net>
In-Reply-To: <f0231c21-8727-94cb-96aa-13ebfb5b7283@talktalk.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 14 Nov 2018 15:06:49 -0800
Message-ID: <CABPp-BERm=tCRE_D8nK3Pj2YOss1RKCgt5uL-ojbT7Ph=P8G+Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] rebase: Implement --merge via git-rebase--interactive
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Pratik Karki <predatoramigo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Mon, Nov 12, 2018 at 10:21 AM Phillip Wood <phillip.wood@talktalk.net> wrote:
> >> -Flags only understood by the am backend:
> >> +The following options:
> >>
> >>   * --committer-date-is-author-date
> >>   * --ignore-date
> >> @@ -520,15 +512,12 @@ Flags only understood by the am backend:
> >>   * --ignore-whitespace
> >>   * -C
> >>
> >> -Flags understood by both merge and interactive backends:
> >> +are incompatible with the following options:
> >>
> >>   * --merge
> >>   * --strategy
> >>   * --strategy-option
> >>   * --allow-empty-message
> >> -
> >> -Flags only understood by the interactive backend:
> >> -
>
> It's nice to see this being simplified

:-)

> >> -if test -n "$git_am_opt"; then
> >> -    incompatible_opts=$(echo " $git_am_opt " | \
> >> -                        sed -e 's/ -q / /g' -e 's/^ \(.*\) $/\1/')
> >> -    if test -n "$interactive_rebase"
> >> +incompatible_opts=$(echo " $git_am_opt " | \
> >> +                sed -e 's/ -q / /g' -e 's/^ \(.*\) $/\1/')
> >
> > Why are we no longer guarding this behind the condition that the user
> > specified *any* option intended for the `am` backend?
>
> I was confused by this as well, what if the user asks for 'rebase
> --exec=<cmd> --ignore-whitespace'?

They'd still get an error message about incompatible options; see my
email to Dscho.  However, since it tripped you both up, I'll make the
clean up here a separate commit with some comments.

> >> +if test -n "$incompatible_opts"
> >> +then
> >> +    if test -n "$actually_interactive" || test "$do_merge"
> >>      then
> >> -            if test -n "$incompatible_opts"
> >> -            then
> >> -                    die "$(gettext "error: cannot combine interactive options (--interactive, --exec, --rebase-merges, --preserve-merges, --keep-empty, --root + --onto) with am options ($incompatible_opts)")"
> >> -            fi
> >> -    fi
> >> -    if test -n "$do_merge"; then
> >> -            if test -n "$incompatible_opts"
> >> -            then
> >> -                    die "$(gettext "error: cannot combine merge options (--merge, --strategy, --strategy-option) with am options ($incompatible_opts)")"
> >> -            fi
> >> +            die "$(gettext "error: cannot combine am options ($incompatible_opts) with either interactive or merge options")"
> >>      fi
> >>  fi
> >>
>
> If you want to change the error message here, I think you need to change
> the corresponding message in builtin/rebase.c

Indeed, will fix.
