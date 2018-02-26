Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 128581F404
	for <e@80x24.org>; Mon, 26 Feb 2018 17:28:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751094AbeBZR22 (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Feb 2018 12:28:28 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:53595 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750826AbeBZR21 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Feb 2018 12:28:27 -0500
Received: by mail-wm0-f67.google.com with SMTP id t74so19090635wme.3
        for <git@vger.kernel.org>; Mon, 26 Feb 2018 09:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=SaGyr4wt84KEoO4pjiBjSsKqS5PRJnJt4iEe3uxxuGM=;
        b=eMXGdGvbuwBISk/YA4DEFi1OGkrZQIaDh8/e+fJ8Nqt9jzl8HKK4z8Yw4d6HJEYmqh
         EwFmwe08DIdhVjM5vb8+0b+qI+kOG50XkMyNBiW+QaD9vl4XFRwlfH2mEBhXhFWdYW6l
         A/XY6kOFWmVWulAhfl/Fgz5ymMb1ay4Tewxfu2SdpgMP0EdVywJzqu/mq1KYhO7oBTJw
         BJ/JcOj0EcuwnJMId6Ir2og9lJk4Pni2enTfY4dcDzFeRYg8lwrARJ/qjYZQU7hFxLz0
         35D7W8SXsGxQ6dt31xsDIk0Bt15p1Cn6NQGxGuHqhjKdEn9HtAce2NSxXHQb9CjAn8Yb
         V2/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=SaGyr4wt84KEoO4pjiBjSsKqS5PRJnJt4iEe3uxxuGM=;
        b=HPzcPeHT6cxkiXxbBo+/XQmJH2nHT+M+SsaLYcCjbCNWkvN978muqtYcQh28KMevWs
         lW61xKklCrsBCe8Yd1Pzg3WkixBr7CRrAQxaHViVSZYfTepSpgaW424pGM5to+duCP6V
         SFT4s01bB0ZNTQFRJQFnivO8dtrSm78d/Ud2L70tOc4sXrLF0mGv1lCTcOra5Mw1Pgqg
         Ouab4q5XSegFiuM3OfRfLaLybBx/a1eEZKKXfLz3CixWqNUdsB5am8jFloMKCm3JjcYT
         AEn3YNrecmKYY3hyeBsJo0csykqdeEn/T+fRng0HAB7/lcPCfsRqpKq1Or9YSSWYDJLq
         LtXg==
X-Gm-Message-State: APf1xPCQP26YX7SGMF7aJ4BlIDIlKSnNEaCIbcddsCKaQQGRb6LB5Hp9
        1yr0unvEY6ihN+Q61VEB95U=
X-Google-Smtp-Source: AH8x2244UlF6XTC6U1r5E+1EQlRO7Ipp17SK5SWQymvL4Cd+2NmNG5wK+h1gq/GIV//eGm+xjZEguw==
X-Received: by 10.28.143.66 with SMTP id r63mr9789847wmd.82.1519666105412;
        Mon, 26 Feb 2018 09:28:25 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id p21sm7189622wmc.45.2018.02.26.09.28.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Feb 2018 09:28:24 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stephen R Guglielmo <srguglielmo@gmail.com>
Cc:     git <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>,
        Avery Pennarun <apenwarr@gmail.com>
Subject: Re: [PATCH v2] subtree: fix add and pull for GPG-signed commits
References: <CADfK3RVJ9pYtpX9x2=CZSKLVy2qxBKeyyGA_S=jo8K-Fa4FOqA@mail.gmail.com>
        <xmqq7er3s4t7.fsf@gitster-ct.c.googlers.com>
        <CADfK3RXa9wngOZ9YmurThm=Xu8J=nq0tK5yaMOMT4T0be2sUZA@mail.gmail.com>
Date:   Mon, 26 Feb 2018 09:28:24 -0800
In-Reply-To: <CADfK3RXa9wngOZ9YmurThm=Xu8J=nq0tK5yaMOMT4T0be2sUZA@mail.gmail.com>
        (Stephen R. Guglielmo's message of "Mon, 26 Feb 2018 09:46:32 -0500")
Message-ID: <xmqqwoyzr77r.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stephen R Guglielmo <srguglielmo@gmail.com> writes:

> On Fri, Feb 23, 2018 at 5:45 PM, Junio C Hamano <gitster@pobox.com> wrote:
>...
>> I am however starting to feel that
>> ...
>> may be a better approach.
> ...
> I'm happy to develop a new patch based on your recommendations. Should
> it be on top of the previous patch I sent or should it replace the
> previous patch?

Even though I said "may be a better approach", to be bluntly honest,
I do not think it is _that_ _much_ better than what you sent ;-)  So
please do the "on top of the previous patch" thing as an independent
effort (not the "git log" workaround bugfix) only if you deeply care
about improving "subtree" script (as opposed to just want to see the
immediate glitch corrected to get on with your life---I happen to be
in the latter category with respect to this issue).  The independent
effort's focus would instead be to improve the script not to make so
heavy use of "git log" (and other Porcelain commands) in it, so that
we do not have to tweak the script to undo improvements we will make
to the Porcelain commands for better human experience in the future.

Notice that one hunk in this patch is a small step in the direction;
it stops using "git log -1" and uses "rev-parse" instead.

For the remainder of the script, we need to identify how "git log"
is used in the script and what they are used for, and then rewrite
them with the more stable lower level interface.  It is a very first
step to mark invocation sites by replacing "git log" with "$git_log"
;-)  

The same may apply to uses of other Porcelain commands.  A general
rule is that scripts should avoid using Porcelain commands unless
they are interested in giving output for human-consumption directly
out of these commands (as opposed to running the Git commands and
then reading their output and reacting to it).

Thanks.




