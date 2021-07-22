Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE16C4338F
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 23:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CFFB60E9B
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 23:31:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232697AbhGVWvW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jul 2021 18:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232692AbhGVWvV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jul 2021 18:51:21 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B2DC061575
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 16:31:55 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id n10so1224966plf.4
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 16:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Y8kD0zu4CbiwdY+TD9w3JZ+Lv9wQF3OQEn00NBj08TU=;
        b=RPvjDTr+gMWcnrYRrHl9C7z4JRacsPj5RxKgafCjiA4Smx49azywJjCGnmp0IITfuM
         ny4iDhosqDE/qi7LIsT2u2no1+9XEyVTQJ+zMpkRd8cy0xOZrs0RB/VroHvIjE53sKiM
         HWpPXf+rY/p7bA/kJHBFMS9p33pFLpCTUZFkPOrDhC2JYLefLIvCUZ2p6Vyou024kD3I
         wDuk0vTm1DZNNYUHVh27sKX8efDQr90pvQ5bInvrvTlhidzXpF70bGCHm4w6d0MD6siz
         nU2xEsOevkVG8/TkzXXmcxO1+0Jf4SfElmLJR6k3yIGC6wYQCzZ506AIvTMwc0bVHPee
         qngA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Y8kD0zu4CbiwdY+TD9w3JZ+Lv9wQF3OQEn00NBj08TU=;
        b=i5nEaORR8itiicUvh1gADM+1DjP5TJgU0S/6zNEb6sH7sh/zphyPv66bz9DJ0JI8QK
         4ymATH3lWOhjSVeR0TbB8/Pa3I1nKvy3JvlUHujSVOmYZENkBaE0BaE+5rxqW63UeK5Y
         Kz4Dh3iClrsjD2bT5SujvhXsKae3J/MmzY1GGXAT7DMWXdOLDXuUTzaoh/sNr60bDp1F
         c/eIUVdu/d/YzCYsbJRywiq2nKaR49pvPptAK8qwIPGVYSNBpaPr8C7PL3VEuQB7dPbu
         jw3QvETv99+nyAJ2nEs28NwUSfFuQ4kKub7vQ8/XC/G93U+SiHgIIaS8X+0ZnbZbXy9U
         RDVg==
X-Gm-Message-State: AOAM530cTaNKW/88IkLZ7Vdb+kZN6D2KOJHcxUtYox82yb6PrNt4Dc83
        x1EfeL9/HPYfGO9TlP4qBPRcNRaZlgY9cw==
X-Google-Smtp-Source: ABdhPJwrDsY1gG+ms0sA4X6ejEkfXUkJJOG2WwltDZgQ/f40unJluG2esuE/PchGeOBcCGURZ8CLlA==
X-Received: by 2002:a17:902:9b87:b029:11e:7c15:a597 with SMTP id y7-20020a1709029b87b029011e7c15a597mr1761610plp.6.1626996714400;
        Thu, 22 Jul 2021 16:31:54 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:3c03:6226:e12f:afc9])
        by smtp.gmail.com with ESMTPSA id u24sm32635424pfm.156.2021.07.22.16.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 16:31:53 -0700 (PDT)
Date:   Thu, 22 Jul 2021 16:31:48 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 8/9] hook: teach 'hookcmd' config to alias hook scripts
Message-ID: <YPn/5GLrAb17KqyB@google.com>
References: <20210715232603.3415111-1-emilyshaffer@google.com>
 <20210715232603.3415111-9-emilyshaffer@google.com>
 <87fswey5wd.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87fswey5wd.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 16, 2021 at 11:13:42AM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> 
> On Thu, Jul 15 2021, Emily Shaffer wrote:
> 
> > To enable fine-grained options which apply to a single hook executable,
> > and to make it easier for a single executable to be run on multiple hook
> > events, teach "hookcmd.<alias>.config". These can be configured as
> > follows:
> > [...]
> > diff --git a/Documentation/config/hook.txt b/Documentation/config/hook.txt
> > index a97b980cca..5b35170664 100644
> > --- a/Documentation/config/hook.txt
> > +++ b/Documentation/config/hook.txt
> > @@ -3,6 +3,11 @@ hook.<command>.command::
> >  	executable on your device, a oneliner for your shell, or the name of a
> >  	hookcmd. See linkgit:git-hook[1].
> >  
> > +hookcmd.<name>.command::
> > +	A command to execute during a hook for which <name> has been specified
> > +	as a command. This can be an executable on your device or a oneliner for
> > +	your shell. See linkgit:git-hook[1].
> > +
> > [...]
> > +Global config
> > +----
> > +  [hook "post-commit"]
> > +    command = "linter"
> > +    command = "~/typocheck.sh"
> > +
> > +  [hookcmd "linter"]
> > +    command = "/bin/linter --c"
> > +----
> > +
> > +Local config
> > +----
> > +  [hook "prepare-commit-msg"]
> > +    command = "linter"
> > +  [hook "post-commit"]
> > +    command = "python ~/run-test-suite.py"
> > +----
> > +
> > +With these configs, you'd then run post-commit hooks in this order:
> > +
> > +  /bin/linter --c
> > +  ~/typocheck.sh
> > +  python ~/run-test-suite.py
> > +  .git/hooks/post-commit (if present)
> > +
> > +and prepare-commit-msg hooks in this order:
> > +
> > +  /bin/linter --c
> > +  .git/hooks/prepare-commit-msg (if present)
> >  
> 
> I still have outstanding feedback on the fundamental design
> here. I.e. why is this not:
> 
>     hook.<name>.event = post-commit
>     hook.<name>.command = <path>
> 
> See:
> 
> https://lore.kernel.org/git/87mtv8fww3.fsf@evledraar.gmail.com/
> 
> As noted there I don't see why not, and more complexity results from the
> design choice of doing it the way you're proposing. I.e. we can't
> discover hooks based on config prefixes, and we end up sticking full FS
> paths in config keys.

Interesting. My gut says that it would make it harder to neatly write a
config with the same hook running at the very beginning of one event and
the very end of another, but I'm not sure whether that's a case to
optimize for.

I would also need twice as many lines to run a script I wrote as a hook
- that is, the base case which is probably all most people will need. So
with your proposal I *must* name every hook I want to add. Instead of
"hook.pre-commit.command = ~/check-for-debug-strings" I need to
configure "hook.check-debug-strings.event = pre-commit" and
"hook.check-debug-strings.command = ~/check-for-debug-strings". That's a
little frustrating, and if I never want to skip that check or move it
later or something, it will be extra overhead for no gain for me.

I do agree that your approach bans the regrettably awkward
"hookcmd.~/check-for-debug-strings.skip = true", but I'm not sure
whether or not it's worth it.

To help us visualize the change, here's some common and complicated
tasks and how they look with either schema (let mine be A and yours be
B):

#1 - Add a oneliner (not executing a script)
A:
[hook "post-commit"]
	command = echo post commit
B:
[hook "oneliner"]
	event = post-commit
	command = echo post commit

#2 - Execute a script
A:
[hook "post-commit"]
	command = ~/my-post-commit-hook
B:
[hook "script"]
	event = post-commit
	command = ~/my-post-commit-hook

#3 - Run a handful of scripts in a specific order on one event
A:
[hook "post-commit"]
	command = ~/my-post-commit-1
	command = ~/my-post-commit-2
	command = ~/my-post-commit-3
B:
[hook "script 1"]
	event = post-commit
	command = ~/my-post-commit-1
[hook "script 2"]
	event = post-commit
	command = ~/my-post-commit-2
[hook "script 3"]
	event = post-commit
	command = ~/my-post-commit-3

#4 - Skip a script configured more globally
A:
(original config)
[hook "post-commit"]
	command = /corp/stuff/corp-post-commit
(local config)
[hookcmd "/corp/stuff/corp-post-commit"]
	skip = true
OR,
(original config)
[hookcmd "corp-pc"]
	command = /corp/stuff/corp-post-commit
[hook "post-commit"]
	command = corp-pc
(local config)
[hookcmd "corp-pc"]
	skip = true
B:
(original config)
[hook "corp-pc"]
	event = post-commit
	command = /corp/stuff/corp-post-commit
(local config)
[hook "corp-pc"]
	skip = true

#5 - Execute one script for multiple events
A:
[hookcmd "reusable-hook"]
	command = /long/path/reusable-hook
[hook "post-commit"]
	command = reusable-hook
[hook "pre-commit"]
	command = reusable-hook
[hook "prepare-commit-msg"]
	command = reusable-hook
B:
[hook "reusable-hook"]
	command = /long/path/reusable-hook
	event = post-commit
	event = pre-commit
	event = prepare-commit-msg

#6 - Execute the same script early for one event and late for another
event
A:
(global)
[hookcmd "reusable-hook"]
	command = /long/path/reusable-hook
[hook "pre-commit"]
	command = reusable-hook
(local)
[hook "post-commit"]
	command = other
	command = hooks
	command = reusable-hook

B:
(global)
[hook "reusable-hook"]
	command = /long/path/reusable-hook
	event = pre-commit
(local)
[hook "other"]
	event = post-commit
	command = other
[hook "hooks"]
	event = post-commit
	command = hooks
[hook "reusable-hook"]
	event = reusable-hook


I'm not going to comment on which one I like more yet - I think I will
study this for a while and let others weigh in on their preferences too.
I tried to order the cases from most common to less common. Please feel
free to chime in with more use cases that you think would be handy which
I forgot :)

 - Emily
