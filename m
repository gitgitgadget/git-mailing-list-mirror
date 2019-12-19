Return-Path: <SRS0=FxFb=2J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78202C2D0C1
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 20:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48DE32465E
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 20:16:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kjDeDY9n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbfLSUQt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Dec 2019 15:16:49 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:34823 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbfLSUQt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Dec 2019 15:16:49 -0500
Received: by mail-oi1-f194.google.com with SMTP id k4so3652556oik.2
        for <git@vger.kernel.org>; Thu, 19 Dec 2019 12:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9FiUVSU5NKvPGEq71ZNiCXaRpl0IxZXenhtA40IY45A=;
        b=kjDeDY9nbHYE2cfxCwINRnHLfqVqFKFSDEEmSlPx/CwxhE6NqtQn+RPrb+UC61OWg/
         MlnsVFSTvz+nU34cZp155BXfPAXmnbGBdTaqqEZcPkkTK86YxCwugmmtSev5HsCRaE7p
         e1p+IrAILl7sP9AzI3XpFgpPMltL/tqfWf57nWIGduKJocrbeIePvrRg2Y4iID3+rL7s
         7yZhnoX7vCOI+6+fZJAUFpBiBSfzhCRt6PephTjAcyY+cHgDGYGKP3XWC++qIFvr1rgc
         HMQqaJo1qOk72DMPlIw+mvuDhWn8miIsbajrRacabWlnI1sbALW5mVxCxIwJpo30fQmC
         5nxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9FiUVSU5NKvPGEq71ZNiCXaRpl0IxZXenhtA40IY45A=;
        b=GgS1R3Zchqc/oXjAUaeC9NOEaMkC79+oHDZtA6Ua7QDP8VSWrlg8gzgsLRDw/v5W25
         wnZsUza87GY7RxpRnQvQ5UdoQcleptZ+fq9y9zgPa8Qem1TooCAGFjLrdLDtuNNjHanC
         Azbd+C87Dsygg9SCJCEwpv2DRfuiS58Nj226BVpm1jb41NTD05q7ASf7fmgCfS2v8Apg
         gAiejYIpZTydY7SMHkzKXU0h/9/Q7aUtb/nAoFlg4xULVDiZpDh2lcfWFJLKcdAZ+1lY
         ewDjhTVVzVG2cqiTPr4LJPxTDIVeMmg/xaleLNdrw7U1KbdvfnzhfwdBPsxJ2qMhujn+
         ub3g==
X-Gm-Message-State: APjAAAUNoXKwUdlhuEsTT0wMbJK96b9bNRl8you5z371DbJX+zDaDr8J
        WiIzQ4RB5qYBoEcJH7qUTS6sys2vGxcA49qmSiB0f0yg
X-Google-Smtp-Source: APXvYqw5JdkP+FPjrgGO59EEBJFOAHnYVXvNP8yGsROlgT1a/2ST81mxZ1O0fKFMRYfsQBNgtd71LrW86yJezXFf/EE=
X-Received: by 2002:aca:cf83:: with SMTP id f125mr2957699oig.15.1576786608230;
 Thu, 19 Dec 2019 12:16:48 -0800 (PST)
MIME-Version: 1.0
References: <CAMNO-Ba0-Me67qEEfHoJyBoWg0X_x7=qmmZ1D8ZK9S_0Tk=J5Q@mail.gmail.com>
 <20191219195303.ckeuucm5c7n56eew@yadavpratyush.com>
In-Reply-To: <20191219195303.ckeuucm5c7n56eew@yadavpratyush.com>
From:   Insane Sharpness <insane.sharpness@gmail.com>
Date:   Thu, 19 Dec 2019 20:16:37 +0000
Message-ID: <CAMNO-BZUUj7EcXJGyu-xF55m=ZRen7yRCGg=r-HmJ0p4GeH_bw@mail.gmail.com>
Subject: Re: New Git Visualiser Tool - GitVine
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Pratyush,

Thanks for trying it out and the detailed feedback

I will investigate this slow initial load on some git/kernel projects,
though I have to admit, it appeared fast on maybe simpler/smaller
projects.
Gitk/git log seems to handle this without issues, so thats a clue for me

> The log for git-gui is missing some merge commits like d32e065 and
> 2763530 but then it shows some other merges like 69fdb92. I'm not sure
> why this inconsistency happens. This also leads to the tool showing
> 39acfa3 as the HEAD (as of writing this it is also the 'master') when in
> reality the HEAD is at d32e065.

I have to check this inconsistency further vs Git-gui (also there are
some additional options in the GitVine Edit Menu - Show first parent &
Show all. This may influence the visibility of some commits)

Thanks again for feedback & gives me much encouragement.

Regards,
Prashant Sharma

On Thu, Dec 19, 2019 at 7:53 PM Pratyush Yadav <me@yadavpratyush.com> wrote:
>
> Hi,
>
> On 19/12/19 10:53AM, Insane Sharpness wrote:
> > Hey All,
> >
> > I made an application recently to better visualise git commits on a
> > per file basis.
> > And added this to the git kernel wiki here
> > https://git.wiki.kernel.org/index.php/Interfaces,_frontends,_and_tools#GitVine
> >
> > Does not try to compete with more feature rich & powerful clients like
> > Gitk, Kraken etc..
> > Just tries to be simpler.
> >
> > Free Standalone & runs on Windows, Linux & macOS
> > Just needs git in your path. (Developed using Python, Qt & packaged
> > with PyInstaller)
> > Project Page Here: https://insanesharpness.gitlab.io/GitVine/
> >
> > Its still a rough cut and loads of room to improve + add more features.
> > Please try, would love to hear what you all think.
>
> I have only used it for a few minutes, but one thing I immediately
> noticed is that the startup time is _really_ slow. On the git-gui repo
> [0] with only about 1200 commits, it takes around 10-15 seconds to load.
> On the git.git repo [1] with around 57,000 commits, it takes nearly two
> minutes to load. In comparison, gitk it almost instant. These two repos
> are relatively small in size, and examples of bigger ones would be
> Linux, Chromium, etc where I expect startup times to be even slower.
>
> I'm running it on Linux on Git v2.24.1. Speeding up the startup time
> would be really nice.
>
> The log for git-gui is missing some merge commits like d32e065 and
> 2763530 but then it shows some other merges like 69fdb92. I'm not sure
> why this inconsistency happens. This also leads to the tool showing
> 39acfa3 as the HEAD (as of writing this it is also the 'master') when in
> reality the HEAD is at d32e065.
>
> Also, when I double click a commit in the list at the right side, a
> popup opens with the commit information like hash, author, commit
> message, etc. But, I notice that the "Signed-off-by" trailers are
> missing the email addresses. The popup when hovering over a node in the
> graph shows them correctly though. So, for example the trailers of
> 39acfa3 are:
>
>     Signed-off-by: Kazuhiro Kato <kato-k@ksysllc.co.jp>
>     Signed-off-by: Pratyush Yadav <me@yadavpratyush.com>
>
> But they show up as:
>
>     Signed-off-by: Kazuhiro Kato
>     Signed-off-by: Pratyush Yadav
>
> All this said, I like the simple and clean UI. Looking forward to how
> the tool grows :)
>
> [0] https://github.com/prati0100/git-gui
> [1] https://github.com/git/git
>
> --
> Regards,
> Pratyush Yadav
