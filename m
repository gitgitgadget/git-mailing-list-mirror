Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87E76C4338F
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 20:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B99C61179
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 20:18:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244916AbhHFUSj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Aug 2021 16:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244883AbhHFUSi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Aug 2021 16:18:38 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0FEC0613CF
        for <git@vger.kernel.org>; Fri,  6 Aug 2021 13:18:22 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id s22-20020a17090a1c16b0290177caeba067so24451750pjs.0
        for <git@vger.kernel.org>; Fri, 06 Aug 2021 13:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=FYoGcNYF4tdaR+1cOJBRDHASxlyZfIFMD9avVs18Vw0=;
        b=DpUXwChkLdoBZ2L5/PZrWpYl4R1KhQUxBR0cnEBxVNVNdXJvhO5Dx7IpkEjjaLjYXP
         YVrBFKNzDsTu5J0c1hGNrxVufEHws/NK4dl7RsyZhSeKU2zuwSRokTaQetRnTvax+z0n
         7KJKuitiRfbArcB0wIjn1IQ3Bcv3rodWF0eY7QLIfV2Ioa4wqfecmwNXfWNA4Lvakr0X
         0CHSx4gYsNctyfxSnR0tkPt6xgf9NMovDFPjbXLnV8FOMWUn5NBP9tlrPvrRhXUWtic7
         1o0XUofDJlIf65OcCxxSxR0ydABpuUZF6I65oeWTn0jvASsedZlZlhR4iOMh8+Y1EBXW
         IYhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=FYoGcNYF4tdaR+1cOJBRDHASxlyZfIFMD9avVs18Vw0=;
        b=QPb4mddVHaGZv40xwhn31zwQj0ylkX18fNfdBiolk6xv8lHVxj7kqHzAeSXLyspcqC
         IG19a+h9k9VBBVS++lPOCWJutMff/aYS/1dwK65LW9Way5uQTaBfapcivOYLFodfSDJJ
         0PYyfO0VAZYc66ajwsL0lrT7MVwxBxZzJSrsaYxBsFf73vv4D6LXd+MhtsuK/eRqrOmc
         LYhCYscNlPYG3mHGbaM9Svsld/Cv3vJS1aueJHAPC5846QLEeuN21BRhYQqa1FlJWdzy
         hRAr/Q89mF96JIy2H3mvd4BujDvDQ+uEuZ8/fKymm5f3eAN7DQ+p4fMxddRG953XvgXd
         3vog==
X-Gm-Message-State: AOAM530RkpZaAZ2QAqtmQNbg2IidxkH/VdssVoipcwCkDlhr3qwCOLJS
        R5vV1QWtCEykd3QmTOvT2/i3oA==
X-Google-Smtp-Source: ABdhPJyaL7kWdzo/0zSdU6dQLCAD6neGnCAFD8M26kmm+KckOcKQl6J+pZT5l3XM1XEbfnYSBGLdaw==
X-Received: by 2002:a17:90a:d994:: with SMTP id d20mr12006379pjv.137.1628281101813;
        Fri, 06 Aug 2021 13:18:21 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:5b73:9aa1:d0f9:1d45])
        by smtp.gmail.com with ESMTPSA id u13sm10808015pfi.51.2021.08.06.13.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 13:18:21 -0700 (PDT)
Date:   Fri, 6 Aug 2021 13:18:15 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 8/9] hook: teach 'hookcmd' config to alias hook scripts
Message-ID: <YQ2ZBw4vZswlSkYq@google.com>
References: <20210715232603.3415111-1-emilyshaffer@google.com>
 <20210715232603.3415111-9-emilyshaffer@google.com>
 <87fswey5wd.fsf@evledraar.gmail.com>
 <YPn/5GLrAb17KqyB@google.com>
 <87bl6ttmlv.fsf@evledraar.gmail.com>
 <YQr6xojzxk3xJrTw@google.com>
 <877dh0n1b3.fsf@evledraar.gmail.com>
 <YQxcDZSEvrRKIN+L@google.com>
 <87sfznzd7v.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87sfznzd7v.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 06, 2021 at 12:26:02AM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> 
> On Thu, Aug 05 2021, Emily Shaffer wrote:
> 
> > On Thu, Aug 05, 2021 at 02:17:29AM +0200, Ævar Arnfjörð Bjarmason wrote:
> >> [...]
> >> > No, that's in fact as designed, with my model B. The user configured
> >> > "echo hi" to run on "verify-commit" events; if those events are
> >> > initially used by some wrapper, but later we decide they're a great idea
> >> > and absorb the verify-commit event into native Git, then this is working
> >> > as intended. I think your argument is based on a misunderstanding of the
> >> > design.
> >> >
> >> > Could it be that the way I provided the examples (my schema after A: and
> >> > your schema after B:) made it hard to parse? Sorry about that if so.
> >> 
> >> Aren't you assuming that users who specify a verify-commit will be happy
> >> because git's usurping of that will 1=1 match what they were using
> >> "verify-commit" for.
> >> 
> >> I'm pointing out that we can't know that, and since you want to make
> >> "git hook run" a general thing that runs any <name> of script you've
> >> configured, and not just what's in githooks(5) that it becomes very
> >> likely that if we add a new hook with some obvious name that we'll
> >> either break things for users, or subtly change behavior.
> >> 
> >> Which isn't just theoretical, e.g. I tend to run something like a "git
> >> log --check @{u}.." before I run git-send-email, with this configurable
> >> hook mechanism having a "git hook run sendemail-check" would be a way I
> >> might expose that in my own ~/.gitconfig.
> >> 
> >> But if git-send-email learns a "sendemail-check" and the behavior
> >> doesn't exactly match mine; E.g. maybe it similar to pre-auto-gc expects
> >> me to return a status code to ask me if I want to abort on a failed
> >> --check, but mine expects a revision range to run "log --check".
> >> 
> >> In practice that's a non-issue with the current hook mechanism,
> >> i.e. nobody's sticking a script into .git/hooks/my-custom-name and
> >> expecting it to do anything useful (and if they are, they have only
> >> themselves to blame).
> >> 
> >> Whereas we'd now be actively inviting users to squat on the same
> >> namespace we ourselves will need for future hooks.
> >
> > Yeah, this is a good point. Seems worth a note in the 'git hook run'
> > doc, making a point that "you can use this for your wrapper to run
> > specific hooks, but be careful about namespace collisions". We're a lot
> > less likely to add a hook named "repotool-verify-commit" than we are to
> > add a hook named "verify-commit", for example.
> >
> > I think it's enough to warn about future namespace collisions and make
> > an "at your own risk" note.
> 
> I might have lost track at this point, but later examples in this E-Mail
> you show don't seem to require such a note.
> 
> I.e. it's only an issue if we conflate a semantically meaningful slot
> like "pre-commit" in the config with one that can also have the meaning
> of simply defining an arbitrary user-decided name.

No, I don't think that's the case. The examples I used later in the mail
don't have anything to do with this "wrapper wants to use 'git hooks
run'" case.

Let's imagine a current commonly-used wrapper, 'repo'
(https://gerrit.googlesource.com/git-repo/+/refs/heads/master/README.md).
This wrapper is used to manage multiple Git repos into something
semantically similar to submodules.

Let's say that 'repo' decides that instead of rolling its own hook
system, it would like to use Git's native hook system. Let's say that it
wants to call user-defined hooks any time someone has just completed
running 'repo sync'. It could ask users to define a config like so:

  [hook "myrepohook"]
    event = post-sync
    command = ~/some/downloaded/myrepohook --with --args

Then 'repo' itself can, at the end of its 'repo sync' implementation,
call 'git hook run post-sync' (instead of using some other hook
specification schema).

But Git itself has a 'git submodule sync' command, and let's imagine
that we decided we want to run some user-defined hook at the end of 'git
submodule sync'. Naturally, we can call it 'post-sync', and then we will
accidentally invoke the hooks which someone configured for 'repo' - as
you pointed out would be a concern with my design, this will *also* be
a concern with your design.

This specific use case is what I think we can get around with some "at
your own risk" documentation, because we are much less likely to collide
with someone asking their users to configure like so:

  [hook "myrepohook"]
    event = repo-tool-post-sync
    command = ~/some/downloaded/myrepohook --with-args

> >> > No, but it's something I'm interested in passing as an environment
> >> > variable. I didn't add it to this series because it seemed to me to
> >> > distract from the core feature. We would like to add it to simplify our
> >> > invocations of https://github.com/awslabs/git-secrets, so it's on my
> >> > radar.
> >> 
> >> Having such an env var as part of the initial series seems like a
> >> sensible thing to have.
> >
> > Eh. To me, it feels like feature creep. It also is something we could
> > add today to the existing hook mechanism (even if it's a little
> > pointless since you can basename, like you say), so it feels orthogonal.
> > I would prefer not to add it in this series.
> 
> Sure, I guess you can add two hook sections to replace e.g. your
> {pre,post}-receive hook (which are commonly routed to the same script
> with file-based hooks). Having a single setenv() seems easy enough, and
> I'd bet a way more common use-case than wanting to skip earlier defined
> hooks...

More than anything else, I think this comment convinced me that the skip
config also falls under YAGNI and I can drop it (and we can add it later
if "hook.myhook.command = true" isn't clear enough).

I snipped the rest because I don't disagree or have anything further to
say. Look for a reroll this weekend, we hope.

 - Emily
