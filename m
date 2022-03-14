Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDCABC433F5
	for <git@archiver.kernel.org>; Mon, 14 Mar 2022 15:13:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241592AbiCNPOf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Mar 2022 11:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240968AbiCNPOc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Mar 2022 11:14:32 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00EFD55AE
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 08:13:19 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id x8-20020a9d6288000000b005b22c373759so11970944otk.8
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 08:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=7MWyVxee3DoHNplKDyQ8UC7cJZaaj2iVXux9JLrnSIE=;
        b=KF3YK1FT+4mcItye/brMeo5Wz3h18HUk/xcq+SSPVhXgtk0FRESQgrRLkpfskRhvwn
         l9wWpu0WWJOwrDJ7HmgPKXwm7W057CSBquCyyMHwrEVEPz/Q8b9L3mQ81t0CJcAm7Xgw
         LLs0LzwJbdAqb8NS2KDMbKDI0jM5sToH0TP2iEUgTBJyFgcPRZ/0UogM7R+srsuSvtEL
         8unamckoX0yniKC4sx7raGShH3JONE54EfYVxHcggMhN/W6SMBjgqeSmIPkgq0p7sbPM
         i9Cg321FH+QjiOrxLCMJfS2YzHwA0oAwMvE6cx5e7DxW/eWiJxNC5f+bX2iIXwLzmesS
         Dgtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=7MWyVxee3DoHNplKDyQ8UC7cJZaaj2iVXux9JLrnSIE=;
        b=i8+mNcB0n5mSMvYhEQUfa/RTtueVK/mrR4hxPAfI1g6dEYjpIhDifMARV8YjgfQNh4
         kc3cNk2BIBEQJKtlePYtxJiLOz/DikRUUTnDvflIedGCtpKTQQQ7nvVy2mkC8NfWX5V1
         ArFtESMiScnUwNOtaVFGJRKVa3AwHKzhoBn2IcHGsNLRMuj+ur5Pt6/3BkkoN+AL9YRU
         d4u9zpvMHpp3e5+t8TL1kcDi6/SOLuFnyeRRwqQRti1ePKCsE6vSJH6fT46ieYu1dZqf
         P3OTqcOPSgWhYZzE3WFJccLpXha4jThFfxzpI5rUnw4hdW+0hl5sWr6z8xospqSzgtLY
         dlkQ==
X-Gm-Message-State: AOAM532BrMEuxcX0yc+d3/CVMvjnEk4QtCK4E7Wb4I1bYC4Knmux56yn
        EmmGMLwv6mX0SrPpIUtO442h
X-Google-Smtp-Source: ABdhPJxnI16wZzyC6R2fqJ2yKDcHVOnhPqrEe2LVjplR0KPwvBI0nQD+KpI00D4rUIOI1Kq/eunGTw==
X-Received: by 2002:a05:6830:2419:b0:5ad:1086:4397 with SMTP id j25-20020a056830241900b005ad10864397mr11327582ots.337.1647270798658;
        Mon, 14 Mar 2022 08:13:18 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id q40-20020a056830442800b005c9274907a0sm5959677otv.10.2022.03.14.08.13.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Mar 2022 08:13:18 -0700 (PDT)
Message-ID: <b9ba7ad3-c361-abcd-4735-b011d502dcad@github.com>
Date:   Mon, 14 Mar 2022 11:13:17 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 2/5] reset: introduce --[no-]refresh option to --mixed
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Victoria Dye <vdye@github.com>
References: <pull.1170.git.1647043729.gitgitgadget@gmail.com>
 <bda93703013e3576101079d6aa4b821ae4c73fb7.1647043729.git.gitgitgadget@gmail.com>
 <fac1f57c-1bb8-2458-91ce-db5cb55f2e7d@github.com>
In-Reply-To: <fac1f57c-1bb8-2458-91ce-db5cb55f2e7d@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/14/2022 11:05 AM, Derrick Stolee wrote:
> On 3/11/2022 7:08 PM, Victoria Dye via GitGitGadget wrote:
>> From: Victoria Dye <vdye@github.com>

>> +test_index_refreshed () {
>> +
>> +	# To test whether the index is refresh, create a scenario where a
>> +	# command will fail if the index is *not* refreshed:
>> +	#   1. update the worktree to match HEAD & remove file2 in the index
>> +	#   2. reset --mixed to unstage the change from step 1
>> +	#   3. read-tree HEAD~1 (which differs from HEAD in file2)
>> +	# If the index is refreshed in step 2, then file2 in the index will be
>> +	# up-to-date with HEAD and read-tree will succeed (thus failing the
>> +	# test). If the index is *not* refreshed, however, the staged deletion
>> +	# of file2 from step 1 will conflict with the changes from the tree read
>> +	# in step 3, resulting in a failure.
>> +
>> +	# Step 0: start with a clean index
>> +	git reset --hard HEAD &&
>> +
>> +	# Step 1
>> +	git rm --cached file2 &&
>> +
>> +	# Step 2
>> +	git reset $1 --mixed HEAD &&

> Perhaps you want to have two arguments: one for config settings
> and another for arguments, meaning your call in test_index_refreshed
> should be
> 
> 	git $1 reset $2 --mixed HEAD
> 
> and calls like this should be
> 
> 	test_index_refreshed "-c reset.quiet=true" "" &&

After looking at your other examples, I thought of another example
that you might want to consider.

In the helper, use:

	git $@ --mixed HEAD &&

and then for the callers, use

	test_index_refreshed refresh &&

or

	test_index_refreshed -c reset.quiet=true refresh &&

or

	test_index_refreshed refresh --quiet &&

and similarly through the other tests.

Thanks,
-Stolee
