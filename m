Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99B32C433DB
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 11:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51E1664E00
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 11:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbhBPLgZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 06:36:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbhBPLgJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 06:36:09 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC70C061574
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 03:35:28 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id 6so950977ois.9
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 03:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=0m8j/1KcUAWY195h05ss9NO4QCy3kvvU7i+ouLJdYOQ=;
        b=b1BD+GERpCmiX5N9IzUldhfqaBVbY4FKJK2/sOfy8JXfFG/DfH7qjDj38/WAuuuBsP
         /p5aQaqwXV5BxyTeFuot6z6DzALtXMMyTPO9Zckj/1y28DLQBGXnkZUJbYpq3LY83kvS
         1KlBBnLCQeAhRQTSNP/ysnvdhRwSBU5JolqzQFSpOGo5STDaUyP2cKPhtdfK/1aZyLlk
         HLeP2awRtHADFXqcnWFVqmja5tYr7uwOcRjHtITJ5ZwdnDrpFGlF+7esFmep4NkXKbpE
         8gUuaBwN04I7IW+Naib9ff9ERJivyeCDXJsl8YR5dxY8g6I/Qkk3LqgfRFLsrgMKfakf
         YgrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0m8j/1KcUAWY195h05ss9NO4QCy3kvvU7i+ouLJdYOQ=;
        b=jKuIGgCxRu8+6x4smcv3m8m9xa602Zr/c6hj7GCAAbht4bJgb+U+jlN/vAc7SDodeh
         F2r1TctaqvSVmplSerwkqrBrtFhSVxzCz9sBJm1xk12dk4w+uGiOoZ+e4hdcUIapKcZC
         Cc6o86g0mcz3uJwJFPXLgZyqLhB0sFZnd9lP2MsSlWMpA5MlN4VcZQMHrKtW04Gr7bnG
         hYDfe0qEH/Mvisq3Gxp5je7L0CAjC4bRpfChCUDDbMqghZxaQs466T5Na8UvvvK2CRyG
         j3rWEwNIbdzGFUhXYb2qNWimQZP1j1c0MpDLtaZJHjlBCkUiaWaXxPFdUpYfBfZpwKnb
         hzVA==
X-Gm-Message-State: AOAM532GTk3lw7xYUxQJ9/Z4zCEt8okDU4+Anl+LUt0oBKtCzbuSn540
        jWaY1rwvUS1dwkj54WfEkCuS/W5mjgdVUg==
X-Google-Smtp-Source: ABdhPJwDlOmcrpCdXxNhey/Z5LWtKpe7b4hDkHk5ZGj5lUKX8niGhJjwfi+ncvwdwqYTRwSTWXDUOw==
X-Received: by 2002:aca:4fca:: with SMTP id d193mr2285951oib.135.1613475328233;
        Tue, 16 Feb 2021 03:35:28 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:bccc:aed3:3481:8d68? ([2600:1700:e72:80a0:bccc:aed3:3481:8d68])
        by smtp.gmail.com with UTF8SMTPSA id k21sm4233121otl.27.2021.02.16.03.35.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Feb 2021 03:35:27 -0800 (PST)
Message-ID: <57d86d79-e33e-053d-3282-0b36145358fb@gmail.com>
Date:   Tue, 16 Feb 2021 06:35:26 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101
 Thunderbird/86.0
Subject: Re: [PATCH 2/5] commit-graph: remove redundant handling of -h
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        dstolee@microsoft.com,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        peff@peff.net
References: <87r1lhb6z7.fsf@evledraar.gmail.com>
 <20210215184118.11306-3-avarab@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20210215184118.11306-3-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/15/2021 1:41 PM, Ævar Arnfjörð Bjarmason wrote:
> +test_expect_success 'usage' '
> +	test_expect_code 129 git commit-graph -h 2>err &&
> +	! grep error: err
> +'

I think this test already exists in t0012-help.sh, since it
tests bogus options for all of the builtins. (I can guarantee
that I wouldn't have thought to add the check without some
instance like that.)

Thanks,
-Stolee
