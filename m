Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 970F71F859
	for <e@80x24.org>; Wed, 24 Aug 2016 07:38:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752559AbcHXHhR (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 03:37:17 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:35562 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752275AbcHXHg5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 03:36:57 -0400
Received: by mail-it0-f67.google.com with SMTP id f6so1291821ith.2
        for <git@vger.kernel.org>; Wed, 24 Aug 2016 00:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=pDMRD2UBnMkH037QbuFLfPruSxIvik3o5oF0/lMj+24=;
        b=RSPUdb9/bdX4y5qyaz1r2BHZ3E32Pv0MB0ZWceZXCDNxBWKeUfk1qI4s9GPu5zwU/b
         leRY5T/trzecWkQfssk9OI2p+AWA3wsXcRKR1sWhgcqhWHFL/aM/4c5CxTcwJ05L+1it
         kWaVPbXHdKyu3pTH3BA902vGCbzpy594YcxCE+uDJlKW9FI9vsGJ3Nrk6WPj2kLvZTug
         CCbdwOEBWYphE7ieuuCqcctIr27LX5EWTILvI1wdhhsCBVmCxSYD6Yru1AtxSXLu3Rzx
         GWA4rJPUKye5R2sIAevy9OqfsW3O4cFi/kolxxcdD9WDMfaRXCynBknTUPmRZisJ53d/
         7E7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=pDMRD2UBnMkH037QbuFLfPruSxIvik3o5oF0/lMj+24=;
        b=Luqw6jpuefWaR8Rcqy2FWw+5bkfvOyDaB4k82Ia17G8OSOHfHh18oj67JtS9+sRfKI
         VLbFXWd4PW3Whv7DtlTxIVRmIadgqRZ7Dc6M9CkWOOraqq/KOddSmtXeGDXaG2fYloBi
         Ddkovb1U4lBwdeyyP4G/SY+oDIBnu8l26M1odGSsvp+sYP2+p84y31V5AHrg7ffwH9LC
         5GCD2bvzMKP1RXyTxW3de5RpR2NwaOkFB8Neps6N7DDObDVsCtukEr83LhZZl7NJwxK/
         aMfaz482CuHgUt4FTq7qOrjrtQF3doslew13wXSbO3gykDNigpVKoaYxab/9Kj/zZaru
         0mng==
X-Gm-Message-State: AE9vXwNICBinQ4K3mgxcrRp9BXZnV/QFKwE9eIHJ/B5k+cMuK7/vxZTX8ZjEScBzhYxR78ol0vSVodIqJcIX6w==
X-Received: by 10.36.210.68 with SMTP id z65mr2765024itf.32.1472024217116;
 Wed, 24 Aug 2016 00:36:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.130.1 with HTTP; Wed, 24 Aug 2016 00:36:56 -0700 (PDT)
In-Reply-To: <fff4cdfa36355af7917a06be9f67b50b56bfce99.1471968378.git.johannes.schindelin@gmx.de>
References: <cover.1471968378.git.johannes.schindelin@gmx.de> <fff4cdfa36355af7917a06be9f67b50b56bfce99.1471968378.git.johannes.schindelin@gmx.de>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 24 Aug 2016 03:36:56 -0400
X-Google-Sender-Auth: Uhhqwp6t8CX3Bjhy2IpdQN4MZZ8
Message-ID: <CAPig+cQ2xH1ytsTGNDeDZiHTZpnp28XUJoAY+W-+iw+85gMbtg@mail.gmail.com>
Subject: Re: [PATCH 11/15] sequencer: lib'ify save_todo()
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 23, 2016 at 12:07 PM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> To be truly useful, the sequencer should never die() but always return
> an error.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> diff --git a/sequencer.c b/sequencer.c
> @@ -929,24 +929,29 @@ static int sequencer_rollback(struct replay_opts *opts)
> -static void save_todo(struct commit_list *todo_list, struct replay_opts *opts)
> +static int save_todo(struct commit_list *todo_list, struct replay_opts *opts)
>  {
>         static struct lock_file todo_lock;
>         struct strbuf buf = STRBUF_INIT;
>         int fd;
>
> -       fd = hold_lock_file_for_update(&todo_lock, git_path_todo_file(), LOCK_DIE_ON_ERROR);
> +       fd = hold_lock_file_for_update(&todo_lock, git_path_todo_file(), 0);
> +       if (fd < 0)
> +               return error_errno(_("Could not lock '%s'"),
> +                                  git_path_todo_file());
>         if (format_todo(&buf, todo_list, opts) < 0)
> -               die(_("Could not format %s."), git_path_todo_file());
> +               return error(_("Could not format %s."), git_path_todo_file());

format_todo() doesn't seem to make any promises about the state of the
strbuf upon error, so should this be releasing the strbuf before
returning?

>         if (write_in_full(fd, buf.buf, buf.len) < 0) {
>                 strbuf_release(&buf);
> -               die_errno(_("Could not write to %s"), git_path_todo_file());
> +               return error_errno(_("Could not write to %s"),
> +                                  git_path_todo_file());

Do the above two new error returns need to rollback the lockfile?

>         }
>         if (commit_lock_file(&todo_lock) < 0) {
>                 strbuf_release(&buf);
> -               die(_("Error wrapping up %s."), git_path_todo_file());
> +               return error(_("Error wrapping up %s."), git_path_todo_file());
>         }
>         strbuf_release(&buf);
> +       return 0;
>  }
