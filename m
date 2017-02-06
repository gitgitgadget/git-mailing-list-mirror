Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 099A51FAFC
	for <e@80x24.org>; Mon,  6 Feb 2017 23:09:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752483AbdBFXJw (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Feb 2017 18:09:52 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36759 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752331AbdBFXJu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2017 18:09:50 -0500
Received: by mail-pg0-f65.google.com with SMTP id 75so10242407pgf.3
        for <git@vger.kernel.org>; Mon, 06 Feb 2017 15:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=qj1YerD4Esq601KGdnaZsJKEPv5YgkSW5lSWMrIq6ig=;
        b=Piv33tyU8wT9S62OcMoHCJQHurjBoTXrIxzAgeqJq604r7jBBzBpnozNX96/Wf8E3X
         ky8EHezC87Sm5FIyRWt/+PT3KxArJegMLPsoye6XMt2DLKhSvmairXOw1EBtj2o57QyA
         Ukldb1kCPDFv9mJja40PdogpsnimKqJtoOuOAa7QMmezvyJ7QU0CmisZfqbBxaToyPjv
         pSLbHLagHBWhvaFSIAJ5ks+zHSvxLPkEMOe2jP1WQlv1xD7uzZhepZOIR3Kmr5ghmEez
         2CWNt5b/QlbHtUE4urlyn041/scJOpQV9ngVwawSR4nGD0Umf9HKGmqK/TmnskOZIpH2
         4yTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=qj1YerD4Esq601KGdnaZsJKEPv5YgkSW5lSWMrIq6ig=;
        b=Y1GRpAD6bY3hq7gG3J+Y0/n/AOA7dLcc4FP7Y1zSlDDWzq5/iD+sKzGH4fvacj7Q9Y
         NEEdTsGlWZlbbUiv32tOGhXlcXekufVPKoFUZm8lJ37KwqCCU4SSED/P5vgRecTuKXzn
         2Uj/1+NqAyPzC/Kk5kU8S/NPSJBAtk8+ECAuBn6x6Vc4pZsC6K9bAV62D/yzJqPQwRpf
         BEGvI0PsXGizOaM04+j5zOuqf8DW8kL6PnPmv/2vGI1irfYyyh4YdDBDPo44G/s79jXc
         UbblRWUxLtXrXOugZgsXY33EF/Ra/S0/u85dVPd5Pa0P5XHcSfq5XmEsvIK8opebSRe0
         7OGg==
X-Gm-Message-State: AIkVDXJZhccwKAI6ngjS72rv9OsKQtuZ/0ecf3yNC60yJrfaFUVk/YPQ2z05iSShWbcFtg==
X-Received: by 10.99.109.143 with SMTP id i137mr16338590pgc.11.1486422589335;
        Mon, 06 Feb 2017 15:09:49 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:310c:cda4:fdbc:2aa2])
        by smtp.gmail.com with ESMTPSA id n123sm1079908pga.9.2017.02.06.15.09.48
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 06 Feb 2017 15:09:48 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Siddharth Kannan <kannan.siddharth12@gmail.com>
Cc:     git@vger.kernel.org, pranit.bauva@gmail.com, Matthieu.Moy@imag.fr,
        peff@peff.net, pclouds@gmail.com, sandals@crustytoothpaste.ath.cx
Subject: Re: [PATCH/RFC] WIP: log: allow "-" as a short-hand for "previous branch"
References: <1486299439-2859-1-git-send-email-kannan.siddharth12@gmail.com>
        <xmqqtw882n08.fsf@gitster.mtv.corp.google.com>
        <20170206181026.GA4010@ubuntu-512mb-blr1-01.localdomain>
Date:   Mon, 06 Feb 2017 15:09:47 -0800
In-Reply-To: <20170206181026.GA4010@ubuntu-512mb-blr1-01.localdomain>
        (Siddharth Kannan's message of "Mon, 6 Feb 2017 18:10:26 +0000")
Message-ID: <xmqqtw86zzk4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Siddharth Kannan <kannan.siddharth12@gmail.com> writes:

> Hey Junio, I did some more digging into the codepath:
> ...
> In case you would prefer for me to not work on this anymore
> because I am new to the codebase, I will leave it at this.

The above is nicely analized and summarized.

The earlier mention of "those new to the codebase" by me was "this
is an inappropriate topic as a GSoC microproject for people new to
the codebase" and it wasn't meant to say "this part of the code is
too precious to let unknown folks touch it."

The focus of GSoC being mentoring those who are new to the open
source development, and hopefully retain them in the community after
GSoC is over, we do expect microprojects to be suitable for those
who are new to the codebase.

The focus of microprojects are twofold.  It is a way for new people
to learn the way in which they will be interacting with the
community once they become Git developers, sending their patches
(which includes analyzing and explaining the problem they are trying
to solve and their solution to it) and receiving and responding to
review comments.  We also want to find out which candidates are
willing to learn and which ones are difficult to work with during
the process.  And its primary focus is not about solving the real
issues the project has with its code---something "bite-sized" is
sufficient (and desirable) for microprojects for both GSoC student
candidates and GSoC mentors and reviewers to work with.

> (c) -> Else look for "r1^-"
> ...
> Case (c) is a bit confusing. This could be something like "-^-", and
> something like "^-" could mean "Not commits on previous branch" or it
> could mean "All commits on this branch except for the parent of HEAD"

Do you mean:

    "git rev-parse ^-" does not mean "git rev-parse HEAD^-", but we
    probably would want to, and if that is what is going to happen,
    "^-" should mean "HEAD^-", and cannot be used for "^@{-1}"?

It's friend "^!" does not mean "HEAD^!", and "^@" does not mean
"HEAD^@", either (the latter is somewhat borked, though, and "^@"
translates to "^HEAD" because confusingly "@" stands for "HEAD"
sometimes).  

So my gut feeling is that it is probably OK to make "^-" mean
"^@{-1}"; it may be prudent to at least initially keep "^-" an error
like it currently is already, though.


