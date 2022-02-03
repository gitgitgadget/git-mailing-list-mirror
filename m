Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24538C433F5
	for <git@archiver.kernel.org>; Thu,  3 Feb 2022 17:00:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352488AbiBCRAg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 12:00:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352482AbiBCRAf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 12:00:35 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E18C061714
        for <git@vger.kernel.org>; Thu,  3 Feb 2022 09:00:35 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id me13so10720167ejb.12
        for <git@vger.kernel.org>; Thu, 03 Feb 2022 09:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=irgKnP4XQpO53PmGEgxka1+h6T6wAbIlOCwFq8z2KsY=;
        b=PASRMjYaa3nkkDLk0PhOLth7pfoqJ5Pwiv6C5lx9UZ9gKRvkj7ql5T9BTn3cA4EMSK
         lYunQ1TveRXoXCgP4p2it58nHo44BdsXSBS8oehm7tFRwNAf+9EFFakITcAoD7ZnED2C
         T9dB/xAZiLtAi9QdXPH73uBVKJ14voTVH5ZMdKX8Le7rdj801oHY7KWla0vbN+CGn/CP
         uIKqeeUU+2l8DstY28G5SE6wJlWIXdPu9bRuME5tgEW5KcqovWOcsHm+7DXzqYPQWc2V
         patMDF9krtJ78QckiXX+J/mdCUWEiqsi7bDStWGZzYUz/IKYrp9KFqscz5smVjQr5Ind
         1Z/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=irgKnP4XQpO53PmGEgxka1+h6T6wAbIlOCwFq8z2KsY=;
        b=KZ+jsvi95cZbImsAgPfHHyaCMS4uwOEb4erZJ9qWJxGV5+fldlDDeP3O4ITTA8IInZ
         /IQl+yG+phYQcpBJvK10126ar6x7spX73JrL/JR+EHqHQbeufYVuEq0I511NXX0tUL+4
         kYjIFG9DitFLIvWBvGO5aU2NKOzzEotywJ5zzSEW6HbLWUcDwyqoEVIiOt3ij/jTAmOR
         XdfC1ed/obUE/bJ0iVBJKDohFtL1Jni66j21unh4caQLzmYh7mjTC8kmWaGTvOrV7til
         u04M8OihGl2YcaL4AiAnjwxgsiJnTVUThXnAJ/eGwWKM8a5npXqVchndGZ+BSfedw9Pq
         By6Q==
X-Gm-Message-State: AOAM530dt5IwByVY26CZj9i97jaljn6bjVwXTyY0w87Nm/KGDsCrbD3g
        u8tW3AQhdYGHmYqd1S2WCTTjCmpiTVEjf1YZMcA=
X-Google-Smtp-Source: ABdhPJxdgiPM1uM1k+hjmIj3pmKr+avh64FIHvsMLVLy3A5iQkpz/4t7m1aApPG2lWfSuK3DEnbWL2aPhFFIxh0HkEQ=
X-Received: by 2002:a17:906:4c47:: with SMTP id d7mr23231085ejw.192.1643907633792;
 Thu, 03 Feb 2022 09:00:33 -0800 (PST)
MIME-Version: 1.0
References: <pull.1122.v2.git.1643479633.gitgitgadget@gmail.com>
 <pull.1122.v3.git.1643787281.gitgitgadget@gmail.com> <04c3bdc44d2c76ffc82a95db3ca4fd07270f94cf.1643787281.git.gitgitgadget@gmail.com>
 <220203.86ee4k7lo8.gmgdl@evledraar.gmail.com> <CABPp-BHye_Zyw=x8B+QoSxWA1b0xyVL9==7kA4CD0q3eTrk8cQ@mail.gmail.com>
 <220203.86o83o5jr2.gmgdl@evledraar.gmail.com> <CABPp-BEKuXHELVx4=5JJTj5HVOKZ=Y-4G4BK47BCZYYRSrkFsQ@mail.gmail.com>
 <220203.86fsoz6hr3.gmgdl@evledraar.gmail.com>
In-Reply-To: <220203.86fsoz6hr3.gmgdl@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 3 Feb 2022 09:00:22 -0800
Message-ID: <CABPp-BFFcFxWL+FRSf9ANwHU1mp_oWcsfLOwvBAuv-J3oNh3SA@mail.gmail.com>
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

On Thu, Feb 3, 2022 at 8:24 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
> On Thu, Feb 03 2022, Elijah Newren wrote:
>
> > On Thu, Feb 3, 2022 at 2:26 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <=
avarab@gmail.com> wrote:
> >>
> >> On Thu, Feb 03 2022, Elijah Newren wrote:
> >>
> >> > On Wed, Feb 2, 2022 at 6:01 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmaso=
n <avarab@gmail.com> wrote:
> > [...]
> >> >> I would get it if the point was to actually use the full usage.c
> >> >> machinery, but we're just either calling warning(), or printing a
> >> >> formatted string to a file FILE *. There's no need to go through us=
age.c
> >> >> for that, and adding an API to it that behaves like this new
> >> >> warning_fp() is really confusing.
> >> >
> >> > Because the formatted string being printed to the file won't have th=
e
> >> > same "warning: " prefix that is normally added to stuff in usage?
> >>
> >> But the pre-image doesn't add that either. We're just calling
> >> vfprintf(), not our own vreportf().
> >
> > Right, I'm saying that I thought you were reporting the original patch
> > as buggy because it doesn't produce the same message when given a
> > different stream; it'll omit the "warning: " prefix.  And I was
> > agreeing that it was buggy for those reasons.
> >
> > Or was there a different reason you didn't like that function being in =
usage.c?
>
> Maybe it was accidentally a bug report :) But no, I was just observing
> that it was odd that it was in usage.c when it seemingly had almost
> nothing to do with what that API accomplishes.
>
> But maybe the underlying issue is that the "warning: " part is missing
> here. But I didn't mean to report that/missed it.
>
> >> > That's a fair point; that does have a bit of a consistency problem.
> >> > And I'd rather the messages were consistent regardless of where they
> >> > are printed.
> >>
> >> I think that makes sense, that's why I added die_message() recently. I=
f
> >> you meant to print a "warning: " prefix I think it would also be fine =
in
> >> this case to just do it inline. See prior art at:
> >>
> >>     git grep '"(fatal|error|warning):' -- '*.c'
> >
> > So, making diff_warn_rename_limit() stop using warning(), and just
> > always directly writing out and including "warning:" in its message?
> >
> > I'm wondering if that might cause problems if there are any existing
> > callers of diff_warn_rename_limit() that might also be using
> > set_warn_routine() (e.g. perhaps apply.c?).  Of course, those callers
> > probably couldn't handle anything other than the default stream.
> > Hmm...
>
> Using set_warn_routine() is the "right" way to do it currently, and with
> or without a "warning: " prefix the current API use is "wrong" if the
> purpose is to have it behave nicely with the pluggable usage.c API.
>
> But of course that may not be the goal at all, i.e. I think here we've
> probably stopped caring about usage.c's formatting, logging
> etc. entirely, and are just emitting a string.
>
> Just like serve.c emits "E <msg>" or whatever (and not with error()).
>
> >> >> diff --git a/diff.c b/diff.c
> >> >> index 28368110147..4cf67e93dea 100644
> >> >> --- a/diff.c
> >> >> +++ b/diff.c
> >> >> @@ -6377,14 +6377,21 @@ static const char rename_limit_advice[] =3D
> >> >>  N_("you may want to set your %s variable to at least "
> >> >>     "%d and retry the command.");
> >> >>
> >> >> +#define warning_fp(out, fmt, ...) do { \
> >> >> +       if (out =3D=3D stderr) \
> >> >> +               warning(fmt, __VA_ARGS__); \
> >> >> +       else \
> >> >> +               fprintf(out, fmt, __VA_ARGS__); \
> >> >> +} while (0)
> >> >> +
> >> >>  void diff_warn_rename_limit(const char *varname, int needed, int d=
egraded_cc,
> >> >>                             FILE *out)
> >> >>  {
> >> >>         fflush(stdout);
> >> >>         if (degraded_cc)
> >> >> -               warning_fp(out, _(degrade_cc_to_c_warning));
> >> >> +               warning_fp(out, _(degrade_cc_to_c_warning), NULL);
> >> >>         else if (needed)
> >> >> -               warning_fp(out, _(rename_limit_warning));
> >> >> +               warning_fp(out, _(rename_limit_warning), NULL);
> >> >
> >> > Why do the only callers have a NULL parameter here?  Is this one of
> >> > those va_list/va_args things I never bothered to properly learn?
> >>
> >> That's wrong (I blame tiredness last night),an actual working version =
is
> >> produced below. Clang accepted my broken code, but gcc rightly yells
> >> about it:
> >
> > Well, seeing the new code makes me feel better as it makes more sense
> > to me now.  ;-)
> >
> >> Note that both your pre-image, my macro version and Johannes's
> >> linked-to-above are technically buggy in that they treat a
> >> non-formatting format as a formatting format. I.e. we should use
> >> warning("%s", msg) in that case, not warning(msg).
> >>
> >> See 927dc330705 (advice.h: add missing __attribute__((format)) & fix
> >> usage, 2021-07-13) for a similar bug/fix.
> >
> > Good point.
> >
> > Man, what a can of worms this all is.  Maybe I really should just drop
> > patches 5, 6, and 8 for now...
>
> Yeah, I really think it's worth it to just sprinkle a tiny bit of
> if/else (or a macro) here and print to stderr inline or not. We can make
> some use of some usage.c when there's good reason to do so, but this bit
> just seems like a needless digression.
>
> I hope all of this has helped somewhat ...

Absolutely; thanks for reviewing!  These parts may just end up in me
dropping some patches for now (since they're not actually being used
anyway), but I think it's all good feedback.
