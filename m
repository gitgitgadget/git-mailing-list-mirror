Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E22C636D3
	for <git@archiver.kernel.org>; Fri, 10 Feb 2023 11:32:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbjBJLcy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Feb 2023 06:32:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232251AbjBJLcp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2023 06:32:45 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2425671F04
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 03:32:44 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id j17so7884176lfr.3
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 03:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o8tWMgR0JRc2DP8AadhfFTLE8DFM+OzgVOyLbYf21EU=;
        b=mCBsm9lDNRjU9ELr/qJXOC5KZWLwzE+vxL/df3FgiJW53CqDAiOLhOjPvhqF2oCKpY
         VBe+Xo9I2Y5mJcdT40BAUPufOEQACd+VqUjpWdQF6daUuL6WHNg6ez551dcADlk0iiCh
         rdguorZxx9b6tX6r6bYyI1emaqI8aGeAHvihmQP44KLHze3Dv/3zB/kRPhhlyafJ3g/N
         X2GgmocLNw0v0Okcj3HLvPp0gPD7P0UMprCzYThtUubv/J6RJ7GKYKrCCZ+0/KKCoKaA
         qXrcDz9RKGQztqkROhX8qiCdpZ7wBAqYzasfHxWWK4qvZhu/cdvW8rk0OhWZaWZ94W96
         VYyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o8tWMgR0JRc2DP8AadhfFTLE8DFM+OzgVOyLbYf21EU=;
        b=T8QspTDVJktyXlaiyOYM1tOTkycE8L1YHprweSNY3yyPvaBPFgWbZsf5pGJJYZDpOn
         B9G+rDXU8C3KY9I/xWHuUNh/+IIYb6oZwcmxL+hR8wJaEqydAlCfKc8y+xZAY/2CUf+a
         pNFh3uKwIalOeLNUAVv5pKEP2M5VT7BYuTXsSp+sBSuv7p1cKj5pT0YBE9nGhOSqkyaQ
         Az99W4233GYDknJof3+FVg9ZQkErIrte4eLO+ZcF3q9LKJ/P3VNBgqutvUavtDvDrhzm
         K+0ZT4MhShO2op+2B3bbcTMN2Ih22/jJsTiNpVoEIl8XeVSjnKLOMlKEqoXPRGdDmR62
         wrhw==
X-Gm-Message-State: AO0yUKWAsk1189R0ze0HYy6Jd1QUJIgzLAb4uw3Deekn41GdoLMbNPSh
        gBZcvhHeZhOLBkW7LcBQ5zyzwnjzCBAPrq0XJmTmf9/51Z0=
X-Google-Smtp-Source: AK7set/XUWnwAcsfZUkCzwrV3M1VY7IZtFmlEDa7GFf1XCuAo6KzdLypyHh28H8ILd61EsF+u2XYieWGkgTX1LozW7s=
X-Received: by 2002:ac2:4ad1:0:b0:4cb:ce4:7bf0 with SMTP id
 m17-20020ac24ad1000000b004cb0ce47bf0mr2712971lfp.78.1676028762358; Fri, 10
 Feb 2023 03:32:42 -0800 (PST)
MIME-Version: 1.0
References: <20230210080110.32983-1-vinayakdev.sci@gmail.com> <CAPig+cS-9gbxb3tWqaWtsjfiQR60GQXpfCKM7-neu6AH8rUvcA@mail.gmail.com>
In-Reply-To: <CAPig+cS-9gbxb3tWqaWtsjfiQR60GQXpfCKM7-neu6AH8rUvcA@mail.gmail.com>
From:   Vinayak Dev <vinayakdev.sci@gmail.com>
Date:   Fri, 10 Feb 2023 17:02:30 +0530
Message-ID: <CADE8Naoq4N9EpSfb8=ADPRLeAsmjVhL+ayOzhS=syaZ0PQh71w@mail.gmail.com>
Subject: Re: [RFC][GSoC][PATCH] t9160: Change test -(d | f) to test_path_is_*
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 10 Feb 2023 at 16:38, Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Fri, Feb 10, 2023 at 3:05 AM Vinayak Dev <vinayakdev.sci@gmail.com> wrote:
> > Changes test -d and test -f commands in
>
> s/Changes/Change/

Sorry for this error, I actually sent the patch before I got your
review of the prior one.

> > t/t9160-git-svn-preserve-empty-dirs.sh to test_path_is_dir and
> > test_path_is_file respectively, which are helper functions defined in
> > t/test-lib-functions.sh
>
> This summarizes the changes made by the patch, but readers also want
> to know _why_ the changes are being made; in fact, "why" is more
> important. Previous patches similar to this one have explained that
> test_path_is_dir() and test_path_is_file() are superior to `test -d`
> and `test -f` because the functions provide diagnostic output when
> they fail, and that diagnostic output can make it easier to debug a
> failing tests. So, if you reroll the patch, focus on explaining the
> benefits of the functions rather than explaining the mechanical
> changes made by the patch.

This is correct, I will make the message more informative about the
relevant aspects of the changes.

> > Signed-off-by: Vinayak Dev <vinayakdev.sci@gmail.com>
> >
> > vinayakdsci (1):
> >   Change test -(d | f) to corresponding test_path_*
>
> As with the other GSoC patch you submitted[1], this one is also
> missing the "---" line below your sign-off, which tells git-am where
> the commit message ends. As mentioned in [2] you may need to adjust
> your tools or workflow to prevent the "---" line from being stripped.

I apologise for this mistake again.

> The actual changes made by the patch are probably reasonable (though I
> don't have CVS libraries installed presently, so I wasn't able to
> actually test the changes).

If by testing you mean running the test file to ensure there are no
errors, I did do it thoroughly before sending the patch,
so I can vouch for the changes :)

Thanks a lot!
Vinayak
