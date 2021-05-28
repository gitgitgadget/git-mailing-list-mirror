Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05BDEC4708C
	for <git@archiver.kernel.org>; Fri, 28 May 2021 04:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C562B613DD
	for <git@archiver.kernel.org>; Fri, 28 May 2021 04:12:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbhE1ENt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 00:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbhE1ENm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 00:13:42 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D9FC06174A
        for <git@vger.kernel.org>; Thu, 27 May 2021 21:10:39 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id v19-20020a0568301413b0290304f00e3d88so2330344otp.4
        for <git@vger.kernel.org>; Thu, 27 May 2021 21:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OmOk5S1eyI9PV+0tz/9ymF3b3aEc10iBzJrInX5vg14=;
        b=grps5t5azBt3iQzhX6H7Jvm0WCTl6pp8jN1QmU0IhOOyAuWW8j59qg2RqZKgRYECmc
         ohT50NQGorLjvAq5N6OwhHECvAnbhIHPX62Sww8DxfqWZfaXuCARsx/f9JWlxvbkybyN
         bKW8MwizJDWPxFsS6TwbzH6b5asSssqq39X+gmIm/OFQSmU2nZn3oJ2AwMj3f8CrTlpa
         GxW3lWTkdwAWEoZw2kvJvFrRiQ9IrJv03eexA05eKHmZolEplOZxH1VAiLWWVLPV92xf
         2WrLzph/ESOuST1wBJFdQs4fnClbubPnzMDTAolmEps8ufR7vN6a8KVe0guUCmvVtALR
         TvjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OmOk5S1eyI9PV+0tz/9ymF3b3aEc10iBzJrInX5vg14=;
        b=XfXCCwFzuy2eMPDaFrvy0IMTPZ9JLjnGgW+/dKQCd+WcbjpV704GrxXFOqGSz+Da3U
         UYzDXmBbTZwkZGFZVMk1L1REESoOgkG6gW2cvs42FFuj9fsykhC1eX5t9QEwpf049V4v
         5/M3QIDPTcBGc2AU/yoUaT31sGi8Z7O6qHHGpTKG94fRlvTB92GwSxpQ9+TofeTso+Mv
         4SBuw8Pkq6WIEgc7Zj3GGJSv8Mnhg9+ASUYMIpvlK9Nk99HNxa+E6P+95HK9Hrc1hzvG
         jvcwKOYsA9ECkonK+KmPoM6/WhGyBfOyICqeYGQ9EHMz+bLj9oZxLbDuv2D5OWTGaElV
         tK7A==
X-Gm-Message-State: AOAM530iiliQ+Pvx+QiKpOW7Zkr/73h4Hl8yHVTqSrWe0VH/IhIifXft
        PNR4QKQfTS/YL7+CVqqp7ocZ8veDEtyZ2JHtQqo=
X-Google-Smtp-Source: ABdhPJzHGCpfThB2kLWGLU+OBSt/UrbAmlGW+TEoyEB/OXZeh8L2O1KfQvkZ/ocMd39XgKLHUxOEluUF5Ib/kmwENCs=
X-Received: by 2002:a9d:7096:: with SMTP id l22mr5479245otj.345.1622175038789;
 Thu, 27 May 2021 21:10:38 -0700 (PDT)
MIME-Version: 1.0
References: <pull.962.git.1622104642.gitgitgadget@gmail.com>
 <5055dfce32815c8c8ec250457df389d4cd02ee12.1622104642.git.gitgitgadget@gmail.com>
 <YLBIIL+yShDVlWo5@nand.local>
In-Reply-To: <YLBIIL+yShDVlWo5@nand.local>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 27 May 2021 21:10:27 -0700
Message-ID: <CABPp-BGXwC5Gtz5PVkXnw2wXzacqjUACB=sgCF5e=BwJiWsYPQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] merge-ort: replace string_list_df_name_compare with
 faster alternative
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 27, 2021 at 6:32 PM Taylor Blau <me@ttaylorr.com> wrote:
>
> On Thu, May 27, 2021 at 08:37:17AM +0000, Elijah Newren via GitGitGadget wrote:
> > -static int string_list_df_name_compare(const char *one, const char *two)
> > +static int sort_dirs_next_to_their_children(const void *a, const void *b)
>
> I looked at the new implementation of this function (and
> df_name_compare() to double check it) and am convinced that it's
> correctness, with the exception of one question.
>
> Some thoughts I had while trying to make sure this was all OK:
>
> > +     const char *one = ((struct string_list_item *)a)->string;
> > +     const char *two = ((struct string_list_item *)b)->string;
> > +     unsigned char c1, c2;
> > +
> > +     while (*one && (*one == *two)) {
> > +             one++;
> > +             two++;
> > +     }
>
> Advancing 'one' and 'two' to point at either the end of 'a' (and the
> same position within 'b'), or the first place where the two have
> different characters. If 'b' is shorter than 'a', '*one != *two' will
> terminate the loop (since '*two' will be NUL, and '*one' will not).
>
> > +     c1 = *one;
> > +     if (!c1)
> > +             c1 = '/';
> > +
> > +     c2 = *two;
> > +     if (!c2)
> > +             c2 = '/';
>
> Store off the last character of each, or '/' if we got to the end. Hmm,
> is this right (the guard in 'df_name_compare()' read 'if (!c1 &&
> S_ISDIR(mode1))'). Suppose both strings were "foo", then both c1 and c2
> would be "/", and I think we would return -1.
>
> That doesn't seem quite right to me. I think it *would* be right if we
> checked the mode of each entry before assigning c1 or c2 to '/',
> though. (Being generally unfamiliar with this area, I haven't looked to
> see whether getting access to the modes of each entry at this point is
> easy or not).

Good reasoning; I should have been clearer about one of the
assumptions that this function operates under which precludes that
possibility.

> > +
> > +     if (c1 == c2) {
> > +             /* Getting here means one is a leading directory of the other */

Your example case of both strings being "foo" obviously conflicts with
this comment; but the comment is correct.  This function will never be
given two equal strings because it is called to sort the keys of a
strmap, and strmap keys are unique by construction.  (If one side of
history has "foo" as a directory, and the other side has "foo" as a
path, then there is still only one "foo" in opt->priv->paths.  Every
entry in opt->priv->paths records 3 hashes and modes and whatnot in
order to know what each side of history had at the given path.)

Also, even in that case (when two strings are equal), getting the
right return value would only matter if we cared about a stable sort.
But we call this function with QSORT, not STABLE_QSORT.

Interestingly, this function technically doesn't even need to fully
sort the array either.  For example, if you took the output of 'git
ls-tree -rt HEAD' and permuted the order of files within the same
directory, that kind of level of quasi-sorted would be good enough for
my purposes; I just need files underneath the same directory to be
"together" and the containing directory to appear immediately before
those.  There is a later call to write_tree() that will hande sorting
within a single directory to ensure fully-sorted-ness.  Unfortunately,
I don't know of a way to take advantage of that less strict sorting
requirement for this point of the code to improve the performance
further, so this function just implemented "pretend that every path
has a '/' appended and then fully sort them".

> > +             return (*one) ? 1 : -1;
> > +     }
>
> > +     else
>
> I did find this spacing awkward (would have expected '} else' or even '}
> else {'), but it hardly matters.

I'll fix that up while adding some comments about the purpose of the
function and the fact that it assumes there will be no duplicates in
the array being sorted.
