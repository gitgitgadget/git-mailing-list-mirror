Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B33C433FE
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 19:45:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbiJUTpN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 15:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbiJUTpI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 15:45:08 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327594C2C5
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 12:45:04 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id lx11-20020a17090b4b0b00b0020d7c0b426dso4654297pjb.6
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 12:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fEfeExrjPg4BOKYwnVepJm8zW/myM5X1hR6Kr2HyW3k=;
        b=mV6jrD3PxnMutcHXSTlqsb7wbu76MCtxMnh/D5RI76qBfH4OGPkAsFIuHVYMkCGctz
         kK77GyAv59OVYc3W4hlya3gc5URNbIcDr8EOzN7Yez2TWmVa5UOseMHrY61Nm7b4H1+4
         YgMIHW9ErT04EucFq4n+60471V1Cbg4OLdmmh4tbhdXtw+2OHgw8BEBklkAujJNoOTOW
         Zytc4q7bZlkALHbLjWNF7Lw324PCLFYlc8JIjWVrJtYAkTcqUWjAYbtyElwiHljKcoUY
         EnKHIBzH2hE99tQqzkccH7C/GKnMD4MDGsUJiT+fkDsvlA+IWqatxIGBK2QqDVs1YdmZ
         /Bzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fEfeExrjPg4BOKYwnVepJm8zW/myM5X1hR6Kr2HyW3k=;
        b=0b7CHr1xCOUzbL8YaNPhztkznIZvd1gK+BprDyjH3AunbOI/oI2WTozOryUF85XXmW
         7s7ImMscJ3DOQZayIuCSDV6ooGcKYrT3N7ujYstCwJNqyxzGfXS5pCPrUo0Bpq88V7na
         qYXNXcXNmlIs8C4DoQtEvNsPY9aLEGAHJJ0It7BfgTEQdx8x839GhA7Jj/EcM46DGvv1
         H8iYoAP1zPLWBbVc1Nvn1Q8zg4wmXvcFt3ny11mVernO/zGOvaiihneQRirdqyj9AFEh
         WPJK6mrOBcVFoQtcpu0BP/h3iifHvvLEaFAfLj0oeS5I41MwGE2JWsYSa/n80Xctud6s
         EyBw==
X-Gm-Message-State: ACrzQf27tFFshnbnGtI+KheoS7+wssWmHNFZQ3ZEJo2X5kvmQlbbKb+P
        i883uc1p1MKq3r9EQjE0tug3JByLjjebYQ==
X-Google-Smtp-Source: AMsMyM7BX764xA58nUXLcwwWAJgTuFJpycDzwf/Ou3wvkQOSUay0tI8vdQTsJYsIetuB+ZJqwEeWnHAcVXaaaQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:2491:b0:565:998b:90ac with SMTP
 id c17-20020a056a00249100b00565998b90acmr21242432pfv.65.1666381503709; Fri,
 21 Oct 2022 12:45:03 -0700 (PDT)
Date:   Fri, 21 Oct 2022 12:45:02 -0700
In-Reply-To: <Y1ImS1Muvk1MAQeC@coredump.intra.peff.net>
Mime-Version: 1.0
References: <xmqqa65rnuvv.fsf@gitster.g> <Y1Hy9n7E1/yWKkYv@newk> <Y1ImS1Muvk1MAQeC@coredump.intra.peff.net>
Message-ID: <kl6lczalx8ox.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: What's cooking in git.git (Oct 2022, #06; Wed, 19)
From:   Glen Choo <chooglen@google.com>
To:     Jeff King <peff@peff.net>, Michael McClimon <michael@mcclimon.org>
Cc:     "Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?=" <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Oct 20, 2022 at 09:16:38PM -0400, Michael McClimon wrote:
>
>> > * mm/git-pm-try-catch-syntax-fix (2022-10-17) 1 commit
>> >  - Git.pm: add semicolon after catch statement
>> > 
>> >  Fix a longstanding syntax error in Git.pm error codepath.
>> > 
>> >  Will merge to 'next'??
>> >  source: <20221016212236.12453-2-michael@mcclimon.org>
>> 
>> I am not totally sure what these question marks mean, but I'm happy for
>> this to go to next, for what it's worth. (There was an outstanding
>> question about the general behavior of Git.pm in bare unsafe
>> repositories, but I certainly am not planning to solve it in this
>> series.) Thanks!
>
> Me too. I had hoped for a test, but because of those outstanding
> questions about the behavior, I think we are better off skipping it for
> now, and fixing what is obviously a bug.
>
> There is one devil's advocate thing that is nagging at me, though.
> Because this whole safe-directory thing is security-relevant, could we
> make things worse by "fixing" it partially? That is, consider
> this code:
>
>   git init --bare foo.git
>   sudo chown -R nobody foo.git
>   cd foo.git
>   perl -MGit -e 'Git->repository'
>
> Post 2.35.4, etc, is it a security vulnerability for that final step to
> open the repository? If so, then right now we are "not vulnerable" in
> the sense that an unrelated bug causes Git.pm to bail in the final step.
> And fixing that will mean we become vulnerable.
>
> To be clear, having an unrelated bug is not a good way to prevent
> security vulnerabilities. But it is the status quo. If the fixed version
> (after your patch to add the semicolon) is vulnerable, but the released
> one in the hands of users is not, then fixing it does make things worse
> in the short term (even though the obviously correct thing in the long
> run is to fix that bug and also correct the vulnerability the right
> way).
>
> I wasn't around when the directory-ownership stuff was discussed or
> worked on. But it might be nice for people who worked on it or thought a
> lot about it to give an opinion on whether the state after your patch is
> in fact vulnerable to a security flaw.

Off the top of my mind, the safe.* protections mitigate:

1) safe.directory: Attacker creates a difficult-to-spot repo high in the
   directory structure in a shared machine, and the victim navigates
   into an innocuous-looking directory that happens to be a subdirectory
   of that repo.
2) safe.directory: Attacker creates a repo somewhere on a shared machine
   and tricks the victim into navigating into that repo.
3) safe.bareRepository: Attacker creates a repo with a bare repo in its
   working tree and tricks the victim into cloning the repo and
   navigating into the bare repo.

In each of these cases, having the user specify GIT_DIR to mean "yes
this directory is really the one I wanted" is a reasonable tradeoff IMO.
Some ways of setting GIT_DIR might be ok, e.g. GIT_DIR=. everywhere is
pretty flawed for 2 and 3, but it does mitigate against 1 (which is
arguably the scariest).

However, if GIT_DIR is set by searching for the repo (e.g. by "git
rev-parse --git-dir"), this just disables every safe.* protection. IIRC,
you mentioned that this is exactly what Git.pm does, so as it is, yes
this does leave us in a vulnerable state.

If we are using `git rev-parse --git-dir`, maybe a reasonable solution
would be to teach `rev-parse` to respect safe.* protections? e.g. `git
rev-parse --git-dir --safe` could error out just like `git` in an unsafe
repository.

[1] https://lore.kernel.org/git/Y02SHlW1rNQdfCHI@coredump.intra.peff.net

>
> -Peff
