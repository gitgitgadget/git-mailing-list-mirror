Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B91AC4338F
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 10:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CA9360E78
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 10:50:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236947AbhHKKvD convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 11 Aug 2021 06:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232644AbhHKKvC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Aug 2021 06:51:02 -0400
X-Greylist: delayed 358 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 11 Aug 2021 03:50:38 PDT
Received: from mailproxy03.manitu.net (mailproxy03.manitu.net [IPv6:2a00:1828:1000:1108::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7633C061765
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 03:50:38 -0700 (PDT)
Received: from localhost (200116b86008d40055e599cb51dd17e8.dip.versatel-1u1.de [IPv6:2001:16b8:6008:d400:55e5:99cb:51dd:17e8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: michael@grubix.eu)
        by mailproxy03.manitu.net (Postfix) with ESMTPSA id F1A3112A0282;
        Wed, 11 Aug 2021 12:44:37 +0200 (CEST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20210811045727.2381-1-felipe.contreras@gmail.com>
References: <20210811045727.2381-1-felipe.contreras@gmail.com>
Subject: Re: [PATCH 0/7] [un]stage: officially start moving to "staging area"
From:   Michael J Gruber <git@grubix.eu>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Felipe Contreras <felipe.contreras@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
Message-ID: <162867867735.7067.8548435810107710895.git@grubix.eu>
Date:   Wed, 11 Aug 2021 12:44:37 +0200
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras venit, vidit, dixit 2021-08-11 06:57:20:
> In the last 13 years of discussions virtually *everyone* has agreed that
> the term "the index" is not a good approximation to how most users
> perceive and utilize this feature. For a summary of the discssions see
> my blog post [1].
> 
> This is particularly true of newcomers, which is why everyone that
> teaches git uses the term "staging area".
> 
> Among all the proposals for a better name "staging area" is by far the
> one with the most consensus.
> 
> Everyone except two people agreed that "the index" is not a good term.
> 
> All non-official documentation already uses the term "staging area" [2]
> [3] [4], including what is considered by most people the best
> documentation out there: the Pro Git book.
> 
> There is absolutely no reason not to start using the term "staging area"
> officially.
> 
> Let's start by making the staging area a first-class citizen and making
> 'git stage' a prominent command, similar to 'git branch'. Additionally
> add 'git unstage' too.
> 
> Only *one* person expressed discontent with the term "staging area".
> 
> In favor:
> 
> * Felipe Contreras
> * Scott Chacon
> * Jonathan Nieder
> * Matthieu Moy
> * Jeff King
> * Miles Bader
> * Ævar Arnfjörð Bjarmason
> * Jay Soffian
> * Pete Harlan
> * Aghiles
> * Piotr Krukowiecki
> * Phil Hord
> * Victor Engmark
> * David (bouncingcats)
> * Alexey Feldgendler
> * Alexei Sholik
> * Zbigniew Jędrzejewski-Szmek
> * Sebastien Douche
> * Thiago Farina
> * Mark Lodato
> * Philip Oakley
> * William Swanson
> * Ping Yin
> * Hilco Wijbenga
> * Lars Vogel
> * David A. Wheeler
> 
> [1] https://felipec.wordpress.com/2021/08/10/git-staging-area-rename/
> [2] https://git-scm.com/book/en/v2/Git-Basics-Recording-Changes-to-the-Repository
> [3] https://www.atlassian.com/git/tutorials/saving-changes
> [4] https://coderefinery.github.io/git-intro/04-staging-area/

Of the many possible ways to restart this discussion, calling out names
and pitching people against each other is quite possibly the worst.
Incidentally, this proves (again) what I wrote back then.

Git (the project) has always been about the strive for the "best"
solution, and different people have different views about the metrics
(technically sound, user friedly, consistency, backwards compatibility ...),
their scales and their relative weights - and the same is true for
judging a particular suggested solution in these metrics.

There are definitely more than two "staging camps" in this community -
you can come up with a count of "2" only if you conflate a multitude of
aspects, such as:

- use the term staging area in documentation
- scratch the term index from the documentation
- use "--staged" option aliases
- rename "--cached" option to "--staged"
- use "stage" command alias for "add"
- rename "add" to "stage" (and possibly revamp)
- use pseudorev STAGE (and dump "--cached")
- use pseudorev INDEX (and dump "--cached")
- one of the above plus WORKTREE
- ...

I would in fact think that this community is comprised of individuals
rather than camps, and that overall it does not object against the use of
"stage/staging area". At the same time, the fact that 13 years on we
still have the same "git diff --cached" etc. indicates that we never had
an alternative concept and implementation which the majority agreed on.
So, depending on how you conflate the aspects above into two, either the
"pro" or the "contra" camp consists of 1 person, and you can certainly
reach most 2-partitionings.

Just imagine someone who thinks purely in terms of "technically sound"
and "backwards compatible" (you know who you are ;) ): that person will
never be "pro stage" or "contra stage", but if they don't like your
implementation of "git stage" you will put them in the "contra camp",
giving up all chances of winning them over technically.

[As a side note, index might be more l10n-friendly than stage because of
its latin origin (so it's there in more languages already).]

I have been away from the project quite a bit (merely for lack of time),
but some people will remember me as striving for "consistency" in the UI
(e.g., favouring "git diff [HEAD] INDEX" over "git diff --cached [HEAD]").

Independent of my remarks about the restart of the discussion, I had a
quick glance at this series. The questions which arose already around
"stage/staged" seem to indicate that the series is more about renaming,
some reorganising but not so much about a fresh look at a consistent
user experience.

In other words (and to show a way forward), a cover letter with the
potential to bring many on board could start with:

##

It has been 13 years that we discussed about "the index", "the cache",
"staging" and the "staging area". There seemed to be overall consensus
that the concept of "put something on stage that is to be committed [to]"
serves well in training and documentation when we explain git's index
and related commands which change the index (git add) and compare to it
(git diff --cached).

Let's try and find a common ground for implementing this in user facing
commands. Here are a few possible appoaches:
- command/option aliases
- command/option renaming
- revamping of the command structure (as we did "checkout->switch")
- revamping the rev UI (from "--cached" to "INDEX" or "STAGE")
- you name it

To kick start this, here are a few more thoughts on some of these/an
example implemenation for one of these/...

##


Cheers
Michael
