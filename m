Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2049FC433F5
	for <git@archiver.kernel.org>; Thu,  3 Feb 2022 16:09:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352125AbiBCQJ5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 11:09:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbiBCQJz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 11:09:55 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E8BC061714
        for <git@vger.kernel.org>; Thu,  3 Feb 2022 08:09:55 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id m4so10318454ejb.9
        for <git@vger.kernel.org>; Thu, 03 Feb 2022 08:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+ke7RaMQixVkIRm1Ff/l0zFyoIKpOBVHVKRs6Omoli4=;
        b=RrLYT8Ln8sQnnHY/sK9Ab7rx3bNt21rd6tCDrAfxiKNUzkDQNC309Bdy6nYDSrKn7l
         t4UwQaB33QMipXykOR+C2EGUKQJqg973iDOuWO20a8XtN5kJ25BdxVt5rOML3f5bHtH/
         ngfIRxFu41Qw6FZpf+5owSTRxJxDonno6EgojqdkGgEG6dWvmmYQ0/Nz4djsYvfGOSHG
         wNqsS0asqHJ9iY0aDrGVRBTbsiFSZN5+R+GpdORUOBvFojbfrX6o/ONzs7+xNRaluXbQ
         i0cA353HnAaMWjbucRZHjkoXeW31qXcFpfiBZxci4ALNaOeK0lzzCRKsecN062cwRB/B
         VAmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+ke7RaMQixVkIRm1Ff/l0zFyoIKpOBVHVKRs6Omoli4=;
        b=kcsWADMSE5kRCS1kpGlgtsuLoAOLm30Szc3aN8KHEds9DpgSs5pcu0arO3Qo9dCg2r
         830bup+F8eFKi7Gm4jBFykQwhbUXB/VUWh63lye1ktsWu8L6xK943G7PHVnQfcYY2pbD
         6C28e9XR5ItnyQAEL+n4/s3Q9ZsyypXtvi2YnoeHlrR1SfpXW5Fq1Birb9zYx/hlEh+f
         B9VpjkUVNfWybNBZZUq/FPqKv7qgDBKGxvCsNpv3luA/xbTNCc2+vxwLTkfKmZA5KxgJ
         zTosaoRq+MZ9YMszhiAeFCceONqjB5cMto5xrixBnRCZY7adR1qyOLAI0uUAAb8ophs1
         GH4g==
X-Gm-Message-State: AOAM5329RVW4Zxkwmet3vYqCyr7qV+u/0J01SCDTP0Lz9v+nrYxGHbxu
        w00trWKpSoTgJQL8bhUGk0D97+GmH0wq29tgEU2GJIA9
X-Google-Smtp-Source: ABdhPJwq0DQ+cVnDy0yMIAJMQ93V9TBsQfWJ9ame0jH1lzHPT5zrQC4IpdqlLzgIPaf836DrKffZlg7nCtLUZCdVgn8=
X-Received: by 2002:a17:907:7da8:: with SMTP id oz40mr24410486ejc.328.1643904593725;
 Thu, 03 Feb 2022 08:09:53 -0800 (PST)
MIME-Version: 1.0
References: <pull.1122.v2.git.1643479633.gitgitgadget@gmail.com>
 <pull.1122.v3.git.1643787281.gitgitgadget@gmail.com> <04c3bdc44d2c76ffc82a95db3ca4fd07270f94cf.1643787281.git.gitgitgadget@gmail.com>
 <220203.86ee4k7lo8.gmgdl@evledraar.gmail.com> <CABPp-BHye_Zyw=x8B+QoSxWA1b0xyVL9==7kA4CD0q3eTrk8cQ@mail.gmail.com>
 <220203.86o83o5jr2.gmgdl@evledraar.gmail.com>
In-Reply-To: <220203.86o83o5jr2.gmgdl@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 3 Feb 2022 08:09:42 -0800
Message-ID: <CABPp-BEKuXHELVx4=5JJTj5HVOKZ=Y-4G4BK47BCZYYRSrkFsQ@mail.gmail.com>
Subject: Re: [PATCH v3 08/15] merge-ort: allow update messages to be written
 to different file stream
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 3, 2022 at 2:26 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
> On Thu, Feb 03 2022, Elijah Newren wrote:
>
> > On Wed, Feb 2, 2022 at 6:01 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <=
avarab@gmail.com> wrote:
[...]
> >> I would get it if the point was to actually use the full usage.c
> >> machinery, but we're just either calling warning(), or printing a
> >> formatted string to a file FILE *. There's no need to go through usage=
.c
> >> for that, and adding an API to it that behaves like this new
> >> warning_fp() is really confusing.
> >
> > Because the formatted string being printed to the file won't have the
> > same "warning: " prefix that is normally added to stuff in usage?
>
> But the pre-image doesn't add that either. We're just calling
> vfprintf(), not our own vreportf().

Right, I'm saying that I thought you were reporting the original patch
as buggy because it doesn't produce the same message when given a
different stream; it'll omit the "warning: " prefix.  And I was
agreeing that it was buggy for those reasons.

Or was there a different reason you didn't like that function being in usag=
e.c?

> > That's a fair point; that does have a bit of a consistency problem.
> > And I'd rather the messages were consistent regardless of where they
> > are printed.
>
> I think that makes sense, that's why I added die_message() recently. If
> you meant to print a "warning: " prefix I think it would also be fine in
> this case to just do it inline. See prior art at:
>
>     git grep '"(fatal|error|warning):' -- '*.c'

So, making diff_warn_rename_limit() stop using warning(), and just
always directly writing out and including "warning:" in its message?

I'm wondering if that might cause problems if there are any existing
callers of diff_warn_rename_limit() that might also be using
set_warn_routine() (e.g. perhaps apply.c?).  Of course, those callers
probably couldn't handle anything other than the default stream.
Hmm...

> >> diff --git a/diff.c b/diff.c
> >> index 28368110147..4cf67e93dea 100644
> >> --- a/diff.c
> >> +++ b/diff.c
> >> @@ -6377,14 +6377,21 @@ static const char rename_limit_advice[] =3D
> >>  N_("you may want to set your %s variable to at least "
> >>     "%d and retry the command.");
> >>
> >> +#define warning_fp(out, fmt, ...) do { \
> >> +       if (out =3D=3D stderr) \
> >> +               warning(fmt, __VA_ARGS__); \
> >> +       else \
> >> +               fprintf(out, fmt, __VA_ARGS__); \
> >> +} while (0)
> >> +
> >>  void diff_warn_rename_limit(const char *varname, int needed, int degr=
aded_cc,
> >>                             FILE *out)
> >>  {
> >>         fflush(stdout);
> >>         if (degraded_cc)
> >> -               warning_fp(out, _(degrade_cc_to_c_warning));
> >> +               warning_fp(out, _(degrade_cc_to_c_warning), NULL);
> >>         else if (needed)
> >> -               warning_fp(out, _(rename_limit_warning));
> >> +               warning_fp(out, _(rename_limit_warning), NULL);
> >
> > Why do the only callers have a NULL parameter here?  Is this one of
> > those va_list/va_args things I never bothered to properly learn?
>
> That's wrong (I blame tiredness last night),an actual working version is
> produced below. Clang accepted my broken code, but gcc rightly yells
> about it:

Well, seeing the new code makes me feel better as it makes more sense
to me now.  ;-)

> Note that both your pre-image, my macro version and Johannes's
> linked-to-above are technically buggy in that they treat a
> non-formatting format as a formatting format. I.e. we should use
> warning("%s", msg) in that case, not warning(msg).
>
> See 927dc330705 (advice.h: add missing __attribute__((format)) & fix
> usage, 2021-07-13) for a similar bug/fix.

Good point.


Man, what a can of worms this all is.  Maybe I really should just drop
patches 5, 6, and 8 for now...
