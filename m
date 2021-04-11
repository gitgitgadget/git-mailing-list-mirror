Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA1D7C433ED
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 20:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8D6F61028
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 20:22:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236537AbhDKUWR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Apr 2021 16:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235486AbhDKUWR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Apr 2021 16:22:17 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1905AC061574
        for <git@vger.kernel.org>; Sun, 11 Apr 2021 13:22:00 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id n2so16832996ejy.7
        for <git@vger.kernel.org>; Sun, 11 Apr 2021 13:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=c79cCEDw7RQOI/mFh1WLbCOcQsz7eTFJx0zf54Z2rNA=;
        b=lYX/lkwJL66FPMWl9PIdQKc/ijl8oEct99p7stu8r9A5WHuKLBhMx2v8cQHMH0SJTj
         RJx4JeMe2/cnnqoU0fsoQQEAcxksum5o2NXtjaEAN9hep6/9gXWGi8FU8kHE/u6eNhOJ
         WOZS0TX2qk4/qIxL2QtidzBPxlVz0Ad7jPaAoZ1xgiittFLHBAjQCUEYjZG/lQZ42V+w
         l17H3/GnTpq7J2hXeAX0omtKgfmn00A/rG1MX9O2mPVr/wHvAyKppqTyf3JAmdqINHeE
         RQBlqeyBTNs6JqmEj24srvHMcBTJ6QpkJpor6zt3qiMy6+LFpGrPjpX/ESO8hgECo+mn
         amWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=c79cCEDw7RQOI/mFh1WLbCOcQsz7eTFJx0zf54Z2rNA=;
        b=MzQ2JU0o6A5hKcLsrubdjxllVdqFQKkVuxyVVT6i83cnWvM6L2iMyfbSqeDZu7Z6mM
         ZsOE9sOWp8r6sJ56QDoQzx6IcmLLIZpUw+7vpVou+s2qX3lQp9S4jo/Jh85SaC+VfK2I
         /SDA2MCOk/FxBZ7rCp/hOvd/mQk5DrK3wxOtDy3vbeZjq6HI0qhmsh8mQzOo18JZ8sfy
         dFnbn+Ipvz+jpXrHUeAej9aEJ26m49AbOfLhkZ7tC/DFZj7W3HR38PFZCWLAld1jL8Ja
         qO5yos5NMoXnQ6OEHO29Js8n60RS4MRjtkhuwZNtw/nRSzDy3NP2jINRC9DZ9WAITXGK
         tM/A==
X-Gm-Message-State: AOAM531gu35Sbq1wNgdL/ODglNYMvdunQL2rd7Kkp1OPbnREijn9Aw7W
        8dDE4USxACCo/ur7s79mjePY3gb0b+I3OUjAJr8BvvMGIHA=
X-Google-Smtp-Source: ABdhPJwYJc8BX1HDjZ+LJMfQi1TWrYPh6NAI4YqgHiFZNVDq4hJp65kEECJHuVGEeZb29JTFXpCTG36hd4mAI5pBxqs=
X-Received: by 2002:a17:906:c348:: with SMTP id ci8mr5499942ejb.303.1618172518577;
 Sun, 11 Apr 2021 13:21:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAKu1iLXtwuCQTS0s7_LEm0OJF-4s0UhPhDW1r5Zb7=GsSPfpdQ@mail.gmail.com>
 <20210409153815.7joohvmlnh6itczc@tb-raspi4> <CAKu1iLX1AyTCSGxDVgiR1cr4=4ODD-gn8jHAinhp7OhDChAf1A@mail.gmail.com>
 <20210411093746.ymqofe2uawclwu5i@tb-raspi4>
In-Reply-To: <20210411093746.ymqofe2uawclwu5i@tb-raspi4>
From:   Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>
Date:   Sun, 11 Apr 2021 13:21:47 -0700
Message-ID: <CAKu1iLUNooP+FDMJKekH4b2Cq5BhFZwAb=d28iPv55C5+cQbCg@mail.gmail.com>
Subject: Re: git-p4 crashes on non UTF-8 output from p4
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for your excellent and friendly feedback!

I understand everything you said, but I have a question about the unit
test you requested.  The git-p4.py script currently does not have
tests and is not written in a way that would be testable.  (The Python
function I modified calls into the shell and requires a valid Perforce
installation.)

Would you prefer I  a) refactor the code to be testable and then write
tests  or b) skip the unit testing (not sure if there are any further
options)?

(For option a) I would break out the part of the function I modified
into another function and then call my new function for my testing.
(I guess it would be better to break the refactoring and my changes
into 2 separate commits.)

On Sun, Apr 11, 2021 at 2:37 AM Torsten B=C3=B6gershausen <tboegi@web.de> w=
rote:
>
> On Sun, Apr 11, 2021 at 12:16:25AM -0700, Tzadik Vanderhoof wrote:
> > Here is the pull request:
>
> Thanks for the work. Some comments inline.
>
> >
> > From 8d234af842223dceae76ce0affd3bbb3f17bb6d9 Mon Sep 17 00:00:00 2001
> > From: Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>
> > Date: Sat, 10 Apr 2021 22:41:39 -0700
>
>
> The subject should be one short line, highlighting what this is all about=
,
> followed by a blank line and a longer description about the problem and
> the solution. The original description was good, see below.
>
> > Subject: [PATCH] add git-p4.fallbackEncoding config variable, to preven=
t
> >  git-p4 from crashing on non UTF-8 changeset descriptions
>
> In that sense I make a first trial here, subject for improvements:
>
>
> Subject: [PATCH] Add git-p4.fallbackEncoding config variable
>
> When git-p4 reads the output from a p4 command, it assumes it will be
> 100% UTF-8. If even one character in the output of one p4 command is
> not UTF-8, git-p4 crashes e.g. with:
>
> File "C:/Program Files/Git/bin/git-p4.py", line 774, in p4CmdList
>     value =3D value.decode() UnicodeDecodeError: 'utf-8' codec can't
> decode byte Ox93 in position 42: invalid start byte
>
> Allow to try another encoding (eg cp1252) and/or use the
> Unicode replacement character  to prevent the whole program from crashing
> on such a "minor" problem.
>
> This is especially a problem on the "git p4 clone" command with @all,
> where git-p4 needs to read thousands of changeset descriptions, one of
> which may have a stray smart quote, causing the whole clone operation
> to fail.
>
> Introduce "git-p4.fallbackEncoding" to handle non UTF-8 encodings, if nee=
ded.
>
> >
> > ---
> >  Documentation/git-p4.txt | 10 ++++++++++
> >  git-p4.py                | 11 ++++++++++-
> >  2 files changed, 20 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
> > index f89e68b..71f3487 100644
> > --- a/Documentation/git-p4.txt
> > +++ b/Documentation/git-p4.txt
> > @@ -638,6 +638,16 @@ git-p4.pathEncoding::
> >   to transcode the paths to UTF-8. As an example, Perforce on Windows
> >   often uses "cp1252" to encode path names.
> >
> > +git-p4.fallbackEncoding::
> > +    Perforce changeset descriptions can be in a mixture of encodings. =
Git-p4
> > +    first tries to interpret each description as UTF-8. If that fails,=
 this
> > +    config allows another encoding to be tried.  The default is "cp125=
2".  You
>
> I know that cp1252 is attractive to be used, especially for Windows insta=
llations that
> use Latin-based "characters".
> But: If we introduce a new config-variable into Git, the default tends to=
 be
> "if not set to anything, behave as the old Git".
>
> > +    can set it to another encoding, for example, "iso-8859-5". If inst=
ead of
> ISO-8859-5 may be more portable on the different i18 implementations
> than the lower-case spelling.
>
> > +    an encoding, you specify "replace", UTF-8 will be used, with inval=
id UTF-8
> > +    characters replaced by the Unicode replacement character. If you s=
pecify
> > +    "none", there is no fallback, and any non UTF-8 character will cau=
se
> > +    git-p4 to immediately fail.
>
> As said, before, many people may expect Git to fail, so that the default =
should be
> none to avoid surprises.
> When a "non-UTF-8-clean" repo is handled, they want to know it.
>
> > +
> >  git-p4.largeFileSystem::
> >   Specify the system that is used for large (binary) files. Please note
> >   that large file systems do not support the 'git p4 submit' command.
> > diff --git a/git-p4.py b/git-p4.py
> > index 09c9e93..18d02b4 100755
> > --- a/git-p4.py
> > +++ b/git-p4.py
> > @@ -771,7 +771,16 @@ def p4CmdList(cmd, stdin=3DNone, stdin_mode=3D'w+b=
',
> > cb=3DNone, skip_info=3DFalse,
> >                  for key, value in entry.items():
> >                      key =3D key.decode()
> >                      if isinstance(value, bytes) and not (key in
> > ('data', 'path', 'clientFile') or key.startswith('depotFile')):
> > -                        value =3D value.decode()
> > +                        try:
> > +                            value =3D value.decode()
> > +                        except:
> > +                            fallbackEncoding =3D
> > gitConfig("git-p4.fallbackEncoding").lower() or 'cp1252'
> > +                            if fallbackEncoding =3D=3D 'none':
> > +                                raise
>
> Would it make sense to tell the user about the new config value here?
>  raise Exception("Non UTF-8 detected. See git-p4.fallbackEncoding"
> Or somewhat in that style ?
>
> > +                            elif fallbackEncoding =3D=3D 'replace':
> > +                                value =3D value.decode(errors=3D'repla=
ce')
> > +                            else:
> > +                                value =3D value.decode(encoding=3Dfall=
backEncoding)
> >                      decoded_entry[key] =3D value
> >                  # Parse out data if it's an error response
> >                  if decoded_entry.get('code') =3D=3D 'error' and 'data'=
 in
> > decoded_entry:
>
>
> Did I miss the Signed-off-by here?
>
> Please have a look here:
> https://git-scm.com/docs/SubmittingPatches
>
> (or look at Documentation/SubmittingPatches in your git source code)
>
> And finally: Thanks for the contribution.
> Is there any chance to add test-cases, to make sure that this feature
> is well-tested now and in the future ?
>
>
> > --
> > 2.31.1.windows.1
> >
> > On Fri, Apr 9, 2021 at 8:38 AM Torsten B=C3=B6gershausen <tboegi@web.de=
> wrote:
> > >
> > > On Thu, Apr 08, 2021 at 12:28:25PM -0700, Tzadik Vanderhoof wrote:
> > > > When git-p4 reads the output from a p4 command, it assumes it will =
be
> > > > 100% UTF-8. If even one character in the output of one p4 command i=
s
> > > > not UTF-8, git-p4 crashes with:
> > > >
> > > > File "C:/Program Files/Git/bin/git-p4.py", line 774, in p4CmdList
> > > >     value =3D value.decode() UnicodeDecodeError: 'utf-8' codec can'=
t
> > > > decode byte Ox93 in position 42: invalid start byte
> > > >
> > > > I'd like to make a pull request to have it try another encoding (eg
> > > > cp1252) and/or use the Unicode replacement character, to prevent th=
e
> > > > whole program from crashing on such a minor problem.
> > > >
> > > > This is especially a problem on the "git p4 clone" command with @al=
l,
> > > > where git-p4 needs to read thousands of changeset descriptions, one=
 of
> > > > which may have a stray smart quote, causing the whole clone operati=
on
> > > > to fail.
> > > >
> > > > Sound ok?
> > >
> > > Welcome to the Git community.
> > > To start with: I am not a git-p4 expert as such, but seeing that a pr=
ogram is crashing
> > > is never a good thing.
> > > All efforts to prevent the crash are a step forward.
> > >
> > > As you mention cp1252 (which is more used under Windows), there are p=
robably lots of
> > > system out there which use ISO-8859-15 (or ISO-8859-1) we may have th=
e first whish:
> > >
> > > Make the encoding/fallback configurable.
> > > Let people choose if they want a crash (if things are broken),
> > > fallback to cp1252 or one of the other ISO-ISO-8859-x encodings.
> > >
> > > In that sense: we look forward to a pull-request.
> >
> >
> >
> > --
> > Tzadik



--=20
Tzadik
