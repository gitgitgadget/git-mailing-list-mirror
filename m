Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4490F212FAD
	for <git@vger.kernel.org>; Mon, 24 Aug 2026 10:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787568913; cv=none; b=HF1yBDWw/IgTLBRzW7M6OUfE6WmRfEBkfRsUN1uGVLdEVa9KqgI0DA+tiqzGMPEjPgShhg6dTTrkSVgiD6haD+PmT5FwYo+aVgPM9pY4+yeS6Ei7lLXtFqIHXqe+EGQUlEQxVpeMLnHO+tD96Po7ZSYAAK8imLhSMbGq4abuwsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787568913; c=relaxed/simple;
	bh=zUxi5G409bsKh3UBP1m4D1yo3oyiDICar+OoWvsV9uo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nKxkNZSroZ7ya/GoRkwWAOsSRZ3Ri116zOHoce8rOjTLdG6lpfKHAnN2JwmRGcbUpQ+B+YESdgyutgFAc4aJccQ6atng/l/uOBVJBKVzCmjerXhH4W5U6dmGk2Yr28WR3Y/2KATKhBVkpGD3NQsLKI1MDGwRYtNYi/e6FA1Y0Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=antmicro.com; spf=pass smtp.mailfrom=antmicro.com; dkim=pass (1024-bit key) header.d=antmicro.com header.i=@antmicro.com header.b=YkgMatzI; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=antmicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antmicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antmicro.com header.i=@antmicro.com header.b="YkgMatzI"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c214321dc32so647794966b.0
        for <git@vger.kernel.org>; Mon, 24 Aug 2026 03:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=antmicro.com; s=google; t=1787568909; x=1788173709; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sv1NOx0YN2GqcpNbyxiv7jjuZlGAcp0NU4/KmKxaU0U=;
        b=YkgMatzId4NUVKV3adjztsZJcE4GRJmCjmPl5udqi/ofGfb9In+45pVrUyiIv+h2kq
         LQ1K/lwpe6h4UqFGm9UPvMCjYDytyITLZrrVdlejIjp1ApAzGBS4qa1+dSC/HRcOSGRi
         dZao7Gib225pS7OeNiBo3tAVQs5bpAD42tMt8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787568909; x=1788173709;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sv1NOx0YN2GqcpNbyxiv7jjuZlGAcp0NU4/KmKxaU0U=;
        b=q9+gkNjnzKR2BbynyFwMXZrgRtdfZ+itUGek0lxAKzKiu0CSVqKsLuiUT32OXXZkqL
         gm+zGMCkPsqPkNvrFYZpoxaiOvCai3DOUrGAiWc3pMcBgl0hwoJ5DqFH00LF0ez+t9pF
         hTw7+6s+U3BYb1zaaeoFHyprI3GXhjIk4V53TAypziib4+nIh9/nGgMd57mj5FX1bWQu
         6rxFMDxbAYbtsrj7n0zVVhe4WLqtJngYFTrh9xlcP/iEUspCmlaKv0Pm34N+29sMLXqC
         KcfoOjZpycOjO4sMtpqZygSRkYwV5WWvhiG1m6mt88GuHn17Q5Fwgc4yplUax2FfcU8j
         uAMA==
X-Forwarded-Encrypted: i=1; AHgh+Rpp2Dc9E9taqMObtfOU5nQkQReGdlh0Xn8TN2Zyx0HmeQCabguJyoYqwPY8xxJgix6pFo4=@vger.kernel.org
X-Gm-Message-State: AFuF++lBAPuApKGDV3qoYuhXPT632qLR/4wfbQgpmZENYIaUwGRS+qQa
	z3NPAqiqTFaW9nC8ZMBA0lyWfIItqHv2tv3OJZMY8cahq6SilzmY9dIQ3bxvTAYVFWo=
X-Gm-Gg: AR+sD10avb6sixWo7dYBPbbVV0Q4B5Wx+lXUbYLxRJQRuGFIFLvSwUh/7flHtFmCDKG
	eBYDXXheRUncplIKTT7jiEsztOjRy4WgwW+BhjtV7sZa6CnZ/5vfuviCNzwzU8cE+gqDAkZn91e
	RWDbRnv9nZQHtxNj1jLd+ofAa/9aq5SzpXnvzpLYZ3d7XhptpaNwSAaZ/0O071YeZe7uEwwJm2Y
	EsPvx9pVqQPxROuHaOsDLkZxkOlnBBE7RsFGyJJxYgfU4m+idewZpEW4guHmCvtGvEpyC7t+CYC
	z3ZDYsM2tTcNwjcXF+hYiIFeYeLjeAl0vNSmNBdjJYEDRkV/QUXPb2V4OqLZPYRQRY9gCJris0v
	OaleOvPJx1Y1IA9SsZCz2ZtHyRqQ54OB8FLiOzIiCwm6cbqxgNipu4imDtY6QBInLH1PRiejWP8
	6Lk+q+Bm2sADkSbiVo8IeHuGrpo2dJ4iQYRAtlOHpu8g9usNk0lNRcfAUbCpFQyACpMcjxbuydT
	zM=
X-Received: by 2002:a17:906:f049:b0:c16:126b:98b4 with SMTP id a640c23a62f3a-c246a2ef584mr2792326166b.3.1787568909307;
        Mon, 24 Aug 2026 03:55:09 -0700 (PDT)
Received: from [10.10.8.17] ([213.17.234.100])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2496296cafsm1232597266b.14.2026.08.24.03.55.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2026 03:55:08 -0700 (PDT)
Message-ID: <248fc3ca-7907-4720-ab71-1cf5926b82a0@antmicro.com>
Date: Mon, 24 Aug 2026 12:55:08 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pull: add --hard mode
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Junio C Hamano <gitster@pobox.com>, Phillip Wood <phillip.wood123@gmail.com>
Cc: Koji Nakamaru <gitgitgadget@gmail.com>, git@vger.kernel.org,
 Artur Bieniek <ar2rekb@gmail.com>
References: <pull.2384.git.git.1787052873141.gitgitgadget@gmail.com>
 <xmqqwltn1o4e.fsf@gitster.g> <0c2607e2-16da-4efd-879f-82ef2c2aa127@gmail.com>
 <xmqqo6ewsrzd.fsf@gitster.g>
 <2b9cc581-7c8e-4cb3-9524-2b466209ac7e@antmicro.com>
 <fa62cf90-61ae-4352-b823-455ccffe403a@app.fastmail.com>
Content-Language: en-US
From: Artur Bieniek <abieniek@antmicro.com>
In-Reply-To: <fa62cf90-61ae-4352-b823-455ccffe403a@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/20/26 7:29 PM, Kristoffer Haugsbakk wrote:
> On Thu, Aug 20, 2026, at 18:43, Artur Bieniek wrote:
>> One case where --ff-only does not seem to cover that audience is when
>> the upstream branch itself is rewritten.
>>
>> For example, a checkout may contain no local development at all and only
>> be used to track the latest state of an upstream branch, but if that
>> branch is rebased or otherwise force-updated, git pull --ff-only will
>> refuse to update it because the histories have diverged.
> 
> I don’t understand what you need a branch for in that case. I just use
> the remote-tracking branch in that case (`origin/main` e.g.).
> 
> PS: Bottom posting is strongly preferred on this list.
> 
>> ...


The branch itself is not essential; the point is to update the 
checked-out working tree as well. git fetch updates origin/main, but 
leaves the checkout at the old commit.

If resetting does not belong under pull, would the inverse design be 
more appropriate, e.g. git reset --pull --hard, meaning “fetch the 
configured upstream and reset to it”? Or would making reset perform 
network I/O be undesirable for the same reason?

Thanks,
Artur
