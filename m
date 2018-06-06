Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FD811F403
	for <e@80x24.org>; Wed,  6 Jun 2018 17:15:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753015AbeFFRP4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 13:15:56 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:34088 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752243AbeFFRPz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 13:15:55 -0400
Received: by mail-yb0-f196.google.com with SMTP id n23-v6so971885ybg.1
        for <git@vger.kernel.org>; Wed, 06 Jun 2018 10:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=FbvD1bG6bdOFcsTGuDlfuKerMlVJb/32/OhyE3jD0N0=;
        b=XKy6bJ7M9tZNeu5iLP4uPpN6scgScGdhIzwoW+wXgi95GD9FFMuechOD3pmNyevuWp
         b4icGnH7SpC9mmNZAPev5+N8lrkihotoJklnMtsjJ7WIu58CnOnoA9hsjOCdoS06TYAu
         AsI0kpdhb04c3js3KA66pPJu+GeP8ohtj8Sa9rSGdxOh8wl0KFIVJTjIC+cDCoRUmxgk
         n/rHQIv6Job51cTcr70jEUOoSZaYYXiAAZ08KIwF3cO5zWE4gKCdQx30u4NEGqejkZha
         BFJLaWKXwa0vonU3QioJGOthDONAVFt2XghCMCLM87i4wevHKo+cdLPvhasXLPoacvFv
         o8JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=FbvD1bG6bdOFcsTGuDlfuKerMlVJb/32/OhyE3jD0N0=;
        b=cwknwiEDIFmTa9lOJT3oLIoLQ26zumukxGhSqYMKhaXgrWs9tlm7W/xgyc69WMg2Pi
         CFpMAXmQJ+pP5dOMYS5aK9SQnkD/X9+IhXGiy4a54MZBeWwFFb4EkTaOjfBW+qK2c56M
         0iEOsQO06vghqiwgt5ovzAPmQI882oXfW1DNSm03SVgEBOUiOS7fxyHayuWrNrpQgjBW
         +Ty50weWH6/uNUyNrXtuwNgpJWiR64i/yIl/D1K0OeGLHjp6YY8Uv9pH01FSFBUuggQq
         ZGN0i2wY/QR8krFgDQLtey7Rgga9l/wFK94dgkcRCUYnVkOGs9fsFd7lyRqAl2BYseIG
         Rigg==
X-Gm-Message-State: APt69E2LVONoA/CZ3CPMNlHrkxmCsUjuOpNPht/jKmpoSeSgdVlT9N3f
        DGfVa8HSdrUaBaZZzQzR08PA1rBcTUl4liDm7lU=
X-Google-Smtp-Source: ADUXVKJHl2KHhHCp9n2Yssm9k56k8oLB1ywOUs696DissUYjZmnTnxMA2ZoCafYo3MBrG95DljTkr/1a3mGBXUtJt2c=
X-Received: by 2002:a25:8751:: with SMTP id e17-v6mr1679666ybn.194.1528305354939;
 Wed, 06 Jun 2018 10:15:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5b:784:0:0:0:0:0 with HTTP; Wed, 6 Jun 2018 10:15:54 -0700 (PDT)
In-Reply-To: <20180604201742.18992-1-asottile@umich.edu>
References: <20180604201742.18992-1-asottile@umich.edu>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 6 Jun 2018 13:15:54 -0400
X-Google-Sender-Auth: _P3gKiFiHEBAw6ahtM1VFFxvxD4
Message-ID: <CAPig+cSzJ=2Zz7jRNB7sK7FyZ+YwdAFseCTSDbM_m4E8K9WxHA@mail.gmail.com>
Subject: Re: [PATCH] config.c: fix regression for core.safecrlf false
To:     Anthony Sottile <asottile@umich.edu>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 4, 2018 at 4:17 PM, Anthony Sottile <asottile@umich.edu> wrote:
> A regression introduced in 8462ff43e42ab67cecd16fdfb59451a53cc8a945 caused
> autocrlf rewrites to produce a warning message despite setting safecrlf=false.
>
> Signed-off-by: Anthony Sottile <asottile@umich.edu>
> ---
> diff --git a/t/t0020-crlf.sh b/t/t0020-crlf.sh
> @@ -98,6 +98,16 @@ test_expect_success 'safecrlf: git diff demotes safecrlf=true to warn' '
> +test_expect_success 'safecrlf: no warning with safecrlf=false' '
> +       git config core.autocrlf input &&
> +       git config core.safecrlf false &&

I was going to suggest test_config() for these rather than bare
git-config, but I see other tests in this file already use the bare
form, so this is following existing practice.

> +       for w in I am all CRLF; do echo $w; done | append_cr >allcrlf &&

Simpler: printf "%s\n" I am all CRLF | append_cr >allcrlf &&

(probably not worth a re-roll)

> +       git add allcrlf 2>err &&
> +       test_must_be_empty err
> +'
