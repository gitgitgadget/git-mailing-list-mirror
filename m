Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27BFCC6FA8A
	for <git@archiver.kernel.org>; Wed,  7 Sep 2022 16:04:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbiIGQEo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Sep 2022 12:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiIGQEP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2022 12:04:15 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F242BB934
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 09:02:44 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id d2so4060529wrn.1
        for <git@vger.kernel.org>; Wed, 07 Sep 2022 09:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=CISfIJr5XlbWPo0p4rNEWGyDOMBhv3zIQCvKr8Ipk4M=;
        b=b/ddJwNnY59kBrwH77ZRP3i7soqI00HnFYWOGjScXz89Nv3OxvWtfFRtRCN+EMq0x+
         jl7/+L93rXPBZSaG6nzAww4xuCmjWPygvWYUgJHE3x7pYkbjb5iCtm5qEFyvP9xaLsSz
         7e+4159CEAhxLxtzndhVAOohQleQr+SlEmIVBbRt7XvwMpjbByJonJwq8Viqk7j9MAvS
         B7oRMmdnIUnlg/XgZ0C5TvOHkzdvWcENMIwih+x9DIJwvfJ/TYuZTDUk+GuD+XxN4hXK
         eANHEfTmG4+UKZH7T6nYqDg52W75HnuUiT13FsX3T60ajxMIR+iSG6Q3Rsv15kGSqgEn
         ot+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=CISfIJr5XlbWPo0p4rNEWGyDOMBhv3zIQCvKr8Ipk4M=;
        b=fnzSLV75UQKiYvs9T6tUFPaJjSlCDbZ6jyAECyUGLfFoGFV8q6REzvZsSPw+1voZ5U
         vjCWA2IhQTbOXS8xXTZsOt4m92q86RFK6OIVTTG6gmTuf0OcNUJ8yGyq0izWCeorMu8h
         WyxYRQjFa1Ku5ylumQqh5wsK51FlDNQeUZhlJZDnG/V8eR3IUV69z0TkA5XRV3QiBwHN
         cMTPi1ab19j6Ufs5STodub/BYCt1ZeiYg91jitG53cvOUuGyjvCob1VLO0wLBvHdra5E
         i/xqBKwQ5UXujagjChYBQGfmpks3tH22QDcJqy83g+x86MsK03q7c5cVUkURD1se7rs0
         fcug==
X-Gm-Message-State: ACgBeo3Kskxf6yQgkavlTJCKHrinm+RknuxlS5FWF3M+ypCVqGBo5OKu
        I/5qea5G/XmbYgLsO+mbcpr2gQnXb3PUl4qjT/NwNtwUbaE=
X-Google-Smtp-Source: AA6agR4WKgytw4if698JO1Mi0lYqIo1QVz0rt2C6JM1uBb0BUkvwx1IXxmBJfdwEQTCjAwc4cStCTQUNk4A4Q53OSKg=
X-Received: by 2002:a5d:6c6b:0:b0:225:dde:ab40 with SMTP id
 r11-20020a5d6c6b000000b002250ddeab40mr2558341wrz.690.1662566552780; Wed, 07
 Sep 2022 09:02:32 -0700 (PDT)
MIME-Version: 1.0
References: <CA+4x=b_07g6STT0nvma_gRhv=zdj+7TQx5SxKLUtuqONLwv=TQ@mail.gmail.com>
 <9676rprp-s6p4-o2r5-6s86-5939os5qn855@tzk.qr> <CA+4x=b91W31eAnShPzVw1zta43OYwArsgW0EsU1-0vkOw+qGyA@mail.gmail.com>
 <329qn1s7-s61r-277p-2q6n-194438531393@tzk.qr>
In-Reply-To: <329qn1s7-s61r-277p-2q6n-194438531393@tzk.qr>
From:   Lana Deere <lana.deere@gmail.com>
Date:   Wed, 7 Sep 2022 12:01:56 -0400
Message-ID: <CA+4x=b-eM=oZpRNi7-jmK1HNGUnd4Vdp-NBdzSaNK6C0okqo6Q@mail.gmail.com>
Subject: Re: 2.37.2 can't "git pull" but 2.18.0 can
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> What
> happens if you call `git pull origin feature/switch-to-qt5` explicitly?

$ /re/tools/linux-x86_64/opensrc/git/2.37.2/bin/git pull origin
feature/switch-to-qt5
From http://githost:7990/scm/dp/d2s_sw
 * branch                  feature/switch-to-qt5 -> FETCH_HEAD
Already up to date.

In that case, it works.  But subsequently trying without the explicit
specification still fails.

.. Lana (lana.deere@gmail.com)


On Wed, Sep 7, 2022 at 6:21 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Lana,
>
> Please find my reply inline.
>
> On Tue, 6 Sep 2022, Lana Deere wrote:
>
> > With --prune set, the 2.18.0 pull still works but the 2.37.2 pull
> > still fails.  There are several of us sharing this branch and we
> > aren't having any issues pushing or pulling with 2.18.0.
>
> Oh, so there _is_ a remote branch called `feature/switch-to-qt5`? What
> happens if you call `git pull origin feature/switch-to-qt5` explicitly?
>
> Ciao,
> Johannes
>
> >
> > .. Lana (lana.deere@gmail.com)
> >
> >
> >
> > On Mon, Sep 5, 2022 at 6:25 AM Johannes Schindelin
> > <Johannes.Schindelin@gmx.de> wrote:
> > >
> > > Hi Lana,
> > >
> > > On Fri, 2 Sep 2022, Lana Deere wrote:
> > >
> > > > I'm testing an upgrade to git 2.37.2 from the current version we're
> > > > using of 2.18.0.  When I try to pull in my development tree, 2.37.2
> > > > gives me an error but 2.18.0 things all is fine:
> > > >
> > > > $ /tools/linux-x86_64/git/2.37.2/bin/git pull
> > > > Your configuration specifies to merge with the ref
> > > > 'refs/heads/feature/switch-to-qt5'
> > > > from the remote, but no such ref was fetched.
> > >
> > > I bet this means that that `switch-to-qt5` branch was deleted on the
> > > remote side, in which case...
> > >
> > > > $ /tools/linux-x86_64/git/2.18.0/bin/git pull
> > > > From http://githost:7990/scm/dp/sw
> > > >  * branch                  feature/switch-to-qt5 -> FETCH_HEAD
> > > > Already up to date.
> > >
> > > ... Git would lie here and simply use the locally-cached version of the
> > > last successfully-fetched `switch-to-qt5` branch.
> > >
> > > To test this, you could pass the `--prune` option to `pull` (see
> > > https://git-scm.com/docs/git-pull#Documentation/git-pull.txt---prune for
> > > details), then try both pulls, and I bet _both_ will now fail.
> > >
> > > Ciao,
> > > Johannes
> > >
> > > > Anyone have any ideas about this?  All I could find on google was a
> > > > suggestion that the "no such ref" message indicates the remote branch
> > > > was deleted, but that's not the case here.
> > > >
> > > >
> > > > .. Lana (lana.deere@gmail.com)
> > > >
> >
