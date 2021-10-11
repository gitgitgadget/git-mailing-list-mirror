Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6085DC433F5
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 13:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C0EE60C41
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 13:13:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236838AbhJKNP5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Oct 2021 09:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbhJKNP4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Oct 2021 09:15:56 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C421C061570
        for <git@vger.kernel.org>; Mon, 11 Oct 2021 06:13:56 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id d131so38984167ybd.5
        for <git@vger.kernel.org>; Mon, 11 Oct 2021 06:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9IDt91eUcYcvyJVzQAeMM1FfzBIdKizN033Ww6vYIiY=;
        b=MkEMz8h4k5FfpvFsNeZV5gwuFR1VFyiQkLHXUKM3b9iG6OyBE8QHLHaz6c2hi6JVTD
         ndfpkJE3CWkIYCETo8bpqexjBckvckJrX0HskpMh+UGB1z69BRiDK+/up/uoWWv+TT1M
         94KCWdd44uN/VbZMQnRJQ+06ZowNhBIPlkmQ5Iv43we9SGC95oPZh+lU2KZS/JHMglYN
         fV0k3qbmmiW6bNoyfWMJIUmeKw/rh0ib+ySrDVIURjWjwU0imahEtCOXJ90AwkfW2L1n
         yRhWZZsxIrY/Y92vyIu9e2ua8DYWTOGbO344bDk+1EEY7IIyzwng1OevQ+NAe6BIYAnU
         fmLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9IDt91eUcYcvyJVzQAeMM1FfzBIdKizN033Ww6vYIiY=;
        b=C8brfxc2DTgiLuNXRmJYiuB5IpTuJcs/q/11DVwQHnnb0ntQWkfG18GFm5rfzRK6xR
         No8TkTdIRjUEAPerHH88xZBNRYdI8G39PtF7yTJQU1le2h6/5owYuXctX+v66jlS7z8m
         22ficnHdnaST2EN2GmVpeKt+oBqWQOYG0c0qBR4dBTOtI1u5uJZ42Az6I1wIeK1mDv7r
         e90lbzcn6KNyH+egyH31djmmoZIG1GknrDvFlBLfgs9CEGN0r9vNL3tm1/9IsbTMG+YF
         UF74jVxc3c2qgNZm4qW4vuFmo8lVIxsd5KZ1vvMdk+11eGD43otra8CgeamJ+cyPt26y
         zyHw==
X-Gm-Message-State: AOAM530VPQvuOAEO4k0MBryQMKOY+0QfdChCJJvAaO6McE2iLRj5HXp4
        /glNsbxA76cOEtIvGC1OACCJsWc0tsG7evog8QL4q8eY+W0=
X-Google-Smtp-Source: ABdhPJxI0kuXfE/NBmrVfqhUFAYSca5odt0bAWoMuuiZjWhrlPrVphcsxWhSIaW7zuN1lc1YY2V777AiYdhEpHEfVsI=
X-Received: by 2002:a25:2205:: with SMTP id i5mr21611038ybi.203.1633958035330;
 Mon, 11 Oct 2021 06:13:55 -0700 (PDT)
MIME-Version: 1.0
References: <e257c62e-edff-f559-95e7-374b623a3f61@zoho.com>
 <CAP8UFD1_2g84epP+qjP2QW2g2bzdWcepPE60rY2vdKpTZFdEDg@mail.gmail.com>
 <a12adb98-d8c1-cd36-1760-343360a9ba85@zoho.com> <afd8890e-0042-8fc6-523d-f69aa6ed7af3@zoho.com>
In-Reply-To: <afd8890e-0042-8fc6-523d-f69aa6ed7af3@zoho.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 11 Oct 2021 15:13:44 +0200
Message-ID: <CAP8UFD0TBOkNU2g_OqpMiQyopBfae95nBwJQJ8F04+C1FcBRYQ@mail.gmail.com>
Subject: Re: I just want the revision
To:     ToddAndMargo <ToddAndMargo@zoho.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 11, 2021 at 12:24 PM ToddAndMargo <ToddAndMargo@zoho.com> wrote:
>
> On 10/11/21 03:09, ToddAndMargo wrote:
> > On 10/11/21 02:45, Christian Couder wrote:
> >> Hi,
> >>
> >> On Mon, Oct 11, 2021 at 4:57 AM ToddAndMargo <ToddAndMargo@zoho.com>
> >> wrote:
> >>>
> >>> Hi All,
> >>>
> >>> I am trying to write a script to tell me the latest revision
> >>> showing on
> >>>
> >>> https://gitlab.freedesktop.org/spice/win32/spice-nsis/-/tree/master
> >>>
> >>> which is 'virtio-win: rebase on 0.164", but I can only see this
> >>> from a web browser, as the page is dynamic.
> >>>
> >>> I do have access to the git link on that page:
> >>>
> >>> https://gitlab.freedesktop.org/spice/win32/spice-nsis.git
> >>>
> >>> Does git (or some other) have a way of telling me
> >>> JUST the revision without having to download the turkey?
> >>
> >> If you just want the commit ID, you can use for example:
> >>
> >> $ git ls-remote
> >> https://gitlab.freedesktop.org/spice/win32/spice-nsis.git
> >> refs/heads/master
> >> f6ad44f35f5caeec51b7002169977272d85701a3        refs/heads/master
> >>
> >>> If I could get something that contained
> >>>          virtio-win: rebase on 0.164
> >>> I could dig out the revision
> >>
> >> You might also want to take a look at the GitLab API docs, for example:
> >>
> >> https://docs.gitlab.com/ee/api/commits.html
> >>
> >> Best,
> >> Christian.
> >>
> >
> > Hi Christian,
> >
> > I do not mean to be dense, but how do I get
> > "virtio-win: rebase on 0.164" out of:
> > " f6ad44f35f5caeec51b7002169977272d85701a3  refs/heads/master"?
> >
> > Perplexed,
> > -T
>
>
> Found something that worked:
>
> $ curl --silent
> 'https://gitlab.freedesktop.org/spice/win32/spice-nsis/-/commits/master'
> | grep  rebase
>
> <a class="commit-row-message item-title js-onboarding-commit-item "
> href="/spice/win32/spice-nsis/-/commit/f6ad44f35f5caeec51b7002169977272d85701a3">virtio-win:
> rebase on 0.164</a>
>
> <a class="commit-row-message item-title js-onboarding-commit-item "
> href="/spice/win32/spice-nsis/-/commit/d6836f79ba8deeef5b7719fd94cc208b81eb70df">virtio-win:
> rebase on 0.164</a>

If I needed more information than just the commit ID, I would use the
GitLab API, especially:

https://docs.gitlab.com/ee/api/commits.html#get-a-single-commit

So you might want to customize this example command:

$ curl --header "PRIVATE-TOKEN: <your_access_token>"
"https://gitlab.example.com/api/v4/projects/5/repository/commits/master"
