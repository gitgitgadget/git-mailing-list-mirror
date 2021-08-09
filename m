Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B34A6C4338F
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 08:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9226C60E93
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 08:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233714AbhHIIC6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Aug 2021 04:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233754AbhHIIC4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Aug 2021 04:02:56 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE0EC0613CF
        for <git@vger.kernel.org>; Mon,  9 Aug 2021 01:02:33 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d1so15520065pll.1
        for <git@vger.kernel.org>; Mon, 09 Aug 2021 01:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=references:user-agent:from:to:cc:subject:in-reply-to:message-id
         :date:mime-version;
        bh=xazWhi7FyGEvFHDN9RsyylHXq4sjf3s7BjDW6as52Pw=;
        b=MlMmIAxFXEJPvX6p0JlVZ8MxcMIxMTdQxb9OXZSD2KsYkMPCUfIkTNg+Ot+a/Dlodz
         /LWpRR+sQm4JV+tKllTYbzdZMq7vm34MjLl/J0cXTOemjg2Tipgw8fG0CQPPz80oWZjA
         e6GijKyNmo/misJ2IlicIp6guryRQzybHRZGz3sp9Wtjz+gxpWzvA/LCkYrcQUO9og67
         u1pOEyboE2J1KsllkclaZhNUM59vHyXqsfIMHClaJSHjyK5+kmD83XyrNVhU0eR7rDJ/
         Gb/cw+mHE3bAwCPQgUkrFALEu6u40rcPhPxKSK26zNe9fH4GRFcKL3WUmqBopVNqTsEs
         nukw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:message-id:date:mime-version;
        bh=xazWhi7FyGEvFHDN9RsyylHXq4sjf3s7BjDW6as52Pw=;
        b=FtkpC74gN6lARZ4iIs7fzwimWFc3FXF0/W6+1SULzvFIbUgj6nUVrJdFExAeGIW1tZ
         p7k2Lea30U0Np1E09GkVNUvNWkrfZ9jKUWc/nCQr2PKe0Fnf2fe6lG2rxJAp8QwVJLas
         LH0J0ZhEHR7J1Ho8egyZxdKwfUKE4CMxgh+pqG12ZHPn6iIIej4AUNrZjLZ3IFTjWjw2
         LQKOPJakClBLzt4vGlg9tfgzWs3uyY2HC4GxkTqmJPKi+G3jPU4fYC+yttvze5fZ8nBP
         IN10aYA+FHqLX7FtKrJKadVn54Xg/uNJrGBXCo+up0fZrPObEXKJS4xfzoiww8Fc/YPI
         6IFw==
X-Gm-Message-State: AOAM530dRvVkRP4W3CfcuhBNbnOjm1oNhxgMKK3jkA4LwaZiKj2YGfDd
        8uypHnfwuT9QpcH1ORSKR6w=
X-Google-Smtp-Source: ABdhPJw5RaiUN9Qj84YYFAOvocUOJxaEHhWKXBCdGrkzTx85jdtlJzLWJMTzbJNorSYBo9YuUH8hhw==
X-Received: by 2002:a17:90b:1c8c:: with SMTP id oo12mr6023967pjb.170.1628496153362;
        Mon, 09 Aug 2021 01:02:33 -0700 (PDT)
Received: from atharva-on-air ([119.82.121.47])
        by smtp.gmail.com with ESMTPSA id y13sm20730816pjn.34.2021.08.09.01.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 01:02:33 -0700 (PDT)
References: <20210806120147.73349-1-raykar.ath@gmail.com>
 <20210807071613.99610-1-raykar.ath@gmail.com>
 <20210807071613.99610-5-raykar.ath@gmail.com>
 <1b731c17-7284-746d-331b-d0edd5823318@gmail.com>
User-agent: mu4e 1.4.15; emacs 27.2
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     avarab@gmail.com, christian.couder@gmail.com, congdanhqx@gmail.com,
        emilyshaffer@google.com, git@vger.kernel.org, gitster@pobox.com,
        jrnieder@gmail.com, pc44800@gmail.com, periperidip@gmail.com,
        rafaeloliveira.cs@gmail.com, sunshine@sunshineco.com
Subject: Re: [GSoC] [PATCH v4 4/8] dir: libify and export helper functions
 from clone.c
In-reply-to: <1b731c17-7284-746d-331b-d0edd5823318@gmail.com>
Message-ID: <m21r73avvx.fsf@gmail.com>
Date:   Mon, 09 Aug 2021 13:32:26 +0530
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:

> On 07/08/21 12:46 pm, Atharva Raykar wrote:
>>> [ ... ]
>>
>> diff --git a/dir.h b/dir.h
>> index b3e1a54a97..a4a6fd7371 100644
>> --- a/dir.h
>> +++ b/dir.h
>> @@ -453,6 +453,16 @@ static inline int is_dot_or_dotdot(const char *name)
>>     int is_empty_dir(const char *dir);
>>   +/*
>> + * Retrieve the "humanish" basename of the given Git URL.
>> + *
>> + * For example:
>> + * 	/path/to/repo.git => "repo"
>> + * 	host.xz.foo/.git => "foo"
>> + */
>
> Are you sure about the examples here? I just tried and ...
>
>   - '/path/to/repo.git' gave me 'repo' like you said
>
> .. but ..
>
>   - 'host.xz.foo/.git' gives me 'host.xz.foo' instead of 'foo'.
>     I think you meant to have 'host.xz/foo.git' in the example.

Yikes! I meant 'host.xz:foo/.git'. That should give us 'foo'. Thanks for
the correction.

> Also, here's another example that might be useful to mention in the docstring:
>
>   - 'http://example.com/user/bar.baz' => 'bar.baz'

Yeah, especially since that's probably the most familiar example for
most end users.

>> +char *git_url_basename(const char *repo, int is_bundle, int is_bare);
>> +void strip_dir_trailing_slashes(char *dir);
>> +
>>   void setup_standard_excludes(struct dir_struct *dir);
>>     char *get_sparse_checkout_filename(void);
>>
