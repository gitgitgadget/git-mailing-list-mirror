Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8557AC433DB
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 20:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3675A64F0E
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 20:45:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbhBZUpj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Feb 2021 15:45:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbhBZUpi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Feb 2021 15:45:38 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3057DC061574
        for <git@vger.kernel.org>; Fri, 26 Feb 2021 12:44:58 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id o3so11071885oic.8
        for <git@vger.kernel.org>; Fri, 26 Feb 2021 12:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=yzGRWBPFbvMDMo8+chdDvxw+sGZL0uxpI+7wPGkldj8=;
        b=ROCPF5w8f9mQgeaJ59QlwkegO3ShllclfuQHYbZ3OYvr74vzyYN8PAcYRS8MRcNE+g
         R1/J4dHi7rsKbtcYw+LgI2/M8Qg7VTIdU2N1I8MReapz9tLO8deGfFdIK0lwu2Xy5Q5E
         qUSB17m1U9CCDmyA4Ljqf1dUyBLWlSAKEjDRQ74ra6wz3TZrL/aD4xD0V/RDc7ZJGsoD
         hGlCWJLAXw+gAG6tLZyBqrOC7QB8tP/lHl2ksGkEcGvtykANFTHBVm0GwcgqqEX6qarJ
         qcPE1bweJm06VzL9Hg0bnYqC41N4Z3xD4Hmn/SwhMuB5q2ZLjmhVSL0b2BYV3/ra+V0d
         xOrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=yzGRWBPFbvMDMo8+chdDvxw+sGZL0uxpI+7wPGkldj8=;
        b=YX9VhJBGKdH2uS+X8Ek9Iku+ZVS3XrgLCLS+6nxqcXqdouMxKbOsmL8namrFicwfl4
         7mBzUQRGFP4oEZ1wTzsX2nv76UyzYmD0unjhxd3YUqQXkVBRFLga//Uci8N4jC9FJKkA
         pll9xAjHy3nLa+sd03IYjC3ewpGvth5mCed9JXdDuCQOIjvNfwBq/NR+3LGcZhYTg4p3
         8vzcoe3SkqWFMOQ2pdqxflvQUSE9zi7ASiUqsv0ZMUUPROFzifdAgmXsQnw65p504lou
         qxmbmhzCwoUjhidzoOhXSKQDHxQAweuXfJwHWKPsrNPp8QSjBhP41N7dK7X/dN0iEYEk
         f0IQ==
X-Gm-Message-State: AOAM533wYjXl0f/PHT5Q2sV+DS4S33mzdB/f1qf7IQyej7SvkNmKYy8O
        8jurq/rCXp0+ZCylxeDGqzlnzOakebvVkj2lXuEd7l68OBkF8g==
X-Google-Smtp-Source: ABdhPJy8o/8FNuDIVkMoY6CL9489Xxf5wJauwE5JXCxaHH3aCy4v1tJ5XFKL0ikNu736elj43Ur/poHaDdD5HHi9w7c=
X-Received: by 2002:aca:30c2:: with SMTP id w185mr3342273oiw.177.1614372297286;
 Fri, 26 Feb 2021 12:44:57 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?B?zqPPhM6xz43Pgc6/z4Igzp3PhM6tzr3PhM6/z4I=?= 
        <stdedos@gmail.com>
Date:   Fri, 26 Feb 2021 22:44:19 +0200
Message-ID: <CAHMHMxVc8Q1waPQbec-UUN9jcEUgtXOdHymAKigtNj+tc=Wwvg@mail.gmail.com>
Subject: Pathspec does not accept / does not warn for specific pathspecs
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello there,

as I was trying to use git-archive to ... well, archive some
artifacts. So I called:
git archive HEAD -o p.zip --prefix=p/

Then, I noticed that .gitignore files from the repo were packed (and a
couple of others, but we don't care about that right now).
I wanted to exclude all .gitignore files (there is `/.gitignore` and
`/resources/.gitignore`). So I did:
git archive HEAD -o p.zip --prefix=p/ -- ':!.gitignore'

I noticed that the second-level .gitignore file was still included. I
started thinking that this is not a .gitignore pathspec, but it
matches a literal file.
I don't know why at-the-time I accepted that, since, if I write
`.ignoreFile` at a `.gitignore`, it would exclude any `.ignoreFile` at
any level. So I did:
git archive HEAD -o p.zip --prefix=p/ -- ':!/.gitignore'

Which, as expected, did not change anything; and I followed up with:
git archive HEAD -o p.zip --prefix=p/ -- ':!**/.gitignore'

Then, I noticed some weird behavior. The second-level `.gitignore` was
getting ignored, but not the first one!
Someone at the chat indicated that, the `**` was _magically_
interpreted as `*`, which is obvious to me why it won't help. So, they
suggested:
git archive HEAD -o p.zip --prefix=p/ -- ':!(glob)**/.gitignore'

Which lead to **both of the  .gitignores** to be included. And then I
was baffled.
Now I know (I guess) that the pathspec magic was `:!`, and I tried to
match against a `(glob)**/.gitignore`, i.e. `(glob)*/.gitignore`,
which, of course, it doesn't exist in any form.

And I wonder:
Why doesn't `git archive ... -- ` understand `:!.gitignore` as a
.gitignore file would do (minus the `:`)?
Why doesn't `git archive ... -- ` understand `:!**/.gitignore` as a
.gitignore file would do (minus the `:`)?
Is there some reason that `git archive ... -- ` doesn't understand
`:!(glob)**/.gitignore`? It doesn't sound awfully complicated, or
risking a lot of regression (a folder starting with `(`, and
containing valid pathspec long forms IMHO is rare), or
Is there some reason that `git archive ... -- ` doesn't warn me that
`:!(glob)**/.gitignore` is invalid (and maybe I meant
`(exclude,glob)`)?

With regards,
Ntentos Stavros
