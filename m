Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F3A39ACC
	for <git@vger.kernel.org>; Sun, 16 Mar 2025 10:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742120100; cv=none; b=RIJDCvspLBQtwYYZZihuOe31twJ5CxWNO8O1UUCu1xMEhw9jiEBkg9c0zGnNYO1TBTgLNEOLPc2NQZzore96VjPCQViJ4bPzJ1YhryCz+JDspDrvd93nUDGrHm+Y2FjpD6siIyqqHhQxQzKlNtpG14YwOjGtf0w0lI9e2bwx6Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742120100; c=relaxed/simple;
	bh=WeI5rtirK4I0w5YkIhSV142gOha7IAR4z9RI/gCT0cU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oO6KtyUOGWpsfAuYyFeEV2ofLBh9yDc/dQ4GCiU+atJIv3uHuLiW+OhuOnmKUaL/YWpJP1V1NV/mSVu+BAqRkvpAxCHDUj2AixEr1xYgrpFkPvrG12yN83SzS4M9/Wj02yBKNGZLT7WGXc2i4gUEC81aF3RKOjmVZzUUD06wfSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XG2jYei5; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XG2jYei5"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2ff80290e44so2090310a91.0
        for <git@vger.kernel.org>; Sun, 16 Mar 2025 03:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742120098; x=1742724898; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kkh7Gs6f9tozVDWQHE00O73ERCRpoaCm7ZGlef2zJPg=;
        b=XG2jYei5hV1drSB2PKZ5l0ZunqnXWjnDyXvMvrFDGxH5Gjuf10v5eocqajtqiCz3tT
         CAhWWrwGxZ6DCj5jEZv4TNIKHt+OKfW0sPF45/zc9bxwZmhVZs+HEjy+f+K2ORMNvTyN
         d/Yv5hMVBkmWPe5YyXrItRcu/NthNnVV7U7gHxQwUGRQiA1CU9WWtdLzkRcIwVqD7mw1
         Orc1R1XQhTq56bCeyI+moYLgkBAcg7MK0AhqUBtiwXlOu149yFPP1s+bvusQ6YTzgqj7
         TttVcwjlN+d7F8I0JJtSYUymvE5ccjpSf+ZyHQ5YeJfQSS8R8VMZp1VlIl1YvL474ue3
         X6tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742120098; x=1742724898;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kkh7Gs6f9tozVDWQHE00O73ERCRpoaCm7ZGlef2zJPg=;
        b=A0hx7unHEniOjw/sEmz7PVQn2SB8C0lKkNpb9O/p2UPLFq+mo7X7gwObr+XEl+9wIf
         61eXeeF/4IRUp/i0xLWXkiWRgV3wfgFPWfboYuA729+feJra+OyLCMGmCLIBt8E97Qdu
         0EfkIIeAurauxVnLLBTYjZ6KcKvW4s+/s+K0/COyiVlcgsGgaCyScQrU3UIIUlT0f7SN
         Eqr7Pq5a3aq4b7ugdCZI7SKLhD5laDc6yxcs7/DSQxSb7rj4X3ronJiZWExpsrjRyD41
         Wneg3+q9SEQyR7qZ8igC3wGQDVqNyWRgagJgLXpV/5Mlp4iPolc8vmzJKdFJgFRN8VHm
         QzTw==
X-Gm-Message-State: AOJu0YxeqFKzBRVytWZWC6yebOBaY+ODIkHitT3bS4DzyfYIKmOU3a7g
	T+ZOFDkxWyeqoxIkH417ZlLtJotnu7bvJiZmI6QgbDwxwAh6u2my
X-Gm-Gg: ASbGncur6w/y/3EHGDOmk82tnyO3CgVXdJ96RZZspK+kPOGoC1VTzQf8H9/2GPkFqDQ
	x06MPwzmyE1lfleF8xiS/E5ooEEcVoSUTKmZ28qarSFkiIz6ujgQNLoEFpmMexpfDANOm26EtML
	0QV1q+4l7FSETRlq5Nmj0ZlYzNm3O00aT7Jx7KHzu5h3USOxfEeuus3ts2kymDvlTOnvVLPwZPL
	zLyNZUcPyZRWbpweLhkdEhDJ/6lotYj017736+GceyMQwCAry3SnJ9LRKK1r/3AXxlNR/XVZND4
	oJq6vr72kUanwNMeB36HUE8OwLYyN751Kz9XtPU3xLszwbbCnItaSmrzHArAkOpWUqj1rbZe3D6
	5wUMi6GjLUR9iNCM=
X-Google-Smtp-Source: AGHT+IG9nE68nzjKhm0RjsJ+6H+XAk1wszSlGvw2UnNxBNZ7UL6CVUdDHqDXQNdAuRSuz7iwC7Jvug==
X-Received: by 2002:a17:90b:3d85:b0:2fe:a79e:f56f with SMTP id 98e67ed59e1d1-30151ca0b77mr10485473a91.13.1742120097932;
        Sun, 16 Mar 2025 03:14:57 -0700 (PDT)
Received: from ?IPV6:2400:1f00:2:fe0a:50c9:c0c5:fb7d:882? ([2400:1f00:2:fe0a:50c9:c0c5:fb7d:882])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30153afe73esm4447800a91.25.2025.03.16.03.14.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Mar 2025 03:14:57 -0700 (PDT)
Message-ID: <a720058a-f8cd-422c-a8c3-af7536bfc880@gmail.com>
Date: Sun, 16 Mar 2025 15:44:54 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GSoC PATCH] pathspec: fix sign comparison warnings
To: Junio C Hamano <gitster@pobox.com>, Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
References: <a3aa5f99-63ce-4be5-8d64-fb6e226b3bf9@gmail.com>
 <CAOLa=ZRNJD7NqceGQ4B8ox+50m2q1nU1t29x7O0roc=-_4ww0w@mail.gmail.com>
 <xmqqcyelq714.fsf@gitster.g>
Content-Language: en-US
From: Arnav Bhate <bhatearnav@gmail.com>
In-Reply-To: <xmqqcyelq714.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Junio C Hamano <gitster@pobox.com> writes:
> Karthik Nayak <karthik.188@gmail.com> writes:
> 
>> Also a bigger question is, shouldn't the type of `pathspec.nr` and
>> 'istate.cache_nr' be the actual change required? Shouldn't they be set
>> to 'size_t'?
> 
> Please do not blindly advocate the idea that size_t is always the
> right type for any countables.  It is not.  
> 
> Platform natural way to count things is either "unsigned int", if
> you are only counting, or "int", if you need to be able to signal an
> unusual state other than "here is now many we have in the set", like
> how index related functions uses (-pos-1) to signal a location in
> the same range with different meanings.

I did notice that negative states were sometimes used for such things,
which why I said I didn't want to do the change to unsigned, it would
be too complicated to change such things, and I do not think any
alternative would be better.

-- 
Regards,
Arnav Bhate
(He/Him)

