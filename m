Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E892C6FA90
	for <git@archiver.kernel.org>; Tue, 27 Sep 2022 18:11:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbiI0SLH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Sep 2022 14:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233072AbiI0SLE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2022 14:11:04 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2372874CED
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 11:11:00 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-351cee25568so26427657b3.1
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 11:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=tFO+eHfkmb7zVGbYxgTK1bWuwVm1KkYXm4jS0YKVQ90=;
        b=ImU8gFTrYwZarRFGGlX3ZakL7xXKcb6FWMPMmywHViGtalm6oeKlrYjGGDaPL9c0Vt
         Z/92gMdyEaxpjs4yeo60A8Yii1YS/5s0iFo96EeWkRikahSnv6RtpwzR5zwRIE+Kr6S7
         rE0hndU4/qoUszCSeYo6i30CaohKb5o2yA/ZKQMOmYVCT8rjynRTh/lvhIyA0Z7tUks/
         MqVVoL9EUDhhQJrYRbwl4sjchh9T9iBpIlhTf6y3CDo5JmGBQ3Sb+8V0sDAfhwpSPUCi
         0P5od0JW5Ab2L16z1nsK1N6dE72YPEdSd9gdDAzHatpWeGKbeLgSW7DmxP5G8KChL9RP
         F/3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=tFO+eHfkmb7zVGbYxgTK1bWuwVm1KkYXm4jS0YKVQ90=;
        b=AogoqvRwqDJpqXnGF2tKg4RbTdwYXnx+V5fUYYBHqrgyjzs5yzOsh2eIxP1lar3zPy
         OJhVBfIsUoPDbgQ+7f6sYO/YqmoP1xOCVuBghV+s8jxbA/cNdHoQX7soqjKtoaTEnDnt
         x3n39COiBvP1a3HXFoUHdqKzSfNZYuZEiiiN36c0RlYHNQ3TVVJ4LkmUM8sJphogec5X
         2SJ67SS458X9g2jFm55CCnwGTqyeExIMV4sfMOUSZkrtzIcA/ONoPtnXnUClCV4WlJ+x
         VZxYNxeyneYHZnxVFa3UfpF0mYF8OeB/2qnJ7LjItYpK66PKuiYentppirTpi6wqVUDZ
         vaTA==
X-Gm-Message-State: ACrzQf33xdsJ9bGjVMp3ZQlhOw/wnC3WpP+pLxYxSqz795eY8s98HXGR
        Mbe0qbsqm0YXX27kSpeaZk8Jzw0r9q7yw7EBQpWx66sNl0E=
X-Google-Smtp-Source: AMsMyM5cXirJyrjs8wUMUvpIRuqRC9tjDWZgtllcizbq3cKkbvlPzKWcXLBkdGohUhu+yxAxmTwO2rSuP9i5yjnyiI0=
X-Received: by 2002:a81:8502:0:b0:340:a7fc:ddb2 with SMTP id
 v2-20020a818502000000b00340a7fcddb2mr28418902ywf.378.1664302260049; Tue, 27
 Sep 2022 11:11:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220922232947.631309-1-calvinwan@google.com> <20220922232947.631309-2-calvinwan@google.com>
 <xmqqy1u9uddc.fsf@gitster.g> <CAFySSZA=tThoHdTY7+bMStvC=xeeyMiv4aVDYt-eNW2mQE10qg@mail.gmail.com>
 <xmqqpmfh8lxw.fsf@gitster.g>
In-Reply-To: <xmqqpmfh8lxw.fsf@gitster.g>
From:   Calvin Wan <calvinwan@google.com>
Date:   Tue, 27 Sep 2022 11:10:49 -0700
Message-ID: <CAFySSZC1DMdnCpi9enDG0=NDb+OU8jufHsq4WkjoN3mp1SZT8w@mail.gmail.com>
Subject: Re: [PATCH 1/4] run-command: add pipe_output to run_processes_parallel
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, emilyshaffer@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I wonder if you can arrange not to let them make unbounded progress?
>
> In order to run diff-files with path A B C D E ... where B and D are
> submodules and others are not submodules, you do not have to run and
> finish comparison for B and D before you can do the comparison for
> other paths, in order to preserve the proper output order.  You can
> start child task for B and D and arrange so that they will run for
> any other submodules, and then you

There is no need to preserve proper output order, as the output is
sorted at the end.

>  - run comparison for A.  The child task for B and D may be running
>    and starting to talk back to you, in which case their write may
>    get stuck waiting for you to read from them, but that is OK, as
>    you will read from them shortly.
>
>  - wait for the child task for B.  This is done by reading from the
>    pipe connected to it and waiting for its death synchronously.
>    The child task for D is still running and may be making progress,
>    but you are not obligated to read its output to the end.  You can
>    postpone reading to conserve memory and it will fill the pipe and
>    stall automatically.  Then accept the result for B.
>
>  - run comparison for C.
>
>  - wait for the child task for D.  You may have some data read
>    already while dealing with B, but you may still have some reading
>    to do at this point.  Let it finish synchronously.
>
>  - run comparison for E.
>
> etc., perhaps?

I understand the idea you're suggesting and I think it would work,
but I'm worried about the overhead this would create. I would rather
implement a separate "git status --porcelain" output for just this
submodule case so 1. we would not have to worry about unbounded
output and 2. both the output parsing and the command could be
optimized. In parse_status_porcelain, the function returns early if
the submodule is found to have untracked and modified changes.
This early termination can happen on the command side, rather
than the parsing side.
