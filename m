Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F14C4360C
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 08:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 110F9613CF
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 08:59:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233646AbhDFI7U (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Apr 2021 04:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244760AbhDFI7T (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Apr 2021 04:59:19 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A25C06174A
        for <git@vger.kernel.org>; Tue,  6 Apr 2021 01:59:10 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id n4so5609829ili.8
        for <git@vger.kernel.org>; Tue, 06 Apr 2021 01:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LBGU1TlPl6rrzOatWGOZSUfMKouxny8KSsWv/8CcEgs=;
        b=W+073Gevxkw2A9UlONUqahNBExCPar2dQky4Eda2pakI0AxXFr/hd/5tgGru++EjQQ
         YQhrVSlX9cYvnlIATOH5c4M0K2mIm8FA6eLydQNzktpgaYgYChXPFq4NxHE6WbQwQFNu
         NdT3f9sfZwHbtORBKODfjfaffNbGQn/mk3fhPkWcy8EGlysw69QkTr3tz9MqZzQ2yD5r
         kCvOS/Sc5mjPcTfTXR9sAAbC+CW9ncd0NMSE4T+j9s4HTBjIdxDHIXbW1l+Zpbchv6BS
         38hYB+im8buyBwlB9FF6X8clke21HpsC/QXoDHWzpEZncNT8sTWlEpnk3ZZ1IVoXHJZo
         sZhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LBGU1TlPl6rrzOatWGOZSUfMKouxny8KSsWv/8CcEgs=;
        b=lJnrQYsywWwi/8nBOkOCu6folfaFNENDqDoj31l97gVVDXKZmT2+zoRHQZ7+4AjAyN
         cHl0UoT5GlUtbG6GqRzPsyphhla5lSjyJXpGDv+3t9e7cJsEIPQrHe2kS0q461nLVcOJ
         WDC2SQ+VDZBJl7cf8O6hG99J73GT3MYsnmI9CIs9Ey32kNlS7KI0fYkaSDLmBNPjzUOp
         fi0AWvtZcbT1H1ScYtwFqy1WksmOPtLynX2qbx9z75BECMe6MfNvKB7bNljHT+b2ruXs
         z+eikx0+x37Vxrq6tNHaW/DbbyBK6v26Lwl5cUCJNgaGozuZGwD8G9Q3Bpv6QsFHbDIB
         osxw==
X-Gm-Message-State: AOAM5315f9tcetGs6IEgpjWfM3ASQ/6edWJm3t+qCjhUR22CBBpd+2NL
        ADBVdrt046MMCofmc92oHqQ1Z07OdmrKdUu647I=
X-Google-Smtp-Source: ABdhPJzaTHiDaey4Lvv4V/mizzQZ+ivA1kzWWZwQjUw8PlFbVYcBtXiqBv8H4Y7rrstniqlJnueEOfnjmaxJbam5FiU=
X-Received: by 2002:a05:6e02:19c6:: with SMTP id r6mr23130972ill.174.1617699549821;
 Tue, 06 Apr 2021 01:59:09 -0700 (PDT)
MIME-Version: 1.0
References: <pull.927.git.1617631280402.gitgitgadget@gmail.com> <50fce64e-d3f5-05e6-5e2a-645864211176@gmail.com>
In-Reply-To: <50fce64e-d3f5-05e6-5e2a-645864211176@gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Tue, 6 Apr 2021 16:58:58 +0800
Message-ID: <CAOLTT8RB-Ky70Z_JOEAbKSpRwmvNwF9ecikD4ThOorZ=Ne-LTg@mail.gmail.com>
Subject: Re: [PATCH] [GSOC] ref-filter: use single strbuf for all output
To:     Derrick Stolee <stolee@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Hariom Verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> =E4=BA=8E2021=E5=B9=B44=E6=9C=886=E6=97=
=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=885:02=E5=86=99=E9=81=93=EF=BC=9A
>
> On 4/5/2021 10:01 AM, ZheNing Hu via GitGitGadget wrote:
> > From: ZheNing Hu <adlternative@gmail.com>
> >
> > When we use `git for-each-ref`, every ref will call
> > `show_ref_array_item()` and allocate its own final strbuf
> > and error strbuf. Instead, we can provide two single strbuf:
> > final_buf and error_buf that get reused for each output.
>
> s/two single strbuf/two buffers/
>
> > When run it 100 times:
> >
> > $ git for-each-ref
> >
> > on git.git :
> >
> > 3.19s user
> > 3.88s system
> > 35% cpu
> > 20.199 total
> >
> > to:
> >
> > 2.89s user
> > 4.00s system
> > 34% cpu
> > 19.741 total
> >
> > The performance has been slightly improved.
>
> This is a nice amount of time! Perhaps simplify the
> presentation:
>

Thanks! But now it may still need more experimental examples
to prove that this optimization is visible.

>   The performance for 'git for-each-ref' on the Git
>   repository itself with X references changes from
>   3.2 seconds to 2.9 seconds.
>
> > Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> > ---
> >     [GSOC] ref-filter: use single strbuf for all output
> >
> >     This patch learned Jeff King's optimization measures in git
> >     cat-file(79ed0a5): using a single strbuf for all objects output Ins=
tead
> >     of allocating a large number of small strbuf for every object.
>
> This part of the cover letter could be put into the
> commit message itself. Use the correct formatting,
> though:
>
>   This approach is similar to the one used by 79ed0a5
>   (cat-file: use a single strbuf for all output, 2018-08-14)
>   to speed up the cat-file builtin.
>

OK, I will do it.

> I found the code change to be correct. Thanks!
> -Stolee

Thanks.
--
ZheNing Hu
