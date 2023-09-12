Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1862DCA0EF1
	for <git@archiver.kernel.org>; Tue, 12 Sep 2023 15:06:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236169AbjILPGY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Sep 2023 11:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235693AbjILPGX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Sep 2023 11:06:23 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DEB1CC3
        for <git@vger.kernel.org>; Tue, 12 Sep 2023 08:06:19 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-501b9f27eb2so8347875e87.0
        for <git@vger.kernel.org>; Tue, 12 Sep 2023 08:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694531177; x=1695135977; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IdpZyhalAUHIETrBieXLAVAOVZKOVlYCAN3QyFCDBS8=;
        b=Jhm3tJYHZvqBouLEPtsMasEBPoBOWZxq3INPtybK5DBJOZ/kIJx6Ut+E2Ut0RftMMd
         N7oVJuyPX7kwB3oaqGxQXMTBAMhxGwxCGlLAEyLy+f4SoqdEY/5FjPOEjCdPOYbFz+hG
         mG9UOjRQAT97dxKwM66rZlNG1b9Z44wJ9tDG945m8nS0XsjIGZjyws/AtdGRuTjYkyHO
         FbCE0L2iYuuTIOHRv8pe09y2JX+tGHmXhb32KKdvxLqxGJEjvogRfHTPmhsIn2F58fJi
         hOKZwtdWgtHkEkzSGhqmHBYjUxAPZ0wpL5PTSZXTlG7BY4ijA5bOrYnjHqVzw+EQHa2n
         PMnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694531177; x=1695135977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IdpZyhalAUHIETrBieXLAVAOVZKOVlYCAN3QyFCDBS8=;
        b=kGFAn7VN2lSxI9bYC2iEXe363Ctbuvm7tAfc3r9jQY4xaY/cEwutvu4vdOSWhrcLg7
         fsKzHExVlxpb2d8uU2SXJSPqqNaUODUKdwur5JrxcDTON9Y7ybCNPNoXR3tAreVMgc1P
         cvQ5dKzkwzYsCuQb6Tj9pUc55yje2pb6g5nD+/OghmZeDE5oPlO1iJphvP6xeWtXPGzY
         5u2Hypg9OjzzTgMQS1g/fHmrkTNpiB+EiikEu5TqMzGyCZLBTGBL0lzItzFm8kqsq8w7
         zSGfWZ3a6ARZ+RNEvNJdROyowIwb1DKvCHup1dLkYGsmNVs15ahbgZzZPBndWtUf6MjH
         MUrw==
X-Gm-Message-State: AOJu0YwcwCVhgG5b83X2lZETkx+fVN2VDurr8cIRYOBNBOd/hO115Jjx
        DmuUrvtKNAO7qj5IS42vngsBxj6LTbEqE2tcuNMBUL0zrgo=
X-Google-Smtp-Source: AGHT+IEOdJcZUmAXjQ4FHkQZaiQ9B3OGIWHjOKFWcOrjuQ2oN7qd93CEhQviz3gjuCuo+Xw4NB4lb72RYVWRy8jGVOk=
X-Received: by 2002:a05:6512:a93:b0:4fd:d254:edc6 with SMTP id
 m19-20020a0565120a9300b004fdd254edc6mr1006891lfu.26.1694531177124; Tue, 12
 Sep 2023 08:06:17 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1577.git.1692389061490.gitgitgadget@gmail.com> <xmqqo7j4t4dm.fsf@gitster.g>
In-Reply-To: <xmqqo7j4t4dm.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 12 Sep 2023 08:06:04 -0700
Message-ID: <CABPp-BGnjfNEROw0tbvk5vCeFeiS_5COH+_u7r5ZeXX1epP0wQ@mail.gmail.com>
Subject: Re: [PATCH] This fixes a minor memory leak (detected by
 LeakSanitizer) in git merge.
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Kevin Backhouse via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Kevin Backhouse <kevinbackhouse@github.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 18, 2023 at 2:41=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "Kevin Backhouse via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Kevin Backhouse <kevinbackhouse@github.com>
> >
> > To reproduce (with an ASAN build):
> >
> > ```
> > mkdir test
> > cd test
> > git init
> > echo x > x.txt
> > git add .
> > git commit -m "WIP"
> > git checkout -b dev
> > echo y > x.txt
> > git add .
> > git commit -m "WIP"
> > git checkout main
> > echo z > x.txt
> > git add .
> > git commit -m "WIP"
> > echo a > x.txt
> > git add .
> > git merge dev
> > ```
>
> We'd rather not to see the above in the proposed log message; can't
> we add (a variation of) it to our test suite?
>
> > The fix is to call free_commit_list(merge_bases) when an error occurs.
>
> We usually have the description of what the problem is and give an
> analysis on why/how it happens, before presenting a solution.  Write
> it more like:
>
>     The caller of merge_ort_recursive() expects the commit list
>     passed in as the merge_bases parameter to be fully consumed by
>     the function and does not free it when the function returns.  In
>     normal cases, the commit list does get consumed, but when the
>     function returns early upon encountering an error, it forgets to
>     clean it up.
>
>     Fix this by freeing the list in the code paths for error returns.
>
> >  merge-ort-wrappers.c | 4 +++-
> >  merge-ort.c          | 4 +++-
>
> These two places and their fixes seem OK, but I have to wonder if
> these are complete fixes.
>
> > diff --git a/merge-ort-wrappers.c b/merge-ort-wrappers.c
> > index 4acedf3c338..aeb56c9970c 100644
> > --- a/merge-ort-wrappers.c
> > +++ b/merge-ort-wrappers.c
> > @@ -54,8 +54,10 @@ int merge_ort_recursive(struct merge_options *opt,
> >       struct tree *head =3D repo_get_commit_tree(opt->repo, side1);
> >       struct merge_result tmp;
> >
> > -     if (unclean(opt, head))
> > +     if (unclean(opt, head)) {
> > +             free_commit_list(merge_bases);
> >               return -1;
> > +     }
> >
> >       memset(&tmp, 0, sizeof(tmp));
> >       merge_incore_recursive(opt, merge_bases, side1, side2, &tmp);
>
> The function before this hunk appears to have very similar code
> structure.  Does it need the same fix, or if not why not?
>
> > diff --git a/merge-ort.c b/merge-ort.c
> > index 8631c997002..a0eb91fb011 100644
> > --- a/merge-ort.c
> > +++ b/merge-ort.c
> > @@ -5070,8 +5070,10 @@ static void merge_ort_internal(struct merge_opti=
ons *opt,
> >               opt->branch1 =3D "Temporary merge branch 1";
> >               opt->branch2 =3D "Temporary merge branch 2";
> >               merge_ort_internal(opt, NULL, prev, next, result);
> > -             if (result->clean < 0)
> > +             if (result->clean < 0) {
> > +                     free_commit_list(merge_bases);
> >                       return;
> > +             }
>
> Before this function, there is a comment that this came from another
> function and it seems to still have a very similar code structure.
> Does the other function need the same fix, or if not why not?

The other function would need a more involved fix, which would
basically involve porting a59b8dd94f (merge-ort: fix memory leak in
merge_ort_internal(), 2022-01-20) to merge-recursive as a preparatory
step.  This particular cleanup cannot be ported in its current form to
merge-recursive.c until then.
