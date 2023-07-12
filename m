Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF20EB64DA
	for <git@archiver.kernel.org>; Wed, 12 Jul 2023 20:33:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbjGLUdh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jul 2023 16:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjGLUdh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2023 16:33:37 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9D319B9
        for <git@vger.kernel.org>; Wed, 12 Jul 2023 13:33:36 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b7441bfa9eso2153311fa.0
        for <git@vger.kernel.org>; Wed, 12 Jul 2023 13:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689194014; x=1691786014;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+O3EtsR7LurV15vGa7EEnXPoMfULWcWxAAoCiRLX9Fk=;
        b=fsvCUHmoIjXyiY/NUuP6NvKkcHfIWkKGCz6iQbmx9l8QDKsYVNdmpwnsHhk9SoKlLA
         WiQG/5raKu4+FMC2fP2ez09sqMD4JJuFrI+caUcvosSihjQ/oZeCyCsisAvJWN+fMS2v
         kdjdS8+aU58Qtd9wlS04FtqTEunbWicIzCIaJsf6xMm/u0u886SK2nxxBCMtddnMNC9k
         JmlTBSghVP+BeEjb1O7Zp0iM1V2ngYaK9rsD2/hzxsRiHEOgV+ZXd6EcKnXvl/se3JW7
         T8r8fTZbRWgnrrzFx4Ck3cTDmIIgUjg7v47t2/p/gbPodwJbm3FpdhQLzeFKXO3Wi8Pb
         6kxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689194014; x=1691786014;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+O3EtsR7LurV15vGa7EEnXPoMfULWcWxAAoCiRLX9Fk=;
        b=k0LNFu+pko9ZhvmbYWN9zbG3XsR0m5mnNPDmsCDPMRhou8rlRHaHv+VLLWbzOZ4XZe
         8BySBOjE0YPxs1SgUCym9Ko6LojFg1Qj6G9QnYtn/yOLcWBt6O4zHvIP3v+YHeMu17+L
         XXHSFj3E8bhaHTshh3PY9BfLhkFBu1U8f/1A3F4j2sMXmiqQobkOXFWjzT5YI4ziieil
         jBmf+AdLCpJlxK6XPbocV0yfugkr3eeRxHSAoSrXUYPzixL0u8al1+tkmN7wF0ArlKYi
         KtEyN9wxc6pMtjYPlxARje/vE8/+VTmHYc722oSMQgM1qNT+C2HqGyk4bFL3916j5NVM
         js7w==
X-Gm-Message-State: ABy/qLaFd2w5lEqL+2QyOZSraw3F6nwHNW9pAlF8FDrG9hZRTDKGoPcO
        bgD6lbbesmlioQcrewU3AZlbRajneGUlOdWQ2bba3d6ej+o=
X-Google-Smtp-Source: APBJJlEauQenolGcq6BVr09gaI20qcW2di5TzfoFYBnyhpdY2uoMv9bxwHgr/uzh13lV7fE44cswCX/nzrtB3uz5oUA=
X-Received: by 2002:a2e:b10f:0:b0:2b6:a694:aaa1 with SMTP id
 p15-20020a2eb10f000000b002b6a694aaa1mr1183199ljl.1.1689194013938; Wed, 12 Jul
 2023 13:33:33 -0700 (PDT)
MIME-Version: 1.0
References: <CACZqfqAB7zyn56+NOL=E8Y3bXNiQnJdmVXgzsnj78C-Anw-h2Q@mail.gmail.com>
 <xmqqbkghw4qd.fsf@gitster.g>
In-Reply-To: <xmqqbkghw4qd.fsf@gitster.g>
From:   Josh Soref <jsoref@gmail.com>
Date:   Wed, 12 Jul 2023 16:33:22 -0400
Message-ID: <CACZqfqDE-SCOqVX9a8KCLAn1zSVbYxuCeU8Y=3-nhj5wbL=AWQ@mail.gmail.com>
Subject: Re: [rebase] `fatal: cannot force update the branch ... checkout out
 at ...` is confusing when it isn't active
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Soref writes:
> fatal: cannot force update the branch 'main' checked out at
> '/private/var/folders/r3/n29fz25x72x191fdv6mhhr3m0000gp/T/tmp.fGD64HAf'

> It's true git in the repository does have a pin of sorts for the
> `main` branch and that `git-rebase` would be very upset if the
> branch's location were changed, but as an end user, the `main` branch
> is not checked out, the `next` branch is checked out.

Junio C Hamano wrote:
> Fair enough.  Perhaps "cannot force update the branch 'main' in use"
> would alleviate the confusion?

That would be better.

Even better would be to tell me what's using it (rebase). I'm not sure
how possible that is.
