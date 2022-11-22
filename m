Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25486C4332F
	for <git@archiver.kernel.org>; Tue, 22 Nov 2022 13:30:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbiKVNaP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Nov 2022 08:30:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232140AbiKVNaN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2022 08:30:13 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D156164A08
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 05:30:11 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id z26so14377669pff.1
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 05:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=enObh9mjNRVczSRwi9Dqf3SAPNmK54INwN38i8TO9Ok=;
        b=hpnp+fy4OxbOAF7UZYYg77rLjFWM6RHW5icZ1ML/LYFP0yPYHUCVHpgVNRKXyBwcBK
         aNjX67bXzVhV6PnCRGhH86KaSP4eL0Odb+pXkY9GMp4mAmVYQLPOA27acvWplianc5uV
         hSFitYn32pcsJbxQHgEXEZj5ea/Opla99vQVk4Q2eNsb7TuS1hDIbykErSuxMWZo88zc
         esA8CeA1jxghFe54LZghqYMF8xesqsuwuG0bEmabPNu96JTCgL5O+hLWAhaenw6tZgVU
         6p7Sj1RStZq19WO6flHx1iyZtPQRdqfV2snk7tRubVs5wtElAem+n+R1YTUrA4lHGo5r
         Adxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=enObh9mjNRVczSRwi9Dqf3SAPNmK54INwN38i8TO9Ok=;
        b=OWwVk7ilkQJXkj1XRfSp+q8zFs8UVHeMDgCthbZBIM6+V+XvooTsVhlehqTCvRchCo
         AX22jLUOtCkqZpRDyMw1HyHNS5T/mcHH4vT4mtks6MARs+tbAHjHJu7XtgOcwqg+9Rpp
         /F6fTG5JUP5n0I5WzsCqsDOQDZzqXPnMmzu1gHcXmmChJkfJiin5XEMf/LLSuVLHj5IP
         iALQCYqd0u8zbmq1z9bPlMdU30DRitYYrQcDWQwgxAXgC2GKc+lK5vVT4cr2Pn0H7bhu
         I7eH9zU2gvzZtZI3ejMSOJasfx0TpXA5EuzvzD3A60W7EaQF+uoYIDEtji9tGM5MRbms
         E1gg==
X-Gm-Message-State: ANoB5pnkgYDpqMHZzlriC563oI7IK0W1F0NdqIN+drwxmBq/GHqQebZE
        IxOeo9YZxI5aNbylX5/8tZ6JF/SYCoIwe/3i1xg=
X-Google-Smtp-Source: AA0mqf6aW71KKOlbACvMTbgF+mqHRijw3kG6KyPOtbsifZu/cUep/TfVgV4RA0Hn6f1ki2KZR/0Ut2Vllw7O6LdqY8o=
X-Received: by 2002:a63:1f08:0:b0:43c:e3c8:8c30 with SMTP id
 f8-20020a631f08000000b0043ce3c88c30mr3707634pgf.579.1669123811251; Tue, 22
 Nov 2022 05:30:11 -0800 (PST)
MIME-Version: 1.0
References: <pull.1423.v2.git.1668907644.gitgitgadget@gmail.com>
 <pull.1423.v3.git.1669033620.gitgitgadget@gmail.com> <ccfea26de333ac5a08a5df4c9b790811067bd437.1669033620.git.gitgitgadget@gmail.com>
 <Y3vFpNbWswu/8gjb@coredump.intra.peff.net>
In-Reply-To: <Y3vFpNbWswu/8gjb@coredump.intra.peff.net>
From:   Yoichi Nakayama <yoichi.nakayama@gmail.com>
Date:   Tue, 22 Nov 2022 22:29:59 +0900
Message-ID: <CAF5D8-vjSz__06-Oy=GbByVL=_sqU5SXkjt3uLEjQKkVyBEgEA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] git-jump: add an optional argument '--stdout'
To:     Jeff King <peff@peff.net>
Cc:     Yoichi Nakayama via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 22, 2022 at 3:38 AM Jeff King <peff@peff.net> wrote:
> It's also unfortunate that we have to repeat the ugly "type" check
> above, which also happens again later, after we make the temp file. I
> see why you did it this way; the stdout code path does not want to make
> the tempfile. But the code before your patch was silly to do it this
> way; we should always have been checking the parameters before making a
> tempfile.
>
> I was also puzzled why the stdout mode redirects stderr from the mode
> function. Wouldn't the user want to see any errors?
>
> So together, it might look something like this (instead of, rather than
> on top of your patch):

Thanks. I've applied it.

I was throwing away stderr because Emacs' M-x grep inserted both stdout
and stderr into the output destination, and a perl warning was issued.
However, the warning itself is meaningful, and I thought it would be very bad
not to know the reason when an error occurred, so I came to the conclusion
that stderr should be left as is.
-- 
Yoichi NAKAYAMA
