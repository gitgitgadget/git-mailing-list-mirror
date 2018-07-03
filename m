Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2AC531F6AC
	for <e@80x24.org>; Tue,  3 Jul 2018 20:36:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752839AbeGCUgJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jul 2018 16:36:09 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50556 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752607AbeGCUgI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jul 2018 16:36:08 -0400
Received: by mail-wm0-f66.google.com with SMTP id v25-v6so3633831wmc.0
        for <git@vger.kernel.org>; Tue, 03 Jul 2018 13:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=dYJZJ4jnZWnHwFilNcZmAsURrLG+BDP0nVTO2vBpfLc=;
        b=mWXxikYC8TXTV5yJIA9tiuS7ilugqvOaU/BXCzP1AhK/ZTXSj7w2c2Ehar80EYuBY8
         U5RuDxzm1gXGNZgN2QGY6+VE1tx1RSBkAzkxNNsNv3x5Zn7l1klsKzaRS2T4PJ6W/WGa
         AHD+jfGUH7x9vhtG9lhjB0aV8axcOmhXgnhKrt21tdjQFafAvPJmKKKY6axD2LHK/jcE
         TsJsZcPI8mHj7V++geUEXj+UaV534J7YP+VbiIjH1VwzJS3DUc2FoZO1uhMwyy3QmKkO
         9fTjCvHJHA+ypL48+oQqR6/OdDP8tD+hijG1ocub5mwIqHfBR2An5HaJp+5B7Y1LJyQX
         scrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=dYJZJ4jnZWnHwFilNcZmAsURrLG+BDP0nVTO2vBpfLc=;
        b=PhVBnLsenIUOY5r76f7PI51xCzUk/d5nneQXMpcI6itaIoRSlw5rm1PVMmmpg9N4OA
         ojT45afg71F0jdeyz/64xpxBc3y9+EGep2x04ckxlKMK1sd+hr4seFb6Wkz91V4TPzfG
         fFANgwDv7bLGigDwRVJEPLCtDzOVLUQonnsjBVRkmEVWq1Ie/f+uV267hOfdQAuawbIc
         2QYH1tdWIGb/OpVRQE6IQEvT8DI/9EJYZw8VtTYDydCa1KLb+JEzuzCmEnLBjxWy+ra0
         4m99pllsCd5cmmHMZHTByd1XR4udCpnKoauIefOLFkKfYjusuKqh3WoTfJ07ZLVxTt3O
         1ZAg==
X-Gm-Message-State: APt69E2vUQPx134KShqm9q/11bAnJg/bb2/qz4fE9WBovpnyEP+Zp4xQ
        C3n3nErS+8RQ7JTGm0LC2Y05pgkP
X-Google-Smtp-Source: AAOMgpeR7OzNZ1WNPWovYLBQ/2od5cc8xYP0PcweEQ8/EUmOk4cJvbxTFTJ3v/smE4ZS4HRV8R3+Bw==
X-Received: by 2002:a1c:d92:: with SMTP id 140-v6mr11305316wmn.32.1530650166924;
        Tue, 03 Jul 2018 13:36:06 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id x16-v6sm4149030wme.12.2018.07.03.13.36.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 13:36:06 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk
Subject: Re: [GSoC][PATCH v2 5/7] sequencer: add a new function to silence a command, except if it fails.
References: <20180702105717.26386-1-alban.gruin@gmail.com>
        <20180702105717.26386-6-alban.gruin@gmail.com>
Date:   Tue, 03 Jul 2018 13:36:05 -0700
In-Reply-To: <20180702105717.26386-6-alban.gruin@gmail.com> (Alban Gruin's
        message of "Mon, 2 Jul 2018 12:57:15 +0200")
Message-ID: <xmqqd0w4oy4q.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alban Gruin <alban.gruin@gmail.com> writes:

> Subject: Re: [GSoC][PATCH v2 5/7] sequencer: add a new function to silence a command, except if it fails.

Lose the full-stop at the end.

> This adds a new function, run_command_silent_on_success(), to
> redirect the stdout and stderr of a command to a strbuf, and then to run
> that command. This strbuf is printed only if the command fails. It is
> functionnaly similar to output() from git-rebase.sh.
>
> run_git_commit() is then refactored to use of
> run_command_silent_on_success().
>
> Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
> ---
>  sequencer.c | 49 ++++++++++++++++++++++++-------------------------
>  1 file changed, 24 insertions(+), 25 deletions(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index 57fd58bc1..9e2b34a49 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -768,6 +768,24 @@ N_("you have staged changes in your working tree\n"
>  #define VERIFY_MSG  (1<<4)
>  #define CREATE_ROOT_COMMIT (1<<5)
>  
> +static int run_command_silent_on_success(struct child_process *cmd)
> +{
> +	struct strbuf buf = STRBUF_INIT;
> +	int rc;
> +
> +	cmd->stdout_to_stderr = 1;
> +	rc = pipe_command(cmd,
> +			  NULL, 0,
> +			  /* stdout is already redirected */

Are we reviewing the correct version?

I thought we discarded this comment in the previous round.

> +			  NULL, 0,
> +			  &buf, 0);

