Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0235CEDD
	for <git@vger.kernel.org>; Sat,  9 Mar 2024 11:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709984086; cv=none; b=ehG0JLDDDM9pfX6K+8JCYQLI1bn0h8C9DmeqYo547kaAw7rkrfkEycTseCqvX7R35khWTIYsZjp4QS4EgZch3rwxefD5tcZQbIDAL5gbWU/7doCYVfEtFkqpBW0d+3bmatQlYIqN1D0fUB3K9STzl9I+zb21lXxyqULeL2kbsWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709984086; c=relaxed/simple;
	bh=5P7/nr+VH/H7+C3lL1jUzGtKe22b5ho670hzw11KCJc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CQyZoj9tyXcZSs+AFZOZkE1IIYwAF6lLkEku8FbkJHqOZ+/f3uB82gUzr9TeVNZ4h1qWHKMM8aaZ1Zg6LyhlNTRKq18R08b7/ExXvlSDkAhuK2Cr0Mb0XJI2o9dX948WDYttwu6DVvJe2dEgp0f9fjoc6X9z53gJlSUk03mqH2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M/6cxe3S; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M/6cxe3S"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41317cc388dso10992455e9.2
        for <git@vger.kernel.org>; Sat, 09 Mar 2024 03:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709984083; x=1710588883; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=M80pkxxcfqTIxV1C1LzO11SmxwmejzTlES2YHMQzpgI=;
        b=M/6cxe3SWV6/EFyX/9crSLDuGRqGsZEnZll+Q2bppjulP0pDH3KnksKgL4CfBaohmF
         J7rowNHrVSh2LUEr59s56oMkY6+HED33ejmwg+BWOwt7/XugXDeTv2f5nB3GeO0CwlTa
         Jo/ki9ZFzGikJBetiiuBsVK6gbfUA4/koXlzAwxGJ4OtQKFi+CcQ50HGm5Sxkhxgj6gx
         wP5YJPqJJdhO/F9yMpTmEVe5UbUGgXMYd1F7aYHWZ3nqJmV3zuXEF6uTt6MOZgLfcXZp
         eP62ihZZsUQKz7gHpSuGjZhreuoAyGhVnSoNFi6+41XFy0MLHXa5AHPpuA3N9+N8nQBE
         +Wvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709984083; x=1710588883;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M80pkxxcfqTIxV1C1LzO11SmxwmejzTlES2YHMQzpgI=;
        b=tRAKCKDVsGrxHx/fhnV+VxcHYU/7BiR0FfTG/1Ym3u7cWHrLPHjv0HfMwNLt1EM9FC
         q3ScA2fEpR/wpGAoUQdBLlUS7DRN7osSbteZ7TTvM2lKpyhVDljrUYZqPk2BaZ8MxcJy
         EKPlGxnPHY6c7qID5+W3QPjCSu104BMuHHW3q9lSGjJMXARjgMc/tvRNU0LYODgWWF/h
         FTFycj7y2dpqlkY0ZuCcDvidXSYCqXNntK71ghuvejU8/oAmXJU3mnUpidX+NHDsWcJJ
         GoIoFTgkM0c4kyuYhK4y0Upew26wFXTVTvIXb8gA4Lh/DrIcc43cMosovvCJl03Foaz5
         pMJg==
X-Gm-Message-State: AOJu0Yxel6Ie/EH2DTJAxffaQAnLev0pW98iL0K57KCQp72g2sQ7ek7L
	45v39hl8aioLYbOnd8syUu5ttHhxRb98ANeifvpYOhXPnB1/sZ4J4cTqtugn
X-Google-Smtp-Source: AGHT+IHz9nBKdS1l+J48TdWQMmz7FtgFlbI4Eo9JMFWRSbrl7XoNWU7Ekx/ehe7y3lXhK0AKQOBrmQ==
X-Received: by 2002:a05:600c:46ce:b0:412:e847:a346 with SMTP id q14-20020a05600c46ce00b00412e847a346mr1355679wmo.33.1709984083329;
        Sat, 09 Mar 2024 03:34:43 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:6a5:fd01:d2c6:37ff:fef6:7b1? ([2a0a:ef40:6a5:fd01:d2c6:37ff:fef6:7b1])
        by smtp.googlemail.com with ESMTPSA id z11-20020a05600c0a0b00b00412f428aedasm8804855wmp.46.2024.03.09.03.34.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Mar 2024 03:34:43 -0800 (PST)
Message-ID: <80396270-46a5-49b0-88ed-44c1f48a2b30@gmail.com>
Date: Sat, 9 Mar 2024 11:34:42 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: What's cooking in git.git (Mar 2024, #02; Thu, 7)
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
References: <xmqqplw5ihm7.fsf@gitster.g>
 <f7cd227f-dcde-4d71-b1a6-a4d34c492cd1@gmail.com> <xmqqttlghgqs.fsf@gitster.g>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqttlghgqs.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 08/03/2024 15:42, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> On 08/03/2024 02:26, Junio C Hamano wrote:
>>> * rs/t-ctype-simplify (2024-03-03) 4 commits
>>>     (merged to 'next' on 2024-03-04 at 9bd84a8877)
>>>    + t-ctype: avoid duplicating class names
>>>    + t-ctype: align output of i
>>>    + t-ctype: simplify EOF check
>>>    + t-ctype: allow NUL anywhere in the specification string
>>>    Code simplification to one unit-test program.
>>>    Will merge to 'master'.
>>>    source: <20240303101330.20187-1-l.s.r@web.de>
>>
>> I have some concerns about the last patch of this series
>> c.f. <0947cb09-8b07-4fcd-bbe2-ae37c2cd5ec7@gmail.com> It might be too
>> late for this series but using the internal implementation functions
>> rather than TEST() is not a pattern that I would want us to encourage.
> 
> I actually think it is merely showing the lack of necessary features
> in TEST() and other public macros/functions of the relatively new
> low level test framework.  If a user of the framework needs to use
> the "internal implementation functions", that gives an incentive to
> those who are pushing for the test framework to polish and update it,
> so that such a framework client does not have to go deep into the
> implementation details.  When they come up with an improved framework,
> they naturally have the first target to adjust to the framework to
> demonstrate that they made the world a better place ;-)

I think that's fair - I'll flesh out the details of a couple of helper 
macros TEST_BEGIN and TEST_END for tests like this in consultation with 
René in the other thread.

I do hope though that unit test authors will feel free to improve the 
framework themselves if they find it lacking as a contributor writing an 
integration test would do with the integration test framework. As we get 
more experience with unit tests were bound to want more helper functions.

> And I think such an update can come after the dust settles in this
> case.  It is just a single simple test that is isolated and nobody
> other than the unit-test folks should care about, as the subject of
> test has not seen any change for a long time.

Agreed

Best Wishes

Phillip
