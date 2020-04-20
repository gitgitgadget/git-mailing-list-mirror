Return-Path: <SRS0=xG8z=6E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB38C3815B
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 17:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7235B20CC7
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 17:24:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rch9dn4g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbgDTRYy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Apr 2020 13:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725773AbgDTRYy (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Apr 2020 13:24:54 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1561BC061A0C
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 10:24:54 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id z25so5344725otq.13
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 10:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zzMYpConqZAkHV5D9PBVBIABf2UPiJ8D5vlABbz2N+M=;
        b=Rch9dn4gXAYPOb3Wmr1QEE9ju0v2ifECYadQRdk+CuY+kLq25bKwtQ5rCV//Dvud1n
         GIpq/6a2wm/x3St3IHIaqPpEWUOyHl9qCoaIp4A+eagKN8kJKwN5Vjfew6l+xtPDwQ6Q
         RIaMLLmM5Kf4Wy5GWAsvTfqJ4BfwjlYgEi3IyWRqqEiv7b0lORqoA9tOzayk0WDjQO5s
         XUNdwbVjLQMUY4sVLXNqanSeoCvY5RBYU6gHdh8x0cgKsM9FkrPVVXRxeHfQTGo+kh/u
         7XV/R054AxaqAMbsZHoX0KxhNz9uAUGyer5B/5imV0664aTd3BcdQ7+pvA2/TF0ZB/5n
         xVcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zzMYpConqZAkHV5D9PBVBIABf2UPiJ8D5vlABbz2N+M=;
        b=H+Qu23sIt5SjHJPEkfiwoa91zYnhML0ZhHSkzATqmqJ1Bc7KrId0zJl9TMrhXgkXJI
         6n4fnOcFviScHsK8CPxMl2gQx2NG05gaaH17XpC5eMTIb3AIc0IKiQkmC+/bKYTfvmlU
         Dx6pr7MfLpz042kCmQj4LVnDcsKwfn6MzG3p7hglCfz77lCalPP4dPb77OGXm7a1OhCw
         wmZYWqOkz8ivdZ4wrFqviBGN3FkdM/j30xb7sMjp/Min626OAXv1eso5bzaUxo67wdEF
         MXy2SittQFaQGPYbVkFK1AwW6iQwXwroPrfDOEs0oRBVnBKM5Mcl9IYsikCFct56U6mC
         0WRQ==
X-Gm-Message-State: AGi0PuY/vKp3zTvKAybLR2VjUMX5q6aQrJPtYjR2oqEczAw2iYxmr+96
        q7JQsSnY0fXCGTohc86fIT+p91gJ18wKsLONQKOaljM4
X-Google-Smtp-Source: APiQypI6CHUdNQxD8zvi2nIIk4aASrGxVV7R6ghx8UubYoRgf/hHTy0gCv0zsqu1UvcHrO9HODGWcmdgoTwhK6V2VKY=
X-Received: by 2002:a05:6830:1ae3:: with SMTP id c3mr7136023otd.345.1587403493186;
 Mon, 20 Apr 2020 10:24:53 -0700 (PDT)
MIME-Version: 1.0
References: <AM0PR02MB371559B3C5445A3C9D39821B9CD40@AM0PR02MB3715.eurprd02.prod.outlook.com>
 <CABPp-BGis7wswAjwgTa84m-TsQznrQWQJVJZW0_MyN9ieFMzeA@mail.gmail.com>
In-Reply-To: <CABPp-BGis7wswAjwgTa84m-TsQznrQWQJVJZW0_MyN9ieFMzeA@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 20 Apr 2020 10:24:42 -0700
Message-ID: <CABPp-BHjF4AJdTrdqxvgsZq+UBZd06upFOHEx-8eQ8qKO-CtkA@mail.gmail.com>
Subject: Re: git-filter-repo For Windows (possibly a request for a bash for
 Windows primer)
To:     "Kerry, Richard" <richard.kerry@atos.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 20, 2020 at 9:53 AM Elijah Newren <newren@gmail.com> wrote:
>
> On Mon, Apr 20, 2020 at 8:11 AM Kerry, Richard <richard.kerry@atos.net> w=
rote:
> >
> >
> > This follows my earlier query for which the answer was "use git-filter-=
repo".
> > I've cloned git-filter-repo from GitHub, and I've installed the latest =
Python (version 3.8).  I'm working on Windows.  Windows 10 if it makes any =
difference, so git is Git For Windows.
> > The first instruction for git-filter-repo is to copy it into the "--exe=
c-path" of git.  That fails, saying Access is Denied.  So leaving aside the=
 option to change the permissions I've followed the second half of the sent=
ence and added my git-filter-repo location to my Path (or PATH if it's in b=
ash).  Now running "get filter-repo" gives:
> > /usr/bin/env: 'python3.exe': No such file or directory
> >
> > My python executable is called python3.exe.  There is a note in the git=
-filter-repo project about certain Windows installations where it isn't cal=
led python3, but that now raises in my mind the question of whether I need =
to tweak git-filter-repo to look for "python3.exe" rather than just "python=
3".  Or can I take it that the Windows version of bash understands that it =
needs to add ".exe" automatically?
> >
> > Assuming that is handled automatically, what do I now need to do to sat=
isfy the error message?  Do I need to put something in bash-for-Windows' /u=
sr/bin/env directory?  Or is there something else entirely that I should be=
 doing?
> >
> > And is it OK to ask about this on this list, or should I be going to a =
git-filter-branch resource?  Or for Git For Windows?
> >
> > Regards,
> > Richard.
>
> Emailing this list is fine.  You can also open an issue on GitHub for
> the project if you prefer; I respond in both places.  I may have
> limited ability to help with Windows issues since I don't have a
> Windows system to use or test on, though I have succeeded in fixing a
> few Windows bugs based on reporter feedback. (So maybe this list is
> better because more people can chime in with Windows experience?)
> I've got at least a dozen or so reports of people using it
> successfully on Windows so someone has figured it out.  I'll try to
> provide a few pointers that might help.
>
> You don't have to use "#!/usr/bin/env python3" or "#!/usr/bin/env
> python".  I could have put "#!/usr/bin/python3" there, but that might
> make it specific to my system.  I figured other systems installed
> python3 somewhere other than /usr/bin/, but that /usr/bin/env should
> be somewhat common and should find the python installation.  If
> /usr/bin/env doesn't happen to exist on your system, though, it is
> perfectly fine to have "#!/System/Commands/python3" or whatever is
> needed.
>
> If installation is difficult, you could consider using a package
> manager.  In particular, the scoop package manager, built for Windows,
> was one of the first out there to package git-filter-repo -- it was
> even ahead of most the linux package managers.  (And, yes, scoop can
> also be used to install python3 as far as I understand.)  I haven't
> used it myself (because I don't have a Windows system as I mentioned
> before), but since they were so interested in packaging
> git-filter-repo and making "scoop install git-filter-repo" part of the
> instructions (https://github.com/newren/git-filter-repo/issues/20),
> they look like a friendly bunch that are willing to help.
>
> I also looked through the issues and PRs related to Windows, and
> thought that the following links particularly had interesting comments
> that might be useful to someone running on Windows:
>   * https://github.com/newren/git-filter-repo/issues/36
>   * https://github.com/newren/git-filter-repo/pull/10
>   * https://github.com/newren/git-filter-repo/issues/48
> I don't know if any of them will solve your particular problem, but
> they seemed more likely to be of interest or use than most.  Also,
> I'll repeat the link for search for reports of Windows issues with
> git-filter-repo in case I missed one that might be useful to you:
>   * https://github.com/newren/git-filter-repo/issues?q=3Dis%3Aissue+windo=
ws

Oh, also https://github.com/newren/git-filter-repo/issues/56 which
suggests PowerShell may mess things up (and in a different way than
issue 36 showed).
