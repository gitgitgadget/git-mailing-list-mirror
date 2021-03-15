Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B98C2C433E0
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 01:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F0DF64E6C
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 01:28:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbhCOB1y (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Mar 2021 21:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbhCOB1l (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Mar 2021 21:27:41 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C6EC061574
        for <git@vger.kernel.org>; Sun, 14 Mar 2021 18:27:40 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id u198so28029278oia.4
        for <git@vger.kernel.org>; Sun, 14 Mar 2021 18:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NsfUv532TKvZRbOlV+LORuO3j5flXGvjbj+SNNiBkBk=;
        b=of0p8FkFl7ArmpA0G/x7Z+MdAWSR2KM9aeGMYQSaTRBfE+uB1ZvwlX7GvFwjLAbj68
         bav1+gehMtksBS7KSNiYsJCzWh+XxfDCM/EldR0Sxp82Tr18mTNYWLVJ0gOWOYCy1cop
         O+qjMmR4xfORItR2gZoP/B2Q9YoJrvaEbEWxDZqT4iVcM7iDFHuEGgn7/CU2Ml/CFu1v
         +ivD+9zREqUWOWD3/4+gw0S9/pV+Xl/FIyouqJluoiYr+KopbFeKF9UkOIY194so09Lx
         cb/nW286mVYnIsTY/Kk3U3XxNtRYuBxkj5ooNtN1n3l2n8GqkzhGkwkweePxbuzd9fPa
         nSEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NsfUv532TKvZRbOlV+LORuO3j5flXGvjbj+SNNiBkBk=;
        b=OEjIjZav28HwWGBMW5QGuVkhJ9Z1gYpzbjqQgpMQ4mHUbRkuCisdZ85EDMVFSdJaXF
         Vpk1Jf1p3Dl8RMlKXAmqhV+CFGe+LVnRTJwG4QoeurW4vY927PwOghrmktr0AaIqNZ6G
         uB98yxGXySouMcMJSH6p5L14pl+TD/TOOjjRtYVymSsrc2t7HZBQ6wwf0jOsYiEOEJzB
         FIHM4TpQkMR2k/jFmpcmw2L3rJezxcH8M/NwTfrsUw0ctw0TkMoeTyPKOggCKVqGSUIN
         FNlg4iJ+hYMsp+fZ6/dTsGFlWi9QXqJ0ZzGngGGK4Np4wTZO4Iu7N8Tk0pSr85S3MzGc
         x6Hg==
X-Gm-Message-State: AOAM53258kjkVT7crD+qQ7SoRRSEzp/C2qKP83kPWYJg8YEQLnQ1hmkB
        LOHT0krApHSp8O76KBcernHlWMtwb4e0L42Hsd8=
X-Google-Smtp-Source: ABdhPJwqfBLWAHq1fRDi7VlXDVgGtThjVHKE4ShDjS3wY26zLS079uyn+Hvgbmxvb4mgymLGOEZeYDaftBWQzq8TGwE=
X-Received: by 2002:aca:d68e:: with SMTP id n136mr17604102oig.179.1615771660301;
 Sun, 14 Mar 2021 18:27:40 -0700 (PDT)
MIME-Version: 1.0
References: <pull.901.v3.git.1615726978059.gitgitgadget@gmail.com>
 <pull.901.v4.git.1615737505834.gitgitgadget@gmail.com> <xmqqh7ld2syx.fsf@gitster.g>
In-Reply-To: <xmqqh7ld2syx.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Mon, 15 Mar 2021 09:27:28 +0800
Message-ID: <CAOLTT8RNKFC_NzZXGvE4Zz+NmVHCUAn-jZFu-0Nm=7JAS0jBjA@mail.gmail.com>
Subject: Re: [PATCH v4] [GSOC] commit: add --trailer option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        "Bradley M. Kuhn" <bkuhn@sfconservancy.org>,
        Brandon Casey <drafnel@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B43=E6=9C=8815=E6=97=
=A5=E5=91=A8=E4=B8=80 =E4=B8=8A=E5=8D=887:52=E5=86=99=E9=81=93=EF=BC=9A
> IOW this part would become ...
>
>         if (trailer_args.nr) {
>                 strvec_pushl(&run_trailer.args, "interpret-trailers",
>                              "--in-place", ...);
>                 strvec_pushv(&run_trailer.args, trailer_args.v);
>                 run_trailer.git_cmd =3D 1;
>                 run_command(&run_trailer);
>         }
>
> > +     } else
> > +             strvec_clear(&run_trailer.args);
>
> ... and there is no need to have "else" that won't need to do
> anything.

Yes, but we also should clear "trailer_args" in "else" here, and check the
return value of the "run_command()" for clear "run_trailer.args".

>
> >       verbose =3D -1; /* unspecified */
> > +     strvec_pushl(&run_trailer.args, "interpret-trailers",
> > +                 "--in-place", "--where=3Dend", git_path_commit_editms=
g(), NULL);
>
> And this line will be gone.
>

Indeed so.

Thanks.
