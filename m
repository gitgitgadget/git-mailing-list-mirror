Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B17FD1F462
	for <e@80x24.org>; Sat, 27 Jul 2019 23:48:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbfG0Xs3 (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Jul 2019 19:48:29 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40026 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfG0Xs3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Jul 2019 19:48:29 -0400
Received: by mail-ed1-f68.google.com with SMTP id k8so56194201eds.7
        for <git@vger.kernel.org>; Sat, 27 Jul 2019 16:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=9tojZPyTZhHxGEyNFygHWM1Gor/tY4Y0/MWBoYwy9VE=;
        b=ZEU24iOjObZhq2OBOxS3aHq90/vjENyqjFPIAEEKe6r2s/nQ//pGHRyOIetcbllVO8
         0qaDOu1cLqmmUC1sHF0TUlqWeVSX2yw8cVcnDFMdymzYeB5UgLycWTU3docBIszgpHQO
         AXKoBW/gx1WQJtkeiMynXrMz6g9Qom7dsSlwJzuccPl9OTtWukmbFVXP9TERkgXNd0EX
         c3P/8aoHFrgpMLxoNRBPx3V25c+HMWLPEmiRAV+dva2iHdwSYHSWPZ/r02kHTIlU28Cz
         KLjzID8UwQfthbsaf/8s1cltXp3IP6t1Qam0/W39of3oGXOLi6b3NupD+TR4DjP/oYVm
         4LuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=9tojZPyTZhHxGEyNFygHWM1Gor/tY4Y0/MWBoYwy9VE=;
        b=PwuQPCLc/RjdQv2Els9L4h6ItPDsiYSUQshvkS34NYD9K0KE0fQL+wf5yYGZ7jYMGU
         76c78msucs1KIjnlalLGUxPSdL7ovt0IoN+0dQYg5yj/BMKxbSqSevjjJc6xYg/iTRz0
         WspC2bthavTTE+/ZZZEdwIfX+AJPeaB99ENwBJfDMaqWCvjf+bz/BFpYjy/j7b77zJ86
         pi4G3tYEsEt3aKRQMZCVOWFJrNtb2UsdMr7EKVsXzHAYYApd07QMvNmKDYC/8+qi8TtU
         7feTrSe4n7cQUCjUJzlERjlGGJNqAb4oJRGr1EfM50xkYI0R6Ii+t0cUDW6krjB9VmPI
         ZryA==
X-Gm-Message-State: APjAAAWMprdlhz6w/vo9plk0fHdHS4iBP4ubmZ+bYk1XXPc5vhBLN5ax
        h8Q/MCUXbd1dSmf1UUPhkRQMlAOI
X-Google-Smtp-Source: APXvYqxBNugT8oNDqERzl2AubTqM7YoccT6h8qGrrzao531F+z5mFhOvPnQDq9UAnxKrAgAri+TmMQ==
X-Received: by 2002:a17:906:4d19:: with SMTP id r25mr78023857eju.125.1564271307702;
        Sat, 27 Jul 2019 16:48:27 -0700 (PDT)
Received: from evledraar (i237193.upc-i.chello.nl. [62.195.237.193])
        by smtp.gmail.com with ESMTPSA id oe21sm10132447ejb.44.2019.07.27.16.48.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 27 Jul 2019 16:48:27 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/3] grep: plug leak of pcre chartables in PCRE2
References: <20190727202759.22310-1-carenas@gmail.com> <20190727202759.22310-4-carenas@gmail.com>
User-agent: Debian GNU/Linux 10 (buster); Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190727202759.22310-4-carenas@gmail.com>
Date:   Sun, 28 Jul 2019 01:48:26 +0200
Message-ID: <874l376nud.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Jul 27 2019, Carlo Marcelo Arenas Bel=C3=B3n wrote:

> Just as it is done with PCRE1, make sure that the allocated chartables
> get free at cleanup time.
>
> This assumes no global context is used (NULL passed when created the
> tables), but will likely be updated in tandem if that ever changes.
>
> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> ---
>  grep.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/grep.c b/grep.c
> index d04635fad4..d9768c5f05 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -604,6 +604,7 @@ static void free_pcre2_pattern(struct grep_pat *p)
>  	pcre2_match_data_free(p->pcre2_match_data);
>  	pcre2_jit_stack_free(p->pcre2_jit_stack);
>  	pcre2_match_context_free(p->pcre2_match_context);
> +	free((void *)p->pcre_tables);

Is the cast really needed? I'm rusty on the rules, removing it from the
pcre_free() you might have copied this from produces a warning for me,
but not for free() itself. This is on GCC 8.3.0. How about for you &
what compiler(s)?
