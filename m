Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 646B51F597
	for <e@80x24.org>; Thu, 19 Jul 2018 22:35:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730897AbeGSXUK (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jul 2018 19:20:10 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37661 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730913AbeGSXUJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jul 2018 19:20:09 -0400
Received: by mail-wr1-f66.google.com with SMTP id q10-v6so9521668wrd.4
        for <git@vger.kernel.org>; Thu, 19 Jul 2018 15:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=Hv9H+kqCzT9csuCfPxIF6YQnp8ayL+7E4qEpUed3yWs=;
        b=ssI9qnDprK56d0j6NdvzWXD16fqq/tURVwmI77QGLQ+zsCVrpE9TavsHvJdd2N4iCq
         f4m6TEJ0gIQKYMv8RLQPotSDn9Jz4yKh4Lri8pOUQi+IcTLSoKe9xy4aejTULjqQ10uf
         lDyvDKmEGiDc0Iw2eWUqEd58/Wxuhzb4CCMXBCtH8dwGaVPMtD20gQ1dyLzUNSuWTxl8
         oSDben/PYgFqo9Ke3IO9Pie9XJo3u6siBpeXHv1ETjJ0MWj9OIAVSH83rd0LIiDFxtlm
         AZ+VAcdr0kCl/DCJAtd8x6rxA/2VXcFu3Va4+jl4TCTSH47bAisG8sm1NaRW88clmSHU
         JFkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=Hv9H+kqCzT9csuCfPxIF6YQnp8ayL+7E4qEpUed3yWs=;
        b=di/W6z+kOVqX346gTP0HF/GhiESipjAr1cd0gbd24W8ON/AaRwX7LpEfJAQBpOAblw
         i1lW0d39pkxnoQ5M9zcU7VQdvvrqTWZkqR4AjGbY1pTE2gj8UEt5q3voHnJAt5mtOCsV
         NtcCs4MvVv4ODOZ0ZmtYoDt5oMA2Uk6vxmZByO13Z4Ee4ZznrpN0tRjmy6/4TzOGnqye
         ZS7tilUb4Y1efXhtmRDgHd0SphEtUK8937bO8xdpoux1D5yLEqv9r7bWJZ1I0uY7Qeeg
         e1CLJ7v31L6rPUwS2LPE1F+laTakYf1jbReO7CSbnzaad9SumQPtwy6KfKlNU+R6Ag/B
         ECKg==
X-Gm-Message-State: AOUpUlHqNayiJJiD8hFIBWQn2wWy9Um7H9pSW2hWkCWbrq6T2yNFGCPm
        bAm/bj9qfgfkVsH1EVhmzgA=
X-Google-Smtp-Source: AAOMgpdfu118WB/Q9DiUuUeh/bSc2dLJ6N94G6OkIwAQVateckThmwog7dQecvvWbbCIfOsriYG5qg==
X-Received: by 2002:adf:c554:: with SMTP id s20-v6mr9073478wrf.46.1532039697676;
        Thu, 19 Jul 2018 15:34:57 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 185-v6sm83891wmh.22.2018.07.19.15.34.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Jul 2018 15:34:56 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Vitali Lovich <vlovich@gmail.com>, git@vger.kernel.org,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: rev-parse --show-toplevel broken during exec'ed rebase?
References: <CAF8PYMjub1KK_ZK0hijTNBACSa6SaFyu1dJgrXd5fJU5Hc_dhg@mail.gmail.com>
        <xmqq7em01ns9.fsf@gitster-ct.c.googlers.com>
        <20180713184732.GC968742@genre.crustytoothpaste.net>
        <20180713201949.GA17670@sigill.intra.peff.net>
        <xmqqsh4jt5d0.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1807192225260.71@tvgsbejvaqbjf.bet>
        <20180719220929.6550-1-szeder.dev@gmail.com>
Date:   Thu, 19 Jul 2018 15:34:56 -0700
In-Reply-To: <20180719220929.6550-1-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Fri, 20 Jul 2018 00:09:29 +0200")
Message-ID: <xmqqva9adfcf.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

>> Forgetting the code in git-sh-setup, are we?
>> 
>> git_dir_init() rather specifically set GIT_DIR to the absolute path, and
>> since that variable is already exported, the `exec` commands launched via
>> `git-rebase--interactive` all saw it.
>> 
>> That is the reason why the sequencer.c was taught to set GIT_DIR to an
>> absolute path rathern than not setting it: for backwards compatibility.
>
> GIT_DIR was not exported to 'exec' commands during an interactive
> rebase prior to 18633e1a22 (rebase -i: use the rebase--helper builtin,
> 2017-02-09) (nor was GIT_PREFIX):
>
>   $ git log -Sgit_dir_init master git-rebase*.sh
>   # Nothing.
>   $ git checkout 18633e1a22a6^ && make -j4 prefix=/tmp/BEFORE install
>   <....>
>   $ git checkout 18633e1a22a6 && make -j4 prefix=/tmp/AFTER install
>   <....>
>   $ GIT_EDITOR='sed -i -e "1ix set |grep ^GIT"' /tmp/BEFORE/bin/git rebase -i HEAD^
>   Executing: set |grep ^GIT
>   GIT_CHERRY_PICK_HELP=$'\nWhen you have resolved this problem, run "git rebase --continue".\nIf you prefer to skip this patch, run "git rebase --skip" instead.\nTo check out the original branch and stop rebasing, run "git rebase --abort".\n'
>   GIT_EDITOR='sed -i -e "1ix set |grep ^GIT"'
>   GIT_INTERNAL_GETTEXT_SH_SCHEME=gnu
>   GIT_REFLOG_ACTION='rebase -i (start): checkout HEAD^'
>   warning: notes ref refs/notes/commits is invalid
>   Successfully rebased and updated refs/heads/master.
>   $ GIT_EDITOR='sed -i -e "1ix set |grep ^GIT"' /tmp/AFTER/bin/git rebase -i HEAD^
>   Executing: set |grep ^GIT
>   GIT_CHERRY_PICK_HELP='
>   GIT_DIR='.git'
>   GIT_EDITOR='sed -i -e "1ix set |grep ^GIT"'
>   GIT_INTERNAL_GETTEXT_SH_SCHEME='gnu'
>   GIT_PREFIX=''
>   GIT_REFLOG_ACTION='rebase -i (start): checkout HEAD^'
>   warning: notes ref refs/notes/commits is invalid
>   Successfully rebased and updated refs/heads/master.
>
> And then recently came 226c0ddd0d (exec_cmd: RUNTIME_PREFIX on some
> POSIX systems, 2018-04-10), which then started to export GIT_EXEC_PATH
> to 'exec' commands as well...  

Correct.  git-sh-setup does assign to GIT_DIR, but unless the
end-user has it exported, it does not export, which has long been
very deliberate.  But it does not really matter, as exporting BOTH
GIT_DIR and GIT_WORK_TREE is a lot easier to understand and probably
safe (even though technically a regressing) solution, and fewer and
fewer things will be relying on git-sh-setup in the future anyway.

