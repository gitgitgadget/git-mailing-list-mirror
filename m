Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8CA6C433FE
	for <git@archiver.kernel.org>; Thu, 23 Dec 2021 18:38:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349857AbhLWSif (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Dec 2021 13:38:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240342AbhLWSie (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Dec 2021 13:38:34 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213FEC061401
        for <git@vger.kernel.org>; Thu, 23 Dec 2021 10:38:34 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id bm14so24736697edb.5
        for <git@vger.kernel.org>; Thu, 23 Dec 2021 10:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=niroAWe6e4NL8Hba6B6DHvNVFO57/vaCCxWrf8uVAPk=;
        b=GF/6Ty65fERYCF8jPD0AhQ9505BnTw2RC3su2s7Rc8HSU8iCEnoXAgMA2gdeJ3nrMh
         uDHtOJxA8+X+wkbI6uRJepTAM3c/uwEDu8ltd6XMxCPazOejtnlWhLF6H3F09bcswWi1
         59oE4LBmJoCl180T3Nnt/vtkZIaWpRMpZrIiI1bdsRYQqr2HpzghTj4FTJ+V3ujm5+6A
         H8j6Lv8ch68gFbLmVIZwXYJNYy92X7wR+xcbv1YLW5btWwEIqThEQY/f1bKEh8dMD9gK
         MtRV65Pun7zUv87HPaci0YjANjTURfOKv+RTamngaiU5nIeBC9SO+/BhPuqLVaC8NFf2
         mN3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=niroAWe6e4NL8Hba6B6DHvNVFO57/vaCCxWrf8uVAPk=;
        b=Ki8Ws9XFC3j16a1O2+sXBG0iMLtACaMJSSKzFWiKHF1Tr8/FAyiwJzVbTq+UEaMfcC
         ZKM9UQl66LHyl6xhwYNb+hCL8JkaEPDzwHTTLxU+gf7d5zAZL+vttkt67hs5Z/dQtbxp
         ktHDuyiFMDuEnmZBzh1A3++Bcu6+bkixMM/myoEt4qq1Y8PUNJ8BVjls7FecStELzsuc
         B3FyGjNF8nIrBbLDayqeYnJAyWua2ENqiJqX3/E74KKktTpPW+MnwgcifO4yJxlSv08F
         axj9+swVLG3VhFI70cCB/G1TyQuPT7w4ojaBys8N3rbhTNyDHwQ6dOg0oMB4ZM1v/1Ta
         YCMg==
X-Gm-Message-State: AOAM530CA+CMPWVM9Xl/lDc7h+h9e/Vm/YLP7+b/cwV3To++tozfO8+a
        ILcHxds2P6zJphL13X1GiNU3bSzRgimImZZmH/s=
X-Google-Smtp-Source: ABdhPJwOYo9INmrLf5Q6CX+j2CuO9RuE14cHaY6IBpFX0z3KB7o2Gmw/OgdJU+en/ydtVUZjdk5r9ZA5t1y+qGEhw9Q=
X-Received: by 2002:a17:907:9808:: with SMTP id ji8mr2981510ejc.476.1640284712670;
 Thu, 23 Dec 2021 10:38:32 -0800 (PST)
MIME-Version: 1.0
References: <pull.1103.git.1640109948.gitgitgadget@gmail.com>
 <1e7eef7705e2f7b4a456056e4335d82267680214.1640109948.git.gitgitgadget@gmail.com>
 <xmqq1r25o651.fsf@gitster.g>
In-Reply-To: <xmqq1r25o651.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 23 Dec 2021 10:38:21 -0800
Message-ID: <CABPp-BEWs8zch2diE2n0oKW6J8PRDDFwujzCXzemfz2-2-pjQA@mail.gmail.com>
Subject: Re: [PATCH 4/9] merge-ort: mark a few more conflict messages as omittable
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Neeraj Singh <nksingh85@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 21, 2021 at 4:06 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Elijah Newren <newren@gmail.com>
> >
> > path_msg() has the ability to mark messages as omittable, designed for
> > remerge-diff where we'll instead be showing conflict messages as diff
> > headers for a subsequent diff.  While all these messages are very useful
> > when trying to create a merge initially, early use with the
> > --remerge-diff feature (the only user of this omittable conflict message
> > capability), suggests that the particular messages marked in this commit
> > are just noise when trying to see what changes users made to create a
> > merge commit.
>
> It is likely because when somebody is looking at the output of
> remerge-diff, they are mostly concentrating on the _content_ level
> merges and they are not keenly looking for a merge whose result is
> deposited at a wrong path.  Since what is shown is something that
> has already recorded in the history, we can safely assume that it is
> no longer a relevant (or "it is way too late to matter"), I would
> say, to show these messages about "file location".
>
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> >  merge-ort.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/merge-ort.c b/merge-ort.c
> > index a18f47e23c5..fe27870e73e 100644
> > --- a/merge-ort.c
> > +++ b/merge-ort.c
> > @@ -2420,7 +2420,7 @@ static void apply_directory_rename_modifications(struct merge_options *opt,
> >                */
> >               ci->path_conflict = 1;
> >               if (pair->status == 'A')
> > -                     path_msg(opt, new_path, 0,
> > +                     path_msg(opt, new_path, 1,
> >                                _("CONFLICT (file location): %s added in %s "
> >                                  "inside a directory that was renamed in %s, "
> >                                  "suggesting it should perhaps be moved to "
> > @@ -2428,7 +2428,7 @@ static void apply_directory_rename_modifications(struct merge_options *opt,
> >                                old_path, branch_with_new_path,
> >                                branch_with_dir_rename, new_path);
> >               else
> > -                     path_msg(opt, new_path, 0,
> > +                     path_msg(opt, new_path, 1,
> >                                _("CONFLICT (file location): %s renamed to %s "
> >                                  "in %s, inside a directory that was renamed "
> >                                  "in %s, suggesting it should perhaps be "
> > @@ -3825,7 +3825,7 @@ static void process_entry(struct merge_options *opt,
> >                               reason = _("add/add");
> >                       if (S_ISGITLINK(merged_file.mode))
> >                               reason = _("submodule");
> > -                     path_msg(opt, path, 0,
> > +                     path_msg(opt, path, 1,
> >                                _("CONFLICT (%s): Merge conflict in %s"),
> >                                reason, path);
>
> I am not as sure about this one as the other two, though.  I guess
> in the context of remerge-diff, resolving the add/add conflict into
> the same file is also something that happened long time ago and
> these messages are too late to matter the same way as the other two.

Yeah, I'm not so sure about it either, and my notes are long, long
gone.  I think I'll pull this one out, and we can always tweak it
later if needed.
