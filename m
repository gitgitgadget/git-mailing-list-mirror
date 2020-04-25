Return-Path: <SRS0=d/2q=6J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88058C54FCB
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 14:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D94C20704
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 14:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RCDDf+Vw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbgDYOMX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Apr 2020 10:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726050AbgDYOMW (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 25 Apr 2020 10:12:22 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC76C09B04B
        for <git@vger.kernel.org>; Sat, 25 Apr 2020 07:12:22 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id i68so10415450qtb.5
        for <git@vger.kernel.org>; Sat, 25 Apr 2020 07:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GAkWVNAPqHRB84v3zlNUV0nvXUw+hki+3wQ7ZbqqfSg=;
        b=RCDDf+VwFO1JAQpyTjk9VRvn7d1c7etHBxpFZuVM5bO9CtgnkjgLxnUMNvdATPZ7yZ
         vgxV9jhj21jagTTKM1TXrk+2tEzj/3jzOHcP+sw6VBFgEUfFiW6sliuaPryQJo04qf+c
         QVuDU+h3QX5foFWH3LCfyaLuMU2iB79RcPYqLY/qdtiz/cWwEGxwA7WwUyriOfuQBo4b
         YDuzEKns8d8epAb/qTXOR4U+JVFYmcZ7O6V5uqZ7RxOzZcXNRav/kHcLs+RNW1Wt/G5r
         L80vTHkO0Ct6sDKYd81ebXVDdEFsJ8VRQ+wIirVpatFMXJmwLollJFMlWdyahjW3QdyI
         k/Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GAkWVNAPqHRB84v3zlNUV0nvXUw+hki+3wQ7ZbqqfSg=;
        b=tGJWkyZ2Xut6Hexrq62M6kRzI3dUUA0v9Y4jPYiqiHmry1vFQDwVlFJlk4PAO5UIdr
         jJm/eh5nztTwNOy0M43AR5esnVJ3bSktoMzHQUIIa9Cei9CCAEi1Ut6Eq0MUSP7xPKvm
         1OZDKRMVs3G0aGbWVo8GYK3JBWE+CvMOqeiVmsjAvt9NNtsxsxCE4oBzfdExTJKzw2gc
         57nW+VzpGlzG0wmH2durdJYVsoQuYaT4zScvdFpoEJZTLuMVkOyYjJ0EOyxxJ4tYHMCQ
         eiAZbYRSLa7NbJmEFwsj2sH2behAN/jHu7QyKrBMCVneZA8KBRo+oK1VBvPlxLnd2VbQ
         Wigw==
X-Gm-Message-State: AGi0PuY4skznelCPfHGT+jZiZ2lMF/49BBt5yOo52mtylwOFmdhNNisU
        UZBmg8bl7M6an5eIJJCMZ5Nrs5T+uoqGrSTH+bs=
X-Google-Smtp-Source: APiQypLa1NlXcvdsPJ3z9V0/VQoMKAd2YPf8XCn9JQeGBadcl8isj3ezJ1BaKX7gXyWSo4sLqMJAO9LFVHJE+wiY0S8=
X-Received: by 2002:ac8:7448:: with SMTP id h8mr14908925qtr.225.1587823941445;
 Sat, 25 Apr 2020 07:12:21 -0700 (PDT)
MIME-Version: 1.0
References: <pull.614.git.1587700897.gitgitgadget@gmail.com>
 <xmqqv9lod85m.fsf@gitster.c.googlers.com> <CAKiG+9V_nZUXf2a689vZ54rG+xTCFMGcJe_7Av-khaxxuijERg@mail.gmail.com>
 <xmqq8sikblv2.fsf@gitster.c.googlers.com> <CAKiG+9Xtof8Hj3npsS-M0SnT_dcjtHjP_+avWB4oOHkaMdnSbw@mail.gmail.com>
 <40da111a-77e0-55b1-a6c2-9edc77cf1f3c@iee.email> <nycvar.QRO.7.76.6.2004251523560.18039@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2004251523560.18039@tvgsbejvaqbjf.bet>
From:   Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Date:   Sat, 25 Apr 2020 19:42:10 +0530
Message-ID: <CAKiG+9VMjft14ttqQuZMwewOGFbnbfJ3uXn0vPiJb05A8wdSwg@mail.gmail.com>
Subject: Re: [PATCH 0/8] CMake build system for git
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Philip Oakley <philipoakley@iee.email>,
        Junio C Hamano <gitster@pobox.com>,
        Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philip and Dscho

On Sat, Apr 25, 2020 at 6:59 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Philip,
>
> On Sat, 25 Apr 2020, Philip Oakley wrote:
>
> > On 25/04/2020 05:09, Sibi Siddharthan wrote:
> > > On Sat, Apr 25, 2020 at 3:13 AM Junio C Hamano <gitster@pobox.com> wrote:
> > >> Sibi Siddharthan <sibisiddharthan.github@gmail.com> writes:
> > >>
> > >>> The goal would be to maintain a CMake build for Git keeping it in
> > >>> sync with the Makefile. The Makefile is not going to be replaced at
> > >>> all. The CMake script for now only supports Linux and Windows. It
> > >>> does not support BSD, Solaris and others, whereas the Makefile does
> > >>> support them.
> > >>
> > >> So you are doing (1).  I already said that I feel that engineering
> > >> burden to divert resources for CMake support would be unacceptably
> > >> high.
> > >>
> > >> Whenever any of our developers need to add source files, Makefile
> > >> configuration knobs that people can add to config.mak, etc., you are
> > >> forcing them to figure out where in the CMakefile to add them or
> > >> devise ways to allow builders who do not use config.mak (because they
> > >> use CMake) to do similar tweaks.
> > >
> > > Adding source files to the CMakefile is going to just as long as
> > > adding it to the Makefile, anyone can figure this out and this is not
> > > going to take much time at all.
> >
> > While figuring these things out isn't /hard/ it can be tedious and time
> > consuming for those who are not familiar with the particular tool set
> > (as evidenced, in my mind, by the poor dev support for Git for Windows
> > because of the need to understand two operating systems and their
> > awkward interactions) - those that are familiar and understand the/their
> > whole tool set are usually the x10 folks.

One way of reducing the tediousness is to guide the developers in the
Contribuiting document
as to where to add the new source files for both the Makefile and CMake script.

>
> Is it fair to compare the complexities of the differences between what Git
> expects and what Windows provides to the difference to add files to
> Makefile _and_ CMakeLists.txt?
>
> When I add a file to the Makefile, what I do (and imagine that _everybody_
> is doing in that circumstance) is to find an already-existing file that is
> similar to the one I want to add. For example, if adding
> `builtin/oakley--helper.c`, I will try to imitate
> `builtin/submodule--helper.c`.
>
> And when you do that, you don't really need to understand Makefiles or
> CMake. You find the list(s) and add your file there, paying attention to
> whether it is maintained alphabetically or append-only.
>
> That is a _far_ cry from the hoops through which you have to jump to
> understand, say, the important background details in order to start
> working on `compat/mingw.c`.
>
> At least from my point of view, there is very little analogy between the
> subject under discussion and what you brought up.
>
> Having said that...
>
> > > As for the configuration knobs I agree that adding the same to CMake
> > > is going to a bit longer.
> > > But anyone who is hacking Git is going to do it with the Makefile or
> > > (if accepted)CMake script, but not both while hacking.
> > > So they will continue to make progress with the system they feel comfortable in.
> > > They will only run into an issue when they try for a PR. Currently the
> > > CMake script is only used for generating the visual studio solution.
> > > We can add a (continue-on-error) to vs-build job to make this process
> > > less of a hindrance.
> > > If people take the time to hack Git, figuring out how to do the
> > > configuration knobs in the CMake script is not going to that much take
> > > time
> > > compared to the time they spend making Git better.
> > >
> > >
> > >> Any patch that is acceptable to the current project would become
> > >> unacceptable because they lack updates to CMake part, but I suspect
> > >> we do not have enough people who are so much devoted to give a good
> > >> review if updates to CMake part are added.  And it is unclear why it
> > >> would be beneficial to slow our existing developers down by forcing
> > >> them to become familiar with CMake.
> > >>
> > >> So..., I am not just "still not convinced", but I am even more
> > >> convinced that we do not want this series, after thinking about it
> > >> longer.
> > >>
> > >> Thanks.
> > >>
> >
> > Is there a middle way, given that IIUC there is most benefit on the
> > Windows side, that on the git.git side the Makefile could contain a
> > suitable comment directing those interested in CMake to the relevant
> > part of Git-for-Windows. Is there a part that could hold, and track, the
> > matching changes to the primary Makefile?
>
> We already use `GIT-VERSION-GEN` as the authoritative source for the Git
> version, by parsing the line that contains.
>
> It would look very similar, at least in my mind, to generate the list of
> source/script files by parsing the `Makefile`.
>
> Sibi, what do you think?
>

One way of doing it is to track if the Makefile is changed in a
commit, run a hook
to see if it contains any new OBJs and match it with the CMake script.
But this is too much work, in my opinion.

For the scripts, things are a bit complicated, suppose people use sed
and grep to
do their logic in the Makefile, we add "sed" and "grep" dependencies
to the build process
This is not a bad thing, but the same logic can be implemented in
CMake without "grep" and "sed".
Also, the Makefile script generation logics are path relative, which
should be modified in CMake
to have arbitrary build and source directories.

The better option is to guide developers how to add their build
changes to CMake also. (This is not hard at all)

> Ciao,
> Dscho

Thank You,
Sibi Siddharthan
