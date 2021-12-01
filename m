Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF6EC433F5
	for <git@archiver.kernel.org>; Wed,  1 Dec 2021 05:38:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346764AbhLAFly (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Dec 2021 00:41:54 -0500
Received: from mail-pl1-f179.google.com ([209.85.214.179]:33752 "EHLO
        mail-pl1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbhLAFls (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Dec 2021 00:41:48 -0500
Received: by mail-pl1-f179.google.com with SMTP id y7so16824581plp.0
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 21:38:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PssoNew3A9CZ+O2u1w/obXklrsSdx95opuGYwknWpP0=;
        b=ini/yHI1+ISgB4HlsLsLyY5ibsXl26h8fO3Vo8zZljnM4PIxv5ux6TcxbpuMJDs4hU
         prCSNG/+VX3TmY+u5+aWKJd5rTWdQ48TWn/2+S24ZxPdDza6cuXJhVmWDB+aA7v/HbTy
         dnXEI1WrArRA7VyLv+w0UxjShHISy/eVg3RN/ZX2W6v4M04Ff7VfEjDg7reQ9Q9g9PLJ
         Wh3bjp3MameBkTux9cbCXZxOUa5rD0u0J4IKciaxN7Dbqz5hW03I5PViJwWDEV0nzfmn
         kLXi54njOe4k5agpg8e/VXbxtDVwlrikY9QCpts8x3mAyGy79RQOd6iY5cKPPn6PAY4T
         lV3Q==
X-Gm-Message-State: AOAM533pvheQht9BToP0QL9h8Xtc78WAFfUF/CrjOB3uNkBeV22fORuo
        RAUWNd4CC7v1PjZI/qJUrSNCHqM2h1e5/3CrXd8=
X-Google-Smtp-Source: ABdhPJxW6vWD+PGBPQrsbyd3lUVh4OGBB5bfB9kRi/AIriDxZqobsqVp3wAnVrCHianUJsPmapQbd29QwXe47xUPK9E=
X-Received: by 2002:a17:90a:b107:: with SMTP id z7mr4805037pjq.104.1638337107732;
 Tue, 30 Nov 2021 21:38:27 -0800 (PST)
MIME-Version: 1.0
References: <20211130043946.19987-1-sunshine@sunshineco.com>
 <YaXQ/HinYZH1wL7E@coredump.intra.peff.net> <CAPig+cRQqm8Ce29PnkndT47NNxM3UhJv12RZGZZJD-AyGVC7Zw@mail.gmail.com>
 <YaaN0pibKWgjcVk3@coredump.intra.peff.net> <CAPig+cT+YfgBG3Aqszp+y7iy_megboECZy3NkMqUjBj7=Z661A@mail.gmail.com>
In-Reply-To: <CAPig+cT+YfgBG3Aqszp+y7iy_megboECZy3NkMqUjBj7=Z661A@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 1 Dec 2021 00:38:16 -0500
Message-ID: <CAPig+cRB45nwUin4Lv-j2dAQob1SSu7hGyM2c3E8G2ym_uFB2w@mail.gmail.com>
Subject: Re: [RFC PATCH] vreportf: ensure sensible ordering of normal and
 error output
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>,
        Baruch Burstein <bmburstein@gmail.com>,
        Randall Becker <rsbecker@nexbridge.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 30, 2021 at 9:36 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Tue, Nov 30, 2021 at 3:47 PM Jeff King <peff@peff.net> wrote:
> > On Tue, Nov 30, 2021 at 09:05:54AM -0500, Eric Sunshine wrote:
> > > (1) I don't think the practice is documented anywhere, so people --
> > > including me when I wrote builtin/worktree.c -- might not know about
> > > it. Indeed, we don't seem to be entirely consistent about doing it
> > > this way. Randomly picking submodule-helper.c, for instance, I see
> > > status-like messages going to stdout:
> >
> > Yeah, we've definitely not been consistent here. There's no silver
> > bullet for this aside from vigilance during review, but probably laying
> > out guidelines could help.
>
> Thanks for the reference. I'll take a stab at adding a blurb about
> this to CodingGuidelines.

I just posted a patch which updates CodingGuidelines to talk a bit about this:
https://lore.kernel.org/git/20211201053214.2902-1-sunshine@sunshineco.com/
