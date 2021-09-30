Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60BDBC433EF
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 05:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 309A5615E5
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 05:27:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239907AbhI3F30 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Sep 2021 01:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233588AbhI3F3Z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Sep 2021 01:29:25 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB937C06161C
        for <git@vger.kernel.org>; Wed, 29 Sep 2021 22:27:43 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id l8so17684741edw.2
        for <git@vger.kernel.org>; Wed, 29 Sep 2021 22:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mpk49iruhf8TgXrEldZetqa3OVeVAndnr4DiD5wIw3I=;
        b=nw2njgLTzY4KckdivbcG0sWwtpTjtsyqepO7HbW8oJgkkHr+hqgBTHNDO3zI5IDBjS
         crQurtiGuYnKQjflgkZpjiQ9BvMbTZr/voBv52ca3Nc2rfsNocIp2yB2IhGt/aTHePYE
         qWL3K//A7u2Ek08rEnqYgIIL2kIPGYF7wHhUiVoYDIEOL8w9HHYKy3F8cR+sdlSHPyW3
         teCW+Xzpw0h3wkOlvMSo6XwpFQ8CzOlX50pvuyFLQnV2vmaE93MuQHBMRujKg/m3ZUNy
         k9nCnvfe9Jj/Cps+2JfLk04ZXvQOyT2sq/ZFK+J7Nz8B17AvjFcQdQyZ0hhFZCCieek7
         aAbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mpk49iruhf8TgXrEldZetqa3OVeVAndnr4DiD5wIw3I=;
        b=p3RIZSKQcOOkc31lAcbZFwg6d3rsl7/AyjlpEn7nQG+91aDs8WD6/UivtzTpcUdJWv
         8MigI4GuywG7sUOtPU81si7bnkTh+VPE0KnfZkL/MritwjMKCk33zTeyu7uAlo4xgo5J
         UDWeEHb9U4g8h2QQfwD53IqNCogXjAFrBLlK6EsZLIQa9ll2liMmaT85/VEez1DVfy+a
         pCLsQ5gHuY0oSQS2yh6xk5jsL7TVYQ+N829oxzfI/vyckm+V44ksikFx/Nngyifo1Nfx
         LsnW4SCqXBzMIVoyKcN/w++K6hvFq4ftUjZYca6QRb0jI+Jbvv+n2nDRrZ5XnsZh7Az2
         cJ6A==
X-Gm-Message-State: AOAM5303NdqOWEBtARngdNQDDJVS1GKpR4O3hLwSojNEgpQTuDS3JM7B
        u7gdjrDsk0u2b0+bpHfcV7SDwfNjb9yu4kpMuG3fdLQs4/I=
X-Google-Smtp-Source: ABdhPJwqVXL7FTF3pMBLefXbonX0cMPJ2w2+orNdbVCwg+c98pgpb4otGzi7KPJx+GXE4Gpxu0kah3D2XU7vTrbYU54=
X-Received: by 2002:a50:be82:: with SMTP id b2mr4820449edk.56.1632979662273;
 Wed, 29 Sep 2021 22:27:42 -0700 (PDT)
MIME-Version: 1.0
References: <CANgfOPtz9JqCs-7z1DJnOqxnsGiQS6BBPD6tKTWnTpC0K3qZ9Q@mail.gmail.com>
In-Reply-To: <CANgfOPtz9JqCs-7z1DJnOqxnsGiQS6BBPD6tKTWnTpC0K3qZ9Q@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 29 Sep 2021 22:27:29 -0700
Message-ID: <CABPp-BGv=+R1trGZq7r+-VneVUSoH_nOhS9sh3P7WSCiSVZksQ@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_Question_about_git_merge_=2Ds_ort_command=E2=80=8F=E2=80=8F?=
To:     Ariel Man <arielman22@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 19, 2021 at 8:12 PM Ariel Man <arielman22@gmail.com> wrote:
>
> Hi,
> following the below thread, led me to do some tests:
> https://stackoverflow.com/a/69114710/11705021
>
> One of the test can be seen here, in the last example in my question:
> https://stackoverflow.com/questions/69150777/git-mv-doesnt-work-as-expected-wrong-files-location
>
> I wanted to get confirmation for my case:
> Does `git merge -s ort` command, doesn't know to detect new folder
> location when merging it? It did worked for folders and files
> renaming, and new files under existing folders (as describe here:
> https://stackoverflow.com/a/52227201/6309)

I mean, if you have a testcase and want to see how it works, you can
just try it.  merge-ort has been released and is part of git already.

But I'll take a stab...

Your testcase with new folders sounds like testcase 12f from t6423 in
our testsuite (from commit 902c521a35 ("t6423: more involved directory
rename test", 2020-10-15)), a case that works with the `ort` merge
strategy but not with `recursive`.  So, the `ort` strategy is likely
to be better for your usecase than `recursive`, but it's hard for me
to definitively state that it'll solve all your usecase(s) since you
didn't fully describe them.  This is especially important since you
appear to have discovered a segfault (in the first post); I was not
aware of any circumstances when the old merge machinery would do so.
I'd be interested to know if the same issue repeats with the `ort`
strategy, and, if so, whether you can get a stack trace, or find an
example that reproduces the problem, or provide us with access to your
repository.  Also, in your second link, you allude to problems in a
case that does not include new folders, in situations where I'd expect
`recursive` and `ort` to behave the same.  But it's hard to know the
expected behavior since you didn't provide that many details about the
setup -- e.g. you didn't cover the contents of any of the files (so
it's hard to know if files are more similar to ones with different
names than what you expected to be matched up), it's unclear if there
are other files involved (e.g. if you have multiple copies of some
library and the rename detection is detecting a different copy than
you expected, or if there are lots of additional files besides those
you are listing in your example and they are being renamed
differently, etc.), whether you have lots of large files also being
renamed (perhaps the VDI files you allude to somewhere?), etc., etc.
If you can provide access to a repository and the commands you
reported and what you expected vs. what you saw, I'd try to find some
time to take a look.

I hope that helps, though I'm not sure I've got enough details to
answer all your questions.  I guess if I were to summarize, I'd say:
  * the `ort` strategy would be better than `recursive` for you, for
one particular type of issue, but probably behave the same on other
areas
  * you seem to have useful testcases that might be different than
ones we have in our testsuite or that I know about
  * you haven't provided enough information for me to investigate or
answer any further, though.

You have gotten me really curious about this segfaulting testcase --
whether it's just in the recursive backend or also afflicts merge-ort,
and how to duplicate it.
