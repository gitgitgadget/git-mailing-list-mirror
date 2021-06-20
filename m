Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B852C48BDF
	for <git@archiver.kernel.org>; Sun, 20 Jun 2021 20:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA92761156
	for <git@archiver.kernel.org>; Sun, 20 Jun 2021 20:14:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbhFTUQW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Jun 2021 16:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbhFTUQV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Jun 2021 16:16:21 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5772EC061574
        for <git@vger.kernel.org>; Sun, 20 Jun 2021 13:14:08 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id gb32so16986325ejc.2
        for <git@vger.kernel.org>; Sun, 20 Jun 2021 13:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=JmPe63RbKK+lIb/CXvwot6LOJ3fGzRaZC4SySbw4TUo=;
        b=VMBl372b2J5ItIFRxhLS2Eo0ubPT3xMWc61yEheiM1P6dCrajsgeNh3LyCyY2dzBy6
         ucwrrNau4L63rlgRY3mULPBOzwCh0+sXNLOXzxafoz8g0HsWkwh34x/ipkU5R35+trk1
         8WAkY+50PrnjKBVQAdLyL/mpN9Bz7YdIoO3AwdSElHcQfjRyrqwOiPTa+gtRid2Y0bAH
         ukBSqInEYwlzUanwpO2ff7TanaTs4qcamd72fhaBXvxJDk7pM/Xb64hUp6E/HvTLhgWz
         z739b/VmD5afKBqveMEqg9ZTZu2jw2+z3kWkPemh1Ff/iSxQBVc7GyBoz37oVZMIRtdN
         WZuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=JmPe63RbKK+lIb/CXvwot6LOJ3fGzRaZC4SySbw4TUo=;
        b=SPN/T6OOlTyQFkyZBxTOv4xH0AZxfpL+57h6p8z9vesJewTGDqRi9E/N94+qvHj9V/
         /RSvdij+W6ise/BDQbjMV3CKMVrgBcRkpujQMWkjceAY+t5gqiEdBLJhAc+91rspbLq7
         w4dk7S6S/czUg/wJY/YCT8rc03B6THI/lxm8x7rykt/94SxpfvNGDK82UTs5EJNtsNFL
         qw8mxZksWvaUVNythGa+5qZe7IyPvGJ3y4fkG/vqD4+f6OVZUa3+zyDwM2fRdw2EdFCI
         BI7KKVOG2OrxYTVl0WFpjAiTprG1+9MyEjY+bYmX64d3jTGe5W2txvs0UttTslchrQc9
         CX9w==
X-Gm-Message-State: AOAM532YjnmSd6KlnWcF2xvS/HhfRR+DYBcdCsDgp3EMbZObm/sQMKvQ
        CytIjBWjZ0X3abB/rU1Kvjrg/+uz0z0=
X-Google-Smtp-Source: ABdhPJye6WgBXNwsv94Hgrwt/jg7yALjLpMlaDNpX3+eTQ6CCqHSX15x+aXGFvn/UkzQsbDZ2SwBpw==
X-Received: by 2002:a17:906:15c2:: with SMTP id l2mr20805570ejd.348.1624220046621;
        Sun, 20 Jun 2021 13:14:06 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id w17sm3908801ejk.112.2021.06.20.13.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jun 2021 13:14:06 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [RFC PATCH 0/2] MVP implementation of remote-suggested hooks
Date:   Sun, 20 Jun 2021 21:51:04 +0200
References: <cover.1623881977.git.jonathantanmy@google.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.12
In-reply-to: <cover.1623881977.git.jonathantanmy@google.com>
Message-ID: <87fsxc47le.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jun 16 2021, Jonathan Tan wrote:

> This is a continuation of the work from [1]. That work described the
> reasons, possible features, and possible workflows, but not the
> implementation in detail. This patch set has an MVP implementation, and
> my hope is that having a concrete implementation to look at makes it
> easier to discuss matters of implementation.

My C on this RFC is:

1) A request that someone reply (there or here would do) to my comments
   on the last iteration of this at:
   https://lore.kernel.org/git/874kghk906.fsf@evledraar.gmail.com/

2) I think you'd get better feedback if you CC'd the people who've been
  actively discussing this in previous rounds.

To briefly summarize the main gist of that 1):

> This but does not use any features from es/config-based-hooks but is
> implemented on that branch anyway because firstly, I need an existing
> command to attach the "autoupdate" subcommand (and "git hook" works),
> and secondly, when we test this at $DAYJOB, we will be testing it
> together with the aforementioned branch.
>
> I have had to make several design choices (which I will discuss later),
> but now with this implementation, the following workflow is possible:
>
>  1. The remote repo administrator creates a new branch
>     "refs/heads/suggested-hooks" pointing to a commit that has all the
>     hooks that the administrator wants to suggest. The hooks are
>     directly referenced by the commit tree (i.e. they are in the "/"
>     directory).
>
>  2. When a user clones, Git notices that
>     "refs/remotes/origin/suggested-hooks" is present and prints out a
>     message about a command that can be run.
>
>  3. If the user runs that command, Git will install the hooks pointed to
>     by that ref, and set hook.autoupdate to true. This config variable
>     is checked whenever "git fetch" is run: whenever it notices that
>     "refs/remotes/origin/suggested-hooks" changes, it will reinstall the
>     hooks.
>
>  4. To turn off autoupdate, set hook.autoupdate to false. Existing hooks
>     will remain.
>
> Design choices:
>
>  1. Where should the suggested hooks be in the remote repo? A branch,
>     a non-branch ref, a config? I think that a branch is best - it is
>     relatively well-understood and any hooks there can be
>     version-controlled (and its history is independent of the other
>     branches).

First, unlike brian I don't (I hope I'm fairly summarizing his view
here) disagree mostly or entirely with the existence of such a feature
at all. I mean, I get the viewpoint that git shouldn't bless what
amounts to an active RCE from the remote.

I just think that we could probably do a better job of it than what
people are doing in practice, and I've seen people do stuff like have
build systems setup permanent symlinks to git-hooks/<some-name> in the
tracked dir. We could at least envision a git-native implementation
asking the user "do you want this hook update? <shows diff>".

I just find this design approach completely bizarre as noted (probably
in less blunt words) in the linked E-Mail.

We have Emily's series to convert hooks to be config driven that we hope
to land in some form, at that point they won't be any more of a special
snowflake than any other config.

And then, instead of doing what I'd think would be the natural result of
that: Simply supporting an in-repo top-level ".gitconfig" file. We're
still going to seemingly forever have them be an even more special
snowflake with this facility, and the reason seems to be mostly/entirely
to do with working around some aspect or restriction of Google's
internal infrastructure.

I think it's just un-git-y to have a meta-branch that in some way drives
not only all other branches, but all other revisions of all branches,
ever.

It breaks expectations around git in lots of different ways, you can't
fetch a single branch and get its hooks, you can't locally alter, commit
and update your hooks while e.g. renaming a "t/" directory to "test/";
your hooks and code can't be atomically changed).

I think I get why you want to do it that way, I just don't get why, as
mostly noted in those earlier rounds why it wouldn't be a better
approach / more straightforward / more git-y to:

1. Work on getting hooks driven by config <this is happening with
   Emily's series / my split-out "base" topic>
2. Have a facility to read an in-repo '.gitconfig'; have lots of safety
   valves etc. around this, I suggested starting with a whitelist of the
   N least dangerous config options, e.g. some diff viewing options, or
   a suggested sendemail.to or whatever.

3. Work our way up to trusting that for more dangerous stuff, eventually
   hooks. Most of the legitimate concerns from others with this is
   having some UX where our users won't be trained to just blindly say
   "yes" to an alias/hook config that "rm -rf's /" or whatever.

   If we start experimenting with that with aliases or hooks that can
   run arbitrary code it's like handing a toddlder a shotgun, let's at
   least start with a sharp fork or something (less dangerous config) :)

4. People who want this "I want my hooks to apply to all revisions ever"
   could probably get 99% or 100% of what they want if their hook is
   just a stub that does the equivalent of:

       sh `curl https://git.google.com/$reponame/hooks/$hookname`

   You'd then simply forbid on your servers any changes to a .gitconfig
   that did anything with the hook.* namespace.

With such an implementation you don't need a magic
"refs/remotes/origin/suggested-hooks" refs, just some state machine (I
suggested e.g. GPG signing chains as an eventual end-state, but "show a
diff every time" would also do) that keeps track of what config (and
hooks are just one such case) has been OK'd, and which has not.

I'd think it would even work better in the Googleplex, you could clone a
co-worker's branch and execute their hooks, since they're the same as
what you've pre-approved, you could even clone some random person's fork
of a "blessed" project, because the hooks would be the same `sh $(curl
<url I already trust>)`. That validation could even be a system-level
in-config hook on your laptop, thus bringing the whole thing full
circle...
