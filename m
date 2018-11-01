Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 489941F453
	for <e@80x24.org>; Thu,  1 Nov 2018 06:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbeKAP6R (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Nov 2018 11:58:17 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:45646 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727675AbeKAP6R (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Nov 2018 11:58:17 -0400
Received: by mail-vs1-f67.google.com with SMTP id 124so11603180vsp.12
        for <git@vger.kernel.org>; Wed, 31 Oct 2018 23:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ek6/LA6UEe4xFSh8coyOqCv5B0oUZ7ZwCPtxmo2tj5g=;
        b=byDs/8rA3W3ug16jZMKvzo02vKFzBv+vcX21XaHM7ZnoMv7GRAkS9Rw139HhRy6JP3
         j9rOZdVi7iBaT4R2CkfhMrDsndzFSRH70Y8DYRa6VHN1aBJyOCqDMjhdTc0a2lE4lmTn
         hg8r0k/cqMxfND1q+g1/BSR2OAWDgUauuQsYEGSt7qcHd53p7jtR3a9d+4Tqdy++M6tO
         l+kMx2eu0uVt+/kNJEbrc8L1B4cAYKLHxAmsg91TOubL7gVWmNx2U5qLI4P8r22ZTpqk
         EAY54veyRDitYx4VGftkhCXyIZrAgqV0OLIHvzfI+RYQ3AE4KwMeyNwDtLy+ntYF+Ofg
         DPNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ek6/LA6UEe4xFSh8coyOqCv5B0oUZ7ZwCPtxmo2tj5g=;
        b=jVaSH3LrGVcY/DbQ4pSt6X3G2LaEtUCamAg6x1CdgGO4jaJ54vitEkypIArAgpaBLo
         8zLUalouytChSOHqHcBjT8lBF/2oVB0b0PmCPiN8KvbjVlsdPApUEGrRZpB1xAbNNgmg
         Hx2plJ/tg6Te8yNvVgZaoRSIk6ckg0LcsVBb9DfXStX5E96asg7dy7MTwfei2mAUBoUM
         op0lTLBUyAedCGpI05reLGhrFjNODmSQkdCimJ+8GSVEawCPsn2CGdsz7M6GS5InLBoz
         xxw3DxeU+TkgFvLCOv9IpKSSYWVPEDG5Yct8l9USR20v8a6hON71og2dbSJy7i8lDC+0
         7W8g==
X-Gm-Message-State: AGRZ1gIUsg8t3CrfVOD3E2lDPnC5Qpa7GYLA/T+0gtA0clkixlEJNlU5
        DiYzcD3TZ57rrl+hxyGrohIjHcUWzg4nYQeH+jCjhw==
X-Google-Smtp-Source: AJdET5f8STewzSF97f4O54B9gt8NsBX7qOxjTYa38tl0jgXS/DnSf7sqtgGBznZhCbH6q/f/pLGDJ1vqHA7WJqePBLE=
X-Received: by 2002:a67:e44f:: with SMTP id n15mr2835099vsm.116.1541055395624;
 Wed, 31 Oct 2018 23:56:35 -0700 (PDT)
MIME-Version: 1.0
References: <20181014020537.17991-1-newren@gmail.com> <20181019193111.12051-1-newren@gmail.com>
 <20181019193111.12051-5-newren@gmail.com> <0b84c95b-38bc-e39e-a033-81eb3e7b8202@gmail.com>
 <95a236fd-a757-81ad-34aa-b26b3c3b6e85@gmail.com>
In-Reply-To: <95a236fd-a757-81ad-34aa-b26b3c3b6e85@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 31 Oct 2018 23:56:24 -0700
Message-ID: <CABPp-BGC11LRrSXveKg5+rvNY-29uTB5_Qdiev1-s7abJTNygA@mail.gmail.com>
Subject: Re: [PATCH v3 4/8] merge-recursive: new function for better colliding
 conflict resolutions
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 31, 2018 at 6:57 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 10/31/2018 9:53 AM, Derrick Stolee wrote:
> > On 10/19/2018 3:31 PM, Elijah Newren wrote:
> >> +#if 0 // #if-0-ing avoids unused function warning; will make live in
> >> next commit
> >> +static int handle_file_collision(struct merge_options *o,
> >> +                 const char *collide_path,
> >> +                 const char *prev_path1,
> >> +                 const char *prev_path2,
> >> +                 const char *branch1, const char *branch2,
> >> +                 const struct object_id *a_oid,
> >> +                 unsigned int a_mode,
> >> +                 const struct object_id *b_oid,
> >> +                 unsigned int b_mode)
> >> +{
> >> +    struct merge_file_info mfi;
> >> +    struct diff_filespec null, a, b;
> >> +    char *alt_path = NULL;
> >> +    const char *update_path = collide_path;
> >> +
> >> +    /*
> >> +     * In the recursive case, we just opt to undo renames
> >> +     */
> >> +    if (o->call_depth && (prev_path1 || prev_path2)) {
> >> +        /* Put first file (a_oid, a_mode) in its original spot */
> >> +        if (prev_path1) {
> >> +            if (update_file(o, 1, a_oid, a_mode, prev_path1))
> >> +                return -1;
> >> +        } else {
> >> +            if (update_file(o, 1, a_oid, a_mode, collide_path))
> >
> > The latest test coverage report [1] shows this if statement is never
> > run, so
> > it appears that every call to this method in the test suite has either
> > o->call_depth positive, prev_path1 non-NULL, or both prev_path1 and
> > prev_path2
> > NULL.
> >
> > Is there a way we can add a test case that calls this method with
> > o->call_depth
> > positive, prev_path1 NULL, and prev_path2 non-NULL?
> >
> >> +                return -1;
> >> +        }
> >> +
> >> +        /* Put second file (b_oid, b_mode) in its original spot */
> >> +        if (prev_path2) {
> >> +            if (update_file(o, 1, b_oid, b_mode, prev_path2))
> >
> > Since this line is covered, we _do_ call the method with prev_path2
> > non-NULL, but
> > prev_path1 must be non-NULL in all cases.
> >
> > I may have found a reason why this doesn't happen in one of the
> > callers you introduced.
> > I'm going to comment on PATCH 8/8 to see if that is the case.
>
> Nevermind on the PATCH 8/8 situation. I thought I saw you pass (a->path,
> NULL) and
> (b->path, NULL) into the (prev_path1, prev_path2) pairs, but in each
> case the non-NULL
> parameter is actually for 'collide_path'.
>
> It is still interesting if we can hit this case. Perhaps we need a
> different kind of
> conflict, like (rename, delete) [but I struggle to make sense of how to
> do that].

rename/delete conflicts are sent through handle_rename_delete() which
do not call into handle_file_collision().  What you'd instead need is
a rename/add conflict, in the virtual merge base, on the appropriate
side.  The fact that the prev_path2 non-NULL case is covered means
there's already a regression test that's probably nearly good enough,
you'd just need to edit the committer timestamps of the two merge
bases so that a different one was older.  I'm pretty sure we can come
up with one without too much effort.  I'll take a look tomorrow; too
late tonight.
