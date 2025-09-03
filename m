Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0EF274FDB
	for <git@vger.kernel.org>; Wed,  3 Sep 2025 09:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756893252; cv=none; b=uIk0+8JYXBVgYR2G6q8oN3tcLNfbOjETsJ+FK6GrNtp4jYLbL8FuiKS+Tbq/lVWr7cPfCxwd6S2MllRyrxvgCYP6H3WeTGhTSItXW6r1A3wgczeLk+20IWTPRBzkcMt5T1F7/sInoux6eI4gLeSLqAydZbYjU8T55WhtUJFh+qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756893252; c=relaxed/simple;
	bh=2kdYN0njFzurCM5gn8tIJ/HCASOqygw39+EDt0aV3uE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JQHoILB9d8iPMPJO8oP6+vqNW6x9GmfKRriAwqgfjf3z1f9rNh8ZLzL/l7qD3sVIVGQNeJi2RvoWEVsdgYBsjBTRUZ3DXSnaejSaOuTwm0xulmsA0yULFRghp2HvNhN0lHlepXeNItZtSwyyCW6/6kudxZ/9bwft2AtCrDVEV14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cKVSRwpT; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cKVSRwpT"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3df35a67434so205052f8f.3
        for <git@vger.kernel.org>; Wed, 03 Sep 2025 02:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756893248; x=1757498048; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hrfFgZSApFzQa7DTXKceLADiRI8Df2F+CVDgva6aaWw=;
        b=cKVSRwpTkDbsfc9JtyB1tl7n0h/bh82yI5DRuMsTLGYvTalsE/m49eFUFKVVYbHc0V
         i7Egap/Sy7FnsbvRLm+Uz5NhOoq7ifqPHw22Qs+cbGcKcLVFJKxNaod6uSAA6V1wHlgx
         N6jxo78fYve4fGi9tLMC8Xj9gSeYkSu//fTi5P/qQYdADkTA3/iqGNirrIe7YoJq71gB
         u5GxrjuankBDBEz5quW0nap9D2x4hkZwG+4QxKsuETLA2tpKh8RgMiQshbAFbs3MhzeY
         ys3294fn8fcodIH9kIn0FvwJMfz7tsXY+EGVYmwOWcSyjhdZwqGjLgMyKvabJ+Zamiqo
         tRcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756893248; x=1757498048;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hrfFgZSApFzQa7DTXKceLADiRI8Df2F+CVDgva6aaWw=;
        b=rC7ml/m4sFv81OsO0REuV04vFfnCGRxGKLzYI2vDRpvhdqiXjX80SM2tbkJX/Bn3K+
         einC3cfISN2UI+aqMxC1eKGWK+urnPXVnwqaQSSiREjLcYmDoK1mWKyd2uhOXTV0V8fh
         yHTpUBoFRyUi9A+hr/Ai6vaG8biIcmsa2oI1CpSsKA0+Z5qFY7SPCnlJ0WkfFgn7J8pO
         XjsiCppARFJqAGUaXeiC23NWa5+TPxAIal0fUKrh090RUY3YCybuoEttX/S9MaOYt0//
         5+YQFFQZyzI4sgxHkJnbpfoMDfRnTnlGjM/SuX11Z6qoxpt4UM6eSQG/PRRz8LTfdEoN
         e9uQ==
X-Gm-Message-State: AOJu0YyVQ03ymLmsK+kQoaXZokAda5Ka2HLR3uOLFPspMvlPgj0TkNK5
	NLR6sBF22mYHq0UKkaHqcE7DK+jaH4RZ54vtFTe2QqejRnwVWni7aiSX
X-Gm-Gg: ASbGnctA3PWUJD2FV4n35ammEs9T7W0GMtsG/N1Rl8Q1uzT6O3jipPl+HHDbOB0Dx7+
	LBzto4zlbFp/EguWCUgQhpCz541yHukOrcSEbIgoMTjjqxmwpAEOZjl5H3OaEgdoGh85KxQr1M/
	eM/PpRoHg8lnAwctCiB5qAjKtXr0IbGrMe4CAyS6Q0PMy3QDuczkFU2i+S92uY3R+5np0P0oipN
	Ud+ptc7p/d5keOCe7GGrOkKhVUB2v5uCX6FErxp+ZpWv5bNoEbt74lgwm95P0ZqNMItGt8ojQ6F
	ts4fGHyA/kT4nXP2q+joLBWgJ19UanPLuUa70EFh3mL+0W3ugucz05CjPG3quCNUpZ0UvI4AlzU
	XixEiO7tV+XCgYU2sLTuzN28ZisWdzo7IUGVXvokkhaXqnPXtAWu27UnDPRBVEdcJLz9IYLNj2b
	YTIBYWiP/b6mS+qG8=
X-Google-Smtp-Source: AGHT+IGJat9FcCM/b1MzFF+s5soCqGEHbzzmWaAzVqB7LenJaVRo6TXMFAkhvdAGq2Q6whb+LHCKgg==
X-Received: by 2002:a05:6000:4312:b0:3cf:1249:8048 with SMTP id ffacd0b85a97d-3d1e05baf5fmr12151029f8f.59.1756893248296;
        Wed, 03 Sep 2025 02:54:08 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:1751:3d01:f738:17c2:c65a:d0dc? ([2a0a:ef40:1751:3d01:f738:17c2:c65a:d0dc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e886619sm230267855e9.15.2025.09.03.02.54.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 02:54:07 -0700 (PDT)
Message-ID: <9d52f24e-d495-44d4-b122-7d80d1f4b77f@gmail.com>
Date: Wed, 3 Sep 2025 10:54:06 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 6/6] breaking-changes: switch default branch to main
To: Patrick Steinhardt <ps@pks.im>, phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Wing Huang <huangsen365@gmail.com>
References: <cover.1756308283.git.phillip.wood@dunelm.org.uk>
 <487d1a33130cb2fafadcf98da00a332a7408a0e8.1756308283.git.phillip.wood@dunelm.org.uk>
 <aLbWuGQhriQCMFbO@pks.im> <96e128d9-e5e3-4bfc-9e33-3caa75cacfe6@gmail.com>
 <aLfHvl5JuttXrI0y@pks.im>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <aLfHvl5JuttXrI0y@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/09/2025 05:44, Patrick Steinhardt wrote:
> On Tue, Sep 02, 2025 at 04:13:27PM +0100, Phillip Wood wrote:
>>
>> I'm happy to drop those patches if there is a consensus that
>> GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME is still useful after we've switched
>> the branch name. I'm still not quite sure what it is useful for though.
>> Removing it makes it clear that the tests are relying on the builtin default
>> branch name that users see rather than some special name used only for
>> tests.
> 
> We may eventually want to remove the whole infra. But I just don't think
> it's necessary as part of the Git 3.0 deprecation and that we can rather
> do it as a follow-up once Git 3.0 is out of the door.
> 
> IIRC, the initial idea behind this variable was to adapt tests to not
> even care what the default initial branch name is in the first place.

When the variable was introduced in 704fed9ea22 (tests: start moving to 
a different default main branch name, 2020-10-23) it was described as 
"This `GIT_TEST_*` variable is meant purely for the transitional period 
while the entire test suite is converted to use `main` as the initial 
branch name by default." The way it has been used is to allow tests to 
continue to hard code a fixed name for the default initial branch.

> Tests should be agnostic of that name and use e.g. git-symbolic-ref(1)
> to figure out what HEAD points to. So maybe we should follow through
> with that idea and start refactoring tests into this direction so that
> they never set or read the variable in the first place.

That might be a good direction for the future. The test suite could set 
TEST_DEFAULT_BRANCH to the default name and tests could use that rather 
setting GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME and hard coding the 
expected name or running 'git symbolic-ref'.

I'll drop the removal of GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME but I'd 
like to keep the patches that switch the tests from using "master" to 
"main". We've converted nearly all of the tests already so it seems a 
shame to leave a handful unconverted.

Thanks

Phillip

