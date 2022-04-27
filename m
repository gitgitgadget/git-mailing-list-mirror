Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 063EDC433EF
	for <git@archiver.kernel.org>; Wed, 27 Apr 2022 17:28:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244004AbiD0RbU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Apr 2022 13:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243967AbiD0RbS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Apr 2022 13:31:18 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4267DE30
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 10:28:06 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id l62-20020a1c2541000000b0038e4570af2fso1613917wml.5
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 10:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3rFFpBVpV1KvX9FJwP5ApIogILTjspl+4Ipps2OT0Lw=;
        b=Fq9Wyrsi6vT67Q1kdlB2hceVhv72PIdJC9nRu9AETtEc8vV0Mnf6aXBAurnU2/xH/g
         BLCMl8y5PlFU3TAX6PPfnGkEpSso3sGgczj+4/BHdLfdnf5aoyuSVD2d4EHcM3hG1Cme
         4bq8mzTnId4Gja/AyCAxPz848CTHRBi6CsLukI2OmiCH0ZwuWmSXCM7E44Zq1TBeyKwu
         F7Vqxm0C03771vUKfoezxZxzvs6nBq9KqbefGbMVjKTSox/noc58Nafod56ApWEhVwRu
         byVN5YYnKuJdDk9B9Y4Jriel0ZHGcET2HYCGfFzI7wR84aerhVqlpjTFvrjWy6MyWqBz
         9W9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3rFFpBVpV1KvX9FJwP5ApIogILTjspl+4Ipps2OT0Lw=;
        b=bqov8ZV+nqwHjUM+SWidJssZx6CJgReI4BuJA9vI5BEf/r5MFOEEFH8onjuqZg6cCQ
         n0F2xl0/bD/CxVW1ir7irvFbqE0KDPqbJSTGt7lZEFszY8YVn5bxyHrkjT0Pef2gm0fN
         RsqQwSi9s5oHzuOecwVGQyHFHlXOJ87vwneKZHT/Y4DoNRs54HerJbNMuEWEy/cEnV8K
         5HibheSLzmsiIu6WeJMx5ALNz95d9xZDHEVrhDkrCtbnoESvvTCrGmMa5+KVuAYNbU7I
         1zWv3NTUiqPjCjHWk87busuDlyQ9kiFBXI9DoSj5nLNxL/noESmTh6SL57JPRlCWk7a2
         xQPQ==
X-Gm-Message-State: AOAM530EWAGob5MCp7PtGDuNJLEpNM1kZx+wk9YWy9uU4rBPfArWfvPP
        aC4rpl4Vbp+631oCc/vstUA=
X-Google-Smtp-Source: ABdhPJyKvlPdm8wbWLLtFYMo8Of7/BY4lMZ6A3GhEAtoz4/S8HfAgZ3pEzF1/UzCGgQz9/EVm6KLhw==
X-Received: by 2002:a05:600c:a0b:b0:389:dd65:66f1 with SMTP id z11-20020a05600c0a0b00b00389dd6566f1mr26466312wmp.95.1651080484952;
        Wed, 27 Apr 2022 10:28:04 -0700 (PDT)
Received: from [192.168.1.201] ([31.185.185.192])
        by smtp.googlemail.com with ESMTPSA id t18-20020a05600c199200b0039291537cfesm2041169wmq.21.2022.04.27.10.28.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 10:28:04 -0700 (PDT)
Message-ID: <6c3b447d-9419-982d-678c-6a6c0ff8cbc2@gmail.com>
Date:   Wed, 27 Apr 2022 18:28:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] git-compat-util: avoid failing dir ownership checks if
 running privileged
Content-Language: en-US
To:     Carlo Arenas <carenas@gmail.com>, phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, philipoakley@iee.email, me@ttaylorr.com,
        guy.j@maurel.de, szeder.dev@gmail.com, johannes.Schindelin@gmx.de,
        gitster@pobox.com, derrickstolee@github.com,
        Randall Becker <rsbecker@nexbridge.com>
References: <20220426183105.99779-1-carenas@gmail.com>
 <20220427000522.15637-1-carenas@gmail.com>
 <6522673b-494a-951c-be5e-3ca01577c12b@gmail.com>
 <CAPUEsphEymVE1HHeDZE+Fh50fr7DJSpM_YFNC-v=m9hFhgz-UA@mail.gmail.com>
 <57217c15-c6d1-32f1-a481-0003ba66e342@gmail.com>
 <CAPUEsphumEJ=qBM9c9WLJ6fzL=mcK2+3fUViyHEvttaD-DsOgg@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <CAPUEsphumEJ=qBM9c9WLJ6fzL=mcK2+3fUViyHEvttaD-DsOgg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27/04/2022 17:54, Carlo Arenas wrote:
> On Wed, Apr 27, 2022 at 9:31 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>> On 27/04/2022 16:38, Carlo Arenas wrote:
>>> FWIW, I still think that using atoi with a check to skip "" is
>>> probably as safe as doing all this extra checking as no one has shown
>>> yet a system where sizeof(uid_t) > sizeof(uint32_t), but agree with
>>> Junio that using long instead avoids issues with the systems where
>>> sizeof(uid_t) > sizeof(int) and unless sizeof(int) == sizeof(long)
>>> (ex: 32-bit Linux) which is then covered by the cast.
>>
>> if sizeof(uid_t) < sizeof(long) then the cast will truncate the value
>> returned by strtol() which means we are trusting that SUDO_UID is a
>> valid uid otherwise it will be truncated.
> 
> correct, this whole procedure relies on the fact that SUDO_UID is not
> a bogus value (ex: it was produced by a non buggy sudo and hasn't been
> tampered with)
> 
> in systems where sizeof(uid_t) < sizeof(long), it is expected that the
> id we got should be able to fit in an uid_t so no truncation will ever
> happen.
> 
> the only thing that worries me is sign extension but that is why I put
> a specific cast.  for all practical reasons I expect uid_t to be
> uint32_t and therefore using long should be better than using int
> (through atoi)


If we think uid_t is a uint32_t then should we be using strtoul() to 
make sure we cover the whole uid range where sizeof(long) == 
sizeof(uint32_t)?

Best Wishes

Phillip

> Carlo

