Return-Path: <SRS0=d/2q=6J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70A94C54FCB
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 12:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B91220714
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 12:09:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQaofgci"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbgDYMJ0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Apr 2020 08:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbgDYMJ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Apr 2020 08:09:26 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2E6C09B04B
        for <git@vger.kernel.org>; Sat, 25 Apr 2020 05:09:24 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id c23so9698427qtp.11
        for <git@vger.kernel.org>; Sat, 25 Apr 2020 05:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uz5H2qTb662LEYJEaZzWLmQBIKUfZYn2trZ+J0erJZo=;
        b=nQaofgciOVU6h14W0aPES8O6biIq6yeUpBpUTlQ9rjAsvpvA8ubu2evZzq3EPSMWSY
         1WE2w0/bAxP5m4VI5OsrqPBYiItfzauxMUSFWbxPM2IMiokQSJpGVHt5/f4Yvg3hQgG7
         33UfYm+w87O0VFlgb2o1HaYLGXt7ZqlXv6tjnmzzy4MRkZskkERHlHF7hdj6w/C43TTE
         qWqhHhaqmMs6Y6bjhs4uNRhdt7dFKgzLYOU1UX/ZVT/gjIzbLCjksOHeCyVcIRJr2hb1
         0/FDYVos9/FE4lqobTAEI4mTu0DuNKqKCA5GF1yDoPus8Z+65Tnvl9CxjcTcsiL/wRbN
         P+HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uz5H2qTb662LEYJEaZzWLmQBIKUfZYn2trZ+J0erJZo=;
        b=iKKfNlL+myKv2DromfJTJb6ck6lfEbX1XhLljVPz2zEAXOSindPFYjfJ9omjphMayY
         FgjwyiH86NkiNYaK7McuAjr+hSCNuk48jBs7a77ErVe1Zxx7b8K6cnWF/CnfJBy5gvMi
         3ACmwjqA0h5+eXnEAJ3Lk+eDXB2vCMCcGo0iCkS5pl+AHCqi7xhk4XuL/jxdwF2z41mU
         Tc/aTaqsuG/zE6631pVEYI4nsj5jvwXnZY+5E+Ii4d2DkSDooRHUVad4f6ZE6C0Y1x7B
         ogCmMuXCjPZBURKoBH80X5q8qAnyVf5VAG7mtYWVb05fatNxLBUE30aNQAjWjxpSJSX+
         JgSQ==
X-Gm-Message-State: AGi0PubkP8nHPrKY23+RC8ttvhPYRm7KrbOAwfnZhNbeQEnFYTsVSjZB
        /nvMpA7cFMAjL2NoNz39C0vn/KCiHMtWG2ldISA=
X-Google-Smtp-Source: APiQypKF/SiwdDRzVznMQng/mo6MtNCbppueDAEbVAAHyXBWiibf6j+RhNHAzkslpiwiQSsYo1mE2JPBi55MKuzWTIY=
X-Received: by 2002:ac8:19fd:: with SMTP id s58mr14368717qtk.222.1587816563928;
 Sat, 25 Apr 2020 05:09:23 -0700 (PDT)
MIME-Version: 1.0
References: <pull.614.git.1587700897.gitgitgadget@gmail.com>
 <d6c630028bf43ea74ef1ac3b60d49aea252b3f4b.1587700897.git.gitgitgadget@gmail.com>
 <3fd87ba7-654c-ff5e-2951-7bbbe3c5d119@iee.email> <CAKiG+9V9N5zV=dxZwVmAaEFYQbswnSNLVqKMx5ti=zaPatZdkg@mail.gmail.com>
 <cb5f658b-f63d-1a67-fd10-be7762930612@iee.email>
In-Reply-To: <cb5f658b-f63d-1a67-fd10-be7762930612@iee.email>
From:   Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Date:   Sat, 25 Apr 2020 17:39:12 +0530
Message-ID: <CAKiG+9WCzSa4DGqh+5zxkyvMNp=QV5=pyw3cZXFo3vY8ZWqW6A@mail.gmail.com>
Subject: Re: [PATCH 6/8] cmake: support for building git on windows with mingw
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philip,

On Sat, Apr 25, 2020 at 5:07 PM Philip Oakley <philipoakley@iee.email> wrote:
>
> Hi Sibi,
>
> On 24/04/2020 21:29, Sibi Siddharthan wrote:
> > Hi Philip,
> >
> > On Fri, Apr 24, 2020 at 11:09 PM Philip Oakley <philipoakley@iee.email> wrote:
> >> Hi Sibi,
> >>
> >> On 24/04/2020 05:01, Sibi Siddharthan via GitGitGadget wrote:
> >>> From: Sibi Siddharthan <sibisiddharthan.github@gmail.com>
> >>>
> >>> This patch facilitates building git on Windows with CMake using MinGW
> >>>
> >>> NOTE: The funtions unsetenv and hstrerror are not checked in Windows
> >>> builds.
> >>> Reasons
> >>> NO_UNSETENV is not compatible with Windows builds.
> >>> lines 262-264 compat/mingw.h
> >>>
> >>> compat/mingw.h(line 25) provides a definition of hstrerror which
> >>> conflicts with the definition provided in
> >>> git-compat-util.h(lines 733-736).
> >>>
> >>> To use CMake on Windows with MinGW do this:
> >>> cmake `relative-path-to-srcdir` -G "MinGW Makefiles"
> >>>
> >>> Signed-off-by: Sibi Siddharthan <sibisiddharthan.github@gmail.com>
> >>> ---
> >>>  CMakeLists.txt | 120 +++++++++++++++++++++++++++++++++++++++----------
> >>>  1 file changed, 97 insertions(+), 23 deletions(-)
> >>>
> >>> diff --git a/CMakeLists.txt b/CMakeLists.txt
> >>> index 29a23eb11f7..d9eb1060390 100644
> >>> [snip..]
> >>>  find_program(SH_EXE sh)
> >>> +if(NOT SH_EXE)
> >>> +     message(FATAL_ERROR "sh interpreter was not found in your path, please install one. On Windows you can get it from here https://gitforwindows.org/")
> >> Either the error message or the web page it points to need to coordinate
> >> on the 'sh interpreter' reference to help the script kiddies follow the
> >> thread. At the moment there is no 'interp..' on the gitforwindows web
> >> page. Would someone attempting to use cmake need to use the Download or
> >> the Contribute buttons, or some other route to acquire the missing SH_EXE?
> >>
> > On Windows, if you are using Git Bash, then you don't have a problem.
> > This message was for people trying to Git on Windows without a bash shell.
> >
> > I can rephrase the message saying
> > "On Windows go to https://gitforwindows.org/ and download the Git
> > installer which ships with a sh interpreter(bash)."
> >
> > Would you suggest something else?
>
> Filling the message out a little, I'm thinking of:
>
> "sh: shell interpreter was not found in your path, please install one.
> On Windows, you can get it as part of 'Git for Windows' install at
> https://gitforwindows.org/"
>
> The second 'install' could be dropped, but may be needed to fully
> qualify the instructions for some readers.
>
> The key feature I was checking was the clarity of the 'install' action,
> as opposed to the way sh is integrated within Git for Windows (which is
> a whole new topic of conversation for some users!)

Sure, We can incorporate this message.

> >
> >> (this is also a context line in the next patch)
> >>
> [snip..]
>
> --
> Philip

Thank You,
Sibi Siddharthan
