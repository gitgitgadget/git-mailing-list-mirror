Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF9E2B9BC
	for <git@vger.kernel.org>; Wed,  7 May 2025 01:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746580492; cv=none; b=u0r6lFX/5qXS0AGI7IUc/P1pd4iHqBMRM2ErH8GlugLSJVg3UZavGYtGKX17dvEkYT7MPIH+OVMZ8IZHZx3K8IqplQ04JG9PI8SxI+5QBh4XDC1U1hh+a3UqLHtY+yYsnlAUspUZyzMhTD0LTY7Th6a457qm6bDCfWeVQ4ARvJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746580492; c=relaxed/simple;
	bh=X/3qrNGnecAJVNBmxmFvnQxW1TPlJyhF5zSkpXolJSs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lodyho3NsjzfGb/Egq6P25jLUL6sffEi+E174rOD43ylZEO4MstZcoSJKykdKEiaJp5sx0JBd1tQBe+FHvxRRU+MajIJA5eIajZ61w7V9H5Epcxmslx/XaDiURXjl7jLPTo07en9MNxdmmjCZsoWrynuCs4EuvkpN1YQLZHBq2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DHlyX0CJ; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DHlyX0CJ"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e728cd7150dso4787549276.3
        for <git@vger.kernel.org>; Tue, 06 May 2025 18:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746580490; x=1747185290; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JOugaR0mZSaY6c1zJI8d6bjbqibT2lm1pbBIAk174uM=;
        b=DHlyX0CJT/WpSnKETguO2TsR4z8nlz+84mqTfd79ttkynxd/WM3xkaOLW+2C8jPHyl
         B4V7WfuYUfwRgI8swTpdkADfImBLF4c+JLdHRrLaoIt0JCd/W3HZwduP1dBC8VS/bZrZ
         p0B+xZjf8OMTjKQs0DcFmlaIrTeCignAoTwBRjG65fIrNxt208gKbT3PoSI7rFQBqlJa
         fQbFv9HyDgZnwKRZYILLiz5Pn8GWlkuZrhjzfNcZgft6/pKy5OKVmmPux8pGOOusuGEG
         8YV5rwHxr9aXbxQmJCcJu3INaMTzK7xSQZzWb21R2qneXcWvvc4ra7YDwNZrAf9EcDCb
         OURQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746580490; x=1747185290;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JOugaR0mZSaY6c1zJI8d6bjbqibT2lm1pbBIAk174uM=;
        b=OEna+aUghJsAl8+OlMj3rdt43LxtzUmHYV6UoagROJUe5lHBfth5hapFlCI58uqgl9
         SJRM1feTDn0ec+6pWFsMLbtKE8hliet8lE9hMMGwAAmIr3+Y/qxqMLRkGUdAuzby+yR/
         7WPAfaicYJGtis/3coy9Fn6J9yfJNkarJzyWSOe1dKaCF8RS/QGn3E8y0bsmp6Dd12NB
         5J5EWbURqfdHh3QIeufcsP3VlOYmPI4BxFCIYbXOt86y5tFEJUc8bfEgEvQ8Wx47q+2o
         cavDzFtMt0KLzmg9eCP6PVyFsGe8UjcODWqu0Sl48muZ6bqwy/vYIO7U2Km3Y1xVaN/Y
         V5dg==
X-Forwarded-Encrypted: i=1; AJvYcCWzNLOHraFFuqCkwv5VRrKoTBMonkKt1tEfjUEwDd6N4ogmp6RvY2d3CuJV8yX29eeDhek=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl9Csw0DP+HJra0r7au1RSnxPZAn97nSPm+9HLqd0PSoqVf82c
	eS/j2v8EFGHgRdrlGnWNwGAZwUFGFxMG8cl3UpO2kVy4lI5E5RC8
X-Gm-Gg: ASbGncva4PJ6rJ5ETP1eOmZnufoIdhTq6+t+ggp122x/2fQ1NdS26HZaFAW+A4VWFzb
	4AUoWdhZf7ouIaPxw1FyQVOo9MmeuFdgnwE6TFD1nSKWQkSTgXGGyHzYkyBLo5GhcWGjxBZp2P1
	OGEZ2+8/rzPWCkRLOjPGgtv5yKHG2Dz4/3SqV3gFdrqF0eSGp9zug4gdXf2oyjAX/+Ka7hvfuwv
	H6i8/YaZvLppsY4CQ3rIl4Aaa0B6S4yLZdBqatf9FLh2MKwWQybqfSLQtNlVDlYbypWNFX18hQa
	+iUfSoZbbsdAsIq6vrTym6VTbwP1iG1QqXgVTxcjQDSRQfSrMtI52fMaTVy0hm55yNii8oKG/jL
	GzkRxf/KzdQEpSl3A3BOHAjZsKXLl
X-Google-Smtp-Source: AGHT+IH+8mtdO/Qc9tzpYG13KDSmxzqo8UtTWf5v6yJoC5+/tv5Xl20sBwKUFIPBfHbd4254GPMZaQ==
X-Received: by 2002:a05:6902:e0f:b0:e73:124b:95c4 with SMTP id 3f1490d57ef6-e7880e7df25mr2158742276.13.1746580489771;
        Tue, 06 May 2025 18:14:49 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:cc2e:477b:d336:3346? ([2600:1700:60ba:9810:cc2e:477b:d336:3346])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e7841cc7fc9sm229400276.25.2025.05.06.18.14.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 May 2025 18:14:49 -0700 (PDT)
Message-ID: <8c4841eb-473d-483b-a5cf-15bd41ba890c@gmail.com>
Date: Tue, 6 May 2025 21:14:48 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/17] odb: get rid of `the_repository` when handling
 alternates
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <20250506-pks-object-store-wo-the-repository-v1-0-c05b82e7b126@pks.im>
 <20250506-pks-object-store-wo-the-repository-v1-8-c05b82e7b126@pks.im>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20250506-pks-object-store-wo-the-repository-v1-8-c05b82e7b126@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/6/25 7:09 AM, Patrick Steinhardt wrote:
> The functions to manage alternates all depend on `the_repository`.
> Refactor them to accept an object database as parameter and adjusting
> all callers. The functions are renamed accordingly.

...

> -	prepare_alt_odb(odb->repo);
> +	odb_prepare_alternates(odb);

I was looking forward to this change in an earlier patch that
introduced the line being edited here. Thanks for making this
cleaner (and the other callers will get cleaner eventually,
too).

Thanks,
-Stolee

