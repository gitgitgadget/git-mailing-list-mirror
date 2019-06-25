Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E0A51F461
	for <e@80x24.org>; Tue, 25 Jun 2019 11:18:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729907AbfFYLSc (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 07:18:32 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:36703 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727964AbfFYLSc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 07:18:32 -0400
Received: by mail-io1-f65.google.com with SMTP id h6so572003ioh.3
        for <git@vger.kernel.org>; Tue, 25 Jun 2019 04:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V8cbRUZ1byK+zWWJCQ0sgp/ky/lKaD1aLDvoos+AVR4=;
        b=SswClHx8lSkmPJyrr6eXZqBCzztBhLo/gLzgJK/nSvdmHug5wbb6JW0/btw/khzRB4
         yPln1rqCCA0AqBdxRc/lVQziR1vzs3seAKu8r537g2jSt8rjtDxUJfdaeBCjwRw4TfGw
         6WBgnCftSR4oR3FMSxw/wlrPTTt6ekK3msQ1o7eHNpGQ48Qq8f/84jPeWjvYqU/mDfoD
         +fuSUZvDtTYdDU2tc2LI1+dKuRCPXmmgT+pg7jrFn2V6717Ihp5uJRZDVy6LmcKzPqa8
         OxqXJsZslhqEOi/uqNKSFdI6AxoCiF8gH2mRfTHJR/YSHtXeqqMyD3Vkx0YX8dLyQnOQ
         zpaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V8cbRUZ1byK+zWWJCQ0sgp/ky/lKaD1aLDvoos+AVR4=;
        b=LGXicL56nQUfZmSHQipOIe/Js79fruBJvQYI55HuS46SZYPGlQcKF19Y79fMSJd2H6
         cgWCQUMJU0rZK54vySdFdJfg7XjWNKA31yjog9QGlktI3p6V3HOdiIHQ78eHZOlcZ4gV
         zJTL6py/9Lvgsuzwe+GVchpFM7FTwtmWrFjxwtILcdqud/9ez8ELaCDh75PuSQCCWxTt
         kaB4tfFvBENd9U/e+kIvUTBheKi/AOqkYmNH3oaYMPmEKuKlvjOb7t+HgPw0wFoLJKKB
         iPjbr3XUZdR5dzbZqPG6H1nYbDDVCQVbPeIUGPhoNcrYFg4e+5D6hEY6R7jmtVRhNBVZ
         WNyg==
X-Gm-Message-State: APjAAAVYc+zfJpmNQ8j1P38HWzUIcfh9J/Pd6MPA072W8orz1baHzOI4
        YVWhlVqMk5rXf4/2pCRSn8h2b1NNt20ud9vrRg4=
X-Google-Smtp-Source: APXvYqytrZ7qLNzev0WbAuiEiziE81lMwhQzvQWGZqAhFX5se6v3BOh2UH9OWXEstb8lxR0l4/2uZUiHTMzTEXTkNjE=
X-Received: by 2002:a5d:8890:: with SMTP id d16mr6771166ioo.274.1561461511469;
 Tue, 25 Jun 2019 04:18:31 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqsgryhmqt.fsf@gitster-ct.c.googlers.com> <20190624202653.13810-2-MorianSonnet@googlemail.com>
In-Reply-To: <20190624202653.13810-2-MorianSonnet@googlemail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 25 Jun 2019 18:18:05 +0700
Message-ID: <CACsJy8BnpkfYwKJiz2u5=yhoyLQzu5yAcsvmL75bxWop=ZRh0A@mail.gmail.com>
Subject: Re: [PATCH] submodule foreach: fix recursion of options
To:     Morian Sonnet <moriansonnet@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, MorianSonnet@googlemail.com,
        Git Mailing List <git@vger.kernel.org>,
        Rohit Ashiwal via GitGitGadget <gitgitgadget@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.us>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 25, 2019 at 5:02 AM Morian Sonnet <moriansonnet@gmail.com> wrote:
>
> Calling
>
>     git submodule foreach --recursive <subcommand> --<option>
>
> leads to an error stating that the option --<option> is unknown to
> submodule--helper. That is of course only, when <option> is not a valid
> option for git submodule foreach.
>
> The reason for this is, that above call is internally translated into a
> call to submodule--helper:
>
>     git submodule--helper foreach --recursive \
>         -- <subcommand> --<option>
>
> This call starts by executing the subcommand with its option inside the
> first level submodule and continues by calling the next iteration of
> the submodule foreach call
>
>     git --super-prefix <submodulepath> submodule--helper \
>       foreach --recursive <subcommand> --<option>
>
> inside the first level submodule. Note that the double dash in front of
> the subcommand is missing.
>
> This problem starts to arise only recently, as the
> PARSE_OPT_KEEP_UNKNOWN flag for the argument parsing of git submodule
> foreach was removed in commit a282f5a906. Hence, the unknown option is
> complained about now, as the argument parsing is not properly ended by
> the double dash.

My bad. Last time I checked *.sh but forgot about *.c. I looked around
this time in *.c. This should be the only submodule--helper invocation
that needs "--".
-- 
Duy
