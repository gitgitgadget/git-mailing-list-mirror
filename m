Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96541C43334
	for <git@archiver.kernel.org>; Tue, 14 Jun 2022 11:22:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242393AbiFNLWW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jun 2022 07:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233268AbiFNLWV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jun 2022 07:22:21 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285D02496B
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 04:22:20 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id w17so3324344wrg.7
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 04:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=XSicjV3POZxE/EQ11bSongR7BalOz2jM0vcd5unJLEU=;
        b=B7wXSZczoZaJ179N1M3OkQrzpzps6VkJB2K1QXErltXlOQcomVnPHAXOsG5pnDnZpD
         +qfDyqbNfgKsX8AiEzm/bVT7qr5S+RRudDvr/xqyZInZ8yakZK7phn/GtrUfpaWnIpRz
         JsY0+1xmgja5Fd4MtUbDV60V8V8/iC1qN5ZoIs60FrVMHRShdEVj52Gg/XBoW0lkVWqD
         T0AWOd1Io0ewL8ntbBxD1VKt+kH3lmy1tzAV4ETljh/qyI/qEQAmulxfZInuPCZ/dq55
         iC43LTL0e2XcU0d31qamwL2ZLYowMUFLk/OR2TcUmIINTfRwuQCFa0VYT0udBjXeDwTT
         Hyvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=XSicjV3POZxE/EQ11bSongR7BalOz2jM0vcd5unJLEU=;
        b=xzyTufYa6cMLIP0nOhDPDWSzUJeaJQZ9YQ5ZWWDWJEYo+nSJgZ9eJg9A7q55VRfUY8
         wcRBVQZr/A6BwHAXi1KOG7c+m2yezfUrDOVxtgSW9111D70JBysc581PQhWAK4EX3AgH
         YEpWE/gCzot0cgwXIBJu/keb3GO5U2zrFi1fFxt340arjGRfGjR146uQrkH+xWcezPCd
         1K88GD7lhvsTIJZUYYOgABE/zfIEmkCCVmQ/AquDhD2yScNnGC/ctkA+pglLguwr228s
         gnb5WgdF5bSJdXLOuc4zl6nZhmnwvcW77/8H6dMrC9JDsGfiQfVHCCne70X0iixUOdH5
         WJew==
X-Gm-Message-State: AJIora/C5aL6ucXIltW5j+MS/sohJpc2krDoloN9SiMZr0BaSn3hAha3
        XISVUMt7/SCO/ekN8RbUfKERMCIvXPQ=
X-Google-Smtp-Source: AGRyM1uUapJEIi5Z+8d4rTp4iXXvL75Vs6+uj7Ecu9G0fnCLlIJPu5QwfZLN0x56fpjNwceejG/FHg==
X-Received: by 2002:adf:de01:0:b0:210:3e88:6d1f with SMTP id b1-20020adfde01000000b002103e886d1fmr4421419wrm.695.1655205738662;
        Tue, 14 Jun 2022 04:22:18 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.192])
        by smtp.gmail.com with ESMTPSA id l9-20020a5d4809000000b00219e8d28fb1sm11548269wrq.57.2022.06.14.04.22.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 04:22:18 -0700 (PDT)
Message-ID: <cdf0012a-f104-87e2-104f-db1c8080cf0a@gmail.com>
Date:   Tue, 14 Jun 2022 12:22:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/4] branch: add branch_checked_out() helper
Content-Language: en-GB-large
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <pull.1254.git.1654718942.gitgitgadget@gmail.com>
 <dbb7eae390c90d4b710f48d8875bd7db0409aea3.1654718942.git.gitgitgadget@gmail.com>
 <42ada1a3-adc2-2c43-9aa1-7854858865ae@gmail.com>
In-Reply-To: <42ada1a3-adc2-2c43-9aa1-7854858865ae@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 14/06/2022 11:09, Phillip Wood wrote:
> [..]
>> +static int initialized_checked_out_branches;
>> +static struct strmap current_checked_out_branches = STRMAP_INIT;
> 
> I looks like this map is never freed which I think makes sense but makes 
> me wonder about the relevance of patch 5. I think it would probably be 
> worth marking the map with UNLEAK() in prepare_checked_out_branches().

Actually I think UNLEAK() is for marking stack variables, not globals so 
ignore that. I think patch 5 makes sense in that in keeps the leak bounded.

>> +        if (wt->head_ref)
>> +            strmap_put(&current_checked_out_branches,
>> +                   wt->head_ref,
>> +                   xstrdup(wt->path));
> 
> STRMAP_INIT sets .strdup_strings = 1, so the xstrdup() is unnecessary.

Sorry that's nonsense - it is wt->head_ref that is copied by 
strmap_put(), not wt->path, so the xstrdup() call is correct

Thanks for working on this and sorry for the confusion

Phillip
