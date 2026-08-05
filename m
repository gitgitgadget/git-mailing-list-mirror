Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F6846F480
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 13:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785934806; cv=none; b=TSvhR9SoujBQQ6bS/FkSIfslRd2LEAQr0YKaVrF78yhKbrgi9Pu0MGBFkzmHC+7cHu49b+ON46JQMeLmgfjSVcmbHr1fx7mDJmexz4U5LMUwYSJgfXtjdVwn1e+o0iphJajqG5hU0cgyMPmK2T7XX44UtaZDWATU0iaqiqdBrig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785934806; c=relaxed/simple;
	bh=OmrC9ygFjSWUPs6iUsIY+UiPKmALP2JXF8OsvEVN/hI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A3i39NgC/EW4gIwdXRCrlrQn+ImL7KzE45QEPxXGLZvbBCKY4V0RT3DcKRdOhVBezHpH0ED+RC3hw+QqHNEG0opKYHYtBbKxNen04xf3PdwaqpMe5RtjUFqtiT6IEB++zLuDQCkbU9isV1Y/hIwzl6t/FohpOUUVESrqXtvqYoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A4s6tYO3; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4s6tYO3"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6a051b737d8so970626a12.1
        for <git@vger.kernel.org>; Wed, 05 Aug 2026 06:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785934803; x=1786539603; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oVLwSby3bY2j7PDuYu93l3zlYnn+ZvkeisYhsECSCwE=;
        b=A4s6tYO30CB0KiqAyrLyXxbD7aIE6KlbMbOz5s/tH7yfux/CjnQMJ8AjPxXDpN7X+1
         M5FypsTHKO3/cbbn2Zs2FBgkSDziMCGHLEDE7sh9nU4nIBDqa/vLOEpp+y/lXikz11fj
         oRS+YPb0BKSXQ3JqO0b9G8owa16rQANQeY/2vAEU6xiY+jGl4gKTKXH0snaCGwCq7Ayk
         QO+bQDy3sd+V5m6YYus6zSOREknEHxyJXrX0i6GVAC2HfUszAbdY+WB0miJFyD+Kionn
         6pvuZ6RezwMUR0ieRhzBemeOqSWJxcM4IXiUZeHiOt80Nq0W/qCa/oP7pDwjiQsG7Opo
         iHKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785934803; x=1786539603;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oVLwSby3bY2j7PDuYu93l3zlYnn+ZvkeisYhsECSCwE=;
        b=MZvmYYwGVyx1LRjyqO67DYn6ZGwztJ/b4UQwDWWHbcE0KTscjIeBOb6sx20mpDLgzI
         0kGgsb76old4Z/7SwPPbOO6c/IrRP/7Lis/9nPJBdR8QD3fjhmCW4spThEAQB/qIjKfw
         F42mucl/2o7gh0l4zlpJqg99mkFUUKN+Bgs6hU8F4XGGSrGQ2xOZh1fMaya0gizeWSe6
         7lAUh4bQZEBF8K+VyK8ZIKnUnniXXdoq1sQ3BFwwKPd6qo/es5Zfv6JAXllDQYYriE3g
         pUcyIkkZslDauxaV/irbFde/3yKOZEPaj4P4bBPOlV7aYRzCXggvMUIP/8tROzU7hhGC
         pTKg==
X-Gm-Message-State: AOJu0Yyla2qRdgLEr+s5E3Z7P04BD0oEJbhqNyg0fRy27HpkIy4qOwZo
	6nLZNmVjvg/UKiJ9dJyZybUxTXtf7lChdMw2AJfGySYe3K+daMhocIoC
X-Gm-Gg: AR+sD11t4Prakved6oLzNs47+0RCw6nTKuVt/BcHVhmmgkgiVrr69omgdg8w8ufKuKN
	KzO5H1qoETEyT3FV7fZzYikIvUNxVpCrQeWdt0hglYAEe84pq3a+qsKLKTlu7k1ood39Xxnd+J1
	a/dwvJQUo8H1uRe+YV8QeLX/ARwo3WLhIRKUWQozfNnuUuKVBnKEWnR6ZhHqimHD3fiE0fVoj8v
	ztlan8JTAn3DufL0ybEkI7UrAAMrcQqalR/ayCmlnPyJK1uxGevy0tm1+CvpqFibuvwwDIchv6a
	7BxS4fy6wAFzjsy1eFRP7FPZiUzRVIFcbQjBhdFKDhKeS/F0gx1lLySPvSQY3LQz82sV47WIe2j
	VkY4r33G7Nq3yC2Z9EJvSU0z9iMLjCWc/oYYwuU0zW4Kku+9HEpg4NwafN/NQ43R9qrzIboxwHW
	VCq1tEe7riVIrPSDli2StKMThHMRt5RBsiLtYI3QKLuxOO4DXVFyeWbPWATiMag2IWglTDlK0uc
	fnLtJtDRWWAbhE3x2QjSriom3JLz/8E6vL2iD5AgUn9Q6il
X-Received: by 2002:a17:907:6d14:b0:c1c:23f9:5f17 with SMTP id a640c23a62f3a-c2039c6631amr351588466b.22.1785934802844;
        Wed, 05 Aug 2026 06:00:02 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:17bb:9901:48d8:e54:f1b0:bd0c? ([2a0a:ef40:17bb:9901:48d8:e54:f1b0:bd0c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c203624e6c8sm109858066b.15.2026.08.05.06.00.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2026 06:00:02 -0700 (PDT)
Message-ID: <975a0661-945c-4a03-bad1-14db929c8d97@gmail.com>
Date: Wed, 5 Aug 2026 14:00:26 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: git-replay/git-history lose notes
To: "D. Ben Knoble" <ben.knoble@gmail.com>, Patrick Steinhardt <ps@pks.im>
Cc: Git <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>
References: <CALnO6CAN1=dgRsYjABfa3CJkGnvb139EcrzS9EnX43i3szOgtQ@mail.gmail.com>
 <anLXz2vos4zbIciW@pks.im>
 <CALnO6CDtihFytS1dhfZPDA7jUL3bvAt=zYOH9Wi=naEoC58B1Q@mail.gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <CALnO6CDtihFytS1dhfZPDA7jUL3bvAt=zYOH9Wi=naEoC58B1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 05/08/2026 12:39, D. Ben Knoble wrote:
> On Wed, Aug 5, 2026 at 2:27 AM Patrick Steinhardt <ps@pks.im> wrote:
>>
>> Hi,
>>
>> On Tue, Aug 04, 2026 at 04:06:38PM -0400, D. Ben Knoble wrote:
>>> Hi all,
>>>
>>> I don't think this has been reported or discussed yet, though my
>>> apologies if my search skills just didn't find it.
>>>
>>> It looks like git-replay and git-history will drop notes (or rather,
>>> not carry them over) when rewriting history. I've seen this both with
>>> "git replay --onto=… …" and "git history fixup" recently, though I
>>> suspect it affects all the modes.
> [snip]
>>
>> This somehow rings a bell -- wasn't there a recent discussion about this
>> on the mailing list somewhere? I might be confusing it with a different
>> command though that's loosing notes.
> 
> Yeah, that rings a bell for me, too. A peculiar rebase bug, I think?

Yes, there was a note-related rebase bug reported recently

>>> Are notes out of scope for replay and history, or is this just a
>>> "nobody's gotten around to it yet"?
>>
>> For git-replay(1) I'm not too sure, as I consider that command to be
>> part of plumbing. But git-history(1) is a user-facing command, and
>> because of that I think it should handle notes automatically for the
>> user.
> 
> I can't speak for replay, although I do use it as a convenient "rebase
> a bunch of local branches that have conflicts without checking each
> one out"… but the history part makes sense to me.

I think having a command line option for replay to turn on note copying 
would be useful (and as a plumbing command we may not want the behavior 
changing via config). The implementation will probably want to live in 
the shared code anyway.

>> So for me at least it's more of a "nobody's gotten around to it yet"
>> scenario. I've created an issue in our GitLab issue tracker so that we
>> can maybe pick this up in the next release cycle. But I won't complain
>> if anybody beats us to it :)

I agree adding it for history makes sense.

Thanks

Phillip
