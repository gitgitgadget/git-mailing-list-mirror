Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD63C433ED
	for <git@archiver.kernel.org>; Sun,  4 Apr 2021 08:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09F9E61247
	for <git@archiver.kernel.org>; Sun,  4 Apr 2021 08:52:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbhDDIxA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Apr 2021 04:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbhDDIw7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Apr 2021 04:52:59 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99745C061756
        for <git@vger.kernel.org>; Sun,  4 Apr 2021 01:52:55 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id e7so9584228edu.10
        for <git@vger.kernel.org>; Sun, 04 Apr 2021 01:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wP+QVilRBg1fkuww9sJ4NzjheM5uC/E0emcpzNfgvz0=;
        b=ugwIBE8gfy0ymcw1PhUcTnTIbQdxGYadH6Ay4eAuOk6rSZVTp0J56VaNxO7077TgBO
         YsaG204Gpq+bC5vUaxpOfYcRjEF7D6NBMJjkyjqlcALolrYp1rOKOxfcUeuCmeg1sFLI
         QYYZxlYyJlS5omPNCwhFFHP3MgovxYXzJQMFeaEIN+Yx+pD9eAUS18RfBn7S7+YiL2WI
         AT0Pur3dFTOlCvmcjjqbSodsUenKgeiRJx2GUPNbXWHLcCLz2w50baYVUESbllbdyQ8W
         tACUTERAUXGSZlpBFwoY5dsqhBzwXGaoTRDleeRtr896kQEi1FsaP3ogjLpkmG5XvS4r
         7Tug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wP+QVilRBg1fkuww9sJ4NzjheM5uC/E0emcpzNfgvz0=;
        b=l9vcXCcUJyzEVPDNYGVUyyRDAaIjXtCoq80Va/xEFtTafEgng1BB95bUSwlwhUI7yt
         XYlnAf9ITjzUMlwOvqfEC5QRH85A/IuTnBF87onzi7+YO5YjxHV2ahbeIOBrjJEZGZxd
         Gl4IyMXw08rkdYTpSr1QUuWyc3LVX89snlzF4/msYKJo+xIWtiRn4BhVBCXKIiJg3HJI
         fJRJYMmtiwDeANP6+LM5a4EQ8timOnmjBiPeWp5k3g7f8rdd3stiOFw7etK+TuVN99K6
         9jUN3mamAfqbyAd/dx8k/cDOLKmlt4uU198DG/4JTpSM28yLnwUUzwyCcutvkWM1Q8fP
         WpCw==
X-Gm-Message-State: AOAM532YDCkJaVdR5uKgFDQrpberLRT5Cd8ud91vWK129TizsfD9gCYt
        5FNzcG/sX/WRl309gGMIGzI0k7Q8MMoyBX0oBUg=
X-Google-Smtp-Source: ABdhPJzGgfUg2W90e68HC12qqsJx3k6Lkr7W3vyE8gJNRMzJ+Raa+UT+ck49gJHSR8iRnd9az+EJNPnU8bSIn56Ahf4=
X-Received: by 2002:aa7:d503:: with SMTP id y3mr24716359edq.142.1617526373356;
 Sun, 04 Apr 2021 01:52:53 -0700 (PDT)
MIME-Version: 1.0
References: <pull.913.v5.git.1617185147.gitgitgadget@gmail.com>
 <pull.913.v6.git.1617369973328.gitgitgadget@gmail.com> <xmqqim544dl4.fsf@gitster.g>
 <CAOLTT8QvPPJ4jYXjch+RhdHDnvDT6Woh2oQoX2LcoiVX_t7jZQ@mail.gmail.com>
In-Reply-To: <CAOLTT8QvPPJ4jYXjch+RhdHDnvDT6Woh2oQoX2LcoiVX_t7jZQ@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 4 Apr 2021 10:52:42 +0200
Message-ID: <CAP8UFD1=v_dfjKT2zY2=DFhZO1RWh9-++m5gAOn5WmwuV2pJXg@mail.gmail.com>
Subject: Re: [PATCH v6] [GSOC] trailer: add new trailer.<token>.cmd config option
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 4, 2021 at 7:44 AM ZheNing Hu <adlternative@gmail.com> wrote:

> This may be an off-topic question:
> I wanted to use `shortlog -s` instead of the document example,
> But I found a very strange place:
> Here we have two shell scripts:
>
> $ cat ~/bin/gcount
> #!/bin/sh
> if test "$1" != ""

It's better to use `test -n "$1"` instead of `test "$1" != ""`.

> then
> git log -1 --author="$1"
> else
> echo "hello there"
> fi
>
> cat ~/bin/gcount2
> #!/bin/sh
> if test "$1" != ""
> then
> git shortlog -1 --author="$1"
> else
> echo "hello there"
> fi
>
> If I use them in the terminal, there is no problem with them,
>
> $ ~/bin/gcount gitster
> commit 142430338477d9d1bb25be66267225fb58498d92
> (interpret-trailers-command-arg, abc5b)
> Author: Junio C Hamano <gitster@pobox.com>
> Date:   Mon Mar 22 14:00:00 2021 -0700
>
>     The second batch
>
>     Signed-off-by: Junio C Hamano <gitster@pobox.com>
>
> $ ~/bin/gcount2 gitster
> Junio C Hamano (1):
>       The second batch
>
> if I use .cmd to run these scripts, the situation is totally different:
>
> $ git config -l | grep trailer
> trailer.cnt.ifexists=add
> trailer.cnt.key=Cnt:
> trailer.cnt.cmd=~/bin/gcount

The script/command used in ".cmd" or ".command" should really return a
short string with no newline or line feed char in it. Here your script
can return multiple lines which could mess things up and be difficult
to understand.

> $ git interpret-trailers --trailer="cnt:gitster" <<EOF
> EOF
>
> Cnt: hello there
> Cnt: commit 142430338477d9d1bb25be66267225fb58498d92
> Author: Junio C Hamano <gitster@pobox.com>
> Date:   Mon Mar 22 14:00:00 2021 -0700
>
>     The second batch
>
>     Signed-off-by: Junio C Hamano <gitster@pobox.com>
>
> And if I turn to use gcount2:
> $ git config trailer.cnt.cmd "~/bin/gcount2"
> $ git interpret-trailers --trailer="cnt:gitster" <<EOF
> EOF
>
> Cnt: hello there
> Cnt:
>
> It looks like `shortlog` does not write to standard output.

In shortlog's doc there is:

"If no revisions are passed on the command line and either standard
input is not a terminal or there is no current branch, git shortlog
will output a summary of the log read from standard input, without
reference to the current repository."

I guess that's what's happening here.

> Note that in `short_log.c`, log will be output to `log->file`.
> Does it make the above behavior different?
> Is there a good solution?

I would try to pass a revision on the command line.
