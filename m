Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B153446A7
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 13:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791552873; cv=none; b=VF/P2jEH2jhx5LcIU8K44JVArMB6cjvBkyT4iu3KQ9rYXzM7u+55Q0OmwPndIDKGV4Gn916vfel7cANinfria6tfwB9kydlDceo1dWaNHxcNkI6tvFt3mo+zvonqqGrjo9veAUwPOM+U+895k+G384YP+jqXdGylQKy/B+MOZxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791552873; c=relaxed/simple;
	bh=JrsKYmNzwYdrFOf2EnN/2db8K05YYJIzis5ztVTdz2k=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=buUuTGx0W25HprfNMYpbPWR8x1LkFvpLUN4U7gQApm8uzmrkbjKqy+dJd99APagqeNrwlYezdu4CP1LmEZ3E4x1lTQgrtQgRdReCNK4oWjWSV1cwRX8u5f4Ju2wWKEdekHbwu8c/lNqCFT8iAqecp0MhxVR9ofmHSm3Q+5Rjq+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GHBIm7SX; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GHBIm7SX"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a021c809e3so40661475e9.0
        for <git@vger.kernel.org>; Fri, 09 Oct 2026 06:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791552870; x=1792157670; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=r0sKrQ6h4I8LjNy55Px+q+JoZ3ZQUPuto57f1PoqMqQ=;
        b=GHBIm7SXimtm0UkYnaPRifBgBX5H5Xuf5t9t3ofrNmNAn+ASndLvaQ4ejCLlRgKrRM
         GlAk1BZ9ZrYAd/sAztnMVLHBwT+hfajw7M8wyrT7Ls4yEQWYPJ1wikNEdhQ8LFa28hLX
         h8Bx8FhCyjwZ4zXiF5QcBIl3Q3w7MU/UxhmnykhHAg5W8XvSy8QpyqDtlICPuvggKnIb
         0FIzh6Yoq2Gg82ToqWb4bzVbfCJrvi0/G95pXueAlxtEvMU3Te9q/TjPnd24/Gk9TR1V
         YUHkyCWMLB8HxIucicr8KpIo8EGQNYoB9X03e6w7XD+TvN9KkIWJGeKkci+dFDQSG3PS
         k1EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791552870; x=1792157670;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r0sKrQ6h4I8LjNy55Px+q+JoZ3ZQUPuto57f1PoqMqQ=;
        b=FXih2oeO/PP0m6evwRzA/4EGWIZZJ6v+25dTQYsVg+L6r3+5WQFCibn1dEMUcpYDnm
         hG1r4di6uOLbea6TXG7+DpILeSEXRvzWjk2k7PDuPJod6azh0O4gCl7jEaQl1foBS3Yv
         ZOqyazmySNC3dRdhoYZMSlDD8Sj+LJ/gM48q4/GUf2b+UBlC3foeh9j9jJ0MPCIJWvzF
         /wlmU0kF1o0l8c9R8lYaBd0tEl58oUFcIDadC4PFPE4CjUz1Bd7fssgLiBMuXJVlg6bW
         tCPscuvNmaAc8TzPj4JjlXjSKeQwqGl+lR6As9y39n0H2woI8CkPGtjGh/F+gYaqIRo5
         8Aig==
X-Forwarded-Encrypted: i=1; AKwUvByxNrPcKB8kn3jOl5+PA6wCpE/71MJ5dPnA5Xf+XQE8vzviv8/gIbIWzE4eG90k6wN3PFQ=@vger.kernel.org
X-Gm-Message-State: AFuF++l0M98W36ZGtRM7IgyfGdP2gkTQ9NJ4HQbyz3NxYu1tVE/2Q9uH
	oySc39oGuNf86hxVxM5JeURdWmSfRVCyY4gIZ2bKldu7LY7bN3fvgObx
X-Gm-Gg: AYBFou2YaUW/O7KpkSOYvt9HffVJxMEqAtQYNA6/G4Cmykasxv0SRMl0Xaxm+XDz8qg
	FOld1xSQLVqraXhqmvZ3HpvdGJ+n78JLdPsdfcfricKM9U4+fhweiQWjD9fjM/PjnNGxwxVK8F8
	CG/OxW92JThRwJwZ8x4vPVGwDQmSmCQN8T07/XD8CuLtqsWq0bSa/By0JrzW+iotC7CLTXTMdhv
	sRuReja1e+gsvVVLqdtFr+pitZSfRYgIOpiYEJpvcX/pBunP+K6Ai6xbnrv3gfC5vxzgfiyVVvh
	KQNP859lSiyHQqIdyO6iS8B+/aPGX3JQuEiwUxLv+wIMt6VO4Vxgc7AKoN4NtjSFaVO5EgGFZb8
	7KEyRO5rO9QCeo2sn8TQyW4gKEImpFhOvALAiR8OOj7idh4mQ456nYNj2NBNEGU8xqmwB58c9z3
	skqhqjF/SnLeFvWQRaqU9Oy9lAG+VWnLlFEjC2M3ZWUZwDTAYx50QK3vM/NmO50YZ0+HRFxVFIR
	kBMrDK81UXOvaXQAERJRtlfdp3XCZCJovromxlgDXCwCqwgJWVs
X-Received: by 2002:a05:600c:138a:b0:4a1:7bd4:d07d with SMTP id 5b1f17b1804b1-4a18e4c85fdmr39166645e9.34.1791552870118;
        Fri, 09 Oct 2026 06:34:30 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18e4225f4sm67362245e9.0.2026.10.09.06.34.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2026 06:34:29 -0700 (PDT)
Message-ID: <da5d6d28-b64b-4cfa-9998-93c69720b3c6@gmail.com>
Date: Fri, 9 Oct 2026 14:34:28 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] branch: let --delete-merged find squash merged branches
To: "D. Ben Knoble" <ben.knoble@gmail.com>, phillip.wood@dunelm.org.uk
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Harald Nordgren <haraldnordgren@gmail.com>
References: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
 <CALnO6CBwWy3aafyDJPKFk5vuWy2EF1n1Oc=W7+RVAE3rxpXwiw@mail.gmail.com>
 <39a28064-1698-4971-a80f-4a4c4dcdd8d9@gmail.com>
 <CALnO6CB2qPtv6Cr4LL1x=ZPmD_zLw1GzLUKgXE-NcTWObbiLkA@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CALnO6CB2qPtv6Cr4LL1x=ZPmD_zLw1GzLUKgXE-NcTWObbiLkA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Ben

On 08/10/2026 18:51, D. Ben Knoble wrote:
> On Sun, Oct 4, 2026 at 5:54 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>>
>> If we have
>>
>> (topic)  D - C - B - A
>>                         \
>>    (main)    M - Q - P - O -
>>               \          /
>>                 - - S - -
>>
>> where M is a squashed merge of topic I think we have
>>
>>       M^2^{tree} == topic^{tree}
>>       Merge-base(M^1, M^2) == Merge-base(topic, topic@{upstream})
>>       $(git rev-list --count --right-only M^1...M^2) == 1
> 
> Perhaps we are thinking of 2 different things? In practice when I see
> a merge created using GitHub's squash and merge option (and, I think,
> also when using `merge --squash`), there is no second parent. You
> could instead just get
> 
>      (main) S - Q - P - O
> 
> where S is A+B+C+D applied to Q (i.e., closer to a cherry-pick with
> --no-commit).

Oh, you're right, I'd misremembered how "merge --squash" worked.

> And we know that S is not necessarily tree-same to topic's D, so…?

I agree we need to use patch ids rather than trees in that case.

Thanks

Phillip

