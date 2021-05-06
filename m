Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23411C433ED
	for <git@archiver.kernel.org>; Thu,  6 May 2021 11:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D34006121F
	for <git@archiver.kernel.org>; Thu,  6 May 2021 11:52:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbhEFLxP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 May 2021 07:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbhEFLxP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 May 2021 07:53:15 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DAE2C061574
        for <git@vger.kernel.org>; Thu,  6 May 2021 04:52:17 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id z24so4549231ioj.7
        for <git@vger.kernel.org>; Thu, 06 May 2021 04:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=W3Z11PRHhe41XCLIvajKcRXlUNWHph8peg5g4vc3jvE=;
        b=FUnzH8bDnIvCmla9x7Okix85bYQxBnhOeil2HVdXsQaSyt8oDnUbMGOcSJn8xXlYP7
         gN/8UqoCSRZRiNL0HWnM37oGQKFvnWXbNIEoxcqwJziR1fakyqb+kuzB78Cx5w/eGPzr
         ngrt8bmYNrmFUAv6lzKWF4895RsWkcxHu+Jn+MXRvVgTMGVcU6CZ+heHhqTiZ9Nr8ZaV
         PkXh3ppQZrxQx3RkHCIx5aaC+QBwzMCv/yqTP9JOD8ArEzSBQqpW9h+azwewnkVpYmrZ
         RYqNrHFf3Znnjxh2LE6GuytSGQBv9i5B/FEHugr+Yz44AWdHaUiaO//Kj1rtLbGbQKy6
         D7kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=W3Z11PRHhe41XCLIvajKcRXlUNWHph8peg5g4vc3jvE=;
        b=VQUUWsfZlu/mfDinVqQz/rmfJ3DJqGKnoqlKxV+J784TSSx8NJpofW620OCFEslQ+O
         nLXvxWSnPaoyZDLrx9wkqHA/4uowqle3IkZzUi1wGRDJsQOpb5XttsYsB+xKIlc0urZK
         L16wedCYYPYQH03xhSudO6SlNHnOQvwi/zFT8SVcjjGPpDvoZULhw+apdRiiz6qNMHwG
         5vYJACko7dkuEN5yceEgaJu7FawBInGLCCj9IUqMR/kBilquXWYCxQptTstaS8nIVB5a
         YvHyhokU0BiHXFRlI0V96vAOug3CM1+KCvqes8TqEE0bmPKtBDjkRie2j7uQeXMZcUlv
         XW7w==
X-Gm-Message-State: AOAM5339BkiPd4FOPUgOE/+efwUTLcouwRUJgAB9sWlB5rLOozbq2pDs
        v58y6S50iCakQc0d7p5rzwrsBGBE6PTp7Mreyrc509HmUWSiadcj9XPBqA==
X-Google-Smtp-Source: ABdhPJy4Aa7K1rg5f34HBfG6IttQxpuWx7as1/28gyX1HNfT0dECYPX9of9kYFIULzmtckZqIcDKiSUN3zvNkgqJS9A=
X-Received: by 2002:a6b:d213:: with SMTP id q19mr2819154iob.203.1620301936685;
 Thu, 06 May 2021 04:52:16 -0700 (PDT)
MIME-Version: 1.0
References: <pull.949.git.1620228664666.gitgitgadget@gmail.com>
 <xmqqfsz01vc2.fsf@gitster.g> <CAOLTT8SmvRaohV+v2C9eFXyc8O+di5PfZJeWNinmm8X=Ckdveg@mail.gmail.com>
 <xmqqk0oczao3.fsf@gitster.g> <CAOLTT8S9TbRWGPeGKR9=cDnaw2RMukawV48dPEK1KL0X_87udA@mail.gmail.com>
 <xmqqtungxg4y.fsf@gitster.g>
In-Reply-To: <xmqqtungxg4y.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Thu, 6 May 2021 19:52:03 +0800
Message-ID: <CAOLTT8TQXAh9vu21d5rvaHe=+eqtFU8MCVhorfGmqYRohDThUg@mail.gmail.com>
Subject: Re: [PATCH] [GSOC] ref-filter: solve bugs caused by enumeration
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B45=E6=9C=886=E6=97=
=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=887:20=E5=86=99=E9=81=93=EF=BC=9A
>
> ZheNing Hu <adlternative@gmail.com> writes:
>
> >> So the fix was to see what atom it is by checking its name member?
> >> Is starts_with() a reliable test?  A fictitious atom "pushe" will be
> >> different from "push" or "push:<something>", but will still pass
> >> that test, so from the point of view of future-proofing the tests,
> >> shouldn't it do the same check as the one at the beginning of
> >> remote_ref_atom_parser()?
> >>
> >
> > I think it's not necesssary. Before we call `populate_value()`, ...
>
> I do not care if it is not needed with the "current" set of atoms we
> accept.  The example "pushe", which obviously will not be accepted
> by today's code, was all about future-proofing.

Well, what you said makes sense, now I think something like this will be
more secure. In the future, other people may be grateful for such a choice.=
 :)

@@ -1730,7 +1759,7 @@ static int populate_value(struct ref_array_item
*ref, struct strbuf *err)
                        else
                                v->s =3D xstrdup("");
                        continue;
-               } else if (starts_with(name, "push")) {
+               } else if (starts_with(name, "push") &&
atom->u.remote_ref.push) {


--
ZheNing Hu
