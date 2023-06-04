Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF5CC77B73
	for <git@archiver.kernel.org>; Sun,  4 Jun 2023 12:43:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjFDMnu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Jun 2023 08:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjFDMnt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Jun 2023 08:43:49 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49410B8
        for <git@vger.kernel.org>; Sun,  4 Jun 2023 05:43:48 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-51458e3af68so5635823a12.2
        for <git@vger.kernel.org>; Sun, 04 Jun 2023 05:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685882627; x=1688474627;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gWJEep1btwdv4enfGifOaZD5c5chuuApgiKIcguGkq8=;
        b=TyowkmmArdByZ9o5JVEOzBG3feo0Sn49bGir7nVQ3gjmNQxsjqAdomtG5jZcEpPkCn
         IZB0b4mnM3sN/YlHd30xAPY0HX3WNKIwm5C5TQ+KsOR0Bq9BSC9QgPkquoy8Oe/OeGWy
         6Nr2CuVuYSPJcS41n1Bu2FnM/hfYpNkQk5+yWWixusSt4CoaCNdUiNVywdrO0cpYhOMI
         DIl9qD13WArVsMBZK/nbgKrKEfdQzgNVNg3zUAYI6rrgG/wYzxwNAN5LIH/ayB8f9bTN
         lmw14n2+tOW7eO3lFB4J0XoosFp0E+ilouVaMI5TT0zBxaWwPJRGCWDthfjAYimWltPg
         0+kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685882627; x=1688474627;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gWJEep1btwdv4enfGifOaZD5c5chuuApgiKIcguGkq8=;
        b=Qwn5ImSPXIfofm3LvuVeoPrV69bj+jfHDGNOakmZTOvmgh30yNy/3FEUowxP1u8R17
         KZZCoizM84U1eM9pNDiNpXpuroh+oXgLrEcj4gyuWva/IgGMGK0W3o7zT6B/fVtpyvfS
         lH8eIwEtFNEVf/SdAdzLJDB7cSHsJ9aUQs/usURw68FuF73exqMZm3nqTn4Lk6AyeSSt
         lE42Mw9cGuIspTb+EYhrJ5+uiu+laByKuyobuI/ixBdx7JBF4Ga/dupw7FNLVvJY726n
         hiDh50i/w/jGU7tshcG25Nz5WZjhWiyPlhrv3CNCjdLg5JWqYY0vOkL36YKy1W3V195k
         GEkQ==
X-Gm-Message-State: AC+VfDzQkbZMyy47TZaTZZ7X3DHvuZm+WKttjX09WoTKCaSiHvJPKyuE
        Cf1kgaVBO9qHs2UK89DUugw3wXkbA4tWb2mcBkWumLWe
X-Google-Smtp-Source: ACHHUZ4Af5RsqZYyDBPW7Fu1BBzvqOXUMUMGEJEmDkGbG+VD8uwLaeHWby5aUdm1X5ZEyVQlnl4O5kieqOBs73BOyNM=
X-Received: by 2002:aa7:c718:0:b0:514:3e1:239c with SMTP id
 i24-20020aa7c718000000b0051403e1239cmr5148994edq.42.1685882626375; Sun, 04
 Jun 2023 05:43:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAHsf_F2CgyTWr82htsyg8aiA-WhrKa4zJQUc_wJwF0pfRYR7yQ@mail.gmail.com>
 <ZHo+742ova7QTAe1@tapette.crustytoothpaste.net>
In-Reply-To: <ZHo+742ova7QTAe1@tapette.crustytoothpaste.net>
From:   Shahin Dohan <shahin.dohan@gmail.com>
Date:   Sun, 4 Jun 2023 15:43:36 +0300
Message-ID: <CAHsf_F3m8U+gPSVk8wMmF6ozEW0YgMUQ9qbYBAE+J_FmeAge0Q@mail.gmail.com>
Subject: Re: Bug: Git bash slow after update
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Shahin Dohan <shahin.dohan@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Brian & Bagas,

Thanks for your replies, no other processes affect performance and yes
the issue seems to be in Git Bash for Windows rather than Git itself,
I thought it came from you guys as well :)

Apologies for the late response, could not send plain text emails from mobi=
le.

I'll report this to Git for Windows project!

Thanks,
Shahin

On Fri, Jun 2, 2023 at 10:11=E2=80=AFPM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2023-06-02 at 06:42:01, Shahin Dohan wrote:
> > What did you do before the bug happened? (Steps to reproduce your issue=
)
> > Updated Git to 2.41.0
> >
> > What did you expect to happen? (Expected behavior)
> > Same performance in Git bash as before
> >
> > What happened instead? (Actual behavior)
> > Every operation is significantly slower. CD is slower, git pull is a
> > lot slower, etc...
> >
> > What's different between what you expected and what actually happened?
> > Git bash performance is significantly worse
>
> The Git project doesn't distribute any binaries at all.  If you're using
> Git for Windows and seeing problems that are in Git Bash and don't
> involve Git (e.g., slowness in the shell with cd), then you'll probably
> want to report it to https://github.com/git-for-windows/git/issues/
> after searching for any existing issues.
>
> I will also mention that you'll also want to indicate in your report to
> the Git for Windows project if downgrading again solves the problem
> (which you should try) and if you have any sort of non-default
> antivirus, firewall, or monitoring software, since those can affect the
> performance of programs on Windows.
> --
> brian m. carlson (he/him or they/them)
> Toronto, Ontario, CA
