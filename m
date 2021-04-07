Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B46C433B4
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 07:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8EC160BD3
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 07:53:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbhDGHxr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Apr 2021 03:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbhDGHxr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Apr 2021 03:53:47 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB29BC06174A
        for <git@vger.kernel.org>; Wed,  7 Apr 2021 00:53:36 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id p4so9404030edr.2
        for <git@vger.kernel.org>; Wed, 07 Apr 2021 00:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=SqwRWFabL0d8/Bttp230cMC/bPEPvhgwipXhDAQIt2s=;
        b=H474ItVOXYnJAB6wR0G4cL5fqCN053zNkcFSsM1vOx5c3qnvWlVV1Kw1liXw15/iQ2
         tFdRmB7UO5Fjk+0VdBv2ODOG/MVWSh2ug/AXDhKOO+pJKhHCAJD9aWd/PM4A00FVLxzX
         XaNUBV1gMl727AFLLj2Ut0RSaUrKi0ZYY8PjPWiCUzg8Q4kc2SmOwG/W1wvoFGVJWxrZ
         94CQL1OsHVBL0FYVd3scf8yfo0PvMjgXeb0xIgAaRmTQJOOrpBMJKqCWSV/JiMwchstH
         j0BygWmoIJX3rJTNiF/94jbjNAZ8mweRig0WnwnRV14n9VD90ccSghC/FTo1rJfu1p5q
         zAVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=SqwRWFabL0d8/Bttp230cMC/bPEPvhgwipXhDAQIt2s=;
        b=kb76Mb758T2DUXCNRHOA3pb2rWS2INywKvQJlp6q++TVou2hQqoI5sA7il1eAU8EN2
         Sq+iZbzZZ8RugKcU2mQwHCFTlzedK1Lz9fnqROckr+etRmZeVBrr+gF61EuRjH5X/DWN
         rcv05T+Axb+tfNzk+d60dMQVaJZY9oQUiKF2pS9E8fd4EwWndnRj49dhcSdWpX5Rpq+M
         YNuuwn0keH5DnmqWLP7KaG0mo+ilq3Q18ycxzweBV/DTveeavrHamvXdhH640rNOUaSG
         b6M3SaS9xX9apHIjCvTaERYO+qFPTQpMUTGWRuZN5qEBT88HgXmM9wKsCBPXWPQPCcdC
         IOgg==
X-Gm-Message-State: AOAM530qzP4CxyBaU8jEKlHx7CHmCkYZVEFFPkrvS1pyQc9ruLn9veUN
        SyfI364sYKpklHglceIHU+A=
X-Google-Smtp-Source: ABdhPJzU+td1ygu6KQUtkmF+SpxIAX4NcvTD44BDwoqBsr0gWiJ7jNjXY8V+BPID20WCPJV/8HSBgw==
X-Received: by 2002:aa7:d697:: with SMTP id d23mr2811070edr.127.1617782015401;
        Wed, 07 Apr 2021 00:53:35 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id r13sm15252263edy.3.2021.04.07.00.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 00:53:34 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Albert Cui <albertqcui@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Albert Cui via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2] hooks: propose project configured hooks
References: <pull.908.git.1616105016055.gitgitgadget@gmail.com>
 <pull.908.v2.git.1616723016659.gitgitgadget@gmail.com>
 <ec031dc8-e100-725b-5f27-d3007c55be87@gmail.com>
 <CAMbkP-S-9cccMpU4HG0Wurqap-WkTmD2zk50nKd9kJ_oWO__qw@mail.gmail.com>
 <YGzrfaSC4xd75j2U@camp.crustytoothpaste.net>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <YGzrfaSC4xd75j2U@camp.crustytoothpaste.net>
Date:   Wed, 07 Apr 2021 09:53:33 +0200
Message-ID: <87tuoijzsy.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Apr 07 2021, brian m. carlson wrote:

> On 2021-04-05 at 22:45:10, Albert Cui wrote:
>> Right, this entire proposal is trying to get to a "Git-blessed" solution,
>> and I should make the need clearer. A few reasons for standardizing
>> this come to mind:
>> 
>> 1. Many existing "standard" solutions. A multitude of existing solutions for
>> this use case speaks to the fact that a basic config script is not sufficient.
>> I mentioned Husky above, but here are a few more; basically each
>> popular programming language environment has a solution for this.
>> 
>> https://github.com/sds/overcommit - Ruby
>> https://github.com/pre-commit/pre-commit - Python
>> https://github.com/Arkweid/lefthook - Go
>> https://github.com/shibapm/Komondor - Swift
>> https://github.com/typicode/husky - Node
>> 
>> These solutions all handle the installation and updating of hooks. A
>> "configure-hooks.sh" script doesn't handle hook updates, unless you go through
>> the trouble yourself of implementing and maintaining that.
>
> I think part of the problem is that an automated process to update hooks
> is generally a security vulnerability, since it means that untrusted
> remote code will automatically run on your computer.
>
> I want to be clear that I understand the desire for this feature, even
> though it's not a feature I would personally use, and the fact that
> there are many approaches means that clearly there are many people that
> do want this functionality.  I have in the past shared hooks with others
> and we have mutually benefitted enormously from that fact.  My concerns
> here are solely about the security aspects of this feature.
>
>> 3. Improving security. As you mentioned, hooks are difficult to get
>> right from a security
>> perspective, and standardizing on a single implementation allows us to
>> give developers
>> a well-vetted solution with a better security model than what exists
>> today. For example,
>> we're proposing making it very clear to users whenever there's a hook
>> update. This isn't
>> something that existing solutions do.
>
> I don't think this materially improves security.  All of these options
> have the same security problems, and that's inherent in the solution.
> What we're doing here is basically giving people a built-in feature that
> is the equivalent of piping curl to bash and blessing it as secure when
> it's not.
>
>> I'll also say in general, the Git project is much more likely to get
>> security right than smaller
>> projects, where oftentimes even popular projects end up unmaintained.
>
> I agree that Git tries to be careful about security.  It is for these
> reasons that I think Derrick and I have provided you the feedback we
> have here.
>
>> Agreed. We already did a security review internally at Google. The main
>> feedback was:
>> 
>> * We need an explicit opt-in opposed to setting hooks up automatically,
>> e.g. a command line flag like --accept-hooks at minimum. This is primarily
>> to distinguish people who are just cloning a repository to browse the code
>> from people who are developing.
>> 
>> * The average user doesn't have the ability to review hooks in general
>> (security is hard and obscuration is easy), and if the user has
>> already opted into
>> this feature because they are engaged in development, it's very likely
>> that they're
>> already running build scripts, so the additional attack vector here doesn't seem
>> like a big issue.
>
> I think you've hit the nail on the head here, but drawn a mistaken
> conclusion.  The average user doesn't have the ability to review hooks
> in general and therefore cannot make an informed decision about whether
> to enable them, so the behavior we need to have is not to lead them to
> doing things which are risky from a security perspective.
>
> If my goal is to just build a product and not to run its tests, which I
> do with a decent number of projects, then I can audit a Go or Rust
> project trivially and determine if it executes arbitrary code or not
> during the build process and if so, inspect it and gain confidence in
> it.  In fact, there are many projects which don't execute build scripts
> during the process, and therefore which are completely safe.  This hook
> design changes that calculus dramatically.
>
> I also want to point out that people clone repositories for a variety of
> reasons.  At GitHub, every team has its own repository with
> documentation.  Literally every employee at the company, regardless of
> role, interacts with a Git repository, even people who do normally
> nontechnical tasks such as our in-house lawyers and our event planners.
> Many of these people are nontechnical, and almost none of these
> repositories has any software development involvement.  There are also
> numerous people elsewhere who may work on projects such as books or
> other non-software in repositories who are nontechnical.  Under the
> current model, the biggest problem these people face is accidentally
> corrupting their local repository and losing data.  With a design that
> prompts them to install hooks, they face the possibility of arbitrary
> code execution.
>
> The reason I proposed the FAQ we have in our documentation is because I
> answer a decent number of questions on Stack Overflow, in addition to
> questions that involve users that I get pulled into at work.
> Overwhelmingly, the vast majority of users, even developers, are not
> completely comfortable with Git and are unsure about how to use it
> effectively (cf. https://ohshitgit.com/).  If we propose to a user that
> they should do something like enable hooks by adding a prompt, many
> users will automatically say "yes" because (a) they don't understand and
> they trust that Git is prompting them to do something beneficial and (b)
> because they don't know or care and just want to get on with their
> lives.  As a result, we're exposing people to giant social engineering
> attacks on behalf of potentially unscrupulous repository maintainers.
>
> This is made worse by the fact that we will prompt users even when
> cloning a repo that they have no intention of performing development on
> means that we will have users who are misled here where otherwise
> nothing would happen.
>
> There is a huge problem with social engineering attacks and phishing on
> the Internet today and I'm concerned that this is going in exactly the
> wrong direction.
>
> I would want to see a comprehensive security analysis feature taking
> into consideration social engineering attacks, the skill level and
> comfort with Git of the majority of Git users, and the fact that people
> clone repositories for many reasons other than software development.
> It's easy to look at this from the perspective of the typical employee
> at a major tech company and assume that users are generally security
> conscious, comfortable with Git, and primarily engaged in software
> development on the projects they clone, but I'm not sure any of those
> cases are generally true, and anyway there are many counterexamples in
> the real world whose use cases we need to take into account.
>
> I continue to have serious reservations about this series and approach,
> and I'm not sure that any proposal we can adopt here will address the
> security concerns.  To be frank, I don't think this proposal should move
> forward in its current state or otherwise, since I think the security
> problems are inherent in this approach and fundamentally can't be fixed.
>
> This is, as should be obvious from my email address, my personal
> opinion, despite my reference to my employer above.  Unless otherwise
> stated, I don't speak for my employer and they don't speak for me.

I agree with pretty much every word you said, in particular the social
engineering aspect of this. In past mails I've referred to elsewhere
I've proposed some Emacs-like "ask" facility for git, but you've
convinced me that that default would be a bad idea for the "user just
clicks yes no matter what" reasons you noted.

Still, I do think there is a way to make this work in a way that's
probably acceptable for everyone:

 * We don't ever ask the user to install hooks, it's something that
   they'd have to know about and pro-actively set up in advance.

 * The security model is entirely focused on not approving changes as
   you "pull" them, but e.g. GPG-verifying the whole chain with some
   pre-setup key.

The use-case (and I've had this use-case in the past) would be something
like a BigCorp which automates its servers/laptops, but would prefer not
to patch/build/ship something like git itself.

So when you "git clone" your corporate repos you get relevant
config/hooks, but not otherwise. We'd of course have a way to discover
that you can set these up & do so after "clone", but it would be
something more like check-mailmap, not something we'd prompt you to do.

I'm personally much more interested in doing something like this for an
in-repo .gitconfig, with us shipping a graduals whitelist of known
config values at differeng safety levels.

That sort of thing really *is* something we could imagine asking the
user about, or even doing by default, e.g. applying a "diff -U<n>"
setting for that repo, picking up non-executable aliases for
non-data-changing git programs etc.

But as you note hooks are really on the extreme other side of that
security curve, which is why in some earlier thread discussing this I
suggested that a much more productive way to start an effort like this
would be the in-repo .gitconfig route. We could start with our N most
safe config variables, and work from there...

