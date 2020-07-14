Return-Path: <SRS0=b2TE=AZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DAD1C433E0
	for <git@archiver.kernel.org>; Tue, 14 Jul 2020 03:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4085921927
	for <git@archiver.kernel.org>; Tue, 14 Jul 2020 03:51:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i38xUMIc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbgGNDvL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jul 2020 23:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbgGNDvK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jul 2020 23:51:10 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4EBFC061755
        for <git@vger.kernel.org>; Mon, 13 Jul 2020 20:51:10 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id a6so1411602pjd.4
        for <git@vger.kernel.org>; Mon, 13 Jul 2020 20:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=A1enaDhjmX6zJcrYsdjlQNlLUkdLZnmcyITJxFDw57U=;
        b=i38xUMIcwbg2g8TLMeRgCBJEfu6IKhSb+0tU3dvGiV/OrGAdmtrza/A9zPpRoFsubv
         sl+HtLhfcyLFkn+ctMJqNkRqQHuXou76VSyqKUx8Wj7nL6q40t3//gTARN0xU1gLVOE7
         kjAQp88QTZmIIMtvLvlJYjElecwigiMh9zc4v17XSM7FooGuXeYoymiVAeAFDX5UzDSe
         lo/aHrxmAB8HdrtoZFqHQc7s5MS6NN6OUHTQ4be662UTMA538gv1vhRKyiZ4i29dXekL
         mrRJH1YyiRvoFuE4/9QtUkRHPjr4dPng0qATBmTRWFisT+D7ZMyN0A/pqq8sjwvlMwzO
         kNQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=A1enaDhjmX6zJcrYsdjlQNlLUkdLZnmcyITJxFDw57U=;
        b=WSs/5+KpJc0E0mYoMwORLEIb5m5TEOFxicC0WdQzg45jvhCYNVdJFLpXH20p/s4kjE
         DBQ7pTUG2HLDM0wxA0MNiY0tT2AgGJe3p50Dhayn0CVC4Uqg9knjlNtu9+c8pdvU9Lja
         kbs9CoE6ms7vOgvDid1GVtVSFlIJ3JDXn7GgTQuLxfoX4OJKn3jcW2IV11aeqt4FW8Z0
         IywSr0Ux88asTHf7W7e6pQ0UJfgRIKSsvETcJxU/X1VMzj9dl4U7CLjneMHi57Uox0s7
         S0vgZ3LpYhXRMsvFYJp/Pp4wGXC1w86Et/3UNhVyIfhKKMuyax8J/a1ZxbqVqU7W+qNc
         ox+w==
X-Gm-Message-State: AOAM532gHgXIXg6eHa5eVqODKB1iRRffAMs8uxWJiPWLAZkZNepw5jdq
        iGjidJrNLWPn4iSAEbnMBFMta7a0DZmYbVXyqzB+
X-Google-Smtp-Source: ABdhPJw0apI/os241XVHfzITEvrYd5J3xyTW1j6MtqIsvI0i7I9zUQsiumeTSECyEsEzK4ae3+1NlLQwGayytVO1w3cu
X-Received: by 2002:a17:90a:2b8f:: with SMTP id u15mr2478250pjd.98.1594698670101;
 Mon, 13 Jul 2020 20:51:10 -0700 (PDT)
Date:   Mon, 13 Jul 2020 20:51:04 -0700
In-Reply-To: <20200714031017.GA15143@generichostname>
Message-Id: <20200714035104.1465772-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20200714031017.GA15143@generichostname>
X-Mailer: git-send-email 2.27.0.389.gc38d7665816-goog
Subject: Re: [RFC] should `git rebase --keep-base` imply `--reapply-cherry-picks`
 ?
From:   Jonathan Tan <jonathantanmy@google.com>
To:     liu.denton@gmail.com
Cc:     levraiphilippeblain@gmail.com, git@vger.kernel.org,
        sunshine@sunshineco.com, avarab@gmail.com,
        Johannes.Schindelin@gmx.de, jonathantanmy@google.com,
        newren@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > Is this a sane default ? I understand that it is a good default when we are rebasing 
> > *on top* of master, but here I'm just doing some squashing and fixup's and I did not
> > want the commit I had cherry-picked from master to disappear (yet). In fact, because it
> > was dropped, it created a modify/delete conflict because in a subsequent commit 
> > in my feature branch I'm modifying files that are added in the commit I cherry-picked.
> 
> So if I'm not mistaken, if we have the following graph
> 
> 	A - B - C - D (master)
> 	     \
> 	       - C' - D (feature)
> 
> and we do `git rebase --keep-base master` from feature, C' will be
> dropped? Indeed, I am surprised by how this interacts with the
> default setting of --reapply-cherry-picks.

Just to clarify, the default setting is --no-reapply-cherry-picks. (I
understand that the naming is confusing - the name was discussed quite a
bit [1].)

[1] https://lore.kernel.org/git/20200309205523.121319-1-jonathantanmy@google.com/

> > How would a change that made '--reapply-cherry-picks' be the default when using 'keep-base'
> > be received ?
> 
> I'm somewhat surprised that --no-reapply-cherry-picks is the default. I
> would argue that it _shouldn't_ be the default at all. It's an
> optimisation for when no --onto or --keep-base are specified but it
> definitely can cause problems otherwise, as we've seen.

When I encountered this feature, it was a surprise to me too, but this
has been documented as a feature for a long time (e.g. see the man page
for 2.1.4 from 2014 [2] - search for "RECOVERING FROM UPSTREAM REBASE").

[2] https://git-scm.com/docs/git-rebase/2.1.4

> I think I would argue for the following in decreasing order of
> preference:
> 
> 	1. Make --no-reapply-cherry-picks the default in all cases.
> 	   (Those who need the optimisation can enable it manually and
> 	   we can add a configuration option for it.)

I assume you mean "make --reapply-cherry-picks" the default (since
earlier you said that you were surprised that --no-reapply-cherry-picks
is the default)? Also what do you mean by "optimization"?
--reapply-cherry-picks is faster because it does not need to read the
upstream commits (optimization for speed) but --no-reapply-cherry-picks
fits some people's workflow better (optimization for workflow).

> 	2. Make --no-reapply-cherry-picks only active if no --onto or
> 	   --keep-base are given (--keep-base is a special case of --onto
> 	   so we only have to handle it in one place).

This might be confusing - I wouldn't expect "git rebase master" and "git
rebase master --onto master" to have different behavior.

> > Tangential question: in any case, would it make sense to still add the "dropped because 
> > already upstream" commits to the todo list, in the case of an interactive rebase ? 
> > (maybe commented out, or listed as 'drop' with some kind of comment saying those 
> > are dropped because they appear textually upstream?)
> 
> That would make sense to me. I don't have a preference between either.

This makes sense to me too.
