Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB72F31716B
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 18:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772476760; cv=none; b=DZpftwUI1pvyyTfpq3VJbVU0tMwPtKS/egRFCbNbAxHMUM3eDn1bAz0yZ59DtNTSPgVVW30u/a01T2Xauw472m74ac/mUolVB8Fy2ucfMw2XchzRWDqdoK3WkZRa7mMlTWAcCyDy6dZKC23fvaxWcE1DxlyaHqBYm1HjWGCB7qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772476760; c=relaxed/simple;
	bh=DnZLTwzC9GqMIE3QQQTfrttvUgLWACVAkWemyPE9WgM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WBVmGhXzDhttwhNA2vNJx3wNbmJ/DotvbaVwT/fQCEEVrcR/6PmwL3tvNMxjtjAGj6+V/wwSBnJYoOLYsqYcYa47GGB5y0YNZ/mjtIeuT1Cgw5Su7/MwDjpkVcK/QhunVpcQPO0C948Ee6bBLARP2csCYGgw0GWwPZ7BYfvcjxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PaTvuSSd; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PaTvuSSd"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-899c3441177so79724286d6.0
        for <git@vger.kernel.org>; Mon, 02 Mar 2026 10:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772476758; x=1773081558; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BXYAugtgDGWortFe6LFB43Q5tOnhmkK3xVn0RsoI1Hc=;
        b=PaTvuSSd7U5RPOGSODzIrvNjzgcmLNghYU9YiI63m019XkuWPqkt0KCGhKtgyt8s0V
         /fudCivKjpgcmr0KGF5GJHRybC74HWTK9yocEzTWt0UAyYKgcn1nosJ2qcJNfyR5VwK0
         etJn3TrHeN+/Tv43ZpTcv2Z6anOuuTZambTibb7eDOuAEVkfkFW2BLM2i5S8vJt7/vu1
         Nbq/XH3g7Ltq+SFtyTYFydFQrZgF3F4E9vlfHOf44iv4elXso/Qa9YU8b+7Jxsn5BRhL
         SwwVrndSnda5WlhxB1/0JIdMyqzHopvQ9HphmIe8TZEZiGWsDWlfTGPk7Uhk2vhYKpBg
         sblw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772476758; x=1773081558;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BXYAugtgDGWortFe6LFB43Q5tOnhmkK3xVn0RsoI1Hc=;
        b=Aplph0KoJo3XVpHsPI0KiCgAy+Akp2z7sKBdAZwz5Aa52XlgcFirWdlRK+6ovbERJz
         rjaN/KyB4TTMo8+yTR44Oo4LjG8U6CQWZA3rxIBeY137lz9vaE/Wnw6JOMBRnG3hB/PE
         Lm/lnxc8x6+6NXacG9t4mbFCd2EXVxZKL65HoVScCCPDDL1Ui4LjT2es0oKhlkuslHWx
         VmrA00qMHTGfuDH/PI4ShxvBrvbjUYwBB97+z3Ji+Do5CejPNi3cqLsJAUhJ9QuUhz2o
         ONcVpVGk9+cpTIPSbDIXXqh27OAgVc+aPu0PBfbMD8VCIWBSKfC5sCpu5MOCyH9tk8Cw
         lGtg==
X-Gm-Message-State: AOJu0YzlM/0ZZBDJAHfW7yCDAYb07FEdfDOQ7Vzbrz0YZivMUeDiwF63
	6aD71dUEKLdjSdThGbt8fT3mdcmkgnxIpHZn4phsOkrYQzlsXmJO/NM3
X-Gm-Gg: ATEYQzyJz0V8ZEb2Y+v1Wzrc2OQYLgCywWqGOKYU/nyZ0hZr7hYkklB0oAbZTh85zal
	6Wg+7EaINF+UvJqsN00h7lIPehr/J7BiQhNHbEQ3jOp0g+EjdtbXAr255CIlxC7GRmsqx6o/E8E
	bPUPEDZKwHE5Uw0HSzbKBf/nsee46gHNK+RZf1qdC+EwGGEv/rUJZotHUH9t6wszhRpZapJffnB
	Vcq+3felIPJzEN/N9IUdajjSFUOk4Fd59fj6jcvv7ByABjcb3670DgIkLr1rwlRUucqdIoTBVZn
	2duGNI2zVCVViqQb71KAM52yAGvqdSbHy/e5VIiSRAh1Zk7rcXD7+kxlV7QnbkyI5yDNzHjLJgP
	ROSUSqjAUTOqOuh/j/e84zuGYRSdQvssiL6uccBqwk8SiZSiu/OdGopdTT4fFd85zQT8BgYndGk
	Vfkb8F/oB12ydHehdbsqrlMaQEJdSVkJkR8r6g///aXQDjUha4a2BpvS0Lh8dyq9xPfq50rg==
X-Received: by 2002:a05:6214:5196:b0:895:1d2a:1718 with SMTP id 6a1803df08f44-899d1dbc101mr200383276d6.18.1772476757876;
        Mon, 02 Mar 2026 10:39:17 -0800 (PST)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899ff659b75sm21146276d6.34.2026.03.02.10.39.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 10:39:17 -0800 (PST)
Message-ID: <15eb8691-a55d-4edc-94fe-ac8a4b37b90c@gmail.com>
Date: Mon, 2 Mar 2026 13:39:16 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] for-each-repo: work correctly in a worktree
To: Jeff King <peff@peff.net>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, fastcat@gmail.com,
 Eric Sunshine <sunshine@sunshineco.com>, Patrick Steinhardt <ps@pks.im>,
 Phillip Wood <phillip.wood123@gmail.com>
References: <pull.2056.v2.git.1771968924.gitgitgadget@gmail.com>
 <pull.2056.v3.git.1772465805.gitgitgadget@gmail.com>
 <2a6091095f120426fed554a08871f2b4dcd15282.1772465805.git.gitgitgadget@gmail.com>
 <20260302180601.GD28275@coredump.intra.peff.net>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20260302180601.GD28275@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/2/2026 1:06 PM, Jeff King wrote:
> On Mon, Mar 02, 2026 at 03:36:44PM +0000, Derrick Stolee via GitGitGadget wrote:
> 
>> @@ -15,10 +16,11 @@ static const char * const for_each_repo_usage[] = {
>>  
>>  static int run_command_on_repo(const char *path, int argc, const char ** argv)
>>  {
>> -	int i;
>>  	struct child_process child = CHILD_PROCESS_INIT;
>>  	char *abspath = interpolate_path(path, 0);
>>  
>> +	clear_local_repo_env(&child.env);
>> +
>>  	child.git_cmd = 1;
>>  	strvec_pushl(&child.args, "-C", abspath, NULL);
> 
> The second part of the hunk here is as expected, but the first one looks
> wrong. We didn't remove any references to "i", so either it was
> redundant to start with (and the compiler should have complained), or
> now we've broken compilation.

You are correct. I did a --fixup here and it messed up the diff. I should
have double-checked the commit-by-commit compilation and testing post-
rebase.

> Looks like the latter, but we recover when we switch to using pushv in
> patch 4. So I think the declaration of "i" should move to that patch.

Can do. Looks like a small v4 update _is_ required.

Thanks,
-Stolee

