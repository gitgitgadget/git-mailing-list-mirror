Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00477C4167B
	for <git@archiver.kernel.org>; Mon, 18 Apr 2022 12:27:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238857AbiDRM3u (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Apr 2022 08:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240025AbiDRM3P (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Apr 2022 08:29:15 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CEA1205ED
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 05:23:05 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id d198so7844181qkc.12
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 05:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=noVrqTTOwBI9aVc7MdZkP88ctwjUsiyDifF0m2z/at0=;
        b=hf38Qz2QN5tGjonMICVTWojZ+RniqNTK311ACxSzbwLTvsswRhtERddiY0GQxvYTC7
         7KgBPTTMl4gyb2A+Jn27KPhEfdwxwncg/QAbpwQuy8TyoB77Hp+vZHKWFMmnTpGxFjGc
         6lSJxExqBYQLY4pTwx8iNsR14teFefiTKHIbnrzD5LKTNRADMeZko2ulSiHGcpUYlykB
         y34ObZ6oO44Ap+kXQFyv3h67VF6J0J+Pl6ekfWxn6ZwtxMtOok3TGznJ147eT5b6xcFE
         BaGlA6nQqsjfrfE/Jj6dFxOtqahqhxnigif1Ni3x3UH5k+x8piTUnK+h3UMTlFStjS0M
         tLpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=noVrqTTOwBI9aVc7MdZkP88ctwjUsiyDifF0m2z/at0=;
        b=zrWesH6YeuQrqjuPX0jHOV3rSLApBc1AqdRto6OmEh/L87aWUPLuSfHihDBnoyfFXX
         sdSJPOEYHFvE8YYxOLMS7/zKFv8gcFPfH+GhrGllmVo3q9YgmYKd6Rhs44pttjkF58pC
         qQuCZNHkwDBjZoaDJHx2VpA673HNoKyUwF9DOzBve1D5i5jL5vew8WfWXzOHkvhMUD25
         VQjiqJBCdgizlTBSyM+da9zPdA2RWISsOgJv1UPiCqkPttS5R3l30fTXrDM7EK3ZJ5VA
         hdAUIdtMqWxYmWhIzqrcednZ8zkkaTMYntc+mQdxurn3qWbJ+hQVBNHCKrHG2P121XjR
         Ii7g==
X-Gm-Message-State: AOAM5304v3WSJKErooTzJTjJc6ZjkBMV5dcXCOsYjTK/h5vQbRkhQZ5/
        OqOdUV0iiFnHXKfgQ7RiwaWg
X-Google-Smtp-Source: ABdhPJzd+Bf9qJGjKXjzxll410igD3gQew53HNxZeu/6bn/xtTJFoutHtGlK+MPnnQ50qpXXRgY2rA==
X-Received: by 2002:a37:a442:0:b0:69e:9971:66ab with SMTP id n63-20020a37a442000000b0069e997166abmr2891717qke.557.1650284584419;
        Mon, 18 Apr 2022 05:23:04 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id y25-20020a05620a09d900b0069e82fb9310sm2834222qky.15.2022.04.18.05.23.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Apr 2022 05:23:04 -0700 (PDT)
Message-ID: <e3303456-a46c-10db-d6e8-61cd0ffe79d6@github.com>
Date:   Mon, 18 Apr 2022 08:23:03 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 1/4] t1092: add compatibility tests for 'git show'
Content-Language: en-US
To:     Josh Steadmon <steadmon@google.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, vdye@github.com,
        shaoxuan.yuan02@gmail.com, Derrick Stolee <dstolee@microsoft.com>
References: <pull.1207.git.1649349442.gitgitgadget@gmail.com>
 <8c2fdb5a4fc3317c05324da54692036e36fc15f3.1649349442.git.gitgitgadget@gmail.com>
 <Ylhp5ubNco+oATOD@google.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <Ylhp5ubNco+oATOD@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/14/2022 2:37 PM, Josh Steadmon wrote:
> On 2022.04.07 16:37, Derrick Stolee via GitGitGadget wrote:
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
>> ---
>>  t/t1092-sparse-checkout-compatibility.sh | 16 ++++++++++++++++
>>  1 file changed, 16 insertions(+)
>>
>> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
>> index 236ab530284..74792b5ebbc 100755
>> --- a/t/t1092-sparse-checkout-compatibility.sh
>> +++ b/t/t1092-sparse-checkout-compatibility.sh
>> @@ -1151,6 +1151,22 @@ test_expect_success 'clean' '
>>  	test_sparse_match test_path_is_dir folder1
>>  '
>>  
>> +test_expect_success 'show (cached blobs/trees)' '
>> +	init_repos &&
>> +
>> +	test_all_match git show :a &&
>> +	test_all_match git show :deep/a &&
>> +	test_sparse_match git show :folder1/a &&
>> +
>> +	# Asking "git show" for directories in the index
>> +	# does not work as implemented. The error message is
>> +	# different for a full checkout and a sparse checkout
>> +	# when the directory is outside of the cone.
>> +	test_all_match test_must_fail git show :deep/ &&
>> +	test_must_fail git -C full-checkout show :folder1/ &&
>> +	test_sparse_match test_must_fail git show :folder1/
>> +'
> 
> A reminder that directories are not present in a non-sparse index would
> help those of us unfamiliar with the differences between
> sparse/non-sparse indexes to understand why the full-checkout cases fail
> here. Initially I was confused why any of these lookups would fail
> because my mental model was "a sparse-index is a proper subset of the
> non-sparse index".

At this point, it would be repetitive to explain the sparse index
every time we do anything involving it. Reviewers should expect to
be familiar with the topic, or consult the in-tree documentation [1, 2].

[1] https://github.com/git/git/blob/master/Documentation/technical/sparse-index.txt
[2] https://github.com/git/git/blob/4027e30c5395c9c1aeea85e99f51ac62f5148145/Documentation/technical/index-format.txt#L396-L406

Specific to this change, sparse directories are not being taken into
account, since 'git show' is still in the compatibility mode that
expands a sparse index to a full one [3]. Thus, the differences in this
patch are only related to full-checkout versus sparse-checkout.

[3] https://github.com/git/git/blob/4027e30c5395c9c1aeea85e99f51ac62f5148145/Documentation/technical/sparse-index.txt#L69-L74

Thanks,
-Stolee
