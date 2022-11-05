Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0471BC4167B
	for <git@archiver.kernel.org>; Sat,  5 Nov 2022 21:32:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbiKEVcm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Nov 2022 17:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiKEVck (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Nov 2022 17:32:40 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA29C9FF5
        for <git@vger.kernel.org>; Sat,  5 Nov 2022 14:32:39 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id i5-20020a1c3b05000000b003cf47dcd316so7404397wma.4
        for <git@vger.kernel.org>; Sat, 05 Nov 2022 14:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1+u22dlpV5DhRiAFWyGMCD2qIx0R/ntapXGH25tjD3A=;
        b=Ddk9yiY9hEWh1sWqvcBXyHEGFJ5AtCJ43X7CZncpVBUlHnPQoSauM+hR8ZX4IVrkhe
         WzAGb1CQfysFDYOwv1jtG1P4zfXSCGdIe5VLY16C2Q6wc6McdtEteRPXPJAIo5FRke2W
         qJ/p0gJyTOppRmOlcXQCTLPX8/ZuHI9XU7ORbjMsRoZoMoelxiW/aE74/142EDr7PUhM
         y7im+KUvr62rcfZzRHrRwctL6Kb+pmRqFWojnoAFCaM8HHmdM891qES5WTn7EZ0+WbSW
         JCwSiD+ylhQWsw48M8+RGsjaMj65xOEMyudJq93xJ0BEEhBRZaHapK6KOgp1wsTq4kb5
         k5Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1+u22dlpV5DhRiAFWyGMCD2qIx0R/ntapXGH25tjD3A=;
        b=iIv3VugWYM/UKp15eZtgemIaCqUg6jHezBD/RXTItQLtTRAsFvPoqQHSeT3cgyX/2S
         TAKoaZHF2agaV2hDx0YnXtuy0cvfsTHW9Wvpr0SC18+5hhe/czQK3n/ZJHVZyF2f5VjG
         vWebxeQibiKBwJngYIv3vgLII2PQKKUVcmr69VBSoDc9AsNUBGR2rKXlQ5nuCLYWu7oz
         N9kxZ6q4g+ca+pWhU7eggTZaFjIowc7HmRHOZfAkVGQcB1sbaLpAYU+TgfgpLq2UHwu8
         8gXErpmOu/VU89sAlm2g9dMG9dTYvq+13HMKUJBn66FKl19bTDxiylLO8bQDgKWIjxtF
         9rpQ==
X-Gm-Message-State: ACrzQf1uhzhbTDhGU6XKj7DuVAUcYqKaEqYSfB9lVfCrqZIv9M4w5pjT
        TpxHvRCLE+2Mwf8tlpGN2Sc=
X-Google-Smtp-Source: AMsMyM59oGERgeXv+jWKAKg/RL+798nv7gMO12GmzbwuTJ5ori3/+1wEyVjgT0E0/W5PGUvSBqXD6Q==
X-Received: by 2002:a1c:7312:0:b0:3cf:6957:1639 with SMTP id d18-20020a1c7312000000b003cf69571639mr26035131wmb.108.1667683958183;
        Sat, 05 Nov 2022 14:32:38 -0700 (PDT)
Received: from [192.168.1.74] ([31.185.185.212])
        by smtp.gmail.com with ESMTPSA id a17-20020adfed11000000b00236863c02f5sm2995919wro.96.2022.11.05.14.32.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Nov 2022 14:32:37 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <43ec357b-bbd2-6b17-58f4-676a8c5e1749@dunelm.org.uk>
Date:   Sat, 5 Nov 2022 21:32:36 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 09/13] parse-options API: don't restrict OPT_SUBCOMMAND()
 to one *_fn type
Content-Language: en-US
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <1cb1c033-0525-7e62-8c09-81019bf26060@redhat.com>
 <cover-00.13-00000000000-20221104T132117Z-avarab@gmail.com>
 <patch-09.13-2cb3807aa17-20221104T132117Z-avarab@gmail.com>
 <df855ba1-52b1-1007-68e8-2e28e85b6822@web.de> <Y2ZKHPkEXViv9wcp@danh.dev>
In-Reply-To: <Y2ZKHPkEXViv9wcp@danh.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Đoàn

On 05/11/2022 11:34, Đoàn Trần Công Danh wrote:
>   
> On 2022-11-05 09:32:44+0100, René Scharfe <l.s.r@web.de> wrote:
>> Why is this trickery needed?  Above you write that callbacks in
>> builtin/bisect--helper.c can't use subcommand_fn because they need
>> their own argument.  Can we extend subcommand_fn or use a global
>> variable to pass that extra thing instead?  The latter may be ugly, but
>> at least it's valid C..
> 
> Not the author, but I fully agree with you, I think instead of adding new API
> for some arbitrary subcommand_fn, I would change the subcommand_fn to
> type:
> 
> 	int (*)(int argc, const char **argv, const char *prefix, void *context)
> 
> The last argument would be an object pointer, which will be casted to
> the correct type inside the callback.
> 
> Let me cherry-picking this series on top of mine to see how things
> would progress.

Unfortunately the current implementation of OPT_SUBCOMMAND relies on 
returning a function pointer though a void* variable which while widely 
supported is undefined behavior. I wonder if an API like

typedef int (*subcommand_fn)(int, char**, char*);
typedef int (*subcommand_ctk_fn)(int, char**, char*, void*);
struct subcommand; /* opaque */

OPT_SUBCOMMAND(name, value, func);
OPT_SUMCOMMAND_CTX(name, value, func, ctx);

int call_subcommand(struct subcommand* subcommand, int argc, char** 
argv, char* prefix);


which would be used as

int sub1_fn(int argc, char** argv, char* prefix, void* ctx)
{
	struct cmd_ctx cmd_ctx = ctx
	...
}

int sub2_fn(int argc, char** argv, char* prefix)
{
	...
}

int cmd_foo(int argc, char** argv, char* prefix)
{
	struct cmd_ctx ctx = ...
	struct subcommand cmd = { 0 };
	...
	struct option opts[] = {
		OPT_SUBCOMMAND_CTX("sub1", &cmd, sub_fn, &ctx);
		OPT_SUBCOMMAND("sub2", &cmd, sub2_fn);
	};
	argc = parse_options(argc, argv, prefix, &opts, usage, flags);
	return call_subcommand(&cmd, argc, argv, prefix);
}


would be an improvement. One can avoid having to mark the ctx parameter 
as UNUSED() if a subcommand does not need any context by using 
OPT_SUBCOMMAND() rather than OPT_SUBCOMMAND_CTX().


The implementation of call_subcommand() would look something like

struct subcommand {
         void* ctx;
         int has_ctx;
         union {
                 subcommand_fn fn;
                 subcommand_ctx_fn ctx_fn;
         };
};

int call_subcommand(struct subcommand* subcommand, int argc, char 
**argv, char* prefix)
{
         if (subcommand->has_ctx)
                 return subcommand->ctx_fn(argc, argv, prefix, 
subcommand->ctx);
         else
                 return subcommand->fn(argc, argv, prefix);
}


Best Wishes

Phillip
