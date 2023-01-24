Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB84DC25B50
	for <git@archiver.kernel.org>; Tue, 24 Jan 2023 02:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231844AbjAXCGC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Jan 2023 21:06:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjAXCGB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2023 21:06:01 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A0944A1
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 18:05:59 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id z7so15223029ljz.4
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 18:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vfVvbi9aZlFHnQSL4sYGsdNs1WA1lAhCMFJLcITbVxY=;
        b=e4zJsmhmmWNTPiz8vpu2iWRFqBoJASNvqI0eSlaseIGNi/vF/g/k6O1kW6PyCR/sNA
         dO6g1uhvdAMoDM6eq5MBW4s6fXfSqjJO9daIHHZiU6BrY7Bf6H9sJBSN8RY6MwWOJXeT
         a4PnNJ1iSp2vXAIRi1eBlgsMKbF0WG2Vgzu5V+UBG9zUTgwxJefDOJ4XNwSfoCFSNAwq
         ooJmA+uixjYjnVtFasGu0E8t+p3w34m6QTJwHmrmGTovXU05Sp4cd1uXTNSOl2VQFZ7i
         kQ328GG12ykYwaYNU6bUOLf3hkrFdgMjvk+Qcs/YD7dxQEu/Tj16AKL7NPxv8v513v9H
         vd4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vfVvbi9aZlFHnQSL4sYGsdNs1WA1lAhCMFJLcITbVxY=;
        b=hQJyxifO9lWRgfv+JmU93M8oHs5Kp0yme8gbZHsIRHr6wHaAn6utz61BsNuLlnG9Rp
         /r8TbsIC2qAFuCpoN3UOVyHlVYo96wpFN3d5aqYy079jkrX/mciWG+is5MXtR8AgmjOq
         mtaMJSNbFbHhRoWqRoaNnMeR+3xcMlXlX2VEoF2WqNpK72lv9kHtRqLam2N1TjzLx5vD
         xwjyB3aZVbiSD676K2cAM8NEjaDiqz7lDmk0XTDJe8qZkNGxj1gzlruG4o4Hqk6HhQvb
         TGmZUt85BU0RjLZu/8fNcwThbeKtid38S8UCMLWTcxHVu8yDXurcnijEToWKBFj7psu6
         m3RQ==
X-Gm-Message-State: AFqh2ko9hjxqlC9SB3Txb1IA7gymDStzWgRNGtIUKnuBrqA8r0opKwWz
        a18zaDUZFqlGbS8e/6zZkMCjV/hwMHk3J/tnMzQ=
X-Google-Smtp-Source: AMrXdXu1yWxbQ61RWUq0Pvle5X+OFNdab/Uok0/47VUW0mMSqABCR5uPDa9grWCHJaoToyBUWdUkjwLHhbWEK+gBP1M=
X-Received: by 2002:a2e:9842:0:b0:289:c64d:cba2 with SMTP id
 e2-20020a2e9842000000b00289c64dcba2mr2474615ljj.325.1674525957439; Mon, 23
 Jan 2023 18:05:57 -0800 (PST)
MIME-Version: 1.0
References: <pull.1466.v3.git.1674266126.gitgitgadget@gmail.com>
 <pull.1466.v4.git.1674367961.gitgitgadget@gmail.com> <1d9748df-4f54-908d-75cf-49ff1d154fcb@github.com>
In-Reply-To: <1d9748df-4f54-908d-75cf-49ff1d154fcb@github.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 23 Jan 2023 18:05:45 -0800
Message-ID: <CABPp-BG4mUv0W1Duo3Jm6iOALY4Z2sT3o3nqDhz2sboe3AH1aQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/9] rebase: fix several code/testing/documentation
 issues around flag incompatibilities
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 23, 2023 at 7:56 AM Derrick Stolee <derrickstolee@github.com> wrote:
>
> On 1/22/2023 1:12 AM, Elijah Newren via GitGitGadget wrote:
> > We had a report about --update-refs being ignored when --whitespace=fix was
> > passed, confusing an end user. These were already marked as incompatible in
> > the manual, but the code didn't check for the incompatibility and provide an
> > error to the user.
> >
> > Folks brought up other flags tangentially when reviewing an earlier round of
> > this series, and I found we had more that were missing checks, and that we
> > were missing some testcases, and that the documentation was wrong on some of
> > the relevant options. So, I ended up getting lots of little fixes to
> > straighten these all out.
>
> Wow, this really expanded since I last looked at it. Thanks for taking on all
> of that extra work! (That was not my intention when recommending that you take
> over the fix.)

Yeah, I know you were willing to let some of the work wait for some
future series, and I intended to take that route.  But...
  * both you and Phillip brought up --autosquash, and it turns out we
didn't check it
  * the above made me check the whole list of incompatibilities and
discover other missing checks
  * adding tests made me discover that the documented
incompatibilities had a few issues
  * you mentioned that an explicit --apply wasn't checked either, and
since I was already diving in I figured I might as well handle that
too
  * even though you mentioned the config fix wasn't needed, both Junio
and Phillip brought it up as well,
    and based on the various feedback gotten so far, I started think
that just addressing it might require
    less work than going through more back and forth on review of the
feature without that implementation.

> > Changes since v3:
> >
> >  * Corrected the code surrounding --[no-]reapply-cherry-picks, and extended
> >    the testcases (Thanks to Phillip for pointing out my error)
> >  * I went ahead and implemented the better error message when the merge
> >    backend is triggered solely via config options.
>
> I really appreciate this extra attention to detail. I'm also really happy with
> how you implemented it, using different variables to signal how the option was
> specified (and using -1 for "unset" in both cases).
>
> While I had not been following version 2 or 3, I read this version in its
> entirety and everything looked good to me. These improvements to our docs,
> tests, and implementation will be felt by users.

Thanks for reading!
