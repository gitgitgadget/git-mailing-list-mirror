Return-Path: <SRS0=LBHq=C6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA54C43464
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 04:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 946DA20866
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 04:22:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B5MO+NPT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbgIUEWn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Sep 2020 00:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbgIUEWn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Sep 2020 00:22:43 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58DFC061755
        for <git@vger.kernel.org>; Sun, 20 Sep 2020 21:22:42 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id nw23so15735995ejb.4
        for <git@vger.kernel.org>; Sun, 20 Sep 2020 21:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6oD9079M7osGawowiIAwkYPnu00uG0rPQ5TmBcHrqM4=;
        b=B5MO+NPTKWMd3Sa4zvvBYAQBjWrVP1EwXcBnbMttLnWKwlvm1mXlpe9uZfvQfDm1oP
         Zsx4vsloBLJuPcU/9E6pambh7BQYg3kaZtCPmfDdMcHkgagfRXVXcCOE6QsJAUdI2Jpn
         Be8wb8QD2e9M6Vre5fpESYqlvE0OcLZv1YvPbZeq4soxoK/mE0i+x8U3FWYY5P9N9Tm5
         G7kAuAoInd09qWsKOwvGG1JV6eeWG1wY5U/Re0HvaHDF9rQD00KbNv1kUsjS3xByqRd3
         U6KbkIA6P100LPNRADFz2eNzebiq7KenInWUYg33iT8xI2J2+H9ivsvnqCjnpf58F72p
         GhQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6oD9079M7osGawowiIAwkYPnu00uG0rPQ5TmBcHrqM4=;
        b=PipMAHBEVuDDkZhgiknF2Hjis9Hf0KgnVVJD+qpbt5+qv9qLwd1ufnUzAzQFDt0olg
         DU0zKLpLP9D2bqgpXDAl+OiEDX0E1+OZWO54slAdW6+gKKabolA1InrfbCikjvNN+28B
         81f0yGFm4yTdOAXM12iVOP8qHqiRJ2+M/q5zhHmCaZziEa+TI2kusMGN2YSAjCMiMY+v
         9abeAALcSZrTKSLQI6p/fRg/cmBhVBgHxDd6o4xjrt/CQmHZWCrjU+MhjZqUFJHWA6yY
         H0nbpvedngHw9LUtmUWDMSeonS5XL9MEa7qUWC+U8R/whFcJHODYOXwg7PKugW01CINB
         mGTA==
X-Gm-Message-State: AOAM530ey2W1LF/twjoACZ7M5neBuGT0BSBStFapZ2XYrD597fyBXxeX
        jqr5bDNPv3gYCdQIl3IixFHqSgPf9YswzEiq908=
X-Google-Smtp-Source: ABdhPJxCc7DsuAiOFhvIqnM/lw6T9KWiVO0FE27lMPe130reXRQ5QFI438u4q7tJJBerUPQQfvQqLJ9AWvurprvxbLU=
X-Received: by 2002:a17:906:8258:: with SMTP id f24mr46478335ejx.551.1600662161236;
 Sun, 20 Sep 2020 21:22:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200828065609.GA2105118@coredump.intra.peff.net>
 <441bd08b-ca7d-5977-a455-c4c2a4bd4bc9@gmail.com> <a9b7cac1-1993-dbf9-a048-a81c2c39a906@gmail.com>
In-Reply-To: <a9b7cac1-1993-dbf9-a048-a81c2c39a906@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 21 Sep 2020 06:22:29 +0200
Message-ID: <CAP8UFD05qPn6kGRTQGhwABvZbfoH3xcK3VpFo7d5koj9d7mUsg@mail.gmail.com>
Subject: Re: Git in Outreachy?
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 20, 2020 at 6:31 PM Kaartic Sivaraam
<kaartic.sivaraam@gmail.com> wrote:
>
> On 07-09-2020 00:26, Kaartic Sivaraam wrote:>
> >> I would appreciate help to find project ideas though. Are there still
> >> scripts that are worth converting to C (excluding git-bisect.sh and
> >> git-submodule.sh that are still worked on)?
> >
> > I think Dscho's e-mail linked below gives a nice overview of the various
> > scripts and their likely status as of Jan2020:
> >
> > https://lore.kernel.org/git/nycvar.QRO.7.76.6.2001301154170.46@tvgsbejvaqbjf.bet/
> >
> > I'm guessing only the status of submodule has changed as it's being
> > worked on now.
>
> After giving it a second thought, I believe I should take back my word
> about the git-submodule status changing. There still seems to be some
> work left for it.

Yeah, there is some work left, but Shourya said he was interested in
continuing to work on it.

> To be clear,
>
> - there's 'add', whose conversion is currently stalled [1]

Yeah, but it hasn't been stalled for a long time, and sometimes it
takes time after the GSoC or Outreachy period for former GSoC students
or Outreachy interns to resume their work.

> - there's 'update', which still has a decent amount of code [2]
>   in the shell script.
> - we still have to complete the conversion completely converting
>   moving the rest of the bits from `git-submodule.sh` to C which is
>   mostly just the option parsing. This might be more trickier than
>   it sounds as we would've to ensure the we don't accidentally
>   change behaviour of the options when moving the option parsing to C.
>
>   There's also an e-mail from Junio which is relevant [3]
>
> I'm not sure if this would be enough for a complete project on it's own.
> I'm also not sure whether 'add' would get converted in the meantime. In
> any case, I believe we could add a few other small refactoring projects
> to make up for the rest of the period. For instance,
>
> - Replace more instances of `the_index` and `the_repository`
>   (https://github.com/gitgitgadget/git/issues/379)
>
> - Turn the `fetch_if_missing` global into a field of `struct repository`
>   (https://github.com/gitgitgadget/git/issues/251)
>
> - Possibly others from #leftoverbits
>
> Thoughts?

Yeah, without 'add' we would have enough related issues for another
project. I would prefer though that we wait for at least 3 months
without any progress before suggesting them as a project. That's what
we usually do and I think it's the right thing to do.
