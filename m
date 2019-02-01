Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 970571F453
	for <e@80x24.org>; Fri,  1 Feb 2019 09:02:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728239AbfBAJCN (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Feb 2019 04:02:13 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34120 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbfBAJCM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Feb 2019 04:02:12 -0500
Received: by mail-qk1-f196.google.com with SMTP id q8so3595700qke.1
        for <git@vger.kernel.org>; Fri, 01 Feb 2019 01:02:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8zAspVltCfCryzuO76PkgwOPKCEw0Dm0/sQol7TcRk4=;
        b=tjC5tb+y0nOofqJ8wjNdKlTRiivXB1p49M7Z70y/msaMqJF4DhQqBzPegV2odWKmO6
         7QFppmKoLWAN4orXwzTVESWb7ZVXMhijQdGFt1i3BD94uGRZ7+9Adda3zXmSLNREacRH
         Lgvpk1O8WyX+Gs+4b3WEiIgRLzge1jQS532RezBru1P8v7Uy8kNjDfceYWFmUR53Njg1
         fTrvoSxBSziei4Cg9loXbObQQmbGKKXtIBOalEv20c81JCOjzs9gX9OrnXzsXypY/P9s
         A7CiL3wuYFWrvy4MOsizIjkChNh6+lYlhCtEAhackt1tkTxI4XyHlp9IAllG5llMoizJ
         BxLg==
X-Gm-Message-State: AJcUukfe0COhzl9cizb0rxGf8FxyVHFhH4jZMj51tLbm8Am/zwZB29nb
        nxrtxHUOaP8OmEAU363I/ja8CAu/4wnXfm3CSU/4/kHu
X-Google-Smtp-Source: ALg8bN6mAy+Lw89G83J2cmkEzOvm/grkk2E3+INnIYCexz9HQOgVj8M9+BgNh0XecklZ0RDn8JgHLodo8KA1Nty+88s=
X-Received: by 2002:a37:66c1:: with SMTP id a184mr34829039qkc.314.1549011731796;
 Fri, 01 Feb 2019 01:02:11 -0800 (PST)
MIME-Version: 1.0
References: <01020168a8338064-b1c054c4-3e05-4825-b8dc-636d9c63dcfc-000000@eu-west-1.amazonses.com>
 <01020168a8338127-d50bd8d1-c178-4f13-86b1-9a191f64ded0-000000@eu-west-1.amazonses.com>
In-Reply-To: <01020168a8338127-d50bd8d1-c178-4f13-86b1-9a191f64ded0-000000@eu-west-1.amazonses.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 1 Feb 2019 04:02:00 -0500
Message-ID: <CAPig+cTyVu7maTXBLaeCK7V_42+QrDPUs57a3F_tdwRDMYtcaA@mail.gmail.com>
Subject: Re: [PATCH 3/3] It's C not C++ so variable length array should not be
 used [-Werror=vla] :,).
To:     Shahzad Lone <shahzadlone@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 1, 2019 at 3:36 AM Shahzad Lone <shahzadlone@gmail.com> wrote:
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> @@ -197,9 +197,8 @@ static unsigned long write_large_blob_data(struct git_istream *st, struct hashfi
>                                            const struct object_id *oid)
>  {
>         git_zstream stream;
> -       const unsigned bufsize = 16384;
> -       unsigned char ibuf[bufsize];
> -       unsigned char obuf[bufsize];
> +       unsigned char ibuf[16384];
> +       unsigned char obuf[16384];

Reiterating my comment on patch 2/3, this code was fine until your
patch 1/3 changed it declare a variable length array. Rather than
creating a new patch to fix an earlier mistake in the same patch
series, use "git rebase -i" to adjust patch 1/3 to not introduce the
problem in the first place and drop this patch, and then (re-)submit
the patch series.

Thanks.
