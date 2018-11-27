Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A7591F97E
	for <e@80x24.org>; Tue, 27 Nov 2018 19:44:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbeK1GnI (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Nov 2018 01:43:08 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39069 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbeK1GnI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Nov 2018 01:43:08 -0500
Received: by mail-ed1-f65.google.com with SMTP id b14so20045065edt.6
        for <git@vger.kernel.org>; Tue, 27 Nov 2018 11:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0rkst4Bavjx9NkKVVmA5I0U3FsIv5heTe01kew6UzNA=;
        b=XjfyHQFLPx7FkC/RYXK/xa6S582lCq0bxcO4qL2viiTnSMXssOgVsjV3LEx+TxTC2l
         NQ5Ow0SYhSY7b885VYvtagLPv6XwXB3Ai3oG+fL0JcUwAY158PqoVUsF+oPr9a8k0iLX
         49QVQL9aW/FBtU+Cyo/dUbXUc0+Xyz+5RD+lsdHRDK51oWYd/CMRO7Mv5SkrGUp9AiX1
         eAcfLTJ2QUdf4O12s+iyMiOSZRx6Gtmog68p3JEeJsCp1fNmvkxGzoSOSJLnsvEzvVHs
         Xe4D9m3PebeYv3xuRAPS2hOFJRRg9PfLX8nVLLsg6/Dr5ACFam2P/ddwloCUxEih70we
         mX5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0rkst4Bavjx9NkKVVmA5I0U3FsIv5heTe01kew6UzNA=;
        b=ZufMIZGwpFekUBBIoO3i8tUwVrmEhxMwdIE9Nr7UQNzK87mYNhJoAKx8r7u+mW/4/s
         EqDni0GndIKTmpjlpP04kgw9x6Wj5OfpPl0PuHMKFwF8C164b6Fdf2xpp0z291iJK+mF
         OY8qiu2nAC4ZXHqRqay0+sEFtKmA75WEYfLi7jcnur+ovmtvNnnCebjBkQWUgYdDtUEi
         ukXj5Aa4MB17maDfGwsvqmLbCA1lm4kOpbZ9tkSbfV0pWvdzamkLksVQLRjUlPEtnC5u
         l4JOb7wUF5v9/MPal3bUGsV6mwlaz9gw2xol9Pxh2ZjuLL3DMP4/zO3C4YXzfOfk69+Y
         J5Lg==
X-Gm-Message-State: AGRZ1gIlP/Unb/0h8Q/hm7SfoQhvzIUaubWGFMmVFI28XUqAKsGgFs3/
        835mzri5li8Y2oH9T9+z7OhKokARQBKtcCmLIwAh4Q==
X-Google-Smtp-Source: AJdET5et7onPtguVU4uJwq4pAE14SXAQCof4TzCamzpaXJ6S+czrVxN2u3K2vX+bDjGmoGSRIEZrTzNOxzNt/8HB5nw=
X-Received: by 2002:a17:906:b7d1:: with SMTP id fy17-v6mr24341639ejb.70.1543347848719;
 Tue, 27 Nov 2018 11:44:08 -0800 (PST)
MIME-Version: 1.0
References: <20181120174554.GA29910@duynguyen.home> <20181127165211.24763-1-pclouds@gmail.com>
 <20181127165211.24763-2-pclouds@gmail.com>
In-Reply-To: <20181127165211.24763-2-pclouds@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 27 Nov 2018 11:43:57 -0800
Message-ID: <CAGZ79kYXYzS6mHJWSkC-gAj_Ts2z8-jCX9tuTenKE+bxTgbtHw@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] parse-options: allow parse_options_concat(NULL, options)
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 27, 2018 at 8:53 AM Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <=
pclouds@gmail.com> wrote:
>
> There is currently no caller that calls this function with "a" being
> NULL. But it will be introduced shortly. It is used to construct the
> option array from scratch, e.g.
>
>    struct parse_options opts =3D NULL;
>    opts =3D parse_options_concat(opts, opts_1);
>    opts =3D parse_options_concat(opts, opts_2);

While this addresses the immediate needs, I'd prefer to think
about the API exposure of parse_options_concat,
(related: do we want to have docs in its header file?)
and I'd recommend to make it symmetrical, i.e.
allow the second argument to also be NULL?

In the example given here, you'd just short it to

    struct parse_options opts =3D opts_1;
    opts =3D parse_options_concat(opts, opts_2);

if not for this patch. Are opts_{1,2} ever be NULL?
