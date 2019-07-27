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
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E0441F462
	for <e@80x24.org>; Sat, 27 Jul 2019 23:47:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbfG0Xri (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Jul 2019 19:47:38 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44289 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfG0Xri (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Jul 2019 19:47:38 -0400
Received: by mail-ed1-f66.google.com with SMTP id k8so56181660edr.11
        for <git@vger.kernel.org>; Sat, 27 Jul 2019 16:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=FqkXGe8gF+BuSZz5ctLdBOd+KEPXZSwOxa6U5y6M77M=;
        b=CRngLQFQDpgsRneMYMxZz6jR4ccMTO8FhKb3n08tJrWYYbPZtwwJC8lhLBQ1uSz75L
         zdP1Zok8qcL5YFlMXuNe4XHe+GvHADX1ndkMv8IAsDEbowQPsoGGu5ZSefdzWxDV7oiY
         zzT9U+O3AXJ3T/zIQxdCZRUHpFUTIqiN4otqgwQY9z2Du7+EkotP82da4sAnHI0FMRhr
         PXOHn48GI9hAKrUd2hQU4VUDRYPbVKI6d3/Wn0BQr7h8yLzSu3fsnVrNVsJAr4BQTrCE
         KQgzOhDJAvahQIAD43u/q25R+V5mmbfcBFSSHQ+W4oIE+yMAxihsGdFTPga3brzCEHsO
         G/Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=FqkXGe8gF+BuSZz5ctLdBOd+KEPXZSwOxa6U5y6M77M=;
        b=tEXh7aUJYlC4OaSg72wjkdEUw6tCkeZt9wRDH72m6qFHg8RhML0jAM3SEoUB737iQ8
         QSte35eId0ZmpQ8RVmQdN4/urlZaaRd/9NFSTV5Xkq62um8Cw/9tJhbq2bSJupJTmoNG
         NToGSLjo5cqSoytwJi/Fg/DV5tq/2SHjuXzZXL6KI8xG5eydtd3dzL6RK4b7FiTKDbeQ
         uwq6YYugm/h6Htk1fNllWYLTnxoAlhoY8zqd1ChpwH5SRKaeYXl5Q0NYzeFf+LwEuwT4
         PDIF9i/12JGgiCU7xNZapdrxZ5bVa2r3n0u8qwrLBIEbEPHSS9al/xIhakYjqdQt+JKY
         yimw==
X-Gm-Message-State: APjAAAXaX6wIN5G9HghGZw+Cn44X37kdOkBtVc4EZUsiejO+fibgexQE
        /yR1EWQtMBvCqK5GhBvqYVo=
X-Google-Smtp-Source: APXvYqyoKsin+c8u5U8F1728DCqn3Ig5Jl+omkynEikC0HW3zG8T1E8Rp3Q7c40ijmuvbHYdbNeGSg==
X-Received: by 2002:a17:906:c315:: with SMTP id s21mr77172192ejz.238.1564271256353;
        Sat, 27 Jul 2019 16:47:36 -0700 (PDT)
Received: from evledraar (i237193.upc-i.chello.nl. [62.195.237.193])
        by smtp.gmail.com with ESMTPSA id v8sm14573986edy.14.2019.07.27.16.47.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 27 Jul 2019 16:47:34 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/3] grep: make pcre1_tables version agnostic
References: <20190727202759.22310-1-carenas@gmail.com> <20190727202759.22310-2-carenas@gmail.com>
User-agent: Debian GNU/Linux 10 (buster); Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190727202759.22310-2-carenas@gmail.com>
Date:   Sun, 28 Jul 2019 01:47:34 +0200
Message-ID: <875znn6nvt.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Jul 27 2019, Carlo Marcelo Arenas Bel=C3=B3n wrote:

> 6d4b5747f0 ("grep: change internal *pcre* variable & function names
> to be *pcre1*", 2017-05-25), renamed most variables to be PCRE1
> specific to give space to similarly named variables for PCRE2, but
> in this case the change wasn't needed as the types were compatible
> enough (const unsigned char* vs const uint8_t*) to be shared.

Both the v1 and v2 functions return const unsigned char *. I don't know
where I got the uint8_t from. This makes more sense.

This series looks good to me. Thanks for the fix. Just one caveat:

The point of 6d4b5747f0 was not to only split out those variables we
couldn't get away with re-using. Then I would have later re-used
e.g. pcre1_jit_on & pcre2_jit_on as just pcre_jit_on. We could also do
that now.

I think doing that & this part of the your changes makes things less
readable. The two code branches we compile with ifdefs are mutually
exclusive, so having the variables be unique helps with eyeballing /
reasoning when changing the code.

> Revert that change, as 94da9193a6 ("grep: add support for PCRE v2",
> 2017-06-01) failed to create an equivalent PCRE2 version.
>
> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> ---
>  grep.c | 6 +++---
>  grep.h | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/grep.c b/grep.c
> index f7c3a5803e..cc65f7a987 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -389,14 +389,14 @@ static void compile_pcre1_regexp(struct grep_pat *p=
, const struct grep_opt *opt)
>
>  	if (opt->ignore_case) {
>  		if (has_non_ascii(p->pattern))
> -			p->pcre1_tables =3D pcre_maketables();
> +			p->pcre_tables =3D pcre_maketables();
>  		options |=3D PCRE_CASELESS;
>  	}
>  	if (is_utf8_locale() && has_non_ascii(p->pattern))
>  		options |=3D PCRE_UTF8;
>
>  	p->pcre1_regexp =3D pcre_compile(p->pattern, options, &error, &erroffse=
t,
> -				      p->pcre1_tables);
> +				      p->pcre_tables);
>  	if (!p->pcre1_regexp)
>  		compile_regexp_failed(p, error);
>
> @@ -462,7 +462,7 @@ static void free_pcre1_regexp(struct grep_pat *p)
>  	{
>  		pcre_free(p->pcre1_extra_info);
>  	}
> -	pcre_free((void *)p->pcre1_tables);
> +	pcre_free((void *)p->pcre_tables);
>  }
>  #else /* !USE_LIBPCRE1 */
>  static void compile_pcre1_regexp(struct grep_pat *p, const struct grep_o=
pt *opt)
> diff --git a/grep.h b/grep.h
> index 1875880f37..d34f66b384 100644
> --- a/grep.h
> +++ b/grep.h
> @@ -89,7 +89,7 @@ struct grep_pat {
>  	pcre *pcre1_regexp;
>  	pcre_extra *pcre1_extra_info;
>  	pcre_jit_stack *pcre1_jit_stack;
> -	const unsigned char *pcre1_tables;
> +	const unsigned char *pcre_tables;
>  	int pcre1_jit_on;
>  	pcre2_code *pcre2_pattern;
>  	pcre2_match_data *pcre2_match_data;
