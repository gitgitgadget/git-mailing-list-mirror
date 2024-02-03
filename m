Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F81C4428
	for <git@vger.kernel.org>; Sat,  3 Feb 2024 01:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706924452; cv=none; b=pM/WS/IolkYI/F+8lY17BFIj7wZCRqaBllYHkeHb1m+Nl3cJpRfOxWtS+HPMv+ggnMuoc57A0XSVXURSm2zMsgQ6y3BC7wrpAFIb5jh32Q4bG1oVyd2u2H90Ht9kdS8dBwM9XV7OoYg4pA4LjR8kRxSHhwQxn0FmA9W+Hi5gxlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706924452; c=relaxed/simple;
	bh=BDoJPXwV0UoiRCfXKy5p9U9lm3YMy4T7TGa2VOtpLC4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ifEVyWBZegUDI7kkL2EFNNWb6iJQxqZFRW1U5aOZSowyxS1s/ySPNtYKUqbUkH7G8mTiqzPcBwjvtQZODwMG7x4kNLKHPR9AKOVVgf3HEhvCmmX9gZeEABE63ZnhPUJOhTTe4808lSGnbkmV7t7YJF73ijkPTrcSHuyns1jJLkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bu20HJNG; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bu20HJNG"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6ddce8ad5cfso2220369b3a.2
        for <git@vger.kernel.org>; Fri, 02 Feb 2024 17:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706924451; x=1707529251; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xK++e/46NW6VD/+nykK7frBybetl0Ptn6cdKPHpErEQ=;
        b=bu20HJNGTAN6LMlChKLN/Og0cYD0JjFKFCysWlBVHnyoOsdaw8OC5mCMABxtb6zRaH
         ognqXriq0LLu20uqKh0apMS7aI2uPO49lJa0eOqDT2/wMLjJ4sT7vNMfX/JEaWjLBpkw
         3jRHMw97F+BDHsLLXqYyjcb+ThaACQbUSQDo0barY3zGe5+FBgQiZvgTVL6g1VfAPMm4
         yC7RrVsSwf/dAy8+Q6I5Vw0JgZhVKfTgma2Q7WNAs2/eC6Pcuykza//s6P/x+mBA3rFJ
         bwi4aqn1/G9LYdnDlbUWgjZdzmtFkWyheO6HQnGlTyQ+C0JSWKYQbIQuaBCvaIutnk0f
         hz3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706924451; x=1707529251;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xK++e/46NW6VD/+nykK7frBybetl0Ptn6cdKPHpErEQ=;
        b=SoWH2c8VOAa7xFm04F+SyeizD70HsMM9QtkZXwyxyc3dPfQyY97VqLi9NOHNiLw19l
         n6rF+86yaVjwlXnZy9n9wyMI+5a1CJUgd+3ulOo+eLjMd66WY4x9ghw3T6/Rvd3Q3VLn
         8mNjRXEImFC9V6qKfa8r+5QY99gSy2AuymF2wet8ORgSIiqlooful17b+N2PZqqV8R55
         21GiJtpzU5ibZrmgAb3ulhX5CZKSTWe9QrFeHegvpWXW1J6z2aZQbDKQgTAqLIccUqZZ
         sWIpqNQ0Y5kEDKFdHOL02R4Ix1s9L1GdXE6P4vTrz3TbKachecLRJgEZTNvILGTOaQcH
         1+rA==
X-Gm-Message-State: AOJu0YztSfRlS/2xXxQ7ru93CcyXK5uwJ70qaBmFQCqJ55P8r8u3l9bA
	R/lthRBXrZhAYdJ1O927jjdKNy7FCfZ4uSdjv1hoHwKlMZ15Wns9sbSMd4rdZayJviQU1QLop0D
	WmA==
X-Google-Smtp-Source: AGHT+IGoLDsZ9yTkyB8B8RSTfPhBusdqY67Za3OjtY6NI0KB7o3fbhXDLpRqPcVOjy1RIiZECaSnvV5EGdY=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a05:6a00:d43:b0:6df:dba8:c51f with SMTP id
 n3-20020a056a000d4300b006dfdba8c51fmr266084pfv.1.1706924450770; Fri, 02 Feb
 2024 17:40:50 -0800 (PST)
Date: Fri, 02 Feb 2024 17:40:49 -0800
In-Reply-To: <xmqqplxfx1nk.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <pull.1632.v2.git.1706308737.gitgitgadget@gmail.com>
 <pull.1632.v3.git.1706664144.gitgitgadget@gmail.com> <885ac87a5447e54139171fb3eda62055ffd517cd.1706664145.git.gitgitgadget@gmail.com>
 <xmqqplxfx1nk.fsf@gitster.g>
Message-ID: <owly5xz61g0u.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v3 09/10] trailer: delete obsolete argument handling code
 from API
From: Linus Arver <linusa@google.com>
To: Junio C Hamano <gitster@pobox.com>, 
	Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>, 
	Emily Shaffer <nasamuffin@google.com>, Josh Steadmon <steadmon@google.com>, 
	"Randall S. Becker" <rsbecker@nexbridge.com>
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: Linus Arver <linusa@google.com>
>>
>> This commit was not squashed with its parent in order to keep the diff
>> separate (to make the additive changes in the parent easier to read).
>
> Hopefully we won't see such an artificial separation in the new
> iteration.  As we saw, being able to compare before and after images
> in a single patch is useful while reviewing a change that is supposed
> to be making things cleaner without altering what they do.

Totally agree (and I'm reaping the benefits of this as well in the
smaller preparatory refactoring changes I've made for the next reroll).
