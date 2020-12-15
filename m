Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF386C4361B
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 03:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A02D8223D6
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 03:50:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgLODuj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Dec 2020 22:50:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbgLODuQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Dec 2020 22:50:16 -0500
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58136C061793
        for <git@vger.kernel.org>; Mon, 14 Dec 2020 19:49:36 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id d8so18075538otq.6
        for <git@vger.kernel.org>; Mon, 14 Dec 2020 19:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=TUqgFwNYaIN/SOD0javJrLYI+u0miLbZKekaPVRP8so=;
        b=aoVy6ohNJX6xYnNrV12NZtswh8PkmHc5ABTzaGm0zEB4cn01Cc6NzOJbxSqSJO7aV/
         s0GB34NJaC+ctAKblCrC6TLGIGE4qTS/g1Wd+wbcVI5uIPlGcigC6gk3xIK88rXauPmB
         brqx9th7lkEywqsxlw/0ECl+U+b0mzN9PVjCeedCHioE+oEFjFkJ1tIkMalwy+ZSr004
         9UppVhgSHkMYD7kXJL8eBcxg5Pe5iNeduc1aLLEuFMVIoFSTE3uRt7O0XOG99/J1e4Lc
         rxVx5ADAOqIlBthqDPaEgr9RZ4uWB2ESfn0uK0s3v7atho2o8leS7r09iGlPQ0NvzV9Y
         UlXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=TUqgFwNYaIN/SOD0javJrLYI+u0miLbZKekaPVRP8so=;
        b=Sc799qcefmxTZxklnLCCxbHrKF6GBY8r2OfdlWXmfjHPT0mvNYrFYZgq20jm1xhJFY
         g2yNHhOaoyuAjVnZp2vYjnjHxkI/CpZ0yOmjvvuSYmd//wbKeE/dCMB2+yHk+QHOvfmQ
         ejmI9PWAD6BlEtHSWDbL1jLnmsOMw4PIpbPI2N54lbyz8QfCJkCBMo66ChgrvUDPYvMT
         pM2BOZxga7ZdYTX9obt3hZkDHkAZB4KIRHVp1zgtt6W3uKKts9XGWeup+nNe1ouqi7JL
         OqGgGYNFpE5j87OUkFpI0Kaxd+ERoHBQ1R1hmE8INp+fSHTjxonhhPmtJ1iXWXxwI0BY
         ZZOg==
X-Gm-Message-State: AOAM533pyAw4ZFWmhvdc+YLWRnV2zKF4SbsgY+M3aiA3oU+gpgOkYiwO
        OSZKUjg3MC/014ZYRi2k1hM=
X-Google-Smtp-Source: ABdhPJwziAvQrElyuWhVWVOcgkIkrQBHjpI559EPToYs9KZuZGc+5Kgprnz0T3Czbrfvu4SoEoHjJQ==
X-Received: by 2002:a9d:3645:: with SMTP id w63mr6095571otb.117.1608004175734;
        Mon, 14 Dec 2020 19:49:35 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id e8sm126477oti.76.2020.12.14.19.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 19:49:34 -0800 (PST)
Date:   Mon, 14 Dec 2020 21:49:33 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        John Keeping <john@keeping.me.uk>,
        Richard Hansen <rhansen@rhansen.org>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        "W. Trevor King" <wking@tremily.us>
Message-ID: <5fd8324d70ae5_d7c48208fa@natae.notmuch>
In-Reply-To: <X9ggAxk/z0D9Qom+@coredump.intra.peff.net>
References: <xmqqlfe99yvy.fsf@gitster.c.googlers.com>
 <CA+P7+xp=UGd0iK8uLxnqH0iycrxo--8on3d0Z+jsuyhpV-fVew@mail.gmail.com>
 <xmqq360h8286.fsf@gitster.c.googlers.com>
 <CAMP44s3KCoDfRXzarJw5AE7UsY-=eP6GbHzdDcdrs2rsw5tL+w@mail.gmail.com>
 <xmqqy2i86ok1.fsf@gitster.c.googlers.com>
 <CAMP44s13YFZeOMz6V5sPdOnLXD-v3aQZiP7vvXXNfQLZP4Puwg@mail.gmail.com>
 <CABPp-BGZcmHhge7JnM12baL_86yV-+7z4kkvFwUUrP+db8QD8Q@mail.gmail.com>
 <xmqqy2i6w45c.fsf@gitster.c.googlers.com>
 <CAMP44s3NNDL+zJjaukV9D2dJyU=ugSrnWz9o-whO9hKnBTxAow@mail.gmail.com>
 <xmqqtussirsl.fsf@gitster.c.googlers.com>
 <X9ggAxk/z0D9Qom+@coredump.intra.peff.net>
Subject: Re: [PATCH v2 02/14] pull: improve default warning
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Thu, Dec 10, 2020 at 11:17:01PM -0800, Junio C Hamano wrote:
> 
> > You want to let the user express: "I do not want to choose either
> > rebase or merge.  I want 'pull' to fail when it needs to deal with
> > non-ff history.  But I do not need to be told about command line
> > option and configuration every time."
> > 
> > I said I don't (I view that disabling half the "git pull" just a
> > safe fallback behaviour until the user chooses between merge and
> > rebase), but if we wanted to offer it as a valid choice to users, we
> > can do so.  We just make it possible to squelch the latter two parts
> > of the three-part message---you leave pull.rebase unconfigured and
> > squelch the latter two parts of the message, and you got the "stop
> > me, I do not merge or rebase, but don't even tell me how to further
> > configure" already.
> 
> FWIW, I would be such a user who would want to squelch the error but
> keep the ff-only behavior (and have been doing so for years via
> pull.ff=only).

If you have configured pull.ff=only, you should be getting this error:

	Not possible to fast-forward, aborting.

We would like this error instead:

  Not a fast-forward, either merge or rebase.

And after that it should be obvious what this command should do with
your current configuration:

  git pull --merge

But it would fail, even after specifying you want to do a merge, because
"git pull --ff-only --merge" fails.

> So I think this is a valuable thing to have. And it does work just fine
> already, without pull.mode. The reasons to care about pull.mode (IMHO)
> are mostly about explaining it:
> 
>   - it isn't respected with rebase. So if you set pull.rebase=true, now
>     pull.ff=only does nothing. This is arguably confusing, though I
>     doubt it comes up much in practice.
> 
>   - having a single tri-state of merge/rebase/error for "what do I do
>     when pulling a non-fast-forward merge" is conceptually simple and
>     easy to explain.

Indeed. It's *mostly* about explaining it, but there's also what I
stated above:

  git -c pull.mode=fast-forward pull
  git -c pull.mode=fast-forward pull --merge

We want the first one to fail, and the second one to succeed, which
can't be done with the current "pull.ff=only".

> So I like pull.mode in that sense. But it is also weighed against the
> fact that we'd still have to support pull.rebase, and we'd still have to
> support pull.ff, and explain how those interact with pull.mode (and I
> think any new error in this area must be squelched by those existing
> variables, or it would be a regression for people who already picked
> their default long ago).

The interactions should be easy:

  * pull.rebase=false -> pull.mode=merge
  * pull.rebase=the-rest -> pull.mode=rebase
  * pull.ff=only -> pull.mode=fast-forward

(note: I'm not entirely sure of the last one)

Then, any --merge/--rebase option overrides the mode, but not so the
--ff options.

We would still like this to fail:

  git -c pull.mode=merge pull --ff-only

Right?

In other words: pull.mode is strongly linked with pull.rebase, but not so
much wih --ff*.

> > But there is an established way used in this project when we allow
> > squelching overly-helpful help messages, and we can apply it here as
> > well.  That way:
> > 
> >  - unconfigured folks would get all the three parts of the messages,
> >    just like the current system.
> > 
> >  - if you tell rebase or merge, you do not see any.
> > 
> >  - if you do not choose between rebase or merge, you can still
> >    squelch the latter two by setting advice.pullNonFF to false.
> > 
> > The last one is "keep the more dangerous half of 'git pull' disabled,
> > without getting told how to enable it over and over", which is what
> > you want to be able to specify.
> 
> Using advice.* to squelch the advice would be fine with me, provided it
> was _also_ squelched by the existing config options.
> 
> Which I think is where your thinking is ending up.

Yes. At least that's my thinking.

Cheers.

-- 
Felipe Contreras
