Return-Path: <SRS0=2Qsv=4E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C2EC2BA83
	for <git@archiver.kernel.org>; Sun, 16 Feb 2020 10:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A65AA22B48
	for <git@archiver.kernel.org>; Sun, 16 Feb 2020 10:39:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RiIdnjSK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbgBPKjG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Feb 2020 05:39:06 -0500
Received: from mail-ed1-f49.google.com ([209.85.208.49]:43285 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgBPKjG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Feb 2020 05:39:06 -0500
Received: by mail-ed1-f49.google.com with SMTP id dc19so16892201edb.10
        for <git@vger.kernel.org>; Sun, 16 Feb 2020 02:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CCa6tUdbmdKxgVOWt1ixLshWkNqLzfUwBJb+JCIfFUo=;
        b=RiIdnjSKDhcNhy8WYsu5CLGmwAqh+ef5OSvguTtmDan/vO6yhpMKKY4rAbOTytS1sw
         npefiM4SXNADIjLMedK+m+WCXfixhj1D6qtLw0q4+aiNwglHd+LAzd1MlbAZONLUihlr
         qCdID1yHgt+znzxqG9idxLnRbW+ueInerHYntFkvR/5UpqNoHKtoj41tRBaFm3+FktOu
         tpjp/vBQab9ILgtjh0+kSwDQn/ayjKFYxQtfjSfQzT+0N+IbvRnhSwPSi6lufuJ40uZ5
         TupmYcImoCeoIQa/LtPYYv5UKHYHOd6yzNq+1sKDCyafC/U6FR5PkTQkbt9GsDUImamz
         xndw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CCa6tUdbmdKxgVOWt1ixLshWkNqLzfUwBJb+JCIfFUo=;
        b=jKyFU/xoozHKKKtIDKpWnGjZiQ18VWKcsyLd6vJdjaEfOGluhJhTgg2ximHDyp0ECF
         1VI89R60Pmw/tFQJYCDoi95idb+fi87G3oyzVNBylrNbHOl3Erm0sHatNNwIqgBTXJ0I
         qi6GprkHLkbCdblEuWpG1c2lf1Pu+5IXMTFIR59Tj5/0JW7N+eJHIYJVMvKt/Jg/caVt
         FCuAEmhe4VSz1DK+kVUdn2aLVKxTlYIbnFW0ODNuXTNoARMJjsF7klY0W4gIIPl6VSMK
         D3ER8kM9W7ZOalJrE01XDxiSP7n9sBvH/O3ti+Oe47FxtFk6cjJD/CdmCrse4JGzkiVm
         2FXg==
X-Gm-Message-State: APjAAAW60t/F6dR3Oj420fXhaPSU8tq7YGBT6pCh51OBra4Ica9tYFUZ
        01S7nA26I5qTsly0BbNY2R3JH3UHKdPpmbaxaNw=
X-Google-Smtp-Source: APXvYqykmZ+VCVTPMkqwfdOtJBaEF+ar4wgaPbwJrNXk1sIw2vf5Ns2akzM/rJasjczLVab5+s7J0m7GnzhUOs+bfxA=
X-Received: by 2002:a50:fb13:: with SMTP id d19mr9561877edq.87.1581849542657;
 Sun, 16 Feb 2020 02:39:02 -0800 (PST)
MIME-Version: 1.0
References: <20200122053455.GA51054@coredump.intra.peff.net>
 <CAP8UFD1-cswU0gSX3a2KqiExhYgY_qMZ6Sz7FHdxs7mrb_hh-w@mail.gmail.com>
 <CAP8UFD2_qmB1q9vhz=BJo3XG4jnLWDPhCVVb4gAh_pfKoGnZJQ@mail.gmail.com> <20200204163716.GA7308@coredump.intra.peff.net>
In-Reply-To: <20200204163716.GA7308@coredump.intra.peff.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 16 Feb 2020 11:38:51 +0100
Message-ID: <CAP8UFD3UewcZ3oid_SiUYuFEO49JTzaSigHDTP8OPs2yh6s6zA@mail.gmail.com>
Subject: Re: GSoC and Outreachy Summer 2020?
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 4, 2020 at 5:37 PM Jeff King <peff@peff.net> wrote:
>
> On Tue, Feb 04, 2020 at 05:11:20PM +0100, Christian Couder wrote:
>
> > > As with https://github.com/git/git.github.io/blob/master/General-Microproject-Information.md
> > > the idea is to not have separate documents for each year and each
> > > program (GSoC or Outreachy), but rather point people to the same
> > > document that we should update regularly.
> >
> > While at it, I just applied on behalf of Git to the GSoC 2020 and I
> > sent invite to possible Organization Administrators. I am one of the
> > admins already but we need another person to accept the invite before
> > tomorrow as they require at least 2 admins. This is the only thing
> > left we need to apply.
> >
> > The information I used to apply is in:
> > https://git.github.io/SoC-2020-Org-Application/
>
> Thank you for getting this going! I'm happy to be the second admin (and
> am signed up now).

Thanks!

For some time I have been thinking about trying to get more former
GSoC students and Outreachy interns helping us with mentoring. Here is
a pull request that could help, but I would be happy to get opinion
before merging it:

https://github.com/git/git.github.io/pull/414

(It adds a note about giving back and mentoring to
https://github.com/git/git.github.io/blob/master/General-Application-Information.md)

Best,
Christian.
