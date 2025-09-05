Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C2337427B
	for <git@vger.kernel.org>; Fri,  5 Sep 2025 17:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757094472; cv=none; b=G+jZ0K/wXbxv7C8z7fT+OvHXBdvcn3WNhOdH7VdM6TEaV9NKAmD8Nvno1HFKlS4f3Wuk3p2F80VUDHsGSXXbRAjxKa5zbIRhtFjBTutTTwTZ6egS1rO5kaedp2I3q3SsJBvS4uBTuRi5ACsBkvNw9nX7Xew02XvFOxNyiRhCCMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757094472; c=relaxed/simple;
	bh=ggw/GsUqRmFW3bjOrmJnd1QBfMYxDnBnOJ1OArj/VNE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=smossGkBkChS7Hw6UBYPaA5yXX+kag6TESQHLKWyeu2RnvNmF2DOiMKHh6yT4TfL62smUmxDgFM9Cq1J8/NTt1gL338jHrw+WAbLaea52eYonL0BHCeLxKT1cUKdYZ6H9RFWYQCP+lTBAjgOd3utWkKQDzIw/roJsQOYG1bfIzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ncJehayO; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ncJehayO"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45cb5e5e71eso13895435e9.2
        for <git@vger.kernel.org>; Fri, 05 Sep 2025 10:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757094469; x=1757699269; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B8zn4GZl31uQWlJP/Irq4LjXAax9t/NCZZFUhQJ6UVw=;
        b=ncJehayO3WpglavrUMg4auD3oFxQXCqqYexYd8xEY5LCyMDIFgkfRF1X9NsZI+5hxz
         AAiP1Q5A4E8M/3isYE1TGBI7ZrE+mzLlxFORBKwcIs2ahF4j/qt9LN1kIqFl8qeES2fb
         adgYu8eWB8tNgkNI3eB+jocF99WydBeCHI6tf0ZABbeD+ZGxMl6ADNhdBqaUPlzgKAIa
         VcnY03WTpCc3Pb2ks1KC6aJtwIU4QVrXcvjy2rQhIqcXm29SBNbdQ+3L+1zQPDTV0q1A
         DfXIOgO6v7mlMc2QAZbe0GegcVEL+L0pRT9sd7umE0JahC4JonknR3OuUulYK3Vuv8Qa
         qiJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757094469; x=1757699269;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B8zn4GZl31uQWlJP/Irq4LjXAax9t/NCZZFUhQJ6UVw=;
        b=Xxbhm84asFCcU2TKZ2l8xTArXnkVs5pD/j/FgkPJWaQ2E8N7kqpumtup3Zg2T0HbZl
         /useQlBXzwAz/o3sC1cUwrpb/iV6Lir4j+9h2kz9I7jf7V2DsZZmUg53gxtcF7jvsEjd
         m7p5RVczGHN+ya56oEK82dWoEvmS/cE7z3cToqHIWmRQw/5l0fAI/zwZnjApt5fyAoUz
         n3Lejs9vrOFgmfN2WLC2o6hsemiWENcycqIwCaLJvc+2USwxrhTdxKGPb6pmc3KIrl0b
         /lkyrnB3hLA94FaViONU4S8PSGGy/xwLimMolmcy1q3xspfZVyjb02OVhNNAlJTO0Zqp
         JTYA==
X-Forwarded-Encrypted: i=1; AJvYcCV5zxH0sAAqHRC/UUMwYPl227lVcumBzfkxBwvbt1m1a0sxBv0pmAc33XG7O0c0Np9zL7k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjg69lT3TvKXevCe/D56/dS8eNlUnvE4ZktFONpbfqtHlEzP0S
	wHqegV+qxFZZCzSqFLoT1GdtECCx87xv+Z1Pb8VMGWKxj4RmFeK/cNgS
X-Gm-Gg: ASbGnctSgHmfEBVE5w9S/nQ4QZZm6H/fuVlRcfueJ7bF4WKIivFrBxGzYatGThEfJc+
	Zfug9NfiroEmL+wAvihqfswq3qWyEqVd4krPZiba4JjTTAT5ButbWF6k5QSE+hO5l5Q4ZSFHTeO
	I88PEWfVGMAuZrNej0eVWfPx1MVnr1NxbQXmMdifjvIPCYTOolHjbx7PWbKIYoZNEKMFAjaE4cP
	H9cMr8nYMEbNkAfwjMolbGXuykrwIMuCYKf8+LVUxG8qWA1KavIY5XGuWUdm0+2Guc+2gWT24Fh
	EUiLKP3ltj58fTpiurI4LQV3ul+rADBUYv337evRuo5QhPIUF/A531eSCUlANlPc8yr1jtwAs38
	0657DRCYdkdcyvGKlr4jSvr2uo0JujwGnrqDSGsOw4QTo7BVO3K2dN3dAdROeD277Z6DBiApjDO
	rCHkYy
X-Google-Smtp-Source: AGHT+IEzbFEwQmoXXcMIZHBOpFVde0gyC5B5iyNxfAGzOyTp06JTRzFjNEHFWO0Tls+uzGCoe+zFgQ==
X-Received: by 2002:a05:600c:a43:b0:459:d3ce:2cbd with SMTP id 5b1f17b1804b1-45b8556a7acmr196832765e9.13.1757094468207;
        Fri, 05 Sep 2025 10:47:48 -0700 (PDT)
Received: from [192.168.0.4] (ptr-178-51-222-125.dyn.orange.be. [178.51.222.125])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dcfc481b5sm43995585e9.0.2025.09.05.10.47.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 10:47:47 -0700 (PDT)
Message-ID: <44ae54a6-ba49-40e7-b519-15c12cca0404@gmail.com>
Date: Fri, 5 Sep 2025 19:47:47 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] alloc: fix dangling pointer in alloc_state cleanup
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>,
 =?UTF-8?B?44OO44Km44OpIHwgRmxhcmUgdmlhIEdpdEdpdEdhZGdldA==?=
 <gitgitgadget@gmail.com>, git@vger.kernel.org
References: <pull.2040.v4.git.git.1756941427825.gitgitgadget@gmail.com>
 <pull.2040.v5.git.git.1757007856062.gitgitgadget@gmail.com>
 <20250904204932.GD30633@coredump.intra.peff.net> <xmqqjz2d7t2q.fsf@gitster.g>
 <52fb3fea-4842-4532-8572-df41537da5f9@gmail.com>
 <88ae6c7b-0a69-48bd-9e73-672331a22197@gmail.com> <xmqqecsl55gk.fsf@gitster.g>
Content-Language: en-US
From: =?UTF-8?B?44OO44Km44OpIHwgRmxhcmU=?= <nouraellm@gmail.com>
In-Reply-To: <xmqqecsl55gk.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 05/09/2025 16:39, Junio C Hamano wrote:
> ノウラ | Flare <nouraellm@gmail.com> writes:
>
>> By *s I am referring to *s_ so a sanity check with: if (!*s_) return;
> Because we
>
> 	s = *s_;
>
> upfront, exactly because we do want the code to segfault if the
> caller passes NULL to the function (so s_ that is NULL will cause a
> NULL dereference right there), after that happens checking the NULL
> ness of s and *s_ is equivalent.
>
> And the whole point of doing "s = *s_" upfront is because readers
> can easily get confused when they have to deal with double pointers.
> The only reason why we pass the address of the pointer variable is
> so that we can assign NULL to it at the very end, and before we can
> do so, we want to be able inspect the innards of alloc_state object.
> By dereferencing s_ early into s, the code can work with the object
> itself without having to worry about following double pointer, so
> even though if (!*s_) and if (!s) may be equivalent, writing the
> latter is more in line with the whole reason why we have a variable
> 's' that is separate from 's_'.

I see your point, but I previously wrote we could lean more towards

Strict contract enforcement instead of defensive programming

Which would keep if (!s) return; instead of if (!s_ || !*s_) return;

In any case, I believe we all now agree on if (!s) return;

Pushing it right now.

Happy w-e y'all!

