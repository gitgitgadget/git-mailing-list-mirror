Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FF3F1F461
	for <e@80x24.org>; Tue, 14 May 2019 12:57:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbfENM5Q (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 08:57:16 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:33414 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbfENM5Q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 08:57:16 -0400
Received: by mail-io1-f65.google.com with SMTP id z4so12941260iol.0
        for <git@vger.kernel.org>; Tue, 14 May 2019 05:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mOz7Vnbunrp1/vSG0EZWb0FeZogcXZTJZdVGsLjYbW0=;
        b=ioEQZjikoMqv/YAJPicxwochlr0BSre2dHlJfpixhhG2ApAD8pE55LNMQHHj5vRaLb
         3NpJVO71cpmTtjRhWvkC2xhKfiB423Uu8nAwnt8m87CQQIRG05IjK9eltF0wCrhOFN9G
         eoUFCa+6nr2I11Z+J5Vfv5fnEm3QMteVt1fkSsWFr5Rqp5xRSRhvKc4UbvmAZlWTUSQn
         c96zkJ/ZTVrryCwLvAbFcBvwBwWi/YdjcdIl13q4BmiAeT01werNRVKoTwpyDwCZg+3D
         Qm9+3KOkDepeaNM32JgES9SaFZXRd4+qKAucme9d1et8uytw+Fkpm45zQldCFRNHsQHm
         7E6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mOz7Vnbunrp1/vSG0EZWb0FeZogcXZTJZdVGsLjYbW0=;
        b=SpPNmkz0An4O6bAToGdtiCn5zNWyyV5/6GnmemHKsqsbyyi5HNKM88jVH/xYbtDTOB
         yyVmF68OUaHyGAsSoP0GkmNkYzqRy4i27yootEkiwhTRT4OY7HqhkcKfGDgzrZy0C+f9
         o6yiz4rfqK+igOb1CGbGXQIj1fZqTZ9bFtZxdzlvO7DPyzJodT5naIo5AU12bDMblWa5
         Hfve09xycLzONVU+REpgdAEml09yIGsbUruInkCcYNOsYnKSPsKxU2e6Mk77rgSTn7jl
         62Wf/wi95Q9ZBQoydG1NFIfONuQjKaVWE8TBG7QUmboFCRpcZBF8fxXxvlaTpW/f+53g
         FQog==
X-Gm-Message-State: APjAAAX56OIselsbOA7OJVv3wCD7yoh2erFvMpm6aUT49rHpX359zmTP
        btmnBhI63BbE9X+Hn8vJVkob8rMJ3jXMI/1bUSc=
X-Google-Smtp-Source: APXvYqx0R8unNvJWMvd0XFzwbbtrSgStSx8AlqElCHFKUN3HKWlsRTFJ5JmgcmNAxgODU/PXGQFUQqFcMg3fUKs18+g=
X-Received: by 2002:a5e:d60f:: with SMTP id w15mr17181247iom.282.1557838635532;
 Tue, 14 May 2019 05:57:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190514002332.121089-1-sandals@crustytoothpaste.net> <20190514002332.121089-4-sandals@crustytoothpaste.net>
In-Reply-To: <20190514002332.121089-4-sandals@crustytoothpaste.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 14 May 2019 19:56:49 +0700
Message-ID: <CACsJy8CnCoMK7ahjRotKfiC2ic-U0hdhKuQAeF-TtVt8N+bU2Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] rebase: add support for multiple hooks
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 14, 2019 at 7:24 AM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> diff --git a/builtin/am.c b/builtin/am.c
> index 912d9821b1..340eacbd44 100644
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -441,24 +441,8 @@ static int run_applypatch_msg_hook(struct am_state *state)
>   */
>  static int run_post_rewrite_hook(const struct am_state *state)
>  {
> -       struct child_process cp = CHILD_PROCESS_INIT;
> -       const char *hook = find_hook("post-rewrite");
> -       int ret;
> -
> -       if (!hook)
> -               return 0;
> -
> -       argv_array_push(&cp.args, hook);
> -       argv_array_push(&cp.args, "rebase");
> -
> -       cp.in = xopen(am_path(state, "rewritten"), O_RDONLY);
> -       cp.stdout_to_stderr = 1;
> -       cp.trace2_hook_name = "post-rewrite";
> -
> -       ret = run_command(&cp);
> -
> -       close(cp.in);

In the old code, we close cp.in...

> +int post_rewrite_rebase_hook(const char *name, const char *path, void *input)
> +{
> +       struct child_process child = CHILD_PROCESS_INIT;
> +
> +       child.in = open(input, O_RDONLY);
> +       child.stdout_to_stderr = 1;
> +       child.trace2_hook_name = "post-rewrite";

maybe use "name" and avoid hard coding "post-rewrite".

> +       argv_array_push(&child.args, path);
> +       argv_array_push(&child.args, "rebase");
> +       return run_command(&child);

... but in the new one we don't. Smells fd leaking to me.
-- 
Duy
