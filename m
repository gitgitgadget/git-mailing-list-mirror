Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3133C2D0E4
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 01:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A56E241A7
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 01:45:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rejxdF8E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726020AbgKRBpe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 20:45:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgKRBpe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 20:45:34 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 345FCC061A48
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 17:45:34 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id c17so297897wrc.11
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 17:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1GwK4I2TuLD0wgS1zxpshCH3DodWZ6f5KCcjQOd+vX0=;
        b=rejxdF8Eca66Ges53kbBXDlbmSL/WQJURVvMsJruDgK/1JAJ+NMQKqq3oaiKgHDIYy
         pJmztFYLLBLJgySweAwl9kAI7n90kXUglLPBxLrCUenH16yB/5Sf2gsJtgyU7voYcu4d
         +GVh9N1pg9dLFFSajUS72AlHLuoCmEiJkFD8xKNYu5U9FGbipk/2W/cKraeAcOqxw1Q+
         D2qFQX1Lc88PkhrNQsiJje8BlSTpQiKNYujz1suQkClSmjYwbR5F80Nozs5x4dfRXljj
         5DyJq0ygkxwtUR5kp1uPIq8g3jdT/7vmUqQqof3cPyy/YujWhWmVgXqXJOB8ZHzGo9Ay
         YS/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1GwK4I2TuLD0wgS1zxpshCH3DodWZ6f5KCcjQOd+vX0=;
        b=XsImCkdp8dBTiVaYVVBVgziYY0PM+UAM2GLZFwPZ/huZ7B8pvuZuvsM2fxxuzMrGej
         WFbuf1pgIE2qhorC5N1XEpT4ixxji5ruYZBi0n3kDPFQ9XVeNHHwBtAGvLRxTt2NvGpP
         cuDaFzaoWJEGeGODbvjkQRWY4IvQQ34X1rm1b3g8i9xdZV879qUTfENpiIcruScRg1X3
         5DofRXZNazA+twUdWPhWidYg//5S2WKJOzA7sD2NyRHsW3FR7XpW/v8hU3z5xWqsfh79
         qAqU8iZ1sHnKF35mSxHxLsqGb6bGhFO01K6f8f7yO0S1VzPEq6wFT2iglt5dvsa/l+M3
         nJgA==
X-Gm-Message-State: AOAM5309htcdfYbvp6gdEsvoTgZ3ZtlxWS3T8xhsoqwwhsAKQdcamg4U
        IEtRcWxcLN+bSC/0gqH9pRq8JPGsZuV7dUkkzmc=
X-Google-Smtp-Source: ABdhPJzTkVyaCDgFz33KsqwmYSf9sxZ8mBcby+Kum9SddhN+QY1ne2jPjAPnVzA/zXWy37pfYfEWcmsgrL73AACIBG8=
X-Received: by 2002:a5d:4349:: with SMTP id u9mr2181338wrr.319.1605663932787;
 Tue, 17 Nov 2020 17:45:32 -0800 (PST)
MIME-Version: 1.0
References: <pull.762.git.1605221038.gitgitgadget@gmail.com>
 <87r1oraewl.fsf@x220.int.ebiederm.org> <CAMP44s2VJOd3N2zaj8YPv0iLOqTF7vWyZ=zPd9vd0+qO1DbEVA@mail.gmail.com>
 <20201117233313.GB642410@coredump.intra.peff.net> <CAMP44s1HhiDYfji9L2sj3QbCDmsb9dnrLCS6cQJPbmS1F3vKoQ@mail.gmail.com>
 <20201118012230.GB650959@coredump.intra.peff.net>
In-Reply-To: <20201118012230.GB650959@coredump.intra.peff.net>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Tue, 17 Nov 2020 19:45:21 -0600
Message-ID: <CAMP44s1t3CKF3btQwSwaz_Pu2fE6PGyb+_iMW8dAbY3aE3mH7w@mail.gmail.com>
Subject: Re: [PATCH 00/28] Use main as default branch name
To:     Jeff King <peff@peff.net>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 17, 2020 at 7:22 PM Jeff King <peff@peff.net> wrote:
>
> On Tue, Nov 17, 2020 at 06:18:03PM -0600, Felipe Contreras wrote:
>
> > On Tue, Nov 17, 2020 at 5:33 PM Jeff King <peff@peff.net> wrote:
> > > On Tue, Nov 17, 2020 at 04:47:56PM -0600, Felipe Contreras wrote:
> >
> > > > This should be easy to do if we make "origin" be a pseudo ref that
> > > > points to "origin/HEAD" (and we could introduce "origin/@").
> > >
> > > Didn't we already do this long ago? refs/remotes/%s/HEAD is special in
> > > the dwim_ref() lookup:
> > >
> > >   $ git rev-parse --symbolic-full-name origin
> > >   refs/remotes/origin/master
> >
> > Hmmm. For some reason none of my remotes do have a HEAD.
> >
> > If I do "git remote add", and then fetch, the HEAD doesn't seem to be present.
>
> Yes, I have run into that, and it's definitely annoying. The
> refs/remotes/<remote>/HEAD symref is created by clone, but is not
> updated by "fetch". That's intentional, because it's supposed to
> represent a local choice (that is merely seeded by the remote side). But
> it seems like adding it if it's missing might be reasonable.

The equivalent of this choice is in "git remote add -m":

  With `-m <master>` option, a symbolic-ref `refs/remotes/<name>/HEAD`
  is set up to point at remote's `<master>` branch. See also the
  set-head command.

This is of course inconsistent. Is it the "head", or is it the "master"?

Presumably if we want to avoid the term "master", then this option
needs to be renamed.

In my opinion unless this option has been explicitly set,
"origin/HEAD" should keep track of whatever remote head is set.

If somebody updates its remote HEAD from "master" to "main", then
origin/HEAD should be updated accordingly. Granted, this may be some
overhead in the 99.999% of the cases where the remote HEAD is the
same, so it may not be worth even thinking about it.

But at least the first fetch after "git remote add" should fetch it,
in my opinion (unless it's manually configured already). I'm not sure
if origin/HEAD can contain some placeholder so that "git fetch" knows
what to do.

Cheers.

-- 
Felipe Contreras
