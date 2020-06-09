Return-Path: <SRS0=lPKc=7W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5289C433E0
	for <git@archiver.kernel.org>; Tue,  9 Jun 2020 15:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A7B92074B
	for <git@archiver.kernel.org>; Tue,  9 Jun 2020 15:17:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bocoup-com.20150623.gappssmtp.com header.i=@bocoup-com.20150623.gappssmtp.com header.b="JDWooaoH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730716AbgFIPRL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Jun 2020 11:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbgFIPRL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jun 2020 11:17:11 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EECE8C05BD1E
        for <git@vger.kernel.org>; Tue,  9 Jun 2020 08:17:10 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id n70so4433092ota.5
        for <git@vger.kernel.org>; Tue, 09 Jun 2020 08:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bocoup-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/IScaURb0LJr7O9BLNfmLb2PchMNZZENaGkxcJUvsKs=;
        b=JDWooaoHroSIBHbI0U/uW1tT4UwRkTvmaqhGwXV18Nv2uGjTk/JoOzp4pxg+qeryMp
         O6Wy0nwm7DBo5QfMEkHtlNKNsYsLpzsHj/Q18ehhmzVSJys2OndLKp7agZnkTQ50VIqu
         9PBBVtwClfx/I1aV0SEKpmvDH9Q/ZuWN6t+Who+r1iUzuaqnZc+KEvcjMay1tWNsCnss
         CW0EtCeZKFDTnXSkPHN2rzJMgdugk/sSwa5fFNN8ZuI4C7OzMJLCvG8nT9g8Yjgr0WjB
         GPP90Rty1Y+2qlcoxFGGg81Nsp6S36f/ld6g1E8OpENPzjsUZGNutc2Usn3qaOtqnlSn
         2ozA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/IScaURb0LJr7O9BLNfmLb2PchMNZZENaGkxcJUvsKs=;
        b=RDiQV8HN+Xafw+yCu5mnnAjhpzlciy5kwTRb+FrhGuIU0Z8AkiYnuhqSQeSouk5jkE
         DvAYMZszZkTv9e1TZpsQ6ubSY+blVg0T3pU6Eq0jjI9etFZZYKROPd4ubefCskb9D5oC
         Kl7wnA90XktpNvQY2mpdIX2eWx2XEGaW88SpDVVqtFsfEJdaIGhQcMPRHaRuPNAkGocN
         7l6unosQonRwVat/lJX7Q+P4WZTiyMQ+lUI//IBytu7JJRSLlBwkkFhEM1mYUdHi9rm0
         HoAo7jYv8LnjSW0BD9/roFhFRbYXQOICHCnJZfC94gquevhKbaPzqsBiV/1wGc4rpuaU
         PuGA==
X-Gm-Message-State: AOAM530r+/xdhV2xSIyfC2udBj0UbQSsCZ3IOGOgdNTqQEX8QhdwjA7l
        L8xhUqnfpymLWl2reVUQDZb24+sg/goZC0bRdVzJ9A==
X-Google-Smtp-Source: ABdhPJy7z2i6nFGbB19gf6m3on3g3leZWvnynQPlw5ZsNH9Iz9Vb9zMlRxN61iHq5tKQ6jmRU/+ZU6cnR34LQbHvifg=
X-Received: by 2002:a9d:6e84:: with SMTP id a4mr21326244otr.112.1591715829320;
 Tue, 09 Jun 2020 08:17:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAOAHyQwyXC1Z3v7BZAC+Bq6JBaM7FvBenA-1fcqeDV==apdWDg@mail.gmail.com>
 <20200505231641.GH6530@camp.crustytoothpaste.net>
In-Reply-To: <20200505231641.GH6530@camp.crustytoothpaste.net>
From:   Simon Pieters <simon@bocoup.com>
Date:   Tue, 9 Jun 2020 17:16:57 +0200
Message-ID: <CAOAHyQx=+fM1FpAv+g3M+j7j4MgLJA03=MGFmXLvZcfJKAEpGg@mail.gmail.com>
Subject: Re: Rename offensive terminology (master)
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Cc:     don@goodman-wilson.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for your encouraging response, Brian, and the research of
what the change entails for git.

I've added Don to the cc, who started to work on implementing this change:

https://twitter.com/DEGoodmanWilson/status/1269931743320182784
https://github.com/git-for-windows/git/issues/2674

Although I think it's reasonable to move away from 'master' regardless
of its origin, today Tobie Langel pointed me to
https://mail.gnome.org/archives/desktop-devel-list/2019-May/msg00066.html
where, one year ago, Bastien Nocera made the case that git's 'master'
is in fact a reference to master/slave.

If someone is interested in helping with this, please follow up with
Don. But I would like to ask again for git mainline to seriously
consider adopting this change, given the information presented above
and the ongoing movement against systemic racism.

cheers,

On Wed, May 6, 2020 at 1:17 AM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2020-05-04 at 17:20:33, Simon Pieters wrote:
> > "master" is an offensive term, as it can be interpreted as being
> > slavery-origin terminology. See
> > https://en.wikipedia.org/wiki/Master/slave_(technology)#Terminology_concerns
> >
> > The Python programming language, and various other projects, have
> > taken a stance and moved away from offensive terminology including
> > "master". See https://bugs.python.org/issue34605
> >
> > When different projects using git decide to move away from "master" as
> > the name of their main branch, inconsistency ensues between projects.
> > See https://github.com/desktop/desktop/issues/6478 (and "Related
> > Issues and Projects").
> >
> > To avoid offensive terminology and to avoid further inconsistency, I
> > think git should use a different branch name than "master" when
> > initiating a repo. I don't have a strong opinion, but I like "main"
> > since it shares the first two characters and it's shorter.
>
> I've been busy and haven't had much time to respond to this, but I've
> gotten some feedback from other people on this issue and so I'll share a
> few thoughts.
>
> Others have pointed out that "master" meaning a canonical source may not
> share the problematic origins mentioned above.  From feedback I've
> received, I get the impression that "master", even though from a
> different origin, brings the idea of human bondage and suffering to mind
> for a non-trivial number of people, which of course was not the
> intention and is undesirable.  I suspect if we were making the decision
> today, we'd pick another name, since that's not what we want people to
> think of when they use Git.
>
> Clearly we have compatibility concerns to consider though, so if we
> decided to make a change, we'd probably want to make it in a 3.0, which
> as far as I'm aware hasn't been discussed yet.  I also wondered what
> such a change would involve, so I did some research.
>
> It appears that if we made the obvious one-line change to
> builtin/init-db.c, we'd have 304 tests that fail, which is about a third
> of our test suite.  I haven't examined any of these tests, so I don't
> know what would be involved in changing them.  I imagine a project to do
> so would involve setting an environment variable in the test setup code
> (e.g., MAIN_BRANCH) and replacing instances of "master" with that until
> everything works with an alternate value of that variable.  Picking the
> new name itself could be deferred until later, and we could choose from
> some popular alternatives.
>
> There's also the documentation, which at first glance seems mostly to be
> examples, many of which could be changed to any suitable branch name.
> There are a large number of those cases and someone would have to audit
> them all.
>
> So it looks like this would be a reasonable amount of work for someone
> if they decided to pick it up as a project.  Since I have limited free
> time and am working on the SHA-256 transition, I won't be doing this,
> but if someone did pick it up, I would be happy to do some reviews,
> provide feedback, and include a few patches while doing other work in
> the area.
>
> I realize there isn't agreement on a direction forward or whether this
> is worth doing at all, but since Git usually operates by providing
> feedback on an initial set of patches, I thought I'd sketch out what
> that might look like for folks who were interested.
>
> I should point out that it's also possible for users who dislike the
> current name to use a template to change the default branch name like
> so (using the proposed "main"):
>
>   mkdir -p ~/Templates/git
>   cp -a /usr/share/git-core/templates/* ~/Templates/git
>   echo 'ref: refs/heads/main' > ~/Templates/git/HEAD
>   git config --global init.templateDir ~/Templates/git
>
> Then "git init" will set your default branch to "main" instead of
> "master".  This does have the weirdness that it claims it's
> reinitializing your repository, but otherwise appears to work.  That is
> of course orthogonal to changing Git itself, but is an option for folks
> who'd like to make a change now.
> --
> brian m. carlson: Houston, Texas, US
> OpenPGP: https://keybase.io/bk2204



-- 
Simon Pieters
Bocoup https://bocoup.com/
