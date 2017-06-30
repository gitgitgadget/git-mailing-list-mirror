Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 150AB201A0
	for <e@80x24.org>; Fri, 30 Jun 2017 22:00:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753143AbdF3WA1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 18:00:27 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:35790 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753012AbdF3WA0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 18:00:26 -0400
Received: by mail-pf0-f178.google.com with SMTP id c73so73081316pfk.2
        for <git@vger.kernel.org>; Fri, 30 Jun 2017 15:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4kAl/g+iWUlxIBgTdVmRWrKHdogb9zREX+sNrQb8QQU=;
        b=Pgm31J5O2vM+n0b4aC8jNq83wYGTQ26TF4BSJX/j4RGcUgFro7mXIvdr70Of0UhsMB
         35dFSCgt+ZuWFY+eKHyD/69hQNgvwQOikQHVAT4AMHF1oJHCyWaGgwN5GoDJ9Dq6wHaY
         pE9Lcu8VNzrwQNuhNbkIrF1Mc5MtqZtHxrirwubp8NvYBHMbKxSkiFFB71UPEpkmYubs
         GeOnSRNBCUbQPpCv3o4JG2Wef0W4Iww8z1XOj1pdgRK6opQu0VJrZ0NQmXjOFQMdbe6m
         uPf8vBgqCa5sT/zt+/JyETXwkbnigh3CvOFDn0n+f5tHJuFdz8z0piDphbuDGwBGfNJO
         POQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4kAl/g+iWUlxIBgTdVmRWrKHdogb9zREX+sNrQb8QQU=;
        b=NyJ8SNX6lHHgagODbgj6tg1VDtDnyWSn6y7cHk/eWIUnmXW5QAQtSJygyjF1Srq/5U
         RzFUnEtRZP5rllpjq3fIzUi+C6KHfDmhkEfPpPgYk1HdctZwDz5IGpq5TvnBD6JBV1Tt
         aRa91LoS+kGd3ctW5PKkJQ3+p43HdkVipl/LzT2GhOKlPJ4EZV6cYBYQXOuu8L7t6Gz6
         70NJhoiLt8TNC7leZhWQY/TPhjo5/8c/VGpx5TRh+ED4dJlek3kOEhexS6ylxmMxMWD2
         FHV7enf+GQ4dovDPAtyPfa6oLuMymg1n3dNcQoXChA2flDnavpZ5SZypozcSHOT2MSxL
         pv+Q==
X-Gm-Message-State: AKS2vOxBeMlSlf+apKzuJbNrGnEe7idmeqzgObAHJ3iTfUrNJ3IcYLxN
        lM8OIlkxv/IYcYWzIqAiLvRCYDoQsKefQ+Fm/w==
X-Received: by 10.84.171.197 with SMTP id l63mr26545802plb.167.1498860025769;
 Fri, 30 Jun 2017 15:00:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.183.170 with HTTP; Fri, 30 Jun 2017 15:00:25 -0700 (PDT)
In-Reply-To: <19ee7852-efcc-66d0-24ad-3462a4d5eaf6@peralex.com>
References: <19ee7852-efcc-66d0-24ad-3462a4d5eaf6@peralex.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 30 Jun 2017 15:00:25 -0700
Message-ID: <CAGZ79kaYYSeyeHpnMuK=+pV+JA-97a=if-AyELvSA4Y5yGhmmg@mail.gmail.com>
Subject: Re: speeding up git pull from a busy gerrit instance over a slow link?
To:     Noel Grandin <noel@peralex.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 30, 2017 at 5:28 AM, Noel Grandin <noel@peralex.com> wrote:
> Hi
>
> I'm running git version 2.13.1 on Ubuntu 16.04 (x64)
>
> I'm connecting over a very slow (international link) to a very busy gerrit
> server (gerrit.libreoffice.org) using ssh.
> Ping types are on the order of 200ms.
>
> Using GIT_TRACE_PACKET=true, what I am seeing is that the bulk of the time
> is spent retrieving packets having to do with things which I have no
> interest in, i.e. the refs/changes/* stuff (see below).
>
> Is there any way to deliberately exclude these from the pull process?
>
> My git config looks like:
>    remote.origin.url=ssh://logerrit/core
>    remote.origin.fetch=+refs/heads/*:refs/remotes/origin/*
>    branch.master.remote=origin
>    branch.master.merge=refs/heads/master
>    branch.sdrshapeid.remote=origin
>    branch.sdrshapeid.merge=refs/heads/master
>
> Thanks, Noel Grandin

From here I figured, you're talking about gerrit.libreoffice.org/core
My initial clone is taking rather long, it was stuck in the
"Counting objects" phase for quite some time. Maybe ask the
Gerrit administrator if they have pack.useBitmaps enabled?

(This is a tangent, and most likely related to the initial clone only,
you are asking for everyday fetches.)
