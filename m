Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EED6C433DB
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 05:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDDEE64E49
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 05:47:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbhCOFqr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 01:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbhCOFqk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 01:46:40 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B98C061574
        for <git@vger.kernel.org>; Sun, 14 Mar 2021 22:46:39 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id x135so28896303oia.9
        for <git@vger.kernel.org>; Sun, 14 Mar 2021 22:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3BcAYdsKWacl4tmPMxnWjnnRQPhzMPAUQ9cCHX7n7pk=;
        b=oJR0KGfJJjRGVme1dTLWBM7oAEBkzYfYRY+pg3WgrC9wkwkYLlnawXp5aVcphQnJz7
         nG2asbjss4FTBhhd4gPiEyYmMoRQ0vs6f8G0Q2F+D6QibTEF/RgDl4Z2fOnwTJ6OXG8I
         a7dnZ/XUX7OK2yxfJ36uk5AA6N7Amt6dHQ/LizCsrFr1BGvN7uJxp2GUQgTCwTXH9Il5
         OPOb63YeodxIliijdBCQUC6x//y+6zTsmbdKYAkeCNqf2mAEnGHUE8psxWYfifVqymE6
         n00OXxoP1rUkjEVaM5WHhgCgUf916qRSRTMIh7Ot3fmyY8It53e9DHWIPWKhGrfntYK3
         3JcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3BcAYdsKWacl4tmPMxnWjnnRQPhzMPAUQ9cCHX7n7pk=;
        b=n79bQP+5Bz4zO5kHeB/OlVDkm9xLXd8FyOmNNpjzrZsb0F8EmMVvAAK8++TzaQuGB/
         lhCmPqX633TMReuWPLmy4MoE70aNyPZ0c+ZQMGxFb0Ynfp/U96Ju1STd35S5TxOW8/l2
         w3CrIRA+UHRDwBk2uylFlwP90js/FlCq2PQSZBvWf6EL/rzA5WhqxLX5lx+ozWKPk9PT
         y/R7UKQh79x2jDnrKMLraQIlOvz/NUf1Q6ca+Gbu3B4zyqPo2EcAVoBfirSKs7/VV9s2
         Aurrf6aI9SuBCI67hNXeNTOksntEBYFgbfDX7IktsYZ9VOPNdWOQU0moKamptIlJXldn
         flWA==
X-Gm-Message-State: AOAM530QqeJdgd+aZa84hOlypXI/dpTdRN2lwWY5394+BpcU/0t0aclH
        Z4iXY1waNS7DxxuJedoZ47swhwLw/X5wv4/maj0=
X-Google-Smtp-Source: ABdhPJz1YbjZdEadX1XlkIbOv3lLuHIHfu2Eppd96VrlxFk1MB8zkLXB75lwagjZvb3iQFjhMFeUhIbQKRbgSlJZuwA=
X-Received: by 2002:aca:af10:: with SMTP id y16mr17600616oie.120.1615787199369;
 Sun, 14 Mar 2021 22:46:39 -0700 (PDT)
MIME-Version: 1.0
References: <pull.901.v4.git.1615737505834.gitgitgadget@gmail.com>
 <pull.901.v5.git.1615778692784.gitgitgadget@gmail.com> <CAP8UFD3mpu6eTqifnwUV4uHoAASaQnxX21CacOn4dGSp+juVKw@mail.gmail.com>
In-Reply-To: <CAP8UFD3mpu6eTqifnwUV4uHoAASaQnxX21CacOn4dGSp+juVKw@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Mon, 15 Mar 2021 13:46:28 +0800
Message-ID: <CAOLTT8R2qmmp=-2fRdVQJN6LkrhCcM_SfL46MALPwtycJ_LH9A@mail.gmail.com>
Subject: Re: [PATCH v5] [GSOC] commit: add --trailer option
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
=8815=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=881:33=E5=86=99=E9=81=93=
=EF=BC=9A
>
> On Mon, Mar 15, 2021 at 4:24 AM ZheNing Hu via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>
> > diff --git a/builtin/commit.c b/builtin/commit.c
> > index 739110c5a7f6..24fccb561398 100644
> > --- a/builtin/commit.c
> > +++ b/builtin/commit.c
> > @@ -113,6 +113,9 @@ static int config_commit_verbose =3D -1; /* unspeci=
fied */
> >  static int no_post_rewrite, allow_empty_message, pathspec_file_nul;
> >  static char *untracked_files_arg, *force_date, *ignore_submodule_arg, =
*ignored_arg;
> >  static char *sign_commit, *pathspec_from_file;
> > +struct child_process run_trailer =3D CHILD_PROCESS_INIT;
>
> It seems to me that `run_trailer` is used only in the `if
> (trailer_args.nr) {...}` block, so it could be declared there instead
> of as a global variable.
>
> > +struct strvec trailer_args =3D STRVEC_INIT;
> > +static const char *trailer;
>
> I am not sure that this `trailer`variable is really needed. It seems
> to be used only as the third argument to OPT_CALLBACK(), but there are
> other places in the code base where we pass NULL as the third
> argument.

Good advice.
