Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24DB258CFA
	for <git@vger.kernel.org>; Thu,  7 Aug 2025 14:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754576241; cv=none; b=MlCP2d6RN70vzFzlJ7XJ4+kiIF5cQ72jTM67DDChb3WphXbpOmYQnRq++UVLKN+K++d1NWmjrR+gWV1yt3rlTsVnCFDR2fjjXPH1rEW4A3J8Qi6CgtH+L3ONGxdmFka1B/c2bJP9XajMrIvza93BBUYgruGNKs0wUZ1NcJjagyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754576241; c=relaxed/simple;
	bh=R3+qOlz4yDVv7u7BiWn/3SIefY7iKjq1po29cI8CRvg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=snmn9LToPyKeRqRupjbjh3iwF5+4lXg72+/tF1XRxcmUeJh+MDobz/TnYu5dRYoSs56lsMR0bHjNKEbnyPYYpGsPHeZXe0dxrCmttxCCShWF843z/kHBTXMkkZxAvWM61uMgFxUtnf6Dug+Ktqa4jrpvzbGTby1TTPo3MRMmXdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QvsF3KTt; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QvsF3KTt"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-458ba079338so7815455e9.1
        for <git@vger.kernel.org>; Thu, 07 Aug 2025 07:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754576236; x=1755181036; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=j5b1An31EmqxOvZGIHI4Kl6IJJ4nu8samzcjyquGwZE=;
        b=QvsF3KTtYjveyynvG8JEvoirYVSK2Z0CuaD7WizLU1YjZZ8o+8CYGTb+YVH25sUgZ/
         B+Lx6t9ChIvHjCIPdYOQomHXLzzopUFucvK33fyYxS3hYjWPzFrCt+aqE3MfsGt93IGz
         xCXL/wLP41s8xd504+xsWxrJ5vaZzkjx5En5kxes4yaX9FksqrBh6buM2AxyathCjoNU
         SkTTFQrXB1kbR0YNWSeEEhNdHZNl43365j0J6sHnK9qfy7K3MyM4N8Iz2uqVTPp7iTtE
         NrTMAAqZrieU0Aq5nK/DbA4od8tX0oL74OMVPJds2pHN+TJBLVDfCvDIyaiKu8tTTloN
         mnDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754576236; x=1755181036;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j5b1An31EmqxOvZGIHI4Kl6IJJ4nu8samzcjyquGwZE=;
        b=rCt1ZhYIZaia0vXDfAgIrGqpHObP/vNNKgp7qDV398QivVZCk6c2135cwH9yWvZayc
         5n+RWLQsatD7tfAKvCR1vvpkLkn5eUeM8177PkBZWra+ZzVGaL5MYwM8J7LgL2cbRtXH
         E0DbLkuers1r1VqHt1eJfE+K5/jDOQC1lSw8ru0A0Eny98j4q4mLHH5yMve6CWtfdlAz
         wcrkzf+tLcjDOJa+zkHEdcI1WqmNYwae6PR6J9scnVULi3G0TTif2DZEXkUJu4+ivHmz
         5HkXE8VvIOrycvXlZ3FBmz+BK4ALpfF6dknUmWKhQ+i8tGpBNImngAC/tPDEhqDiZlOs
         XYNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVy5SLdX7ehion9KiAckocizKoufUhuVKpL6gxrOeCM6vRuFAsrQRC3huYauJlUg4kD+HQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs1wkPGKBhwlgzavPghWnsPNFbuvic0U0azKtBeHjtS71FL3tJ
	WREwvWEmoWTr3BbL61xVkA1m4eh2e0JowDvBfftmtUgmSUW1/QlYvGC7T2d4jA==
X-Gm-Gg: ASbGnctCl6xUefK2Lfvya+UhsIBriOew4pOASlRZB8oMBD6sMr/3OsVh1o0OSOVbK6N
	zeJTgfAq7yrdhDZhI+9f+YO+OT+hPHGyL/PWxeoZg4YspkmjEYtIsVHjeEe7fJJUILVxbQ3oRng
	8qsVMeuwRftVWtaiYP9C6udNQlyuZ3WqQ1hBxgoc8Q+mrnjgI4O8NOToLR7YGpjuJ9aoJeVQ/F2
	xWJafT4hcvssjP+1h50TLoriSZWqO9aiIbYDS3melVMBo+6cwyZHB0O7NDivipP3yY5szQgWQTF
	1Cw+kDMZu4RQV/81k71tRdyvi6Qxfe2zerp/wh/VW2kgnUS9DxkXFhSQJn/fPoQzAHQH+Py5hle
	WiznfQzgPd70JwzezqGNbZA7QSkJWS5nNfIhBMS25FdGc+31oZVJjAHMyL3YLdQrW4RUn0qhX12
	lJ
X-Google-Smtp-Source: AGHT+IHiuwvR2BLE2ZZ4yd4Tt5ZM9j7aOfyuuGxemrPPIAJzMnrya0nltnaEVghyUN4J6zeisY2Z0w==
X-Received: by 2002:a05:600c:6211:b0:458:b4a9:b024 with SMTP id 5b1f17b1804b1-459ee0a9cb0mr39907085e9.11.1754576236115;
        Thu, 07 Aug 2025 07:17:16 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c? ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e584302csm103001445e9.7.2025.08.07.07.17.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Aug 2025 07:17:15 -0700 (PDT)
Message-ID: <582e8e75-c6eb-4845-8f3b-62f234f0964f@gmail.com>
Date: Thu, 7 Aug 2025 15:17:14 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] git-compat-util: introduce `count_t` typedef
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
 Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
 Jeff King <peff@peff.net>
References: <20250807-pks-introduce-count-t-v1-1-e96be52d8db1@pks.im>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20250807-pks-introduce-count-t-v1-1-e96be52d8db1@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

On 07/08/2025 10:22, Patrick Steinhardt wrote:
> Historically, Git has been very lenient with its use of integer types
> and didn't really give much thought into which type to use in what
> situation. We interchangeably mix and match signed and unsigned types
> and often times blindly convert them. This use has led to several
> out-of-bounds reads and writes in the past, some of which could be
> turned into arbitrary code execution.

My feeling is that one of the main problems has been using different 
types for loop indexes and loop limits. If we mandated that the loop 
index had to be the same type as the limit that would improve things 
considerably and without mandating a particular type.

> A discussion that regularly comes up in this context though is what
> types to use for counting entities:
> 
>    - One question is whether the type should be signed or unsigned.
>      Arguably, the answer should be to use unsigned types as long as we
>      know that we never need a negative value, e.g. as a sentinel. This
>      helps guide the reader and explicitly conveys the sense that such a
>      counter is only ever going to be a non-negative number. Otherwise,
>      code would need to be more careful as it may hold negative values.

The counter argument to this is that it is easy to write incorrect loops 
when counting down if the loop variable is unsigned. Using a typedef 
that hides the actual type makes that harder to spot as it is not 
immediately obvious whether the loop index is signed or not. As we have 
cases that do need to store a negative value then we're still left with 
using a mix of signed and unsigned types for counting in our code base.

> Introduce a new typedef for `count_t` that is of type `uintptr_t` to
> give clear guidance what type to use for counting entities. This type
> was chosen because in the worst case, an entity may be a single byte and
> we fill all of our memory with these entities. As `uintptr_t` is
> guaranteed to hold at least the value of a pointer, we know that it
> could be used to index into every single such entity.

How many sites actually allocate anything like that number of 
entities?Generally we use ALLOC_GROW() or ALLOC_GROW_BY() which means 
that we're not normally counting bytes. ALLOC_GROW_BY() assumes the 
number of entities fits into a size_t so should be be changing that to 
use count_t? If we're worried about overflows then maybe we should look 
at alloc_nr() which calculates the new allocation with

     (nr + 16) * 3 / 2

which which will start overflowing long before we starting allocating 
UINTPTR_MAX single byte entities.

Thanks

Phillip

