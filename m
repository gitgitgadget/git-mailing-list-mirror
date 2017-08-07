Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E406C2047F
	for <e@80x24.org>; Mon,  7 Aug 2017 21:43:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752002AbdHGVn3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Aug 2017 17:43:29 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:33940 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751775AbdHGVn3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2017 17:43:29 -0400
Received: by mail-qk0-f196.google.com with SMTP id q66so1719701qki.1
        for <git@vger.kernel.org>; Mon, 07 Aug 2017 14:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=RPag603Yq7EuGoSotltQR47vzojeBWfVGUFmrEHFGg0=;
        b=FWDtNA3cp0yCPRmihPU2wnN0XRevaNQkncDES9FjCayj2WWrtvRpOwcgfUy3wgfcRU
         V6k6GdL6r0h7SO4qBMCmUS+Jgs7jEIJazjQn4FaFHijz29g4dHFA1B0VAEZJQedpMLt/
         JF76ROscXCqwnnuZUxJ+xIRU2JYat9rUiqX84e+09M/a1Wegv7d4871vW3dH24S/hvKs
         EDysp/zgLQTzGNC6hmjpBUmGDhlDojpvx58qUcOhqavD+6QoxGvo+1S/sWduAFGaTC+i
         g+GXHb1uD6ignTgBeSWtvE4qMHCQR87do+JDufz+HxljN7ScEynT0hYLXdH0B88AoHo9
         5leA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=RPag603Yq7EuGoSotltQR47vzojeBWfVGUFmrEHFGg0=;
        b=eLDd0nn/gWjkBfSmFtvJqJYHL3qV9T8AlnS+Q786gEsyyi+0mUQAATPUVWUZFoSkkz
         TfcMJIDfRN4XM9jjbHy9Qh8d8NG6C0hBegplggJHWPRBI1+8xtLaJ8zAgrQJDKQHSP+y
         L04pASPNZ/PqpJ36UI8Ssxuny2+Krn/dXY0EfKajoIGYdGJqxr0SiNUThO38x/ToaPu6
         DisrJn+/wAom8glSep2xA2B4Fzzvgake1pT/RTKGscmx1GYQv2gCyNYH7IlT85QR8a+d
         RPWjJzrM7gGS2kvn5c0DoyjnlA4zGxmQy0uQS9bbP0IuvL6aLCcvxmNbKb9uILPG1RvU
         U9Vw==
X-Gm-Message-State: AHYfb5igOxG0EHoP8n3BDfTitbSZuU8f0TmfscnhEQzLpDtIurfisItq
        fx3cy6P9eO0PjPdERD2fxlMJb7z1dm/k
X-Received: by 10.55.71.76 with SMTP id u73mr2852962qka.25.1502142208105; Mon,
 07 Aug 2017 14:43:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.31.13 with HTTP; Mon, 7 Aug 2017 14:43:27 -0700 (PDT)
In-Reply-To: <20170807211900.15001-9-pc44800@gmail.com>
References: <20170807211900.15001-1-pc44800@gmail.com> <20170807211900.15001-9-pc44800@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 7 Aug 2017 23:43:27 +0200
Message-ID: <CAP8UFD0kdyVSvmh=JgnZLTXyTL0PnK5L1F7agHCfke1NM1Z5aw@mail.gmail.com>
Subject: Re: [GSoC][PATCH 08/13] submodule: port submodule subcommand
 'summary' from shell to C
To:     Prathamesh Chavan <pc44800@gmail.com>
Cc:     git <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 7, 2017 at 11:18 PM, Prathamesh Chavan <pc44800@gmail.com> wrote:

> +static enum {
> +       DIFF_INDEX,
> +       DIFF_FILES
> +} diff_cmd = DIFF_INDEX;

Using an enum could be a good idea, but I am not sure about using a
static variable.

> +static int compute_summary_module_list(char *head, struct summary_cb *info)
> +{
> +       struct argv_array diff_args = ARGV_ARRAY_INIT;
> +       struct rev_info rev;
> +       struct module_cb_list list = MODULE_CB_LIST_INIT;
> +
> +       argv_array_push(&diff_args, diff_cmd ? "diff-files" : "diff-index");

Maybe diff_cmd could be an argument of compute_summary_module_list()
instead of a static variable, as it's only used in this function and
in module_summary() below which is calling it.

[...]

> +       if (files) {
> +               if (cached)
> +                       die(_("The --cached option cannot be used with the --files option"));
> +               diff_cmd++;

Couldn't this be:

               diff_cmd = DIFF_FILES;

?
