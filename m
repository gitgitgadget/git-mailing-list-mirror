Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8238FC55ABD
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 15:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 367B2208D5
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 15:37:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nHu2xLf4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgKMPhy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Nov 2020 10:37:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbgKMPhy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Nov 2020 10:37:54 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1DD7C0613D1
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 07:37:53 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id u12so3142181wrt.0
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 07:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lbo3ZmMfskdK3ARqM70Mm1Om/fcTMjfz9q54Emirqto=;
        b=nHu2xLf4b4t934fKoRl6FTmnxu0dI/RoanMXhN00SZzDQ/GYwR3xyZDL5pE6o6kztq
         4lkCyC7LA60pdTXQi9cgxU318Ze6se0Flg8kgM0vQgNrNkA6mnHAQ9FxHFf8rlTsD0io
         bDNIklO7NiT3lsr07VWDXeHbzFnv7B8fUT2C/GInaUZVZVva+jjkifhEiRpHFl2vSGrD
         HaxvbFpK5G+T/BwWCyEWXnorKtzi1vUM4Cnb1T4zhOE0Fi2JwOjv7U4wrz+qQC+M6OVk
         4MvPLgTHLhPvzwQQBIlkPL+hwls7lnHfRAFEbhKZa5zTGvppQCpZhZFtYEeWLF9oSkax
         7z3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lbo3ZmMfskdK3ARqM70Mm1Om/fcTMjfz9q54Emirqto=;
        b=iXINqtWioUPkdgEYzg5/WTm8IyB394y3dfzjERVnyQ6gEjp050AjWW3CEf5rAwysS7
         G3DZvwHUvBZmeRTCwfnGhsCY5w+A5PVGUcHnvkBawOhundT2281n+tGLs5vn0DlgXtPW
         sISpIzDTGpWbH8ZYmHER6AUFgPSV4wl9T1dYUqUYBlijBJYm/vrdnvwFnNTzj3w7CYYt
         iyV5jmOQWY4bE6/eUdZzSksJ05eIcQ/N05a1OPlWEWLISnm8Gc5fHFLYtJlBMAV/g5ni
         +hvRHsOFKnUN+TvzWiRe5MeoJO+BXVvC/M8qRpPqO/vRQwL0gQGd29EtUyGTkYFi7pno
         kmNw==
X-Gm-Message-State: AOAM531UPweONHnI0Q8CLpfXDLhsY60ULJvTNv00yUI8F1y+pg3YBoci
        sJ7m2eLrYLjopzInrZZc4XgZ8vosPVQPzrpwgcZbBqPkcdc=
X-Google-Smtp-Source: ABdhPJx49dSkB6Q7bm+vRY6mQ+ajIrW/6koxJmTSkI4+nV819eIAs3LfDqX2OXmX88kBvr4JjtgduZpdxKYj/KMuDzw=
X-Received: by 2002:a5d:52c1:: with SMTP id r1mr4384605wrv.255.1605281867517;
 Fri, 13 Nov 2020 07:37:47 -0800 (PST)
MIME-Version: 1.0
References: <CAMP44s3BJ3dGsLJ-6yA-Po459=+m826KD9an4+P3qOY1vkbxZg@mail.gmail.com>
 <20201113010107.GL6252@camp.crustytoothpaste.net> <CAMP44s1U1FevS7NrAYxvgVyzfR5tnD9-+BbPdw5bKnaNHkyD+A@mail.gmail.com>
 <20201113051408.GA3985404@mit.edu> <CAMP44s3AeESm7VBKbar0ir_Py35g99ZW6bNX_=AK4N=OFkcrdA@mail.gmail.com>
 <20201113145802.GB3985404@mit.edu>
In-Reply-To: <20201113145802.GB3985404@mit.edu>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Fri, 13 Nov 2020 09:37:36 -0600
Message-ID: <CAMP44s1TV3MJtSpUW_iEppg_0ArkTEh_u-gJLmhcCEyVfhXspA@mail.gmail.com>
Subject: Re: The master branch rename, and avoiding another v1.6.0 git-foo fiasco
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Don Goodman-Wilson <don@goodman-wilson.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 13, 2020 at 8:58 AM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> On Fri, Nov 13, 2020 at 12:28:52AM -0600, Felipe Contreras wrote:
> > On Thu, Nov 12, 2020 at 11:14 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
> >
> > > Is it changing the default branch name when creating a new repository?
> > > (Which affects only people creating new repositories)
> >
> > You may choose to downplay the experience of certain part of the
> > user-base, because in your experience creating new repositories
> > doesn't happen often, but that doesn't mean these users don't exist.
>
> OK, fine.  That wasn't clear in your earlier messages.  So this is
> *not* like 2008, where we are breaking workflows or finger macros of
> *existing* git users.

In some ways it's not as bad, but in others it's worse.

I suspect the political nature of the change is not going to be well
received, especially if it's snuck on them.

> Instead, we might be causing a certain amount of confusion with
> respect to *new* users, especially if some portion of them are using
> an older version of git, where the default initial branch name is
> "master", or a newer version of git, where the default initial branch
> name is "main".

It's not just new users. There may be other kinds of users accustomed
to creating repositories. Not all users follow the same kind of
workflows, some may not even use Git for software development.

I don't think we can claim with much certainty how *everyone* uses Git.

> It's important we be specific about the concern, as opposed to using
> abstract notions of "backwards compatibility".  Because I'll note that
> even if we were to release a git 3.0, it's not going to fix the
> potential confusion where some students / new users trying to follow a
> tutorial are using git 2.x, and some are using git 3.x.

It's not going to fix them, but it would ameliorate them.

Some people today do know what changed in Bash 4.0, not so much what
changed from 3.1 to 3.2.

This is what major versions are for.

> We could delay making the change for years, but that isn't going to
> guarantee that all of the various tutorials on the 'net will be
> changed, and experience from long deprecation periods (exhibit 1:
> Pythonx 2.x vs Python 3) is that people will drag there feet and put
> off doing the work to migrate for years and years and years.

This is a false equivalence.

Yes, the migration to Python 3 was a problem, the lesson here is:
don't do what Python developers did. Ruby took a completely different
approach, and the move to Ruby 1.x to Ruby 2.0 was basically painless.

The Git project already had one basically painless major version bump,
and in my view it was generally well received. If anything it should
have changed *more* things.

Not all major version bumps are the same, and the Git project can
learn to do them the right way.

> So I think it's worth making explicit exact what the nature of the
> breakage is: specifically, some confusion for new users following
> tutorials that haven't been updated, and to balance that off against
> the costs of delaying the change for years and years and years.  And
> that's because individual projects and individual git repositories are
> making that change *already*.  So changing what the default "out of
> the box" might be in some ways will make it worse for new users who
> follow the some random git tutorial or traning on the web and then
> then have to interact with some open source community which has
> already changed their primary development branch to be "main".

This is once again a false equivalence.

What other projects did is the equivalent of changing the master brain
in git.git to something else. That's up to Junio and I don't
particularly care one way or another (although I would prefer if he
didn't). That would affect a relatively small number of people: Git
developers.

Changing the default of the tool is an entirely different thing that
will affect thousands of people. Apples and oranges.

Then you say if we delay it would be for "years and years and years".
Who said so? Why can't it be one year? Or six months? If it doesn't
happen tomorrow it will have to happen in 2030? No.

And then you mention other projects. Well, what other projects do is
their prerogative. Nobody forced them to make a premature decision,
and if their users suffer as a result, that's on them.

The Git project should not be held hostage by the decisions of other
projects. If it takes a couple of months, or even a year, for a change
to be done right without breaking user expectations, so be it.

> If we know that's the concern, then we can improve the messaging and
> documentation, and I appreciate that you have done some work along
> those lines already.  So let's see how we can address the problem
> constructively; maybe that means making the git default trailing edge
> as opposed to helping to lead the change.   Maybe not.

I think you misunderstood. I did the documentation work in 2008, for
the git-foo change, *after* the change was already rolled out, the
users complained, and I noticed the documentation was not updated.

I have not done anything for the master rename, which I believe is a
huge mistake, and has not been discussed properly yet.

That is a separate subject, here I'm just talking about the impact of
the patch that was just sent.

Moreover, none of what you have argued so far has any bearing on my
point about enabling warnings and a deprecation period.

Even if we don't wait for Git 3.0, a warning should be shown at least
a couple of months before the actual switch happens.

To sneak up an entirely political change like this without warning is
disrespecting the user-base, it's what caused the *huge* complaints in
2008, and it's just not cool.

Cheers.

-- 
Felipe Contreras
