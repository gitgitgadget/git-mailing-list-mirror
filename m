Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61553C47092
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 12:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4702F61028
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 12:47:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233864AbhFAMsq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Jun 2021 08:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233758AbhFAMsq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jun 2021 08:48:46 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97DCCC061574
        for <git@vger.kernel.org>; Tue,  1 Jun 2021 05:47:03 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id r4so15104754iol.6
        for <git@vger.kernel.org>; Tue, 01 Jun 2021 05:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=j4I7BjupetXlGqJOB8xV8k9iAfjC8m4reCHUUXoLLuo=;
        b=WLOn4UvXW7J8ZCLgQmER3uhKngG/cBHbF142vVfmwleDTQgJemsPVqjXebTC7XuyAY
         nBYcVuR1jrdzqh8HagEK40qQkXIwaBGXY3tkKhNnr78EX+qiK33NTYQAS5PdPeBFz9q5
         e05xHg0Q1HrB8dnFPpH00YN8nCwpP/rCllasgSnV9ufWTQavk29jDaOkw94T/9K4J5vP
         nf9vb5K7ZB/24cguDMFmDhonONY5omUJFfXRAHcShR6PXpVlbG4nGxwJx29GR+aP1kRv
         2GPXw+vVJOSRt03XRzyKtN6c3j+OZBjX2/TPpiEtB6sVek6i8u4OX04Xrm5jpP5GcdZj
         fwhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=j4I7BjupetXlGqJOB8xV8k9iAfjC8m4reCHUUXoLLuo=;
        b=adWElaQWtO5rn8TzQhpL9LoXi4LupuDm3BlUjhAQ2mJJk6ZIU/9E7MtHOsXn+m0QlH
         s7kzBilWjtWNH+dIb0N/6wDcVVjexd3M5d5ewCpFzIuIFVn5aAXDtUYwTSUZob8JHJ5F
         pJjsFF+P4p5wYW34SYEAkar1KPR4s7/utP3a/WJcufXUcu1PDgKpwOvAtWNfG9E/BTEp
         AlckRmZSGhFr/fmW9/73TETh8gx5R6vNZbEPaFnHNIn8ii5LxvyzUhN8CauWSFJPuOLm
         OL8Or1w0hZac3kkA4Tl++HVCrph2SU1Z1F/fKJbifhrynb+pdOkpy2TjKWp/R2lxHnIM
         xo8g==
X-Gm-Message-State: AOAM53045tARLAI2rSbXg6f8CtfWMR8P3YCjC4WfK6pTtYE1fNKnix9J
        HBEW/757sUcwjp/o3OeLiAJwycp+Aykd8iilmY4=
X-Google-Smtp-Source: ABdhPJy2SJ7Zdl9oqpjgsJaar0P+jzrx51OpBzbVjBR0/Wrp52eCI0tLMq7kRWD2gHXgRv3BXq+f8bkxlqM+KIDEqIY=
X-Received: by 2002:a02:b084:: with SMTP id v4mr12885832jah.130.1622551622946;
 Tue, 01 Jun 2021 05:47:02 -0700 (PDT)
MIME-Version: 1.0
References: <pull.965.git.1622363366722.gitgitgadget@gmail.com>
 <YLP/GEN0qIXvWEUn@coredump.intra.peff.net> <CAOLTT8Q0zbxh8X03ZmgAzHadTbE4-Af+AB3POOUF2n22u8RExw@mail.gmail.com>
 <YLT2UfCZyQIXWIOv@coredump.intra.peff.net> <60b509be97423_24d2820856@natae.notmuch>
 <YLWSRBJHiph+Bejo@coredump.intra.peff.net>
In-Reply-To: <YLWSRBJHiph+Bejo@coredump.intra.peff.net>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Tue, 1 Jun 2021 20:46:51 +0800
Message-ID: <CAOLTT8SZxiBtxj7=B-75gVghZAp-qf_oqFGwyi7iKD61uH-vsw@mail.gmail.com>
Subject: Re: [PATCH] [GSOC] cat-file: fix --batch report changed-type bug
To:     Jeff King <peff@peff.net>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> =E4=BA=8E2021=E5=B9=B46=E6=9C=881=E6=97=A5=E5=91=
=A8=E4=BA=8C =E4=B8=8A=E5=8D=889:49=E5=86=99=E9=81=93=EF=BC=9A
>
> Or we could just generate the entire expected output and check it with
> "cmp". The most robust way is probably to loop over the objects, running
> "git cat-file" for each, but that's slow. Maybe:
>
>   git cat-file --batch-all-objects --batch-check=3D'%(objectname)' >objec=
ts &&
>   git cat-file --batch=3D'%(objectname)' <objects >expect &&
>   git cat-file --batch-all-objects --batch=3D'%(objectname)' >actual &&
>   # not test_cmp, as it is not binary clean!
>   cmp expect actual
>
> That feels a bit circular in that it's mostly just exercising most of
> the same code in the "expect" and "actual" paths. The interesting part
> is the combination of the two options, which is why I think that just
> making sure we don't hit an error might be enough.
>

Such a test is also acceptable. I will add a test like this.

> -Peff

--
ZheNing Hu
