Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85DBCC433EF
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 03:29:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiBXD3l (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 22:29:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiBXD3k (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 22:29:40 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8372D20BCD8
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 19:29:11 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id p15so1549586ejc.7
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 19:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AUoMm5PDBTkDPLmHa6XUcW8m/kG+rn3prJSOywv+7go=;
        b=mTRqWnbsIsZ2qTdRVCjAtlJuxdNlTVwdmrWHLsv3g49jWiocRJMTS9Fyg4tJkQbo9y
         l7DNqRA5gchLCItNe7BieF7kfDWl3XphTEWcUwUVjKIpkmeMzq0PP3xVVouGflB1FQS3
         LYd/x7qjIe9ddfGGnxX0kUiegiF8ABE3V/I1G3t+eWuKwPmn2C21VYVootkJL1q+TqzV
         Y5xh2RsZ+kw/UstjMH4BYyEXBXY26gf1XD3vC/34aQdhr/jYVfFEslGhdGefVc8CSRkn
         Ec5c9p5aLzghoGtugS+4nnYqPHbqKhdg7aDBJyKSc87ACDVZEsPCeUrChxTI2y0yJUeH
         jpVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AUoMm5PDBTkDPLmHa6XUcW8m/kG+rn3prJSOywv+7go=;
        b=27UpjREoGTURrenJlK8mO0VvzBV3icETddVca9XVA51WsE2aH/wEymk+QWflVtFBy+
         z0TfuNF9jU/JgqcPk9uampgqsFqX6Ayktv6OT6LdS6sxlBk4XH2bCaDi7KzhUKiiChjE
         EK65kyQAqS1KxEvvocs426yrZvZiu5VGcL8jU5Likb19bEKqqdawW97ycKP+v/vXe8KU
         0EKJSXfsEmO2hPztCuEJ6o5PgOSkG95Euc99CF4vqiisyehPWPEOmriH4yqtTyeJ+UiH
         90JV88psVDPxS667mvpi86gKicWWkMIfhUKe+A6q1iXoOSBNKwZrlcD4Hl2e2GUyLNiI
         7WLA==
X-Gm-Message-State: AOAM532lllylBdICmnoo8tAMtQpoDjB2oxlodyDuLOjxWt7m80qQ7ukk
        UumxVlkOHLp/EOV+tiZjM6fol7hyWrtk+HZ9NEc=
X-Google-Smtp-Source: ABdhPJy++vA3X+p20ZrGzicUD2v5BeYMrungsqMtQy7buKjZvIvk9w99iWU9qqFY31581DTyBvbBsU1wwTOuxUMhpww=
X-Received: by 2002:a17:906:af79:b0:6ce:61d3:7e9b with SMTP id
 os25-20020a170906af7900b006ce61d37e9bmr622864ejb.191.1645673349942; Wed, 23
 Feb 2022 19:29:09 -0800 (PST)
MIME-Version: 1.0
References: <20220222114313.14921-1-shivam828787@gmail.com>
 <20220222114313.14921-2-shivam828787@gmail.com> <CAP8UFD1FVuoe7V3JU+hExsbjWTkNZFCZFV4qc65YLd4ow-Da5w@mail.gmail.com>
 <xmqqsfs9thq7.fsf@gitster.g>
In-Reply-To: <xmqqsfs9thq7.fsf@gitster.g>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 24 Feb 2022 04:28:58 +0100
Message-ID: <CAP8UFD0miSWhksE8aWUY6awhf4sCNSO1mfPni2EEi94fzFnyoA@mail.gmail.com>
Subject: Re: [PATCH 1/2] t0001: remove pipes
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Shubham Mishra <shivam828787@gmail.com>, git <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 23, 2022 at 10:07 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > Only the exit code of the command before the pipe is ignored.
> >
> > Also it's ok to use pipes if the command before the pipe is not `git`.
> > We trust regular commands to just work and we test only `git`.
>
> Both very good points.  So ...
>
> >> -               find .git/worktrees -print | sort >expected &&
> >> +               find .git/worktrees -print >tmp && sort tmp >expected &&
> >
> > Please put the `find` and `sort` commands on 2 different lines when
> > they are separated with &&.
>
> We do not want to split this pipeline into two commands.

Yeah, right.
