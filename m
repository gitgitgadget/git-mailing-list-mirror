Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F6001F597
	for <e@80x24.org>; Mon, 23 Jul 2018 19:14:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388141AbeGWURb (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 16:17:31 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36864 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388137AbeGWURb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 16:17:31 -0400
Received: by mail-wr1-f67.google.com with SMTP id q10-v6so1771110wrd.4
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 12:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=5bYNGAxNHKenPph/c6PfSZwOJF8JInnd9bZ/UQmcfck=;
        b=ajM1GsmNp3/R/RCF61KoNmMAjx9VHzm8ydSmDxbZy6EjkI6NpXs5ZvOKNsiMk3Gvyg
         cDx+C2+0hXyATq1SHovNzMtAicGtlDYk3+nsoosBEvTuJ0V2DJIKkhleS7+/5YlfzIu2
         XLaM+cLkUFGYfpfrSqVbD7ZfP5knZAO5JLDYgLfTuGlr5Fa0oz2vhznr/YabIZQm9akB
         6QGuzaSpIScQl/9A2KZ0EPpBa4mL+BaQE+BHqQdvwUzVfga5cQ4iUFKGkNqJpSr3TzSC
         k0VuxL/vY1DNOZZt62G0cL2F1cpPtkYLiHSHK2BplrUz5HA5DIsmvkRX7sj+GgfbtRIL
         iKrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=5bYNGAxNHKenPph/c6PfSZwOJF8JInnd9bZ/UQmcfck=;
        b=irIOrGmeOMBuCf8+eUV+nR4fjgxVBSUDCoTMIZtApADkwtioIXZk7g1YZNCYsPr70v
         ra8igc63hCNhM/R4uWCB/PYI9hyWRdoYovQ0BbfUX78pDIx9q517rRDsp/kEjNwMDtct
         LyBnWlKovIBEEnBS7AtE55hAQZiX9nsPk79gVNVwFJLhlTMVwNyP3CXtFjwIhqG7Xmwh
         nUTmjv7RMDFujDX+YNfjP11pkXyT1jNnmw2JS/So7HHCv+CQH5vGJ4jYyd16TV5N48tp
         JJweuEJr1gJ+wT0mGSRnTyfomp0U8cLAVjJdUjSTPBTHN4yZfHnWKyQV58S0hk7TdJ3O
         zQnQ==
X-Gm-Message-State: AOUpUlEvHUTgV+Tyn3/QyL9Ng/PDQFpYGvCdKEmsRWk14NJXEPZdE2Ww
        F3l45hGmhnwoc17IkUZohbhzWW2J
X-Google-Smtp-Source: AAOMgpdoGLwD5uCsxTyGqRH6rdBRBeERznukBvKWtEXwQ6Pp5qMNWRO0aBzASBckV+LisEnXbHNnHQ==
X-Received: by 2002:adf:f091:: with SMTP id n17-v6mr9957221wro.49.1532373291983;
        Mon, 23 Jul 2018 12:14:51 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id o16-v6sm2340176wmf.10.2018.07.23.12.14.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Jul 2018 12:14:51 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 1/1] t7406: avoid failures solely due to timing issues
References: <pull.12.git.gitgitgadget@gmail.com>
        <78f7a5e4baae162d1dff18701a25903b304adf9e.1532353179.git.gitgitgadget@gmail.com>
Date:   Mon, 23 Jul 2018 12:14:50 -0700
In-Reply-To: <78f7a5e4baae162d1dff18701a25903b304adf9e.1532353179.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Mon, 23 Jul 2018
        06:39:42 -0700 (PDT)")
Message-ID: <xmqqmuuh69xx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> To prevent such false positives from unnecessarily costing time when
> investigating test failures, let's take the exact order of the lines out
> of the equation by sorting them before comparing them.
> ...
>  cat <<EOF >expect2
> +Cloning into '$pwd/recursivesuper/super/merging'...
> +Cloning into '$pwd/recursivesuper/super/none'...
> +Cloning into '$pwd/recursivesuper/super/rebasing'...
> +Cloning into '$pwd/recursivesuper/super/submodule'...
>  Submodule 'merging' ($pwd/merging) registered for path '../super/merging'
>  Submodule 'none' ($pwd/none) registered for path '../super/none'
>  Submodule 'rebasing' ($pwd/rebasing) registered for path '../super/rebasing'
>  Submodule 'submodule' ($pwd/submodule) registered for path '../super/submodule'

Thanks.  It obviously goes in the right direction to loosen the
ordering requirement that fundamentally cannot be met, as the log
message cleanly analizes.

Do we know that the write(2)s that show these lines are atomic, or
are we merely lucky that we don't see them intermixed in the middle
of lines (sbeller cc'ed).  I _think_ they are but just wanted to
double check.


