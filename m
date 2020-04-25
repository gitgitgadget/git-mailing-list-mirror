Return-Path: <SRS0=d/2q=6J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9181FC2BA19
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 03:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65F4020704
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 03:57:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZmKhmDWN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbgDYD5W (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 23:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726038AbgDYD5W (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 24 Apr 2020 23:57:22 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78817C09B049
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 20:57:20 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id n143so12472201qkn.8
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 20:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B1qah8UJfwBc5xgoBRhtWu8I3NXhJ/dNeZS+DruT/3E=;
        b=ZmKhmDWNsyFdRBCuVxx6KwNS5ywRhSrbolWOTxjqpEJrFSDN71a/+xvFkOCrK3C7cK
         U4PEmC5Nus4TyIeAAZytNicoT0lK7O/73zTFYpToZDrYbO7ZnJN6V6bh3HgI4A3/kr/n
         y0WUFUwnPPbGq2VO252YPcuhHXryQVLQ/9kQ63MggvVKePPhfGprSJgUb0xK/ZkMQJIt
         SzF57g4NHoP7zqDyi9G6HFQkvmhPff5a9VKb5qUk67q/VwpWsTKO7fmZxKQwBy7KxmkL
         /kpZu4p4BnGTs35PFYcJlDzwoT7Dfd7bbEOBik7lrDZSD6tZG5Gh9KUB1K/LdYJj8XXz
         IGRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B1qah8UJfwBc5xgoBRhtWu8I3NXhJ/dNeZS+DruT/3E=;
        b=kvEGxK5eO5qqADRf68M1zpKu3Bt0uUnzVneOWCqeln2j5WVbTS4GXYrUikh9BUzo7m
         R9ZJDaskd2n+Ljf06C2tyolqdsEzm1yDo5UdKKPthcxZ19dvMfpE6+Ol0qnVRFpgsgJ0
         1AgVU3p0SwgpxnPTNmlbEe4lGBQcRm/qLfRv+bu4xsLnKpbbrdgVaIOD4Qm6Bx7BLIpC
         XQF6DVfsB0oXmKKmtqxU3bcXbd0G3oZfVwaFlLp1hpDhRGB5d7rHaVRs3n8kzD+1+Kzc
         mrcPAZtdKNEomgIxJCw676IHLSvUe9XK7te+iLx0nHvxkzbAnTIU3PRvYlxS+SyPCS74
         LNLQ==
X-Gm-Message-State: AGi0PuY+MVIjfcLA5Xo8vW/8c3RbfSrJ0dq5D7wzlGNJvCIn/PY+NZUn
        tKeejd8VGmEtfXZiHR9NvnBGeto0utgnoZO2W5ZBXw==
X-Google-Smtp-Source: APiQypIJpe5aX6dmL7M7jl6q1REv+zK91+lMHuO5/ZcsJPZy7Yl2EMUiYWiHRTcHEAW8g0Cj1DPXMhVJlVurfPZ2TCc=
X-Received: by 2002:ae9:dc46:: with SMTP id q67mr12262479qkf.431.1587787039660;
 Fri, 24 Apr 2020 20:57:19 -0700 (PDT)
MIME-Version: 1.0
References: <pull.614.git.1587700897.gitgitgadget@gmail.com>
 <166b78f71755bb3f9967b32bfe282210c2bb240d.1587700897.git.gitgitgadget@gmail.com>
 <20200424173433.GL1949@danh.dev> <CAKiG+9V=bJNqrHRy8y8cbjkgzrmhOMMz47+8fgfQARAetx4MFQ@mail.gmail.com>
 <20200424230954.GA4071@danh.dev>
In-Reply-To: <20200424230954.GA4071@danh.dev>
From:   Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Date:   Sat, 25 Apr 2020 09:27:08 +0530
Message-ID: <CAKiG+9VELgWxiehkwjREQ6H3L+eTt-Wrs0sPLMAucCLiD3Ooeg@mail.gmail.com>
Subject: Re: [PATCH 5/8] cmake: support for testing git when building out of
 the source tree
To:     Danh Doan <congdanhqx@gmail.com>
Cc:     Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If you are adding a new test script you will have re-configure.
Even in automake you are expected to do this, unless you have a glob
pattern in Makefile.in somewhere.

On Sat, Apr 25, 2020 at 4:39 AM Danh Doan <congdanhqx@gmail.com> wrote:
>
> On 2020-04-25 03:02:49+0530, Sibi Siddharthan <sibisiddharthan.github@gmail.com> wrote:
> > > >  file(GLOB test_scipts "${CMAKE_SOURCE_DIR}/t/t[0-9]*.sh")
> > >
> > > Remember cmake won't be re-run if nothing was changed in CMakeList.txt
> > > If I only change some code, and I decided the change I make should be
> > > tested by a-new-and-independent-test-script.
> > > I need to re-run cmake manually! I don't like it, at all.
> > >
> >
> > No you don't have re-run CMake.
>
> Yes, you have to re-run CMake.
> https://cmake.org/cmake/help/v3.14/command/file.html#glob
>
> > Note
> >
> > We do not recommend using GLOB to collect a list of source files
> > from your source tree. If no CMakeLists.txt file changes when
> > a source is added or removed then the generated build system cannot
> > know when to ask CMake to regenerate. The CONFIGURE_DEPENDS flag may
> > not work reliably on all generators, or if a new generator is added
> > in the future that cannot support it, projects using it will be
> > stuck. Even if CONFIGURE_DEPENDS works reliably, there is still
> > a cost to perform the check on every rebuild.
>
> * Run CMake now.
> * Don't touch anything
> * Create new test-script, let's say t9904-just-for-cmake.sh
>
> * Check if it's run or not, I bet the answer is not
>

The new test script is not added to list of test scripts.
So yes, you will have to re-run CMake.
A reconfigure in CMake is going to take less than 2 seconds, not like
automake which can take as long as the initial configure itself.

> Anyway, Junio said NO, I don't need to be a CMake hater here, anymore.
>
> --
> Danh

Thank You,
Sibi Siddharthan
