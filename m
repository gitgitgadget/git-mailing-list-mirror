Return-Path: <SRS0=PlGQ=4G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE5EEC34026
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 15:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97B6222527
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 15:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kqYRIHnk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbgBRP4R (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Feb 2020 10:56:17 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:43903 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbgBRP4Q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Feb 2020 10:56:16 -0500
Received: by mail-oi1-f193.google.com with SMTP id p125so20540046oif.10
        for <git@vger.kernel.org>; Tue, 18 Feb 2020 07:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4Kmt2sqFHb31yQTQntIb0gA8uvrh6BrttoM8luKAfNY=;
        b=kqYRIHnk84xaXa9+Gj2oLXc4gWBBsXz9wcWebpKIR18xNx00X1UEVVJK7kHm+sNDn/
         BltLflBVspskWfGarc27HAsslB+YTInC86n8+bKKkBfJac2bx36yiLi+/Yt4z+Y1bAjg
         nm9Bz1FAKs2UfjZuOQNlQiMBA8CAPEWUPdJJ3lxSFMQoPZtss+b2NZftw2N16vJOhy88
         pkJ5WxjjmhKxiMc0yizJzFgGQGAxnYzA3pjHjN+9uqiND7fQXWEF6vw83Vfw2HNv6zEX
         cHews85uu93B+gQ3d30xAN07MqRU3VIXYOfhzasOEWYK42yxLdD68cUuR0NXOE+Siy/0
         g29A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4Kmt2sqFHb31yQTQntIb0gA8uvrh6BrttoM8luKAfNY=;
        b=YMUL7d3Cu8G7tfDRU68xVmdhPjtqUkBvtp30XkFUNPTv6wAnKeH2PstI0yVzABPXHM
         N3uprVfBJgNC9Z4VMXYYNXrh/SYCUPom3UqAabDIMsZwapsMWpT/JO5PhsGETKAhVxbC
         2WaGGYlns827GRF1v/2mPjvB7sl3X5SeMcnc4cMoSndUM6l+5QfHAEEgws+AY62iYyOP
         SsAyb4+DDAVzdejX2QwkIRyD1/J0xxoMKi/6BGWl3ZdbFRKvBwZlV4C9sS1L3FLOk5PP
         UuEGrP47ihLUwnsvxykAZgiIDWPHWqbyKfNcsb2GpQB2c/GFNuCqZleoqsPcGs2XJTBd
         JWLw==
X-Gm-Message-State: APjAAAVIt1kNptDHSrFLO6Ib2V6LYVCRT4F0XiBEs4vbzDjoWXAnHKvC
        6RZCztnz/uS0Q0XKlo6Y4GMG+YjZcmwCb+ZYXc8=
X-Google-Smtp-Source: APXvYqz5ja+wMPTvwphrpw6tSH/5vsCMg5qWYMdAaIoiTpWVapACWj8yGtn+Jfmkg72zyADJwr9LrXp8IiHy6+hofJ4=
X-Received: by 2002:aca:b483:: with SMTP id d125mr1692913oif.167.1582041375865;
 Tue, 18 Feb 2020 07:56:15 -0800 (PST)
MIME-Version: 1.0
References: <pull.712.git.git.1581959751454.gitgitgadget@gmail.com> <nycvar.QRO.7.76.6.2002181501240.46@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2002181501240.46@tvgsbejvaqbjf.bet>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 18 Feb 2020 07:55:59 -0800
Message-ID: <CABPp-BFz63D9Mm69T9tOQpmQdJuhKbA3_U_Su4dV2XSkZxhTfg@mail.gmail.com>
Subject: Re: [PATCH] t3424: new rebase testcase documenting a stat-dirty-like failure
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 18, 2020 at 6:03 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Elijah,
>
> I am awfully short on time these days, so just a very quick observation:
>
> On Mon, 17 Feb 2020, Elijah Newren via GitGitGadget wrote:
>
> > diff --git a/t/t3424-rebase-across-mode-change.sh b/t/t3424-rebase-across-mode-change.sh
> > new file mode 100755
> > index 00000000000..4d2eb1dd7c6
> > --- /dev/null
> > +++ b/t/t3424-rebase-across-mode-change.sh
> > @@ -0,0 +1,52 @@
> > +#!/bin/sh
> > +
> > +test_description='git rebase across mode change'
> > +
> > +. ./test-lib.sh
> > +
> > +test_expect_success 'setup' '
> > +     rm -rf ../stupid &&
> > +     git init ../stupid &&
> > +     cd ../stupid &&
> > +     mkdir DS &&
> > +     >DS/whatever &&
> > +     git add DS &&
> > +     git commit -m base &&
> > +
> > +     git branch side1 &&
> > +     git branch side2 &&
> > +
> > +     git checkout side1 &&
> > +     git rm -rf DS &&
> > +     ln -s unrelated DS &&
>
> This requires symbolic links. Therefore it won't work on Windows, and will
> at least need the `SYMLINKS` prereq. Maybe there is a way, though, to
> change the test so it does not require a symbolic link here?

Ah, yes, I will fix it up.  Thanks.
