Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BF4111A4
	for <git@vger.kernel.org>; Wed, 14 Feb 2024 07:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707896166; cv=none; b=FL2Nj1XqukGlheTo8aq6gOL9sNQVi7FyJGe5izHVP0QkOSzBHMLf91BfAUZHbBeYTHj4TCoo4d0g/JFLTI0eNZnNRMWknlGWexyX2M4gzwmem31XOYXrgKE808jmz0bD75BRZnR1jg+zwFWLECvkkQtwYywL5Maafl6taSUnw/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707896166; c=relaxed/simple;
	bh=wg5TmZsdZonVrZHdeLtEc7IgjGCjUnojpvYumbJaAEo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ApvjEUoThIoUo9UljO6KlQQeNkk2DyvDgJrLyPSE2KzBw9j46NP3c31T57ddIBl5/yXx2vJXASc2UCljuGioq5bP2Qw8AFb9D8lsc0OWDQ9YyzCs68m41SnlxS0kCotbXeZHer3sCK0SoAxH5Q/JZ7yjBHXn9B3Z6awD5VM3Kwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S/DBIxOM; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S/DBIxOM"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6e0a646ce8cso2355185b3a.3
        for <git@vger.kernel.org>; Tue, 13 Feb 2024 23:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707896165; x=1708500965; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iFfrswpGejwZYTvovnhgndCPbRW/4YFLB1cJ9mYr3tU=;
        b=S/DBIxOMs/w8EmcTcp1H8BejRfX5C0dr+Gp7Degz2DAOMkNP4fyfSmYPEOH4NYI8Fg
         wnAHbKANpo7B8+jlxrWPkAKXSBa9sbRDXa1Ylr/dL4STnitCJzhY9KZpd6eat57n3f8Y
         s/qnxZHD1fexKb5YX0uEwyqwTUfMovw7tDcUWUaA8u78i8bsbxLBZu7Y78J56NPpCpkV
         TPqsB/1NtbbozW9LXu6+95h95hQZove514ssqQNckat3bJrr2TRz9In6fb05LINXDpQb
         pbTCm8CKpYSqdqbGsyEvcVplWPp4IxcVkY2VFYjk9LcbPmE63uq2RAPH38YsyhV0bpJG
         j7LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707896165; x=1708500965;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iFfrswpGejwZYTvovnhgndCPbRW/4YFLB1cJ9mYr3tU=;
        b=J6cUC82+XMq+6REtgGTE4dwZvDu/pgdRGfEyyj7envYYxQSnSBHcHMpy4UVmUxfGiI
         j+P2xlz+3IKYoFfrkPeQpjwZcb+MGDzkvtADsibGaZ7MdTJnwaDt+8YqKx2XmwDfaN3p
         eKrQXbL9IlEjUHH3JXFr+gn1DC8u/6eBTB92CfbasdEaLCalsmq/l8ggCbfT2OZu+AYL
         1eVqHvZ3GGy1p9xhuA5vSPUVSBJIoIpt+DpTPmwV2+kGcsOc9IQ6mGzHbvK4zoJHpBDP
         YqmPoAe03s2paYokMKJwjrMHZwmnrBMmT0llbnZEc0jO7ffQF+Bvb4t+zsDpngHd+bmS
         BiBg==
X-Forwarded-Encrypted: i=1; AJvYcCUZp/3pSOyTnWv10LrM7FEhWuTaMvMivbzDKkf439Qjyjm7YH35x3PeyEvbUsHF44a309qFAVQ2GeKCbbiWXdHryFuR
X-Gm-Message-State: AOJu0YxvKeppSe1gjXLcy6tZf3TvKL3aqchJTw9FZkE7vepxyPcCexfE
	7hdEeqPtjDjEwewXHXdXG0E0rWUpx4zdyVq06aVxZ0x9kB6h2Dk3Ffm6nccDy/2ySLN5tWPvyfQ
	k0w==
X-Google-Smtp-Source: AGHT+IH2K/zikoI0YZj6C5gSyIq8mMJXQgTDXgI2X7ZmujGSanx0W8T7hozZFD2SYVlVf/EmnlSJdvH1X5Y=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a05:6a00:2d81:b0:6e0:f62e:eb0f with SMTP id
 fb1-20020a056a002d8100b006e0f62eeb0fmr83593pfb.1.1707896164710; Tue, 13 Feb
 2024 23:36:04 -0800 (PST)
Date: Tue, 13 Feb 2024 23:36:03 -0800
In-Reply-To: <owlymssbn6qa.fsf@fine.c.googlers.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <87jzsbjt0a.fsf@gmail.froward.int.ebiederm.org>
 <878r8l929e.fsf@gmail.froward.int.ebiederm.org> <xmqqv86z5359.fsf@gitster.g> <owlymssbn6qa.fsf@fine.c.googlers.com>
Message-ID: <owly7cj7a464.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v2 00/30] initial support for multiple hash functions
From: Linus Arver <linusa@google.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc: "Eric W. Biederman" <ebiederm@gmail.com>, "brian m. carlson" <sandals@crustytoothpaste.net>, 
	Eric Sunshine <sunshine@sunshineco.com>, "Eric W. Biederman" <ebiederm@xmission.com>
Content-Type: text/plain; charset="UTF-8"

Linus Arver <linusa@google.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> "Eric W. Biederman" <ebiederm@gmail.com> writes:
>>
>>> This addresses all of the known test failures from v1 of this set of
>>> changes.  In particular I have reworked commit_tree_extended which
>>> was flagged by smatch, -Werror=array-bounds, and the leak detector.
>>>
>>> One functional bug was fixed in repo_for_each_abbrev where it was
>>> mistakenly displaying too many ambiguous oids.
>>>
>>> I am posting this so that people review and testing of this patchset
>>> won't be distracted by the known and fixed issues.
>>
>> We haven't seen any reviews on this second round, and have had it
>> outside 'next' for too long.  I am tempted to say that we merge it
>> to 'next' and see if anybody screams at this point.
>
> FWIW out of all the "Needs review" topics this one seemed like the most
> deserving of another pair of eyes, and I was planning to review some of
> the patches here this week + the weekend. If my review takes too long
> (taking longer than this weekend) I can give another update next week
> saying "too hard for me, please don't wait for me" to unblock you from
> merging to next.
>
> Thanks.

Unfortunately I don't think I can finish reviewing the rest of the
series (after all this time I've only been able to review just 4 out of
30 patches). I'm also stuck on trying to understand patch 5, as there is
a lot going on there.

FWIW a lot (perhaps all?) of my comments so far were around readability
and not material to the actual design or approach of anything AFAICS.
So, it's time for me to say "don't bother waiting for me" as I said
(predicted?) earlier.

Don't bother waiting for me. Thanks.
