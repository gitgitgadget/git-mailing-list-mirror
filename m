Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85D1E20C11
	for <e@80x24.org>; Mon, 27 Nov 2017 17:21:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932317AbdK0RVe (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Nov 2017 12:21:34 -0500
Received: from mail-pl0-f42.google.com ([209.85.160.42]:36209 "EHLO
        mail-pl0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932281AbdK0RVc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Nov 2017 12:21:32 -0500
Received: by mail-pl0-f42.google.com with SMTP id b12so8856976plm.3
        for <git@vger.kernel.org>; Mon, 27 Nov 2017 09:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=izKPPcrMOOM7ZpZgRPQS6m2rVltLjxy8V8qvURgFtsY=;
        b=S0AdzaoSV6qwp66ChhTk8KxAzhJBsSc+L+3z22tTUCAi1nA7T8ErPP8oJiik72nVAc
         0AUnFwJYZeaCVqW6ueVuuqB2HPmvtrxVE93z8aG/X2d7uR1KEaYUgJxtUyLh9hnYEar3
         w4fHQ6L7CpW2Ied9uo5bchH+x6R9z3TDRfMHVPxEZtOV09zIri+81AbmOm2iQ6BjSIxn
         aUZ+zEUan4g6hXK3d/lCGhCTf+pR1CY896h8lQHFSZXvH/qq6vSylX6Lhy7JDdaDVSeG
         Jvzx6mwetl47NvmDkdnhskrkeTVbWwOdS4MnHgHQrs+L2t4AMrIJ2qnG3to6JQGG+PnF
         q9lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=izKPPcrMOOM7ZpZgRPQS6m2rVltLjxy8V8qvURgFtsY=;
        b=hl3L8JQX0tu1d9YljM9f+XF3gizBZY5SBNoHT2dvhmTexNYbgNrQ6ZDY/sAK1knPcd
         0f0IJ+Di2Tol1NQBncapVwQ+ISqFx+pPXfwrDSGq4VZcYEAXJ5aXb4K350hldw3JdXXc
         O3HxqPSmYKXYjAwc/6tQkBZ/6fSE/NhhmuV6gdr7VyTCc3811DvXv3u4H2vuutPQIYbF
         HyPqHQ8LPwWWmK4NN4radYV9YAFW0HozZ/H4bO0PjGAvztOO/1cqSaybnZ1l/u69390P
         aamPCnvUIscLiJRT549/TmdWeEScNlH31hcWkM9Q4Rzvt9EYHg6rY7yl6hslE9Cj3q5q
         MzEw==
X-Gm-Message-State: AJaThX6XCLQ0GNnA+i0FV0GCDV1mU+808Fe3NUSjsZDMHDbtitXbqg0L
        kJQzBNQ6oZhFRuBjZjv425MveRpa
X-Google-Smtp-Source: AGs4zMbJnqPzKFkOzbr2zYQ9C7H9m4RaMRwEoZdwCcwfcVlAWM7hlMreH6RhSBs2GWphU9XtePFWvw==
X-Received: by 10.84.204.136 with SMTP id b8mr38887759ple.319.1511803291883;
        Mon, 27 Nov 2017 09:21:31 -0800 (PST)
Received: from localhost.localdomain ([2405:204:73c7:b4fb:72c8:dd31:37ff:6021])
        by smtp.gmail.com with ESMTPSA id o88sm49573712pfj.175.2017.11.27.09.21.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Nov 2017 09:21:30 -0800 (PST)
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git mailing list <git@vger.kernel.org>
Subject: [PATCH v2 0/3] rebase: give precise error message
Date:   Mon, 27 Nov 2017 22:51:01 +0530
Message-Id: <20171127172104.5796-1-kaartic.sivaraam@gmail.com>
X-Mailer: git-send-email 2.15.0.345.gf926f18f3
In-Reply-To: <xmqq60a3xdpw.fsf@gitster.mtv.corp.google.com>
References: <xmqq60a3xdpw.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:
> Perhaps time to learn "git symbolic-ref HEAD" and use it instead of
> depending on the name?

Good point. Helped remove the assumption that there's no branch named HEAD.
(and indirectly led to 2 additional patches and the 3 questions found below ;-)


This started as a small fix to make 'git rebase' give a precise
error message when a rebase was done with a detached HEAD. Now it
includes a few cleanups that I caught while analysing the code.

There were a few weird observations when I was anlaysing the code.
They are listed below. Please give your thoughts about them.

The commands I use below were run on my local clone of 'git' and 'origin'
in this context refers to the git mirror at GitHub.

1. "git rebase <upstream> <remote_branch>" does nothing

I tried to play around with rebase by trying out various combinations while
analysing and found the following to have not effect even though the output
doesn't say anything about that,

$ git rebase origin/next origin/maint 
First, rewinding head to replay your work on top of it...
Fast-forwarded origin/maint to origin/next.

IOW, updating a remote branch with a remote upstream had no effect.
Though trying to update a remote branch with a remote upstream doesn't
seem to be very meaningful, the output says it HAS updated the remote
which seems to be misleading. What should be done about this?

2. It's possible to do "git rebase <upstream> <commit>"

$ git origin/next f926f18f3dda0c52e794b2de0911f1b046c7dadf"

This checks out the commit(detaches HEAD) tries to rebase origin/next
from there.

This behaviour doesn't seems to be documented. It says that only a 'branch'
can be specified. (The error message updated in 1/3 previously reported that
the 'branch' name is invalid rather than stating the 'ref (branch/commit) is
invlid')

 git rebase [...] [<upstream> [<branch>]]
 git rebase [...] --root [<branch>]
 ...

Shouldn't it have said that we can give any <ref> apart from <branch> instead of
saying we could give only a <branch>. If intentional, why?

3. "git rebase <upstream> <commit>" shows misleading message

$ git origin/next f926f18f3dda0c52e794b2de0911f1b046c7dadf"
Current branch f926f18f3dda0c52e794b2de0911f1b046c7dadf is up to date.

As it's clear the commit is not a branch. What should be done to fix this?


Kaartic Sivaraam (3):
  rebase: use a more appropriate variable name
  rebase: distinguish user input by quoting it
  rebase: rebasing can also be done when HEAD is detached

 git-rebase.sh | 46 +++++++++++++++++++++++++++++++---------------
 1 file changed, 31 insertions(+), 15 deletions(-)

-- 
2.15.0.345.gf926f18f3

