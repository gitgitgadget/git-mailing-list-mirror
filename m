Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30458C433DB
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 15:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D709F64F2B
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 15:28:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbhCRP2S (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Mar 2021 11:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbhCRP1w (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Mar 2021 11:27:52 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA09AC06174A
        for <git@vger.kernel.org>; Thu, 18 Mar 2021 08:27:51 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id i25-20020a4aa1190000b02901bbd9429832so1536670ool.0
        for <git@vger.kernel.org>; Thu, 18 Mar 2021 08:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AYDFVDqJrfvHCeMDNBI2L+DywGAsH4khVgCdApaosHE=;
        b=smMz5DNpTxf/fPmDc5g1mNXRK7o6g7WHHkI5WcjOAoVIHmMAwV9DIDu3ysd3BznP7W
         HNXSD6TIk8GIEOHQTo2AHHxN9xdurTiBhFXlxyxO4RL/MzllgOBClgGziJCqneK30Tta
         QhFSjNKdGGqnPa8U2Vt9IK7f1tibSEPEv+tpBZHQmi/SLhrDZp4d0ioTGV2BNGEQ9OhA
         7824mOwKwckRQRZD4kExE4qyO4pk8t6dvoYpFmxk05h+0NRoKNe+l9rWRalgQU3qfa8f
         jj/+XDxnABfdil72zR4KXZFn2+321nEb9FBwzpfBYZZXATlOBAbq8EFSTPjk+ly10e2w
         M2uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AYDFVDqJrfvHCeMDNBI2L+DywGAsH4khVgCdApaosHE=;
        b=ddxwJmsUsr/xIjBbGZf9sPOmNuPqoLohFWN15ai8gfwT4SFFlI+c6G9uSvhtGvUGn6
         nePeMVYDjW7puOF+TCDXEyDEndEHmiDP1FAp3l6I1q6m7JOoUFDgCj7ULyZszCcdl5Mq
         C/Pw/fVInyzRrckPlMj8qH7T0A3Br+8YQRrboARJdLTRIWzkcK7V/TA1/JO5ZpOFIrLO
         krl49xezzIR8tb6oTz4NLbaC0rIMNQAvgahzAQXRyFK40MK55MbeqqO9pIgchD1bhwFP
         SThxMh15pCSAtqup6MKZ8buA8bCniR264pbV7JzhO0hw4gTAtbu9CE3VbX1/c8Wb4An+
         /FHw==
X-Gm-Message-State: AOAM531FfozmCX6u917ZbGrluYl+U7wzifGJJf7142YSYZtpcYFyd4jx
        cfAI7/xknZEKWWSqO2H83Pxwpam9Bh4uGvao1Uc=
X-Google-Smtp-Source: ABdhPJwit0/UW3HDbLycGuH/ZON7Qj9UEXu+mdk3AbfJpTSkYZ3uBMrQrN/sMTxxaI6XwaQkn21s6zuWWIPV0L8EAvo=
X-Received: by 2002:a4a:bd97:: with SMTP id k23mr7945499oop.13.1616081271245;
 Thu, 18 Mar 2021 08:27:51 -0700 (PDT)
MIME-Version: 1.0
References: <pull.901.v9.git.1615891183320.gitgitgadget@gmail.com>
 <pull.901.v10.git.1616066156.gitgitgadget@gmail.com> <CAP8UFD0UJvRn6VN5NaYiCK__Z=A_PTowpNxu8wi=9Byh+jJdFA@mail.gmail.com>
In-Reply-To: <CAP8UFD0UJvRn6VN5NaYiCK__Z=A_PTowpNxu8wi=9Byh+jJdFA@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Thu, 18 Mar 2021 23:27:40 +0800
Message-ID: <CAOLTT8TyxR0yFz2yPiPoGYZMMLb8PWi3A9C=QwhEeHvOWkWuPA@mail.gmail.com>
Subject: Re: [PATCH v10 0/3] [GSOC] commit: add --trailer option
To:     Christian Couder <christian.couder@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>,
        "Bradley M. Kuhn" <bkuhn@sfconservancy.org>,
        Junio C Hamano <gitster@pobox.com>,
        Brandon Casey <drafnel@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> =E4=BA=8E2021=E5=B9=B43=E6=9C=
=8818=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=889:48=E5=86=99=E9=81=93=
=EF=BC=9A
>
> On Thu, Mar 18, 2021 at 12:15 PM ZheNing Hu via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > Now maintainers or developers can also use commit
> > --trailer=3D"Signed-off-by:commiter<email>" from the command line to pr=
ovide
> > trailers to commit messages. This solution may be more generalized than=
 v1.
> >
> > ZheNing Hu (3):
> >   [GSOC] commit: add --trailer option
> >   interpret-trailers: add own-identity option
> >   commit: add own-identity option
>
> I see that you discussed an own-identity option in this thread
> recently, but this is version 10 of a patch series, so I don't think
> it's a good idea to introduce new features at this point. I think it's
> better to not tie the work that has already been done on polishing the
> first patch to new patches implementing an additional feature. The
> additional feature can be discussed and worked on in its own patch
> series building on top of this one.
>
OK, I understand that now. I will divide this patch series into two parts.
> Also it feels strange that only the first patch has "[GSOC]".
I forgot to add [GSOC]...

Thanks.
