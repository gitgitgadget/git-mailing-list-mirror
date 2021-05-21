Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A41C433B4
	for <git@archiver.kernel.org>; Fri, 21 May 2021 13:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2333561132
	for <git@archiver.kernel.org>; Fri, 21 May 2021 13:39:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235945AbhEUNlM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 May 2021 09:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235911AbhEUNlK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 May 2021 09:41:10 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C9FC06138A
        for <git@vger.kernel.org>; Fri, 21 May 2021 06:39:46 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id h15so15446698ilr.2
        for <git@vger.kernel.org>; Fri, 21 May 2021 06:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CtCdCqOYkiwBume3bPE4x5klJ/TBD6N2vNU9DVhviDU=;
        b=EOXIrxRtgM5/PjBlVezAiV5m4C0i2AqOmjoYTiq4dbTtL0nVblJZ3mRIK8HXwdtupS
         reUcXs2+4c2b8KdB+Szqo89Fw2s4x/CmEi3tKCowIHNUtZ8wSWHSuRz91diJDqtWShLX
         W31xrm+QzDPXh7Kmo7+/TzZnM0+NY57cWbmKSTHWn3dILLkF8BlwxseyqPVuzgi9jDSh
         Xe1sQ+YzMRIVOykWNu5R5D+WXMTgS00l6/7SPLlox3FO4a8LeS1tXWa65bVbRJ9XVjAs
         gmr+9Sy/ZC4zwJ6S0IPI65zhoErw0jvfhRlioErisHhpxIMOPSQRVE2CepM/5NWKeKcS
         w7wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CtCdCqOYkiwBume3bPE4x5klJ/TBD6N2vNU9DVhviDU=;
        b=m1emRy7V7ChnbQtFdePwuI3JS4XyZdpvuAcF+iAQKbo5S5jLxAoFg0ucSszu4fluLR
         N3/9g10xCUgZlUXgp4fYy8JANP/t2geyWpkbPxv0/lSJxbDdJtyABlSv8bbx2TGNhlq4
         +yRplG183sSJ7TSfgT+JYO6GuTY5RPqf1FpgVm0bHbPvJEJaqqBMnqHY1L9XxApjiXSg
         ELKrZWIurKVdvVIolkN7igcZNpdusqjaRqOVcZYFdzd/Z5428ttjDe1XZq00v8kcMQ9v
         hjwHcffcL+T6XOMhJH4ktXFWS2q1bS9WCA04O4N7dgcCFHRc5ORqvt0Vtsp7Tyyn9lbS
         0xeQ==
X-Gm-Message-State: AOAM532uzppx24ZkSxgzxqSO/H9B9cpof71S+Z9SCKWaoBAKmDcNEywf
        k8zxeb/RFU8xKv4OwZvfiqV0EtM6jD9p1eLocJaec7QHgEXsMTZe
X-Google-Smtp-Source: ABdhPJySAxdAgEV2nLD/cFBVXK1NYEK1KqlL55CG4nSTLcx51grv3+7UUJgEETw6ofryYsc5bz+h4vS4PCU2vUGcxAQ=
X-Received: by 2002:a92:340a:: with SMTP id b10mr11865212ila.301.1621604385679;
 Fri, 21 May 2021 06:39:45 -0700 (PDT)
MIME-Version: 1.0
References: <pull.958.git.1621500593126.gitgitgadget@gmail.com>
 <CAP8UFD0Pzdb_9+VpeLrydu8ROdVi4ygFPk367J+NWGL0P5nXdg@mail.gmail.com>
 <CAOLTT8S_Bu1PG+-gVK_6iUx--YrMx2hxDCTa=5sW6UJv9Oz_0Q@mail.gmail.com>
 <CAP8UFD1yLS9UBs0r6_GjB-K6prW7GNxR+z445HJe8cR4HYLewA@mail.gmail.com> <CAOLTT8Q9meKiHG=TvwsW49dwWtzBNnkfT03+dQrvKDLGuLiOFg@mail.gmail.com>
In-Reply-To: <CAOLTT8Q9meKiHG=TvwsW49dwWtzBNnkfT03+dQrvKDLGuLiOFg@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Fri, 21 May 2021 21:39:30 +0800
Message-ID: <CAOLTT8TVn-SPdsX+0BrrrWzhq3in6DDFxDY_i4fEhkd-dW6nqg@mail.gmail.com>
Subject: Re: [PATCH] [GSOC] ref-filter: add contents:raw atom
To:     Christian Couder <christian.couder@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Hariom Verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ZheNing Hu <adlternative@gmail.com> =E4=BA=8E2021=E5=B9=B45=E6=9C=8821=E6=
=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=889:12=E5=86=99=E9=81=93=EF=BC=9A
>
>
> Now we want to use for-each-ref to print a ref point to a tree:
>
> git for-each-ref --format=3D"%(contents:raw)" refs/mytrees/first
>
> will output:
>
> 100644 one
>
> but
>
> git cat-file tree refs/mytrees/first
>
> will output:
>
> 100644 onem=EF=BF=BDc=D6=88=EF=BF=BD=EF=BF=BDq=EF=BF=BDD=EF=BF=BD=D6=A7hJ=
)E-100644 two.t=EF=BF=BD=EF=BF=BD=EF=BF=BD0=EF=BF=BD+=EF=BF=BD=EF=BF=BDVjC=
=EF=BF=BD=EF=BF=BDeV=EF=BF=BD=D3=88q
>
> which is the compressed data, it may contains '\0'.
>
> Whne we use `append_atom()` to add the contents of the tree object
> to the buffer, notice that it uses `strbuf_addstr()`, the underlying call
> is `strlen()`, which truncates the data we added. Can we have any good
> remedies? For example, record the length of "v->s" by "v->s_size" and
> use `strbuf_addstr(&state->stack->output, v->s, v->s_size)`?
>

This is not a good method, because `quote_formatting()` in `append_atom()`
will also cause this truncation problem.

--
ZheNing Hu
