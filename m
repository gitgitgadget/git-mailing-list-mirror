Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A4EC433ED
	for <git@archiver.kernel.org>; Sat, 24 Apr 2021 21:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E433611ED
	for <git@archiver.kernel.org>; Sat, 24 Apr 2021 21:04:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234040AbhDXVFV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Apr 2021 17:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233958AbhDXVFV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Apr 2021 17:05:21 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01DADC061574
        for <git@vger.kernel.org>; Sat, 24 Apr 2021 14:04:40 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id y136so20957722qkb.1
        for <git@vger.kernel.org>; Sat, 24 Apr 2021 14:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=iV4FwuiRIQr29NvDUtbx1fugKBkEgeAAUPNxVlIQ1Ss=;
        b=jLvq2b3vx8fyISct8WcOfHgSxlg7VZCmXiLqdWAFZo23tqozSoZxZ3uoHs2JEzW0Yh
         wGfYld7u9LS3oby2OESwzeP/g3cBeMJR4aA0mpbssAd3HOP/2c4+yF5o7JAJbfRh/Hjd
         +fTFF0YeKaXHoWzeokt+iAgE7DrpL0/6JzMR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=iV4FwuiRIQr29NvDUtbx1fugKBkEgeAAUPNxVlIQ1Ss=;
        b=UXOx3NWq7dPSPFP2s05B8ApKuerJZ4y/SvucIhlTwoQzHwCfIEgX4rCcKpsnUydLT1
         0p1VYTyuDHodQP7oPNnxqKTsHy/mdp9Eza6V+PP98BbqN2/ah4S4FECsC+tPCZJEuhm9
         JJM4ItnEovYGRrv074y3z3l+4mVEMru0ZjCX6ZQ2iwZ35C83hG2fwC1L9GiXKFxpH9Wm
         uvtL9oc9Oqi5hLhYUf0TQ+q9UsyQCcSjcIkpfVKqDjYDrIvZZrMaRR9wOSZOhGnLRVd0
         k4b9hWpVYWf9+qgwQ4llSGm4w6LiKrSk/CXxTAPNyVe26PUqN2BwutzlfkCafEg7tSAU
         pmlg==
X-Gm-Message-State: AOAM530gRWRDgFP9k0qwtuuoTbWLOgQn8xQFOiaDL+i4Iq7K+sJZihtY
        zLbKFm3XVDyM/eLB+1+RPqlNTWdKF/Ib/C/VbQwLWmUqkEZwlg==
X-Google-Smtp-Source: ABdhPJwbIW3ZZhNVNvYZDfzv28n7cEGYIgdqTMqnLsVrzYP/X8ATVGipPBYeoqM2YXzur8TG2kLj4QYEWlmasnH5hYE=
X-Received: by 2002:a05:620a:21d5:: with SMTP id h21mr10696565qka.314.1619298280034;
 Sat, 24 Apr 2021 14:04:40 -0700 (PDT)
MIME-Version: 1.0
References: <CA+kUOa=juEdBMVr_gyTKjz7PkPt2DZHkXQyzcQmAWCsEHC_ssw@mail.gmail.com>
In-Reply-To: <CA+kUOa=juEdBMVr_gyTKjz7PkPt2DZHkXQyzcQmAWCsEHC_ssw@mail.gmail.com>
From:   Adam Dinwoodie <adam@dinwoodie.org>
Date:   Sat, 24 Apr 2021 22:04:04 +0100
Message-ID: <CA+kUOamj=PfpHsYB4J9=C48zX75aJ9wAf_LgJqFSee+WyJh68A@mail.gmail.com>
Subject: Re: Security vulnerability in Git for Cygwin
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 24 Apr 2021 at 21:32, Adam Dinwoodie <adam@dinwoodie.org> wrote:
> I don't typically announce Cygwin releases of Git on this mailing
> list, but this one's for a security vulnerability, and in particular
> I'd like to catch the (hopefully very small number of) people who use
> Git on Cygwin compiling it themselves.
>
> I've just uploaded version 2.31.1-2 of Git to the Cygwin distribution
> server, and it will be being distributed to the Cygwin mirrors over
> the next few hours.
>
> This update addresses CVE-2021-29468, which would cause Git to
> overwrite arbitrary files with attacker-controlled contents when
> checking out content from a malicious repository, and in particular
> would allow an attacker to overwrite Git hooks to execute arbitrary
> code.
>
> Having discussed with the Git security list, I believe there are very
> few people compiling Git on Cygwin themselves, and therefore agreed to
> release the patched Cygwin build without yet having a patch in the
> main Git source code. However if you do use a version of Git on Cygwin
> that isn't from the official Cygwin distribution servers, I'd strongly
> recommend either not checking out or cloning from any untrusted
> repositories until you've applied at least the functional part of the
> patch I'll be submitting shortly.
>
> I'd like to thank RyotaK (https://github.com/Ry0taK /
> https://twitter.com/ryotkak) for finding and responsibly disclosing
> this vulnerability, and Johannes Schindelin for helping manage the
> response.

One note I failed to put in the original email: there is further
information on this vulnerability in the GitHub Security Advisory at
https://github.com/me-and/Cygwin-Git/security/advisories/GHSA-rmp3-wq55-f557
