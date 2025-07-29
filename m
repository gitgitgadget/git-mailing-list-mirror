Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52B5287507
	for <git@vger.kernel.org>; Tue, 29 Jul 2025 12:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753791587; cv=none; b=qhw5RviJGwCCZ+1dFkb+MYe0u6wmbM0AUb3loh4LQuVRLFt/60nHOgAL6FNRaevaORImTgaIE1ip9XoE/hg5oE1pRYi6al6MAvtJYv6OpkTBupauHS08v19LLxbs7AaBuae8J/gJHTRjUtmQJvpyaDmmWVdRGZWMe7LOkRhsG28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753791587; c=relaxed/simple;
	bh=zHbPXAizDqrhjGVIoqXbP6VNTkGNMe+MucQO9ki/RNE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=boDIsbcnkdv4Y+zKqkAGTo2w8+KGcVHpMfQUsKux74JFAvWD7DIHt21iMptBQEtCwBzS2NdrH+wj6O833nCSIMQmThDlE0vIy7rWHgAl/qMKoDFPyDQkFjbQvazF38jYDJY24/5BueqbYsZ6sUlaRS0+Ci2nHzvcWdDwkJrq1a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eD8OA5nx; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eD8OA5nx"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7e33d36491dso752975185a.3
        for <git@vger.kernel.org>; Tue, 29 Jul 2025 05:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753791585; x=1754396385; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rt6qnEIrGwA/BxvQM/fHeVHdrN54G7aljtTgyTjYI/Y=;
        b=eD8OA5nxcIDsb8o6qw5Yj0FSqfwlIJW2SPnL764kCP9vYKEROgl3kI3hKJgStX5R+L
         n4mxPAoEZN7B79pl3dJZDIdpJhPtbkfz/HHaqEUOfhidyH7JbbEkXi39GN7F660KD+t/
         WI7R1UvNUnFx7YJmODuvwYl5X3OjRXdMe8RN1kjCvSO79anq8gUBuejJgswpQzXVHY2M
         4Jm9ESEphCP2qv11lAc5Pu4/yc6yNhEEfKcszxKvCr015Czu86dEtvirEH9EZsPAHnZQ
         k7o6Zf1XN3IX59deROPb0721pffn/vpRgjfgCDlkVF1eaH7qPbeZOxSLv8lB6eyvsPK9
         viCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753791585; x=1754396385;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rt6qnEIrGwA/BxvQM/fHeVHdrN54G7aljtTgyTjYI/Y=;
        b=B4HOqeCwQYWjlSMCTK9y34EmNT60YNjpxsb/oTxcAtwEkZ5F0d2u/WU0iaYYscVLCX
         k4U7yovLmKp5kFbPwLGtP5idFSuBMZoeACcTLTW/iLbAPhLRcvvKWL/7mfBLz6INm3TA
         NX0nJheZIad3mEBRAuxqJ7Hrq5EdE64KKhSwWMaI0kq0RL9lZj+DHJJ0TBHgQTsOyGJc
         75kbtWZRVO2ZFOUjy3jY55S1Cs2hIySH1eUJ+HoBYokNIfkEPz7ns81IWj8/21q+gEwz
         +JlbTWDkv7n04UHqV+L21Sf3gsQ1amiaE50/d5KyHfBDYiWqShvj0s3abOM3j5UF96Nn
         Ot6g==
X-Forwarded-Encrypted: i=1; AJvYcCWpiqM6YS1KPI1lb7Ej+9A7GAWM6X9re+TN64BCtqPNktuCyyHeRHr70wxNhOlYVB619y4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW9nUdaKDEkcvfcdDL61fHxG+WInm81ux9wDJ9HG3/mGbYckkt
	DZ0wAuG8JwrQHvZhiFVmq4LtGphjebNWuytLCkQpdioJq0x8//ALyg4K
X-Gm-Gg: ASbGncs6TfTmDEoMXlRlMtSD7utyBFthqPW20LhJgy0MVR8zTv6LOCRl82PXcqbXtxo
	N9CxwvsIusxIrAU/xJ7O0YxmDBN1zuDCA4GV27w6M8FgihkJXyZYCmBNXkQ2Q4qTMvfTB5ZW7bT
	fG3LcJXzHEUrAYyIesjKSwOcVGnj8JRL8WzUCoMvDekZ240a+mw5ws0nDEcuXS+3PbX1xKtpO22
	lWzju2OPILx6UUm4kviQvYarXkst5ej7qcQyg1Hegf401qrF76cB6YfsnkqXeA+0vX6btzigBba
	aK7l6R8zu6ad9chqXdbdgPMUlvI38zvbIgXpT1OJjGGz+vo+WYHntf8KwAMB2QRA5ZI5RVuqgy4
	gTu3uI8+WVGsCUqHbuhz5GCmWrOe2L7s0CG4lF+BuNlKnJds8k0Sews6oqLOdXjr6RFB/P+w5Em
	SQblsJ33CKAw==
X-Google-Smtp-Source: AGHT+IFRqcgw6PPOIEdZXR0jeCXtIYR6GgUT5vE5QYPJthAfNM1aN2fM9xddO71CvP78nTkQdir1/Q==
X-Received: by 2002:a05:620a:4495:b0:7e1:9769:97cb with SMTP id af79cd13be357-7e63bf64f1dmr1877152685a.19.1753791584473;
        Tue, 29 Jul 2025 05:19:44 -0700 (PDT)
Received: from ?IPV6:2605:a601:a6de:d300:ac0a:82b6:9e90:e62e? ([2605:a601:a6de:d300:ac0a:82b6:9e90:e62e])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ae9963c2cesm48929321cf.41.2025.07.29.05.19.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jul 2025 05:19:43 -0700 (PDT)
Message-ID: <a78f4d66-f48c-4ec8-a9e2-cc8443b1d247@gmail.com>
Date: Tue, 29 Jul 2025 08:19:43 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GSOC PATCH v6 0/3] environment: remove sparse-checkout related
 global variables
To: Ayush Chandekar <ayu.chandekar@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, christian.couder@gmail.com,
 git@vger.kernel.org, shyamthakkar001@gmail.com, phillip.wood123@gmail.com,
 ps@pks.im, ben.knoble@gmail.com
References: <20250603131806.14915-1-ayu.chandekar@gmail.com>
 <cover.1752882401.git.ayu.chandekar@gmail.com> <xmqqcy9qlfm8.fsf@gitster.g>
 <43aaec10-2696-44c9-8728-2045b83dc5d3@gmail.com>
 <CAE7as+bnG6KgA8X_n36pqP15bmyM6re+xEb1MOXKvZSUdJ8Arg@mail.gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CAE7as+bnG6KgA8X_n36pqP15bmyM6re+xEb1MOXKvZSUdJ8Arg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/29/25 7:36 AM, Ayush Chandekar wrote:
> Hey Derrick,
> 
> On Thu, Jul 24, 2025 at 6:55 PM Derrick Stolee <stolee@gmail.com> wrote:
>>
>> There are two ways to change the approach here to fix the problem
>> of needing prepare_repo_settings() everyhwere:
>>
>>    1. With the idea that these sparse-checkout variables are
>>       critical to the functionality of the repo, they should move
>>       into the repository struct itself and be initialized along
>>       with all other values there. This changes the patches (and my
>>       follow-up series) significantly, but mechanically.
>>
>>    2. If we are going to change the intention of the repo settings
>>       struct to move from "optional one-off feature flags" to
>>       "important information about the core behavior of a repo"
>>       then we should prepare_repo_settings() when initializing the
>>       repository struct.
>>
>> My preference is (1). The only argument for (2) that I can think
>> of is that it is sometimes helpful to share only the settings for
>> a repo without sharing the whole repo. But that seems like a weak
>> reason right now.
>>
> 
> Okay, I agree with your points. I can maybe send a new version to address this.
> 
> Do we also shift settings like index.sparse to the repository then?

For now, it's important to focus this series on the globals being
converted. We can come back around to the ideas around removing
the settings struct and the prepare_repo_settings() method as a
separate series.

The index.sparse setting is something that is colocated in the
settings partly because of its interaction with feature.experimental
being handled in prepare_repo_settings() but also its very isolated
use. The sparse checkout globals are much more spread out across the
codebase.

Thanks,
-Stolee

