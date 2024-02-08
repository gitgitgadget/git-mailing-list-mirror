Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977511D68F
	for <git@vger.kernel.org>; Thu,  8 Feb 2024 00:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707351859; cv=none; b=dN7ZjjpkuMHyAiuK39LLim/zNjTMeKQZeamz82cQsmuujnj0uguJOz/B54zU47h9X68rxfk2UE+ThdQLOFbnTYbvy3GGl5hNIvg94FxZ+Ctgfhb0aKNoa6KI/MPbmIkg0pj5SgoIA3T/a1VhrAKvrFsZ1ZzvmuOYU8EaLzik1Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707351859; c=relaxed/simple;
	bh=UYmbT99ttVsWtrxgXP+vx+sDuYYuVlOOTDlxbroHH9w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mu/+dPOEl3HBN99M/dM+dO2hSAXT0MhCVToAYrTj06FGMRYNSWi5EF2JrHcBCQNa5K17W9e3N1t81WwohtwDLm9sPLTSy1dSNDjXN7ITxU8M3cFJvMGdXIwV//66CLfKxdYOTgfG0DIkk2yx91lyJ9g+6Fi4E8Y7xX9d+tL8vkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U9Nr/X3D; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U9Nr/X3D"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6041dbb7a78so22018587b3.0
        for <git@vger.kernel.org>; Wed, 07 Feb 2024 16:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707351855; x=1707956655; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VUB6MYk6jpy7Cekj+OsaNFjj1HwqANLOOPBYZIIhNME=;
        b=U9Nr/X3DSY34om3JxiaaTNjqYRnqX5j/zlshfhdtY1AGUedRMHUbmu/7/URtQMkI27
         kqomyVFymSm4SVMpN/J5bhy4wbDRTzmWMHkgZZXMbrLvZMVXTv9kPtT978vQ5ywxgzWA
         js9DO402ymaxn2qyz7+cIXygbtZhc1YDsY1RmjxpcNfJ11i3Cwf0rRDLpIQnDnfd6FDc
         pj6kEw46LafbpXNWu2LjYZzTpNeZctikVuLPUr4k63NI/yRSM1yNBxExlILWNR6cCJLI
         +NaVbIbABV1kFcj0oAErRJX+Zs4Bx9CdSm+5DtEOHRjvwZI4o+eR8pMuHVabRJ4nZo8p
         3zOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707351855; x=1707956655;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VUB6MYk6jpy7Cekj+OsaNFjj1HwqANLOOPBYZIIhNME=;
        b=mG1z65/g36FguFZP8875HGV3dUT3IG4HlTXz4ZevIicW5pQrtu3z2j7DdCVC1dBRGi
         R7rCMkRtM1Xyb/IwpX0whopzXY/4s0H7to8DaJ5I/MRja1SWm8Out7/8wuW5foWz3A7N
         n2nDvxp0/zu1PZse94PgaepzLrhnNR3LPMfw+ZjlH0VW3Uv6FNGJCEA4QyZLaGTSCb79
         /RZzh1nfw7vuA6GdTPZ5h0zCgqimStV0jKlB2bBo+2Mn1GiWKPUE0PQ0qpx5XuQ5x44e
         nF6dYSjniG+6MrwYmJfr8dOhtxN5FFEq0k2H1mGNpoF9w2lXL3+3XFmWpUhv6k0hkAHA
         9t2w==
X-Forwarded-Encrypted: i=1; AJvYcCXYBbFCWWb2ZPDNzRIvwPetGHmnHGMQz4vdaeJZl3F/cEMHauQ9XznZKZEJESoDDmzAHHuTUzzcnQLmylCWH/MPpL8/
X-Gm-Message-State: AOJu0YyWdW4YFbtQf1+0GC3nVi5MOrErJmKgO32dcSuIEbOAEGRVq/1R
	bhG0KRpYlOqSeL2kU5GQk3aZJmZ7ugylF8qX6WoZ4KEYcdUZook20PXVXNKWKjIxhCGOJ8EmGGH
	kCg==
X-Google-Smtp-Source: AGHT+IHSRWd8Mv6bYoEfwbZIPHjwd/BamuxdAgprujRBfbIQPyFpZbpRg/OX6T9dYL7QHBpSKmP1UOHpLk0=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a05:6902:1025:b0:dc7:3a6f:e0f0 with SMTP id
 x5-20020a056902102500b00dc73a6fe0f0mr512191ybt.11.1707351855520; Wed, 07 Feb
 2024 16:24:15 -0800 (PST)
Date: Wed, 07 Feb 2024 16:24:13 -0800
In-Reply-To: <xmqqv86z5359.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <87jzsbjt0a.fsf@gmail.froward.int.ebiederm.org>
 <878r8l929e.fsf@gmail.froward.int.ebiederm.org> <xmqqv86z5359.fsf@gitster.g>
Message-ID: <owlymssbn6qa.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v2 00/30] initial support for multiple hash functions
From: Linus Arver <linusa@google.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc: "Eric W. Biederman" <ebiederm@gmail.com>, "brian m. carlson" <sandals@crustytoothpaste.net>, 
	Eric Sunshine <sunshine@sunshineco.com>, "Eric W. Biederman" <ebiederm@xmission.com>
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> "Eric W. Biederman" <ebiederm@gmail.com> writes:
>
>> This addresses all of the known test failures from v1 of this set of
>> changes.  In particular I have reworked commit_tree_extended which
>> was flagged by smatch, -Werror=array-bounds, and the leak detector.
>>
>> One functional bug was fixed in repo_for_each_abbrev where it was
>> mistakenly displaying too many ambiguous oids.
>>
>> I am posting this so that people review and testing of this patchset
>> won't be distracted by the known and fixed issues.
>
> We haven't seen any reviews on this second round, and have had it
> outside 'next' for too long.  I am tempted to say that we merge it
> to 'next' and see if anybody screams at this point.

FWIW out of all the "Needs review" topics this one seemed like the most
deserving of another pair of eyes, and I was planning to review some of
the patches here this week + the weekend. If my review takes too long
(taking longer than this weekend) I can give another update next week
saying "too hard for me, please don't wait for me" to unblock you from
merging to next.

Thanks.
