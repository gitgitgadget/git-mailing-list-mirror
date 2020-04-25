Return-Path: <SRS0=d/2q=6J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D48C2BA19
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 04:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F24E2076C
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 04:10:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f2ChOPi4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbgDYEKI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Apr 2020 00:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726034AbgDYEKH (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 25 Apr 2020 00:10:07 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D192C09B049
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 21:10:07 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id l78so12479875qke.7
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 21:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=unEwGZNw8Znm88iJoG34i/UbT616cFqK9b8MWNleCTE=;
        b=f2ChOPi4SR8nu711ivY8lxxA4XMGnZZXzy4m4noa9NTf2LW2ncM2WvvQV9LIbBMHXk
         mqPabdtvtZEwuB04QD6y5Sy9J4BD+p/nmUYTd/GYF6luFJU310oN2ljDOg8CtgsBWznd
         bt7Y9EXZr9lqS+vvJMTiDzhhfURKQFYlZI2Tyx6AcdnMV+sF6ZLLrDJINH706g3OczYw
         qxR3GPXLaShn8hgiHG5cF4qznm3Z3JtBXWx3m8D9vPe6kdLoZnQpNgkxzlYAcMn8shVo
         gyrFO1QGc9d6DhLx+XagdrGjVhh7NRyxaerdz4d2fdFVmHBwz+/MQzzTqmxGYh9R8hF1
         wL+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=unEwGZNw8Znm88iJoG34i/UbT616cFqK9b8MWNleCTE=;
        b=LZfAcSIwnRgr5urn7ihUgDeb/9U9/cq59AAxIwDSIM3MCBv8wHb7293TEM9TPSis42
         d5CqVvV0i7v13k2vhUmMekwHURqu+Xp4rBhlIANQKpXoSwSyRm59xvxl5U3iA4GqSFcZ
         mkxRgW+IKob0fihDMLCiN3RQPcbRMZTcwYCsjhSuS8wWo3esqWVWpvDVJxpqNdr93+za
         wmsx6WwcLEbiIQTCPUOYeDMKzhZICbKTWqTVoNo5mJ4hF2cUSQM2VpV9TXYJath2bTgx
         sIvFUYMnnYvTFWk6pcBRHkunqXsAdkbC/8GROqy4tBwssdHvf2SdF7CFsOKip4UBtqou
         1iHw==
X-Gm-Message-State: AGi0PubHFVAR+/7NycGmoiEwTeZ/QcXdvh5I7VQO8VYi7PY2+ZOGUkus
        3SEQiafCMugOzgs/oOez7HyCJjo7IC/7ZYFjFMh/tw==
X-Google-Smtp-Source: APiQypJPiyGytfahprQd8FMbRB6rfBBKpwvXGyvwgjtrQiTRyxIp/AJfEi5HE8dVL1fFPWqw3ivBHEvh0TVw68VWExY=
X-Received: by 2002:a37:7846:: with SMTP id t67mr11737808qkc.77.1587787806702;
 Fri, 24 Apr 2020 21:10:06 -0700 (PDT)
MIME-Version: 1.0
References: <pull.614.git.1587700897.gitgitgadget@gmail.com>
 <xmqqv9lod85m.fsf@gitster.c.googlers.com> <CAKiG+9V_nZUXf2a689vZ54rG+xTCFMGcJe_7Av-khaxxuijERg@mail.gmail.com>
 <xmqq8sikblv2.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq8sikblv2.fsf@gitster.c.googlers.com>
From:   Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Date:   Sat, 25 Apr 2020 09:39:55 +0530
Message-ID: <CAKiG+9Xtof8Hj3npsS-M0SnT_dcjtHjP_+avWB4oOHkaMdnSbw@mail.gmail.com>
Subject: Re: [PATCH 0/8] CMake build system for git
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 25, 2020 at 3:13 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Sibi Siddharthan <sibisiddharthan.github@gmail.com> writes:
>
> > The goal would be to maintain a CMake build for Git keeping it in sync
> > with the Makefile.
> > The Makefile is not going to be replaced at all. The CMake script for
> > now only supports Linux and Windows.
> > It does not support BSD, Solaris and others, whereas the Makefile does
> > support them.
>
> So you are doing (1).  I already said that I feel that engineering
> burden to divert resources for CMake support would be unacceptably
> high.
>
> Whenever any of our developers need to add source files, Makefile
> configuration knobs that people can add to config.mak, etc., you are
> forcing them to figure out where in the CMakefile to add them or
> devise ways to allow builders who do not use config.mak (because
> they use CMake) to do similar tweaks.
>

Adding source files to the CMakefile is going to just as long as
adding it to the Makefile,
anyone can figure this out and this is not going to take much time at all.

As for the configuration knobs I agree that adding the same to CMake
is going to a bit longer.
But anyone who is hacking Git is going to do it with the Makefile or
(if accepted)CMake script, but not both while hacking.
So they will continue to make progress with the system they feel comfortable in.
They will only run into an issue when they try for a PR. Currently the
CMake script is only used for generating the visual studio solution.
We can add a (continue-on-error) to vs-build job to make this process
less of a hindrance.
If people take the time to hack Git, figuring out how to do the
configuration knobs in the CMake script is not going to that much take
time
compared to the time they spend making Git better.


> Any patch that is acceptable to the current project would become
> unacceptable because they lack updates to CMake part, but I suspect
> we do not have enough people who are so much devoted to give a good
> review if updates to CMake part are added.  And it is unclear why it
> would be beneficial to slow our existing developers down by forcing
> them to become familiar with CMake.
>
> So..., I am not just "still not convinced", but I am even more
> convinced that we do not want this series, after thinking about it
> longer.
>
> Thanks.
>

Thank You,
Sibi Siddharthan
