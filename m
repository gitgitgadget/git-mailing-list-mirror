Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62B84C89
	for <git@vger.kernel.org>; Thu, 25 Apr 2024 03:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714015071; cv=none; b=GQ51hkJtqKzWyBB0oq2y+lSpjVKuhSNO/BVLRBjIbjgJlvS7clZ3I7tjVPTe7164gGsXHcm8kO9FHKtE7ChGJCwHsNThre+bE0IiPwT9frUGWPfb0j48RWbSqhxA/tiZ47Womi2jxGpgP2wO6H14Ftqy52+eA6vWBg658/PZCfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714015071; c=relaxed/simple;
	bh=9C+RR/YUgjdaBTo4wWDtIcpTWkd4yKUQnRHZTZo6tyg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bTvfgZW0k5YF1/XBlRG4WPOgiGxJztd1zrZXJBDHlkVOHEPjwjSCm70fzzqc+BNh/CLG5msS0WA6T1zzZrdu5ECDeDE41NBuNxPXeNdO83771GzeFfLKVKqw/EMOfUTBLIWM83z/MYz8I1zhw+HFKBTE/tUmAqDSEo6VPx0lrUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OM+xSoEJ; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OM+xSoEJ"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61acc68c1bdso18271407b3.1
        for <git@vger.kernel.org>; Wed, 24 Apr 2024 20:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714015069; x=1714619869; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ujnqE7IGPNjE4I1HV4Z6NdATneu/GawQHJ60h9B5XXI=;
        b=OM+xSoEJNGGsP51VoSNofnCt2rT3gXuD9FFCAg5svGp6bo4LBIOrynE8yzse0oDN++
         5zn1DWHUp8hGAxzyXeMoveNgQzTu4q6G6w1lxc+/49nQN/MGj4ySqBLTvy+pGf1ARbdD
         8QQbPQrDyZmEBhnSUbtI0t6LmY09R6K13AT/D6zRSJUdlBxDHn57erwpBD+g6D/g5pIV
         mAbezxAEUtkE9cC1B3fpYoUj18WqpwDx1W64l05awNfW6kqQWzXy+lzT3HjXuxtQ3jCY
         4o/PTrXcBRBgVFhuBhyuZ/mE0dK8PhzBAS/BwBzKHuLojL95s8URBwGHbUr4SEKddDrt
         pfGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714015069; x=1714619869;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ujnqE7IGPNjE4I1HV4Z6NdATneu/GawQHJ60h9B5XXI=;
        b=cF5PpFl42da5b5UO100F/ahZ3Q9avKOiEjXsAr2TRzFuX9JNn/gaRJbYLHlAS6TjAM
         EjgxYDa+8mg4QZOwJbRSLMTey+YhpCOgRoIgMfExaZ8hfl/V1pcimSVVNk5aIHIDp5ZC
         17ZzCi+MN9mEgc04Uw1e9vkWaN4lCPG3C2r4TyX7p1cu7muoSHsS8vZIjxgXvYxdUq3o
         gDSFv9GZhfXNIUOE+QViafDj5p2iLQBIu6jF83itbXnOEXIjSXGviQbyK3nVNKFR30pg
         NiD/94U9Lsa90hqGH2LORdnIfhSldqz6aCR+/GfVLpHocjnLU2fElXtlJAdMcsjBvz1z
         HmAw==
X-Gm-Message-State: AOJu0YwX/HfgNssZZ278lcnwvpBJkSoHfB752fRM/rRjqKkQlEg1fhwz
	/Xw33QYnGjuW2fPVovQNpXZRI4lW8tQcs/xQGnQliuGuMWElEipOpYEmk/JrEg1Gl7Sg64aE7Bc
	AWQ==
X-Google-Smtp-Source: AGHT+IHLA8jXEWMCSgmNRBJfiXR/e6RBDLy9ZWmfVfbgfvgctBJClmS/pX9OiR/KkrzVOByTIeqEqPIE2uY=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a05:6902:1203:b0:dc6:e884:2342 with SMTP id
 s3-20020a056902120300b00dc6e8842342mr521649ybu.5.1714015068709; Wed, 24 Apr
 2024 20:17:48 -0700 (PDT)
Date: Wed, 24 Apr 2024 20:17:47 -0700
In-Reply-To: <xmqq34rb64oj.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <pull.1696.git.1710570428.gitgitgadget@gmail.com>
 <pull.1696.v2.git.1713504153.gitgitgadget@gmail.com> <0e9ae049b8861fecf49c097e8d52e734f7a9c9b3.1713504153.git.gitgitgadget@gmail.com>
 <xmqq34rb64oj.fsf@gitster.g>
Message-ID: <owlyzfti3zc4.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v2 7/8] trailer: make trailer_info struct private
From: Linus Arver <linusa@google.com>
To: Junio C Hamano <gitster@pobox.com>, 
	Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>, 
	Emily Shaffer <nasamuffin@google.com>, Josh Steadmon <steadmon@google.com>, 
	"Randall S. Becker" <rsbecker@nexbridge.com>, Christian Couder <christian.couder@gmail.com>, 
	Kristoffer Haugsbakk <code@khaugsbakk.name>
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> There are a couple disadvantages:
>>
>>   (A) every time the member of the struct is accessed an extra pointer
>>       dereference must be done, and
>>
>>   (B) for users of trailer_info outside trailer.c, this struct can no
>>       longer be allocated on the stack and may only be allocated on the
>>       heap (because its definition is hidden away in trailer.c) and
>>       appropriately deallocated by the user.
>
>     (C) without good documentation on the API, the opaque struct is
>         hostile to programmers by going opposite to "Show me your
>         data structures, and I won't usually need your code; it'll
>         be obvious." mantra.
>
> The comment inside trailer.c does not count (the API users are not
> supposed to peek in it---that's the whole point of making the
> structure opaque).  You'd need to compensate with a bit more doc in
> trailer.h to help the API users.

SGTM. I can reroll again by the end of the week to add docs for would-be
API users. Cheers
