Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7804C24EABF
	for <git@vger.kernel.org>; Mon, 12 May 2025 17:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747069453; cv=none; b=royD5tNNEkQStPVOx8ZEpJl2MXmrWMJfz33bxkNC9Lmk9MfXvtCcD41qpmf+5xnLxMF0NNwzpLQDGae+Ut47weKuwox2DsOPe8TWhBUrgvWL9nqlFyWYO1dfsbwjC9IqAYXIbbdxKlyMtrGsa+PmUyn25t5/5WV65vP6i7F8YIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747069453; c=relaxed/simple;
	bh=FNy1hT9m9uLOCsfWUJps4yJaA3sZc87CaZbUBuLD1YI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oHyJwBEsV73pnMz+2xu+YxeHCZm1utgqsrd1O10dFkx7ZxG3c9PUBCptcMPzqi2k92jM2mJckWC9DsJeMFI1tX6oy4pUvrwrNl91X0HPQ2ydJBXRdLJbSkReMgIKl/YbI7O7E6jfyRURlFCod/ZV+fxY5EP1ReGwfCZZGAYtpsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NyCKWFQ3; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NyCKWFQ3"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-54d3ee30af1so4789095e87.0
        for <git@vger.kernel.org>; Mon, 12 May 2025 10:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747069449; x=1747674249; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QTzRSqDsGYzd0eb2Z8TrNoHG7VoYnKRgnSqQ5aLS9Tg=;
        b=NyCKWFQ3vayAg/mYj3AX6mXbFpjJErUzsiego/tC5Y9kAf5gE/hrXOmbyFvy24ZQdv
         XI0pHfntVgUqiF8tdNKCsf0LWIwBKAAqoLJRTU7xcFRXHEpG/C1sfpTqFtxZduJnnPiy
         IqlTR9im03mXzAcqqdCiXQ75w+WOZDaGQltjmiCoxuszj7mqD+Zmm6gk4wyf8yC8DGED
         2sTqgZG34TzTk7ftZ4rfVzMMCXqmm3wj2ZudltQGRrvUtp0wOhK/cVfis3GQDz6PxkID
         mqsgQAzDX1AE0wkbnue5K/WTMayH98il4eZkPu7Ykix0JgzLAfCZyMcP8iSxJUHVP47o
         aU+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747069449; x=1747674249;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QTzRSqDsGYzd0eb2Z8TrNoHG7VoYnKRgnSqQ5aLS9Tg=;
        b=eKOWZp8Qr04FYHgUBhPUU0+e2SDVfMBAlpzGD21z9vLMTl0yEUqysBRSjGyEumbFQu
         WwoPwKRtyAXOXKOv9WPc+wuT6xrRJkCHzSzawRhtb2yhW6Hr4HTIx/6XdF6ce4oTtVR3
         RJCZMhhY1JS/aLhtdfbmuxcEPOFMgUtjk7Ko//NNGQpcQ7fRvvJj7L26ihVYC9CPMVPB
         krvjN0HarzTUkC/z4gCQOd0kapj+REkvQgtU0LqwxBIaXcJhEqQIi12+3zyTqJRxSEkv
         HuPCUQRBjqyBBJDGBlEDdp3gqM/TOlu1iu5YH+rJ4k7v2T0/snguNTWQAIDKxsXk9WTg
         GJ7A==
X-Forwarded-Encrypted: i=1; AJvYcCXq8oYArNJra5p8gKwb1+nX1DdV3E288uBjw7SSChtvc7Kh4AXge0bQBFtzAH8w1z+RFHk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0Fx0cPlPYyz6xq54QO9rEKt8PoUXXVr9OfKxI71sabG1UAsHo
	x9fqygtMJtWT9W5zHD9Kzlu56nE8auOvKC93Q7J3Hpx5fQ3wpLxOuzm6nXUJp9Ig6Uzs37DLNPN
	6JrgSPqDYhzCkBOLYtmUT+scDrED15MlM1Uo=
X-Gm-Gg: ASbGncuiQrIpHV0GefKxupgJDEmV4OFVWTRuLjCR6TP6+jlS8zYraErSe7oj//TqhYS
	jBTzbH6YpGUgtm9HWqif9u33CmWcNIhiQwuXFqWCpey+diWAwmsIxuZQROP6E82lDuUm2MAZHY8
	cX9KMePUk0EWBDfpXM713mfhLUr5V8c9TElNogpg==
X-Google-Smtp-Source: AGHT+IEkE69Zw6rN+MlLk9k2AkG7cFzZKAKyixKUwF8TyC9LrC5YeV2E7/o2MjPlB5MIPUfRXg8pV8evb/K8lj3MKx4=
X-Received: by 2002:a05:6512:695:b0:54f:c1ce:9bbb with SMTP id
 2adb3069b0e04-54fc67ecf35mr5065368e87.47.1747069449095; Mon, 12 May 2025
 10:04:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1915.git.1746436719.gitgitgadget@gmail.com>
 <pull.1915.v2.git.1746884789.gitgitgadget@gmail.com> <973dfadd1b3c7e214b14c75494b3b3b786227362.1746884789.git.gitgitgadget@gmail.com>
 <xmqq5xi5vkvi.fsf@gitster.g>
In-Reply-To: <xmqq5xi5vkvi.fsf@gitster.g>
From: Leon Michalak <leonmichalak6@gmail.com>
Date: Mon, 12 May 2025 18:03:57 +0100
X-Gm-Features: AX0GCFv9cVuUheBjIE1-iP-2w5MQz_t3Gb5K0sWyd1p6kWq-gYhgxvZ4aIAOGoo
Message-ID: <CAP9jKjFZ-JNwiMrMB2XFNWq45n-LrFfUvSQEj1QWiBRCjp_tOQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] add-patch: add diff.context command line overrides
To: Junio C Hamano <gitster@pobox.com>
Cc: Leon Michalak via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Eric Sunshine <sunshine@sunshineco.com>, 
	Christian Couder <christian.couder@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 12 May 2025 at 17:45, Junio C Hamano <gitster@pobox.com> wrote:
> It might not be trivial to do but I wonder if we cannot do better
> than this to share more of the same text across manual pages.  These
> two being options understood by `git diff`, we certainly have an
> existing description for them, no?

Yes, I did of course notice documentation for `git diff` also has
these; ultimately my justification for not changing that to use this
new .adoc include as well was for a couple reasons:
- these two options are not together in the `git diff` documentation
(not *so* important, and they probably should actually be together?)
- there is an extra if def which adds on "implies --patch" text in the
`git diff` documentation which isn't the behaviour the add-patch
commands are going for, so that makes the intent a little different
here

But would be good to hear if anyone else has any thoughts.
