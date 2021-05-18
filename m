Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0557C433B4
	for <git@archiver.kernel.org>; Tue, 18 May 2021 11:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA0CB60BD3
	for <git@archiver.kernel.org>; Tue, 18 May 2021 11:42:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244484AbhERLnY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 May 2021 07:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232820AbhERLnW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 May 2021 07:43:22 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E306C061573
        for <git@vger.kernel.org>; Tue, 18 May 2021 04:42:03 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id d3-20020a9d29030000b029027e8019067fso8305639otb.13
        for <git@vger.kernel.org>; Tue, 18 May 2021 04:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=sVuO8Zaa1a7MrGL9M/BXRG3vSo5RCmUYh2h/DWl7wWI=;
        b=FYqCdNPLUfcIGH+b3UtHYA+ahcRLkeYbirdWof2zeDMItqqnEBwDooRoDIg3fI8dyK
         icCbsB2eE2nTOAiU0urlZWb72SZgGD33b1d0stgbwjujL3u4NxJW6xHdu1GfaZ5nzZAr
         EhgDWuhSEYYO22G6IQd+bdNMKUEsA0utSJzsbo9RU9dqeDtG90XnGR9pW5q+20PL1u+W
         2nzwmwDQzxLvPVAYSmyYjWflP1fkAYe8kR5zZiy0REjvInpD6hL5kLO3UBh5ye6k3nO8
         grjc4+ySviEZS5haWoXOahJQs2fOG46Dc8M0TyTcgXEBu3t4zh/wr1MriAqog9O1BU72
         YRNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=sVuO8Zaa1a7MrGL9M/BXRG3vSo5RCmUYh2h/DWl7wWI=;
        b=ZFCXnEP6laLaUVVf6IuCFS9eXpV78ssXzbgvRAodg/IJcw4f9XZ/BUnCjUM9DjRQJz
         G/+boiOksV/8ZzfJzXx6XcMzzLGgSXdoOtmWQF8T7y63PHNkG1dDB+VxvVZ0H3I/sG5d
         eht+N5ceSxrC3i8YK5ZhABtJMEoTWSj0+B524aN+ivPyKnHZXhnieuuQLg5Rviv+CaFO
         sXIi+UOS58p4G9p/9GkMTtoY8IAt2xtX1I86fg3Zb046tPx8MVCo4kp5iEdiJielHFCD
         iHpwEn7tbTZZjr710jzpLAzrBSTfW4FQIyDTA0e/4JWNBcyYkpIdWI0YHMCMn9FOxOy2
         VW8Q==
X-Gm-Message-State: AOAM533hPAZlbz8gYNpqjm3MmJjIBNo0U5adHW5Uv03jLj9cjxsoa0KD
        9dmU9t3TAiC8ZUyR3hd3oJ0=
X-Google-Smtp-Source: ABdhPJw4WOBUNseAP+Ba2m3dY9DKKIZVmNZbbtOVD02bHtXH8piIZWafxcaaeSvH6F+Kudnqkxz9Sw==
X-Received: by 2002:a9d:c64:: with SMTP id 91mr3908269otr.130.1621338122932;
        Tue, 18 May 2021 04:42:02 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id u24sm3802112otg.73.2021.05.18.04.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 04:42:02 -0700 (PDT)
Date:   Tue, 18 May 2021 06:42:00 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Richard Hansen <rhansen@rhansen.org>
Message-ID: <60a3a808d7eeb_151987208bb@natae.notmuch>
In-Reply-To: <YKNk+5k3hKW/xPBZ@coredump.intra.peff.net>
References: <20210516203736.1098072-1-felipe.contreras@gmail.com>
 <xmqqbl993irp.fsf@gitster.g>
 <60a245a927c62_126333208ea@natae.notmuch>
 <YKJZt4vFECoLZhc2@coredump.intra.peff.net>
 <xmqqpmxp6u13.fsf@gitster.g>
 <60a2daa57d8a6_13c370208f3@natae.notmuch>
 <YKMhqZNhamnKqWfi@coredump.intra.peff.net>
 <60a34a7616cda_14d1bc20818@natae.notmuch>
 <YKNk+5k3hKW/xPBZ@coredump.intra.peff.net>
Subject: Re: Re* [PATCH] doc: glossary: add entry for revision range
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Tue, May 18, 2021 at 12:02:46AM -0500, Felipe Contreras wrote:
> 
> > > Why would people need to use "git remote set-head" most of the time? The
> > > symlink is set up properly by git-clone, and has been for many years.
> > 
> > First instructions from GitHub:
> > 
> >   echo "# test" >> README.md
> >   git init
> >   git add README.md
> >   git commit -m "first commit"
> >   git branch -M main
> >   git remote add origin git@github.com:felipec/test.git
> >   git push -u origin main
> > 
> > Second instructions from GitHub:
> > 
> >   git remote add origin git@github.com:felipec/test.git
> >   git branch -M main
> >   git push -u origin main
> > 
> > None of these use `git clone`.
> 
> So? Here are some other instructions from GitHub[0]:
> 
>   Type git clone, and then paste the URL you copied earlier.
> 
>     $ git clone https://github.com/YOUR-USERNAME/YOUR-REPOSITORY
> 
> [0] https://docs.github.com/en/github/creating-cloning-and-archiving-repositories/cloning-a-repository

A random github.com link doesn't show anything. The instructions I'm
talking about are the **first** thing the site gives to users.

On the other hand let's see how we get to your link.

 1. Click "New"
 2. Type "Repository Name"
 3. Click "Create repository"
 4. Ignore the entire setup page (with the `git remote add` commands)
 5. Click on your profile icon
 6. Select "Help"
 7. Go to the GitHub.com submenu
 8. Ignore the Quickstart
   8.1. Ignore the Git cheatsheet
     8.1.1. Ignore the `git remote add` part of the cheatsheet that
            comes before the `git clone` part
 9. Ignore Getting started with Git
   9.1. Ignore About remote repositories
     9.1.1 Ignore the section Creating remote repositories which does
           `git remote add` before it mentions `git clone`
   9.2. Ignore Managing remote repositories (talks about `git remote
        add`)
 10. Select Creating, cloning, and archiving repositories
 11. Select Cloning a repository

Finally we reach that link.

To reach that link we need to ignore **all** the tips GitHub gives, and
directly click on a sbusbusection called "Cloning a repository", which
is part of a subsection "Creating, cloning, and archiving repositories"
which is part of the section GitHub.com, which is part of the help.

I seriously dobut this is one of the first things any user sees.

> Not to mention that every single repository page mentions cloning under
> the "Code" button (including the command-line "gh repo clone" if you are
> using their recommended tool).
> 
> People clone a lot more than they create new repositories.

Depends what you call "people". If you are talking about professional
software developers, then maybe.

But they are not the only users of git.

Do you have any stats?

> > Of 31 repositories I work on and have quickly at hand only 8 have
> > origin/HEAD.
> 
> And of 141 repositories I have on my workstation, 137 have origin/HEAD
> (and of the 4 without, one does not even have a remote at all, and one
> is a git-svn repository).
> 
> I don't think that proves anything except that your workflow is
> different than mine.

Exactly, and we cannot assume most people follow your workflow. In fact,
I'd say your workflow is probably one of the most atypical in the world.
You know tricks 99.99% of users don't know about, in fact that probably
99% of git.git developers don't know.

It is sufficient to acknowledge that there are different workflows.

> > And even *if* origin/HEAD did work on most repositories (hardly the
> > case), most people are not going to train their fingers to type `git cmd
> > $x` when the only $x where the command works is "origin"; they would
> > rather train their fingers to do $x/master which works on many more
> > repositories.
> 
> I guess I'm not most people, because I sure have enjoyed typing the
> shorter thing all these years.

You are not part of that subset.

I'm talking about people that do have "origin/HEAD", but *don't* have
any other "$remote/HEAD".

Do you have a HEAD configured for most of your remotes?

> Look, I get that you didn't know or care about the "origin/HEAD" feature
> until recently. But it's been part of Git for over 15 years, and has
> been used as the documentation examples for revision ranges in both
> git-rev-list(1) and gitrevisions(7), as well as the user-manual.

The fact that something is part of the documentation doesn't mean it is
well-known.

The `git remote add -m` option has been documented since 2007, and you
yourself didn't know about it. If you google for that you find nothing.
There's only 1. a qustion on Stack Overflow with zero votes, and 2. the
mail I send you about it. That's it.

Do you agree that `git remote add -m` is obscure?

If so, why is it different from origin/HEAD?

I decided to skim through the entire Pro Git book to see if I could find
any instance in which they use this shortcut... I found **zero**.

If a user can read the most well-known book about git that had hundreds
of contributors without finding a single instance of this shortcut...
How common do you really think it is?

In, fact, I found an interesting quote: "The git rerere functionality is
a bit of a hidden feature." If rerere is a "hidden feature" then what
what is origin/HEAD?

> I'm perfectly happy to use placeholder ref names in the glossary
> documentation, but it's not like the use of "origin" as a name is some
> obscure secret.

It's easier to flip the problem around: if origin/HEAD is well-known,
what would we *not* expect to find?

Is there anything that would falsify the premise?

Cheers.

-- 
Felipe Contreras
