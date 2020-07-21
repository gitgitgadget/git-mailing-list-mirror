Return-Path: <SRS0=GLOD=BA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B61ADC433E4
	for <git@archiver.kernel.org>; Tue, 21 Jul 2020 20:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 925CA20729
	for <git@archiver.kernel.org>; Tue, 21 Jul 2020 20:57:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NFPGkSy3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728785AbgGUU5K (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jul 2020 16:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbgGUU5J (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jul 2020 16:57:09 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D51DBC061794
        for <git@vger.kernel.org>; Tue, 21 Jul 2020 13:57:09 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id t18so202479otq.5
        for <git@vger.kernel.org>; Tue, 21 Jul 2020 13:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=29BOJy3BHvzhlLeHhHCZyzy7q7gFIIo/GWRg5vmiO4s=;
        b=NFPGkSy3yFEtfhRea7itN521cRfB7xeGFo89Hq2dBztcgWvAlZvg0vq9DUVZJXSnBl
         eEAhlnoiAty6h0A2PF4Hu3IMoLj9QH/Jy+Gq2NxKTSeOp2eO3dbeTDR3i20MvVHrft4f
         bPY0pwG0dtvmEDCbP/hFX6Evm5ktIEPGuBC0Iuf+fNQxY6QSPyT3O00CrKVdtORkKtax
         CQJXzEQTi13qZ7FbJdXQYcI1bcvGG67mbg2p0meJJZIZJYbQ6oV7JO0TpeqfdxQusFMg
         NnXpYE3LTzQNAYZcFq4rIz11ykNok3sGQziFIYeBGyvoOPTH/dKdOWBp+OZt2W/y+q6l
         DpLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=29BOJy3BHvzhlLeHhHCZyzy7q7gFIIo/GWRg5vmiO4s=;
        b=UsIoSrxSmbFG8mnpB076JGfl1JxVdfBjH6wziYqnhP/sJxXUTlJ4csixzs+al7Hm3v
         KG9vHZdcDx0WaXzo7zzv9djEb7+4ji7Bc/oVOPMAbbZ5i9rXBM3ZXa04/4z+yi/qafDZ
         8SOPT5BkLbB6pdIKvzCiR6A3lT8RMqAPGBYKNCFcrYN8L/4e1aFyIGqV8A3LuFDxiC70
         dWZj25IUUIUgTecQKcPTs5ecDu5uAI56flxNtMv58kXfESTEYVHIsADH+7ZmU3oIsFI8
         L+I1Fquw3B7ktzGsTdeL3IYLKaCrl1Rwfubpk47T+7cgJuZP+0F4OswcBNNk75U4tuk1
         xyvg==
X-Gm-Message-State: AOAM530NoVGR1x6147/btDTp9AuNnH4408C34+pB2rDl2CnxZyscRZUt
        GFS1RwB5hZYaLWAFqiz81uQu8HLioMs=
X-Google-Smtp-Source: ABdhPJzLl4w4qmdd9PLS9qBMvSQE1FsNTpqlEzjapkyFi0t1k2p6+ahq/Md0KTfRJZyEuqSEunJh/Q==
X-Received: by 2002:a9d:8e7:: with SMTP id 94mr25448959otf.205.1595365028176;
        Tue, 21 Jul 2020 13:57:08 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:59bf:3bea:a25:54b? ([2600:1700:e72:80a0:59bf:3bea:a25:54b])
        by smtp.gmail.com with ESMTPSA id n7sm5353442ooo.38.2020.07.21.13.57.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2020 13:57:07 -0700 (PDT)
Subject: Re: [PATCH] entry: check for fstat() errors after checkout
To:     Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     git <git@vger.kernel.org>
References: <fbde5e1c9042ea06b448bc759cea9d45e300961f.1594260597.git.matheus.bernardino@usp.br>
 <CAHd-oW4_A7JRmdTqCMrDU7b6-PqBSpNVD-csm3y9Bype6Vn9rA@mail.gmail.com>
 <xmqq1rl48wpt.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <3c5a8e0d-91d7-00a4-4253-ac60f3a34d05@gmail.com>
Date:   Tue, 21 Jul 2020 16:57:05 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:79.0) Gecko/20100101
 Thunderbird/79.0
MIME-Version: 1.0
In-Reply-To: <xmqq1rl48wpt.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/21/2020 4:00 PM, Junio C Hamano wrote:
> Matheus Tavares Bernardino <matheus.bernardino@usp.br> writes:
> 
>> I was looking further at this code and noticed that the conditions
>> under which we fstat() (or lstat()) an entry are slightly different
>> throughout entry.c:
>>
>> - In write_entry()'s footer, we call lstat() iff stat->refresh_cache.
>> - In write_entry()'s `write_file_entry` label, we call fstat_output()
>> when !to_tempfile.
>> - In streaming_write_entry() we call fstat_output() without checking
>> if !to_tempfile.
>> - And, finally, in fstat_output() itself, we check
>> `state->refresh_cache && !state->base_dir_len`.
>>
>> I understand we always check state->refresh_cache to avoid getting
>> stat information we won't really need later, as we are not updating
>> the index. But why do we check !to_tempfile and !state->base_dir_len?
>> Doesn't writing to a tempfile or using a checkout prefix already imply
>> !state->refresh_cache?
> 
> You can easily blame the code back to e4c72923 (write_entry(): use
> fstat() instead of lstat() when file is open, 2009-02-09).  Back
> then, only a single place assigned 0 to state.refresh_cache and that
> is in "checkout-index" with either base_dir_len or to_tempfile set.
> 
> I do not remember, and I am fairly sure Stolee does not remember
> either.  If I have to guess, this was done merely to be extra
> cautious, perhaps? As refresh_cache bit is checked first, check for
> !to_tempfile and !base_dir_len would be dead at best and redundant
> at worst.

Yeah, this portion is way outside of my expertise. I'm happy
to _try_ reading patches, but I'd have difficulty being
confident in any change in this area.

Thanks,
-Stolee

