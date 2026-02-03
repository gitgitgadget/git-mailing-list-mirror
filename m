Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE040314A64
	for <git@vger.kernel.org>; Tue,  3 Feb 2026 11:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770116774; cv=none; b=IMM0lh1gmVrJUOaQKoQ/S02g31Gw3hy0JEW00LisEeCcENO40yc42uvwmyoXu2CaXXNo4MLTi6HmTP2FONY7DTWcRluYCEj8cNQLS2Lv3lPJuJ3tdJLGl6Y89pac/tOHjyRh89i5NveK2HrSRgPHTu/N8EUyg52ALoW5jWQZ3AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770116774; c=relaxed/simple;
	bh=hjtq7bzDMLZ1AvnaVrHoaaTxqvvi8/ZMgyAiCqK7Juo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A+ije67Qawed6/kH6yj1sJ66WPMsaTfBSDX/fAiAnAQSFxhaexwk765XYQxY/MkgEcV9Y9mhCdD9eSM7PQI7JeAT4Q7B3thC7rQLeWYruGoIgH+MXLty0wFNuBppEvNRQwYOhMog0y3f0WFL1I1DVG1LjoIGR3Sz5MZfUlStquM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hu3wz4pJ; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hu3wz4pJ"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-480706554beso58978035e9.1
        for <git@vger.kernel.org>; Tue, 03 Feb 2026 03:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770116771; x=1770721571; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6UUQ/JgK/ELc6sfgskYocgxkWwUlkPQLeMXzHlBxIg0=;
        b=Hu3wz4pJyoZfxDvtblsGeKXGZrE5zXpXtIyi1sYRy5YRGRAw2y7OEwNfqiiHkaThxV
         5xfbkDTnmT6nqesT8EbSRkP44qmrfJnjIge8IYDMvjq87KmiBtMlaYeQmeQsKtj1Vkg0
         QWhrGz4mrWLBG//Z5Dx3ZEzS+vDxYVT3Wi4DhPeX/tnvCnKqV1OFHzI8BMZOE874y8V+
         si2JVNt6sFPDJ5skzjhhpVh80mJDR4X384YVRTsLLQwIFcfnSUHmeHF6YHV8on8UfTtj
         ZNi4gNhzEeN6NMvczzAXUTWpWQQwP5f4kND4tA3LxU0qUkbhyRsCxfaGk/Z+Ds19Jt/L
         3yfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770116771; x=1770721571;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6UUQ/JgK/ELc6sfgskYocgxkWwUlkPQLeMXzHlBxIg0=;
        b=CtWW0lDb+zgyyP00fBYXjtEa71qlxHQn9pE+3F8m4KOvASfVK5tzRHuGOD7gVeKFtx
         v/DGyD7o14c7W1qdA/GTRzAIoapailWWwb3wkglh9dcVOSfs1DWfDQ0k/KAznnMdcCXl
         FPDbeRx+tlJx/51sMT3Q2GCEwx4dLnj/reDiSfPA1GiujwwLPdC4aFu+UhLAj+/uxlk5
         zUVXBNsBwmCFCfpYoS0HW+y9lThGG1wgg0gEkd7hdEdJPSEJEq2gl/LC/AqvaBl0CpPl
         //MVE59c/kFDGF5ITtqULlpNZH7L5q4RU0/yCxX5WjmWJCiffT8E/E827JdKZQLxU9Fa
         q+kg==
X-Forwarded-Encrypted: i=1; AJvYcCXn20MaxKRvOx5YH188QMYj7CPY1qJzz1O8hamSxAQKb00iuRgqI1JIRyyScbVVCHY/eyI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqE0Z3MfAU7TksDR3v4TVIjisWw9l975YUChbURel+lYsmxEcF
	iMbRzbb2vLjIZ3cg2nrCjGdH45beroWm2qYsMBrPWMSuAM6bYOUD6ygj
X-Gm-Gg: AZuq6aJYDcittG1dl81jufiifA+CoY3Eji9ChGUgmyIkiXAUExj84/W3/vDE6eoHkXx
	dPFzw9xU4x7vQd0sqKEraO8N4gudThuZtzpnnN3WTup6Z2Mt44auEHQcr7s3TOOOAy9CXgPsqxz
	IqkzefgURpfvAud/IrSmQJB0BjFFzOGZuNcRI3jvKvs6IRDaSHiryUeLlK40rFqlRML04VRnLT1
	1VwTvtnAvmNp1cHEuuAf94+EtWrbVlZKHy7PIml5PC2+YGgpqTPWB/MLqNwEEssCXQ2Fg1UBG+g
	CwkKrE11dbqj/lgfo4p4W/TQ/MGUOqw5sJjjBLps3ahY3hT8/PHQ+TTSsuWPnKQesKlMzN3S5GY
	1+1jz/xxy0eKeitbP7aLnbASKG05VpmOWEszrJTkgRZOeQ7VXPfT0jUvcuG2s/FKNXiyF9Xko5J
	H5iEkX98ZNdynW/Mn62UBa7aZMggQ4ubx4ulHYd1zKhIRKejyqzdZxMoFDUwCIr6xlfwBZMlI=
X-Received: by 2002:a05:600c:8b31:b0:47e:e78a:c832 with SMTP id 5b1f17b1804b1-482db4b692dmr178600405e9.37.1770116771104;
        Tue, 03 Feb 2026 03:06:11 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:627:1f01:d511:bcf2:b462:9060? ([2a0a:ef40:627:1f01:d511:bcf2:b462:9060])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-482da8d98b8sm137747935e9.1.2026.02.03.03.06.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Feb 2026 03:06:10 -0800 (PST)
Message-ID: <da3221b6-f724-49ea-99e3-9baed38d5bd3@gmail.com>
Date: Tue, 3 Feb 2026 11:06:09 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] wt-status: replace uses of the_repository with local
 repository instances
To: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com, karthik.188@gmail.com
References: <xmqq4inywxx6.fsf@gitster.g>
 <20260203095446.10971-1-shreyanshpaliwalcmsmn@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20260203095446.10971-1-shreyanshpaliwalcmsmn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/02/2026 09:53, Shreyansh Paliwal wrote:
>> 
>> Clarification.  This function is like an initializer for the struct
>> wt_status instance at 's', so it has to take both "struct repository"
>> parameter, but what I meant was other wt_status_foo() functions that
>> take both r and s as parameters.  Once s has been initialized and
>> s->repo becomes valid, passing r as a separate parameter, as if you
>> can feed a different instance of "struct repo", becomes confusing
>> and a source of bugs.
> 
> Actually wt_status_prepare() is the only function which is taking both
> struct wt_status *s and struct repository *r, because it has to initialize
> 's' with the help of 'r'.
> But all the other wt_status_.. helper functions only take one of the following,
> i.e. either they take struct wt_status *s which is fine, or they take
> struct repository *r.

You're correct, but I had the same reaction as Junio initially as I was 
confused by the functions that take a "struct repository" and "struct 
wt_status_state" which does not contain a repository, but at first 
glance looks a lot like "struct wt_status" which does.

Thanks

Phillip

> If we trace the callers of the functions with struct repository *r,
> they are either being called in wt_status.c in which s->repo is being passed
> as a parameter at the end so it shouldn't cause any issues,
> and for any other file callers, the_repository is being passed,
> so to remove struct repository *r, we would have to setup struct wt_status
> in those files as well.
> 
> Best,
> Shreyansh
> 

