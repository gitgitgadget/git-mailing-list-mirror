Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B34C25B08
	for <git@archiver.kernel.org>; Sat, 20 Aug 2022 23:22:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbiHTXWo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Aug 2022 19:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiHTXWm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Aug 2022 19:22:42 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 379512A42B
        for <git@vger.kernel.org>; Sat, 20 Aug 2022 16:22:42 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id l5so998764qvs.13
        for <git@vger.kernel.org>; Sat, 20 Aug 2022 16:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=lFxHlFzI5//qZxmvgQQyppxlSv0JVDAP2BOWSSBpyKk=;
        b=cfEhZ2sVPZADJ18Doi9Dt/R7ZHsDl2PYlE0l1KJ0jhu+gs91g3F9s4WTbF1v67aD0L
         xw+8Po8su3Y2QnyEfjRiHtlJ7JHl86+Bz1kA6BRfdNcc15l7VqXAjXxsOC1S4IXJsFYv
         hoMi2AzTIsaw1U71DQiZeF6V/sPP8HCnU+IoD5YAVuaI+1l4gEjpdkEFgrc2ztoyZP3v
         K6r5l4+YVfkigmvraUZ4XEtuh5LsfAYAOAcPaxdzgDlZOv5WqAUkgG3/8EbYxLOU3XAe
         GpGx0amnOeNAUxmr7WVUwMv4iXROnpWJ/0WB87xZ/ORe0ob7/iKBVYcq4fWojMBqGLuW
         Yljg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=lFxHlFzI5//qZxmvgQQyppxlSv0JVDAP2BOWSSBpyKk=;
        b=uMemGF6bTDQ+bvONNkCYvhAoXkjKz2g69TP7vQbL4DuMpy9F+Jj+E03i5K153JPdXG
         EBacQ3nDlOc+iVcahGO1R9aj4iYW3cLs83BL/CTHY99TQWU30FHIrod4/Gam66vkiIdK
         GTD5zgLi+49Dz7ZArP832y9QSHK0jGc/xzePXf5AfXJH6oljGkmjw+bnE9JkJpygbA2E
         57pfeDCTMbKyJhTaHijpGbXoc9ODFWYAF73Ls5PQDJU7fnNucv0z6so1DfKgZPCqkA/e
         qpxzxDk0mhXAh7bx8Q3ARNGSRJQf45KxD5ghhpO2eSWzcQ41vuAPDEicJfAtEeBMXF60
         w5Ug==
X-Gm-Message-State: ACgBeo13AAYo/Lvdptgg7JKe7yQNvilvqzqNbybfdLsD5+MRp4EfVEgS
        /axgbW1BdmIkeIXgX2VFoVjZx6Y4oD/YuPBQEDY=
X-Google-Smtp-Source: AA6agR59X82IxQzDueMvxtTB7uqfFv3grSmI04Uz4rdEaCjzXuhYU+5nh8yVcKrp0TIXFtMEMncg8NKmFfT+xH6bL8k=
X-Received: by 2002:a0c:8b92:0:b0:496:c8ff:b4c7 with SMTP id
 r18-20020a0c8b92000000b00496c8ffb4c7mr3171088qva.115.1661037761299; Sat, 20
 Aug 2022 16:22:41 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1327.git.1660892256.gitgitgadget@gmail.com>
 <c6eb286b60808bc9e69ce9b09fe4389db15db492.1660892256.git.gitgitgadget@gmail.com>
 <44pr310n-rpr1-0660-0961-386rsq9q11o1@tzk.qr>
In-Reply-To: <44pr310n-rpr1-0660-0961-386rsq9q11o1@tzk.qr>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 20 Aug 2022 16:22:30 -0700
Message-ID: <CABPp-BH98_N4WrYUWTx8oOvfOWhEL+9sGnR8U2tRZjYUfzv1_Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] merge-tree -z: always show the original file name first
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 19, 2022 at 2:17 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi all (and I guess in particular Elijah),
>
> On Fri, 19 Aug 2022, Johannes Schindelin via GitGitGadget wrote:
>
> > diff --git a/t/t4069-remerge-diff.sh b/t/t4069-remerge-diff.sh
> > index 35f94957fce..bc580a242ac 100755
> > --- a/t/t4069-remerge-diff.sh
> > +++ b/t/t4069-remerge-diff.sh
> > @@ -131,11 +131,12 @@ test_expect_success 'setup non-content conflicts' '
> >  test_expect_success 'remerge-diff with non-content conflicts' '
> >       git log -1 --oneline resolution >tmp &&
> >       cat <<-EOF >>tmp &&
> > +     diff --git a/file_or_directory b/file_or_directory
> > +     remerge CONFLICT (file/directory): directory in the way of file_or_directory from HASH (side1); moving it to file_or_directory~HASH (side1) instead.
> >       diff --git a/file_or_directory~HASH (side1) b/wanted_content
> >       similarity index 100%
> >       rename from file_or_directory~HASH (side1)
> >       rename to wanted_content
> > -     remerge CONFLICT (file/directory): directory in the way of file_or_directory from HASH (side1); moving it to file_or_directory~HASH (side1) instead.
> >       diff --git a/letters b/letters
> >       remerge CONFLICT (rename/rename): letters renamed to letters_side1 in HASH (side1) and to letters_side2 in HASH (side2).
> >       diff --git a/letters_side2 b/letters_side2
>
> I would have liked to avoid touching this file altogether, of course, but
> when I investigated, I came to the conclusion that while this patch still
> does not produce the best possible outcome for remerge diffs, it does
> improve upon the current situation.

No, this is a strict regression.  Those file headers corresponding to
the file/directory conflict (similarity index, rename from/to, and
CONFLICT) are all supposed to be grouped together in the same diff
header.  As to the names...

> The thing is, when mentioning that we had to rename `file_or_directory` to
> `file_or_directory~HASH (side1)` to be able to write the file because a
> directory of the same name already was in the way, I would actually have
> expected this to come under the diff header
>
>         diff --git a/file_or_directory b/file_or_directory~HASH (side1)
>
> Previously, it was under the header
>
>         diff --git a/file_or_directory~HASH (side1) b/wanted_content
>
> and with this patch it is under
>
>         diff --git a/file_or_directory b/file_or_directory
>
> which is still not ideal: It mentions only the original file name, not the
> munged one.

The point of remerge-diff is to show how a user modifies from the
auto-merged state to the final merge commit.  As such, the filenames
from before the merge starts are irrelevant; the only two relevant
things are the filename at the end of the automatic merge, and the
filename recorded in the commit.

In particular, for the case here, upon "git merge $BRANCH" the merge
would have stopped with a file named "file_or_directory~HASH\ (side1)"
present in the working copy[1].  The user resolved it via renaming
that file to "wanted_content".  As such, the first and third options
you list are incorrect, and the second one -- from the behavior
previous to your patch -- is correct.


[1] Technically, "git merge $BRANCH" would have used "HEAD" rather
than "HASH (side1)", but that's only because at the time of invocation
of git merge, HEAD would have been a very specific commit.  The same
isn't true of HEAD when the user runs `git log --remerge-diff` at some
very different time, so we opt to replace "HEAD" with something more
meaningful for readers of the diff when running --remerge-diff.
