Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B018C00140
	for <git@archiver.kernel.org>; Tue,  9 Aug 2022 02:55:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbiHICzl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Aug 2022 22:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232030AbiHICzh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Aug 2022 22:55:37 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D68D615D
        for <git@vger.kernel.org>; Mon,  8 Aug 2022 19:55:36 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id d65-20020a17090a6f4700b001f303a97b14so10960895pjk.1
        for <git@vger.kernel.org>; Mon, 08 Aug 2022 19:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=hPte2MT46A2kDzOTLmhMA5VGdWAoAGdIFOKjIaM9hio=;
        b=VEHhI+nUgVpNhEy6o8ZastVyzessLzFF5cwwqkI5kbwWxXRQreNZwS5gzhQV8bHRSZ
         JLMqdSGnUvQa/Zlmbkeo4EPIfLkH+0E3LtflZV3uudHURki+/fkA9iHYdsrTuSvEAJ26
         +WmxIldXWE20de2/V3eRnRsDNvU/vp1M77ZxHPvjkdrM00G2e4TJusDpAPk9YvUdzHDG
         ADo0uPIdsW9v9YeRrj5360FgUlGhmbCvxRV06uthwo8QqAeeVKKH6a3ND+cx/B5A0L/t
         nPLQMRV/2JyC6mbVW1ZBgYz0Th+n+QuIDAGo73o6yzoB66bUysiyUeplndZ6AtDjIX4s
         pMXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hPte2MT46A2kDzOTLmhMA5VGdWAoAGdIFOKjIaM9hio=;
        b=Z//FsfceJo/mZRrwRRJOQLVR6ePoNrPrVdPF1rMQzve/pLkiboXC/yQpauP/EatFMu
         n3U7sF/61FKlYgTRc92Mqd7RFFOv1247ZFq8aD7pQlxj8YbYB6hgoLu1824VWE1waI25
         LTG83GueXVW9SNQ4MCUNhmnWEyAiCDPuBUoo5Bih1cDEDJ1upx70yAhn7GKg5C5IhHf9
         Wch4bRuK0Q3+bD7qw85kFZKj3JD35+0R/QeQg0Owem2y4KdmFKAlVHunz6yPmxcURyuQ
         17kGLbEEXMxUw9ES6eQvpjTClwdSxuLW7e4rQdlxrbWyOBGBEJwFjfx5Lfi7+KC2M9oJ
         3Bog==
X-Gm-Message-State: ACgBeo0er8P50yTiIIxr9FTdaVozHHVkzTruuKBkq0YID0V7GRHrMldb
        +CiMAKnz4IzfCOCKOiZp6GWKgJtfNHGECA==
X-Google-Smtp-Source: AA6agR4JOGb0339Q0YgwFNz6VTYEL13ioquarwWXTTqELSAgUyFFFLbHYbpyzhlVAM/HGa8OuaZeJw==
X-Received: by 2002:a17:90b:4c8d:b0:1f5:409b:b017 with SMTP id my13-20020a17090b4c8d00b001f5409bb017mr32770940pjb.52.1660013735575;
        Mon, 08 Aug 2022 19:55:35 -0700 (PDT)
Received: from [127.0.0.1] ([45.138.210.17])
        by smtp.gmail.com with ESMTPSA id h5-20020a628305000000b0052a297324cbsm9344606pfe.41.2022.08.08.19.55.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Aug 2022 19:55:35 -0700 (PDT)
Message-ID: <651d89e2-5282-2cf8-ffc3-8650a023c80a@gmail.com>
Date:   Tue, 9 Aug 2022 10:55:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/9] t7002: add tests for moving from in-cone to
 out-of-cone
Content-Language: en-US
To:     Victoria Dye <vdye@github.com>, git@vger.kernel.org
Cc:     derrickstolee@github.com
References: <20220719132809.409247-1-shaoxuan.yuan02@gmail.com>
 <20220805030528.1535376-1-shaoxuan.yuan02@gmail.com>
 <20220805030528.1535376-2-shaoxuan.yuan02@gmail.com>
 <bd80881d-b2a3-c220-8f2d-a07a46e14207@github.com>
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
In-Reply-To: <bd80881d-b2a3-c220-8f2d-a07a46e14207@github.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 8/9/2022 8:51 AM, Victoria Dye wrote:
> Shaoxuan Yuan wrote:
>> Add corresponding tests to test that user can move an in-cone <source>
>> to out-of-cone <destination> when --sparse is supplied.
>>
>> Such <source> can be either clean or dirty, and moving it results in
>> different behaviors:
>>
>> A clean move should move the <source> to the <destination>, both in the
>> working tree and the index, then remove the resulted path from the
>> working tree, and turn on its CE_SKIP_WORKTREE bit.
> Looking ahead to patch 6, I think the part about "move it in the working
> tree, then delete from the working tree" doesn't quite match your
> implementation. Instead, if I'm not mistaken, what happens is:
>
> 1. Move <source> to <destination> in the index (do *not* create
>     <destination> in the worktree)
> 2. Delete <source> from the working tree
You are right. The description here seems to be my first in-mind 
implementation, which
I wrote down for record. Later I changed the implementation to the one 
you mentioned
here, but somehow forgot to change the description here.

Thanks for the catch!
>> A dirty move should move the <source> to the <destination>, both in the
>> working tree and the index, but should *not* remove the resulted path
>> from the working tree and should *not* turn on its CE_SKIP_WORKTREE bit.
> Makes sense.
>
>> Also make sure that if <destination> exists in the index (existing
>> check for if <destination> is in the worktree is not enough in
>> in-to-out moves), warn user against the overwrite. And Git should force
>> the overwrite when supplied with -f or --force.
> Also makes sense.
>
>> Helped-by: Derrick Stolee <derrickstolee@github.com>
>> Helped-by: Victoria Dye <vdye@github.com>
>> Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
>> ---
>>   t/t7002-mv-sparse-checkout.sh | 122 ++++++++++++++++++++++++++++++++++
>>   1 file changed, 122 insertions(+)
>>
>> diff --git a/t/t7002-mv-sparse-checkout.sh b/t/t7002-mv-sparse-checkout.sh
>> index 71fe29690f..9b3a9ab4c3 100755
>> --- a/t/t7002-mv-sparse-checkout.sh
>> +++ b/t/t7002-mv-sparse-checkout.sh
>> @@ -290,4 +290,126 @@ test_expect_success 'move sparse file to existing destination with --force and -
>>   	test_cmp expect sub/file1
>>   '
>>   
>> +test_expect_failure 'move clean path from in-cone to out-of-cone' '
>> +	test_when_finished "cleanup_sparse_checkout" &&
>> +	setup_sparse_checkout &&
>> +
>> +	test_must_fail git mv sub/d folder1 2>stderr &&
>> +	cat sparse_error_header >expect &&
>> +	echo "folder1/d" >>expect &&
>> +	cat sparse_hint >>expect &&
>> +	test_cmp expect stderr &&
>> +
>> +	git mv --sparse sub/d folder1 2>stderr &&
>> +	test_must_be_empty stderr &&
>> +
>> +	test_path_is_missing sub/d &&
>> +	test_path_is_missing folder1/d &&
>> +	git ls-files -t >actual &&
>> +	! grep "^H sub/d\$" actual &&
>> +	grep "S folder1/d" actual
>> +'
>> +
>> +test_expect_failure 'move clean path from in-cone to out-of-cone overwrite' '
>> +	test_when_finished "cleanup_sparse_checkout" &&
>> +	setup_sparse_checkout &&
>> +	echo "sub/file1 overwrite" >sub/file1 &&
>> +	git add sub/file1 &&
>> +
>> +	test_must_fail git mv sub/file1 folder1 2>stderr &&
>> +	cat sparse_error_header >expect &&
>> +	echo "folder1/file1" >>expect &&
>> +	cat sparse_hint >>expect &&
>> +	test_cmp expect stderr &&
>> +
>> +	test_must_fail git mv --sparse sub/file1 folder1 2>stderr &&
>> +	echo "fatal: destination exists in the index, source=sub/file1, destination=folder1/file1" \
>> +	>expect &&
>> +	test_cmp expect stderr &&
>> +
>> +	git mv --sparse -f sub/file1 folder1 2>stderr &&
>> +	test_must_be_empty stderr &&
>> +
>> +	test_path_is_missing sub/file1 &&
>> +	test_path_is_missing folder1/file1 &&
>> +	git ls-files -t >actual &&
>> +	! grep "H sub/file1" actual &&
>> +	grep "S folder1/file1" actual &&
>> +
>> +	# compare file content before move and after move
>> +	echo "sub/file1 overwrite" >expect &&
>> +	git ls-files -s -- folder1/file1 | awk "{print \$2}" >oid &&
>> +	git cat-file blob $(cat oid) >actual &&
>> +	test_cmp expect actual
>> +'
>> +
>> +test_expect_failure 'move dirty path from in-cone to out-of-cone' '
>> +	test_when_finished "cleanup_sparse_checkout" &&
>> +	setup_sparse_checkout &&
>> +	echo "modified" >>sub/d &&
>> +
>> +	test_must_fail git mv sub/d folder1 2>stderr &&
>> +	cat sparse_error_header >expect &&
>> +	echo "folder1/d" >>expect &&
>> +	cat sparse_hint >>expect &&
>> +	test_cmp expect stderr &&
>> +
>> +	git mv --sparse sub/d folder1 2>stderr &&
>> +
>> +	test_path_is_missing sub/d &&
>> +	test_path_is_file folder1/d &&
>> +	git ls-files -t >actual &&
>> +	! grep "^H sub/d\$" actual &&
>> +	grep "H folder1/d" actual
>> +'
>> +
>> +test_expect_failure 'move dir from in-cone to out-of-cone' '
>> +	test_when_finished "cleanup_sparse_checkout" &&
>> +	setup_sparse_checkout &&
>> +
>> +	test_must_fail git mv sub/dir folder1 2>stderr &&
>> +	cat sparse_error_header >expect &&
>> +	echo "folder1/dir/e" >>expect &&
>> +	cat sparse_hint >>expect &&
>> +	test_cmp expect stderr &&
>> +
>> +	git mv --sparse sub/dir folder1 2>stderr &&
>> +	test_must_be_empty stderr &&
>> +
>> +	test_path_is_missing folder1 &&
>> +	git ls-files -t >actual &&
>> +	! grep "H sub/dir/e" actual &&
>> +	grep "S folder1/dir/e" actual
>> +'
>> +
>> +test_expect_failure 'move partially-dirty dir from in-cone to out-of-cone' '
>> +	test_when_finished "cleanup_sparse_checkout" &&
>> +	setup_sparse_checkout &&
>> +	touch sub/dir/e2 sub/dir/e3 &&
>> +	git add sub/dir/e2 sub/dir/e3 &&
>> +	echo "modified" >>sub/dir/e2 &&
>> +	echo "modified" >>sub/dir/e3 &&
>> +
>> +	test_must_fail git mv sub/dir folder1 2>stderr &&
>> +	cat sparse_error_header >expect &&
>> +	echo "folder1/dir/e" >>expect &&
>> +	echo "folder1/dir/e2" >>expect &&
>> +	echo "folder1/dir/e3" >>expect &&
>> +	cat sparse_hint >>expect &&
>> +	test_cmp expect stderr &&
>> +
>> +	git mv --sparse sub/dir folder1 2>stderr &&
>> +
>> +	test_path_is_missing folder1/dir/e &&
>> +	test_path_is_file folder1/dir/e2 &&
>> +	test_path_is_file folder1/dir/e3 &&
>> +	git ls-files -t >actual &&
>> +	! grep "H sub/dir/e" actual &&
>> +	! grep "H sub/dir/e2" actual &&
>> +	! grep "H sub/dir/e3" actual &&
>> +	grep "S folder1/dir/e" actual &&
>> +	grep "H folder1/dir/e2" actual &&
>> +	grep "H folder1/dir/e3" actual
>> +'
>> +
> There are two other test cases I'd be interested in seeing:
>
> 1. Move a (clean or dirty) in-cone source file to an out-of-cone destination
>     *file*. For example:
>
> 	echo test >sub/dir/file1 &&
> 	git add sub/dir/file1 &&
> 	git mv --sparse sub/dir/file1 folder1/file1
>
>     I'm assuming this should behave the same way as show in 'move clean path
>     from in-cone to out-of-cone overwrite'.
OK.
>
> 2. Move a (clean or dirty) in-cone source directory to an out-of-cone
>     destination where one or more files in <src> overwrite files in <dst>.
>     For example, something like:
>
> 	echo test >sub/dir/file1 &&
> 	git add sub/dir/file1 &&
> 	git mv --sparse sub/dir folder1
>
>     I don't have a strong opinion on the behavior (does it fail the whole
>     'mv' operation? move everything except the files that overwrite
>     something?), but it would help to have it documented via test here.
OK. I think it will fail the whole `mv` operation. The program will 
report unspecified
overwrite during the early checking phase. The actual "moving" phase 
won't be touched
at all because Git complains early.

--
Thanks,
Shaoxuan


