Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D01E9ECAAA1
	for <git@archiver.kernel.org>; Tue,  6 Sep 2022 18:39:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiIFSjK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Sep 2022 14:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbiIFSjB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Sep 2022 14:39:01 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB035B940D
        for <git@vger.kernel.org>; Tue,  6 Sep 2022 11:38:55 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id m17-20020a7bce11000000b003a5bedec07bso10177602wmc.0
        for <git@vger.kernel.org>; Tue, 06 Sep 2022 11:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=6d3GJ+dlVZl+OLtKX3R4wOjocGsnfy+0gorRL0IwMsI=;
        b=PEgBJTFnKHgAbtTVZ9Nz4ZToJdgGvsZOvwZrWBxSq5RhSVEzAscHsFq4F3/Hni/Ucc
         FQuWykOfCdaofZUsmpupZuco1I7fqYATbh0cmZiJM3kgkkgjz7B1ABb/L+Q8t3NNmK4i
         Dg2/rQDj/hIVHjs0mG15WtKL0e1o8vDrTL6mmE04IJW33GlWyppqHMwr2QR2n9sL2GSV
         uG2s0EFvIGIimuLLyZKjDim0ctpI3U5OtB6b3uIYmGsINbKYaML0J/Byc6VCJSFIw9Sb
         olKuo4r9HfvJSZ1QqzEV2b1HsFAcWr/N5po/mssbs8gwizL/E/rhG93VrAeodHOYCHeI
         EXxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=6d3GJ+dlVZl+OLtKX3R4wOjocGsnfy+0gorRL0IwMsI=;
        b=2V90nM+Sjh8Zz/gOm0Fgl+jbf3EIJrq3+hbTGOThUqvbzMS1QC65f8koMKGHGHJpt7
         llw8VK3xhp/nUlCY/69UJO2TP/QSsw5ufZLfzd7NG5reN45PXhlMl28npTFIwaFuNlSI
         +gBb4NsAtfVc9fZb4Wr1bLmEz4VHnVbnTNBodDcam/cPVd26GCKY+JO90k2nTj096P+k
         pG03zxckLK5+EXSrXcgK+jvXoDJWhqSE1ULshBU2phuteyaT1NwWv7rOqI7P9ZjzDniz
         qd5Ixbzd3Xijpzo57T4OgIPjmZBahIaQ3pJG2FAQeiAYFwO7FUoOD37bn4779C4IbXqs
         BPEg==
X-Gm-Message-State: ACgBeo3vtZVsaDVJoIiFWGE8BHWCADtfQJstzP3oY6anBRc0EvTf4xP9
        6nXd3BqyHfrQZMVTzRDK8KPVZ/7G4YdzbOXUpcZkMA2h
X-Google-Smtp-Source: AA6agR5nbdFAgSg6z2NlJ6o6B+PZowJ+89+AUcqY3Spbovtoa+GnbdDH4xNyl0EjYHsI2wpkUdQ9CYZPS2x3uw2475I=
X-Received: by 2002:a7b:ca42:0:b0:3a6:9d:a444 with SMTP id m2-20020a7bca42000000b003a6009da444mr14880859wml.51.1662489533429;
 Tue, 06 Sep 2022 11:38:53 -0700 (PDT)
MIME-Version: 1.0
References: <CA+4x=b_07g6STT0nvma_gRhv=zdj+7TQx5SxKLUtuqONLwv=TQ@mail.gmail.com>
 <9676rprp-s6p4-o2r5-6s86-5939os5qn855@tzk.qr>
In-Reply-To: <9676rprp-s6p4-o2r5-6s86-5939os5qn855@tzk.qr>
From:   Lana Deere <lana.deere@gmail.com>
Date:   Tue, 6 Sep 2022 14:38:17 -0400
Message-ID: <CA+4x=b91W31eAnShPzVw1zta43OYwArsgW0EsU1-0vkOw+qGyA@mail.gmail.com>
Subject: Re: 2.37.2 can't "git pull" but 2.18.0 can
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With --prune set, the 2.18.0 pull still works but the 2.37.2 pull
still fails.  There are several of us sharing this branch and we
aren't having any issues pushing or pulling with 2.18.0.

.. Lana (lana.deere@gmail.com)



On Mon, Sep 5, 2022 at 6:25 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Lana,
>
> On Fri, 2 Sep 2022, Lana Deere wrote:
>
> > I'm testing an upgrade to git 2.37.2 from the current version we're
> > using of 2.18.0.  When I try to pull in my development tree, 2.37.2
> > gives me an error but 2.18.0 things all is fine:
> >
> > $ /tools/linux-x86_64/git/2.37.2/bin/git pull
> > Your configuration specifies to merge with the ref
> > 'refs/heads/feature/switch-to-qt5'
> > from the remote, but no such ref was fetched.
>
> I bet this means that that `switch-to-qt5` branch was deleted on the
> remote side, in which case...
>
> > $ /tools/linux-x86_64/git/2.18.0/bin/git pull
> > From http://githost:7990/scm/dp/sw
> >  * branch                  feature/switch-to-qt5 -> FETCH_HEAD
> > Already up to date.
>
> ... Git would lie here and simply use the locally-cached version of the
> last successfully-fetched `switch-to-qt5` branch.
>
> To test this, you could pass the `--prune` option to `pull` (see
> https://git-scm.com/docs/git-pull#Documentation/git-pull.txt---prune for
> details), then try both pulls, and I bet _both_ will now fail.
>
> Ciao,
> Johannes
>
> > Anyone have any ideas about this?  All I could find on google was a
> > suggestion that the "no such ref" message indicates the remote branch
> > was deleted, but that's not the case here.
> >
> >
> > .. Lana (lana.deere@gmail.com)
> >
