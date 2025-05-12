Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E537293B6D
	for <git@vger.kernel.org>; Mon, 12 May 2025 18:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747074544; cv=none; b=jDhJ6qT76Qd595Cn+3s3BFesJfnZ1N5Pvay5UY1BDuayxAvWIVVKjJo+jzHQG84UmCF8M2YEGLaMXHKs+Eo/kX9RuMVsYIqeE3t3DN7D/bxBlF9ag5cv77bGtUU8iHMmPl8aKW4d6yTv5P+QiIfVmkJAZajo9O9i/MWkVs3Ipjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747074544; c=relaxed/simple;
	bh=DB3SWLx7fPstui3QZElZGPPEQxsTKT+0KE53GRsEECU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E+0xT+hPV2nVVlW2YFGQGF9zUAKUGZ40yDcP1EQmYWOhJKFpRrDKyEzJhPPyYZnOTi0vxG2kFRFozf1bKArTNvVOuEOGtshNmpvniiLyJ3rpo/d7zoa6GAV2EGyeQwPor0V/8QSqdecPFZ6JV0LTCkgh220s7DGtQ7+v+8DWAzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YkjCB1pD; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YkjCB1pD"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7091d7244e8so44948737b3.3
        for <git@vger.kernel.org>; Mon, 12 May 2025 11:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747074541; x=1747679341; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NO42A7HQQYrDB2E+iZQCssrhFWsWIHk8G2IT9E2JffA=;
        b=YkjCB1pDtuxE/WK2XDSQi+c8gTWMlrbXMNrQVsI9/G9aNTd1DDMCpGPmRtjjfQFqsq
         HXUj95ZxedIl0bS8M1GFy9+vUHU0Ma53rhHpfspb5XzQ2hH6ncdh5an0KaMh4WTSGKpP
         0fuqYVCGuPob8ffy7+V9rXhepBwdM6B71Nh/2vN2/GBwxOjkZj8C8UzNd8LG0dHXf4Uy
         Mc/bEEfxsfZpalNPUYGnTXtis1nqc8IENyCxBxZY07akgfprORaPNWdYdMGPiCTK8ys/
         WbzZlhiTC+B4Kd2Wl7Wm3pnVe94EkkklXFt5Ax9puOkstI7F5DGb2Skam3XUBvrCpdsl
         G/EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747074541; x=1747679341;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NO42A7HQQYrDB2E+iZQCssrhFWsWIHk8G2IT9E2JffA=;
        b=CbO6dHl+bYYxEr0LF61hGPUZvLEiznxG7W601+gIE5VdAL9F+Otk1n54bke1GmB6UN
         Zmokfhmmcfzp+hV8Lq71eT8BYGawkisg2HslWhumdSCbsa8HOB0+ZYnD5ubpxmQSWKDu
         220EublDRq9BtEb8OTUGxvWEHhI5krivRJ4Y2iwcXcKLPP3GzYMIOu3mUDCrV547WwUt
         e1rlBQtFpE0LJ3pOxdVuyGCKS0YpUzJwA3WuWq2IhfiqE4Pzi1xcBJtNjTpE7mGcaCJG
         yDepHSULzQGWd+w2D24Jc8VsbsjMj1vkUr/0O8upwgluWLSePIChi1766HPJitslHuPW
         U+Kg==
X-Gm-Message-State: AOJu0YzIX2d7yLLMIoV+Kvevmb/+hMA2zSR8W+2E3mjn6DIhWKbIyKhv
	brgVs2UPg1NXC8DdILgz8nGk/7Mv5FG2Q4mCJmwtCXX5eX5Y2BMGq3YPeg==
X-Gm-Gg: ASbGncsPrP4W29f98/anbcHa0ZrNv1uWtDD0Yds9iyI7oCfX8nukWIbC+nBUVEBWJDr
	vtvrSF0kiNEOKIZs0UHav9TDK/6ZUGAInfMdDKcbzgaKKqIPQwPeIHijHfwQF+mDq2c+HLlba9w
	f4DtNUy6/w0nAutOn3M0UqF672RgytERbS01pSWT9PNPnjr0zO2hp4IUIwXT1PD0YlcXZG2k1q8
	/4mhc7um/VDJ74LYFIVTJ68p2Rf+f8qnxO9wc7+j5tkCiKd7UHBgu1cnMpWipGM0XCquwEjRgYV
	cXHe4AHQcjzG2c6dXjnTe6imhwSYSQsFdDQlMepK3DKnSl8LfT900jQHoqTSy7Oux3N/nIHV2iH
	29uKewVnmCBpBpDzMao9CCX6tmUfafEQ19cVXEmw=
X-Google-Smtp-Source: AGHT+IHosk7HLTDRWUROZyCkhl6tL1ujZ1oI7VduX3t28vYbrlysNK+vUAEL8P0m4w1FeCLs+jRc8A==
X-Received: by 2002:a05:690c:6f81:b0:6fd:a226:fb50 with SMTP id 00721157ae682-70a3fa25787mr197733567b3.13.1747074541010;
        Mon, 12 May 2025 11:29:01 -0700 (PDT)
Received: from [192.168.1.237] (70-237-88-18.lightspeed.rlghnc.sbcglobal.net. [70.237.88.18])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-70b74314786sm2127057b3.91.2025.05.12.11.29.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 May 2025 11:29:00 -0700 (PDT)
Message-ID: <35622599-c127-438b-9646-591bdfa7e1ae@gmail.com>
Date: Mon, 12 May 2025 14:28:39 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/17] odb: get rid of `the_repository` in `for_each()`
 functions
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
References: <20250506-pks-object-store-wo-the-repository-v1-0-c05b82e7b126@pks.im>
 <20250506-pks-object-store-wo-the-repository-v1-9-c05b82e7b126@pks.im>
 <d3524839-a982-4be3-93ba-c35fdde3726f@gmail.com> <aB3mKS2aSQMKB0xo@pks.im>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <aB3mKS2aSQMKB0xo@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/9/2025 7:25 AM, Patrick Steinhardt wrote:
> On Tue, May 06, 2025 at 09:21:15PM -0400, Derrick Stolee wrote:
>> On 5/6/25 7:09 AM, Patrick Steinhardt wrote:
>>> There are a couple of iterator-style functions that execute a callback
>>> for each instance of a given set, all of which currently depend on
>>> `the_repository`. Refactor them to instead take an object database as
>>> parameter so that we can get rid of this dependency.
>> ...
>>> +/*
>>> + * Iterate through all backends of the database and execute the provided
>>> + * callback function for each of them. Stop iterating once the callback
>>> + * function returns a non-zero value, in which case the value is bubbled up
>>> + * from the callback.
>>> + */
>>> +typedef int odb_for_each_backend_fn(struct odb_backend *, void *);
>>> +int odb_for_each_backend(struct object_database *odb,
>>> +			 odb_for_each_backend_fn cb, void *payload);
>>> +
>>> +/*
>>> + * Iterate through all alternative object backends of the database and yield
>>> + * their respective references.
>>> + */
>>> +typedef void odb_for_each_alternate_ref_fn(const struct object_id *oid, void *);
>>> +void odb_for_each_alternate_ref(struct object_database *odb,
>>> +				odb_for_each_alternate_ref_fn cb, void *payload);
>>> +
>>
>> Here's another occasion where we should be careful about how we rename
>> an "alternate odb". What is an "alternate ref" if we have different 'odb
>> backend's (or slices/shards/odbs etc.). Should we be updating the term
>> "alternate ref" here?
>>
>> Changing 'alternate ref' would be quite difficult seeing how it is based
>> on the 'core.alternateRefsCommand' and 'core.alternateRefsPrefix' config
>> keys.
>>
>> Perhaps this is motivation to keep the word 'alternate' but as a way to
>> differentiate the repo's odb from ones it is borrowing.
> 
> Yeah, the next iteration will call things `odb_alternate` instead of
> `odb_backend`, which I think makes a lot of the terminology fall out
> naturally. The only thing that may be confusing at first is that we also
> have a "primary alternate" now, but I think that's bearable.

I like odb_alternate over odb_backend. Thanks.

-Stolee
