Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C73C43334
	for <git@archiver.kernel.org>; Sun, 17 Jul 2022 03:47:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232572AbiGQDqk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Jul 2022 23:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiGQDqW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jul 2022 23:46:22 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02CAB165BB
        for <git@vger.kernel.org>; Sat, 16 Jul 2022 20:46:21 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id m16so2253695qka.12
        for <git@vger.kernel.org>; Sat, 16 Jul 2022 20:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iGFq4IfEIP8/T6lzoM4k2R5Y/DB/Z/C5qBqPMyhun24=;
        b=dHskxwgLT+hxKZwSh/F69cc0klCA16o8SMfXPNZzeaF3Kqo92u7480URIEz4Pu5Fe/
         hWaT02rctJoSegFu46b0YJ6JL+MSQlUu9Mt3h1emceAwSegKWDfDDNby+CFNweqMj/lJ
         +FaUE5I9GBTT1gsadn0sMKBYW/983FYHu08LM6qMkttGcIcZOVtwsvwRHPHNehIIPZ3l
         YceARPw9Cee7kSzK3KtjiUoWygd+nMFtue6v1+JWGs2BFurlMVhZcTnf+0889Ohre1iH
         frTFuA3ZfJfFWuYK2jnsBBqnyu2zaMIfxwUlrbzj5ZFjKgb8ZWmx1V/r9HVL9F4e1R0u
         Y9Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iGFq4IfEIP8/T6lzoM4k2R5Y/DB/Z/C5qBqPMyhun24=;
        b=AzM2OKScy/6JmS/w93/J3bHNCm4Z1XaKAtwos7zk6LYj024ECZ0h5YUssT1gYEr+FD
         Z48d0jUdIR1vqMwGwK54QU3v2OPXY/D/CfWaFlBJcRDa/QE5TRxKHlIcePVnKVSnaH0c
         Chho+tRyXhdfnPYRXahyCCNQKZ15pvC62hGVgKne7z7xvBTuILIKLibZZpFUyyoJSXF7
         /IqAj3QlkAUCJiW5DBpfy1ijxBb5ftfYlybUzu3KMf13+y2uOf9oRIVOjH7miCobbJYh
         qJV0dmbcJjNYUtJzFeHWOl85PXs5kdi2AcPDMIdvMjYhIud2Brd1GanBs8C2WIEz/Qdd
         hATA==
X-Gm-Message-State: AJIora9R3CsemvYwpyLmc7wYr2ppzsIWLeD2I8vXxxobsnXz56hYhkoU
        WnZreGnRMVsn3MkhKqZobrQqvGoYsm2WoQYNGf0=
X-Google-Smtp-Source: AGRyM1vPgLtRK9Sgj6Nd3jI/1MoYvHCYnwMzWGK4iewYndCyKgMnQ3yWbZyXMn9WGBzaPn6MwXUN/QiHN8kb/2MJKyM=
X-Received: by 2002:a05:620a:4547:b0:6b5:879c:5891 with SMTP id
 u7-20020a05620a454700b006b5879c5891mr13920558qkp.187.1658029579982; Sat, 16
 Jul 2022 20:46:19 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq7d4g8onl.fsf@gitster.g>
In-Reply-To: <xmqq7d4g8onl.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 16 Jul 2022 20:46:09 -0700
Message-ID: <CABPp-BFzehrH19zRSbLBB42nEs50_UCcfV2B22ZJFYtPCX=Zsw@mail.gmail.com>
Subject: en/merge-restore-to-pristine (Was: Re: What's cooking in git.git (Jul
 2022, #04; Wed, 13))
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi ZheNing,

On Wed, Jul 13, 2022 at 7:36 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> * en/merge-restore-to-pristine (2022-06-21) 6 commits
>  - merge: do not exit restore_state() prematurely
>  - merge: ensure we can actually restore pre-merge state
>  - merge: make restore_state() restore staged state too
>  - merge: fix save_state() to work when there are racy-dirty files
>  - merge: remove unused variable
>  - t6424: make sure a failed merge preserves local changes
>
>  When "git merge" finds that it cannot perform a merge, it should
>  restore the working tree to the state before the command was
>  initiated, but in some corner cases it didn't.
>
>  Needs review.
>  source: <pull.1231.v2.git.1655621424.gitgitgadget@gmail.com>

Looks like other reviewers aren't stepping forward (this has been in
"Needs review" for the last 6 "What's cooking" reports), which may
suggest others aren't as interested in this fix.  Since this was for
an issue you reported, and which you even volunteered to help
shepherd[1], perhaps you could step forward as a reviewer even if
you're not that familiar with the code?  Some things to look at and
report on:

  * Does it fix the issue?  (You reported that v1 did, again at [1],
but perhaps you could retest for v2?)
  * Does it appear I've addressed the issues Junio brought up about v1?
  * Even if you can't analyze the changes deeply, you can respond to
my patches with a "walk through" where you try to explain what the
different hunks of the patches are doing in your own words.  Even
folks unfamiliar with code areas can sometimes catch simple mistakes
that way, and even if you catch nothing, it means there's another
person more familiar with that code area.

I've had a little more time lately, so if you or someone does catch
something in the review, I can try to update the series.

[1] https://lore.kernel.org/git/CAOLTT8RpGGioOyaMw5tkeWXmHpOaBW9UH8JghUvBRQ50ZcDdYQ@mail.gmail.com/
