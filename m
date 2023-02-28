Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 069A0C64ED6
	for <git@archiver.kernel.org>; Tue, 28 Feb 2023 00:24:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjB1AYD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Feb 2023 19:24:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjB1AX7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2023 19:23:59 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FA520570
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 16:23:57 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id r18so8050105wrx.1
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 16:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677543836;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CjxWvCsik/JAZeyvca5SeJpzarjz+4fKMi53kRir1ys=;
        b=iKzi6QUGx1OqH9076oRbqZdzPpwapTUpUbtRnkRSf1VuwlenSEtvaW6u9y0hIhK4Eh
         Oz6SDxg1r59kAyhxPZjN5FruD1BsKUqj2tFTxkt5H18GAVQzzKd1koEYcvxFwlh6jvd/
         Qv7c+Z0DkgjBJOcwUDPSmisGkoxGRqoNsOwLGYFLD1qLZsaDb99XEsXUA5PoLV5KpCNU
         xC00hfyoyjJsYeky38Aa72rQXE//Hi+rhjdr+a8XvHvoqthJbEiyD1qROyLbn6u6G1W7
         4nMOw5gcp/N/lQmUZAlWtbMlSLhKdk8AHSgwnfiZtQOwCIGdYmfv3fX7sZrLeTbAcXrd
         5Yxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677543836;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CjxWvCsik/JAZeyvca5SeJpzarjz+4fKMi53kRir1ys=;
        b=bgNQhXaLaft5wCtExZfhP8BcccfoyKM/72FqKgmiCPF7n0RiaSWRkuRX2JJyXS3syw
         JlrvCC1Q7KjhDuIRiEMJHGrRdKhAECOhzFEwF1MUfhu9/GT3yse70QzIUbrKq/FH2ShO
         d0eItHfK4YVzpn2dSlVLqceIBBHpHJuRjchO1xSKNBd2X7DLpCr6m7LLDIUyQUnxoiuP
         Kr73Lo0yIKTndeoohR4I84MkY0EFumG6tqhg9JvD4rCBvPaepQMmP3uStXZiRjKiw8Fe
         ixMaHlucFhm+oH3c8xbhLMcn4v1fn/GlkXMre0nkDfCOr70TwQz2e/zXO/7TBqrYunVS
         p9bw==
X-Gm-Message-State: AO0yUKV0vHOGh8LnxYM4rFUCs8HyIazaF4Xcowpkp333BC1JnUu18abE
        7oml/CDOLjriJk9jxVvdn65ft4adp3M=
X-Google-Smtp-Source: AK7set9skreSHa+G0DMmWyaNxmAcxk5ak9PZL0ngo51kiKuoVTviWcDD4CqCJQ8H2WhkZ32WnwdZZg==
X-Received: by 2002:a5d:6542:0:b0:2c7:434e:9a5a with SMTP id z2-20020a5d6542000000b002c7434e9a5amr665328wrv.65.1677543836330;
        Mon, 27 Feb 2023 16:23:56 -0800 (PST)
Received: from [192.168.2.52] (59.red-88-14-203.dynamicip.rima-tde.net. [88.14.203.59])
        by smtp.gmail.com with ESMTPSA id k22-20020a7bc416000000b003dc521f336esm10305671wmi.14.2023.02.27.16.23.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 16:23:56 -0800 (PST)
Subject: Re: [PATCH v4 3/3] branch: rename orphan branches in any worktree
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <20230227194116.2417165-1-jonathantanmy@google.com>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Message-ID: <fc3a5058-134a-3fcc-a59a-cd072f2d0258@gmail.com>
Date:   Tue, 28 Feb 2023 01:23:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20230227194116.2417165-1-jonathantanmy@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27/2/23 20:41, Jonathan Tan wrote:
> Rubén Justo <rjusto@gmail.com> writes:
>> @@ -583,7 +587,7 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
>>  				interpreted_oldname);
>>  	}
>>  
>> -	if (!copy) {
>> +	if (!copy && (oldref_usage & IS_HEAD)) {
>>  		/*
>>  		 * Update all per-worktree HEADs pointing at the old ref to
>>  		 * point the new ref.
> 
> What is the relevance of this change?
> 

Maybe this change makes more sense in 2/3?
