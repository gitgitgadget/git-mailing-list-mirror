Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C69C43334
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 19:07:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237521AbiGSTHP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 15:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbiGSTHO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 15:07:14 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A165C45048
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 12:07:13 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-10c0052da61so33185427fac.12
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 12:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gy++yN2l2UZq9snjsW7Ve3M3M8EQldjG/tnoupwpqYo=;
        b=jaSfm0eY/j46tMB7Rej1Oiehwa8A1aMHdfQqziv8u+6zqytVTbgGf77uzJHtYk3XmS
         tWwsPGAp1U1qfPIB0MMRG5V0iCz5+onOSYuho9dPuR+a8Jdmvb3xcqRC5Y/nh7kGYu6V
         m6P4oReebPXKT4bbtZAY0yp1e/6/F0kCXjKPgWEPzVddy6e1V8xcOHDFByI64j4522JE
         NKSeJ6HMEaWHGfFvfvRRwjGVVPSLeZQdGNwqSwE/O3XJtA6odTKBD3Up0l46L8l1ieLU
         r847Q0luJ4y9HAST7EyxBW8C0ttgilYJuCoNzbxHbFqsZqYuYkjQkCv/+q3ubb7AYkkP
         7JGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gy++yN2l2UZq9snjsW7Ve3M3M8EQldjG/tnoupwpqYo=;
        b=pPYHzm2HHFRJqOsrJIWWr57woKG69fwitJqmbCZJbQfB+BTmGCIEvmmj2EN7pLxFsO
         Fk2AQLAOMG+9lmuy6fag8Myk+Uxbtujj3ha6dZKbyc/gVHLqASQOsNM5Bj/eukvnEYr9
         0uDfr2Kt3tnXBmXLrdaGRv0ZO7IibrK69oc/a+OZWIdcbAWbZ1J+b/txMkTFoHs7DOsY
         yRbkKhKgtu5510zL9d5uCu1wZgrrco2HhoW93V7SsQRI7+otrB3CM3aVjHCJfS3Y9nn1
         wpS4PELbDwu5yRQNZ2D/Ig18a2puGRAchq7pMycyNYUNh1q3T9upq5JFyjZvj7bVpRz5
         yS7w==
X-Gm-Message-State: AJIora9RcMBXuxUaXsF8Pp6KKeJTugS1EQO9BRY82v1mY+9v8/FBKbLI
        KwraeLGiDuSlfCRex79hAwpTLsSMQN0EpV664XmS6A==
X-Google-Smtp-Source: AGRyM1vo0VFMhdFL9iVOdhVeET1GWhgPNe7Tv8JK+bIT6hBxvxRB3eV+CviRFMzp9VEnVjDD4rTi1ngoLnEXAgnJ+cY=
X-Received: by 2002:a05:6870:8328:b0:10c:fdf5:3be2 with SMTP id
 p40-20020a056870832800b0010cfdf53be2mr515050oae.4.1658257632883; Tue, 19 Jul
 2022 12:07:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220712231935.2979727-1-calvinwan@google.com>
 <20220718214349.3379328-1-calvinwan@google.com> <xmqqsfmxd17s.fsf@gitster.g>
In-Reply-To: <xmqqsfmxd17s.fsf@gitster.g>
From:   Calvin Wan <calvinwan@google.com>
Date:   Tue, 19 Jul 2022 12:07:02 -0700
Message-ID: <CAFySSZDoNX_5mxdKaT8JWkpYxBFxivQc_p2q_4bQk6YsT8QeZA@mail.gmail.com>
Subject: Re: [PATCH v5] submodule merge: update conflict error message
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, chooglen@google.com, newren@gmail.com,
        levraiphilippeblain@gmail.com, Johannes.Schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> These work on the result of calling find_first_merges(), but is it
> possible that we are asked to call this function more than once
> because we see conflicted submodule updates at two or more paths?

This does get called multiple times if we see conflicted submodule
updates at two or more paths.

> I may be misreading the code, but find_first_merges(), either the
> version we see in this file, or the one in merge-recursive.c, or its
> original introduced in 68d03e4a (Implement automatic fast-forward
> merge for submodules, 2010-07-07), look safe to be called twice.  It
> runs the get_revision() machinery, smudging the object flags while
> walking the history, but I do not see any code that cleans up these
> flags for the second traversal.

I don't quite understand which flags need to be cleaned up for the
second traversal.

> Also, this is not a new problem, but I am afraid that the logic to
> find existing merges in find_first_merges() might be overly loose.
> It tries to find existing merges that can reach the two commits, and
> then finds, among these merges, the one that is not descendant of
> any other such merges.  Don't we end up finding a merge M
>
>     A---o---M
>            /
>           B
>
> when a superproject merge needs a merge of A and B in the submodule?
> That is certainly a merge that contains both A and B and it may be
> closer to A and B than any other existing merges, but it still may
> not be a merge between A and B (in the depicted case, an extra
> commit 'o' nobody ordered is included for free in the result).  I am
> not seeing how existing code tries to avoid such a situation.

It is true that we find merge M and it isn't representative of a merge of A
and B in the submodule. In this case, the existing code prints:

"Failed to merge submodule %s, but a possible merge resolution exists: %s"

While this part doesn't claim M to be a guaranteed merge resolution, my
change adds this line:

"or update to an existing commit which has merged those changes such as
one listed above"

Instead of adding more verbosity to this language, it seems like a better
idea to remove "such as one listed above" entirely (and subsequently any
of my code that flags merge resolutions).
