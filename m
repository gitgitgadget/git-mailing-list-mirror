Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488941D0400
	for <git@vger.kernel.org>; Fri,  8 Nov 2024 14:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731077633; cv=none; b=BdWGrwo9PrDbekd1onYqAt4P3RTgvgvnB3CxsdROlpsEKlE913CVXPfrhQF3Pi8h1iH2aJ7ZZXr/wMZyPpwvZgxVNRTdNxyx17oQtjFNCIe1A3AA6BXk3RNubS4SC732fKfhk2o7uuvYX8Wv+g8QRODC7UVY8GUHiFQBgVyM4Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731077633; c=relaxed/simple;
	bh=kCBLw7L5sNBmAAuOCsw1FOqqjc3chxrBmBfivtGC31w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eGwTNCYu30qPnh1sLwT2AkeylvmJdIgVYsZ6pU/qMnZxV0WPcQdlyywj5OkczNcyC50ZEBEjOWcl3MiD3d/JARwT1A7D61R0IxeuT1ppW7TfgZy6NexTUeusK3YUeoHBF7PxRqOLiXoH5i5pRGTLW+zBLsHE374GG5P2xO6zGPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uqxj1UPS; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uqxj1UPS"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e28fd83b5bbso2501144276.0
        for <git@vger.kernel.org>; Fri, 08 Nov 2024 06:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731077631; x=1731682431; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rRlRhHXpf9XqSvkhUfW4l/IODH0qB4wfNujVuj0kCw8=;
        b=Uqxj1UPSdViQRWdTIQ9ZjjDuSLgaUcE75eVnYYXo+r5a+ewaA7L3+Uv0rmUhyf6/Lu
         Ox+hmX/nE9dBs8bkVpm+7A8csRQsC/5tYGyttLDQIEPVRRtpiw82ya6v1BeMqWd+hK84
         wqGYeNb4nuvAKbyb/vZYTXAQ1AgDgqxB8UlXmgNY6Soh/hXNwjTJVQ7gxZ+b43DlIxkJ
         9Z4616IYUz+xaSJ7HdPLy+DF/Zf3NxuFwJTC4g+Emt469IVO7Gnck+hnli2Zb4NwxZuW
         CL+GYUyHBf707D+tJoeI4kvqtwa6sNoLnPAX6G4BW/jpWQ8MPY0KEZU4wfPVS6MI9JNF
         qC2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731077631; x=1731682431;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rRlRhHXpf9XqSvkhUfW4l/IODH0qB4wfNujVuj0kCw8=;
        b=CzUDU+bUBVyO8fNlJTtinFdXLiIkBSjcpM0tiqSHGYfkUEmoMm4DKU1+54d9A2vWaP
         fAqJ8/JFrmAA1d7hUPIqvB/0aF0x8uwrmQCZAJWIdx0AwXGVpyBJgOqWoYjdR4QTksKL
         Dr0nj5g1H6Xo7rnDQ8Eoe/bpGfoXro9AD8WEaPvhY1/TdtCC1AT8FFEb9SVx5gyfsJz4
         XgofEekOJtXh4ULsFq6ILVEoWc3WSFpJexfOIZEcMpsnoQD1EsOH6i38e17EesibQn7l
         EAgmmnxSEcCGwnnpImZHSEx/7e/by/VrJA7fsf/8CJN+xh8AW646ovJzJfMHvJROyEP8
         5M3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVAEs/DyxmQ4f/BwBhN9hO1p35tn7XysICCVp/wU5x0okTGcg8GMN6hDmli+soEZOXunZA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx99bBxroWm1HFwFnErrq2GnDyQDAGaXcJ16VqWJjiP3coaVLzl
	tlT7f3HnjBrSJMpCs+dYBODOBW2nQjQxwrTwaZvZKI2XJsf+CA9q
X-Google-Smtp-Source: AGHT+IH3IAwZAIRLOPf2FmP9OS42G3kiv7ZnkLIWuJnWANjuTK07XXnZeapH/qCxUynC5fuT5lsHZA==
X-Received: by 2002:a05:6902:1509:b0:e30:cac7:5b92 with SMTP id 3f1490d57ef6-e337f8446c4mr3324296276.9.1731077630568;
        Fri, 08 Nov 2024 06:53:50 -0800 (PST)
Received: from ?IPV6:2600:1700:60ba:9810:cdf0:7186:dd7d:aa91? ([2600:1700:60ba:9810:cdf0:7186:dd7d:aa91])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e336ef2f52dsm715582276.24.2024.11.08.06.53.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2024 06:53:50 -0800 (PST)
Message-ID: <5085b96d-4757-4ace-9610-baa21c05bf4d@gmail.com>
Date: Fri, 8 Nov 2024 09:53:48 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] t6601: add helper for testing path-walk API
To: Jonathan Tan <jonathantanmy@google.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
 peff@peff.net, ps@pks.im, me@ttaylorr.com, johncai86@gmail.com,
 newren@gmail.com, christian.couder@gmail.com,
 kristofferhaugsbakk@fastmail.com
References: <20241104233912.2493936-1-jonathantanmy@google.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20241104233912.2493936-1-jonathantanmy@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/4/24 6:39 PM, Jonathan Tan wrote:
> Derrick Stolee <stolee@gmail.com> writes:
> 
>> The biggest question I'd like to ask is this: do you see a risk of
>> a path being repeated? There are cases where it will happen, such as
>> indexed objects that are not reachable anywhere else.
> 
> I was thinking that the whole point of this feature is that we group
> objects by path, so it seems desirable to test that paths are not
> repeated. (Or repeated as little as possible, if it is not possible
> to avoid repetition e.g. in the case you describe.)
In addition to determining the order of the batches, it can be
helpful to demonstrate that we don't call the path_fn with an
empty batch! I discovered this while making the appropriate
changes today and putting the fixes in the right places.

Thanks,
-Stolee

