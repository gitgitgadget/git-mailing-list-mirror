Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEE6EEAC
	for <git@vger.kernel.org>; Sun, 25 Feb 2024 16:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708880298; cv=none; b=ZwANYlJJSd4O9EelELIyx3fZSB2GRkpQheHRmzJF1fk9tmhNjXeWkAJAI0s38pzDETXkb3wFlun0CwtXsMY2BG9MlXTJinuQzJGKoEYtk9ulmVU5vIsQJFmn5H5b1HplLKGWvegeUXsLN+zcDknpyTde2RMtV6ouCYKeEelZM4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708880298; c=relaxed/simple;
	bh=8tbODJdc4ZjeeumAcdmuKCgRwIPej2vMcQzFYKWNgZM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=dEO2u+q/cTq/P9n1DZ6pX2e2PR5nzdLGjA/8IJFGuVmtzbNm0ciM6H4G1Ugl8kHNFXua8gQAS2G/prRZvUPxiH4EL12kqaa2bQZvHZERYKlN3Bv2Wk519twMBaMwg7/8X4EdFrF6e4dd2D/wmBOPFvdeOjbr1DTF78XJzmS2IKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LnvAr+Ao; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LnvAr+Ao"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a3e550ef31cso254165166b.3
        for <git@vger.kernel.org>; Sun, 25 Feb 2024 08:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708880295; x=1709485095; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wze5jXmtli1bTQe8ps2S03KzlRP1FvXZSCxV/HrtcDA=;
        b=LnvAr+Ao3a3kXD1P9esnvHg1R70YXIm/HJkVgybfKO5rJm95/N/8/lHaxo7WIH+5Hl
         ohvCEWXTNEisjTAMmfUs8T+ujJRIXE9SGGJEear0vUMoQyLAmzZn/AkGqVu3LRm4t6bK
         b7z7UrRPqyNLHDPwYMhwpr56Zad1aW0MmHatSZAiS/8k4CdbTJHz4cvQY9R1ygbl1wLl
         YbvUALKhNrJqkw39q7PLJjvUQsqZmL7y0ExIA/WKrgLhkBsRcoD7MmMFfaz5MHoh2oPh
         xzjKyAB13o3Ll3DCn6/CPvmuen+Fuf4qNnIWmn2Qugz3JKioj1lglbq3/as0YkLC6Ra0
         RFZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708880295; x=1709485095;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wze5jXmtli1bTQe8ps2S03KzlRP1FvXZSCxV/HrtcDA=;
        b=K7pIUPjWuzUAzZsHgF/euGs7ZphrJMexNjAaLU5pZwnmpWCOCiVCT0vIhUTv+gGM0S
         gR1rlTWK6oBTKZcdCN0cNwI6ca2g/Ez3/u3TQFcpxzIZP3GXEhVM09j9WqhOK7Q057WU
         nXEoNvzQejsilaz7Cp4Y6CgOzGp/sT4MgCWI1kpVNm0GQj3nLLGkzb/ObNgqldP963Si
         dgsZA7mgJL7/Nx5ER/aNIemZRhWv0JCc5k/g4jRwxOhx80q4uasfALT/i1BuXFO0oOh6
         09LyVL1+HKSXJUhjsevhY64SHMW9w+RLa6fU0ahBSSPEq3USFM8jyGfNyAJBFbQQfC1T
         SxJA==
X-Gm-Message-State: AOJu0YxK12IKqUxcDDdUC2xYLNmBDWH8DFGulduv+v5bDx+spt+K6Tie
	StPh0E1qIHDrkf90kGmwifzJ34qPQjm9sS2+K0kEcaUo3DXnRiEt
X-Google-Smtp-Source: AGHT+IGICTkfrvt0YdonfHm5UR6QRku8pd/xMfoQQCyNSpDqGdXIb4D4IDgPqdCYxPFDJVtXdglERA==
X-Received: by 2002:a17:906:ce5b:b0:a3d:7532:15ad with SMTP id se27-20020a170906ce5b00b00a3d753215admr2917639ejb.39.1708880295114;
        Sun, 25 Feb 2024 08:58:15 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:69d:3501:4b27:339f:196f:f7f9? ([2a0a:ef40:69d:3501:4b27:339f:196f:f7f9])
        by smtp.gmail.com with ESMTPSA id jw4-20020a17090776a400b00a434cae86ebsm179788ejc.219.2024.02.25.08.58.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Feb 2024 08:58:14 -0800 (PST)
Message-ID: <f10cc07a-0e77-462c-bc86-ca0452c20a1c@gmail.com>
Date: Sun, 25 Feb 2024 16:58:11 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 7/8] cherry-pick: enforce `--keep-redundant-commits`
 incompatibility
To: Brian Lyles <brianmlyles@gmail.com>, phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, newren@gmail.com, me@ttaylorr.com, gitster@pobox.com
References: <17b669c4bfe6602f.70b1dd9aae081c6e.203dcd72f6563036@zivdesk>
Content-Language: en-US
In-Reply-To: <17b669c4bfe6602f.70b1dd9aae081c6e.203dcd72f6563036@zivdesk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Brian

On 23/02/2024 06:23, Brian Lyles wrote:
> On Thu, Feb 22, 2024 at 10:35 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
> 
>> Well spotted, do we really need a new test file just for this though? I
>> wonder if the new test would be better off living in
>> t3505-cherry-pick-empty.sh or t3507-cherry-pick-conflict.sh
> 
> I was modelling this off of 't3422-rebase-incompatible-options.sh'.

The rebase case is more complicated due to different options being 
supported by the two different backends. Thankfully here we only have to 
worry about options that are incompatible with "--continue/--abort" and 
so adding "--continue rejects --foo" into the file that tests option 
"--foo" keeps everything together.

> Additionally, I do feel like these tests are only tangentially related
> to the tests that actually exercise the features themselves. Notably,
> the setup requirements are drastically different (simpler) since the
> test should fail long before any setup actually matters. For that
> reason, I think a separate file where other future tests for
> incompatible options can also live does make sense.
> 
> Is there any particular downside to the new file that I am unaware of?

The main downside is that it spreads the tests for a particular option 
over several test files. There is also an overhead in setting up the 
repository at the start of each test file.

Best Wishes

Phillip
