Return-Path: <SRS0=MMY4=4L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA0FBC35670
	for <git@archiver.kernel.org>; Sun, 23 Feb 2020 09:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C174206ED
	for <git@archiver.kernel.org>; Sun, 23 Feb 2020 09:14:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hUXBcXLY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbgBWJOJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 Feb 2020 04:14:09 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33978 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbgBWJOJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Feb 2020 04:14:09 -0500
Received: by mail-pf1-f195.google.com with SMTP id i6so3696948pfc.1
        for <git@vger.kernel.org>; Sun, 23 Feb 2020 01:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gjrvOSdVO6K2bodpvK0OjE4pBLBuiUSCcLVInkOaoR0=;
        b=hUXBcXLY6h90i+XuJrxVt4teCntjmX4SxiBMqOcudW4ej2zkGbmyRkT8CXC1lRe9J2
         32rrbd7jZqf3gSv72ftr7M0a0qUIgZMHuey4w3KA+hlNw4c7gJbAyRlnOAz1FWJ8iZrG
         C9H+cuc0mnsChRrchRLvKuJ/fsyKldsZz0FVBQlkwMHUXsxQeVirrdqhN8sMR+F2Zb0P
         ADpFirRc9t6rRHjDwfPM1mTxyAWM18ug5GnlDe2KLdsFecZ6OGwv9/rV+lqH8W5DYlcN
         9s+h/VN5e7uh80Tj3JOhYVHgD9iZj6I3v+72sJD5tIuzPDGI3xMatdSnF+l+NWKyGwgS
         TI0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gjrvOSdVO6K2bodpvK0OjE4pBLBuiUSCcLVInkOaoR0=;
        b=CTIWKG5rCfiO6Csc+NDSUsVlOmsdSfWs+j/kso71fio5i83FUHk8+7vcVmzKplVz3u
         6CdglvWL43TBGsCCb69/oUQVv4f8FQlJhSG+pv0pRNfKnK9a7NL65mAd8UJRm6arFS7U
         Mtp0kaB2ZQGTnQUg2jE1R5jzOV+kQT/DEeXgUYcoV1gjt920URU3eR6CV8S2wPUmv4Z+
         gS5tzLkvEo5Iq4tk70vL4qoF2dVFDZ6FtUXxHkSH33kZzVOi3UuXLsekdnGYxkZ+qqp8
         7XgvxZ74xY2FS1POR+pfoWdxaWCSIx6ifplJ4wXVDfjqx70gSeV9yEfJZFoRFIXkufPh
         r+4w==
X-Gm-Message-State: APjAAAU+yi1zlxR9+1BSzA3EQbRtcv2rLH1TrwIAAlhDPCiqQM9EYW9D
        v7zVNto84kqutYKCX+CZqa3UYFma48zlC3mKy40=
X-Google-Smtp-Source: APXvYqw/bzmZZfEi5NtNhYXhpFNTcgYxS4QpZBnmq/h+huwW4fRyNd1atxOoxKJBYUFlCxRWpU+Fktaqo9Y4LIqQtmE=
X-Received: by 2002:a62:e112:: with SMTP id q18mr23623788pfh.88.1582449249016;
 Sun, 23 Feb 2020 01:14:09 -0800 (PST)
MIME-Version: 1.0
References: <0157c714-2d9b-7896-f5dc-232d82a46625@web.de>
In-Reply-To: <0157c714-2d9b-7896-f5dc-232d82a46625@web.de>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sun, 23 Feb 2020 10:13:57 +0100
Message-ID: <CAN0heSr+S6FTVrjfa9ZQipyKjv611-DCLZpQPjJUm+T4sMM47w@mail.gmail.com>
Subject: Re: [PATCH] quote: use isalnum() to check for alphanumeric characters
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 22 Feb 2020 at 19:53, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>
> isalnum(c) is equivalent to isalpha(c) || isdigit(c), so use the
> former instead.  The result is shorter, simpler and slightly more
> efficient.

From git-compat-util.h I can see that the claim about equivalence is
correct. And the efficiency claim, too. And agreed on "shorter and
simpler".

> --- a/quote.c
> +++ b/quote.c
> @@ -55,7 +55,7 @@ void sq_quote_buf_pretty(struct strbuf *dst, const char=
 *src)
>         }
>
>         for (p =3D src; *p; p++) {
> -               if (!isalpha(*p) && !isdigit(*p) && !strchr(ok_punct, *p)=
) {
> +               if (!isalnum(*p) && !strchr(ok_punct, *p)) {

I failed to identify any similar constructs. Looks good to me.

Martin
