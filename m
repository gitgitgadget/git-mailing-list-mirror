Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF56C43331
	for <git@archiver.kernel.org>; Sun, 14 Mar 2021 01:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E56AF64ECE
	for <git@archiver.kernel.org>; Sun, 14 Mar 2021 01:27:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234815AbhCNB0u (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Mar 2021 20:26:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233550AbhCNB0X (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Mar 2021 20:26:23 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46458C061574
        for <git@vger.kernel.org>; Sat, 13 Mar 2021 17:26:23 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id e45so5415845ote.9
        for <git@vger.kernel.org>; Sat, 13 Mar 2021 17:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=d73WWe6/DITs6jVatSyloAwKOoPhYPcEUodGkHQw4jM=;
        b=uVoxByI9yi7Wt+sVBcxG6XoFGqXfZl3T41ap00EHGzmWuTFUTQGyFuEfncVBa7WrbV
         9bed5nJXKZdNpwnG3XUIgM3yYluD/1tKfhawTzUGCA5t2RbbpQ30THFzvFzw9JNXabt9
         tD+sc7jolm6ks7TKwaFpcK+fcJBFEs2uRMbgG0K62Xvo3z3EK4ElhWyzyRJ4X9bCb4WF
         nhu/mcV+8rpiGbe4zS9eAnHribx7K54xMuWMb+RlRCReHoYIfSX4+QBcNnWlshNNlUfW
         k8S9bqiCV7ESB0zEej62BmJV6VfIQudtwBHkqxzEyDrE3M8jRec0g5XSMfxdiE9Fq/og
         aYGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=d73WWe6/DITs6jVatSyloAwKOoPhYPcEUodGkHQw4jM=;
        b=ohBGb+0wV2W+0n7MFl3EsoJ0kHhXV0Xh7CA+b35mCjXiqKGTYOHdcN/UjgpqXADmkE
         V72jaUUkqbeK2WuE6xWzL7xWldtQgafXfjpITdDeNnmwawuv7vUhIOIvs/PbbQcNNM5F
         IN8f1Zl1lpKOFVLljGncv4TazbEL2MGFxwZUFRJTJ68oSgPlIB/OA6PMfW8B6SVPFhZU
         m++MMV+buwIhFR64pPlBqI8hDwGlB6uZtzOZbNo51USmMoU291Jst2sL8743oJYY2xiZ
         i3w16O4Z/pHhMdnhupTUU7rK2D2PUm4OWF9TtHqVO5I6Vwm8WTubhMTVGxnCMoAyX4gp
         VGow==
X-Gm-Message-State: AOAM531brTV2cSh8jkfvf9Yo84oFT6BgXwUx9vc58E8ZfOc+19CmJBZV
        7GW1BAn9K80CYbu0u+OgaykpMecV1EmCWSl2GVA=
X-Google-Smtp-Source: ABdhPJwkt3BepdH2kj8fxCESWTgmaJIr47UFIyouAxs5cxR9cbvR0SHPACTRoKL2u3yHw3yxmBkay4pp6k8XZbXFiDQ=
X-Received: by 2002:a9d:6ad6:: with SMTP id m22mr1545912otq.160.1615685182602;
 Sat, 13 Mar 2021 17:26:22 -0800 (PST)
MIME-Version: 1.0
References: <CAD=kLpvn_-HZvHNt1WhrHCmOjyrvy_3cdCYPjCGHowo77_MRYw@mail.gmail.com>
In-Reply-To: <CAD=kLpvn_-HZvHNt1WhrHCmOjyrvy_3cdCYPjCGHowo77_MRYw@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sun, 14 Mar 2021 09:26:10 +0800
Message-ID: <CAOLTT8Tb_ePVgkxap2H7AjZVk_v+zH1FiNYCZKuZfpFskthJxQ@mail.gmail.com>
Subject: Re: Regarding GSoC Project 2021
To:     Shubham Verma <shubhunic@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, Shubhum Verma,


Shubham Verma <shubhunic@gmail.com> =E4=BA=8E2021=E5=B9=B43=E6=9C=8814=E6=
=97=A5=E5=91=A8=E6=97=A5 =E4=B8=8A=E5=8D=882:41=E5=86=99=E9=81=93=EF=BC=9A
>
> Hello Everyone,
>
> I am interested in working on the project "Use ref-filter formats in
> git cat-file" this summer as a GSoC student.
>
> But I saw ZheNing Hu already started contributing to this project. So,
> it is possible that more than one student can work on the same project
> or I have to choose another project?
>
> Otherwise, I will start working on the project "Finish convert git
> submodule script to builtin".
>
> Thank You! & Regards,
> Shubham

I haven't started sending relevant patches for `git cat-file`.
Now I'm still focused on solving some GGG issues, or
Add small options for subcommands that might be fun or useful,
And so you can still choose `git cat-file` to apply for.
But I recommend that you think about and complete a micro project
before applying for "git cat-file"or "git submodule", usually in
https://github.com/gitgitgadget/git/labels/leftoverbits or
https://github.com/gitgitgadget/git/labels/good first issue

Thanks.
--
ZheNing Hu
