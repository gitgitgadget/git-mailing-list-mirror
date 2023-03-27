Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB859C76195
	for <git@archiver.kernel.org>; Mon, 27 Mar 2023 11:00:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbjC0LAf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Mar 2023 07:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbjC0LAe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Mar 2023 07:00:34 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16AA3423C
        for <git@vger.kernel.org>; Mon, 27 Mar 2023 04:00:25 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id bi9so10813700lfb.12
        for <git@vger.kernel.org>; Mon, 27 Mar 2023 04:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679914823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QrnYQ0Z9iZBhnFFAezKwZrjEgqSrbmBCmWbFqAQtE3c=;
        b=EPJWC37UCp2S6MK9Kvu3ZHuDH+6+nDmsMmNruaXbnj9ji4xt0dzqBW516s4a2NVxSY
         aS0y14ntL4se5ea3WOGvzeJMGeFDvtOClsYkqzwkxMq0JY3xvHHAVAkdQ6G94zstg/I1
         Eyd4tA+9UZG4+Hze1it1aufr6iD0oYRc4pZJNJ2QqkxWGWn8qqkNzwZfX91IeO7jkXyG
         EY7rFx7yaZzGahYWmxKQrSGydlgX+F6nkHS9Mhpc5b3bgs6BKODSwoPQBemJAe9DOrtl
         /XzSk68nHsrWbRvcgDu8Gok9I7MVtLqGVH5m9dH1U7Fxp3/Z24m+jITBgu8adTbweniM
         Zijw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679914823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QrnYQ0Z9iZBhnFFAezKwZrjEgqSrbmBCmWbFqAQtE3c=;
        b=5qPoXZbqOyAZMtP1eqRHhp3y3NUyx4tSY9gRUYLKE+TTkg0MX/V3T81kDtMj+Phnu3
         AJDFYkRusIEnDYeJDgb35g9DgPY4HEUcd0C4pZw9OJLBgnci0yxrFATwRjwNQhYiFItc
         0QY7ZjJSlGQrAFWFMN4txD9QfEhF2LE1rhMjZNjrix8IImu1dV9DRXAJsQemvLfjI0H2
         yueYccg9wgS7CzoOLtOc/KtUIPB7j4A2PRZ4hPfetTG36pwnLPCKWNRF+MknntNlqkgE
         F4YEUKxrVdJQdBGMbm/6wqI55l0c8r7IJbWGr6bup5x6aJLVe3qdu9Bd6Hy+p2WUygPS
         TeIA==
X-Gm-Message-State: AAQBX9cmjMu6Rhqt9JUcrGwkB2HWUOKj3ps0H0428jb7HhwsaBk5vqrU
        jwnBaJg90JPLS6Rch4l9VdfLSMEofL3miqz+mTFILA7XJ2w=
X-Google-Smtp-Source: AKy350ajcPNjhps6kUSF+kHx965xPNl29adRj2rB6iYbwJovhD1stR9lGC2WEDBcRT6s97rA8ZUqrE7j/0DugO86UBk=
X-Received: by 2002:ac2:519c:0:b0:4e8:446f:f600 with SMTP id
 u28-20020ac2519c000000b004e8446ff600mr3205847lfi.13.1679914822972; Mon, 27
 Mar 2023 04:00:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAKc7PVD_65vB5+meeO3xcu4ASbqr85LBGUO8Ntb7SvbO+NNHmQ@mail.gmail.com>
 <CAKc7PVA14_mjZeuED1Ee0Mu5YoCSrR4FNNhSEKFHmnKnc-gESQ@mail.gmail.com> <ZBIIKqAIF+aF8vvx@coredump.intra.peff.net>
In-Reply-To: <ZBIIKqAIF+aF8vvx@coredump.intra.peff.net>
From:   Sebastian Gniazdowski <sgniazdowski@gmail.com>
Date:   Mon, 27 Mar 2023 10:59:56 +0000
Message-ID: <CAKc7PVDZ4Ra7s-pyFms1-sGqjYD9b407G1u0A0hHTkQRa-MPkQ@mail.gmail.com>
Subject: Re: A nice, beauty progress metter for Git Clone + a feature request
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 15 Mar 2023 at 18:02, Jeff King <peff@peff.net> wrote:
> Now, none of that is _strictly_ necessary. We could just dump the same
> human-readable progress to the progress command that we dump to stderr
> now, and it could scrape it for things that look like progress, and pass
> everything else through. But then, you can already do that with:
>
>   git clone --progress ... 2>&1 | my-progress-scraper
>
> (and it looks like the asciinema you showed is probably just a
> syntactically nicer version of that with support from the shell?).
>
> -Peff

Yes, that's what the asciinema does  =E2=80=93 it pipes git clone --progres=
s
to a script, and that's pretty much it. That's why I thought about a
core.pipe option, that would hold the my-progress-scrapper command.
That's a very easy change, could it be added to git source code? The
scrapper from the asciinema doesn't care if it's count, retrieve or
resolve, etc. currently ongoing, it simply displays a gauge with the
current percentage for the current stage. After a while one discovers
that it's resolve that's the final stage, and the gauge is intuitive
either before or after this revelation.





--=20
Best regards,
Sebastian Gniazdowski
