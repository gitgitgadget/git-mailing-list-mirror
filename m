Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3F0A20D14
	for <e@80x24.org>; Thu,  1 Jun 2017 19:23:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751174AbdFATX1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 15:23:27 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:35758 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751097AbdFATX0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 15:23:26 -0400
Received: by mail-pf0-f177.google.com with SMTP id n23so35470149pfb.2
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 12:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2TNamig+Q+41CVI8wnO37LDJqeS+gN1xPG7o66Dp9IU=;
        b=vkXyqoSDzfknLOATuvh8ukR4Br0dgoW+CRo4tIHF3NIx/whTH2uluDZ2YThW9/Imeq
         DhXkIBCmfYwdW5F1kaI6Iqw3HgRKOLpWTPw4Q6ST4hxJn734FRohnYw9celtX4tk7B/9
         1Y/4ncGnLn3YaocjDuYvR36h0wgrJXcjCvxnkTwxop4ubovZhxf1ZIIRtiq+RXhpjcms
         0hT2cYV/2PtJOfhauW6HE+paFZGQof/aP8ui0DZdp0NOmzCDANzoQfVxNCsz+L9MItmH
         Qb6rDy5WQnUUo8zL6+baBcim61o1JtYy2XgaQKdjCPxUI8pZH/wfwy28405q6q8HkpXI
         roWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2TNamig+Q+41CVI8wnO37LDJqeS+gN1xPG7o66Dp9IU=;
        b=TqfQqFkzE+YQySbr1oOrlQY/HuGdxyCl8ezPTrkXYvg1k4M6o9ffordPxEzfLpny2d
         IsM0zo8sJBbbFTKovo61bQ9OBDJNUA9wV8q78jC9Kt9n6zjDGXsAgVa7yQMeRhtYL1dg
         CW80kcuuWBt5dwsZs82chfB5WrQiSbAMgT+qQ1PX+XqkUFi38Qk7DCAYZFwdeJvTlBh+
         YxZqU2PnX8HqRlKNRCGUKqc/uOTMTyR+WageD/ILMZGsUYisxw8mvOHbgB7Wp45ZYeoz
         rAMf8wAhTo6i0RQj/nyP/SWGerHSrC3K0O9+koG/KBDo2AnFwZXqlC/LgTHpSEXnpnnU
         LBBA==
X-Gm-Message-State: AODbwcB5AkBZFsFdlitaiqur4a3YzxdNBXlZi0b4DFziH5rX27pOYq7Q
        tFB2dnbn/w1Lfm5Hg/bEOcVgtI3crGhL
X-Received: by 10.84.241.132 with SMTP id b4mr97254801pll.107.1496345005877;
 Thu, 01 Jun 2017 12:23:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.170.200 with HTTP; Thu, 1 Jun 2017 12:23:25 -0700 (PDT)
In-Reply-To: <20170531214417.38857-5-bmwill@google.com>
References: <20170531214417.38857-1-bmwill@google.com> <20170531214417.38857-5-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 1 Jun 2017 12:23:25 -0700
Message-ID: <CAGZ79kafXpn+BXdMOVOPSX7eaFgcWBUULGR_PBXpMhjKjLEM-A@mail.gmail.com>
Subject: Re: [PATCH 04/31] setup: don't perform lazy initialization of
 repository state
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Ben Peart <peartben@gmail.com>, Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <git@jeffhostetler.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 31, 2017 at 2:43 PM, Brandon Williams <bmwill@google.com> wrote:
> Under some circumstances (bogus GIT_DIR value or the discovered gitdir
> is '.git') 'setup_git_directory()' won't initialize key repository
> state.  This leads to inconsistent state after running the setup code.
> To account for this inconsistent state, lazy initialization is done once
> a caller asks for the repository's gitdir or some other piece of
> repository state.  This is confusing and can be error prone.
>
> Instead let's tighten the expected outcome of 'setup_git_directory()'
> and ensure that it initializes repository state in all cases that would
> have been handled by lazy initialization.

Lazy init is usually there for a reason. (As in: it took too long to perform
it at all times, so it has been optimized to only perform the init when needed).

Reading the code of setup_git_env, this is the additional cost incurred to us:
* reading a file ('git_dir' to determine if it is a gitlink or actual directory)
* reading another file to determine the commondir
* some environment variable reading (<10).
  Reading the environment should be fast, though in the implementation
  of libc that I just looked up, it is still a linear search, so O(n) with n the
  number of environment variables. (No actual syscalls though.)

I would think that this is ok as it incurs not much cost. Maybe the
lazyloading implementation was just a habit of the contributors at the time.


>  const char *get_git_dir(void)
>  {
>         if (!git_dir)
> -               setup_git_env();

NEEDSWORK: eventually (say after release 2.16)
we can remove all these

    if (!git_dir)
        BUG(...);

calls. I will read on, as maybe this series touches
this further
