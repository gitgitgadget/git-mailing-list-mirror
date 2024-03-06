Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE595DF32
	for <git@vger.kernel.org>; Wed,  6 Mar 2024 09:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709717782; cv=none; b=hCqOcH+Q3G/l1PxFXwXY8GnVpDKPRoL4Lu68lLiaq8RBY/FhfOJ/vymXQ6pX8KnO7gEFz16nClqwY4NP3OTdvJmY9DhViyCYN2Sbw0D8ZBv901VEZeFLDIvqe8rKWDM1nqWzH+eLL0DSUYpSj/qZqffvTAFFNf+dYwagwmtVObU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709717782; c=relaxed/simple;
	bh=Sihyyxpr3AyLNAB8xykF+beZl4kXBUfMUWJZp36IEfo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u50j9XOjE6xkGjcU3hmVuE/tffaULlN8n7eQ9H8/Fw3JHEBScFmTk5wWVqrus1f+S+Dhf9pxt6F5YjiJY7tdMAwysvCoNgLpghNF1AQSdwV+S66EGbkLi3+HJvj5/90HGNgZ7z5DCg8evEXFnApWrWXQu7f6pYmybfJFFAEsY1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HouUZk88; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HouUZk88"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-412f556b3baso3313945e9.2
        for <git@vger.kernel.org>; Wed, 06 Mar 2024 01:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709717779; x=1710322579; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lR7QzQtug9RYbzz4psltwwZy58+nClkOeUfNUyhXV84=;
        b=HouUZk88pF/9kGVccE3hABbGvjOZYbglOD+qWvkny3hZiT+dfU8WC7i12jSqP6C7wn
         jnhyx+DX7SPJJEY78Dj6jWhiMSKhjyAW7R4XDtfDJZ6/4ppWzG8CxgrlnUaJyph4bWrq
         IMjngKLUeo3XVqc71m2qQP0WUYfRHS6XmTzh/nvszYQzm6LdsSfDeEYZwCtD09F72a/z
         8qLY58qQDI2hn+P1N/W6V6+zJ5Pq3ebP8rdT0QbiFkcHRtelz+XamHA80shdMrJVHLQG
         RqgkXDjA+JifHI5OJiaJR7oYoa/KFalthmb0M1sjriooyhxyL3iOwnKWmJrr5+af4PqI
         zK5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709717779; x=1710322579;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lR7QzQtug9RYbzz4psltwwZy58+nClkOeUfNUyhXV84=;
        b=Gd+mZdLUpcFHgRcQqiGqcQlVmTMP0G4HO003WRHOJwSpI+3iqncvwXtH/dGH57n+lk
         egmiCyaH8At0fZkAT0dB1/WYl4Y+y1yKq4s62pMg+oNSZQAunwgiYWDhcYkBVIlToGIR
         8fnrEVO86rMywSDlARcE+c216hGKOYL/oEQYhKfuqDiU6NOKAEzgSfktTNyhyCxhIGqM
         5beTeg1KXI8uzCioE13mXEBj+zsQSMDLwcRhM1n0QSpjeOm95Vb5l6jWJoBzLjxrgQNl
         lfmQB+TCYvuUyjkY1XMvwP/RyMvYOI5md8gBwB0ZLc6fzwY0ShOBnv8sLny6RlhS9xDv
         HPrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWexdRNVIw5fE+tqQJTMMuH2AHr5q8/7Imxi8qLbvyLB016shR/xOvp88m7afKXOvJdiL4BAK4ZnYriVYAhxJHAyxzT
X-Gm-Message-State: AOJu0YxIEL9dV2LPJSvR2r6smw5fvVm6YIJfcL7avcFi+QmBmX4FyMt5
	vm6rQVvFobxkkiO+8Xy/fXtHwdc6rm6K9LMfuKh1e+MdSFvM/e9Wpy76VthnTq8=
X-Google-Smtp-Source: AGHT+IEpfOaPv/KYpftuc3paNHTl5PJnJWbzKwDX9mon7WI5ouYVXahoU3Jh/56C/XWYqeBY+rz3bA==
X-Received: by 2002:a05:600c:538f:b0:412:f572:5318 with SMTP id hg15-20020a05600c538f00b00412f5725318mr962970wmb.11.1709717778549;
        Wed, 06 Mar 2024 01:36:18 -0800 (PST)
Received: from [192.168.3.191] ([92.173.128.58])
        by smtp.googlemail.com with ESMTPSA id co14-20020a0560000a0e00b0033e3ce48ba1sm7989877wrb.16.2024.03.06.01.36.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 01:36:18 -0800 (PST)
Message-ID: <ef5958e1-af3f-4869-b0e3-ff1448c0d73c@gmail.com>
Date: Wed, 6 Mar 2024 10:36:17 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] show-ref: add --unresolved option
Content-Language: fr
To: John Cai via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: John Cai <johncai86@gmail.com>
References: <pull.1684.git.git.1709592718743.gitgitgadget@gmail.com>
From: =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <avila.jn@gmail.com>
In-Reply-To: <pull.1684.git.git.1709592718743.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 04/03/2024 à 23:51, John Cai via GitGitGadget a écrit :
> From: John Cai <johncai86@gmail.com>
> > @@ -76,6 +77,13 @@ OPTIONS
>  	it does, 2 if it is missing, and 1 in case looking up the reference
>  	failed with an error other than the reference being missing.
>  
> +--unresolved::
> +
> +	Prints out what the reference points to without resolving it. Returns

Style nitpicking: we use imperative form in the descriptions of options
→ Print out what... Return...

> +	an exit code of 0 if it does, 2 if it is missing, and 1 in case looking
> +	up the reference failed with an error other than the reference being
> +	missing.
> +
>  --abbrev[=<n>]::
>  
>  	Abbreviate the object name.  When using `--hash`, you do

