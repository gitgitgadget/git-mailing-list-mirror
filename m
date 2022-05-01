Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F4E8C433EF
	for <git@archiver.kernel.org>; Sun,  1 May 2022 19:38:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348473AbiEATlw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 May 2022 15:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237507AbiEATlv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 May 2022 15:41:51 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6F35FF3F
        for <git@vger.kernel.org>; Sun,  1 May 2022 12:38:25 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id n18so11070514plg.5
        for <git@vger.kernel.org>; Sun, 01 May 2022 12:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S3+kz1C1RUDXNhNw7b6eu9tfoR6ZQ816MawDNXM2nes=;
        b=YS1hvBYid/YD26LCf4DfZDdfNQgVJMXBq8/p/6/PEuMQ/2rzTAtAQspYSdRhIhaet3
         nBPXjr0C3GddkuQrTZNGKRvcwG8W6i2mTjohuQxpFbSl7dfRho/E5T+2sl+eh07wVeW2
         qQtcht36sLFgCnbHpi1DAxIj6jqJkffC5tY/S9s5S5C32iPrPJBRvkXVk7BtnPtC0rTN
         PVgCLiT22EtW6fFpNNzp0wJMhno1PcSGJB7Nl7W/6+5r/o04WX3M+fDvPtjYYAY6zp2A
         f96gz4Vg+G/hL7z9N0Q/q2GBiQPU3D8EbGulAwKbyfppDYYlu5y2aLyVhezHSEvwUjzi
         JHVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S3+kz1C1RUDXNhNw7b6eu9tfoR6ZQ816MawDNXM2nes=;
        b=8JrtY/oSUu1ESiS9HcFd0FGdV/k1qIgTSr6EV8NtZ1394iJGjidA8F4PbzJX9oaKTD
         XZS9s2Re+u2VrN5GPlp5k59p25Zghdguy7R9TAQpqTuO9B2FGskUalal8M4Le89a+/r5
         Z6pqM5CPqUksya6wMDHNPF+8jjzqWevbf4Ec9LawvV0lxq+qnRlZNwEnDGUetneaVnca
         ZzYy+sxIO1o/2EJi6JIj2BPlWEsHVYg8EitToE+hQ89uwYe6dJQheo0BIlIhZZpMtRFB
         bWAYChxImyKGlPAmutWos57fdYuPEfzq7YD6U8mkyvy0eajpSyn1voSXgtlaLvyXpZSp
         dO+A==
X-Gm-Message-State: AOAM531qZBcKrX3L7kcVpKOsJ+B4FevhAD25XEjeO036EH8K3U6EOeLy
        AF4cBRdPqt2MvuWmKS6EkrDyvnJR4vI=
X-Google-Smtp-Source: ABdhPJxh/8QdP1eV1qnBvj4tcp95HZKLm0/7OJr8y/0bzTedA+zG7B6f8M0tYK1nsnnSChf7GXkDvA==
X-Received: by 2002:a17:902:d044:b0:15c:eec0:2bc with SMTP id l4-20020a170902d04400b0015ceec002bcmr8611218pll.28.1651433904513;
        Sun, 01 May 2022 12:38:24 -0700 (PDT)
Received: from localhost.localdomain ([2409:4061:2dc8:74e2:b9d7:535d:3887:4f27])
        by smtp.gmail.com with ESMTPSA id y8-20020a17090a154800b001daac75511esm11897553pja.51.2022.05.01.12.38.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 01 May 2022 12:38:23 -0700 (PDT)
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Git <git@vger.kernel.org>
Subject: Re: [PATCH] builtin/remote.c: teach `-v` to list filters for promisor remotes
Date:   Mon,  2 May 2022 01:08:07 +0530
Message-Id: <20220501193807.94369-1-chakrabortyabhradeep79@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <xmqqfslt44di.fsf@gitster.g>
References: <xmqqfslt44di.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Junio C Hamano <gitster@pobox.com> wrote:

> You forgot to answer more important half of the question.  It would
> be easy for you to know what the string inside brackets means
> because you are so obsessed with the promisor remote to write this
> patch ;-) But when we need to add even more pieces of information in
> the future, will it stay so?  Can "[some-random-string]" easily be
> identified as a list-objects-filter by those who do not care
> particularly about promisor remotes (e.g. those who wanted to see
> the URL to tell multiple remote nicknames apart) when the line has
> even more piece of information in the future?
>
> At some point, we'd need to either (1) stop adding too many details
> to avoid cluttering the output line, or (2) start labeling each
> piece of information to make it easy for the readers to identify
> which one is which [*].  We need to ask ourselves why now is not
> that "some point" already.
>
>     Side note: and the strategy to add new pieces of information
>     need to take the same approach between the two, and that is why
>     we need "what is the plan to add new pieces of information?"
>     answered.

I am sorry if I failed to explain you what I really wanted to mean.
Yes, I forgot to answer the last question which is "When we
want to add new kinds of information other than the URL and the
list-objects-filter, what is our plan to add them?".

So let me answer this now. As `-v` flag gives a kind of overall summary
of the remotes, users expect that the most important and most basic
information should be listed in the output of `remote -v`. So, there
may be some other more important informations in the future that we
have to add to `remote -v` output. In that case, method (1) would not
be a great idea I think (unless a new flag has been created). method
(2) is better.

> > (i.e. which are promisor remotes and which are not) one by one. If the
> > user try to search for the promisor remotes in the config file, he/she
> > have to go through the other configuration settings (irrelevant to him/her
> > at that time) to reach the `[remote]` section. Isn't it?
>
> Sorry, but the question does not make much sense to me.  Why is a
> piece of information you get from "git config" irrelevant if you get
> it in order to figure out what you want to know, i.e.  what promisor
> remote do we rely on?

Let me explain what I really meant here - I am guessing that you have no
problem with the upper part of that para.

If we forget about my proposed change, there are two possible ways to find
out the info about promisor remotes - 
	(1) Use `git config --get remote.<remote-name>.partialCloneFilter`

	   This command gives an output only if <remote-name> is a promisor
	   remote. So in case the user forget which one is a promisor
	   remote, he/she has to try this command with each and every
	   <remote-name> to find out which is/are the promisor remote(s).

	(2) Open the git config file (either manually or by running `git
	    config --edit`

	    In this case, the user has to go through all the settings until
	    the [remote "<remote-name>"] section is found. E.g. let's say
	    below is the config file - 

	    [core]
        	repositoryformatversion = 0
        	filemode = true
        	bare = false
        	logallrefupdates = true
        	ignorecase = true
        	precomposeunicode = true
	    [remote "upstream"]
        	url = https://github.com/git/git.git
        	fetch = +refs/heads/*:refs/remotes/upstream/*
	    [branch "master"]
        	remote = upstream
        	merge = refs/heads/master
	    [remote "origin"]
        	url = https://github.com/Abhra303/git.git
        	fetch = +refs/heads/*:refs/remotes/origin/*
		partialCloneFilter = blob:none

	    To find out whether "origin" is promisor or not, he has to go
	    to the [remote "origin"] section. Here all the configuations
	    under `[core]`, `[remote "upstream"]` and `[branch "master"]
	    are irrelevant to him/her at that time (because he/she is not
	    interested to know about those configuration settings at that
	    time).

The proposed change is simpler compared to the above as it lists down all
the remotes along with their list-objects-filter. Another point is that
it's important for an user to know which one is a promisor remote and what
filter type they use. If we go with the current implementation the output
would be let's say - 
origin <remote-url> (fetch)
origin <remote-url> (push)
upstream <remote-url> (fetch)
upstream <remote-url> (push)

By seeing the above output anyone may assume that all the remotes are
normal remotes. If the user now try to run `git pull origin` and suddenly
he/she discover that some blobs are not downloaded. He/she run the above
mentioned (1) command and find that this is a promisor remote!

Here `remote -v` didn't warn the user about the origin remote being an
promisor remote. Instead it makes him/her assume that all are normal
remotes. Providing only these three info (i.e. <remote-name>, <remote-url>
and <direction>) is not sufficient - it only shows the half of the picture.


> The question is "what can readers achieve by having this extra
> information in 'remote -v' output".  Do you have to duck the
> question because you cannot answer in a simple sentence, and instead
> readers must read reams of documentation pages?  I doubt it would be
> that obscure.

Sorry, I misunderstood that section of your first comment. I think
I hopefully answered this question in the above portion of this comment.
Providing only the three information about remotes is not sufficient
as it do not distinguish between promisor remotes and normal remotes.
In that sense, it will add simplicity and the user would be much more
clear about the remotes(i.e. which is promisor remote and which is not).

> I wanted to like the patch, the changed text is simple enough, but
> quite honestly, the lack of clarity in the answers to the most basic
> "why do we want this? what is this good for? how does this help the
> users?" questions, I am not yet succeeding to do so.

My bad! Hope I am now able to answer all the questions you asked. Let
me know if you still struggle to get my point.

Thanks :)
