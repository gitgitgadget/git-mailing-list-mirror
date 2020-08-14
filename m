Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4EE4C433E1
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 03:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6449E2078D
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 03:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="Ybqi8gt2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgHNDvc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Aug 2020 23:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgHNDvc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Aug 2020 23:51:32 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5933CC061757
        for <git@vger.kernel.org>; Thu, 13 Aug 2020 20:51:31 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id h8so4127555lfp.9
        for <git@vger.kernel.org>; Thu, 13 Aug 2020 20:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DczBQIms0HUTDYu5ZxQ4A1QvJu0P7eLgxbmmx0JoZk8=;
        b=Ybqi8gt2v3nCl9c98o7BBsiHzVzeNx47JGm2r9XjZ8wUkmiAubIFJCM+cWle3ENOGI
         Ci7LCKR6qjG88MfzozdGm4LLXxAgUIR4f6k1LBKLlykhgLFTZXESoqTwRDWLgLYVnFNS
         /6kDNz0T9Nx1FCeZhg+pCmdks9WJQ1aNnlfTZcGEWFRPE9bhg4TQBunMhR6gVhqhmEdI
         Fhna5jhfKOom3USZtNER9t9JczjVKCLIy75zh4jvlbe5qIMQY7nE/YRxOY+CiYr7MivQ
         IESpxtsQw29JLoQUT7qPAGEEoR0Knk681nlovMH/xK3dbkbdeuiwHFZhy5gVXBO3YLxQ
         bBAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DczBQIms0HUTDYu5ZxQ4A1QvJu0P7eLgxbmmx0JoZk8=;
        b=sJ/FhpLV88FIB1OVA/SR919TGLDBdey1HiPvIIhqWLXdaIJrwVK6ZaAYYN+bS4WRzK
         OMPwCUqcTrGMD+buV7CfIEyOdtt1atEZ0UfqzeVbg8zpSjLISiEdXW/nmhjYpEhS97ZN
         miNonbrbz9o1lNs43CgKKMzZmWsfireOMFF69WjWeEfe0BD9yltim54WlztvM/tgcmf8
         Fv7C9bsROtQS31h6MgfH6+WDYOs+aa/7zMhMSOrFLchOPuEbDn2SihHVbRsSPXdyCNQf
         ce3oOFXtXjbq+CipVpJ9RTG7xwordwW6zoRRH1qQkE4iAKXocTpQJJiWS3SibLCU+ZHo
         zKEg==
X-Gm-Message-State: AOAM532yokkkYiXJsr+lCeZGB+S9OMpFgEx7XSmPs9R3JrfFdVAsaYuD
        VT1PqRGwURtLvLJsuha1AbMfIsE8gtIpBVGX+hVInuvBt1g=
X-Google-Smtp-Source: ABdhPJyfKlJVLvLF1cYws6WqXqjP7qh2/hJ/+ZN7VdTKhQNjsfJQOv3ljUHVfRe47n/Np5Rc9a/QBFIHqZ0FMxkVlGU=
X-Received: by 2002:ac2:4a9d:: with SMTP id l29mr281974lfp.23.1597377089251;
 Thu, 13 Aug 2020 20:51:29 -0700 (PDT)
MIME-Version: 1.0
References: <pull.830.git.git.1597374135.gitgitgadget@gmail.com>
In-Reply-To: <pull.830.git.git.1597374135.gitgitgadget@gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Fri, 14 Aug 2020 00:51:18 -0300
Message-ID: <CAHd-oW4quRLLD0qz22facBJPzmn_zVoN-Ze=rP2yvTp=HJONFQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] Extend and add a little more generalization to the
 mem_pool API
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, Elijah

On Fri, Aug 14, 2020 at 12:02 AM Elijah Newren via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> Unfortunately, Matheus' parallel-checkout RFC series (not yet in next or
> seen as far as I can tell) adds a few more mem_pool callers, so this series
> conflicts with his (semantically). I can rebuild mine on top of his, or,
> since his is longer and would probably advance more slowly, it may make
> sense to have his series be based on this one. If so, I'm happy to help him
> update his to depend on this series. Let me know preferences.

Thanks for the heads up. Yeah, let me rebuild my series on top of
yours. From a quick look at your patches, I think it should be quite
straightforward to rebase my changes.
