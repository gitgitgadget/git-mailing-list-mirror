Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5E6B1FAF4
	for <e@80x24.org>; Wed,  8 Feb 2017 22:56:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751815AbdBHW42 (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 17:56:28 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35503 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751235AbdBHW41 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 17:56:27 -0500
Received: by mail-pf0-f196.google.com with SMTP id f144so12351702pfa.2
        for <git@vger.kernel.org>; Wed, 08 Feb 2017 14:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=OleAhtG7W1BE9MT85e9DesLzVIHcXbZ33k54fRXIM8E=;
        b=AMtQQ00gjA+N6R1sr97aRJezz8UnAfzUqgKclBHlPNsCKrwmJcx3Da39INGj6Lw4vg
         qvpqduaSxk9Ct8Rti0tih5RYBxO0W7uPr5AkU+qv/U5smmp+HzAtxrsDr78FNFCRidPy
         lLuHWhjx3R1s3WwOHtizYuMnaAEZvtm0014IUgsaaazhwyUF5W9i+oKVWQ71ikmqKfml
         638I9tXOaw4x4siuC97NaQu1UKiDPgcJ/RvN9tKFhXzbepYE989J54i4GuobD2Qd9MZQ
         6SDYZDUQCm2ij34/9WsB4TqXF3cqdP9ft+/37FTzOyMnYCnh5wjXrr4Xv1+Y3d3heFCS
         g0jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=OleAhtG7W1BE9MT85e9DesLzVIHcXbZ33k54fRXIM8E=;
        b=rA7BoA/qofq2GjSPCyB1Nbz62MMVRqjBYr6L2F9N41ohTV6WULRGvtAX1kMiNmuPAG
         H/3J7d9OKQ2JfneTpMhgR1iXTNhD1+yW9rcKXVhOKHIFqC9ibhwU3O90wUhu0FL305zf
         R+e7S4rE7vRE8YUsfpHxndGstxwoCb8r9vFdYTUhXRNCGyNVyBwy745Fo+lYsAwYFu+w
         rkFJLpQkuyGzZGjP1KKPUmoRXZ7Uts6O4ZOX4RAz30nlMnPwWOwNnXrflrP0sEMoHyMI
         RjCrEc1bc0IyNucP/EWqa/7S5FwTU/rhAHRXH0N/n6ghhLkTa8Omr3wrLlc/qLh5JirF
         xMAw==
X-Gm-Message-State: AIkVDXLwyWltm0oPW+Jag300ctHHcdeBBWh7RCMVH1IjAPPiyO/RDTZaT2sTRG709V2hYA==
X-Received: by 10.98.133.11 with SMTP id u11mr28745431pfd.132.1486594552228;
        Wed, 08 Feb 2017 14:55:52 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:7c20:fa7c:46cb:2209])
        by smtp.gmail.com with ESMTPSA id q22sm22852029pfj.77.2017.02.08.14.55.47
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 08 Feb 2017 14:55:47 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ashutosh Bapat <ashutosh.bapat@enterprisedb.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Michael J Gruber <git@drmicha.warpmail.net>,
        Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Bug with fixup and autosquash
References: <CAFjFpRe8zqxs4OLbCrjnuEzF=75sbBJ+HuZqek49B=O=TFHq8A@mail.gmail.com>
Date:   Wed, 08 Feb 2017 14:55:47 -0800
In-Reply-To: <CAFjFpRe8zqxs4OLbCrjnuEzF=75sbBJ+HuZqek49B=O=TFHq8A@mail.gmail.com>
        (Ashutosh Bapat's message of "Wed, 8 Feb 2017 15:40:07 +0530")
Message-ID: <xmqqbmucuwb0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ashutosh Bapat <ashutosh.bapat@enterprisedb.com> writes:

> I have been using git rebase heavily these days and seem to have found a bug.
>
> If there are two commit messages which have same prefix e.g.
> yyyyyy This is prefix
> xxxxxx This is prefix and message
>
> xxxxxx comitted before yyyyyy
>
> Now I commit a fixup to yyyyyy using git commit --fixup yyyyyy
> zzzzzz fixup! This is prefix
>
> When I run git rebase -i --autosquash, the script it shows me looks like
> pick xxxxxx This is prefix and message
> fixup zzzzzz fixup! This is prefix
> pick yyyyyy This is prefix
>
> I think the correct order is
> pick xxxxxx This is prefix and message
> pick yyyyyy This is prefix
> fixup zzzzzz fixup! This is prefix
>
> Is that right?

Because "commit" pretends as if it took the exact commit object name
to be fixed up (after all, it accepts "yyyyyy" that is a name of the
commit object), it would be nice if the fixup is applied to that
exact commit, even if you had many commits that share exactly the
same title (i.e. not just shared prefix).

Unfortunately, "rebase -i --autosquash" reorders the entries by
identifying the commit by its title, and it goes with prefix match
so that fix-up commits created without using --fixup option but
manually records the title's prefix substring can also work.  

We could argue that the logic should notice that there is one exact
match and another non-exact prefix match and favor the former, and
certainly such a change would make your made-up example (you didn't
actually have a commit whose title is literally "This is prefix")
above work better.

But I am not sure if adding such heuristics would really help in
general.  It would not help those whose commits are mostly titled
ultra-vaguely, like "fix", "bugfix", "docfix", etc.

Another possibility is to teach "commit --fixup" to cast exact
commit object name in stone.  That certainly would solve your
immediate problem, but it has a grave negative impact when the user
rebases the same topic many times (which happens often).

For example, I may have a series of commits A and B, notice that A
could be done a bit better and have "fixup A" on top, build a new
commit C on it, and then realize that the next step (i.e. D) would
need support from a newer codebase than where I started (i.e. A^).

At that point, I would have a 4-commit series (A, B, "fixup A", and
C), and I would rebase them on top of something newer.  I am
undecided if that "fixup A" is really an improvement or unnecessary,
when I do this, but I do know that I want to build the series on top
of a different commit.  So I do rebase without --autosquash (I would
probably rebase without --interactive for this one).

Then I keep working and add a new commit D on top.  After all that,
I would have a more-or-less completed series and would be ready to
re-assess the whole series.  I perhaps decide that "fixup A" is
really an improvement.  And then I would "rebase -i" to squash the
fix-up into A.

But notice that at this point, what we are calling A has different
object name than the original A the fixup was written for, because
we rebased once on top of a newer codebase.  That commit can still
be identified by its title, but not with its original commit object
name.

I think that is why "commit --fixup <commit>" turns the commit
object name (your "yyyyyy") into a string (your "This is prefix")
and that is a reasonable design decision [*1*].

So from that point of view, if we were to address your issue, it
should happen in "rebase -i --autosquash" side, not "commit --fixup"
side.

Let's hear from some of those (Cc'ed) who were involved in an
earlier --autosquash thread.

https://public-inbox.org/git/cover.1259934977.git.mhagger@alum.mit.edu/


[Footnote]

*1* "rebase -i --autosquash" does understand "fixup! yyyyyy", so if
    you are willing to accept the consequence of not being able to
    rebase twice, you could instead do

	$ git commit -m "fixup! yyyyyy"

    I would think.
