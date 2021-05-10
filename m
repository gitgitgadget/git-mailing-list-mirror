Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2709AC433ED
	for <git@archiver.kernel.org>; Mon, 10 May 2021 16:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E74D5611F0
	for <git@archiver.kernel.org>; Mon, 10 May 2021 16:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbhEJQ6L (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 May 2021 12:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbhEJQ6K (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 May 2021 12:58:10 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E78C061574
        for <git@vger.kernel.org>; Mon, 10 May 2021 09:57:05 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id s25so21680036lji.0
        for <git@vger.kernel.org>; Mon, 10 May 2021 09:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v3VC8EkBxmPo2UB0MwfWdUqWznmfMTV2kiLHhDhUbX4=;
        b=JYQV3NX6sOMMeHXtkOg559ZkFIVk+Fx4jEw+K7BiMcU3FIBXt0cMFyPpv58zfFCK6X
         hJQsAVPr4MyNUql5tVz1LpQGqyu/tB9RoQLdM5L6AqHLeLch0ISP8Mvt52X0eGyaXfLF
         ZCp9I6VHCJPSk7eBvoFRkwoDH4O4D3m3Ac+LB5JrLNDx6qursssi3cDrvg8uz7s1qfzE
         7S2R8jpbkPMdT+jcwZS3c7cBJzw5xYcF+t6Q09jCzuzmnD5bQttaT8tSYYs4fZLJthIp
         jOYsxCKa4+PQsWhQRlsGcesncg9co1sOg/+VLBuxfLO7zyDAW5XK3sMsJ75EXMULKRnY
         fGjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v3VC8EkBxmPo2UB0MwfWdUqWznmfMTV2kiLHhDhUbX4=;
        b=HMw8k9Ky361z+t+Dyj15ExtE9lij6LvMMh3IPfDTv3eDIJpbcKp+k4czTuJeT8ngPh
         B3W2SGQYCopp0OqJEjo24rUjBHnZadIhRH8CKZJIVUKfMRTLUifNC+TqAG+fVKMJQb2O
         xOCoO4Lejn1TZKCdKvMVwQMbX+hUCfmfMwcS0+WaVbic8JJCeOccZ+nht2o/ltpTUcWR
         6phWS3vmaQKv8fioVGDtuVNxKcCfew+yxcafBlzVbwD5Dllt1pDMgOs5dh9HmHJhO0fY
         aK8hMEg2gBAuaJQldzr/Xlh27LyIxFKm2CY+4iQ8TVhmhnjvWI08Tnar/nalk5qWRhAD
         2e4w==
X-Gm-Message-State: AOAM530jPzYZuKtXpGYUQ/7OlrWJ3B5pS/Rl4Ha0wtxrxSJvFkQbTQH1
        CduYWVbR9cZVDElFFpvMKt9NJE3jLd8hVW42Q1Y=
X-Google-Smtp-Source: ABdhPJzeglxOlHQphqrGetGJHHVf1PPUjuUhhXHhmzmY1ikh0LGwTij6bql/jtDUlZFDucJ0+2Tg1WsOVd0Xx7qnEUw=
X-Received: by 2002:a2e:81d0:: with SMTP id s16mr22159400ljg.74.1620665823749;
 Mon, 10 May 2021 09:57:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
 <87a6p2hjpe.fsf@osv.gnss.ru>
In-Reply-To: <87a6p2hjpe.fsf@osv.gnss.ru>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Mon, 10 May 2021 10:56:52 -0600
Message-ID: <CAMMLpeT+afQFjB=wDQYz=ECA8m=FXMnUkX7gekOZ3=YtAOJ5EQ@mail.gmail.com>
Subject: Re: Why doesn't `git log -m` imply `-p`?
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 10, 2021 at 6:11 AM Sergey Organov <sorganov@gmail.com> wrote:
>
> Alex Henrie <alexhenrie24@gmail.com> writes:
>
> > I read the following in `man git-log` today:
> >
> > --diff-merges=separate, --diff-merges=m, -m
> >     This makes merge commits show the full diff with respect to each of
> >     the parents. Separate log entry and diff is generated for each
> >     parent.  -m doesn't produce any output without -p.
> >
> > --diff-merges=combined, --diff-merges=c, -c
> >     With this option, diff output for a merge commit shows the
> >     differences from each of the parents to the merge result
> >     simultaneously instead of showing pairwise diff between a parent and
> >     the result one at a time. Furthermore, it lists only files which
> >     were modified from all parents.  -c implies -p.
> >
> > --diff-merges=dense-combined, --diff-merges=cc, --cc
> >     With this option the output produced by --diff-merges=combined is
> >     further compressed by omitting uninteresting hunks whose contents
> >     in the parents have only two variants and the merge result picks one
> >     of them without modification.  --cc implies -p.
> >
> > Why do -c and -cc imply -p, but -m does not? I tried to use both `git
> > log -c` and `git log -m` today and was confused when the latter didn't
> > produce any output. Could we change this behavior in a future version
> > of Git?
>
> Patches to fix this are almost ready, but I'd like to make a warning
> that you'd likely be even more confused by the current output of "-m",
> unless you set "log.diffMerges" configuration option to "first-parent".
> These diffs with respect to /second/ parent at the end of the output
> made me really mad once upon a time.

Good observation. I'm not sure what would be the ideal default here,
but certainly having -m turn on /some/ kind of diff is better than
nothing. Thanks!

-Alex
