Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E47F1F453
	for <e@80x24.org>; Mon, 29 Oct 2018 03:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729345AbeJ2MjM (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Oct 2018 08:39:12 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37900 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729308AbeJ2MjM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Oct 2018 08:39:12 -0400
Received: by mail-wr1-f65.google.com with SMTP id d10-v6so7066620wrs.5
        for <git@vger.kernel.org>; Sun, 28 Oct 2018 20:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=C3fjZ6Tx4S/RXFJOho2laAK1J+BgXSIgBPuxUbyedbI=;
        b=ChngvBZmVg0VvzJLi6iV1aShNsYr79J//XJhULCk2r9126SUl+iRYm5mXw5cnbn43D
         bio0o/wrLmstmfKZ+Q5eluPV2In3ICjJRTRRhqUAw3ef3ycnYfQbvqsxIloyhRh7Nkjh
         ap28R4uzadI4RxhAkiYuZUxAS6UI4bOOuH/tsgoFFukEr2K84l2/WfPAQgHjsmOjXyP9
         f9gCpAY2meZdmwvSL1FKc+GtiixTxJ+IliljjBcSYwO16qo+UR86tkyqwUBFXF5aFdMn
         vWK3GWV3EHgVT31uQr22tq/mQgQlNo1RJ8coVn8Sr6WSfiYNflRTZvzC7JsxYMXSdOWB
         YfvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=C3fjZ6Tx4S/RXFJOho2laAK1J+BgXSIgBPuxUbyedbI=;
        b=H7NUpZPrvu/7nXZ+fm+CpvxIDhO8IdD0y0+AQD1Lw01cm8DKCPFfrr4TXqc7zgN+hu
         2KqXSJn21a0uok2nE863AeEYH6kTngIlDXKYBsCYsyCNXsXqaTd8pCOtLjc5Ekd4+vLc
         0W/wm6pZnZR6yhPDa/NdANPVYdmLmz820mk8L2QgMwcxjxfB3S8nqGSSXoQ4ZeAipiUy
         XKYux72D9WOC4Oqiqtao99ZCnHY12uhM7xtOfU2exFQq1Arb+7Gi92LGuFtu5/GYaMkt
         AQynGeC9aeeJoJud5CBq8MhTI3FCDBGFDWlesLdBU+iUZXrn1LyzqGzVYhwoM7hWnynX
         ezsA==
X-Gm-Message-State: AGRZ1gLr3Y8knRW9rwsuxCd+jPq4SzL/Z5v87uNm9dpmAHSBFTZKo6rr
        VT4nza+O3viJ+fIl8rxR8iQ=
X-Google-Smtp-Source: AJdET5e8kGJB3aXW7uxb3+ZWoyWZ08ZVvvqy68CAIgbo6JHM+a6PN4ZJ+BzeewINgm+5qf8EHeXKww==
X-Received: by 2002:adf:e391:: with SMTP id e17-v6mr13009133wrm.321.1540785137897;
        Sun, 28 Oct 2018 20:52:17 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id i7-v6sm19897748wmd.41.2018.10.28.20.52.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 28 Oct 2018 20:52:16 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Nickolai Belakovski <nbelakovski@gmail.com>
Cc:     sunshine@sunshineco.com, git@vger.kernel.org
Subject: Re: [PATCH] worktree: refactor lock_reason_valid and lock_reason to be more sensible
References: <CAC05386F1X7TsPr6kgkuLWEwsmdiQ4VKTF5RxaHvzpkwbmXPBw@mail.gmail.com>
        <20181025055142.38077-1-nbelakovski@gmail.com>
        <xmqq4ldajz05.fsf@gitster-ct.c.googlers.com>
        <CAC05385y3fCdG4fd2ADahoE0iT+a5KvEr846UCUCQZMOtzzYGg@mail.gmail.com>
Date:   Mon, 29 Oct 2018 12:52:15 +0900
Message-ID: <xmqq36sp76kw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nickolai Belakovski <nbelakovski@gmail.com> writes:

> This is an improvement because it fixes an issue in which the fields
> lock_reason and lock_reason_valid of the worktree struct were not
> being populated.

If the field "reason" should always be populated, there is *no*
reason why we need the "valid" boolean.  They work as a pair to
realize lazy population of rarely used field.  The lazy evaluation
technique is used as an optimization for common case, where majority
of operations do not care if worktrees are locked and if so why they
are locked, so that only rare operations that do want to find out
can ask "is this locked and why?" via is_worktree_locked() interface,
and at that point we lazily find it out by reading "locked" file.

So it is by design that these fields are not always populated, but
are populated on demand as book-keeping info internal to the API's
implementation.  It is not "an issue", and changing it is not a
"fix".

In addition, if we have already checked, then we do not even do the
same check again.  If in an earlier call we found out that a worktree
is not locked, we flip the _valid bit to true while setting _reason
to NULL, so that the next call can say "oh, that's not locked and we
can tell that without looking at the filesystem again" [*1*].

You are forcing the callers of get_worktrees() to pay the cost to
check, open and read the "why is this worktree locked?" file for all
worktrees, whether they care if these worktrees are locked or why
they are locked.  Such a change can be an improvement *ONLY* if you
can demonstrate that in the current code most codepaths that call
get_worktrees() end up calling is_worktree_locked() on all worktrees
anyways.  If that were the case, not having to lazily evaluate the
"locked"-ness, but always check upfront, would have a simplification
value, as either approach would be spending the same cost to open
and read these "locked" files.

But I do not think it is the case.  Outside builtin/worktree.c (and
you need to admit "git worktree" is a rather rare command in the
first place, so you shouldn't be optimizing for that if it hurts
other codepaths), builtin/branch.c wants to go to all worktrees and
update their HEAD when a branch is renamed (if the old HEAD is
pointing at the original name, of course), but that code won't care
if the worktree is locked at all.  I do not think of any caller of
get_worktrees() that want to know if it is locked and why for each
and every one of them, and I'd be surprised if that *is* the
majority, but as a proposer to burden get_worktrees() with this
extra cost, you certainly would have audited the callers and made
sure it is worth making them pay the extra cost?

If we are going to change anything around this area, I'd not be
surprised that the right move is to go in the opposite direction.
Right now, you cannot just get "is it locked?" boolean answer (which
can be obtained by a simple stat(2) call) without getting "why is it
locked?" (which takes open(2) & read(2) & close(2)), and if you are
planning a new application that wants to ask "is it locked?" a lot
without having to know the reason, you may want to make the lazy
evaluation even lazier by splitting _valid field into two (i.e. a
"do we know if this is locked?" valid bit covers "is_locked" bit,
and another "do we know why this is locked?" valid bit accompanies
"locked_reason" string).  And the callers would ask two separate
questions: is_worktree_locked() that says true or false, and then
why_worktree_locked() that yields NULL or string (i.e. essentially
that is what we have as is_worktree_locked() today).  Of course,
such a change must also be justified with a code audit to
demonstrate that only minority case of the callers of is-locked?
wants to know why


[Footnote]

*1* The codepaths that want to know if a worktree is locked or not
(and wants to learn the reason) are so rare and concentrated in
builtin/worktree.c, and more importantly, they do not need to ask
the same question twice, so we can stop caching and make
is_worktree_locked() always go to the filesystem, I think, and that
may be a valid change _if_ we allow worktrees to be randomly locked
and unlocked while we are looking at them, but if we want to worry
about such concurrent and competing uses, we need a big
repository-wide lock anyway, and it is the least of our problems
that the current caching may go stale without getting invalidated.
The code will be racing against such concurrent processes even if
you made it to go to the filesystem all the time.

