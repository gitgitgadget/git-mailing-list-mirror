Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C13AC433DF
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 09:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D734620792
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 09:28:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JL9xwRRD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbgHEJ2c (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 05:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728100AbgHEJ1m (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 05:27:42 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4635C06174A
        for <git@vger.kernel.org>; Wed,  5 Aug 2020 02:27:36 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id x17so2813709uao.5
        for <git@vger.kernel.org>; Wed, 05 Aug 2020 02:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gPueTT3L5iSSPNgZkaT8W439N9CI1Rfafrlh8Gyd3Lg=;
        b=JL9xwRRDZbz8tMesVZyUT6T7C+bb4XOWUNNxhLizSTnJQRkPOOzA4TF7eF66o75NPV
         fxR1m8thq5WU1TlPqCMc/e4j2YuGo0D+pFh1UFSeS17JcI5PUpsOI0i0J3V0yKkgJYl3
         VRdfua+1ifCXdxgVJwTibJoJDCS1QjsU0r/XfLCSAB7mlqrOz0fgdSrXLbSAkGQdfy5Q
         6SyeFp/GJ5hpcRrh+P/bhl7PXBcyUqPFv4DTeEq/1kiuwBqbrsMpUbeTOGI6tYqwfDDM
         xiA8+zPdmwB5p84IeaqZHOPJt/W+x3Rtldk431a5B4ZxAvong3SpCbHkt5oy0UxLpw98
         q/Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gPueTT3L5iSSPNgZkaT8W439N9CI1Rfafrlh8Gyd3Lg=;
        b=i+9j7dxvTCsRIIUfRyPZC5ZBzxIaH5wwibK9vs2ZnJTxtVH2SX9vaR0dPzmwgUrEv/
         ypEV0nuNmw5HDvUTfUuWDMIwPbM3TYmfH+5V0qxcGBqAtYkMgMyHvrAim8/4RI8LOnbK
         +54fMOD7xQLcNG8Xnz9et4CMNeIs/KnccOp7tbHD7cUBmXeCQHAR2Ou5DD0Eo9QcvQR2
         AqrLrGcWnTKDl+pkyUjlQhMN6deW7rYMTb65QB3SMrfRbh2zkvPArCYTbeY4k8XYTn4X
         sBfgMNaf7w+ZRbw0rc5lhej1jFPgqEJYPebpG6/ABBdagl6PljHhgQwmZFqw/9mNx5OR
         1IyQ==
X-Gm-Message-State: AOAM530efvW0PaHqZe74SEYeWYJWLARSlt5V/JRpanAwK+FeZvUVq8UP
        +cszXXszkQKB2aBNBnAEyxXN6Xyhrneny+MxiEE=
X-Google-Smtp-Source: ABdhPJwW8sQBwm6hOtKVAvqvIx7vC2a1CPh/4K9nnfw2JBC9pV2Ij8nOwcl5UB2FTY6pjciVsuZvgEdJj1tjXi050VM=
X-Received: by 2002:ab0:1052:: with SMTP id g18mr1365820uab.62.1596619655022;
 Wed, 05 Aug 2020 02:27:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200805084240.GA1802257@coredump.intra.peff.net>
In-Reply-To: <20200805084240.GA1802257@coredump.intra.peff.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Wed, 5 Aug 2020 11:27:22 +0200
Message-ID: <CAN0heSqsHGL2Pb37d2dWL+RCWac4z8mjpM-v6v6zsxH_8cWQjQ@mail.gmail.com>
Subject: Re: racy test failure in tb/upload-pack-filters
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 5 Aug 2020 at 10:45, Jeff King <peff@peff.net> wrote:
>
>   $ GIT_TEST_GETTEXT_POISON=1 ./t5616-partial-clone.sh --stress
>   FAIL 19.1
>   FAIL 15.1
>   OK   26.1
>   OK   16.1
>   ...

[...]
> OK, so what's in that file?
>
>   $ cd trash\ directory.t5616-partial-clone.stress-failed/
>   $ cat err
>   # GETTEXT POISON #fatal: # GETTEXT POISON #
>   fatal: filter 'blob:none' not supported
>
> What, it's there!? Is it somehow confusing grep?
>
>   $ grep "filter 'blob:none' not supported" err
>   fatal: filter 'blob:none' not supported
>   $ echo $?
>   0

Nice. :-)

> -- >8 --
> Subject: t5616: use test_i18ngrep for upload-pack errors

[...snipping lots of good stuff...]

> In theory we'd see both copies of the message in the second case. But
> now always! As soon as the client sees ERR, it exits and we run grep.

s/now/not/

Very nicely explained, as always.

> -       grep "filter '\''blob:none'\'' not supported" err
> +       test_i18ngrep "filter '\''blob:none'\'' not supported" err

Right, this is the one from the intro and the commit message.

> -       grep "tree filter allows max depth 0, but got 1" err
> +       test_i18ngrep "tree filter allows max depth 0, but got 1" err

This one isn't translated, so this hunk could be dropped. Or maybe you
wanted to knowingly cast a slightly wider net? (And this does fit the
subject of your patch.)

Martin
