Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB81C6379F
	for <git@archiver.kernel.org>; Wed, 22 Feb 2023 10:18:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbjBVKSe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Feb 2023 05:18:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjBVKSc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2023 05:18:32 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711E220D38
        for <git@vger.kernel.org>; Wed, 22 Feb 2023 02:18:31 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id v3so7097885wrp.2
        for <git@vger.kernel.org>; Wed, 22 Feb 2023 02:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YNqmkb0xPTnBWvJe0DxTEqb+tN0lgdCoMr4YTXyOl3k=;
        b=bCGHhYApAY8TwBKp4bmfyafxGgH1G5+Rw65lkQ3TCd+/vZFDyanGeQ0BHdkA18S3s/
         xBf2Ee3yT600Evp+Fl4VbM9Sa8MfvaKgj2bpwI7Rq+xC7k+XzlApWY5suRdKwYBgJS+P
         LAMmaeQ9KfSMcWlybPZ6HBXRnCjrRmqlnF69Fl2GtEBW2Pzl2STKO4xXylKOEMrlpDgd
         U81uGGj2voBANc1/oXpqkcIr5y++T2NZgdnXrvyBDuwNSiERP1eEC6zxZWIuNL8VrO7L
         Qtb1RBZujJQcR56y1b7t5ts7uzMRUp5o2h9Ihb9sHRAvURwmLVJFSYiaCZ16epIaVZrx
         KhHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YNqmkb0xPTnBWvJe0DxTEqb+tN0lgdCoMr4YTXyOl3k=;
        b=3toydJWotVu1MCI54ajcSxo7HnmycRyfngdamGwIcWuXVilvSE44YShe8YmyUzsLi/
         emG8PCZUAGiMuWClDGoCKzNrlByaIs5ApbkGtsQl5+N1SKEZG7Rcmvs1K0cdI1UnwLxe
         ZWIC5SdkU/vsPZ4G7WyWaushaw4czJkDEJ/Zz5wO22ff/+/K787wV1nGdKwkVB/6XvYl
         OrHaYHmOjSqSaKrOKll3JZhkLsZdK7vDcyz5pX1D71v/TbAY1EiqEtXcPOw0Xtjcz7VG
         jTtDYDInMEcYinw7vsye0BkG7H1b3j++FVZJVwnSKoow9LIulTpyZpFFprOBWad1qfQY
         SOmg==
X-Gm-Message-State: AO0yUKX8K6jhGLmDVYxuZYNXGMtPNBt1EnpE6D2j0dCG5jGzxyznMEo0
        ElUfZywWWbK/zoaj0WEDw10=
X-Google-Smtp-Source: AK7set/bz/fyrOnPTBF0oui+KOA3euSZqakvc3jEmIUGCJt3DKqb2p/vrTsnC/a7lYU43aKBv8befQ==
X-Received: by 2002:a5d:4cc8:0:b0:2c5:557b:f837 with SMTP id c8-20020a5d4cc8000000b002c5557bf837mr6282083wrt.14.1677061109969;
        Wed, 22 Feb 2023 02:18:29 -0800 (PST)
Received: from [192.168.1.212] ([90.248.183.175])
        by smtp.gmail.com with ESMTPSA id t13-20020a05600001cd00b002c6d0462163sm5673446wrx.100.2023.02.22.02.18.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Feb 2023 02:18:29 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <f0d0a3fb-d7eb-84d6-7852-0d30eb38af63@dunelm.org.uk>
Date:   Wed, 22 Feb 2023 10:18:28 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 3/4] rebase: stop accepting --rebase-merges=""
Content-Language: en-US
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     git@vger.kernel.org, tao@klerks.biz, gitster@pobox.com,
        newren@gmail.com, phillip.wood123@gmail.com,
        Johannes.Schindelin@gmx.de
References: <20230221055805.210951-1-alexhenrie24@gmail.com>
 <20230221055805.210951-3-alexhenrie24@gmail.com>
 <852c6efd-49a7-f6f0-dd6a-b28cb0909784@dunelm.org.uk>
 <CAMMLpeQ9gEKNX5VtGCgLL_Qzk59ZYji57u-SPy-XeSRPuF2NwA@mail.gmail.com>
In-Reply-To: <CAMMLpeQ9gEKNX5VtGCgLL_Qzk59ZYji57u-SPy-XeSRPuF2NwA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alex

On 22/02/2023 01:38, Alex Henrie wrote:
> On Tue, Feb 21, 2023 at 3:55 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>>
>> On 21/02/2023 05:58, Alex Henrie wrote:
>>> The unusual syntax --rebase-merges="" (that is, --rebase-merges with an
>>> empty string argument) has been an undocumented synonym of
>>> --rebase-merges=no-rebase-cousins. Stop accepting that syntax to avoid
>>> confusion when a rebase.merges config option is introduced, where
>>> rebase.merges="" will be equivalent to not passing --rebase-merges.
>>
>> I think this is sensible in the context of adding a config option. It is
>> a backwards incompatible change though, lets hope no one was relying on
>> it.
> 
> Since the syntax is bizarre and undocumented, I doubt anyone is
> relying on it for anything serious, if anyone uses it at all.
> 
>> Is there a particular reason you decided to redo the option parsing
>> rather than just calling parse_merges_value() from the existing "if
>> (rebase_merges)" block? I don't think it really matters, I'm just curious.
> 
> Without a parse_opt_merges callback, how could we know whether the
> user passed --no-rebase-merges as opposed to passing nothing at all?
> const char *rebase_merges would be NULL in either case. It's an
> important distinction to make because --no-rebase-merges overrides
> rebase.merges but the absence of a command-line argument does not.

The usual way we handle that is to set the value of rebase_merges from 
the config before calling parse_options(). However your solution is fine.

> All the same, your comment made me realize that it would probably make
> more sense to simply change the default value of --rebase-cousins from
> "" to "no-rebase-cousins" in this patch and then add the
> parse_opt_merges callback in the next patch when it is actually
> needed.

Sounds good

Phillip

> -Alex
