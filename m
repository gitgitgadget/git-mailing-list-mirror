Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0242C24167B
	for <git@vger.kernel.org>; Mon, 30 Jun 2025 08:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751273996; cv=none; b=EN7tQMdjgmhQAVQIWDKQvW0kk82ccvQsdj72WvKEs30wFE6oxUFuURnlSSAsoca37KXakDa1IbVYAN+gdu7/Cjj2TgiBTVYER6LGbV+GbwyHgMbGyeCAtV/q0iExD2KEzAlHdFd+BbZ4kBPAs1CRMQxNaiy+eFHCZbwBmMcQ+6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751273996; c=relaxed/simple;
	bh=8jIWJVSwF2ReCuBUyk6cQ/D8Ue1RlGsxqJjkvWsaJmY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mObs9MEeXWZDtw3kCgBvcaqeYSU6gDD1y6ImO6aXsEEZcHLC60U9X9GceSTm/0oK24wyNnry14sFfskRz3B+lPZJ+QjoEXTagk1HUlGjdUBmwG51ujG2iUqoObAHEPZi5QA+Wms2RUz9Ns9oTIPa+uUDt28hdRJd+o4EohFlpIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S25htZIG; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S25htZIG"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-451d3f72391so19682945e9.3
        for <git@vger.kernel.org>; Mon, 30 Jun 2025 01:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751273993; x=1751878793; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YIb7aNcpFChY9jYvF50rKp1Mrb7wXJSSOLaKlyXU+nY=;
        b=S25htZIG0cH4rJiHy3UtvgZHwlSPkmkd/vTB27f9+7mDruvEUSTDStut7lNhvDxcqr
         zxcbeLchFg+/dfGG0hKXMIk/1JfIbapYO0jQJpaH/qagRAIEHK577HXyCsxN5AZVKZRI
         +kEqkQ4Bf5o6bAqzSsHbfdtZF1S3Pk5nKmq3Rn9qBvsSK7sBzaom+BQFD4NbCZqwQaGy
         hEUu3wu1Itj/d1xoIuVMgbZhyWnnRzKCykVAF7DKYmn3dMzdflCyB8xwGaEv/j2StlaZ
         OoMTXHrd4VFrFn9vZ39bcumRNM3mi2Jx+GfvxYRD+5AiWRjMEZAmHFb5sKqEwT/iyMn8
         HqGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751273993; x=1751878793;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YIb7aNcpFChY9jYvF50rKp1Mrb7wXJSSOLaKlyXU+nY=;
        b=PrtZ6MC9mQiEOn2LUs2XWdZaF6RKiwCf1UvhzSjgbWlkJaC/hhm5elV3qb3dCJG9PN
         axwFLfm6AheWxhjmj41iqxhrOO095C4N2CR0vXOYTDWBuSPqnN8Nt56iJ9RbYnG3poFU
         Nxh211V0YY4tdzN84FroBTs2fhWQ4qdMmuqmvnRbUEItowuh4jiYCXPpqgZ23EcW1aae
         +DMZrX2doot8C9XPj3qwMMAuNqKgcqSiH5+jBXBU1ab5C6Q0jGW/lF2M1OsDzXE9/+zd
         SagKcOyd8XSByKU5VDhD4gCh+O62jSvwKQzCSUJeFlrYJzTh+25OQGBu+LZEoSK+WQV0
         ibQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEL9+NZ30D7Tv+5rH4gsvhll7OeeNJeX/df2Tsk56YEEE5NmfXlNfcqq2SGXKma665LcY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY/p1qmD2uwkJx1nCnnRX+g+ZLHpM7VLp0N6fBKLrxpaVfOCcw
	wZ9BZu3Ch4JghpMDfUqig/gcUpw21OlH8HzxUG1CUrPUbyoxkOq6tE+P
X-Gm-Gg: ASbGnct3aAEq/cK/0anlnSm5WfrOlTQCsAZH8PABVcwxYqjmsb3hlZteYkRMk0BbQsq
	ejzywb/MaeUaKuzWY4mloSzLCLgbseoF29Djxwy2gJxik+NQAoIJf288+cDl9gWZLz2yds5Ouof
	az1RbWFWZSZRaZq8qT+HYsVgltkQKL1f3danE0YcdWvZI3F24oxRadosXEij9ZAaQNZzbJVGvB2
	oOyvbjUEkElSIny87Q3vJVgTvXcYESIYY9X7PV+vDI/luDHGMXXupa5PatFqIKxYQ9Jp/rikoQp
	MhWqRTBP8a62RYRkvWznAcAPT86x9LvYZ+8UzXFOar7QB7iuhFTlauk+HbbhnhEOIDGtNarbdrS
	T7Q18sIiPpNDf69H5Q2x5pNwAd8TrkKGo2WGv1Q==
X-Google-Smtp-Source: AGHT+IGYRqpS6+AaKXcJl2sQzplb8OAbQrwZblC7fiNwbvjjS+d2nJVhWjKFbW0wYroJVf5hIuMn6w==
X-Received: by 2002:a05:600c:6285:b0:450:d01f:de6f with SMTP id 5b1f17b1804b1-4538ee51961mr139266095e9.15.1751273992920;
        Mon, 30 Jun 2025 01:59:52 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e5f8b6sm9956879f8f.91.2025.06.30.01.59.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 01:59:52 -0700 (PDT)
Message-ID: <abf3aabb-8e46-4324-9e35-634cdaf110fb@gmail.com>
Date: Mon, 30 Jun 2025 09:59:48 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] daemon: correctly handle soft accept() errors in
 service_loop
To: Junio C Hamano <gitster@pobox.com>,
 =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
Cc: phillip.wood@dunelm.org.uk, git@vger.kernel.org, yoshfuji@linux-ipv6.org,
 kristofferhaugsbakk@fastmail.com
References: <20250626161038.85966-1-carenas@gmail.com>
 <20250626172159.87204-1-carenas@gmail.com>
 <08804dbe-56dd-4c0e-b36b-a82768b0aa29@gmail.com>
 <u4scxaxivz62fsljo7okkfdvcle3zdby6h2sdzd6ed5n6wi5xb@5ekxdycixwxe>
 <xmqq34bl7xa1.fsf@gitster.g>
 <vgailqqh3bcip3gxtdffoo4ey7xjso4xerewxncy22shrzn4k2@25hst4sfgxq4>
 <xmqqy0tc68s4.fsf@gitster.g>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqy0tc68s4.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 28/06/2025 00:53, Junio C Hamano wrote:
> Carlo Marcelo Arenas Belón <carenas@gmail.com> writes:
> 
>> That seems unnecessarily restrictive just to minimize churn and leaves the
>> deflaration of incoming strangely sitting in between two assignments, which
>> while it doesn't trigger -Wdeclaration-after-statement seems to go against
>> its spirit.
> 
> Hmph, I am not Phillip, but my take on it is that incoming and retry
> are fairly closely related variables in this loop, and better
> grouped together?

That was my thinking too

Thanks

Phillip
