Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3463520281
	for <e@80x24.org>; Thu, 29 Jun 2017 17:10:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752343AbdF2RKj (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Jun 2017 13:10:39 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:35159 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752136AbdF2RKi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jun 2017 13:10:38 -0400
Received: by mail-pg0-f42.google.com with SMTP id j186so50852315pge.2
        for <git@vger.kernel.org>; Thu, 29 Jun 2017 10:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aqF1quBzqauHQ/XTyCCIDNPoGDFsgifC7ZEu89Yj914=;
        b=fqBCcyQ1AbWceqAW1V/TfywY2JCHgjsEQlEavwoKmm7/pQLn3HFDhLVtkE1/ziAy1/
         NR/7XZbkmaruhmn0VCysr0VmI+sArX9oHGSK9SYggJhRKZkUIIgzaee+1ECnc/5XJ+/v
         YhUn5whl9EzL1op1i1U7GhMeNUTcLep/Hl6cfCbqfDj+g788Cuox29bdGXe3cn5OUp55
         VG81rQQiJnqhrSiPtX3QxFYLoJvehUJy6sF5Ucr7SKLUorQnlmTkoBq4CDZYp4/PaVWz
         5AYpalRWg6Mf/AjtPh2NABZ7Y1KeknvcRZN+op96UmHp5U75xd6eJfCS9OrLZWlwlc+Y
         ZQ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aqF1quBzqauHQ/XTyCCIDNPoGDFsgifC7ZEu89Yj914=;
        b=LvtShmK/A+iv+0fhggp5AvBBB8g6w6YNE0eeZ2r7TlPhNKQH5p6YkZL54nCCxZhH7H
         6knjdK05RxqbiM95hf3Xh8APnryKN4zzu3+KqU4rABBhc6m0gF+S7ikZrGdvDvklsKz1
         pz4nI44J51RqUmkw87b35bd0be4Q2ZxM/kFCSrk040wzQorLg1o0HG6olP8Q6LdfOPFV
         WU4/oOrvirOkYHpVByGDFGS/krsOY/edZFY8EdzQgyyEKfLNs2n6OtPLnAW+gSSjojrQ
         6cGDQUEywtjhaYT4qr74Ou9YvyxM3TkfjmqMM61FyzBsOwzaGFpDmFlAtC/Qi4q12jSE
         kZdg==
X-Gm-Message-State: AKS2vOwR3pUd1QrxvCV064hQ7+a045D7ToBiZrKCZP5aKIwpvO4/r/YG
        dvWpeyKFX+pzH72ornXfX9qHPXzsuHL4
X-Received: by 10.98.19.136 with SMTP id 8mr17548849pft.105.1498756237343;
 Thu, 29 Jun 2017 10:10:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.183.170 with HTTP; Thu, 29 Jun 2017 10:10:36 -0700 (PDT)
In-Reply-To: <20170628215809.23060-4-avarab@gmail.com>
References: <CACBZZX6Hp4Q4TOj_X1fbdCA4twoXF5JemZ5ZbEn7wmkA=1KO2g@mail.gmail.com>
 <20170628215809.23060-1-avarab@gmail.com> <20170628215809.23060-4-avarab@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 29 Jun 2017 10:10:36 -0700
Message-ID: <CAGZ79kaLEA+6DDgWnqw-hg1GrWVD7CgGNAkmXx_iQmeKGSJUqQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] grep: remove redundant "fixed" field re-assignment to 0
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, J Smith <dark.panda@gmail.com>,
        Joe Ratterman <jratt0@gmail.com>,
        Fredrik Kuivinen <frekui@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 28, 2017 at 2:58 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> Remove the redundant re-assignment of the fixed field to zero right
> after the entire struct has been set to zero via memset(...).
>
> Unlike some nearby commits this pattern doesn't date back to the
> pattern described in e0b9f8ae09 ("grep: remove redundant regflags
> assignments", 2017-05-25), instead it was apparently cargo-culted in
> 9eceddeec6 ("Use kwset in grep", 2011-08-21).
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  grep.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/grep.c b/grep.c
> index 6614042fdc..7cd8a6512f 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -627,8 +627,6 @@ static void compile_regexp(struct grep_pat *p, struct=
 grep_opt *opt)
>             has_null(p->pattern, p->patternlen) ||
>             is_fixed(p->pattern, p->patternlen))
>                 p->fixed =3D !icase || ascii_only;
> -       else
> -               p->fixed =3D 0;
>

I was about to propose a similar action as in 2/5,
but getting the condition right is not as easy:

    p->fixed =3D (opt->fixed ||
           has_null(p->pattern, p->patternlen) ||
           is_fixed(p->pattern, p->patternlen)) &&
           (!icase || ascii_only);

does not look as convincing here.

Thanks for mentioning 9eceddeec6 as in that commit
I would have been easy with just proposing to have

    p->fixed =3D opt->fixed || is_fixed(p->pattern, p->patternlen);

Thanks,
Stefan
