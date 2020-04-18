Return-Path: <SRS0=qItC=6C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C2AC352BE
	for <git@archiver.kernel.org>; Sat, 18 Apr 2020 19:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 892F821BE5
	for <git@archiver.kernel.org>; Sat, 18 Apr 2020 19:56:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eOi046B0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbgDRT4s (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Apr 2020 15:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727927AbgDRT4s (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 18 Apr 2020 15:56:48 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CDE4C061A0C
        for <git@vger.kernel.org>; Sat, 18 Apr 2020 12:56:48 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id 184so3438345vsu.3
        for <git@vger.kernel.org>; Sat, 18 Apr 2020 12:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yH2X1Ltl5brWL51+n2mElTgAm3PJwO9kpd7OsO5LfLc=;
        b=eOi046B02jsuiYHvLRI00nQtTSyQU6Ed7TbMBdcicauRZHeTAFT4BQbpIREEHNF9m8
         lRZIBKStA9tTLhksDJTsVBSPZMNHIN+6QmX17cQrDlSL6i90ijSEOT1/b0oL1hUKqjBB
         Zh11fNvq19ttSOY/zFFGYtzwZRYOiSeUd7X1byM20BuR7HqfS2X7ncwIN1/1OwlWutdK
         nEwZ29qPLb0QW0JRsqoCU0jkJE8MB5ngJBkApIO4gL7Z4HgGiY06k78pmEuSWK9AaF2s
         /WDY6vKTYFe3LEJsRuta7p9cIeMl+XY34OezYBG0gtHYffZbaxRAX/2ajWRrohwlBx/f
         qoDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yH2X1Ltl5brWL51+n2mElTgAm3PJwO9kpd7OsO5LfLc=;
        b=lQO0c9oWlbS4Kg+qiBp3fiA12etvm0blSr5ENqbr/fN64d1TFN3p8gCqo9Q3tBhHpJ
         anI0ikcadPFQh+nkIWNDZUjpvhAqkLxDA/o2B3B3izYCshpWyZzhf7LI1B6zWwBgEhMZ
         SKecjZ/yPH2rrJDgjWNru5zDCxGDvfUfd+gPJxzGjEQEpmYAfdVuiem4vcma88B3ZmaR
         z13FufSkLxq1AKa9dgzuGANufdWuQl+emTLDEDhSS28hieD5MQSkCWLdrLj/ig8cwiSy
         BaEdToSvMmefYDOf0+69w1HoowlXdDRa+ED3LCRT2Sd1ZiqkkTV1jevB+Tc+BZU0tmLE
         Nvgg==
X-Gm-Message-State: AGi0PuYRvwzSQ5eDRMIDJcyPQO1rdF39zfaVftyvGd7uZ3j/q3FXGnWM
        dM/7RKfc3ZlMtYRWHm43mMj2hdRC3R0gSt4xjjlaOQ==
X-Google-Smtp-Source: APiQypLAzDC4TaZnee+PLAz6aW+d8SVM1N9D4CXfZVHYx9Y81Zz0rFzWYBxljUuHQMGtPJ7GE2K3IrO1wsgk2pLtQOk=
X-Received: by 2002:a67:e911:: with SMTP id c17mr6693331vso.46.1587239806830;
 Sat, 18 Apr 2020 12:56:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200418035449.9450-1-congdanhqx@gmail.com>
In-Reply-To: <20200418035449.9450-1-congdanhqx@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sat, 18 Apr 2020 21:56:34 +0200
Message-ID: <CAN0heSppn6BBX4V1T1qgKc4XP+8i6qbcEqd1_3NqWQtZJLaJww@mail.gmail.com>
Subject: Re: [PATCH] mailinfo.c::convert_to_utf8: reuse strlen info
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Danh (I think that's how you want to be addressed?),

On Sat, 18 Apr 2020 at 06:00, =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh <c=
ongdanhqx@gmail.com> wrote:
> @@ -447,19 +447,21 @@ static int convert_to_utf8(struct mailinfo *mi,
>                            struct strbuf *line, const char *charset)
>  {
>         char *out;
> +       size_t out_len;
>
>         if (!mi->metainfo_charset || !charset || !*charset)
>                 return 0;
>
>         if (same_encoding(mi->metainfo_charset, charset))
>                 return 0;
> -       out =3D reencode_string(line->buf, mi->metainfo_charset, charset)=
;
> +       out =3D reencode_string_len(line->buf, line->len,
> +                                 mi->metainfo_charset, charset, &out_len=
);

This is equivalent as long as `line->len` is equal to
`strlen(line->buf)`, which it will be (should be) because it's a
strbuf. Ok.

>         if (!out) {
>                 mi->input_error =3D -1;
>                 return error("cannot convert from %s to %s",
>                              charset, mi->metainfo_charset);
>         }
> -       strbuf_attach(line, out, strlen(out), strlen(out));
> +       strbuf_attach(line, out, out_len, out_len);

This conversion is ok as such. I wondered why we pass in the same
value twice (before and after this patch). Turns out this usage is wrong
(as per the documentation in strbuf.h) but safe (as per my understanding
of the implementation in strbuf.c). I'll follow up with a series that
fell out of that investigation.

>         return 0;
>  }

All in all, this conversion is correct and it doesn't leave the
use of `strbuf_attach()` any less correct than it already was.


Martin
