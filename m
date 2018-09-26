Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01A901F453
	for <e@80x24.org>; Wed, 26 Sep 2018 17:40:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728462AbeIZXyF (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 19:54:05 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:38128 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727399AbeIZXyF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 19:54:05 -0400
Received: by mail-wr1-f48.google.com with SMTP id j8-v6so24142384wrw.5
        for <git@vger.kernel.org>; Wed, 26 Sep 2018 10:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=s6/8cRxKM1DEn/zTT7wtdiBB0k9wuPbT1opmcY/kuhs=;
        b=hF49NSzLrAw4IdDJa3eu5xPdKGJX/5Be6sbY18wAkIDqs/HKb4OIhq/LSP0UxGRXbU
         iijSmrRgoTr6MzolsdMGkq2HKKdEKRcUqbovOD6cgeNKbfwQzSl5PT3aLicXlg4ma1vG
         yxSZTlnLbxPJH0clUbzPlHGvbLDn1J26mbzrTsHG0T5amsgaKAlOV6NfdNnbWVQtc+gS
         IC5xYIvofXAf4uOpiJ6BqulWDu5tkjXjdYYIqBYEz8bLkDzvdsjjFCAh9eZYPxf5yp/X
         iCNNQ9ZR431F+/5UDd9SQys3qUu4u/oKRE30R9Fezaj58WeXZSMYr5BAdFctr3dbmy6m
         qBKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=s6/8cRxKM1DEn/zTT7wtdiBB0k9wuPbT1opmcY/kuhs=;
        b=DzQxwYK4J4si9O7uS7s0BBqsVaAF2AzxH4QQ6nfzhGFuAtnMAh9cF0IEmOD0p1eGzy
         ITpMhjIdQmGmbc5CzPbUmRKmjq54ql8RVN2NA+2INQWPBdBvhsnPpZuoEG25f1gEgW1Z
         j2IoRI13OQhsXMBMyWj9vTXxuMpCqIjJs2DM0kzZi354K76Cg+zmyEaEV75pBWjsoytB
         dgZN+GRDTOpgV31sTQmo6IEnTqTSw3UOIiwKNkpt8Ut+V8O5c9LKMfsUykRItJE19QMJ
         jDJlYkVVnn3ZLh6ieDFJgdy9fVCW0vam1Lkekon6luBgOcMklKWpwjagVNbzhhmp6VAS
         wIig==
X-Gm-Message-State: ABuFfogFAWXxjwbJqwLX8ajhEU/L5z6O1el8JAVc84S2CGaNQwaPQDv4
        C8OUZpp4WGQvxs6dlh1ayRQ=
X-Google-Smtp-Source: ACcGV62wMVAP6NhyybzE4p418q6/gZWJ2KeC8OivxQVmJZ2eQf0NvaOpoX5ftoOJK3778w6XznTS6A==
X-Received: by 2002:adf:ef47:: with SMTP id c7-v6mr5988545wrp.182.1537983602328;
        Wed, 26 Sep 2018 10:40:02 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id h8-v6sm6640918wre.15.2018.09.26.10.40.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 10:40:01 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] worktree: add per-worktree config files
References: <20180923170438.23610-1-pclouds@gmail.com>
        <xmqqtvmdnuab.fsf@gitster-ct.c.googlers.com>
        <CACsJy8Bux0iiOp+zjELM4DuZwiQMA6EDaL0M71Jkp_qPACD8og@mail.gmail.com>
Date:   Wed, 26 Sep 2018 10:40:01 -0700
In-Reply-To: <CACsJy8Bux0iiOp+zjELM4DuZwiQMA6EDaL0M71Jkp_qPACD8og@mail.gmail.com>
        (Duy Nguyen's message of "Wed, 26 Sep 2018 17:48:48 +0200")
Message-ID: <xmqq4lecma32.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> I believe the main selling point of multiple worktrees is sharing
> refs. You could easily avoid expensive clones with --local, but
> synchronizing between different clones is not very convenient. Other
> than that, different worktrees tend to behave like separate clones.

OK.  Even with the enforced limitation that no single branch can be
checked out in multiple worktrees at the same time, it is more
convenient as you can "merge" other branch and trust that the result
on the checked-out branch in your worktree is immediately visible to
other worktrees.

> user has multiple worktrees, but the extension is not enabled. I'm

Exactly.  "config --worktree" in your script will silently break
other worktrees; it wanted to affect only the current worktree, but
it changed settings to all the others.

> probably not clear in the commit message, but "git config" can detect
> that the extension has not been enabled, automatically enable it (and
> move core.bare and core.worktree (if present) to the main worktree's
> private config), so "git config --worktree" will never share the
> change.

I wonder if that is good enough.  The user in one worktree did
"config --worktree" and all the worktrees now start diverging in
their config---but that is true _only_ when they use "--worktree"
option to say "I want this to be set differently from others".  All
the other calls to "git config" will stil be shared.

So from a cursory thinking, it sounds OK to me, but somebody else
may think of bad ramifications after a good night sleep.



