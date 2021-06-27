Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE31DC49EAB
	for <git@archiver.kernel.org>; Sun, 27 Jun 2021 11:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1E2361278
	for <git@archiver.kernel.org>; Sun, 27 Jun 2021 11:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbhF0LeE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Jun 2021 07:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbhF0LeE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Jun 2021 07:34:04 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89386C061574
        for <git@vger.kernel.org>; Sun, 27 Jun 2021 04:31:39 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id h2so18550574iob.11
        for <git@vger.kernel.org>; Sun, 27 Jun 2021 04:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dP29TauXC0//tX44l8OP+JqKVMiqMhjM06sjaJyYAp4=;
        b=sEHLGIk4v0PjhV3ciGH/ted2J6mW2TLQwFQorAe6iK6IE0yHonvaLqHcDAAMNRSHIu
         DELulysC8mzRYuchU1LrVX2dWgoZpk4zA8NZR/PO6L5wzNm3f7TOwKbFX5OM34ve7zsK
         smh/pcchmbsQZR+rhWUPMBe6MBFvfc0OeO7W728AGtPBOBh86kkPSynROaZVcmS+l9G2
         1a+56Tcu2Z0fN3qd0vy+ul8HpkrfJgYqnjDsEpC+qruVDZbr+SVutAIaDwEv9gwxRuIm
         pWatFc8MxTwxPiFdXSzBN2edllaFzcQkOUhKE3Onq+q/uZK2SAty2k6027iZC6dVGbRb
         nvYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dP29TauXC0//tX44l8OP+JqKVMiqMhjM06sjaJyYAp4=;
        b=e786TuGGaXZ6UVeCu+uNCh3WSyZFaG+D919YHN2iwF/H6tM5bcbwJkBGSgJ2EesVmL
         UtcjN2XTD8M40FRyLbcX63B8u6tKxnwQjB+15k7DJ8u6grVfHvxTC4ZwMAekv+YuNuHL
         K5kPHRWRZzzZTPGT+ss9LRHt3eYeoM2WIKtFMAVuhfQy87VUSm/f9p2O4TsUsOTaP133
         lhj9sBWMtelGooJ4XvqULzRRRxXv9aHoyGqhZcdYt5BP2uWS5rNtSr4VSOjNZ559NCY6
         7/VFMtnWAWEyorxLTSsSMJpCKCv8gdhdM6LAtSva76ZPR/N+iKmg/ej5kQJr/cpFbMGB
         xpcg==
X-Gm-Message-State: AOAM5328JsVEXVdi9ZnI3Mgc1d9KpC3kT+xsFxFSfdrRlRjZzOXt5XSj
        6nb9zk2N26D2+uOqfzyG/obSCqmlh2gCqUUh2c4=
X-Google-Smtp-Source: ABdhPJy/v779irde1Hws5hz9rskSBkxR1tnQJPuR3le+ezAyaFqTzbW7YgV3bgejBGUnQR4l/pY9nL4Tzk9F5tj2IYY=
X-Received: by 2002:a6b:f81a:: with SMTP id o26mr8574473ioh.68.1624793499081;
 Sun, 27 Jun 2021 04:31:39 -0700 (PDT)
MIME-Version: 1.0
References: <pull.980.v4.git.1624332054.gitgitgadget@gmail.com>
 <pull.980.v5.git.1624636945.gitgitgadget@gmail.com> <370101ba65f0989487360366f8b83144a6641a04.1624636945.git.gitgitgadget@gmail.com>
 <CA+CkUQ9jWY8KDJxeAk9kDSCGgQLuBuaLEASrGfbA2xnN7nuBBw@mail.gmail.com>
In-Reply-To: <CA+CkUQ9jWY8KDJxeAk9kDSCGgQLuBuaLEASrGfbA2xnN7nuBBw@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sun, 27 Jun 2021 19:31:28 +0800
Message-ID: <CAOLTT8QOi0wYoouqaWn43CKR1bZT6U8v+T+6MMbq1R-4wjqBPg@mail.gmail.com>
Subject: Re: [PATCH v5 12/15] [GSOC] cat-file: reuse ref-filter logic
To:     Hariom verma <hariom18599@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hariom verma <hariom18599@gmail.com> =E4=BA=8E2021=E5=B9=B46=E6=9C=8827=E6=
=97=A5=E5=91=A8=E6=97=A5 =E4=B8=8A=E5=8D=881:27=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi,
>
> On Fri, Jun 25, 2021 at 9:32 PM ZheNing Hu via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > From: ZheNing Hu <adlternative@gmail.com>
> >
> > +       if (ret < 0) {
> > +               die("%s\n", err.buf);
> > +       } if (ret) {
> > +               /* ret > 0 means when the object corresponding to oid
> > +                * cannot be found in format_ref_array_item(), we only =
print
> > +                * the error message.
> > +                */
> > +               printf("%s\n", err.buf);
> > +               fflush(stdout);
> > +       } else {
> > +               strbuf_addch(scratch, '\n');
> > +               batch_write(opt, scratch->buf, scratch->len);
> >         }
> > +       free_ref_array_item_value(&item);
> > +       strbuf_release(&err);
> >  }
>
> I think you can get rid of braces in condition `ret < 0`:
>

Make sences. ;-)

> ```
>         if (ret < 0)
>                 die("%s\n", err->buf);
>         if (ret) {
>                 /* ret > 0 means when the object corresponding to oid
>                  * cannot be found in format_ref_array_item(), we only pr=
int
>                  * the error message.
>                  */
>                 printf("%s\n", err->buf);
>                 fflush(stdout);
>         } else {
>                 strbuf_addch(scratch, '\n');
>                 batch_write(opt, scratch->buf, scratch->len);
>         }
> ```
>
> Thanks,
> Hariom.

Thanks,
ZheNing Hu
