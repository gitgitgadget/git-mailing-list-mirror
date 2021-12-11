Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 731C1C433EF
	for <git@archiver.kernel.org>; Sat, 11 Dec 2021 21:00:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbhLKVAo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Dec 2021 16:00:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbhLKVAn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Dec 2021 16:00:43 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD12C061714
        for <git@vger.kernel.org>; Sat, 11 Dec 2021 13:00:43 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id e3so40991470edu.4
        for <git@vger.kernel.org>; Sat, 11 Dec 2021 13:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=G9It4pci5OPu6vrRi9TzckzvEJanL3B64JPlf1p/atg=;
        b=hKhhBSoe+j6cyvXiSBohdUaiblGOlQVoDuFWSYnM054Ucr2+1P0vcGc5E8j/TgjEaW
         U5WjRdjk50Yhz5h9DlkH0uJVvg4fHQyHaI5/Fty52BNg40CSdQRElKrJ1TYBBtFeZ487
         gqsyn0bx6EXwDvMoL58ZS7teb+QeGujA+eKF6F1gJ1fFMqnG+KsBusPOUFz3JhovBJX+
         9xbWqCwhNvftiXMceWbqVQS1hZfA6qPQbb6wfDFFfcdf+17hiYjCjhqO0hhUsJ4mnhMy
         3Wrw+uJY+0UYIAVsDbIqH1Qu9Nii2yIy2fG7RsgJ0LoeuGe3WzyM1QrOOLi+xs3D5kU4
         DcGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=G9It4pci5OPu6vrRi9TzckzvEJanL3B64JPlf1p/atg=;
        b=pDMOfm3t+HxccvjYT8w9j4wJU7T7i+DUDjfW1+A2CzfXq3NepcfbNntdX0VIMTeErZ
         O0ynBdQL2oeB3N7uydGv8uVtTi/Y/jtKd2FkT9P37QA9cidPvnQ6VnPjSLrJFetoavKg
         80luu9kj4PC7D4yFfeYQwGhl8MvwWb//nY+WHzBaHE8vRW10b/R52bl1KgcPVI0O65ub
         O0Q053ul0W+KNtBO5gYa9dPGjTtk6mGmyygN7Q9h8f3emmLwlU8MX2jMIws5XkbWnekY
         2S4GnR3HIbYXW+AmOeqDVFmYM8N7GzHKz6oEKQYeSGI0Os9i+20stIAeFwXIr6QxLxPU
         Q68Q==
X-Gm-Message-State: AOAM532ZWQfIZIliNsRCAI6owDprsH/iyOmd0jbwKdqaKEy3oPFOfgwA
        SdPZaoEXo3cd+079wWa2R81hkrfw81B7XhwJBPw=
X-Google-Smtp-Source: ABdhPJzBbAj/dVor6RiC8FeEIAnEYPjTStOVewRUwX5hlC1sB81rhYAAlzZz5iRnxWM7bps3mAuvtRWn85R0V7mj7Y8=
X-Received: by 2002:a17:906:3ce9:: with SMTP id d9mr32735659ejh.172.1639256441385;
 Sat, 11 Dec 2021 13:00:41 -0800 (PST)
MIME-Version: 1.0
References: <20211209201029.136886-1-jholdsworth@nvidia.com>
 <211210.86r1ale0o0.gmgdl@evledraar.gmail.com> <xmqqsfv0m9f5.fsf@gitster.g>
In-Reply-To: <xmqqsfv0m9f5.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 11 Dec 2021 13:00:30 -0800
Message-ID: <CABPp-BHjc1i4o-Oe2U2fV8_TRgRPfve_mYt=kveTYMy-3BdpCA@mail.gmail.com>
Subject: Re: [PATCH 0/6] Transition git-p4.py to support Python 3 only
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Joel Holdsworth <jholdsworth@nvidia.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, Dec 10, 2021 at 10:07 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
> > On Thu, Dec 09 2021, Joel Holdsworth wrote:
> >
> >> Python 2 was discontinued in 2020, and there is no longer any official=
ly
> >> supported interpreter. Further development of git-p4.py will require
> >> would-be developers to test their changes with all supported dialects =
of
> >> the language. However, if there is no longer any supported runtime
> >> environment available, this places an unreasonable burden on the Git
> >> project to maintain support for an obselete dialect of the language.
> >
> > Does it? I can still install Python 2.7 on Debian, presumably other OS'=
s
> > have similar ways to easily test it.
>
> Yes, that is a good point to make against "we cannot maintain the
> half meant to cater to Python2 of the script".  Developers should be
> able to keep and test Python2 support, if it is necessary.

I also disagree with the reason Joel gave in the quoted paragraph for
dropping Python2 support, but I think there are other good reasons to
drop it.

> So the more important question is if there are end-users that have
> no choice but sticking to Python2.  Is there distributions and
> systems that do not offer Python3, on which end-users have happily
> been using Python2?  If some users with vendor supported Python2 do
> not have access to Python3, cutting them off may be premature.

These are good questions, though I think there's more to it than this,
as I'll mention in just a minute...

> As the general direction, I do not mind deprecating support for
> Python2, and then eventually removing it.  I just do not know if 2
> years is long enough for the latter (IIRC, the sunset happened at
> the beginning of 2020, and we are about to end 2021).

Python2 was deprecated by the python project in 2008, with announced
plans to stop all support (including security fixes) in 2015.  They
pushed the sunset date back to Jan 1, 2020.  So it has only been
end-of-life for just under 2 years, but it's been deprecated for over
13 years.

In regards to your good questions about Python3 availability on some
platforms: If such platforms exist, they have had over a decade's
heads up...so let's ask a few extra questions.  If these platforms
still haven't made python3 available, would newer versions of Git even
be available on these platforms?  Even if newer Git versions are
available, would users on such platforms have any qualms with using an
older Git version given the platform insistence of only providing an
old Python version lacking any support (even security fixes)?


Some of my personal python2/python3 experience, if it's useful in
weighing decisions:

* There are python projects for which I still continue to support
simultaneous python2 and python3 usage, though for projects that are
smaller then git-p4.py (e.g. 1/2 to 1/3 the size).  Such multi-version
support is painful, and it causes occasional bugs that hit users that
wouldn't arise if there was only one supported python version.

* I initially wanted to also do the multi-version support for
git-filter-repo (which is approximately the same size as git-p4.py,
and obviously also interfaces with git somewhat deeply).  I gave up on
it, and didn't consider it justified, especially with the
then-soon-impending End-Of-Life for python2.  I instead just switched
from python2 -> python3 (in 2019; yes, I'm a straggler.)  Granted, I
did benefit from the fact that git-filter-repo is a
once-in-a-blue-moon usage tool (and only by one member on the team),
rather than a daily usage tool, but I may have come to the same
decision anyway even back then.

* (Slight tangent) I tried to use unicode strings everywhere in
git-filter-repo a few times, but invariably found it to be buggy and
slow.  It was a mistake, and I eventually switched over to bytestrings
everywhere, only converting to unicode (when possible) when printing
messages for the user on the console.  bytestrings are ugly to use
(IMO), but they're a better data model when dealing with file
contents, process output, filenames, etc.  I think git-p4's decision
to attempt to use unicode strings everywhere is a mistake that'll
probably result in bugs based on that experience of mine; it's not an
appropriate model of the relevant data.  It'll also make things
slower.

[I actually think the unicode vs. bytestring thing might be more
important for bug fixing than limiting to python3.  Though I think
both are worthwhile.]
