Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A8CC433EF
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 03:43:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiBXDoG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 22:44:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbiBXDoG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 22:44:06 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D49125A301
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 19:43:36 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id bq11so1100609edb.2
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 19:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WAOJDmHxrMQDtL2WlG7djg5ssqhWk6BS9pksb5rFKjk=;
        b=MVtGLxshSPdKw8OUAZH2zMmEPsxfp9Esp60XCQ3fjQF7SJvC/o8FraE8e3ihJIYFBO
         ffIZNIa648P6zKBIF+ztOHe4NcfL5A7HjAH0A9u7sCM9SEGmtGZBA5SmzizZq9JsCgmE
         bKKYu2qmuws13oPE9Rudb83LzGi3KuWWMUmtGKFT1Jg3GVhALk4Iut4iHvE+XUSlKEUv
         yClj6ofMVQDaYZef/dnkv4ImB1IB0RmoryfSfQWCb8REQx4Cl9Ri4HfGr8WBqR8+Tj3I
         bWUhJbbMuXMcuAt3r8VjjuqlYdUQSUJFUqit2ljpSkjgdxSzT1x60L7IvWHTjq0O2yML
         O6uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WAOJDmHxrMQDtL2WlG7djg5ssqhWk6BS9pksb5rFKjk=;
        b=tiOC2/09bFHynJ4k4Dh2QAEq8Fmg16s2vKlxSYtWZ1mH1g0tiSowL7QOSLZEk+51UZ
         RgMLlZ8vEdlAa05X2g1zn/yU8s/iWhn1sGSwDOLjqcCDVMK7QV0hhKUWr9ukI4JNDytH
         TutMQRzt6rigOLZI/awDQwGbNcPWbD0F8rSMoIMhFv9NBlroJxfdOJnl4MdojDNKgs+a
         E4Q3DMlGhIFS99EVPIeNV0BxA9Lswt0+RubmslGsE0JYPsqsH3b5ZNA18RIqQnAqD2fF
         pUR9CrUIuHedPGAqq4IU4y4Ui/tMoglJUMteq3KAMsDu126yCKQRe+5eO0HrvdO4PixI
         MAUw==
X-Gm-Message-State: AOAM530HUhm2HFSodeDguU9lqpovSRiaR+i0WGvjYh2/teLMUQqKWTsG
        P18m8rxHe/UvB9L25HSoTYLiLrv4Jp/3zPuaoEHlP7sFKJI=
X-Google-Smtp-Source: ABdhPJydVT2ltePZxsHH8wOD/Ans+1/f6Wa2FnB+wzUZcOl4pzMjXot9uaNlL17h1q9AzZjb9vkYaV1fMaby+d/8iEo=
X-Received: by 2002:a05:6402:cac:b0:410:a920:4e90 with SMTP id
 cn12-20020a0564020cac00b00410a9204e90mr525959edb.60.1645674215045; Wed, 23
 Feb 2022 19:43:35 -0800 (PST)
MIME-Version: 1.0
References: <20220222114313.14921-1-shivam828787@gmail.com>
In-Reply-To: <20220222114313.14921-1-shivam828787@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 24 Feb 2022 04:43:23 +0100
Message-ID: <CAP8UFD2wNSJmiohfAGrihm5sO_q4a6UpLMsVNAF5uWyuWt7R9Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] microproject: avoid using pipes in test
To:     Shubham Mishra <shivam828787@gmail.com>
Cc:     git <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 22, 2022 at 6:01 PM Shubham Mishra <shivam828787@gmail.com> wro=
te:
>
> pipes doesn't care about error codes and ignore them thus we should not u=
se them in tests.
> As an easy alternative, I am using a tmp file to write from git command s=
o we can test the exit code.

(Others have already rightly commented on many things, so I am only
focusing on microproject related things.)

As the subject of this cover letter starts with "microproject:" I
would suggest taking a look (or maybe reading again) our page about
microprojects: https://git.github.io/General-Microproject-Information/

Please note that we ask that all related emails start with =E2=80=9C[GSoC]=
=E2=80=9D or
=E2=80=9C[Outreachy]=E2=80=9D or something similar, not "microproject:".

> This is my first contribution that's why I am keeping diff short with an =
intention to understand the process instead of making impactful change in f=
irst attempt. Later, I will send more patches to fix the issue for other fi=
les.

Please read the "Only ONE quality focused microproject per student"
section of the above mentioned page.

Thanks for your first contribution!
