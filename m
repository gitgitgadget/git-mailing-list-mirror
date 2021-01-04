Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FCBCC433E0
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 11:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F92B207BC
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 11:09:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbhADLJW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Jan 2021 06:09:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbhADLJW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jan 2021 06:09:22 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB4BC061574
        for <git@vger.kernel.org>; Mon,  4 Jan 2021 03:08:41 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id h19so18143171qtq.13
        for <git@vger.kernel.org>; Mon, 04 Jan 2021 03:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=C0G8biyjhopjaDmv+jppCuhzXgzGkJ9FgyQ7e7NH2WI=;
        b=IRnR6bl3A0RlkSDI90+Omz3QdR5IiApZI9dS5wlp//oHbub/Ubh35KkWltUaupkzaa
         AjwvHFJylzd0pwG9tqmgFAX8NkuEQy651cH9CYMPSXRVl/j9kvfBXfndKNZGek+EgkVO
         5srxiM/juasuaC7zKRIWUzK4oDAOdxUbHVl/6OGdA6rD2gd2eS1lnDGsPQRKu4P/xHy3
         r5y6wtNHnHQNy+FIMeBEmLT1i5U6nVV9ycthVa1d6O8AeyA2oJ4BNmVUy2gSM/IhGuKJ
         fDmWTQlUjmzKKVXcwMOaV8i0sBehWDslZ6QDJAggPvPivWBHANAdoFu5lprme79tQ9fe
         m8fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=C0G8biyjhopjaDmv+jppCuhzXgzGkJ9FgyQ7e7NH2WI=;
        b=FI5J11J1ZfSqjWc5+SHQaMMDmgoR9/kL5lUM/Q/HBczNaWTQjB/owBwqJw5Dr7hgMH
         6kACB5iaJEChEerSbPs+vPJFniy0ub8yaPBPfo4BVcvqqoGgUWR/O0swedmSxSRoXsY2
         qaWLdX7mmVTHqz63Ds74KkM4AJIKh0vFvrMo+VXFGnMwVNilwXrxwyHre0VcNa0i5VkE
         JsWVMpUib4/tJj9WAV/GRDAJoV+8ba1hjq0ijoqeHCIhElqeIC5zcJ/1hkJK5JHk9Jf3
         lIi4LsokF/pQ0ns1c49wnVkB9ILqrWEXUx0LMtklXXvSaeBbed0Rj/f0QVcbbP0rQAM2
         Aieg==
X-Gm-Message-State: AOAM531tcm/PEUDXP8tcSCWC6LWBHKB2Oxz6AbB39NYn0q31SBA30xVe
        6B/ryWz2xwhRZWDxPx/Ik9wDxoZvN1M=
X-Google-Smtp-Source: ABdhPJyTK6cPrlS0ZPVuY07U5CV9B12GebDHboiOdZq3KoqhGRp3Dn+C10oFhI6Ie37TZHfMGNCWHQ==
X-Received: by 2002:ac8:5bcf:: with SMTP id b15mr70538854qtb.35.1609758520826;
        Mon, 04 Jan 2021 03:08:40 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id o4sm35395636qta.26.2021.01.04.03.08.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jan 2021 03:08:40 -0800 (PST)
Subject: Re: [PATCH 01/12] merge-index: drop index compatibility macros
To:     Alban Gruin <alban.gruin@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     pclouds@gmail.com, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.830.git.1609506428.gitgitgadget@gmail.com>
 <68d88b651c74659eb171e88d701b89d11e7f5f24.1609506428.git.gitgitgadget@gmail.com>
 <f3d0ef14-c753-c107-4693-67cec504964a@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <961af585-1b2a-e4e8-d60f-9becbc75b98c@gmail.com>
Date:   Mon, 4 Jan 2021 06:08:40 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <f3d0ef14-c753-c107-4693-67cec504964a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/3/2021 6:31 PM, Alban Gruin wrote:
> Hi Derrick,
> 
> Le 01/01/2021 à 14:06, Derrick Stolee via GitGitGadget a écrit :
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> Replace uses of the old macros for the_index and instead pass around a
>> 'struct index_state' pointer. This allows dropping the compatibility
>> flag.
>>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> 
> I already libified builtin/merge-index.c in ag/merge-strategies-in-c,
> and such dropped the_index.  I modified merge_entry(), merge_one_path()
> and merge_all() to take a callback, itself taking a repository.  As
> such, in my series, these functions take a `struct repository *' instead
> of an index state.
> 
> I'm not sure how we should proceed with our respective patches.

Hi Alban,

Sorry I didn't realize that. I'll drop this patch. Thanks for letting
me know!

Thanks,
-Stolee
