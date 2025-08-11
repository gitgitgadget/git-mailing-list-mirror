Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003FB139D
	for <git@vger.kernel.org>; Mon, 11 Aug 2025 13:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754917325; cv=none; b=FLTA/vcp9pfjEzVNBeL9oMfj3LZWXrPrmtTpt28L54k0RjGdFWePoLM3Wt/RZzhO6V5GqdZvUJaASF82vWtEGHS2LSLk/Lyqz9JwLHsY5/TOZILazaZ+SsZMzH4DOexJrq2Xk4YO82u8fgbxdEAwJPa47VeCFXVvldIPo/usbjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754917325; c=relaxed/simple;
	bh=d8rPtw6R4lORKnF/iJ8rQm3CiwgtWAS3HVIur/r3eDQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b2JWohoQsvclOiBRR0hxOmmFinBv9CG9nTlp4kKywBr68j/eWfkzRP3hwAm0SfxEWE3iqXIYCR24TnTSjh5uH66SauY8YKZ1BINBCg4qN81vW+BJtsgq8yy9qZP0yIwiFjQSmPysE14bvLN4TmvrL/os4ud/uxtRcr+jSkBu6u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E5+ujnGB; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E5+ujnGB"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-459ddb41539so13846735e9.2
        for <git@vger.kernel.org>; Mon, 11 Aug 2025 06:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754917322; x=1755522122; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hkpl0cTVKv3KY/dR00IHUAibYlmn1oE+S+hNDuPTsiw=;
        b=E5+ujnGBPqDTA8Bng2oLfW/Z7FTrXKXKD/O7GQuDwOb9Op0tP1423qj1/iVfXOkP3H
         h0XwyUcTXbPNCTZRHaTEkdU/3ed2kQjXoAkDFneXz3cThWz1mZ6BARotKWWAKFtP14/w
         4qjaVD8Buep2nuDIDluLFBjnSpZDJZXUPx5QmOnKPTs1tXyKTtNJoy9E08JK/RF29Rg+
         jvQysph7kbHG2oyodCTRBLJ18A5lDf2mU1eeUE9DKiJTOfr29YTjmxQIYjrJxBCl/oxm
         hFYiltpFb4v9tOhm8r8n6/WAn+i+VAQFisq982d1FdbGhssmzRmDY+1lzvDJXhyumLPt
         4uyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754917322; x=1755522122;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hkpl0cTVKv3KY/dR00IHUAibYlmn1oE+S+hNDuPTsiw=;
        b=FKzxPNXxx97YfPVGEcW2VQ7j89fX6sKJ2HRcsX4FECe4gPMZ8PuqiwUZEg3lwvG8pz
         KjJAAsup6FiYbnqqw93mWRJjUv6oN4kOOcof1CeVS2qy8vqRA/N3NKFTyp4OhnxI3l2T
         rL3K76eGNgeBxZObHCYd1bH2Zjjnj60aaJ+urQaByjfgUKhMpEQuQb8VECpVtpofSkJd
         esKZpG3/k5cO5f5PLz4fEUQ8aFIFoA4Lt1et9u2GQhlMRo0XvVur5H3c5ddZxdUURv+O
         iKftsYWKuSQvRC7eBXBHNJ/6XhQyHb/RJHqkqMh7kM7jyql85SOz0/QXNCLt93piYlpn
         +nhg==
X-Gm-Message-State: AOJu0YxIKRD/u8iPj+gHzNHQwJWBbHC0XtfWbR/Cts3QP4kEmYTnkz+0
	e+h7mbXz3yXAot5wA5HQ7RBH4HE1UeN/VXgKhYYn01QfXWwBpgEetg2LSWwsAA==
X-Gm-Gg: ASbGnctNkBYZtmCkqqqviC5zhBfMfZ00oJkjK4GiFlCLRugTsJRLu+vl/lC3UtIvduC
	rvhy5YO8d3C3DdogiGoDIgiegr44e+Et/VlNhNiY8YFc6ti3ibT7ah+Vz58n4V6hn+2GCjD4qIX
	9IfPgEykYN3KozbSoZqDF1ueeLnCv6Eozm3RNng5tiQefsiYyKb7FkKxgXbiXdxXj9PuFQ7c+Yr
	e1JrJWX8vYeLa5GV+p3m+P2KFyFaiQ6fbkOwKXReJGEkpv5njXwXz741pVn56n2DzIcHAVNYGu9
	4+mQwCUG2dkRnBBZtiJwn4ERYMMyUvYIWbFHWRtqvmpISFy5nKFNn74kStjHBkve4WNILRoAIcq
	xMB2MYUdClQzdWbwL8q0w8dJUIs40auAdxGttYhYUwZnjoW6+BSTm644TjhnQWGzPOCFjkkOez2
	BQ6AYsm+Q=
X-Google-Smtp-Source: AGHT+IGFFztx7wt3VdRFh5xN24Ym5eur+hTZ07BXDpuSYQ0U0NJA4EVDGb/abqexQ1uj2myQVTqloA==
X-Received: by 2002:a05:600c:1d01:b0:459:dba8:bb7b with SMTP id 5b1f17b1804b1-459f4ecf85cmr118442245e9.13.1754917321889;
        Mon, 11 Aug 2025 06:02:01 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7a5:4701:9bd8:62f6:3085:6ee3? ([2a0a:ef40:7a5:4701:9bd8:62f6:3085:6ee3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e5868fd7sm271509165e9.18.2025.08.11.06.02.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 06:02:01 -0700 (PDT)
Message-ID: <14d6589c-87a1-4d08-84c1-a9398f6cb8d8@gmail.com>
Date: Mon, 11 Aug 2025 14:02:26 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/5] doc: git rebase: dedup merge conflict discussion
To: Patrick Steinhardt <ps@pks.im>,
 Julia Evans via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Julia Evans <julia@jvns.ca>
References: <pull.1949.v3.git.1754693552.gitgitgadget@gmail.com>
 <pull.1949.v4.git.1754702057.gitgitgadget@gmail.com>
 <061790686b9036cf862c5b918126eac1ca02a79b.1754702057.git.gitgitgadget@gmail.com>
 <aJmtzfuibPwS1WVl@pks.im>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <aJmtzfuibPwS1WVl@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/08/2025 09:46, Patrick Steinhardt wrote:
> On Sat, Aug 09, 2025 at 01:14:14AM +0000, Julia Evans via GitGitGadget wrote:
>>   
>> -It is possible that a merge failure will prevent this process from being
>> -completely automatic.  You will have to resolve any such merge failure
>> -and run `git rebase --continue`.  Another option is to bypass the commit
>> -that caused the merge failure with `git rebase --skip`.  To check out the
>> -original `<branch>` and remove the `.git/rebase-apply` working files, use
>> -the command `git rebase --abort` instead.
>> -
>>   If the upstream branch already contains a change you have made (e.g.,
>>   because you mailed a patch which was applied upstream), then that commit
>>   will be skipped and warnings will be issued (if the 'merge' backend is
> 
> We lose the bit about `.git/rebase-apply`, but I don't think that's a
> bad thing. The user shouldn't have to care how exactly a rebase looks on
> disk.

Exactly, we don't want to encourage the user to poke about in the state 
directory. Also ".git/rebase-apply" wont exist unless the user requested 
the apply backend so mentioning it is misleading (the default is 
".git/rebase-merge" these days).

Thanks

Phillip

