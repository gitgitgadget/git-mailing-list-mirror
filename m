Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3887F20136
	for <e@80x24.org>; Fri, 17 Feb 2017 18:25:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934819AbdBQSZs (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 13:25:48 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33543 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934211AbdBQSZr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 13:25:47 -0500
Received: by mail-pg0-f65.google.com with SMTP id 5so5520894pgj.0
        for <git@vger.kernel.org>; Fri, 17 Feb 2017 10:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=X1K/U7/AWNWndcczoowI6t6P06ydUa3ktE7RuLfqq5Y=;
        b=ginwwp4WUqVEj4U5K6WUXgo23E8rWXlivb9YKmUkAuBKeuyieJQVAHGdaoXK8LrCYG
         HhVrcVANZ0xqy3CEcP13wfcWHYbQ9JLH8T7CiieqHLzFzL4KZvT2nlKocHSdVORSByzP
         Gh8enEuH0Ra/YZ+9SBvP08dYyBzv1xIm1uCyhH4yVlSeLiU3U5SdMQSnkyLX6ERNBMJC
         ieluvv950uXsOMi2Y47xpgZUPj894AtqblNa2ZYkI8xATAAEddWoUtaIrXTDMma8g4gm
         9d3lJ1nhn0wq5j1fiMX7wcg+7wzQ/rdSViTRpakBp0YHRt4zULxLvcNQT5+PnpASSuT5
         DDIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=X1K/U7/AWNWndcczoowI6t6P06ydUa3ktE7RuLfqq5Y=;
        b=VwHK2rHKmzbtO0Vm0OhEw7+T6GIuiyrK/YdUSRfaRyU57CpPPIhhkCfcLSA6wDhdXS
         xP29618CwmtaTyjcV2ubm9Ylqf+JH+fwppG+vRRfIWtQGfgIBPO8BSglh4sETPJxVziX
         dOEObWgH+Rdh0JRvU1BDbqULDjaaEiBCgINiXopKC2u8Z21kyyCi4ZxBeF3IDPx6vxxr
         7jsRSPxZxD+kCg+CEh34dhbDldj4SXwRbWbgT+fVwxpXFYjlz8h2wNmB+4JUUm42aBPr
         pj2S36VsDQoAOpojfciMUuP78xnzQ4Jx7Q6umQSrtZvkCzfklK7YHXUX/lEHZrD1fvI6
         7WTA==
X-Gm-Message-State: AMke39my2apu22c5BElai9U2kA2m3x3etWIofLquvObN3yV+/BSTIZAjRN3KQgL5y/FoWg==
X-Received: by 10.84.176.131 with SMTP id v3mr13267566plb.20.1487355946327;
        Fri, 17 Feb 2017 10:25:46 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:3130:38b1:b121:8f0d])
        by smtp.gmail.com with ESMTPSA id f9sm20927614pfj.56.2017.02.17.10.25.43
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 17 Feb 2017 10:25:44 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Michael Rappazzo <rappazzo@gmail.com>
Subject: Re: [PATCH v3 0/2] Fix bugs in rev-parse's output when run in a subdirectory
References: <cover.1486740772.git.johannes.schindelin@gmx.de>
        <cover.1487350582.git.johannes.schindelin@gmx.de>
Date:   Fri, 17 Feb 2017 10:25:34 -0800
In-Reply-To: <cover.1487350582.git.johannes.schindelin@gmx.de> (Johannes
        Schindelin's message of "Fri, 17 Feb 2017 17:58:53 +0100 (CET)")
Message-ID: <xmqq8tp4u129.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> The bug that bit me (hard!) and that triggered not only a long series of
> curses but also my writing a patch and sending it to the list was that
> `git rev-parse --git-path HEAD` would give *incorrect* output when run
> in a subdirectory of a regular checkout, but *correct* output when run
> in a subdirectory of an associated *worktree*.
>
> I had tested the script in question quite a bit, but in a worktree. And
> in production, it quietly did exactly the wrong thing.
>
> Changes relative to v2:
>
> - the "iffy" test in t1700 was made "uniffy"
>
> - clarified in the commit message of 2/2 why we can get away with the
>   "reset then use" pattern

It is no longer relevant between "reset then use" and "use then
reset", I think, because you did something much better, which is to
move strbuf_release() up so that it comes before the possible early
returns.

Both patches look good.  Let's queue this and move it to 'next'
shortly.  Personally, I think it is OK to fast-track this to
'master' before the final, but just like any other bugs, we've lived
with the bug for some time, and it is not a big deal if we have to
live with it for a bit longer.

Thanks.
