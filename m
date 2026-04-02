Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8093D3C65E8
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 15:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775142628; cv=none; b=kTqumpATO+VoyCZLg8q4A1q4lNwpubAFAn518613fY1CCqA+EKF0uLbqP8lB7yCruSw5Psf5X4TqJ9NE99Cou40OYJjGkVz3bAxTZSSWl/d0tf8XT23LrqiwDxi4ydIc57TXu+Xu8x04W7d96+284QRLcFcTKDQlFQrPKR7lX1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775142628; c=relaxed/simple;
	bh=uTQ+50Mho+O4LCdaC49jw/R75klkC0B0tnjjIZoeQP8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=mzLlASjnmXk2TLoNWQwBq/rqu5OIcS+tv+b+AUglLWGCIEJwhVN9+VaDMIV5RxzXnlv+lcAVJKomv9pV+ExXdTzJBEJm9YOMQCJ/M1euVxMVIw/RJr4ANujOdGY6bIst/pfHCdnvxuF16VzlXuUKJNFBd3adSj16LiA+NFQS9D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eUX3BFIZ; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eUX3BFIZ"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43cfd832155so583758f8f.1
        for <git@vger.kernel.org>; Thu, 02 Apr 2026 08:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775142626; x=1775747426; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ljxCktEK8JSUo9v15t42aHoixrMUURy2APZoZMsySt0=;
        b=eUX3BFIZ+xbZZdpDP5vpVuwlGudKhEmWOkJDvsKOFwdzXYue/eh1zLuwyg1cUUi2El
         QO//oWYkgn5t2I4OVjY6xfSuT7+1bR7FBEjhawV2Y3Bct6uqddAdWVESVxfM+VPNnNtm
         P21xQ8ezRsdOWBKvGogJbaPrILnCaGn4+pJHp3PE5CYRKRQQI/i/oEgCExspPXJEn4Wr
         7EqaB4CEbbVJ/CsWFsl9bekhZVzBky53FkZ3exqihQph3Y+9GyA7bJGhEod7fHcS1QnE
         cB2Bo4C/wpGKmCINd1O/pnU3FKLynDnpfHxNlhJCYOGYZyHz0yL6K6kw5LYldK9q2oZZ
         YKdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775142626; x=1775747426;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ljxCktEK8JSUo9v15t42aHoixrMUURy2APZoZMsySt0=;
        b=jN+ihN2B0lUFi9Fe7jvx70q6LAZJc92L19mnv9D8989ZUhTS8de9+p7J9044wD5Al4
         gHX6X0BqenB/cCxi78V6JX0icKB1bgZSQAo3I9U5sN09T18qYYh3GXzHmTwaW1EtfUNo
         cbTVxuwnSeZX7sBRto6TbNF2CNAmxqB4fxXeJxjsTZCc3L1qDo9l6lx+f7isr5sJ146U
         8mASTl/wxgRWfthkosnGU8XnfmS8CPZGP6F1B6KgHMNVNloPlk5oylDI6vW6Fs6y/21R
         NTQRYs+AhA75t/s5oUVTzDPXMgjerMHMHfP0NOcbIcQZAuD6awX1KWFgDizccqiUzw1+
         +vtQ==
X-Gm-Message-State: AOJu0YzRKfQ++XXe/W8sK3XnmtXoEUHAwprZeXoXqgwC6KUFnbq2IVhI
	FBonVH3R93cyiXdTzzl2OGwGZ7/TkTsxn3t8JLPAbAtYQNAHfGqPuVII
X-Gm-Gg: AeBDiesSHN+ieFzZuGNJDhQv4eUY6L1OEly+lK/pNIH6ezJqodkqAws9aVl+DApicJn
	AXsXYQCnl9se2VzTtL25KBYucP0xrApnF67zz9FQ3BXXXM/YcGNVUOleQlhsEOrMzAvgeSyAJrp
	msBnUuBVagdHaQ384yudGDthf+MnD+7TeqynGtZXGx+Hk0cxw07dLkKZvxwkqAmRI2xrbq/KM0T
	87MF14/KABWevMMUhkMLuGPwSjbcd0ph4HA27G4pH3wassyrqqdKEG5VReCILGp0g/2Uf2Lnmov
	4zK7zuAq7out9v7AcnSKwsB8kW0FF352Ke/TmjuZR3NB6zSNoGMzJhgIXQ9poqBIIvE+O6F9BFq
	sd5byb9GH4KQlqO0WQ+0kOICm9Qw1qqimrT1JE5S4OLjTtYhdQRbs7ARFQvE8mo7O5R/5uqY0KD
	h5fSB3R+cxskK8/SwTOerd+yrURvxzzE1dg5YiLMXfymLezRDrjRoPSpx4sPd06LdAONmEHCUey
	1o=
X-Received: by 2002:a05:6000:2010:b0:439:bdba:56be with SMTP id ffacd0b85a97d-43d150429bcmr14909535f8f.10.1775142625741;
        Thu, 02 Apr 2026 08:10:25 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f? ([2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4e221bsm8179254f8f.29.2026.04.02.08.10.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2026 08:10:25 -0700 (PDT)
Message-ID: <eadbe64e-b43f-42a8-852d-1e0824f5a9be@gmail.com>
Date: Thu, 2 Apr 2026 16:10:24 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 1/3] worktree: remove "the_repository" from
 is_current_worktree()
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
 Eric Sunshine <sunshine@sunshineco.com>
References: <cover.1773411586.git.phillip.wood@dunelm.org.uk>
 <cover.1774534617.git.phillip.wood@dunelm.org.uk>
 <5357c0dd53ee123a4ea064412c83983b0be5e400.1774534617.git.phillip.wood@dunelm.org.uk>
 <xmqqy0jer3qu.fsf@gitster.g> <317ed4f7-f88d-4415-bd25-b62b4a076728@gmail.com>
 <xmqq1ph5kxpx.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqq1ph5kxpx.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/03/2026 17:07, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes> 
>> On 26/03/2026 15:48, Junio C Hamano wrote:
> 
> I _think_ what I am frustrated about is the lack of description on
> "what it means to be the worktree among many that is pointed by via
> the .worktree member in the repository struct".  Does it correspond to
> the worktree being "the current worktree the codepath is working on?"

Yes

>>> The function's comment in <worktree.h> talks only at the
>>> implementation level "construct a worktree struct from repo->gitdir
>>> and repo->worktree" as if it is so obvious what the resulting
>>> worktree struct means at a higher layer's point of view, which does
>>> not help, either.
>>
>> That comes from me thinking of a struct repository as referring to a
>> specific worktree - would calling it
>> "get_worktree_from_repository_instance" be clearer?
> 
> It does not change the descriptive value of the name in any
> meaningful way, so let's not do that.  If the answer to my "what
> frustrates me" comment above is "yeah, we are getting the current
> worktree", then renaming the function to include "current" in its
> name would add descriptive value vastly, though.

That's a good idea, I'll send a patch to rename 
get_worktree_from_repository() to get_current_worktree()

>> I feel I'm struggling to explain this clearly - I find this whole
>> discussion gets confusing because we have "struct worktree" and also a
>> "worktree" member of "struct repository" which means a "struct
>> repository" instance is tied to a specific worktree within the
>> repository. If "struct repository" only had a "commondir" member and no
>> "gitdir" or "worktree" members and we instead used "sturct worktree" to
>> refer to a specific worktree within a repository with functions like
>>
>> 	worktree_get_oid(wt, "HEAD", &oid);
>>
>> instead of
>>
>> 	repo_get_oid(repo, "HEAD", &oid);
>>
>> it might be clearer but that would be a very big change.
> 
> In short, am I hearing the worktree subsystem is not conceptually
> clean and it would be a huge undertaking to clean it up?

Yes, we mostly use "struct repository" to operate on the current 
worktree but sometimes we need a "struct worktree" instead.

Thanks

Phillip

