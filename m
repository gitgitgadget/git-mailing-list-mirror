Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B791A681E
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 15:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786116503; cv=none; b=jW0N4CQ8sv2yICIwayFsEKl9ERIQMHIcoKNRiOex93JGdzURRBpjL96852IxNd3Hz+Wu8jDwM6Tj4FKKi9oL73V+LQoIjMGFYkseQOlOceTLqtX4IGYyf4fj1JL7bW7viW938LrQ6smEJ3Cyq4KTVL0Mwr24z/q6bzIK/qYVFRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786116503; c=relaxed/simple;
	bh=ukHAMhkJG60JHKgXLbObHb+c4Fbs47mdiszBtwFXW9I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XDzhFvzs3csfyD6LlA3qDUDkBKH7GKOpIJ8CGft/Cq74sH/Is3xcAiqbGeXsXh1C0j2u/ZGbsxtPtgE0D5umyYdc5dJrWQlIPbNlJS/YiAsDdCWRCvPKSUP3zsakguot5ss2Pk2cZed7rwi7N5dQldERPfr/nhUgGDZhzIUCxCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BTTxHVBD; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BTTxHVBD"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49557167508so31768785e9.1
        for <git@vger.kernel.org>; Fri, 07 Aug 2026 08:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786116500; x=1786721300; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DfV9sdwGSkHkwdJbanwmpCjRnvSWObDW59T9WHNtWIo=;
        b=BTTxHVBDRkEhqg81dUHMMbzCxwqTKZhmoI3rV6RueVFtbroXIyCRyzwnbYWGxjuU9G
         ao0AgNo29hfmqTwv+hW2LPDiXXiDIdK5q2rnNOWgHF4KvBeUgXk/sfUpr5llShWjeqts
         LHZKHqKQgbj5LNcDNauKi/vBEACSBky3HOHBzAoN8SwlRwYYbFvJ7CQ1sxbKAKYKob3l
         gEInnSuUYQtPWoRtpvGRcalDEJ87BvS67315ndaBpQFx94Sx4izfxaT/68dv/trtoXYz
         42Jgite7iWYTX8Czf2CS02dd37u0Arc4dVxMWnQ+gn1YueawhxQmPVkzKdF4+IL9oHQA
         LLWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786116500; x=1786721300;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DfV9sdwGSkHkwdJbanwmpCjRnvSWObDW59T9WHNtWIo=;
        b=G1nN5xAf6hdjtkqeVb3COI0p/0+Oc1ZNtcVA/fkCh5rvQbZjdyHPFcJIkuxo1f9DdA
         v+/yX62tcB9eUkYVTiwfFV5vqCCbYnNTKP5Z1qHAxciYgQ4CItc3Ag4VJtgkZj8swT/X
         swFPY1gTfx+PVyzY0sK2n6ODLwPV/wZ5UHPXDCkPkOn+vsOuT9gtuQKxxbijOnp7EPjX
         Vg91GAJvrkxMR6nhHEj4zEpyx1IrW/3avO391pXOBXStC01wDv5LVVYhjf4ELAlr7zCv
         4CNvSdp9d0gQ52m4h9CiyzTnLTGIt9qqIpnP1I5Xt1N1dkC72f6dUCJEaFBVIiELmgdG
         OJkw==
X-Forwarded-Encrypted: i=1; AHgh+Rra3rGimi9GYwKuCieNxOYuOvwqUU7roAiR4O79gpF0P12QbMnf6JgvvG0XOiIsIOPrj9E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDo+Ip8Qsb5eov1y8r1vM6ZDgTAqQOHJy9OotHAxJ75Ki6bjeZ
	OwcYzC5WAqS7r0y9ob4JBFQItl+U4QcjmW7LWMzkY5aaOEzacoCO7vUs
X-Gm-Gg: AR+sD10CuWA9tAfnK9psrVf0V4bmHd/hpMUS2CKigSueXWqn5QXniFR2R6BKnrqMHnz
	92HhfrRDKHFCMrSeQrtTMNSRV4pJTe8UqO/n0pI1WuQM9UCwJCKMNoKb7OEwKhVKSVcWzhoAFSX
	I0uHTTWLiDD7dqFNS9jEb976ptgm4qruuuWJDuIsXhVg96N4j7QceVccoeSHzL6xdwkl0bG8x0A
	VqquTE/5AJYBkKuV8MYDF6Vnv/qvIX/HoOHUqSygUTJiSVqZ2do0hcDqztQaCx57qxO1s+9dC1G
	NNaRly5WuEst+lDuxuDNDbqEwAqaZ3G+WWSGIOKCWpQhtZ0rBIlzsAinYbp4l2Y1MlK/gqKO7SA
	aHXUxUj7gO/RHEGBgkOK82/AYKSmTEgKFwA6PP8IRZ+f0me2xTZH3AoYUuIulJ2WKYwnscibCo7
	LWLwQ8sJWEH1DLKyo+2nKuAxRqyTz0YDDQaGg3mco0WqzdMtiTRQiG7D/RsrVVaj0yigA1PsW8F
	dl/yCD9ZxaJ/xMDindKyTy4dTaFNYag+z0EZTHZZ3YsoNfqIyCi3A==
X-Received: by 2002:a05:600c:3b20:b0:499:4893:97d3 with SMTP id 5b1f17b1804b1-4994e7cb8ebmr285678685e9.13.1786116500183;
        Fri, 07 Aug 2026 08:28:20 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d? ([2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995e9f0230sm44170355e9.6.2026.08.07.08.28.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2026 08:28:19 -0700 (PDT)
Message-ID: <1eba5fb2-ab76-41e9-955d-e283256ad25d@gmail.com>
Date: Fri, 7 Aug 2026 16:28:18 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 1/2] rebase: skip branch symref aliases
To: Junio C Hamano <gitster@pobox.com>
Cc: Son Luong Ngoc via GitGitGadget <gitgitgadget@gmail.com>,
 Erik Cervin-Edin <erik@cervined.in>, git@vger.kernel.org,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Son Luong Ngoc <sluongng@gmail.com>
References: <pull.2126.v2.git.1780482436865.gitgitgadget@gmail.com>
 <pull.2126.v3.git.1784708107.gitgitgadget@gmail.com>
 <b9a01e9141d580606527cb1a658c7c72710fb013.1784708107.git.gitgitgadget@gmail.com>
 <5bece313-6ffb-450b-add1-29652b64de10@gmail.com>
 <00e529b6-7ae7-463f-a4b3-0991e9411aba@gmail.com> <xmqq7bmhycxq.fsf@gitster.g>
 <8631114b-aa6f-446e-9710-92c400320eac@gmail.com> <xmqqpl07fb1u.fsf@gitster.g>
 <61291144-60da-4e37-83ef-fe09e91c4f51@gmail.com> <xmqqwludan2m.fsf@gitster.g>
 <0844b4e0-679b-4c0a-bea1-5779b4d0489d@gmail.com> <xmqqh5l7huuc.fsf@gitster.g>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqqh5l7huuc.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/08/2026 21:12, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> On 29/07/2026 15:26, Junio C Hamano wrote:
>>> Phillip Wood <phillip.wood123@gmail.com> writes:
>>>
>>>>> But that was about a low level mechanism that must be more lenient
>>>>> to be usable as repair tools to recover from such a broken state,
>>>>> no?
>>>>
>>>> It checks the new value of HEAD, not the old one so I don't think so.
>>>> The commit message talks about topgit using "git symbolic-ref" to set
>>>> head outside "refs/heads/" - peff had previously tried to tighten it to
>>>> reject non-branch refs but that broke topgit. I've just had a quick look
>>>> at the topgit code and still sets HEAD to point to "refs/top-bases/..."
>>>> by default[1], although there are plans to start using
>>>> "refs/heads/{top-bases}/..." instead.
>>>
>>> Ah, that name vaguely rings a bell.  Is it still in use, and now
>>> they prevent us from forbidding funny characters like {} in the
>>> refname?  Sigh...
>>
>> Yes, it still seems to be maintained, I guess they chose the funny
>> characters to try and avoid name collisions because no-one would want
>> them in a "normal" branch name.
>>
>> Thanks
> 
> I guess I dropped the ball here.  So given that we are OK to see
> HEAD pointing outside refs/heads/, this subthread should be closed.
> 
> My understanding is that we still have an issue reported by Erik in
> <amSSYagL0jTgzElD@mbp> that needs to be addressed before this topic
> can move further?

Maybe I misunderstood but I thought Erik was pointing out a bug in v2 
that was fixed in v3. I do think we want a re-roll though for

 >> +        /*
 >> +         * If the branch is the current HEAD, then it will be
 >> +         * updated by the default rebase behavior.
 >> +         */
 >> +        if (head_ref && !strcmp(head_ref, decoration->name)) {
 >> +            free(resolved_ref);
 >>               decoration = decoration->next;
 >>               continue;
 >>           }
 > [...]
 > Should we be using "resolved_ref" instead of "decoration->name"? That
 > would explain why this was moved and would makes sense as we resolve
 > symrefs when reading HEAD. When HEAD points outside "refs/heads/" 
we'd > then skip updating any symrefs under "refs/heads/" that pointed 
to the > same ref as HEAD.

in [1]. I've also just left some comments on the second patch

Thanks

Phillip

[1] 
https://lore.kernel.org/git/00e529b6-7ae7-463f-a4b3-0991e9411aba@gmail.com
