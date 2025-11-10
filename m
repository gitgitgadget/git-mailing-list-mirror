Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B4A193077
	for <git@vger.kernel.org>; Mon, 10 Nov 2025 09:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762767786; cv=none; b=r+l0Z0JlvjxqeWxBFfuC6rX2wG/otsc3u7iXaXe0t+WuAzf52x44YBwXTTnbuWsA1KWNebJcnMK/uwf1uHknmKYsjI3XPKHsrIuy2zC+/ItSlUqD/em5AFDC4Ty2GHjCUb4u7hR3HpfjjJl/W7O7GFSgiFhObDMYy3qu2rLMN9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762767786; c=relaxed/simple;
	bh=fIBLShf7g++FxV/vvrfd1JYtmdIWyinZCB046S+zTtE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f4J6qC7I3vBAIBXwPUxlBO7ui5ememCs8b46M1G6rUN7Gq7uyDy0kguyXo1MyHMfq5HQPW/MBly8g1fXDti0zhiyQ73GgV+BS1+MKHdQb0Ig4sZy03rNlks/HeyO9Sdzf5b52d+xlHiOOShM/CMiGWzzxaGXnqxxVY9kp7pei3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=STl5Z3d/; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="STl5Z3d/"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-594330147efso2665600e87.2
        for <git@vger.kernel.org>; Mon, 10 Nov 2025 01:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762767782; x=1763372582; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Eg6sRMwhoA4jXahejHqyg21oKemYQcTg4t/AuE7YrC8=;
        b=STl5Z3d/m3HS4Z6axPepMZ6Z6huP14ImfAsMXoSyzSVVxjxGEYKL1yMWrzSEQ5Xnq4
         Q9wYY07ZJzh6RPrzFcNJnRiU16EZ1Xh/kynMRu1Nb6hqUsknrM0PrvABuF6WdLjr1mOy
         o3Cucupgm0Gd3GsT8/Syj1vdD8sw7erbNih43nJx4kvhlwfMpFQcSG4cpdo+Cx22QzmP
         JFo8NohBZZijAnC7HbfH+vil1xbgv4WvQDf1i30dhQaUypUROUWM7sglcX2Y7UJm8zdX
         2Zwss07YuVush0edwZvaagLDUgGWk6+svt9eTVvfvSAK8JQAA9QsUxOCidXlGeZB4SeS
         LKrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762767782; x=1763372582;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eg6sRMwhoA4jXahejHqyg21oKemYQcTg4t/AuE7YrC8=;
        b=rXI0d5Qa9meRzwMHu1QIDHVdLK10sdjKW4+0SX8pceTXpTkQmOha21E6c7BQIsQT22
         XbAtUtlWw010VIboTi9y7A42Iz+AMm/N7kXrSdw83c59goaRSiQ0mJBNITL0WVTCob7f
         0H6wRvhkbyMxkW8uz548CdlM9KzXmW9q+dp4wJuSJCALBZdWzSEz/x0dA1N1I6tL9hKF
         E+umXwGvvFh/PxA4jwLVwht66WZ7Ajk2HUBtJJwh3PnS5mL9BiYGAMzXTqCdKTjZ7sK0
         y+V3u8TYKVSqaQmHdgBmQpbZ9hbPWAKfKmKy2HNSCyiFpd+VT3ZSlqGVq1sbzXC2qBG3
         ZVqg==
X-Gm-Message-State: AOJu0YwzivbsjWUS3H/VN3kpyR3LIAtIaeCW2P/DmwddNyRtRcHYC1cS
	73xejgjf30zGRVfZSNBFmEeKr/EzaO+mY9TUUG76BGO83/jutbn9BRWX7zKhKQ==
X-Gm-Gg: ASbGncs81lv91JNIYhCxNU/inCdI+zUu+U07d5NiAbPt8n8xcUOUDFFxqS1QyjJc2Zg
	+qfJGy2Q0hILyjaxLYMCp09+wNbZwhUK49YbTaDEhfuHylyRj+b/GVCdNWSoUPIv6Y0+vPp8aYd
	7QuTQMRCxrhIiB44avGPD7o5AnaGklGINW+pkEljCQUqmquOfcAu8PpJffw/VlsRVtNlQefnniW
	JS//WBXrmQNG0NjkJ65gBKxgss7JfDJKuJ0uoglfkNQO+DojE9NtZ6U1UAVHAh+ZpfhBOCtMHYk
	D0XwoWwuk6TSEuEmExuyp35VS7je45U62ysHYk/gRCn2uOLQ/QV2iaNcuYh9FxwADNR8bM1aFmk
	XPsTFXFt2D50mC/l5yyH6Kud5S1+7ug2vutzV69k2k1+Pqj1TsbpZ4g4O6ULYxoBqhEBiT+Q4Ld
	1vfQUPzDpYGzC/0+ubZh5OxqX1Q4eRViD5VwuaMAFiIhpCm1AqJ3ZY
X-Google-Smtp-Source: AGHT+IEkySo1f700a82NUZjG9aUc7cIKvwzt0+UbGJVSkIXA+M4xuBDFN+HRTCtN+1Q3ehFjp4sa+w==
X-Received: by 2002:ac2:4c45:0:b0:592:f7cf:9f6f with SMTP id 2adb3069b0e04-5945f161736mr2435172e87.14.1762767782047;
        Mon, 10 Nov 2025 01:43:02 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:658:8901:ced:8495:73eb:ebd6? ([2a0a:ef40:658:8901:ced:8495:73eb:ebd6])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5944a39eb32sm3921849e87.82.2025.11.10.01.43.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 01:43:01 -0800 (PST)
Message-ID: <61e6b077-26ef-49ed-83cf-fa5b7888429c@gmail.com>
Date: Mon, 10 Nov 2025 09:42:53 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] diff: disable rename detection with --quiet
To: "D. Ben Knoble" <ben.knoble@gmail.com>, =?UTF-8?Q?Ren=C3=A9_Scharfe?=
 <l.s.r@web.de>
Cc: Git <git@vger.kernel.org>, Phillip Wood <phillip.wood@dunelm.org.uk>,
 Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <CALnO6CBsj+aMvHJoUQ+LHAtXhcFhQeH8AuHyrX+rumur6MQQog@mail.gmail.com>
 <8796cd59-2335-4674-823d-d682ce7b7f8e@web.de>
 <CALnO6CC+ke1L7T+dO13B0FSjLyJqihKHKZaa-B4dh9guxk7z0Q@mail.gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <CALnO6CC+ke1L7T+dO13B0FSjLyJqihKHKZaa-B4dh9guxk7z0Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Ben

On 09/11/2025 17:34, D. Ben Knoble wrote:
> On Sun, Nov 9, 2025 at 11:43 AM René Scharfe <l.s.r@web.de> wrote:
>>
> λ hyperfine -NiP v 1 2 ~/code/git/'buildv{v}/git diff --cached --quiet
> --no-ext-diff --find-copies-harder'
> Benchmark 1: /home/benknoble/code/git/buildv1/git diff --cached
> --quiet --no-ext-diff --find-copies-harder
>    Time (mean ± σ):      72.0 ms ±   3.3 ms    [User: 45.2 ms, System: 26.2 ms]
>    Range (min … max):    67.6 ms …  79.6 ms    42 runs
> 
>    Warning: Ignoring non-zero exit code.
> 
> Benchmark 2: /home/benknoble/code/git/buildv2/git diff --cached
> --quiet --no-ext-diff --find-copies-harder
>    Time (mean ± σ):      19.9 ms ±   1.5 ms    [User: 8.9 ms, System: 10.6 ms]
>    Range (min … max):    16.1 ms …  24.0 ms    151 runs
> 
>    Warning: Ignoring non-zero exit code.
> 
> Summary
>    /home/benknoble/code/git/buildv2/git diff --cached --quiet
> --no-ext-diff --find-copies-harder ran
>      3.61 ± 0.31 times faster than /home/benknoble/code/git/buildv1/git
> diff --cached --quiet --no-ext-diff --find-copies-harder

That's a nice speedup. Thanks for sharing that - I knew in an abstract 
way that "--find-copies-harder" slowed things down but seeing some 
concrete numbers really brings it home.

Best Wishes

Phillip

>> This actually fixes the error code when using the options --cached,
>> --find-copies-harder, --no-ext-diff and --quiet together:
>> run_diff_index() indirectly calls diff-lib.c::show_modified(), which
>> queues even non-modified entries using diff_change() because we need
>> them for copy detection.  diff_change() sets flags.has_changes, though,
>> which causes diff_can_quit_early() to declare we're done after seeing
>> only the very first entry -- way too soon.
> 
> This does describe the behavior I saw, but it seems to me that, if we
> have changes, then we ought to be able to quit early for --quiet, no?
> 
> So there's some other knock-on effect that causes quitting early to be
> wrong here, and I'm not exactly sure what it is (other than the diff
> queues being different sizes when we hit relevant parts of
> diffcore_std, though it's the working case that has the larger queue).
> So I'm having a hard time tying this paragraph to the actual issue
> (mostly due to my complete unfamiliarity with the diffing subsystem).
> 
>> Using --cached, --find-copies-harder and --quiet together without
>> --no-ext-diff was not affected even before, as it causes the flag
>> flags.diff_from_contents to be set, which disables the optimization
>> in a different way.
>>
>> Reported-by: D. Ben Knoble <ben.knoble@gmail.com>
>> Suggested-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>> Signed-off-by: René Scharfe <l.s.r@web.de>
>> ---
>>   diff.c              |  2 ++
>>   t/t4007-rename-3.sh | 10 ++++++++++
>>   2 files changed, 12 insertions(+)
>>
>> diff --git a/diff.c b/diff.c
>> index a1961526c0..efa8d9773c 100644
>> --- a/diff.c
>> +++ b/diff.c
>> @@ -4987,6 +4987,8 @@ void diff_setup_done(struct diff_options *options)
>>          if (options->flags.quick) {
>>                  options->output_format = DIFF_FORMAT_NO_OUTPUT;
>>                  options->flags.exit_with_status = 1;
>> +               options->detect_rename = 0;
>> +               options->flags.find_copies_harder = 0;
>>          }
>>
>>          /*
>> diff --git a/t/t4007-rename-3.sh b/t/t4007-rename-3.sh
>> index e8faf0dd2e..3fc81bcd76 100755
>> --- a/t/t4007-rename-3.sh
>> +++ b/t/t4007-rename-3.sh
>> @@ -41,6 +41,16 @@ test_expect_success 'copy detection, cached' '
>>          compare_diff_raw current expected
>>   '
>>
>> +test_expect_success 'exit code of quiet copy detection' '
>> +       test_expect_code 1 \
>> +       git diff --quiet --cached --find-copies-harder $tree
>> +'
>> +
>> +test_expect_success 'exit code of quiet copy detection with --no-ext-diff' '
>> +       test_expect_code 1 \
>> +       git diff --quiet --cached --find-copies-harder --no-ext-diff $tree
>> +'
>> +
>>   # In the tree, there is only path0/COPYING.  In the cache, path0 and
>>   # path1 both have COPYING and the latter is a copy of path0/COPYING.
>>   # However when we say we care only about path1, we should just see
>> --
>> 2.51.2
> 
> Covering both seems like the right move to me, thanks!
> 
> --
> D. Ben Knoble
> 

