Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E8271F404
	for <e@80x24.org>; Mon, 26 Feb 2018 12:18:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752925AbeBZMSB (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Feb 2018 07:18:01 -0500
Received: from mail-wm0-f44.google.com ([74.125.82.44]:36046 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752910AbeBZMR5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Feb 2018 07:17:57 -0500
Received: by mail-wm0-f44.google.com with SMTP id 188so16251473wme.1
        for <git@vger.kernel.org>; Mon, 26 Feb 2018 04:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=ua0aiKKXCH/en1PqmTyNmGjNaysyEUxpSXkRQg8nEGE=;
        b=t27DHkb5JfH9XNrx4ANPgqpzUwSFO0m38gqSunQVINAn9PjcPl6YzgTRftCbB6DFMw
         5l2e0E/u8hG1AVSsgO1w7Vxy8mTSGj8N6UOK0m0ckosin9/TLC7RRmEfWJ5HgW9NCVh5
         Eo9EQbFC/MQDXaqNLCaKXINON9SKbGCUuGl0IGwXZUbagzYFpy41vIxU5FmtGO5SAKqo
         vyynDxh23SOUF6j22dFZk44+rvNn2lptN8/xYfQRrBKbIkpQIW1gE4uIQWUi3fsuYRN2
         UEBTK9eyaKolwqt5axsnAqBL65A+dnX3J8GW/B8Eh/4xJkIqpsm0ZRVX7kYlJxcW8NFb
         4XuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=ua0aiKKXCH/en1PqmTyNmGjNaysyEUxpSXkRQg8nEGE=;
        b=ozmRXFR0yYmwhkygMa6mCcLqHSn+va4FsRFA8r93q3Fey3Q1rIlzAcgDww4IZTTeR0
         ZqzI8p+GtpSXxUNre1GGvHlojVUC5MgW6YkdBtxtptI7WRMAuPEyA2DuaAjfwkZ6pXLO
         41iG4GEnLPQpzn1qvo/WjATpXj6WUzCsEcnLJwdRb2AZs/nPL2OhAATZLG35fUkCOaG8
         XBB7q9RWDOHqF7d097zvQZe19Are81EU+kdrs8ReLIK+rg+VGcsF1HOSguW3x/nvcD0Y
         YPKGa5K+SFVmg2A8lzpsi9OoCKIn4XX8TXXKLOQnysnw5NWnge9rFouzqnu5tk3aT+AU
         pMzA==
X-Gm-Message-State: APf1xPAK/BjI/HFNI/BYKgtLzjBpgm/Z94G+D7qXJ1Jdkk6gcPAs3ggG
        X/Cf4DZTk8z5Aw9YpxLtbFc=
X-Google-Smtp-Source: AH8x224VDYv1Wt1RL6Aqo1JZZjZg18v/vT0uNe/nwCSi+kFkNSo0h6vDeZaFtal8A5NSOKIAPRvnGg==
X-Received: by 10.80.146.81 with SMTP id j17mr14058432eda.7.1519647475741;
        Mon, 26 Feb 2018 04:17:55 -0800 (PST)
Received: from evledraar ([5.57.21.48])
        by smtp.gmail.com with ESMTPSA id o63sm7243915eda.17.2018.02.26.04.17.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Feb 2018 04:17:54 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] wildmatch: use the new precompiling wildmatch()
References: <20180225203537.28318-1-avarab@gmail.com> <20180225203537.28318-3-avarab@gmail.com> <CACsJy8D09Jm5TLsXvEJHVDM+K2hCd5E-367-BQssErorynM2kQ@mail.gmail.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <CACsJy8D09Jm5TLsXvEJHVDM+K2hCd5E-367-BQssErorynM2kQ@mail.gmail.com>
Date:   Mon, 26 Feb 2018 13:17:54 +0100
Message-ID: <87po4sdjwt.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Feb 26 2018, Duy Nguyen jotted:

> On Mon, Feb 26, 2018 at 3:35 AM, Ævar Arnfjörð Bjarmason
> <avarab@gmail.com> wrote:
>> diff --git a/config.c b/config.c
>> index b0c20e6cb8..0f595de971 100644
>> --- a/config.c
>> +++ b/config.c
>> @@ -210,6 +210,7 @@ static int include_by_gitdir(const struct config_options *opts,
>>         int ret = 0, prefix;
>>         const char *git_dir;
>>         int already_tried_absolute = 0;
>> +       struct wildmatch_compiled *wildmatch_compiled = NULL;
>>
>>         if (opts->git_dir)
>>                 git_dir = opts->git_dir;
>> @@ -237,8 +238,10 @@ static int include_by_gitdir(const struct config_options *opts,
>>                         goto done;
>>         }
>>
>> -       ret = !wildmatch(pattern.buf + prefix, text.buf + prefix,
>> -                        icase ? WM_CASEFOLD : 0);
>> +       if (!wildmatch_compiled)
>> +               wildmatch_compiled = wildmatch_compile(pattern.buf + prefix,
>> +                                                      icase ? WM_CASEFOLD : 0);
>> +       ret = !wildmatch_match(wildmatch_compiled, text.buf + prefix);
>
> This is a one-shot matching.

It will match once *or* twice depending on how the goto in that codepath
does.

> Is it worth converting to the new interface?

I moved it more as a showcase, to show how the interface looks like in
common scenarios. It obviously won't be a performance bottleneck or
anything like that for this specific codepath.

>>
>>         if (!ret && !already_tried_absolute) {
>>                 /*
>> @@ -257,6 +260,7 @@ static int include_by_gitdir(const struct config_options *opts,
>>  done:
>>         strbuf_release(&pattern);
>>         strbuf_release(&text);
>> +       wildmatch_free(wildmatch_compiled);
>>         return ret;
>>  }
>>
>> diff --git a/refs.c b/refs.c
>> index 20ba82b434..c631793d1e 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -213,7 +213,7 @@ char *resolve_refdup(const char *refname, int resolve_flags,
>>
>>  /* The argument to filter_refs */
>>  struct ref_filter {
>> -       const char *pattern;
>> +       struct wildmatch_compiled *code;
>
> This actually makes me think if we should name this struct wildmatch_pattern.

Yeah, that's a better name.

>>         each_ref_fn *fn;
>>         void *cb_data;
>>  };
>> @@ -291,7 +291,7 @@ static int filter_refs(const char *refname, const struct object_id *oid,
>>  {
>>         struct ref_filter *filter = (struct ref_filter *)data;
>>
>> -       if (wildmatch(filter->pattern, refname, 0))
>> +       if (wildmatch_match(filter->code, refname))
>>                 return 0;
>>         return filter->fn(refname, oid, flags, filter->cb_data);
>>  }
>> @@ -454,12 +454,13 @@ int for_each_glob_ref_in(each_ref_fn fn, const char *pattern,
>>                 strbuf_addch(&real_pattern, '*');
>>         }
>>
>> -       filter.pattern = real_pattern.buf;
>> +       filter.code = wildmatch_compile(real_pattern.buf, 0);
>>         filter.fn = fn;
>>         filter.cb_data = cb_data;
>>         ret = for_each_ref(filter_refs, &filter);
>>
>>         strbuf_release(&real_pattern);
>> +       wildmatch_free(filter.code);
>>         return ret;
>>  }
>>
>> --
>> 2.15.1.424.g9478a66081
>>
