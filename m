Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C06BD1F461
	for <e@80x24.org>; Fri, 21 Jun 2019 08:11:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfFUILI (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jun 2019 04:11:08 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44324 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbfFUILH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jun 2019 04:11:07 -0400
Received: by mail-ed1-f65.google.com with SMTP id k8so8760135edr.11
        for <git@vger.kernel.org>; Fri, 21 Jun 2019 01:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=V7NoIusz/DOq8Z0DapTHLUXJYtlDMlKJMenTmU3kGTs=;
        b=B0y7iwL8LaaPERtNkBJXJbXdzlZWe5Ta7q31wj0xvnVXJBLlv2nPn+DJ3IpkAZnKMd
         8HT02wXMZg1c0suwpG4gJVYfAgHuC+BfZWMMAXBn9ecEWPuuXe6+ZTEEDzgt1qeF5UCk
         9jnM4X/nyqr1ZiWqg92IXjecAxMk7rbzTHrSGT4KAIEn3OWciTWgwFmlRA0VjjRNck+g
         qRDP2UZl93niZa2RgtLSwYpSaM2ivjGF0ohd/E2yAlW+sg/83OmGozkj8hBkCcS+2E1f
         gRuS8vqmrYfgIOINhrEo9o1RKTPp3+StISR4OGJ1obq/AqbgkvWPFcj5BfyiDUpNbnFx
         SY5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=V7NoIusz/DOq8Z0DapTHLUXJYtlDMlKJMenTmU3kGTs=;
        b=ckWUklPRXVh4DTlNeyAtWCSrtcewf161ouTl5OwpkI47+OzmyKCGaRlgMn/22nzL3N
         uukKtHAoek2PyI1axYx6juodOtBuOTGfX/B65sbttFrBSDOLOTYhn92rBCenoGeAvz6U
         Qc4+BBASRpszh2/pxHe7icDfk5KFwFecoDzl30IkVfw1Q4wizD6GVlBZsK52YEQiS4y7
         EJegm4P3vyD6MqOIb94J9rLZ36z3jhO0NR8TP7UZAHoQqy7BBBMa69urhRURhsS18xDr
         jZmStTSqJTximkrZq2G+ZROl7BpnxRKhkXpyinatkS/wxHG1vj8skydpTnc4JZos+zvp
         JLjw==
X-Gm-Message-State: APjAAAU6oMFCCrdKHqsqBngvEifTsSa0Xz++xYtKZFM2kfOmuFBPv9VT
        CmoKDjm2zLVjrwadvWw1Mn8=
X-Google-Smtp-Source: APXvYqyTwYnXK75cadbVkm0+iCBdlOBpIP2fQt648Dax8IGp/xWN8JtQcQHSwLD6fXC6dhtS/++dmw==
X-Received: by 2002:a50:9273:: with SMTP id j48mr118116576eda.285.1561104665854;
        Fri, 21 Jun 2019 01:11:05 -0700 (PDT)
Received: from evledraar ([5.57.21.48])
        by smtp.gmail.com with ESMTPSA id 93sm603336edk.84.2019.06.21.01.11.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 21 Jun 2019 01:11:05 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/8] env--helper: new undocumented builtin wrapping git_env_*()
References: <20190619233046.27503-1-avarab@gmail.com> <20190620210915.11297-3-avarab@gmail.com> <xmqqpnn7lxet.fsf@gitster-ct.c.googlers.com> <xmqqlfxvlwyg.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux 10 (buster); Emacs 26.1; mu4e 1.1.0
In-reply-to: <xmqqlfxvlwyg.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 21 Jun 2019 10:11:04 +0200
Message-ID: <87blyr8ijr.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jun 21 2019, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> ...
>> as I am getting
>>
>>     error: 'ret' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>>
>> from here.
>>
>> Giving an otherwise useless initial value to ret would be a
>> workaround.
>
> I've added this on top of the topic before merging to keep the
> integration going at least for now.
>
> commit 8f86948797a1152594a8dee50d0878604fec3e80
> Author: Junio C Hamano <gitster@pobox.com>
> Date:   Thu Jun 20 15:13:14 2019 -0700
>
>     SQUASH??? avoid maybe-uninitialized
>
> diff --git a/builtin/env--helper.c b/builtin/env--helper.c
> index 2bb65ecf3f..29df0567fb 100644
> --- a/builtin/env--helper.c
> +++ b/builtin/env--helper.c
> @@ -43,6 +43,9 @@ int cmd_env__helper(int argc, const char **argv, const char *prefix)
>  		usage_with_options(env__helper_usage, opts);
>
>  	switch (cmdmode) {
> +	default:
> +		BUG("wrong cmdmode");
> +		break;
>  	case ENV_HELPER_BOOL:
>  		tmp_int = strtol(env_default, (char **)&env_default, 10);
>  		if (*env_default) {

In this case the compiler is wrong, and gcc/clang in e.g. Debian
unstable doesn't warn about this since the analyzer sees that it's
impossible for "ret" to be uninitialized.

I can change it anyway, and if I rewrite the UI of this command it might
go away anyway.

Just thought I'd ask if appeasing older analyzers is what we want for
these sorts of optional warnings in general.
