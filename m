Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64105219FF
	for <git@vger.kernel.org>; Sun,  4 Feb 2024 11:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707045301; cv=none; b=Dqji06BVNxPS7XOtvTWXeZi2rC6/lIi7syThnepICjp7pubtV2pEomTK5FmYIWAqRxzGLa/dEDWtmmA9u4SPU91PKQteIKMFJM3r8xU1xnH1zE9hg9Dfu3LqwB4+LjDVO6m6G0dqG9y72Wp4ljCZGpcwO1IlaCc7OiWHzrLcuIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707045301; c=relaxed/simple;
	bh=+Hjj0dg/ofKM01qh/TRlYXneRhJiKPh/uk3b9wCMqAo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h6BBDjqCCA0wnpWyjM5yTdKCsK5hvUjZOBtFr5STU4OiVtnXrMtrszGvRKRgAzuG4dhyaRlCUd4DGchhU8cL9+9Nji466K1mui+p3eBnQDL+hNTMEMxoRNVr4ICvt+cuykUvr/P2wTAfs/LKNwnRY1cM+PDjYX3ixFqsz9YIkHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GzYgV8oa; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GzYgV8oa"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-783ef8ae70aso260000485a.2
        for <git@vger.kernel.org>; Sun, 04 Feb 2024 03:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707045298; x=1707650098; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RhxEk/tfjk09JZAuH+WiC8mqmblbPvIpOdHTp2TJuiA=;
        b=GzYgV8oa8dQ2+zXrJX1ABHVqMZ9Yx7fhPjT/zahr3F3G+MzmlLT9Il/LDh2OBHkUsn
         /IIyabb/UHu0jVmq8sAGU64RolVF/4Kmtp7bghoARhoB3ktkFsGfRM4TuYiNdSDnhlyN
         9Em+JupmHi3NjDfWPzeeMaTi6GineO7pKMHfbS0b+v6r9uwWfO+3cbJT40dYux01RcYr
         VYjn1cRqhFIQZaTYXlvxE5ai62pCmQ62hC6hdU/HT/wxeEJ+BZABjjykurLrAe/l5Xzp
         yVvdidV6DFcbSdtw4Tn1vZrwcKuspYTaumhNZUP64SG/VBdBUQ/bugn1aHDN/g+tcINP
         BQMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707045298; x=1707650098;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RhxEk/tfjk09JZAuH+WiC8mqmblbPvIpOdHTp2TJuiA=;
        b=dY4WnnGY+qQi8qe5HrAb44Tuub6s4IeGRAmckSDXueOCccs2WCeRWo9heEmF0dli89
         7YyagfLt7DzQCBqyqZxHzy+r4n5poYuZPiFHrfrvujYwPb0kFcS8cnU7B5jaYH18VwNP
         QXl09BlDyIOnx5+MYvIoEQrsRSVCKVsURu4baML/jCiLweT/bOigtHCfov8N/KRl8dDC
         5lD79PpqpwUpMpQEYy272qvWWUSPPvErROc9NCsFRenHf163hhMkhdz6POrkcRLG8tnB
         T7ty/wRtJWtaTlNFxPIo9bGCcM5VzoY7DiNsG0Ut1z3BySai4yFFRk66Qhr9yapdOkyV
         zuEw==
X-Gm-Message-State: AOJu0YzViBlcpXcg2hVnxnAKk5o47A+Xj1ErvTqQIfal75uq43tKEEKg
	j+A1ZO68YELnzEYh4JcMhL1uxb+my5RG76/HjhvK+RT1roxQO81B
X-Google-Smtp-Source: AGHT+IFHeyRwFPwgIjfn0GIXwHwqGtB3SiEM+pSd2qz7sH4Wzo2Ot3Zupzz0+LlzSccvq+gWT23dBQ==
X-Received: by 2002:a05:620a:2238:b0:783:e74f:6699 with SMTP id n24-20020a05620a223800b00783e74f6699mr10477044qkh.5.1707045298307;
        Sun, 04 Feb 2024 03:14:58 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVTpkS8LldKsTGjDClNsHP/U33rH5a+PNEWJYReznM54WkXT5aXXj6O1gXU6GooiNqJG7OM+3Yjp1+ZJGY7p8jvk1uIvYcuDNAV+07CTKD0TpTPxG7Gm0DQ6wYVh1xNhHxPZLeNmmgg1hzPBxPX0uzwmlRzoutD2Q==
Received: from ?IPV6:2a0a:ef40:62e:a901:d2c6:37ff:fef6:7b1? ([2a0a:ef40:62e:a901:d2c6:37ff:fef6:7b1])
        by smtp.googlemail.com with ESMTPSA id a27-20020a05620a125b00b00783f62d1613sm2116406qkl.69.2024.02.04.03.14.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Feb 2024 03:14:57 -0800 (PST)
Message-ID: <0adb1068-ef10-44ed-ad1d-e0927a09245d@gmail.com>
Date: Sun, 4 Feb 2024 11:14:55 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] t/t3515-cherry-pick-rebase.sh: new testcase demonstrating
 broken behavior
Content-Language: en-US
To: Vegard Nossum <vegard.nossum@oracle.com>, gitster@pobox.com
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
 Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
References: <20240202091850.160203-1-vegard.nossum@oracle.com>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20240202091850.160203-1-vegard.nossum@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Vegard

On 02/02/2024 09:18, Vegard Nossum wrote:
> Running "git cherry-pick" as an x-command in the rebase plan loses the
> original authorship information.
> 
> Write a known-broken test case for this:
> 
>      $ (cd t && ./t3515-cherry-pick-rebase.sh)
>      ok 1 - setup
>      ok 2 - cherry-pick preserves authorship information
>      not ok 3 - cherry-pick inside rebase preserves authorship information # TODO known breakage
>      # still have 1 known breakage(s)
>      # passed all remaining 2 test(s)
>      1..3
> 
> Running with --verbose we see the diff between expected and actual:
> 
>      --- expected    2024-02-02 08:54:48.954753285 +0000
>      +++ actual      2024-02-02 08:54:48.966753294 +0000
>      @@ -1 +1 @@
>      -Original Author
>      +A U Thor
> 
> As far as I can tell, this is due to the check in print_advice()
> which deletes CHERRY_PICK_HEAD when GIT_CHERRY_PICK_HELP is set,
> but I'm not sure what a good fix would be.

Thanks for reporting this and for the test case. I agree with your 
diagnosis. I think the simplest fix would be to unset 
GIT_CHERRY_PICK_HELP in the child environment in sequencer.c:do_exec(). 
Long term we should stop setting GIT_CHERRY_PICK_HELP when rebasing and 
hard code the rebase conflicts message in sequencer.c as the environment 
variable is a vestige of the scripted rebase implementation.

To work around the bug I think you can change the exec lines in the todo 
list to

     exec unset GIT_CHERRY_PICK_HELP; git cherry-pick ...

Best Wishes

Phillip

> Cc: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
> ---
>   t/t3515-cherry-pick-rebase.sh | 37 +++++++++++++++++++++++++++++++++++
>   1 file changed, 37 insertions(+)
>   create mode 100755 t/t3515-cherry-pick-rebase.sh
> 
> diff --git a/t/t3515-cherry-pick-rebase.sh b/t/t3515-cherry-pick-rebase.sh
> new file mode 100755
> index 0000000000..ffe6f5fe2a
> --- /dev/null
> +++ b/t/t3515-cherry-pick-rebase.sh
> @@ -0,0 +1,37 @@
> +#!/bin/sh
> +
> +test_description='test cherry-pick during a rebase'
> +
> +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
> +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> +
> +. ./test-lib.sh
> +
> +test_expect_success setup '
> +	test_commit --author "Original Author <original.author@example.com>" foo file contents1 &&
> +	git checkout -b feature &&
> +	test_commit --author "Another Author <another.author@example.com>" bar file contents2
> +'
> +
> +test_expect_success 'cherry-pick preserves authorship information' '
> +	git checkout -B tmp feature &&
> +	test_must_fail git cherry-pick foo &&
> +	git add file &&
> +	git commit --no-edit &&
> +	git log -1 --format='%an' foo >expected &&
> +	git log -1 --format='%an' >actual &&
> +	test_cmp expected actual
> +'
> +
> +test_expect_failure 'cherry-pick inside rebase preserves authorship information' '
> +	git checkout -B tmp feature &&
> +	echo "x git cherry-pick -x foo" >rebase-plan &&
> +	test_must_fail env GIT_SEQUENCE_EDITOR="cp rebase-plan" git rebase -i feature &&
> +	git add file &&
> +	git commit --no-edit &&
> +	git log -1 --format='%an' foo >expected &&
> +	git log -1 --format='%an' >actual &&
> +	test_cmp expected actual
> +'
> +
> +test_done

