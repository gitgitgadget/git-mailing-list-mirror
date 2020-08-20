Return-Path: <SRS0=wu5b=B6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7314AC433DF
	for <git@archiver.kernel.org>; Thu, 20 Aug 2020 12:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4787720658
	for <git@archiver.kernel.org>; Thu, 20 Aug 2020 12:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=globallogic.com header.i=@globallogic.com header.b="H1mdMefI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbgHTM7k (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Aug 2020 08:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729070AbgHTM7O (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Aug 2020 08:59:14 -0400
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5683C061385
        for <git@vger.kernel.org>; Thu, 20 Aug 2020 05:59:13 -0700 (PDT)
Received: by mail-vk1-xa29.google.com with SMTP id x187so390094vkc.1
        for <git@vger.kernel.org>; Thu, 20 Aug 2020 05:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=globallogic.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wtVrqITmG449Dahn0qIGN+DdLW4SNvle4IeOLYRe4Cg=;
        b=H1mdMefIiSOSPSPY14/iJ6I5Fzx+TeaCtKwYjpGLfw5z6Wp/2kqpZbQK2WCmEiIm8A
         xPdH+zih7yK7LKhOjpu2C9F/9z/MsL4EkQTOBjh7tYMRpQbWgHDRYMwuNuPN9BvJCWmJ
         lHc/UZtFpsDsVeb49a3QYRY0U5dF36Sm9slDvtARCUkjzTgI9Ac5Xdm+WNsMkchXR4st
         Pbpq3Lfk4wfOOnaK/46tDr2hLvoLvwBbMZYuJs9f10gWC2d1/mRX3wWmjh/MZmlnnXuB
         ceeXHb7vumpgyGpylz0IH+SLU4U3pQvubQL+jUfh6YNw3kmB6ulU35jTFMGpQdfsq+CN
         PPnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wtVrqITmG449Dahn0qIGN+DdLW4SNvle4IeOLYRe4Cg=;
        b=IDNiTJRLiXWA4HDaIE+u1oIzpGu8+BKFaTSvLExZotIUnnXs5sPZV/UjXjT/ogjRRQ
         zRid2ydWG0RiwvdTG+WKPZVD3nF2/0gg4eCWtjeD8RSLrAe71qrZe92EOI8jSpqUQi2w
         KUh8VqckunuP0RYpaDopDU1GLjCc+LVrFe/0lYDikJnhGoiQ6VBdd2YbeYVo49Cp1dxz
         auEHONSatd8SMQ+xFpAwEAqZLZFL99Gwe8/KoxfY3++bggYCmGzX1nnqUlUZGzwjNp9C
         43CdchZ1Y/ghDpIOyRiQGoNSWwMQa7aM100T9rK6z/sp+qkLkWL1m9uCgwvI1wyayvTt
         BdCA==
X-Gm-Message-State: AOAM530uLmDE9TFGqCAAh1xY2XBmsvLOz9/gqZ6zTJ41TWS3Ks37dy2t
        AZ420Y7mxNBgbr4Rx7OzfDZSenI+95hn7BBn31BkYGXNa2fgXg==
X-Google-Smtp-Source: ABdhPJzpeyTFP7m2MFbnzrPfxTxsvI7Pu2nQfZX9UrseGEoWLvHjeKbzwZp8lPhLWm0hYSoOMcRSnMXACPh+7vSeznY=
X-Received: by 2002:a1f:6282:: with SMTP id w124mr1331029vkb.46.1597928352042;
 Thu, 20 Aug 2020 05:59:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAFvH=vsWyX79j-9pyC5gpxGu8rRxYyrXwywHjh-_T2opHjT8Xg@mail.gmail.com>
 <CAPig+cSCd_8YB90sypTe1bHMQhPgo+Tr2PHNucdqfCpEe+Dosg@mail.gmail.com>
In-Reply-To: <CAPig+cSCd_8YB90sypTe1bHMQhPgo+Tr2PHNucdqfCpEe+Dosg@mail.gmail.com>
From:   Sergii Shkarnikov <sergii.shkarnikov@globallogic.com>
Date:   Thu, 20 Aug 2020 15:59:00 +0300
Message-ID: <CAFvH=vuFg+kM2GkBaE7jRqHWWcTcZMrs36KLS+-VTy8tgNZXJw@mail.gmail.com>
Subject: Re: Possible bug with git restore
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is a script to reproduce the issue that works for me in Git Bash:

=============================================
#!/bin/bash

#create repo with corresponding structure
mkdir restore_bug_test
cd restore_bug_test
mkdir incl
mkdir src
touch incl/test_file.hpp
touch src/test_file.cpp
git init
git add .
git commit -m"initial"

#add a couple of commits
echo "1" >> incl/test_file.hpp
echo "1" >> src/test_file.cpp
git commit -am"1"
echo "2" >> incl/test_file.hpp
echo "2" >> src/test_file.cpp
git commit -am"2"

#reproduce bug
git restore -s HEAD~ -- *test_file.*
git status
===============================================

Haven't checked filenames explicitly, but they haven't been changed manually.
And there are no explicit case changes in the attached script.

On Sat, Aug 15, 2020 at 1:42 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Wed, Aug 12, 2020 at 2:51 PM Sergii Shkarnikov
> <sergii.shkarnikov@globallogic.com> wrote:
> >     I tried to restore a couple of files from an earlier commit
> > running the restore command with a wildcard:
> >
> >     git restore -s HEAD~ -- */filename.*
> >
> >     In my work tree those are .cpp and .hpp files stored in different folders.
> >     Both files were deleted (and got (delete) status).
> >     Running this command without wildcards for each file separately
> > works as expected.
>
> Thanks for the report. Can you provide a complete recipe in the form
> of shell command to make this happen so others can reproduce the
> behavior? Doing so will help track down the issue. Also, since this is
> Windows, do the cases of the filenames in the referenced commit match
> the cases actually on the filesystem (and have the cases changed
> between commits)?
