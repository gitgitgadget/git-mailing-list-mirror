Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8E6EED6
	for <git@vger.kernel.org>; Fri, 13 Sep 2024 15:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726239919; cv=none; b=BL9BjGVEDgSHhBi8+Di6za+X+ee0a76TNZd5RiGTua4UfZdJta2uBqlWpzzZYc7HaCt8nacBhnmoV+UQ7ySFlkdIn7WofUyJduOiOB8pBa0XWwDvUHvNnOoXmptJABycrzz0jnhIAQeIpl6BjGEXA42AXmxOKLqCy31DnoY6dUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726239919; c=relaxed/simple;
	bh=LmNdGmn9ciZNBtdaIk+FmEtpiAQ4sHcEC31sIpcykM8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YlqxMSGZ6+EC893yFiaAz0ShwxJpUs+TANv75XGK2iuyJnLW2nEqCpUr1SKcwGV9jwo20RPsu8x/HuR7NjapQbUBS2CCEGYAoVjECXv42rh8fplJnnve2EUNVxZtRps9KDEFCXT03DN39rf70woaLtMJIJ/Ol+KIiPmZIM5/XSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=axby6sw7; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="axby6sw7"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42cbbb1727eso19884385e9.2
        for <git@vger.kernel.org>; Fri, 13 Sep 2024 08:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726239916; x=1726844716; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HaiWVT1ls3XsHxu7Izw5T+FheClE8fj7EApVnABTuCg=;
        b=axby6sw78Bfk7HNYFkvjBP7HC4QR0t0VdU+8klltBmnnE6swCbTpet342zLMdSO9GL
         FLKJDsNMEGf/2eplXgN1W31FtFfXNaJaAhU/TbZ4MFNBMgQmZ+kbRxNKBpcA8NZW2vD0
         joxMNb6BhQO9gswTP7/Hinf/2TB0pg1/OicI5jLhJkibEdyGctsOFuHynukaVgfJgCC2
         GXK1tUO+3/1RCWlk455BmskkGAzUjuoKvGbY7B1tlmbE+XnddWlppdaTxbi5yACefkZc
         LQJYtcwPq0Nauqip18GpObqrh9YUk6usDjGI8IAY9My1oSMhhWNzSXrVmTsuzIetVMtl
         8qGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726239916; x=1726844716;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HaiWVT1ls3XsHxu7Izw5T+FheClE8fj7EApVnABTuCg=;
        b=gW6EIQbTpLlJr2fclgtQFsqrnv9/HqJXFnYpiVfdJy+1ZOyB3+z3fg/ex337wX4IJu
         jIfd5U2uII6M13pRF8K4FGLjC1RPVx0RGjW5fYSGSWEEACgZXq6+vv8lbuA0O8BSRCvo
         /9NJ1QiahAqUsoBsV8tyToPmSVb9mLMkMnqjydkvhxKxSXyXFXEeO69D/d7LaB5izgxj
         GkOXsIfzbTYZMj8EmeoOSIQlX9zSxLZ8enuVNpyYbpmKiNf0Lsianjpwy9bch4PFGhVC
         YXOrj4afLfEjv44kxY/JYvw63UisUzGcnjG1UK1RsJRTqOrWvGZVpHXrIIloGZ2LYjlT
         z8wg==
X-Forwarded-Encrypted: i=1; AJvYcCVoqiGnDt7V5Vuvh0+zFafhFMrJdGhsdtVPPkeDkKjS2A/QXMEhdBuspMMRZjykKGcMb+s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMFpy+53rbkc6q3kzyGR2D4g2z5pUHohNWqXZcO4W0GWlDB9dl
	WznhDV3rq6rFbotlKrPqvSNP+hewXP0AklMRIbk6GEWoRvPZPbHY
X-Google-Smtp-Source: AGHT+IHGQ43z7NjtfJhs0wxyxMtJsexDPFfDDBeFWkDSerxsZrVdexnhgWn9lIWvw4fo8GSJOxsq+A==
X-Received: by 2002:a05:600c:4ed1:b0:42c:aeaa:6aff with SMTP id 5b1f17b1804b1-42cdb54078dmr56794715e9.10.1726239914686;
        Fri, 13 Sep 2024 08:05:14 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:628:b501:20f0:d089:108a:54d3? ([2a0a:ef40:628:b501:20f0:d089:108a:54d3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42d9b16c2d7sm28584285e9.24.2024.09.13.08.05.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Sep 2024 08:05:14 -0700 (PDT)
Message-ID: <a25f71ad-093f-4e8d-97ef-503bfb9926d2@gmail.com>
Date: Fri, 13 Sep 2024 16:05:13 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Commit signing with SSH key uses SSH_AUTH_SOCK but ignores
 IdentityAgent
To: Justin Su <injustsu@gmail.com>, git@vger.kernel.org
References: <CAB=S_8JhN=WSuYRMWbGz7gZMRX9dSb3k8rJZ7zrxkbHKOqfzww@mail.gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <CAB=S_8JhN=WSuYRMWbGz7gZMRX9dSb3k8rJZ7zrxkbHKOqfzww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Justin

On 13/09/2024 10:58, Justin Su wrote:
> I use Secretive (https://github.com/maxgoedjen/secretive) to store my
> SSH keys on macOS. I've configured my ssh_config to use it as the
> IdentityAgent, and Git can push and pull just fine.
> 
> However, it seems that Git ignores IdentityAgent when signing commits,
> resulting in the following error message:

Git just runs "ssh -Y". I can reproduce this on linux - I suspect the 
problem is that ssh does not read the IdentityAgent config when signing 
even if it is outside a Host/Match in the config file.

Best Wishes

Phillip

> error: No private key found for public key "foo.pub"?
> fatal: failed to write commit object
> 
> I've worked around this by setting SSH_AUTH_SOCK, but this doesn't
> feel correct to me. Is this intended behaviour?
> 
> Thanks,
> Justin
> 
