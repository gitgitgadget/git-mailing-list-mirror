Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A184B1E4A
	for <git@vger.kernel.org>; Wed,  7 May 2025 01:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746580879; cv=none; b=Tw99c0dmL8CU4KyRmLLFrqZ6rzKfHeC6olssVOgCm5nOaarxedtrW9ZegWVljZrL8ggQ7XOBchY9wRZUBYo5Zbj0MAF9qOy/wB+5YWuXcCPX1kvZd+1+6WDNyNkNAHX0CPGtp/UAqMG7EyOykHfNtZws+B3/Da7sJ0tMv2Vsv70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746580879; c=relaxed/simple;
	bh=mFDnQ6WFbVu5X6RjoafAL6/tDDai60vdC8tEv22WhYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NOwcgremyWVKziedO4Kf1gXtu804CrEJTU10EsTQG6Gmw+1RNA74u2o0AJ12x1sxkghtegUpxa2py1ze5sIAsLz5TaPMooRRqsoCJocl4l1sokZ47SxRPjEkE/rN0fJTlLMZlPrWDIWfJqFlJHnRibTazgTReoRqM2by2BI5AHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GGygWMqc; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GGygWMqc"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e740a09eae0so5449149276.1
        for <git@vger.kernel.org>; Tue, 06 May 2025 18:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746580876; x=1747185676; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Rx697ig75IycjVbEDf0H/O/EXjQ0pexJ3yPNetEztWg=;
        b=GGygWMqcZ1U9aIk9OtqbP/AuTKMG7HTGThw9+W2c0GgjpIQlrODMOB0xFcRmgrZC3C
         4FSHD8PLMupFEYFXV6j9WzOvb4MQ70lD6AJP0EAtwo4E2PFbLeRQYT4XzBnQJs4+pC7H
         8tkM+Q5g50q0dm9a1VtIWsbmrnZaioyBqSusrCQWWKL3pxCmksKI90eICzDdftw6l2sh
         N98Fm/xlHSg9QN/Byr+MzB0O51QlcIGAiPG7CiVudD3S3IAKXJsWonTzLX06AVW88J9o
         YA/wgZksPHtNPDQShHWn1vrFr9S5rt/R9AIeB421qeiII9y620P2frBhT+JfZxC1phfO
         /JfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746580876; x=1747185676;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rx697ig75IycjVbEDf0H/O/EXjQ0pexJ3yPNetEztWg=;
        b=UUQepvUgLYnrC7pD3apMrCE/1qVfbVg4XzhQOt/jbDEkoLapbbDTyZQie7mS8CVniA
         aa9O7KxF/PSp8YgufT5iarbyxNZvPfEMPk2ohfrw4DV6VfbqDms0FPNJWRRxrRt9ZvCv
         QF4gmY5U/K1WLJEFBMvPUPdKcjssYZvHTiQbX0jKy+knew4DWgSTOHoSqR1IZA3LfrZA
         gMmnEv6VCxPw5gK3k5kPhV+zV2Rk9N2Y/f5+VWCi7EgpZq40Lrv+cT0oy7oSJ2C9T8kM
         /GP52j/YhczAwthhsygSdTmTKO/RpMfuDcR9Bc1+hlzCL7QT76p7Wof97dGVur2qM4fA
         0LqA==
X-Forwarded-Encrypted: i=1; AJvYcCV08bzKLi7K79FLS+8/8590K3Ocje72CXfrYF08Ch2MbG+TFxNYQlckNVZo8wGSNymKrkc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUGC2wwbCaSVAwksKTTM2THjrkTUFpakkopHrDivA/MIi2S9bA
	8KJXil2QWA1uKPRimoH1WdprVksm+A9qZ9jP2PBMvN5btZXaNBjy2lKzOg==
X-Gm-Gg: ASbGncvyOOU85Wif+JqiVpj1SdQjBkfQOmEnVj4Eq1exxm+nudwoWTWiygTK5wUU0A0
	f5lg2myA6aPyRDgco7+vWFIYMndvSfS/0mrYPtdDRBz7D+GG3v5iMhbr6p34pXwfU5N+BXSZ73u
	r5Rbb/+DphlalE8DqMzShq5LArqb68Tfenylw7mJTgsM+1/xPuOV2s6XNC4XwOqrt9FT7+7PKHy
	X4nrCMuVam4Vx+InTiQV/VD/xOWu+4wT6LrBQFwsKbYeZx0jl5F4wE1UC7Py+NxHf4WcrL2JzqB
	1IbY5HKOzlYugaEO7QapQKax5OcCgTtgK7JXC62LQpPtHCjr8iJwMhxyx1fwCxWoSLsuHGxtbCa
	CKAZbIAGh4+GD8578gffilGlrj+a7sCTXzEeek5A=
X-Google-Smtp-Source: AGHT+IGXeuzjNcOFwCvPeiM6URBw8k6WNob6AV40lwl6OzYyUsYmRSPeu9EqPgh7SnqRP66mdTy82Q==
X-Received: by 2002:a05:6902:138c:b0:e6d:df8b:4658 with SMTP id 3f1490d57ef6-e7881437420mr1871916276.34.1746580876044;
        Tue, 06 May 2025 18:21:16 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:cc2e:477b:d336:3346? ([2600:1700:60ba:9810:cc2e:477b:d336:3346])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e7564634d68sm2481669276.52.2025.05.06.18.21.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 May 2025 18:21:15 -0700 (PDT)
Message-ID: <d3524839-a982-4be3-93ba-c35fdde3726f@gmail.com>
Date: Tue, 6 May 2025 21:21:15 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/17] odb: get rid of `the_repository` in `for_each()`
 functions
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <20250506-pks-object-store-wo-the-repository-v1-0-c05b82e7b126@pks.im>
 <20250506-pks-object-store-wo-the-repository-v1-9-c05b82e7b126@pks.im>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20250506-pks-object-store-wo-the-repository-v1-9-c05b82e7b126@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/6/25 7:09 AM, Patrick Steinhardt wrote:
 > There are a couple of iterator-style functions that execute a callback
 > for each instance of a given set, all of which currently depend on
 > `the_repository`. Refactor them to instead take an object database as
 > parameter so that we can get rid of this dependency.
...
 > +/*
 > + * Iterate through all backends of the database and execute the provided
 > + * callback function for each of them. Stop iterating once the callback
 > + * function returns a non-zero value, in which case the value is bubbled up
 > + * from the callback.
 > + */
 > +typedef int odb_for_each_backend_fn(struct odb_backend *, void *);
 > +int odb_for_each_backend(struct object_database *odb,
 > +			 odb_for_each_backend_fn cb, void *payload);
 > +
 > +/*
 > + * Iterate through all alternative object backends of the database and yield
 > + * their respective references.
 > + */
 > +typedef void odb_for_each_alternate_ref_fn(const struct object_id *oid, void *);
 > +void odb_for_each_alternate_ref(struct object_database *odb,
 > +				odb_for_each_alternate_ref_fn cb, void *payload);
 > +

Here's another occasion where we should be careful about how we rename
an "alternate odb". What is an "alternate ref" if we have different 'odb
backend's (or slices/shards/odbs etc.). Should we be updating the term
"alternate ref" here?

Changing 'alternate ref' would be quite difficult seeing how it is based
on the 'core.alternateRefsCommand' and 'core.alternateRefsPrefix' config
keys.

Perhaps this is motivation to keep the word 'alternate' but as a way to
differentiate the repo's odb from ones it is borrowing.

I'm sorry to nitpick so much here, but your thorough series is helping
to bring to mind all of the different aspects that are being conflated
by our current nomenclature that grew organically and is now being
carefully designed for the better.

Thanks,
-Stolee
