Return-Path: <SRS0=kKTt=BD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26BDDC433E0
	for <git@archiver.kernel.org>; Fri, 24 Jul 2020 12:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 029FC20737
	for <git@archiver.kernel.org>; Fri, 24 Jul 2020 12:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HAG+NS1Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbgGXMXI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jul 2020 08:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbgGXMXI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jul 2020 08:23:08 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F8B5C0619D3
        for <git@vger.kernel.org>; Fri, 24 Jul 2020 05:23:07 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id k4so7855357oik.2
        for <git@vger.kernel.org>; Fri, 24 Jul 2020 05:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oRXbU115w0JMC/mQMXQwOmsJpvQwe2Gy8InWqDO1+Ew=;
        b=HAG+NS1QvnduJojZPKl8mBEXBdiCuOspPPbxN+TE4YgaX8s/WIyFtmdB9Be5WCvVWc
         cS8wfjajTbw+I/Poe31OoD0r2t5b11EFrRYnLEkcF7gc2dQRwap8NESUuiudMRGmerWd
         dKLw2FjPOL2/Ljo9WrQrDHZu3/sNfz5/cS6GpkCZIhMm5osfKqqU7r3tzxh/ze6f65MS
         9kJq1RtnP88i2ubPFg8LcuKx8R2bDMP6umRGMAlMebtbBNpo1pl3La2nHxxlRY/6SHUp
         5JX9ULc88S3ZK820DsAKeHWc0kuJ45PiYYJBy3nwz5e2ic4mGSr/VGJRsB6/2k6FlBs2
         +zpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oRXbU115w0JMC/mQMXQwOmsJpvQwe2Gy8InWqDO1+Ew=;
        b=SNntMTYHTY90YAfV3GXL7wI1kO4vcH2stpI/J8+rTBngHVNgzPkyLkxIhj3ek5dqJk
         ZZ2R464XvdcUv86kyexOm8GgomsGrFb+CcrToKYhsyDDE68AvfteKal1rHCn9O1njalS
         iRTDKMnNZHV5QCotflYiYXKAeZwbHJeAY3dF4Ln0CXTEA6sPV5qALJadKZBYr603hGhG
         mf23xcF+OIeE0LhOSc27DU+YYck4uWrqj4GvlOfLR9nfJF1c1hs8z1YG9/Hx/VQmS5Kh
         VM19p6lqsK9vPXoGPXxqTKo4yB1YWEblZbCiDHK0PEFlYvG5dIsNs078he8ZvNvCGGaf
         +Glg==
X-Gm-Message-State: AOAM5319STF4w6/b+zyvJZfgiYGp2M2Isb/LPVb50NN8KW+wdsUbIRPg
        8G3kez0t5c8CtGViiK0Y+Cs=
X-Google-Smtp-Source: ABdhPJyUL8rkWUNpkt4SioXpKU3z2Ix5lriXufwKc+z0s2MUGYxMiYQhX0LbdlLxr4GPBtfc3VDUew==
X-Received: by 2002:aca:b884:: with SMTP id i126mr7755481oif.65.1595593386696;
        Fri, 24 Jul 2020 05:23:06 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:44af:70e9:4b5b:8d7f? ([2600:1700:e72:80a0:44af:70e9:4b5b:8d7f])
        by smtp.gmail.com with ESMTPSA id r1sm114710oij.44.2020.07.24.05.23.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2020 05:23:05 -0700 (PDT)
Subject: Re: [PATCH v2 04/18] maintenance: initialize task array
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        sandals@crustytoothpaste.net, steadmon@google.com,
        jrnieder@gmail.com, peff@peff.net, congdanhqx@gmail.com,
        phillip.wood123@gmail.com, emilyshaffer@google.com,
        sluongng@gmail.com, jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.671.git.1594131695.gitgitgadget@gmail.com>
 <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
 <8e260bccf1a0b6cd799a6bc78798b31ebed8ad7e.1595527000.git.gitgitgadget@gmail.com>
 <xmqqr1t2qa1n.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <1501583a-0fb0-ad88-bd2f-4f64c3c66980@gmail.com>
Date:   Fri, 24 Jul 2020 08:23:03 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:79.0) Gecko/20100101
 Thunderbird/79.0
MIME-Version: 1.0
In-Reply-To: <xmqqr1t2qa1n.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/23/2020 3:57 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> +static void initialize_tasks(void)
>> +{
>> +	int i;
>> +	num_tasks = 0;
>> +
>> +	for (i = 0; i < MAX_NUM_TASKS; i++)
>> +		tasks[i] = xcalloc(1, sizeof(struct maintenance_task));
>> +
>> +	tasks[num_tasks]->name = "gc";
>> +	tasks[num_tasks]->fn = maintenance_task_gc;
>> +	tasks[num_tasks]->enabled = 1;
>> +	num_tasks++;
> 
> Are we going to have 47 different tasks initialized by code like
> this in the future?  I would have expected that you'd have a table
> of tasks that serves as the blueprint copy and copy it to the table
> to be used if there is some need to mutate the table-to-be-used.

Making it a table will likely make it easier to read. I hadn't
thought of it.

At the start, I thought that the diff would look awful as we add
members to the struct. However, the members that are not specified
are set to zero, so I should be able to craft this into something
not too terrible.

Thanks,
-Stolee
