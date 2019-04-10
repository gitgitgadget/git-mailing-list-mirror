Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80E7420248
	for <e@80x24.org>; Wed, 10 Apr 2019 04:40:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbfDJEkX (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Apr 2019 00:40:23 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37143 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbfDJEkX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Apr 2019 00:40:23 -0400
Received: by mail-wr1-f65.google.com with SMTP id w10so1178095wrm.4
        for <git@vger.kernel.org>; Tue, 09 Apr 2019 21:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=srcudvGKPhBqlVQA6iiyGqEfv4laLstHxo3+JNg2mes=;
        b=HSEIE1uBpXpZc09fCS9dWRrVV/Yyjz6gl7XI1mZkKlCsc21KvW+hgBCcMUcG+QiVuu
         YNjpMdE5foHy+jJuiXlYGz+KEA/Ou0W1zZGDiAojQ/6krUqxuSoJrVAp1416XhhGRoSW
         M8KP/dBMqyzOw6qnbhUEgf1kzlsoxHSSydn8fYlzB2iL6pDTnABvZEnRBYLaMCgqFc2g
         kwinowkz2yP9d0Fl/MJTmCPjoHRyxI3mr413ZYOKfUHTHm3wRdOdyRHpPVwT9EemhcFg
         OEeFv7Z0nd0EQw9q/Sw3yKoFLiZJBc4EKEpRvmafQEBYy0YcA+qODJqCpmfCR/R6GyaH
         cUyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=srcudvGKPhBqlVQA6iiyGqEfv4laLstHxo3+JNg2mes=;
        b=j90oP69Rm5D9lo7AHPO5o95cn9RiYSyDaOj2ShirUyIIKDiNXzqRJNnVgWQ5GdcNbz
         yR/VFWdUtpzmCVMB+QjRTgLrMKAR+rxfIZuHSb0AFgpa1BMf5gvrrJFqCQTyv8J0zvrd
         XCakrXNLz4PoQ0zKm/7bhLX+Ro+8rP2XeDnqd5yST+mfpDa+NN44JqBzY9avNO8oTdIh
         a0VU9XIgtcGAFnVv3P2H150hwlum/0w4yY68dCdNy6oqloAjOeUyQmE2SANFFVWql/U8
         eLXag6QBXiJxO4V3hPT6w1v5ly3hWsxxeyTLvbdgksO8YzLPDeaAJJIZ0XKcm6aQwI5d
         4Jog==
X-Gm-Message-State: APjAAAWx4z1VxXVJlYJAcDAim1ZCo8PvVbCJ6IkXR0PiVDiB6D9zNGKN
        ojGFrdfdNggdjTqq6LTZpL6KPxmiUbQ=
X-Google-Smtp-Source: APXvYqx2gcE3g0fyVGLTUfi77HfVrlHT0YLOzskbUpHakEROKCeE1G9EzyUai0hXfNqGPXkuc1Uc9A==
X-Received: by 2002:a5d:4a43:: with SMTP id v3mr3149296wrs.126.1554871220605;
        Tue, 09 Apr 2019 21:40:20 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id e16sm52605814wrs.0.2019.04.09.21.40.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Apr 2019 21:40:19 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kapil Jain <jkapil.cs@gmail.com>
Cc:     git <git@vger.kernel.org>, Thomas Gummerer <t.gummerer@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [GSoC] [RFC] Proposal: Teach git stash to handle unmerged index entries.
References: <CAMknYEMh=CN6GGRPD_fkafHy84e49JY5dK2dAgX6Z7542dJ-Uw@mail.gmail.com>
Date:   Wed, 10 Apr 2019 13:40:19 +0900
In-Reply-To: <CAMknYEMh=CN6GGRPD_fkafHy84e49JY5dK2dAgX6Z7542dJ-Uw@mail.gmail.com>
        (Kapil Jain's message of "Tue, 9 Apr 2019 21:09:25 +0530")
Message-ID: <xmqqo95e1nik.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kapil Jain <jkapil.cs@gmail.com> writes:

> Plan to implement the project.
>
> Objective:
>
> Description:
>
> Implementation Idea:
>
> Relevant Discussions:
>
> Idea Execution Plan: Divided into 2 parts.

Two things missing before implementation idea are design, and more
importantly, the success criteria.  What lets you and your mentor
declare victory?

As to the design, it does not quite matter if you add four or more
separate trees to represent stage #[0123] entries in the index to
the already octopus merge commit that represents a stash entry
(i.e. when keeping the untracked ones, I think the stash entry's
"result of the merge" tree records the state of the tracked files in
the working tree, and the "result of the merge" commit records the
the-current HEAD, a commit that records the state of the index and
anothre commit that records the state of the untracked files, as its
parents---that's already a 3-parent octopus).

The fact that a stash entry is represented as a merge commit is a
mere implementation detail, and there is *NO* need to worry about
resolving merge conflicts while recording a stash.  If the result of
this GSoC task is to be any usable together with the current version
in a backward compatible way, you must record these extra states as
extra parents of the merge, so it is sort of given already that
you'd be using some form of an octopus merge.

The real challenge would be how the unstashing part of such a stash
entry that records unmerged state should work.  Personally I do not
think it will be very useful to allow unstashing such a stash entry
on top of any arbitrary commit---rather, I suspect that the user
would want to come back to the exact HEAD the user had trouble
resolving conflicts at, without having to first checking it out.
IOW, a usual way to use "git stash" is

	$ git checkout topic
	$ edit edit edit
	... I am happily hacking away ...
	... the boss appears with an ultra-urgent task ...
	$ git stash save -m WIP
	$ git checkout master
	$ edit-and-build-and-test
	$ git commit
	... now the emergency is over ...
	$ git checkout topic
	... sync with the work others may have done on topic
	... while I was dealing with the boss
	$ git pull --rebase origin topic
	$ git stash pop

IOW, it is expected to be applied on top of an updated commit.

But I have a moderately strong suspicion that a stash that holds
unmerged state (i.e. a conflicted merge in progress) is created with
a use case, which is very different from the normal use case, in
mind.  When creating such a stash entry, the above sequence would go
more like this:

	$ git checkout topic
	$ git merge ...
	... oops, conflicted, and it takes time to resolve ...
	$ edit edit inspect edit
	... the boss appears
	$ git stash save -m "Merge in progress"
	$ git checkout master
	... deal with the emergency the same way ...
	$ git checkout topic
	... go back to the conflict resolution first without
	... touching what may have happened on the branch in
	... the meantime---a human brain cannot afford to deal
	... with two or more parallel conflicts at the same
	... time.
	$ git stash pop
	... now deal with the conflict we were looking at
	... before the boss interrupted us.
	$ edit inspect edit
	... be satisfied with the result
	$ git commit
	... now let's see if others have something else that
	... is interesting
	$ git pull --rebase origin topic

And if we assume that the primary use of a stash for a conflicted
state is to bring us back to the exact state (rather than allowing
us to pretend as if we started form a different HEAD), it might even
make sense to teach "git stash pop" step to barf if HEAD does not
match the first parent of the merge commit that represents the stash
entry being applied (again, stash^{tree} is the working tree,
stash^1 is then-current HEAD).  That would make the application side
a lot simpler and manageable by developers who are not intimately
familiar with the code.

Others may disagree with the above assumption (i.e. "a stash for a
conflicted state does not have to be applicable), though, making
your task a lot harder ;-).

Quite honestly, I do not think you can design a system that attempts
to "stash apply/pop" a recorded unmerged state on top of any
arbitrary HEAD and leave a state useful for the end user to deal with
when the "stash apply/pop" step itself introduces _new_ conflicts
due to the differences between the then-current HEAD the stash entry
is based on and the HEAD the "stash apply" is attempted on top of.
Even the current "stash apply/pop with the change between the HEAD
and the index" does punt when it cannot make a clean application,
and that is without any unmerged entries in the recorded index
state.

The key point is "a state useful for the end user"---it is easy to
build a system that claims to leave a state created from the updated
HEAD and what's recorded in a stash entry that the end users cannot
use as a stating point to make progress, but that is not something
our users would want.

Have fun.
