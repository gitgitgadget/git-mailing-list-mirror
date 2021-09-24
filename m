Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1593BC433EF
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 18:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D80D360E52
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 18:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241618AbhIXSlW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 14:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231919AbhIXSlV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 14:41:21 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 451B0C061571
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 11:39:48 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id e15so44074595lfr.10
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 11:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=s0FZHl1Uy4MsJR49Yq7TUSvJ5Koqp18MPNZXP6uCToE=;
        b=V5R05a143Qlc5L3R/FcH6sQRhE8QTjeizAnMkRlZ86cTbMVmGNGZrlFsGRRf589eIk
         NH2yvH7tx88V9gUevDqWI919HWNfe5KqGnYSpDm1k0YpnL5syGUFhfJ0rIMMqzZuGYqr
         ir5nDma9Bc5WGleumUqK6USheOT4SmFmME6Tkded/ZfVhGw4coyfkGoH3SGztKt21NBl
         FeE2SBZ9iIPUWL33AjVVZXuB308YuAton5tMThDA0wMn3USGHZqltjHRgUMkcSYAsDyw
         M+ZhTd+bt+3kuvILoG1WyUnYS45vpgswOI6uctHMLPNR7fvnYGndCCH6fsB/4JduJdRP
         2dCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=s0FZHl1Uy4MsJR49Yq7TUSvJ5Koqp18MPNZXP6uCToE=;
        b=6rM5trnSE5ZE00eAbnsz3KbMPXrIHz9rNddlQpLegxrOAMM0Evu8yV0G6kA3mjQzLN
         syFzH9bA0zaQOmdz3QZxe9jDLyvVLIxxa0GGEVcs93+g6ExkUrQ43lWrb3Kl21Zu1KNY
         ulk01MBKzjtDKCcqDNDd27rpBs8aLOBrdPwFTc9effKhUMZsOnTwwEAV2zYdVkqTEgqQ
         RJ6p1zOnd0jUsIUF2RzCQilhrehISo5yVgbtIPpbizYLPfSdfAqY0J3gR3abQYlFLC6S
         YOC7oZ0DbBgVG4dahJ6D0XnlRVxwvqK11K78h10NiJO2qU51ZC1fhmcCjHRctUITup6u
         OTzg==
X-Gm-Message-State: AOAM532UMZZNhv4T3qgNQNTEvipfFh1OnG0Ofy0vrRjQl5iD2L7PRcr3
        S1mz0etZ/LHX+jGrfRfy+O5GnDFvnx9djWEtfPBJ6vwLWZ8=
X-Google-Smtp-Source: ABdhPJwgkTaqQAxdkEaVKpCDvL4TywwhLpnJ2R0yBbss+BsaUrNg0cEN2c4Kdx6d1OqsYYm5W9nJezaGLTyPl8B9tP8=
X-Received: by 2002:a05:651c:228:: with SMTP id z8mr12715586ljn.429.1632508786400;
 Fri, 24 Sep 2021 11:39:46 -0700 (PDT)
MIME-Version: 1.0
References: <BN6PR15MB1426A342CBA9D993C0C49E55CBA49@BN6PR15MB1426.namprd15.prod.outlook.com>
 <CAJoAoZ=DuqHe2brN8Y2Ts0_afEhUNrdasRBb1O8HHomLKRJ4PA@mail.gmail.com>
 <BN6PR15MB14261D1A350398C0C26793E1CBA49@BN6PR15MB1426.namprd15.prod.outlook.com>
 <000401d7b16e$17ea02d0$47be0870$@nexbridge.com> <BN6PR15MB14262C7036B3C792CCE861D8CBA49@BN6PR15MB1426.namprd15.prod.outlook.com>
In-Reply-To: <BN6PR15MB14262C7036B3C792CCE861D8CBA49@BN6PR15MB1426.namprd15.prod.outlook.com>
From:   Emily Shaffer <emilyshaffer@google.com>
Date:   Fri, 24 Sep 2021 11:39:35 -0700
Message-ID: <CAJoAoZnuTGoF5J9FiwFTxsrG5VZ78zwKXe9w7__8U6UrCVQmeQ@mail.gmail.com>
Subject: Re: pull failed - why should I receive this message.
To:     "Russell, Scott" <Scott.Russell2@ncr.com>
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 24, 2021 at 11:36 AM Russell, Scott <Scott.Russell2@ncr.com> wr=
ote:
>
> Randall,
>
> Thanks for your answer.   However, this is a build system.
> Git clean -dxf would delete all untracked files - not just the conflicted=
 ones.
>
> We must keep all untracked files that would not be conflicted by the pull=
.
> Otherwise, the result would be our build would need to do a fresh build o=
f all objects and build targets - those are all untracked as well.
> Instead of the desired case of just building the changed files and their =
resultant targets.
>
> We just need the pull to overwrite any untracked files that may exist in =
conflict with newly tracked files.
>
> I see git is troublesome in this situation.   Every time a developer adds=
 an untracked file to the repo - regardless of type,
> It will result in failure of the pull.   And a failure of the build.

It sounds to me like the correct solution here is to add build
artifacts to .gitignore, which will prevent committers from
accidentally tracking them and breaking your buildbot's pull.

>
>
> Thanks,
>
> Scott Russell
> NCR Corporation
>
>
> -----Original Message-----
> From: Randall S. Becker <rsbecker@nexbridge.com>
> Sent: Friday, September 24, 2021 2:01 PM
> To: Russell, Scott <Scott.Russell2@ncr.com>; 'Emily Shaffer' <emilyshaffe=
r@google.com>
> Cc: git@vger.kernel.org
> Subject: RE: pull failed - why should I receive this message.
>
> On September 24, 2021 1:34 PM Scott Russell wrote:
> >
> >Thanks for your answer.   Is there not an option on the pull to have git=
 to overwrite the existing files?
> >
> >-----Original Message-----
> >From: Emily Shaffer <emilyshaffer@google.com>
> >Sent: Friday, September 24, 2021 1:29 PM
> >To: Russell, Scott <Scott.Russell2@ncr.com>
> >Cc: git@vger.kernel.org
> >Subject: Re: pull failed - why should I receive this message.
> >
> >*External Message* - Use caution before opening links or attachments
> >
> >On Fri, Sep 24, 2021 at 10:08 AM Russell, Scott <Scott.Russell2@ncr.com>=
 wrote:
> >>
> >> Files not previously in git were added to git.   Why should I have to =
manually delete them?
> >> Why can git put not replace them?  They were untracked files that are =
now tracked  and so the git copy is desired.
> >> We can't always know ahead of time what files may have been added else=
where.
> >
> >To turn it around on you, you can't always know ahead of time what
> >files may have been added elsewhere, so you can't be sure that your
> >newly added untracked file locally will be safe from being overwritten d=
uring a pull. How upsetting if you sink 30 hours into newlib.cpp and then y=
our teammate checks in their own newlib.cpp, and yours is overwritten witho=
ut asking when you run 'git pull'.
> >
> >You might have some luck with the '--autostash' option, which would at
> >least prompt you whether to get rid of things when trying to merge them
> >back together during the automatic 'git stash pop' at the end. Or you co=
uld run 'git clean --force' to automatically delete any untracked files you=
 might have - you could even alias yourself a command like 'git dangerous-p=
ull' which runs 'git clean -f && git pull'.
> >
> >>
> >>
> >> We need the pull to work automatically.
> >>
> >> error: The following untracked working tree files would be overwritten=
 by merge:
> >>         Staging/CADDApps/CADDUIHelper/Source/Release/CADDUIHelper.exe
> >>         Staging/CADDApps/CADDUIHelper/Source/Release_Unicode/CADDUIHel=
per.exe
> >>         Staging/CADDApps/InstallDriversPackage/Release/InstallDriversP=
ackage.exe
> >>         Staging/Common/NCRCommonCCLib/Source/Release/NCRCommonCCLibMsg=
.dll
> >>         Staging/Devices/NFC/Elatec_RFIDReader/Bin/Director.exe
> >>         Staging/Devices/NFC/Elatec_RFIDReader/Firmware/AppBlaster.exe
> >>         Staging/Devices/NFC/Elatec_RFIDReader/Firmware/flash.exe
> >>         Staging/Utilities64/SSPSWDriverInstaller/Bin/DIFxAPI.dll
> >>         Staging/Utilities64/SSPSWDriverInstaller/Bin/DriverForge.v4.5.=
4.exe
> >>         Staging/Utilities64/SSPSWDriverInstaller/Source/Release/SSPSWD=
riverInstaller.exe
> >>
> >> Staging/Utilities64/SSPSWDriverInstaller/Source/Release/SSPSWDriverIn
> >> stallerMsg.dll
> >>
> >> Staging/Utilities64/SSPSWTaskMgr/Source/Release/SSPSWTaskMgr.exe
> >
> >Or better yet, you could avoid checking in compiled binaries like these
> >and instead add them to your .gitignore, unless you really mean to
> >update them every time someone makes some change. When checking in
> >binaries, you should be aware of the additional disk overhead needed to =
do so and take a look at some options Git has to mitigate that overhead, li=
ke partial clone. However, in many cases the easiest way to mitigate that o=
verhead is to simply not check in binaries unless you absolutely need them =
to be version controlled.
> >
> >- Emily
>
> If you are scripting this, try using git clean -dxf and git reset --hard =
before running the pull.  That will clean the objects out of your working d=
irectory.
>
> -Randall
>
