Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF208C678D5
	for <git@archiver.kernel.org>; Wed,  8 Mar 2023 07:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjCHHre (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Mar 2023 02:47:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjCHHrc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2023 02:47:32 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96BC999C07
        for <git@vger.kernel.org>; Tue,  7 Mar 2023 23:47:28 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id y15-20020a17090aa40f00b00237ad8ee3a0so1142807pjp.2
        for <git@vger.kernel.org>; Tue, 07 Mar 2023 23:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678261648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AFOzQEb2tm/USrtMgg6xjlyTSJ27L3jrvJ1ntVjVvH4=;
        b=jxyyM1tQrMp74gNon/QeLMAksnyjCueWMmnE1Wz5yAap6kyqZSoocnIiaZrnJ5oReV
         OOnI/Lvwn+h43EAS6bvbi5acmqqMjeBIy06Tq8ch5kNkb7Jl2PCbhDnb82Z0QxjuPbg8
         OIXyfdXvUkEkJQt2jPwDDIP7aQnnhLJA+Rq/Az5FhbHUXy+TvZ4kBG7wCR+0sOG5lg6G
         A0rBs9OMtGr5Pf4J6tfzaynBBryX2f//UVb8N4SzXhwJ0Ov45NLzdSovcCXYpaswqSbL
         3vLtanaE1hDcEJBMhnnUr6K4oPt1LpKAmJ9QZXD7pJ74qYLusYgpg9KDaLF4nA0rLr4g
         PLow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678261648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AFOzQEb2tm/USrtMgg6xjlyTSJ27L3jrvJ1ntVjVvH4=;
        b=qQ4sF56BorlBhTg5TAjIH0IvwaLJiztRjXxjpdVh3bB5caQe77NABOtOPYzX4j74YJ
         LM052XKvkciGwOk48sdY0znURAVSS8oOKHxR/N9qQvFD5tmrdP7EaWtLTAjXgmv4Ug77
         kL1Ekd7l/8E2qY3p2CeRdk8GjfqMIjAjKWYbrtWFHi6ZkkfkpvVDnN3XspXl3VUZkYbV
         DIx6gab4K7AFJ6KHvgXOIYVIW0D4sE1cKqL/sYOiaAxRiz1QAdXGPKmKdOn44pGb2vPf
         KaEzfBQvBvhOPtIH8GZo12ce4kA8nebAwaoDENDYqvQCki2DsRKaPyhLOoEWQBYW1Tvc
         H85g==
X-Gm-Message-State: AO0yUKXQhTsvbMhEOrWeX5VeI09HN0u09ABsBgXDTLKmhLeE5F5USB+7
        DTRk1iFECkh9PMcrKRimecBFot4PxjCplzGI89Y=
X-Google-Smtp-Source: AK7set+nz92BKK72yteUu0ban4TKqkJ4Xt0FhrCXWUqm0mqf6aO4wbugWJLL8eeJvy2hRFoVetyFRXuY32qzxlgdSKs=
X-Received: by 2002:a17:902:ef8d:b0:19a:fa2f:559e with SMTP id
 iz13-20020a170902ef8d00b0019afa2f559emr7002291plb.3.1678261648015; Tue, 07
 Mar 2023 23:47:28 -0800 (PST)
MIME-Version: 1.0
References: <CAOLTT8TcX6Wit=AOFGNLjA4v9HAvJJxCEtt3JhgUR+3OARycNw@mail.gmail.com>
In-Reply-To: <CAOLTT8TcX6Wit=AOFGNLjA4v9HAvJJxCEtt3JhgUR+3OARycNw@mail.gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Wed, 8 Mar 2023 08:47:16 +0100
Message-ID: <CAN0heSoVBmkuEOkW3wRNXRRjG7y8UqvORie6ocYnmQRz4jEXkg@mail.gmail.com>
Subject: Re: Question: How range-diff lapjv algorithm work
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, t.gummerer@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 8 Mar 2023 at 07:50, ZheNing Hu <adlternative@gmail.com> wrote:
>
> My question is:
> 1. In step 3, why is the matrix size (a.nr + b.br) * (a.nr + b.br)
> instead of a.nr * b.nr?

There's some explanation of that in the man page for `git range-diff`,
under "ALGORITHM". Look for "To explain also new commits, we introduce
dummy nodes on both sides:".

> 2. Why the cost(x,y) which satisfies "x =E2=88=88 [a.nr, a.nr + b.nr) y =
=E2=88=88 [0,
> b.nr) || x =E2=88=88 [0, a.nr) y =E2=88=88 [b.nr, b. The cost of nr + a.n=
r)" is set to
> "diffsize(a or b) * creation_factor / 100 : COST_MAX"? What is the
> role of creation_factor? [1]

The `--creation-factor` command line option is also described in the
manpage.  There was a thread on the mailing list with various
discussions around this creation factor a while back. Maybe there's
something interesting there [1].

> 3. How does LAPJV work here? [2]
>
> [1]: https://github.com/git/git/blob/725f57037d81e24eacfda6e59a19c60c0b4c=
8062/range-diff.c#L310
> [2]: https://github.com/git/git/blob/725f57037d81e24eacfda6e59a19c60c0b4c=
8062/linear-assignment.c#L15

This appears to be based on work by Jonker and Volgenant. Maybe
searching for those names online could find something. Maybe not
git-specific, but even if it's just the general algorithm as such, it
might be possible to find different explanations of the algorithm.

I haven't really studied this algorithm, but since it's faster than the
Hungarian algorithm, I could imagine that either

  * it's super-useful to first understand the Hungarian algorithm, then
    understand why and how the Jonker-Volgenant algorithm does better,
    or,

  * it's completely useless to first understand the Hungarian algorithm,
    since they're so different.

:-)

[1] https://lore.kernel.org/git/1196830250.20220726145447@yandex.ru/

Martin
