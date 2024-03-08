Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF99A38387
	for <git@vger.kernel.org>; Fri,  8 Mar 2024 13:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709906200; cv=none; b=KqfjQXg/5U9Qqn7fuR4zjdEYQYhaS+GVQhow7O4KtXhtZB96++AIj0/ZOdw/5rUZhgCzrQQUsqJGA92YRly6hUI6SSD1xM2kzRfxa7wUq3nu9Pepi1WZmj38hRClLFdOgXlhPDlDt6ne0fPJFaP05ryU7qiiyYGjdWrNbuhD6lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709906200; c=relaxed/simple;
	bh=8qAbH+7sXqQGE99MGUIgObhiZpfRKiMDAP1Bp+ywoOs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CLf1EGaJVeXbvhFbS8jzI1hhKoOYBpqQaR7XZqEwigoeEILr8yQULjRIaOCN1cdpmgOA8c76RAI/aOoP1rlWHHwVRg3YJimDngrXYd4Mz7vlnG3a2Fqz5szst+ekSdQraA9LLpf3CVqxkBXNcjvwKdNdCAPQuwVqtO5OEXbpIj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CCh0JgnM; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CCh0JgnM"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-51320ca689aso1132748e87.2
        for <git@vger.kernel.org>; Fri, 08 Mar 2024 05:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709906197; x=1710510997; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=89EsS/sanuT5cJLEywi9CvvR8kGzJ6PSzFe3FxT2OtM=;
        b=CCh0JgnM3Hq39XcbHC1bIhR5wbCiDUiwlfmOtoixYkrKHW6Lh9OzhTQYZBIvy3MUqa
         HRqWfVeKI0vsEaZSLA2Bz+NLOVVslfB+dYs9yVDwk4auaD0S8jBjgV9HE0X7bPbgsATx
         jw95pSwxMXMjzn4r+AQDzZacUvUcyC76Y/vTNLAxf2ykkeJSxo5+lOJmacUr20IQl56p
         1eF/iuiZNzh6IVh+vH5xP4I3T2FrWZbmHzwkLhzvcoJAKkTTOS2ftJ/m+UnN2Q6pcZSm
         5q36noVRqyYhHqkEgUCxt4dSy45WUO9pm7wNolWcSiOy+C112+oPT1F6+dOAsca62Yxh
         lzDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709906197; x=1710510997;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=89EsS/sanuT5cJLEywi9CvvR8kGzJ6PSzFe3FxT2OtM=;
        b=JYOC3Mo6IJ+30dPtDO1f2h2EldSf9eSFbpa/o8tBEPhJxShMj5EEfP7gfCP/1HUCGm
         ex3XAp3gBFMl32/tKl6b7mKmseKnqVxw6xMJU5rmgF7JTkNlzTCyHiNuYFB/EAWOq8zF
         sTP8vhMuNuZ2u/ubaIJh+kmq/Qtzl0JmGraY44x3OVCZpu0zdKRGooLvGoo+G0qDZ/lO
         r4uC73d7H9inLVmn5N573YjBMMEY5uOiIcCdVYBinfNETUI6+XR3+0zUpGytAuJHC0+y
         OPLlTsk5bJ+rh6ZQpWo2Mm7NZ39FDExLx2grgjX+tajXEJ3ZV00VuctWxgqFGEBDD1L4
         G5/w==
X-Forwarded-Encrypted: i=1; AJvYcCU0elFEUWOu1Urhz5p8WpQdhOA5BbPnKEjLnUtiCbr069ZGfvXlp2Wmmx+olTcX85vlg33n8jZqyNC94G1a6fCmd/q0
X-Gm-Message-State: AOJu0YzCYpv5sQV7Rw6mdhLAcV/J1o/oBhUjowPLj4t4QMuHaO9EB4dJ
	q3rZWo9Bij5Fu3KmafPHg2NDlXprFfe2GgOSFUFfjbh3kg17xx4V
X-Google-Smtp-Source: AGHT+IH4njKhI+LtwBmvRGLwQcO4LKWX8d/vNrjxo/7M4rNEDslgy39xFZ/Of8sOTSHcJF4qoAetVg==
X-Received: by 2002:a05:6512:3141:b0:513:5fb0:c5ad with SMTP id s1-20020a056512314100b005135fb0c5admr3349156lfi.17.1709906196734;
        Fri, 08 Mar 2024 05:56:36 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:6ca:8b01:d2c6:37ff:fef6:7b1? ([2a0a:ef40:6ca:8b01:d2c6:37ff:fef6:7b1])
        by smtp.googlemail.com with ESMTPSA id g25-20020adfa499000000b0033d6c928a95sm23074764wrb.63.2024.03.08.05.56.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Mar 2024 05:56:36 -0800 (PST)
Message-ID: <f7cd227f-dcde-4d71-b1a6-a4d34c492cd1@gmail.com>
Date: Fri, 8 Mar 2024 13:56:35 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: What's cooking in git.git (Mar 2024, #02; Thu, 7)
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqplw5ihm7.fsf@gitster.g>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqplw5ihm7.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/03/2024 02:26, Junio C Hamano wrote:
> * rs/t-ctype-simplify (2024-03-03) 4 commits
>    (merged to 'next' on 2024-03-04 at 9bd84a8877)
>   + t-ctype: avoid duplicating class names
>   + t-ctype: align output of i
>   + t-ctype: simplify EOF check
>   + t-ctype: allow NUL anywhere in the specification string
> 
>   Code simplification to one unit-test program.
> 
>   Will merge to 'master'.
>   source: <20240303101330.20187-1-l.s.r@web.de>

I have some concerns about the last patch of this series c.f. 
<0947cb09-8b07-4fcd-bbe2-ae37c2cd5ec7@gmail.com> It might be too late 
for this series but using the internal implementation functions rather 
than TEST() is not a pattern that I would want us to encourage.

Best Wishes

Phillip

