Return-Path: <SRS0=oWbz=C5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96AB1C43466
	for <git@archiver.kernel.org>; Sun, 20 Sep 2020 09:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4896E20EDD
	for <git@archiver.kernel.org>; Sun, 20 Sep 2020 09:44:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=diamand.org header.i=@diamand.org header.b="BD/Ki+Ix"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbgITJoU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Sep 2020 05:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbgITJoU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Sep 2020 05:44:20 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE86C061755
        for <git@vger.kernel.org>; Sun, 20 Sep 2020 02:44:19 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id w2so9290357wmi.1
        for <git@vger.kernel.org>; Sun, 20 Sep 2020 02:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K/t8mydba2FLny7qff/0PrE601TLHbe+5myVJ6Gn+CM=;
        b=BD/Ki+IxjPGMigHVuPSP7SN97Av2eW6d+VdQWmDM62uNtpmifFmxbagNT+UtfKKpm5
         iYeBR7CPJSvCPRQZuvPaGNMHlldHndGp8/cEarU2FOlHsNYEw91Kai0xLeTB5G/y4re1
         7or1VjYP+O4OIRu3O6Ptm7azNMm7JPH3LXbx8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K/t8mydba2FLny7qff/0PrE601TLHbe+5myVJ6Gn+CM=;
        b=TvhOquw8deZLqzy2TlQ/rLsGdJHfU8IfJK56sGcPehQdTXlRRs/w0PsOhAFMIJ3Lbp
         shNYFDvCvAYtYJ3VXHCKxez2V5xz4jF9SoQvd/WWGQh7O6zOGSzS7PM0MOqN42KfdWON
         jmXI4DP/L+6Vevr3mluxEEvHV4s+8BpXH+MadPJpfd1URtuPvuIl3XOUzvKs+N2KKbdA
         HsF7b1FHi4E22gOUhZWGxeiyB0nr9EahmK/EKL9yMFxpTJhwcljH3wGqtNTtQB2isndV
         Esam8lWzo6PZTJ2NgTHK0gCIydj5T79XEq8/EleAVXyM9mhk4KDowrV1AoMJ92Kmjl3b
         LC+g==
X-Gm-Message-State: AOAM530Wdw3JTKu//RNOQ4xOeTxcqtnLYIJziRAwcDp9Mp23MBXGSm2h
        nDwj0PX2JJpEnJS7ynXG+N2G3D5X2d1T6VabN0OH7G3Hd2wFiw==
X-Google-Smtp-Source: ABdhPJyi/0G4RaaYRLOku/L9mO6kOx/6lbNN7sJ1xJK9bKVGmOo64TH7jLgPjhCURyraYv1hL24Z7jhuEFbXiSDyCAY=
X-Received: by 2002:a1c:3d06:: with SMTP id k6mr24289259wma.27.1600595056507;
 Sun, 20 Sep 2020 02:44:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAE5ih78zCR0ZdHAjoxguUb3Y6KFkZcoxJjhS7rkbtZpr+d1n=g@mail.gmail.com>
In-Reply-To: <CAE5ih78zCR0ZdHAjoxguUb3Y6KFkZcoxJjhS7rkbtZpr+d1n=g@mail.gmail.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Sun, 20 Sep 2020 10:44:05 +0100
Message-ID: <CAE5ih79puooMA1v8jOkqKaO9xPmYqtkT9kXHq2L6YODJJ8oGEQ@mail.gmail.com>
Subject: Re: How to checkout a revision that contains a deleted submodule?
To:     Git Users <git@vger.kernel.org>
Cc:     Jens Lehmann <Jens.Lehmann@web.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 19 Sep 2020 at 10:03, Luke Diamand <luke@diamand.org> wrote:
>
> Maybe this is a FAQ, but I couldn't figure it out!
>
> I have a repo which has a couple of submodules.
>
> At some point in the past I deleted one of those submodules:
>
>     git rm sub2
>     git add -u
>     git commit -m 'Deleting sub2'
>     git push origin
>     ...
>     ... more commits and pushes...
>
> Now I go and clone the head revision. This gives me a clone which has
> nothing present in .git/modules/sub2.
>     login on some other machine
>     git clone git@my.repo:thing
>     cd thing
>     ls .git/modules
>     <sub2 not present>
>
> So when I go and checkout an old revision where sub2 is still around I get:
>     git checkout oldrevision
>     fatal: not a git repository: sub2/../.git/modules/sub2
>
> What am I doing wrong?
> What set of commands do I need to use to ensure that this will always
> do the right thing?
>
> Thanks
> Luke

Replying to myself, adding Jens who added the section below.

This is a known bug:

https://git-scm.com/docs/git-rm

> BUGS
> ----
> Each time a superproject update removes a populated submodule
> (e.g. when switching between commits before and after the removal) a
> stale submodule checkout will remain in the old location. Removing the
> old directory is only safe when it uses a gitfile, as otherwise the
> history of the submodule will be deleted too. This step will be
> obsolete when recursive submodule update has been implemented.

I'm wondering what "recursive submodule update" is. If I do:

    git submodule update --checkout --force --remote --recursive

then those stale repos are still left lying around. I guess that's a
different kind of recursive?

Thanks
Luke
