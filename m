Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D613AECAAD8
	for <git@archiver.kernel.org>; Wed, 21 Sep 2022 08:46:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbiIUIq5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Sep 2022 04:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbiIUIq0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2022 04:46:26 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00EDE77EBE
        for <git@vger.kernel.org>; Wed, 21 Sep 2022 01:46:22 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id bu5-20020a17090aee4500b00202e9ca2182so3239969pjb.0
        for <git@vger.kernel.org>; Wed, 21 Sep 2022 01:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=LPxiutrCb6KH20WN2XJDE+i91BJFAxQCRKfG5+gRtno=;
        b=JDD2XXavz7aIgH7r1CH9MFhLtjzbNe+NLdF4k+EV6CxXei0KU5v0aDW21HBwrhMCRm
         uyYtmLSlzRjhR5e77QbeVkqiRa7vsXJc4vnz3x6udxBHSKSk0CO2QWvCG5qyDN67fqn7
         8jgiZC7InT8HsfX3X2boUAYwynZIIfhPOADlUBCHyZFhnRzDPb6jb6/HrDuozeqjnG6Q
         gyXGr18DIZQxI/L+ki2lu6tYm4ab+NzxZHAnmUmCNe2wN1Q+gDJIkshbLwLTWCTPxbl/
         AvQi82a4G3PCQP+PJm14JloaxSf5I+Vknw8SJsSgUw8bRQwrYpUlk514nNlNmJ/UVeNs
         tDZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=LPxiutrCb6KH20WN2XJDE+i91BJFAxQCRKfG5+gRtno=;
        b=nAwdXllMxMF6f2E0liatwICoVYKgXH88FSpUyfL2aYIKQLvwSQBQ+zzbaFq8gnOuhM
         Q0tz/u26N+XG5LGf7jEJs7lHlbW9vEFOQucvSfhjqBAC6HGuDnry4v0ZlbHV+qAWsPTv
         gB6IrAW8HJxQAXIm0rZj2vusytyKxU8Y677vJpHTFmP84miI7od+GmaZhkuETmY3hE/J
         KjG7th+bVWSFLJnongQ3I2N3OMLtPmy3IgXz5gyFUYTEhrb4p8FwBYweSRLZvJzxEuQy
         3EjDzV6yg4mFM7ygzZnGxlP3xKyw7sXh8Gwgj2SlaoNh5qVyswlE9354lCbONN56FSNF
         rioA==
X-Gm-Message-State: ACrzQf3SnIjufUbzADUF9vleeQUF1ojWZyXmjwnk/5Ei/kHTIhnG9bDp
        nsOJfVyY9QmnjEY+Nk6uDXq5NONgIbCuOTgZEqo=
X-Google-Smtp-Source: AMsMyM5llkhJ0RXHUmvUzeUadkrteBJtlmRkY22O4JhlkLX4VvjUtHhSLePzF8jh26Wp5oUYkkMsu3Qy8AjrvfAXoKY=
X-Received: by 2002:a17:90b:4d82:b0:202:9030:e482 with SMTP id
 oj2-20020a17090b4d8200b002029030e482mr8539375pjb.110.1663749981479; Wed, 21
 Sep 2022 01:46:21 -0700 (PDT)
MIME-Version: 1.0
References: <CA+J78MWhp3qmbBhhSoioJP+d5eh-iEd_vHZdTNB69o7EvvXWYQ@mail.gmail.com>
 <220919.86zgev635z.gmgdl@evledraar.gmail.com> <xmqqbkrbb6ua.fsf@gitster.g>
 <CA+J78MWvOEbJY6+NcLFn0SJGMZn=N7QUMwc=Bta+uHicvD892w@mail.gmail.com>
 <220920.86illi5p6w.gmgdl@evledraar.gmail.com> <CA+J78MUM=JiAF7R_8oV23OQ-LndJbRm4AUdPsgS4HT4SduFgiw@mail.gmail.com>
 <YyrHKmNIoV70sATE@danh.dev>
In-Reply-To: <YyrHKmNIoV70sATE@danh.dev>
From:   Skrab Sah <skrab.sah@gmail.com>
Date:   Wed, 21 Sep 2022 14:16:09 +0530
Message-ID: <CA+J78MXtkYOALDqY4Bxva6nm+vJNtN_hO4w4vFTzx-7izP=zBA@mail.gmail.com>
Subject: Re: what if i use makeheader tool to generate c header file, it would
 be accepted.
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For foo.h and foo.h+, makeheaders tool already has a feature in it.
for more info. read the manual.

The tool is fast enough to handle the situation of generating a single file=
.
note: we can also manually edit header file, it is not gone only it's
auto generated.

For situations like struct, enum, preprocessor declaration, and compat
stuff I have mentioned in the previous mail.

On Wed, 21 Sept 2022 at 13:41, =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh <=
congdanhqx@gmail.com> wrote:
>
> On 2022-09-21 13:23:11+0530, Skrab Sah <skrab.sah@gmail.com> wrote:
> > 1. We would not commit the generated file.
> > 2. There are different ways we can install the makeheaders tool.
> > 3. Makefile will first generate the header file then other compilation.
>
> Without seeing the patches, here is my guess, you will make us only
> write source code in '*.c' and extract declaration from foo.c to foo.h
> And that will save us some time to write (and update) declaration in foo.=
h
>
> However, whenever foo.c is updated, foo.h will need to be
> re-generated, thus all other users of foo.h will need to re-compiled.
> Thus, increase compilation time. We can work-around by write the
> output to foo.h+ and compare to foo.h, discard it if its content
> hasn't been changed. It still takes time to analyse foo.c and write to
> foo.h+
>
> In addition, I'm not sure where would you put the struct, enum,
> preprocessor declaration, and compat stuff.
>
> If my understanding is correct, it's not worth the effort, IMHO.
>
> --
> Danh
