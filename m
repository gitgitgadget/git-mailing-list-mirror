Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1F1198E77
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 18:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717698201; cv=none; b=DIHu4H3UguW96r1E8+bB18fCs8RcFA+EuWIoOW+PptGYqcEZtapCCB37xh5rzNlyuGcT52ocFuqaqFQyAvYbQwb+BZfiv/TElRSgWbc1RbL1PzIXR0dP8FIAnrwidk2twH7iQCLKuwphQVccSL4wqZZPWn8P6uiUNzvM/q/650Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717698201; c=relaxed/simple;
	bh=Lu+gnOZZRWiarmrkF0lmt119xP1dEVmxvCdMXgxBzjc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uGkEteLp/o3xMcMlNTNiNoiTPQQvupL/Y+QP0X18G0Pzsg+/UPRm8rTvxEkjWf4j2zPCYK4lk5EcRFSoRM43J8zv7O0yNUs//Eyw6SSaxL9s725bJirVCzQpqRQtbzKxnJ893JcD6RfaEzuQZHxvBTsXOLjeiYVS0qn2hjwnCoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iYrRHGrN; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iYrRHGrN"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-701b0b0be38so1293236b3a.0
        for <git@vger.kernel.org>; Thu, 06 Jun 2024 11:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717698199; x=1718302999; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QAfxgq6k3/1/QSauGNbC+FAlXTSOzgn1u8ordJdw/Hg=;
        b=iYrRHGrNKJWV4Y7i3jItlAhsbKLQJrmMZEbU2d0xAAKmNvygXOYluAvRmj/C8SiT6v
         heRfMRrzslFmKMBLCxLe2xLVMNXVfy1udgMAVR+eqUdcY6S0fvIw8AU0uWBxQex8ubqs
         FuBQYmlqCPOhJt1LqlKbwEvJJAoP63axVQQJs+oKVvAKJ7UbBEm37QWRfXrbI1YMk20L
         GRcpGSi0FnJU5KzCmQbSEnZtqGBZ7ul/qlemQgK7SDBxde6DuKnOjT7gwMCv6Zllxd+m
         5/vosBJFljSUNdRlRvSqDPNSKYUaJdWeEyNRcKD7XaSn7QNvYaN7RdXsvxsxiWkGkEKC
         jVSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717698199; x=1718302999;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QAfxgq6k3/1/QSauGNbC+FAlXTSOzgn1u8ordJdw/Hg=;
        b=QbZTRCREFMNWPZlr66pakovmC/kwz6uY7gNUK6Q8GeHVddX/+CfR1euKutHfTi5SiT
         OyBgsOGvJ09FlFQKtvUUpiSSwjYzWYUN0+2sBA9NtgtUZlu+axxz/uNeNqcj6jrPWwOq
         hB5Wc2MHYGulHGhAttXAlMBZ3iW3XvOdBc6eTuC4GDUdpD7H6wPNzmbThG3MT1yCkBjf
         ZcG0PpX5/fZHKJct/VD2UuDApldpqLi2x4pmGJgGbl/L2fH/sR/6hEIXLMmiTYEuqYG9
         w28uqvlBR8B/Hh283Ow+bN7S8Nk74AFBfVwQwBPzeEkq0ZpmI+Z0jWaozVeeAyQvmcr4
         S8Mg==
X-Gm-Message-State: AOJu0YxxpDOyUp0fTydmfi4BNgAJoh41jYzBInCfgMiYCLNgDEh3Pm9H
	DtTJSjPcc0UDwmOSlDXM5JaNWzXRa7ayOM4FA3SsD6CJmcc2xg+X5uUGdQ==
X-Google-Smtp-Source: AGHT+IERQ42uZhZk1SLc33X2bA7on6f2w7l3h65gyEMqvc/3nq4tMlBknJ6A23i5a2U/UF5S4cqDPg==
X-Received: by 2002:a05:6a00:1786:b0:6f8:b83f:d433 with SMTP id d2e1a72fcca58-7040c649d4amr266184b3a.8.1717698199015;
        Thu, 06 Jun 2024 11:23:19 -0700 (PDT)
Received: from localhost (201.204.125.34.bc.googleusercontent.com. [34.125.204.201])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6de212befddsm1474472a12.32.2024.06.06.11.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 11:23:18 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  "Phillip Wood" <phillip.wood123@gmail.com>,
  Kristoffer Haugsbakk <code@khaugsbakk.name>,  "Jeff King"
 <peff@peff.net>,  "Patrick Steinhardt" <ps@pks.im>,  =?utf-8?Q?Jean-No?=
 =?utf-8?Q?=C3=ABl?= Avila
 <avila.jn@gmail.com>,  John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 1/4] refs: add referent parameter to
 refs_resolve_ref_unsafe
In-Reply-To: <xmqq34pqlyou.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	06 Jun 2024 11:21:21 -0700")
References: <pull.1712.git.git.1717694800.gitgitgadget@gmail.com>
	<011c10f488610b0a795a843bff66723477783761.1717694801.git.gitgitgadget@gmail.com>
	<xmqq34pqlyou.fsf@gitster.g>
Date: Thu, 06 Jun 2024 11:23:18 -0700
Message-ID: <xmqqv82mkk15.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> "John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>>  29 files changed, 64 insertions(+), 52 deletions(-)
>
> Wow, the blast radius of this thing is rather big.  Among these
> existing callers of refs_resolve_ref_unsafe(), how many of them
> will benefit from being able to pass a non NULL parameter at the end
> of the series, and more importantly, in the future to take advantage
> of the new feature possibly with a separate series?
> ...
> That way, you do not have to touch those existing callers that will
> never benefit from the new capability in the future.  You won't risk
> conflicting with in flight topics semantically, either.

The same comment applies to [3/4], but I do not want to fix the Cc: header
again, so I am replying to this message.

Thanks.

