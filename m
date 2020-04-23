Return-Path: <SRS0=24D7=6H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B21C54FCB
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 16:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA69420704
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 16:15:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oy4Grxcx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729423AbgDWQPP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 12:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728865AbgDWQPO (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 23 Apr 2020 12:15:14 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6B8C09B041
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 09:15:14 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id n4so5093453ejs.11
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 09:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=u43m4UqDtKZIxZZRugSWMs64twUPE6eiFcozGd2OFGs=;
        b=oy4Grxcxr6b5p1B7sm2zHqoMAFhwExkP+CYqgCGC8AXvTW2oUee0XVSHpDw9DBaMWO
         rSOZYKkfz090IFEAIHxET8XRKuUKlGwHcB3npW/NirgOfxMtNvyK41aRqAelmwlELZ8s
         989KdOaGPCdrHRFwI0LbmF/aGvY9I/xzAEJx44P1dLNTtTO1pkrt5L4RcjnnTeTTtIMm
         Tm5GTf6ReBx3PgILKpI/xgT/m08V8+YhI5+Fa37wN/7tTzPO+2nZCc8AuFxlyYLmqeVA
         1R/MJEixqzas7Npceoeh5ONHVAqbCFLqnLHVFywTfrOPmIaa4+5G7w4JV9h9O8d2kOTV
         yY5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=u43m4UqDtKZIxZZRugSWMs64twUPE6eiFcozGd2OFGs=;
        b=hn43fa/kzcUbOCzvDri9NBcX9JSVnhwtOaOZR6DHuzCnPi2ro+ZCpd8PDrK/nsdZZE
         zuOSIfybzphW0a0dmFtNPzti85cJmBIdrwqTHhEjF5LjObSnhtgdTkSvL5wvhd4YFbLC
         0YZFmctQR4Jz0UkAY6rh8WD5fXZ+H72nuoWX+KlOx534XYxz913RNSSwvzM7eshoASEl
         4fOSH9o/59srmActuF3nTJXer/Uo2SNRqvhYiOwJtZSUV4qclaCvN0W5dflS3g2qYUvx
         GmiOZO8auj3zUF77EVg26lU3V6SUIRrgg0n8PUEQytxISpmRMtclhlukqKHXshPfB7DN
         gu2g==
X-Gm-Message-State: AGi0PuYSfTt238OytmCBkniY5be5ZDA1Ik/rnsZ2ZlVPgeAs51+KGv8r
        nu2U4h5hAbz6mlBtYVrvtGbPSV/WwQRJ2Xb2mCc=
X-Google-Smtp-Source: APiQypJR5CcK/nfn0+Mys5/0ehCSI0NjG9hbWmlZUxJ04sEyK9CJIFwCOlGPvyg4Atn3K2KlSPgutxwqEkatUz5ZOv8=
X-Received: by 2002:a17:906:288b:: with SMTP id o11mr3398546ejd.237.1587658512803;
 Thu, 23 Apr 2020 09:15:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAP8UFD2iR2TOoU-HJvOiQvZhJ+ebxX6zs+KfM-CCFKHSYuwNSg@mail.gmail.com>
 <8fb4c61f-56fb-6650-d12e-7aea5f48828a@iee.email>
In-Reply-To: <8fb4c61f-56fb-6650-d12e-7aea5f48828a@iee.email>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 23 Apr 2020 18:15:01 +0200
Message-ID: <CAP8UFD0gO0Qaip84Q+dOzCwirTOEQnJNCeBQrBmCzvjQ6s2KCA@mail.gmail.com>
Subject: Re: Draft of Git Rev News edition 62
To:     Philip Oakley <philipoakley@iee.email>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philip,

On Thu, Apr 23, 2020 at 1:44 PM Philip Oakley <philipoakley@iee.email> wrot=
e:

> A couple of light reading articles were mentioned in the stackoverflow
> blog #17
> https://stackoverflow.blog/2020/04/17/the-overflow-17-legally-beige/
> (verbatim extracts)
>
> 1. CS visualized: Useful Git commands
> <https://dev.to/lydiahallie/cs-visualized-useful-git-commands-37p1>
> https://dev.to/lydiahallie/cs-visualized-useful-git-commands-37p1
> Oftentimes though we use commands that we know work, but we don=E2=80=99t
> understand how they work under the hood! Here is a great series of
> visualizations of git commands to understand them more at a theoretical
> level

This one had already been added by Jakub in:

https://github.com/git/git.github.io/commit/44e19bb6ce35fccb67d0e45087602a8=
b586bde01

> 2. The phases of remote adaptation
> <https://about.gitlab.com/company/culture/all-remote/phases-of-remote-ada=
ptation/>
> https://about.gitlab.com/company/culture/all-remote/phases-of-remote-adap=
tation/
> GitLab put together a really interesting list of phases for teams
> switching from a colocated environment to a remote one. It=E2=80=99s a go=
od
> reflection on how your team culture might work, and how to be prepared
> for changes.

Thanks! I just added this one at the end of the "Light reading" in the edit=
ion:

https://github.com/git/git.github.io/blob/master/_posts/2020-04-23-edition-=
62.markdown

> Both of which were interesting and potentially useful.

Sure!

Best,
Christian.
