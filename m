Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D79A0C63697
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 09:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E2102463B
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 09:05:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q4g0hbq7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgKRJEl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 04:04:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726503AbgKRJEj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 04:04:39 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86481C0613D4
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 01:04:39 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id p19so3679876wmg.0
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 01:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZvLaenwq+ZS5JLjDA8IqVhoRiTQeDKKJJk/N9AXz0UU=;
        b=q4g0hbq7VOTqzCjGBjNXyV2laWTXHst0Y7ucZvfs+N2b/2O3Wn4ozb1YM7viFIi4eS
         Ysl32IZUCgMZgX7J1zL2J9ELuh6DawJXwf3Id6g20MXJItszV/GbnUgs8EMT07NiuE8y
         PlaWA4KR9jFCioliAWUE/3rvaocL34hiWiBazZcWQtlTwTbYLNe2ygfQfN6xOCDeRWLb
         kPGelzPhyPFm3pJRtpXLoI97ZT039glK5GNpNtFTMfdKEjp9xm2CmzxNh584/xOBtQRM
         kuLf99amQbv9138qRVil2JP0JQvVldhWOiPhT3pE+5lBXP90yXTnVVRuW1WrsOMIIAIj
         2Miw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZvLaenwq+ZS5JLjDA8IqVhoRiTQeDKKJJk/N9AXz0UU=;
        b=V5Rc9lqNrLPVJTamV698pFvrA+AQFgidn9LsYihJVhRfVECd2RkPdr/5xwO+n3vBIa
         QzcIVHEF0HRf5TE7+oZKSh1ciJl2RvHKYyTn03gTEke22HvvmMGCD119oNLi3W0kMIIA
         kyDnemXFjcemj0rd8GgUcUqXyj2dkSu9NRs31wFjFKU5jKAhJtgwpzzmdaz2Cu79odeR
         5PJbw4+6rCY9kp8QMG952xFwnR22n9N0VAU846bDa0JucWk19w1VOcEGh0biqpcw3Lm8
         iukxnroUHAVBZE1W22YUz2enX1oRK4XVhaB7TQQhvRoLmOqvX3tweuMmOxsahV0Ixopl
         /fSQ==
X-Gm-Message-State: AOAM5323cd0SjgQE31yqvuB/AASqdADrzd1dv+hmQTmWUrW0ajumVhBb
        s6qdWXN0s8RJbJTY/YTvTAxry/ajq8SkICGvtto=
X-Google-Smtp-Source: ABdhPJxUL8MIDTvb3iIlKQkC6Cl4KErNhO5eH8722z+dbRzezKN+C8t8DhPtDgD0h0S2YNwFQKYx6KJFUUMp34ueSM8=
X-Received: by 2002:a7b:cc94:: with SMTP id p20mr3457058wma.100.1605690276736;
 Wed, 18 Nov 2020 01:04:36 -0800 (PST)
MIME-Version: 1.0
References: <pull.762.git.1605221038.gitgitgadget@gmail.com>
 <87r1oraewl.fsf@x220.int.ebiederm.org> <CAMP44s2VJOd3N2zaj8YPv0iLOqTF7vWyZ=zPd9vd0+qO1DbEVA@mail.gmail.com>
 <20201117233313.GB642410@coredump.intra.peff.net> <CAMP44s1HhiDYfji9L2sj3QbCDmsb9dnrLCS6cQJPbmS1F3vKoQ@mail.gmail.com>
 <20201118012230.GB650959@coredump.intra.peff.net> <CAMP44s1t3CKF3btQwSwaz_Pu2fE6PGyb+_iMW8dAbY3aE3mH7w@mail.gmail.com>
 <20201118020618.GE650959@coredump.intra.peff.net>
In-Reply-To: <20201118020618.GE650959@coredump.intra.peff.net>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Wed, 18 Nov 2020 03:04:25 -0600
Message-ID: <CAMP44s1G9vqrCPsev-uy6G6dEpB-1MXkeqG7Gt_fyHnoCVcLsw@mail.gmail.com>
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

On Tue, Nov 17, 2020 at 8:06 PM Jeff King <peff@peff.net> wrote:
> On Tue, Nov 17, 2020 at 07:45:21PM -0600, Felipe Contreras wrote:

> > The equivalent of this choice is in "git remote add -m":
> >
> >   With `-m <master>` option, a symbolic-ref `refs/remotes/<name>/HEAD`
> >   is set up to point at remote's `<master>` branch. See also the
> >   set-head command.
>
> Wow, I'm not sure how that option escaped my notice for all these years.
> Of course it would be much more useful if it pulled the value from the
> remote HEAD (but again, unless we use "-f" we are not contacting the
> remote at all).

Seems to come basically untouched since 2007:

  b6f5da1e0f (Teach git-remote add to fetch and track)

> And then it is just a question of what the default is. Currently it is
> "never". I suspect most people would be happy with "always", but it does
> break some existing flows. But perhaps "create-if-missing" is a good
> medium.

Agreed. Personally I don't see any problem with "create-if-missing",
but creating a configuration and defaulting to "never" should be a
good first step.

I'm sending an RFC patch to that effect.

Cheers.

-- 
Felipe Contreras
