Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 742ECC4707A
	for <git@archiver.kernel.org>; Fri, 21 May 2021 18:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43FDE61164
	for <git@archiver.kernel.org>; Fri, 21 May 2021 18:36:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235466AbhEUSiA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 May 2021 14:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235293AbhEUSiA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 May 2021 14:38:00 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E315C061574
        for <git@vger.kernel.org>; Fri, 21 May 2021 11:36:35 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id f18so1694451ejq.10
        for <git@vger.kernel.org>; Fri, 21 May 2021 11:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=506EfvPDHHcXb8qO0KUJs/xBVdlpApB+2n/E/CdH+Gw=;
        b=OQucEpjCgX7PDAHjHkgyDiXHQc5ntgmB+K8pxIOn8OAOh5PeQyYzLAGKbf/KDTdTns
         pYEd3M3V0tE3t0kHrpMOE+vY/g6zjopCZCLE8CS8uDUQkLH80rvt+/Md0uGMg3Q7o2UG
         i0eBELQI54hih9SnB2OJIDBJ1szHat9AS6afmhzwJLJqdU+V+otYZQ91/FMqCUohIYcV
         ABkVkc6PWYt3IVQvPjPVubMGgVDwKPfIPzUMPMqM6R4gi5K68SqmHkitF06Hith0twvL
         y9okr4K+Vb2ErgI+I/D3b1R1Dq0f51KhQadpAgV+Egl68xGxSUeSFu60TJUOPJlTPZDw
         9DeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=506EfvPDHHcXb8qO0KUJs/xBVdlpApB+2n/E/CdH+Gw=;
        b=fPFI7XtXpmmVUYhf7wQOXrsKuNZFnDRPkiYDpV6kzSTdBEyZ83cPU7Ti5PQxGsS4uy
         srbK46mYVFkH3999ubdCBcr9pBuQhWRQRcd0qyPgBZ8ImUvau6mbbj+KpuVUiemmHoH+
         q1bAdTBla6PJkKnFqMXIVuHvtwr0GPdsTQxi6u+S62vapGddD2HE3SCLKHVuaqVUPvow
         5DtIkvAX4fRuIrvUwP9Tp2zxlD0rbgQ3vZ6us533SJWOcskYVi4xdhVRU86aTqcMfxe2
         cRbfqwPpFE3Afjvzm1rUYxDx9+21bUaZlRfrB0tAQnYw3nr6jR5oo+S1Z56hcY7iLg4P
         H1Yw==
X-Gm-Message-State: AOAM531VFDQk0e7lCS6adiql2U76kiDDHwneot9SKYqMn9NToa7TW7Cm
        AiLYt2o3GPuLV5yu3yUP6y+uptGhyD5tD/USuDU=
X-Google-Smtp-Source: ABdhPJytMbJt/Y5t8zbRSLlw7pqOiyzLHHLXIk5UTKwKMWglMHaWpduRBrqDskKJh8nmIisJ/wfAoDb/BM8ecfSmCA8=
X-Received: by 2002:a17:906:2a56:: with SMTP id k22mr11873018eje.551.1621622194204;
 Fri, 21 May 2021 11:36:34 -0700 (PDT)
MIME-Version: 1.0
References: <c4b27662-1228-a1ff-26fc-637897ffc8e7@riscosopen.org>
 <EB55447C-538F-44DE-BFC0-A3BD1A970E99@gmail.com> <a727c1af-4993-684d-d299-00bf1a47cfc7@riscosopen.org>
 <FCF5A210-4042-4C1B-87A5-83D916F02FCE@gmail.com>
In-Reply-To: <FCF5A210-4042-4C1B-87A5-83D916F02FCE@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 21 May 2021 20:36:23 +0200
Message-ID: <CAP8UFD39ShCZRxUN7iHFUSQxO=EL18hhpbNN86SAnASHgxe6sQ@mail.gmail.com>
Subject: Re: Bug in git submodule update --remote
To:     Atharva Raykar <raykar.ath@gmail.com>
Cc:     Ben Avison <bavison@riscosopen.org>, git <git@vger.kernel.org>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 21, 2021 at 1:47 PM Atharva Raykar <raykar.ath@gmail.com> wrote:
>
> On 19-May-2021, at 20:11, Ben Avison <bavison@riscosopen.org> wrote:

> > I like that solution. Although, I should note that if the user has set
> > submodule.<name>.remote to something other than 'origin', they will need
> > to ensure that submodule.<name>.branch is also set, or they will still
> > hit the "Unable to find current <remote>/HEAD revision in submodule"
> > error that I initially stumbled on.
> >
> > How about an implementation like the following? I introduced a new "git
> > submodule--helper" command rather than modify "print-default-remote" for
> > a couple of reasons:

First thanks for taking a look at improving git submodule and for
doing so by introducing most of the new code in submodule--helper!

[...]

> Since this would modify the behaviour of the update subcommand, I
> have decided to CC my mentors (Christian and Shourya) who are more
> qualified than me to comment on this proposal.

As commit f0a96e8d's author is Dscho (Johannes Schindelin) and as he
was helped by Philippe Blain, let me CC them too. They might know the
reasons for this behavior better than us.
