Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3860CC6FD1D
	for <git@archiver.kernel.org>; Fri,  7 Apr 2023 07:08:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233087AbjDGHIW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Apr 2023 03:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231524AbjDGHIV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2023 03:08:21 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0A51FCA
        for <git@vger.kernel.org>; Fri,  7 Apr 2023 00:08:19 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id y20so53532844lfj.2
        for <git@vger.kernel.org>; Fri, 07 Apr 2023 00:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680851297; x=1683443297;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JNb0OJO52dYSV+j5IaZtB5sg/hdXVujf/A6atSblZ3A=;
        b=gtx5MAOYMWfB1JM1SqHQee4gW5c6YBpeosoXnr4SRy6+RT0BJWEf6gfWGoevtgcMtb
         Zuc/hhCsza9tRuQT42uf+I93fjlC60TVAUd2I8E/hjpjaPQfkB8LmCotVZBK2JjNfmOX
         QFjmEr4LDlfRRaB7+qYw66A8vExksJjOXTXT2IW8g0OQHTT0YAx8qgId2rw3c5DFgo7K
         n7Eb8tGD7k9Y8T4K8EFlvLjVOD9qRR3LwqLza+hR0YoP7T43/4IoK7JgK3DGrVKqhnLM
         qbpKinBZVh1tKpvrOSEQYEXv3W9M+dG7aEj0w1LFPQErSv5uVLNFyoBvh4G8/CDEaRWU
         0iNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680851297; x=1683443297;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JNb0OJO52dYSV+j5IaZtB5sg/hdXVujf/A6atSblZ3A=;
        b=TgJmK/IADRtRkeLL6rklnYntqc3GMiiq+UgPIcIReg2pLWH2kD8yhQHERQ9ueGu7QI
         +SNxY0SRsjnxoRTMmRaVXst5j0bQA/liy8soCuxjKHKh/nHqN89TCIbvQ5UEC9LKrgzE
         ANNexAaibdGjdsJyMFI+Uf4P9V74iD818+JNma6VIdUVRnrl4SdqC8eQkoB0LWA8z+Ap
         reiEOqk0DtmuOZPRF8bDK61yrPy+nI8j8nDUB1uT21HveQr+TvZMMkV3mmuBW3EkGGKR
         sWVUGgobfKXTnHjl9G7tscCi/R9OAuwIATxsbduuufxe0j7tDMeaTXlVJYAJSnwswwhw
         kotA==
X-Gm-Message-State: AAQBX9dz7DtXRnB36pfY2QTh2Kf3YzctqYfO1hLhJvz5+d7eGqjEukPk
        TfJRLpO9utt/BizljAPfteGezkVoC1WHzYsvYMg53Z7U
X-Google-Smtp-Source: AKy350biikTu+4a4arWMKPi/mmKus5SPNoRhbVzHXLdWv5Eb1IQZGJjBkaebiZzhp1B+yT4i7ScAmc4hDXuGQCr6gno=
X-Received: by 2002:a05:6512:3996:b0:4e8:4409:bb76 with SMTP id
 j22-20020a056512399600b004e84409bb76mr497261lfu.2.1680851297477; Fri, 07 Apr
 2023 00:08:17 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1509.v2.git.1680571348.gitgitgadget@gmail.com> <20230405173020.730912-1-calvinwan@google.com>
In-Reply-To: <20230405173020.730912-1-calvinwan@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 7 Apr 2023 00:08:04 -0700
Message-ID: <CABPp-BHi8tNxoLKSxCaHbyK3zHRevJTqJQdNjU3cLynNExmYVQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/24] Header cleanups (splitting up cache.h)
To:     Calvin Wan <calvinwan@google.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 5, 2023 at 10:30=E2=80=AFAM Calvin Wan <calvinwan@google.com> w=
rote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
> > This series builds on en/header-cleanup
> > (https://lore.kernel.org/git/pull.1485.v2.git.1677197376.gitgitgadget@g=
mail.com/)
> > and en/header-split-cleanup
> > (https://lore.kernel.org/git/pull.1493.v2.git.1679379968.gitgitgadget@g=
mail.com/),
> > and continues to focus on splitting declarations from cache.h to separa=
te
> > headers. This series continues dropping the number of cache.h includes;=
 in
> > this series we go from 254 such includes to 190.
> >
> > The series may appear to be long at first glance, but is repetitive and
> > simple. It should be relatively easy to review, and falls into roughly =
3
> > categories. An overview:
> >
> >  * Patches 1-6, 7: Being more explicit about dependencies. This was
> >    motivated by the fact that trying to find unnecessary dependencies o=
n
> >    cache.h were being made harder by implicit dependencies on trace.h,
> >    trace2.h, and advice.h that were included via cache.h. (Similar to
> >    gettext.h handling in the previous series.) So I simply try to make
> >    dependencies more explicit, for both these headers and a few others.=
 To
> >    make review easy, I split it into half a dozen patches, one header p=
er
> >    patch (well, except that I handle trace.h and trace2.h together). Pa=
tch 7
> >    then removes several includes of cache.h that are no longer needed d=
ue to
> >    patches 1-6.
> >  * Patches 8-19: For several choices of FOO, move declarations of funct=
ions
> >    for FOO.c from cache.h to FOO.h. To simplify reviewing, each case is
> >    split into two patches, with the second patch cleaning up unnecessar=
y
> >    includes of cache.h in other source files.
> >  * Patches 20-24: Other small manual cleanups noticed while doing above=
 work
> >
> > Since patches 1-15 & 17-19 are just more of the same types of patches
> > already reviewed in the last two series, it probably makes more sense f=
or
> > reviewers to focus on the other patches: 16 + 20-24 (which also happen =
to be
> > smaller). I would particularly most like review of patches 16, 22, & 24
> > since they are the least like any previously reviewed patches.
>
> Patches 1-15 a& 17-19 LGTM! Very welcome changes to see the size of
> cache.h shrink after this and your previous series.
>
> I had the same change in patch 16 on a local branch, specifically moving
> editor related functions from strbuf. The eventual dream for lower level
> libraries such as strbuf is to separate out the functions that touch
> higher level objects, allowing for the eventual libification of parts of
> Git.
>
> Patch 20: removal of unnecessary headers are always welcome since it
> allows readers to easily understand what dependencies a file has.
>
> Patch 21: I do have a suggestion that I will leave on the patch
>
> Patch 22: with what's currently in wrapper.h, it feels like it's
> becoming the new dumping ground for functions that don't quite have a
> home elsewhere. While I think this change makes sense right now, I do
> hope in the future wrapper.h can be broken up with more reasonable
> boundaries rather than "this function is a git-specific stdlib or
> whatever lib function".

Yeah, I wouldn't be surprised that we have multiple places needing
cleanup.  I haven't looked much at wrapper.[ch] from this angle, but
you got me curious and I took a brief glance.  Do you really mean
wrapper.h, or wrapper.c?  wrapper.h is actually pretty small, only
declaring 8 functions.  The other 32 non-static functions in wrapper.c
are declared in git-compat-util.h.

> Patch 23: same reasoning as with patch 20, swapping to more precise
> headers clarifies file dependencies
>
> Patch 24: moving more items from the "dumping ground" to where they're
> supposed to be :)
>
> Besides patch 21, the rest of the series LGTM, thanks!

Thanks for taking a look!
