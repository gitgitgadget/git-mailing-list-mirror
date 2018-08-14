Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B909C1F404
	for <e@80x24.org>; Tue, 14 Aug 2018 23:04:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730739AbeHOByE (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 21:54:04 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36474 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728103AbeHOByE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 21:54:04 -0400
Received: by mail-wm0-f68.google.com with SMTP id w24-v6so13704064wmc.1
        for <git@vger.kernel.org>; Tue, 14 Aug 2018 16:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=3TKDdj/ZkEbZbBzIndOPKGqIB5HUuX78CVvqOePwc5k=;
        b=pMa+RiAijsoTnUU05S0jtzViphFLW5ux4aWupoo5J2Yi+8Jt8AACzJx5szQnJjoXol
         CsV0fjWaFZPmna0p75F6yU11Y51054oIGvNl6GPOIXH174NnB09M+YriGBzPJJZLhl1S
         I/7EwKWDuVEaZBoXGkXK8nx0RrShKUiy8YO3VOj711VNG/wuOwz9Edcs9cZP3s8Z+901
         soGTIjETzw5ORZcVsb7qMZ1cX6O3ZPbnd7AmwRD4lMAKNxWZQo7swFdhe46vcsuNz0kE
         ml79UDP0tF0XEtWrEhj31zOsJoJ7A8oebJ8etyn1sgIIJZNtMvEljGBpiB3wc/8Dgeqx
         FDRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=3TKDdj/ZkEbZbBzIndOPKGqIB5HUuX78CVvqOePwc5k=;
        b=uAso6qnbogfHIa2hVymUgRGUQa2wT0AYWtlCDQRH/iW6d2YWy5FbfdUldtbfdfqzFD
         Hb2TKIdfzX9Lq4HGnR1BN/UKCGUY6LMyrfXykmL3mp1375jvNGkBysdJxa0IPP4Bs6RL
         ARPRiKThH6835zC/eRYhREHdT7vYXVnmZcScU+hMR4HOxC5oB0wGnXsMXmTdbViUygqh
         WHbpQLqoGlId+mUARclsY1a24KVLucwEF1Vj27PvFwmmxAMA9R5J4xHKA8wV0kzb1ezy
         IGoq4Om9XJUGbAaq48fM1jrFe1sKImskHlXepkPFv14WCPhol5+mn8IkUJFdW0nWfD65
         v5vA==
X-Gm-Message-State: AOUpUlHN9Py5ufJez4E6LMd2Qm+xysBsO9Hw+1gw5DekbCLZTQn0D7Xh
        JKr2ZbrqfsTsLJepdYbgibU=
X-Google-Smtp-Source: AA+uWPza/HV7vJ0rieoqXV0AH964ZuEcqVcjfm8AL9QehmUzAkmpiP1+UlZEzQqBztl7fpyL6rX2gA==
X-Received: by 2002:a1c:a401:: with SMTP id n1-v6mr12767195wme.125.1534287877672;
        Tue, 14 Aug 2018 16:04:37 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id g10-v6sm20225513wrv.90.2018.08.14.16.04.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Aug 2018 16:04:37 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     joakim.tjernlund@infinera.com, git@vger.kernel.org,
        bmwill@google.com, pclouds@gmail.com
Subject: Re: [PATCH 1/2] store submodule in common dir
References: <95e4f9df528a40bf3f3e648318904500343abf9a.camel@infinera.com>
        <20180814223820.123723-1-sbeller@google.com>
Date:   Tue, 14 Aug 2018 16:04:36 -0700
In-Reply-To: <20180814223820.123723-1-sbeller@google.com> (Stefan Beller's
        message of "Tue, 14 Aug 2018 15:38:20 -0700")
Message-ID: <xmqqo9e4y2gr.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  path.c | 1 +
>  1 file changed, 1 insertion(+)
>  
> On Tue, Aug 14, 2018 at 3:27 PM Joakim Tjernlund <Joakim.Tjernlund@infinera.com> wrote:
>>
>> I am trying to create 3 submodules from the same git repo, each pointing to a different branch.
>> Since the repo is somewhat large, I don't want the 3 submodules to clone the same repo 3
>> times, I want one clone and then have the 3 submodules to point to different commits.
>>
>> Is this possible? If not, could it be added?
>
> yup.
>
> According to recent discussions, it would be just this patch.
> (plus some unspecified amount of work, TBD).
>
> I thought about proposing something proper later, but here is the WIP patch.
>
> Thanks,
> Stefan 

My understanding of what Joakim wants to do is to have a top-level
project that has three subdirectories, e.g. kernel/v2.2, kernel/v2.4
and kernel/v2.6, each of which is a submodule that houses these
versions of Linux kernel source, but only clone Linus's repository
(as the up-to-late tree has all the necessary history to check out
these past development tracks).  And that should be doable with
just the main checkout, without any additional worktree (it's just
the matter of having .git/modules/kernel%2fv2.6/ directory pointed
by two symlinks from .git/modules/kernel%2fv2.[24], or something
like that).

Isn't "common_dir" stuff used to decide if each of separate
"worktree" instance (of the superproject) shares ".git/$stuff"
with each other?

Unless I am grossly misinterpreting the original question, I fail to
see how changing .git/modules to be shared across worktrees possibly
affects anything.  I am puzzled...

>
> diff --git a/path.c b/path.c
> index 34f0f98349a..64c9821b834 100644
> --- a/path.c
> +++ b/path.c
> @@ -115,6 +115,7 @@ static struct common_dir common_list[] = {
>  	{ 1, 1, 1, "logs/HEAD" },
>  	{ 0, 1, 1, "logs/refs/bisect" },
>  	{ 0, 1, 0, "lost-found" },
> +	{ 0, 1, 0, "modules" },
>  	{ 0, 1, 0, "objects" },
>  	{ 0, 1, 0, "refs" },
>  	{ 0, 1, 1, "refs/bisect" },
