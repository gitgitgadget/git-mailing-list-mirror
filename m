Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DED200CD
	for <git@vger.kernel.org>; Thu, 29 Feb 2024 23:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709247607; cv=none; b=VFd8hb4eCfDCTsMappNm8MIY1T59bF5lUEuKOP0mdW8MeeQwNu06ejdqyCqOwBKyxtec6U7l5KyixPKWBh190+cfdAxmu9PqctCV3+P7rObTxoP5i93ipUMb750H0fsIRjkIR0YOZr7CCiJi7+IaJ0tMEQFH1JW0x70D5HlWPpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709247607; c=relaxed/simple;
	bh=nuOA7DT/7KwZqaqTU4Ffun3V+s70lkwAF5OD8fSgxFs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Pha00OjU5LpI4YtKJiPNFTa/Ngh1A0/9EMsm68d02BivPUV4cQFs13QxHMkSOVLGPD4IK4c7b4S1P8WjdyuZ4fQ2Coeho/hIuHijsh3c/WCDM15nni4UMw8q1v0UK2U6ReCLIEkKZuEUMY8myhS7ZvUUa3BRDy3m5i43tuL1C78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J9NOXVCh; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J9NOXVCh"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-607e56f7200so14989227b3.2
        for <git@vger.kernel.org>; Thu, 29 Feb 2024 15:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709247604; x=1709852404; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nuOA7DT/7KwZqaqTU4Ffun3V+s70lkwAF5OD8fSgxFs=;
        b=J9NOXVCh90AHNytqkPsaWKV3HhUhCIqYI55ZxO7YRyC2w0LLMO0fiBm0gGF28feCeE
         l596RlEYooCp4yJRNjrjozL3bq0SLXfNXUMq0jjjE87QjfykgVF/s8Wf1f5hwLR8F+l9
         vYqcajLJmlTcjSctSNuoqZGQKW8zqeR7U8yBF9jIXOOUfbaBpnSrMfptq5MxNQFHYqDi
         pK0GKext8cBJ72EIGD9C++l4nuEjB3ZBHvtfzosP6vicbtRo7lfzyV9WPsWtGN22Fswe
         pqfFyN/pQ7Ik/Se9ptWhSt6X/7ZgBKtB8DiReP0MzdMn91wZbC1DwbIn55R6N624HiBJ
         pEiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709247604; x=1709852404;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nuOA7DT/7KwZqaqTU4Ffun3V+s70lkwAF5OD8fSgxFs=;
        b=b6kphEdn9iFywbKXMFGGKTnSIzMbgVFETD+UKLzoZ9G5BY/RzFjTWKSUi5fer0HwXU
         fXx2oenxzrXqkE35AKnGv1an/C3V1GlpWw4aM/p80lGD8pfIOXhsSnvlHndJ/UcgPfg/
         pwRYLOYSE/kzmoXiQQSSEOs6737EqNEY8FzHXA3NiPvPlhqiEPJxcgBLRB2EeSsiFA6h
         Gyxw/7L5ZU+C+foy9ZqVOLAzVgyyx0QjGCiDfsZ4EjOsSbxUA/Fm4MuXTorNGXX9DCH/
         ZhSpKSUqJNTz36fpPX1vGURNKCGlE/LCGLnfSBPpXoVJjPb0DKxWsK6KUWULg1/iTYGQ
         1I3w==
X-Gm-Message-State: AOJu0YwRUqHTp70ePV6+0D+A5+4NPIbf6KLK2CZeNfQU3YC2obGd/Yqo
	yWDLBGHcsG8MFfSseOayVGiQLZ/lqg1Cy6gYsBH0+Cm1jFBhfB/y6v7osUjBXUqJAnk4vHiZ1qb
	Tsg==
X-Google-Smtp-Source: AGHT+IFncq7VUgzmehxKc3tEuLdaQbksBgqfVCQ2lbr/PLuXE7C5rwPewooYuQrK3J2sjlCkDFF6MJrHj9w=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a81:9907:0:b0:609:e1f:5a42 with SMTP id
 q7-20020a819907000000b006090e1f5a42mr85025ywg.2.1709247604709; Thu, 29 Feb
 2024 15:00:04 -0800 (PST)
Date: Thu, 29 Feb 2024 15:00:03 -0800
In-Reply-To: <CAP8UFD0JV8VEC-MDu86Mzrya9G7JBZaP2vXjFKwcKddEkh=y5g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <pull.1632.v4.git.1707196348.gitgitgadget@gmail.com>
 <pull.1632.v5.git.1708124950.gitgitgadget@gmail.com> <7c656b3f77546ae917ff192031c62d4521d9df8c.1708124951.git.gitgitgadget@gmail.com>
 <CAP8UFD0JV8VEC-MDu86Mzrya9G7JBZaP2vXjFKwcKddEkh=y5g@mail.gmail.com>
Message-ID: <owlyo7by511o.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v5 9/9] format_trailers_from_commit(): indirectly call trailer_info_get()
From: Linus Arver <linusa@google.com>
To: Christian Couder <christian.couder@gmail.com>, 
	Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>, 
	Junio C Hamano <gitster@pobox.com>, Emily Shaffer <nasamuffin@google.com>, 
	Josh Steadmon <steadmon@google.com>, "Randall S. Becker" <rsbecker@nexbridge.com>, 
	Kristoffer Haugsbakk <code@khaugsbakk.name>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Christian Couder <christian.couder@gmail.com> writes:

> On Sat, Feb 17, 2024 at 12:09=E2=80=AFAM Linus Arver via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Linus Arver <linusa@google.com>
>>
>> This is another preparatory refactor to unify the trailer formatters.
>>
>> Instead of calling trailer_info_get() directly, call parse_trailers()
>> which already calls trailer_info_get(). This change is a NOP because
>> format_trailer_info() only looks at the "trailers" string array, not the
>> trailer_item objects which parse_trailers() populates.
>
> Is the extra processing done by parse_trailers() compared to
> trailer_info_get() impacting performance?

I was going to answer this now but I see that you've already reached the
same conclusion as me further below. ;)

> Also when looking only at the patch, it's a bit difficult to
> understand that the "trailers" string array is the `char **trailers`
> field in `struct trailer_info` and that the trailer_item objects are
> the elements of the `struct list_head *head` linked list. It could
> also be confusing because the patch is adding a new 'trailers'
> variable with `LIST_HEAD(trailers);`. So a few more details could help
> understand what's going on.

Makes sense. Admittedly, this is one thing that did bother me at some
point but which I forgot about as I got more familiar with my own patch.

I will avoid shadowing the "trailers" word (and maybe at least add a
suffix or prefix to disambiguate it).

>> In a future patch, we'll change format_trailer_info() to use the parsed
>> trailer_item objects instead of the string array.
>
> Ok, so I guess the possible performance issue would disappear then, as
> populating the trailer_item objects will be useful.

Yep, exactly. In the larger series (some 20? 30?) commits down the road
in my local tree, I have it so that we remove `char **trailers`
entirely (because we should be using the (smarter) trailer_item objects,
not raw strings, where possible).
