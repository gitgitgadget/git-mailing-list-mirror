Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F9320C477
	for <git@vger.kernel.org>; Sun,  5 Apr 2026 16:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775405439; cv=none; b=faHLSm20Kn/ELXPdcZ9TlQmkDlSW8F8QJMI4xp+LuBbtf3MM9a3qiFHlAL130P5P7i6HNDwTQjkGTW/Qb9h7n2q3lDg+iYHf3BsBJA/yFEUGGRVgwjcc8mg8y/hBv0XP93vFwaYqduJyNryKVVb4KvnX4kkfLg9PI2o8e72ix/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775405439; c=relaxed/simple;
	bh=X/0DAeWcV2asmF9OWi+rrL49fUPBlXMnzfdhCq4b7QE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NErKbzClUJ52EkNTwsLMDT61g4pI/OwqJ1DAcJ+0QHQ4VdkvTLbwhnA/OO6znUfz0+/7FbMSEJJ7YsFcgg99Jw2toGWAB7DJ4nfp8WN1o6UllxIBpja/9v/aXbaBPh83rilPEhd/qTthnCqrK3P1/2CjdCntCfVZMZ1GoKAiLpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YsAQDJ4E; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YsAQDJ4E"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4853c1ca73aso33403025e9.2
        for <git@vger.kernel.org>; Sun, 05 Apr 2026 09:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775405436; x=1776010236; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aDlgVl37iSbKYa7pMt0y7Bb6R3f8cb0c6saPHHNEHTo=;
        b=YsAQDJ4EZu4QVl+JmMv/14zpIApvkAgGs2umBwilxSfZQZEQgSntiPRxZz3Vl1bo5t
         344+qo6AWXxjYrmABTclORKGhH4wF8oKxVEOQ1sNJl1jbQORwrWDZe1883ZvIJKfhK4e
         KIBP7W4Ipv+T+VZJyes6EhxED9Jg0yjG1mnc7ljHfcOe4WJT1euYiUitQmZ3j3DPHiqW
         8D7dJ+rE7dpYaYdLuH4iAs/YHPOdC6+LntwtFJCyHXUtlvIXgOI6wGy2n7qEv50xgGHe
         wv++WvISnZCMoa360AXIq9EfzgNwC+qNDRVlgKmJo8owwpNHVmuWmFNn1wts+P1+OPJ1
         aHBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775405436; x=1776010236;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aDlgVl37iSbKYa7pMt0y7Bb6R3f8cb0c6saPHHNEHTo=;
        b=ZWy6iF03u7VCAUJjzc4nQDfzqGH4szDabJZguBzwK46g5a7DDMlX1Qf1rY4WLpWl6L
         DcAgoF2EE9ThtzfT482xaaE01Ic31fuTcmfTkTZ75hT37O9eLp9CoYU6p9u7Uu4sGQhm
         MpEDhvcBK8AFBjQFXvHgbcsiglxy8afUD/A9eYBIsWkGQm54/vxiw8QTBKcjgRFAYirt
         b3GJAJBY7PoZBp44vTLf/8GlSFOR3cHDMC2lAfU8G4zvhvspHkRU/0gWOaW8slVfMFtI
         N5KZVv26tADCkvjA4lOi/gOonrcd+iUElR4stxDCeXNMSOamwpha0XebkRUKhk4R6O+Z
         xSIA==
X-Gm-Message-State: AOJu0YyZHIyqdt3U44b8XpXNlNlQXGjbE04W5RvgpmkDvtXtFJPeWHwx
	VabpomOctcM9QD5kq+WDQ5knWhQ8hNY3RiTqoYGLfClFxHkI5AH04q+B/AKzpg==
X-Gm-Gg: AeBDiet3+DBivHAUua4kV+GFWrlJuFvlkc2fPlZCpTCPnw/vqVnsPMsDCRgi3dMLc2w
	BJamJVtC//8D0+n6UPUhPZy4r2o1lJ9sWO0TBKbdY1f8JdQwPoRnebZ9BFgZ2uFF8CR8Rk6+o54
	5Yxpj65iDIxzt2Ekk4oAqYWA3N0dlpuTSa+uHv02bCufu8bGjU2fJPmaScqrGSWRlOZ4OsCVAdF
	xLE3tQWN/oTcFIsLxJcr5GgNzWzCfPYu+tYvRnmP7RpB6fb3WcDHTIoGFc/t8MQTftkfxxSqW3J
	TsNwEsoFpBUgNP5BI3dKk/fbWjwEikiCR5VG/Avqaxkvh+YivXFVwZdz/TDrU0tZiYIYA1jjaNK
	h7EbAgDDox3meC+kGsFPJQ41XadmG8rtJcTbdTBaLkGmQ2cNyS9kHT8ynrnG23dfpQzCmblLwGM
	Gq4zQf2TGXNEuPot7WooInzfCdmehqaWDh1g6mfw==
X-Received: by 2002:a05:600c:6305:b0:480:690e:f14a with SMTP id 5b1f17b1804b1-4889978c561mr141078455e9.14.1775405436254;
        Sun, 05 Apr 2026 09:10:36 -0700 (PDT)
Received: from [192.168.1.132] ([185.51.136.249])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488b0c53a27sm23417145e9.7.2026.04.05.09.10.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Apr 2026 09:10:35 -0700 (PDT)
Message-ID: <145b6c7f-c037-4a87-b561-d2b4d8c5a0cd@gmail.com>
Date: Sun, 5 Apr 2026 18:10:33 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] object-file: don't use object database without a
 repository
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, cat@malon.dev
References: <20260404172817.2995133-1-luca.stefani.ge1@gmail.com>
 <20260405064651.GA1452907@coredump.intra.peff.net>
Content-Language: en-US
From: Luca Stefani <luca.stefani.ge1@gmail.com>
In-Reply-To: <20260405064651.GA1452907@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 05/04/2026 08:46, Jeff King wrote:
> On Sat, Apr 04, 2026 at 07:28:17PM +0200, Luca Stefani wrote:
>
>> When running `git diff -- $file1 $file2' on large enough files,
>> index_fd() attempts to use 'the_repository->objects', assuming it
>> is initialized, but that's not the case for non-repository usecases.
>>
>> When git diff is invoked without a backing repository,
>> INDEX_WRITE_OBJECT is never set in flags, meaning only the hash is
>> needed and nothing should be written to the object store.
>>
>> Enforce the use of index_core() in this case.
> I don't think we want to use index_core() for a large file, though. A
> test like this:

I don't know what would be the right approach, index_core sure is slow, 
but maybe that's expected for those sizes.

This fix by itself simply avoids entering into the broken case, and it 
still gives me a working diff.

> diff --git a/t/t4053-diff-no-index.sh b/t/t4053-diff-no-index.sh
> index 15076dfe0d..7ef5604430 100755
> --- a/t/t4053-diff-no-index.sh
> +++ b/t/t4053-diff-no-index.sh
> @@ -413,4 +413,10 @@ test_expect_success 'diff --no-index with pathspec glob and exclude' '
>   	test_cmp expect actual
>   '
>   
> +test_expect_success 'diff --no-index on a huge file' '
> +	dd if=/dev/zero bs=1M count=4000 >big.file &&
> +	echo whatever >small.file &&
> +	test_expect_code 1 git diff --no-index big.file small.file
> +'
> +
>   test_done

If you want  I can send a V2 with that, but given it's your test suit 
I'd rather you handle it.

Especially when it comes to multi-arch, as I only really care about amd64

>
> will now fail on a 32-bit system, because we try to mmap the whole file,
> which will fail.  We really do want to follow the streaming code path
> (which knows to respect the lack of a WRITE_OBJECT flag and works
> without an odb in that case).
>
> It's kind of an expensive test, though, so we probably don't want to
> actually include it in the test suite.
>
> -Peff
>
> PS I'd expect a 4GB+ file to work, too, but it looks like the diff code
>     barfs when trying to stuff the file into a diff_filespec. A simpler
>     example is:
>
>       dd if=/dev/zero bs=1G count=5 >big.file
>       git hash-object big.file
>
>     but that dies, too! It looks like the streaming helper uses a size_t
>     to take the size, which is wrong. It really should be an off_t. So I
>     dunno, maybe nobody cares about ever working with 4GB files on 32-bit
>     systems these days. It still feels like we should avoid a large mmap,
>     though.

Ah I I just happened to have a 3G file and I threw it at 'git diff' :)

With `#define _FILE_OFFSET_BITS 64` off_t is properly sized, but if 
other places downcast it then there's little hope on 32bit.

Now even with that in mind not sure if it's worth fixing...
