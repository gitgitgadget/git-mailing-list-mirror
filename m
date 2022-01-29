Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B0B6C433EF
	for <git@archiver.kernel.org>; Sat, 29 Jan 2022 16:47:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352815AbiA2Qr4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Jan 2022 11:47:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233791AbiA2Qry (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Jan 2022 11:47:54 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B282C061714
        for <git@vger.kernel.org>; Sat, 29 Jan 2022 08:47:54 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id me13so27332336ejb.12
        for <git@vger.kernel.org>; Sat, 29 Jan 2022 08:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CptUne5ZuEXnDlc65uNuBmmDeAUs5YXkQwNX1HEl3VA=;
        b=iFhj5husQZC5yfUqLdiIotAH9yu67fT7DAs9J57dMFUs4gctT4Ik6Ca/y+/qjDnii9
         aJUEdZVBxngReYBD0TBSx/37hKtZoXSe9tErfJJWTgSd/SJCoz8iGttxxzc4JJihegm5
         RulML6OMwT019HNanKF/A4UMcYCxI9P+Ru99bpbZD492R3kyQhPLraUkymCEzh/WOBkJ
         k62kHgzAVue8r/U5cDu84LuTcqcemPAKf8BQ42JX/XrW5eO8tTwvT1gTAOjgpfHCBbqv
         bMvv276PKugvVEU+7C5TzHBmYTbhQ2Yt+Ze4eHAia9VEfZOYLJfMCQDk44qlxdPrBKxC
         NiqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CptUne5ZuEXnDlc65uNuBmmDeAUs5YXkQwNX1HEl3VA=;
        b=LmazbJ2x12xq3dK1Etapvo5ou8NcQh5cCwPgj9F/eAN4w66GN1JfhN2yyw/OMA0I+Q
         exDHpgUU37sFPy620y1qVvkmDv6slaHvXE9TyKQVB27HyNouvkCe+u9Jr3q4qIlgoYV1
         IQnlTO5oGqPzMnKl07K/BZzN2WtceVh3I7vLBIaCRKRw6nU29ykKBiPPtOUgcCylMuub
         KiC/rrxI8Q6NTyiWZVEcb3yuJ6J4aoTiZ720VFlVAndBYHM1udqpKqgAzGvt8SpBo2j/
         oJvHrpOyErAdLztB3T8ibozXUwXW4CYJNsKszcboEb0RwVNldMfGpnlZBf2KMwav1as1
         hRPA==
X-Gm-Message-State: AOAM533m3JiNLTXeL5q821kfQ2mVRXoeyvfGVYY8wq+MlhodFKkQMyR4
        pFGPLGGLvShOIsR0MPaTAMth/tAHhj6xXVzVGy0=
X-Google-Smtp-Source: ABdhPJw89Oa3zhdtLlVBtJhFgikUOvW0b+0hGGNa9eBgz8jm/ZAcsDWtzc+FskDiuR6BYpNZjjbgafL3OILzzINuSe0=
X-Received: by 2002:a17:907:1b0f:: with SMTP id mp15mr11118418ejc.493.1643474872878;
 Sat, 29 Jan 2022 08:47:52 -0800 (PST)
MIME-Version: 1.0
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com>
 <35e0ed9271a0229fe2acd2385a7e4171d4dfe077.1642888562.git.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.2201281744280.347@tvgsbejvaqbjf.bet> <CABPp-BG2rMEYBLuBW=0wtpJe4aUFGCFa8D0NTSKz9Sm+CkXPxw@mail.gmail.com>
 <0d7ba76c-9824-9953-b8ce-6abe810e2778@kdbg.org>
In-Reply-To: <0d7ba76c-9824-9953-b8ce-6abe810e2778@kdbg.org>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 29 Jan 2022 08:47:41 -0800
Message-ID: <CABPp-BERtRDeyF3MhOQhAFwjoykOKwXoz6635NK7j2SEKp1b3A@mail.gmail.com>
Subject: Re: [PATCH 08/12] merge-ort: provide a merge_get_conflicted_files()
 helper function
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 29, 2022 at 12:23 AM Johannes Sixt <j6t@kdbg.org> wrote:
>
> Just a heckling from the peanut gallery...
>
> Am 29.01.22 um 07:08 schrieb Elijah Newren:
> > On Fri, Jan 28, 2022 at 8:55 AM Johannes Schindelin
> > <Johannes.Schindelin@gmx.de> wrote:
> >> Meaning: Even if stage 3 is missing from the first conflict and stage 1 is
> >> missing from the second conflict, in the output we would see stages 1, 2,
> >> 2, 3, i.e. a duplicate stage 2, signifying that we're talking about two
> >> different conflicts.
> >
> > I don't understand why you're fixating on the stage here.  Why would
> > you want to group all the stage 2s together, count them up, and then
> > determine there are N conflicting files because there are N stage 2's?
>
> Looks like you are misunderstanding Dscho's point: When you have two
> conflicts, the first with stages 1 and 2, the second with stages 2 and
> 3, then the 2s occur lumped together when the 4 lines are printed in a
> row, and that is the cue to the parser where the new conflict begins.
> Dscho did not mean that all N 2s of should be listed together.

Ah, so...I didn't understand his misunderstanding?  Using stages as a
cue to the parser where the new conflict begins is broken; you should
instead check for when the filename listed on a line does not match
the filename on the previous line.  In particular, if one conflict has
stages 1 and 2, and the next conflict has only stage 3, then looking
at stages only might cause you to accidentally lump unrelated
conflicts together.
