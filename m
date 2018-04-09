Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB5571F404
	for <e@80x24.org>; Mon,  9 Apr 2018 21:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754615AbeDIVNv (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 17:13:51 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:44336 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754089AbeDIVNs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 17:13:48 -0400
Received: by mail-qk0-f193.google.com with SMTP id n139so11040141qke.11
        for <git@vger.kernel.org>; Mon, 09 Apr 2018 14:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=YVoTmzMutjn7+PcNnx3lxOf4+/o1ec16z/mZZjXFdCc=;
        b=TZpC/Fdf10Gxh8Tn7JSoRuo0b2VuhLhqhplITHJoOl1TXD7nLH3Ia6TggZgAbIyPFO
         5ht8o8P68I4YZ+psYOb/g+YKryGnUR7Yk3wNtuFrxxrJkhP4vAb3nvLG0FOMQm5i5rss
         VTwO/TlTkycS2CAUmxf8Eu7vifLHFyTedpfzBr4hRU2oOh26pFuU8AcHEjPMh7FZaEj4
         bHJxMIuBImAhfFdiUsnRKbS/uAvM0ivdSy6MlXtGo51I2gL5cntYDHYl8l6ws7IBc1gb
         a0FL4RURR/xN/OTeiXhGqu7Pbw+rcyDQe6GRmkotZyt1I64U+6bwnaWz472L5Vpeg1yW
         U18w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=YVoTmzMutjn7+PcNnx3lxOf4+/o1ec16z/mZZjXFdCc=;
        b=phE7VmthGnF4e9azIbnXGC3BNUu84QBPPNB/SL5xslq7YgRZ/qooKyXEEU4nwnI/kj
         MxLYdu+NFiIn5QTvCT4jEIuhUp4TClax4nxnkPWsljAdiuJ0lHDCtq6b4CFqNh5SJXs6
         pSKS6IYS3dffOsNq9ga2D95a6LFO/J2VH8j1XW21SxjX47tqMhfJRCEif8EyKzm0MoId
         r6GZH245tcwC/deC8jR6R4CREvNq8hmZ8sq0M/IvMeyDq30jHwSaIAgvNAG+HDEpPz8g
         dpLYyTNuP8Va9OFwviFcT/m/nGHH5bqxHbvMfX+iUFf6/YGwggJLgXFyGGSTX19r7uAO
         vzUw==
X-Gm-Message-State: ALQs6tBmjZ/roQbJvYy7PE/SSj0/CcWibxae1/MQfziwHZy1gDJ2lIQ+
        FNNPrvVR7AeyFZBiKlggQTx00+gVN91dyyy2u+8=
X-Google-Smtp-Source: AIpwx4/10uijxYJ8NWSlr6k+EZIzHjh/XArculvKO/ZarNiJ0bEayWUsMzg5A4EVsEz+B013Hf2qQB+fhXj/pmDylLY=
X-Received: by 10.55.3.140 with SMTP id 134mr52528103qkd.26.1523308426978;
 Mon, 09 Apr 2018 14:13:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Mon, 9 Apr 2018 14:13:46 -0700 (PDT)
In-Reply-To: <20180409204129.43537-7-mastahyeti@gmail.com>
References: <20180409204129.43537-1-mastahyeti@gmail.com> <20180409204129.43537-7-mastahyeti@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 9 Apr 2018 17:13:46 -0400
X-Google-Sender-Auth: ndwrWvhlfgxDmdi7i7B1O3mZkz0
Message-ID: <CAPig+cQQuvr5hOXgLM7rwHDK-q4eJrNLR==F+mQfHrBRjj0vWg@mail.gmail.com>
Subject: Re: [PATCH 6/8] gpg-interface: find the last gpg signature line
To:     Ben Toews <mastahyeti@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 9, 2018 at 4:41 PM, Ben Toews <mastahyeti@gmail.com> wrote:
> From: Jeff King <peff@peff.net>
>
> A signed tag has a detached signature like this:
>
>   object ...
>   [...more header...]
>
>   This is the tag body.
>
>   -----BEGIN PGP SIGNATURE-----
>   [opaque gpg data]
>   -----END PGP SIGNATURE-----
>
> Our parser finds the _first_ line that appears to start a
> PGP signature block, meaning we may be confused by a
> signature (or a signature-like line) in the actual body.
> Let's keep parsing and always find the final block, which
> should be the detached signature over all of the preceding
> content.
> ---
> diff --git a/gpg-interface.c b/gpg-interface.c
> @@ -110,11 +110,17 @@ static int is_gpg_start(const char *line)
>  size_t parse_signature(const char *buf, size_t size)
>  {
>         size_t len = 0;
> -       while (len < size && !is_gpg_start(buf + len)) {
> -               const char *eol = memchr(buf + len, '\n', size - len);
> +       size_t match = size;

If no GPG-start line is found then 'size' will be returned, which
matches the logic before this change. Okay.

> +       while (len < size) {
> +               const char *eol;
> +
> +               if (is_gpg_start(buf + len))
> +                       match = len;

Otherwise, the position of the final GPG-start line will be remembered
and returned. Makes sense.

> +               eol = memchr(buf + len, '\n', size - len);
>                 len += eol ? eol - (buf + len) + 1 : size - len;
>         }
> -       return len;
> +       return match;
>  }
> diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
> @@ -1059,6 +1059,17 @@ test_expect_success GPG \
> +test_expect_success GPG 'signed tag with embedded PGP message' '
> +       cat >msg <<-\EOF &&
> +       -----BEGIN PGP MESSAGE-----
> +
> +       this is not a real PGP message
> +       -----END PGP MESSAGE-----
> +       EOF

This bogus PGP message is just in the body...

> +       git tag -s -F msg confusing-pgp-message &&

and "git tag -s" adds the real PGP message at the end...

> +       git tag -v confusing-pgp-message

and the new logic finds the real PGP message rather than the bogus
one, so "git tag -v" exits successfully. Looks good.

> +'
