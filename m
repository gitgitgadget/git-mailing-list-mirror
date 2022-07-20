Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D38C43334
	for <git@archiver.kernel.org>; Wed, 20 Jul 2022 01:43:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242369AbiGTBnC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 21:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242205AbiGTBmq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 21:42:46 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23F36A9CC
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 18:41:27 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id z13so4495202wro.13
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 18:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aouzOlVTA8Tex4wPc3/eO9x3rO28GmkGiAvW9hra2UM=;
        b=Ejn2HIj3h5P8qqLrAohn0diV8FlVjPksna97jUAesqUX5E6o0NbNeXNbKX3ZHrB3wo
         qB9VSIna7JfxmQFjsG7Man9yZ9CSAj/KczBWFVvS0yYkHZc/kUKFgbWjdmbLfZru27E6
         noJiOQ6kstRveVU0KtQx+EV4tX+puzOjV7kIzAvyDWqdji//TJXbxQ8F9plZF2sc0Jw6
         NYc1Jt66k7WR/jbBF9XVQ8DBvF1fI8vJwzOpIoeMiFS1KW7o+fsDyczvleTX13rWJVFQ
         0d7qzc6yeNTEyI3CDV5tWbFpQEqkBXtXZtTSare8fVDV1k1ZfDtA90vjeGYN28Sf2ZU5
         Mdvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aouzOlVTA8Tex4wPc3/eO9x3rO28GmkGiAvW9hra2UM=;
        b=uKJrgSsZ/IE37tVvkht7P6NtxJJWy8NlD495weeYlgVNcJTJ4I0WVuI13Phom1jIQD
         rUHQtN4NjHdeUWSB8u3CNUjgzL7/wBIfgun5IpjHzG+6G9JE0gT3RYjp+WswFsX7oooo
         WyUgWzjEHzPQOiXBP2TWabsrJHhufiEwcd9/+zqWq6dEyCawcnyiMdkCSkKksB61wxeg
         nOtVBM/K6Hb3vs2vQnHdou2zKC11YoOcXzAStYL92DjcAve+4ct25wDsiLrmID12wnqH
         P7QUiJBmRgoeI7jSJtCmqfzsvOq3sx+KGLkJLPRyMib1MPkVWHSJITFxsHLBb5zn6y5G
         PxPg==
X-Gm-Message-State: AJIora/UKP6VB35DJ4rXL3ThviLFu3ETZGMBOGjjhJxxNB37Is/L/XHg
        vj2PEVMSqFYcmTjrQnf765zjvXoygYnGRDr7SKc=
X-Google-Smtp-Source: AGRyM1tJhNjvL44yk4Ua8zjYC24tdbZ89mln/29T2glSMJQ8cZvVsoYqEZBzU0Ry2czgTBlFbS08XPRxI/WDDofewuM=
X-Received: by 2002:adf:ffc1:0:b0:21d:66a1:c3ee with SMTP id
 x1-20020adfffc1000000b0021d66a1c3eemr27672022wrs.364.1658281286234; Tue, 19
 Jul 2022 18:41:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAKQoGamCrRMqtzziuzi8mL6E7uA3SC1WXiMGT_4rpbk1jcu_OQ@mail.gmail.com>
 <YryF+vkosJOXf+mQ@nand.local> <CAKQoGakSFaNm10ZeTKc8XtTcD0JW19CZP1OwA4j7W__iBQaJfg@mail.gmail.com>
 <YryKCl5J1Em89d3e@nand.local> <CAKQoGanPBec6wRO6uWrETaoJXdszpjRWytXaJwx6jw0mrrj-gQ@mail.gmail.com>
 <Yr0WLebMfBXZ1K7D@nand.local> <Yr0XMWWyD5C9uhlb@nand.local>
In-Reply-To: <Yr0XMWWyD5C9uhlb@nand.local>
From:   Gregory Szorc <gregory.szorc@gmail.com>
Date:   Tue, 19 Jul 2022 18:41:13 -0700
Message-ID: <CAKQoGakg9+cvsHSepXyWFT9Jzg0_anq-YDBNZch95TnUAZ-Ohg@mail.gmail.com>
Subject: Re: Race condition between repack and loose-objects maintenance task
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, stolee@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 29, 2022 at 8:23 PM Taylor Blau <me@ttaylorr.com> wrote:
>
> On Wed, Jun 29, 2022 at 11:19:09PM -0400, Taylor Blau wrote:
> > > However, I think there is yet another bug at play: running
> > > `incremental-repack` appears to be able to repack the cruft packfile.
> > > In doing so, it deletes its .mtimes file and the metadata inside.
> >
> > That sounds like a bug to me. I'll take a look into it and see what I
> > can find.
>
> I actually think that there are two bugs here.
>
> One is that we run a MIDX repack and expire, which could lead to us
> repacking the entire contents of the cruft pack and then expiring the
> metadata file. This is a bug, and we should exclude cruft packs from
> this computation.
>
> Another bug can happen when the cruft pack gets written into the MIDX
> and is MIDX-expireable (meaning that no objects are selected from the
> cruft pack). In that case, the `git multi-pack-index expire` step would
> remove the cruft pack entirely, which is also incorrect.
>
> I'll take a look at fixing both of these, and thanks for pointing them
> out!

For posterity, when I disabled cruft packfiles after having it enabled
for a few weeks, the next `git gc` invocation on a high traffic repo
resulted in >100k loose objects/files being created before they were
summarily deleted by the GC's prune. This is significantly greater
than the unreferenced object creation rate of the underlying repo. So
it appears as if the MIDX stripping of the cruft packfile mtimes
effectively disabled pruning, leading to a build-up of unreferenced objects.

Fortunately I hadn't deployed cruft packfiles to production. If I had,
the excessive filesystem churn on NFS would have caused an incident
due to degraded performance.

Since the interaction between cruft packfiles and MIDX appears to be
buggy, I think I'm going to leave cruft packfiles disabled until these
features work better together.
