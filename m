Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01E81CAAC
	for <git@vger.kernel.org>; Sat,  6 Apr 2024 17:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712423027; cv=none; b=E7R1UF8hTyqYkMqQBbN1Kqd2P7kgJWgu4dhf1VvlNtq3NngR3mqDhwlgCPPq+zsKqwQQG+iqExZbkdkBzSiobllzrlg6h5GXW9Qli0cA6JAZm8go7yNQoBO9DOxpa8uw2/66cSJYHIQZiK6EYF0rwl1XJhWEA69AbR3DODuNUSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712423027; c=relaxed/simple;
	bh=uDNL1Evm+gcizgAytVImERRHYQLjS1KlDqcuhISQOHA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rnrOYncXAa4fyxm7b5Otc8jCSX9yTdqyUJhvfz4gJ/MRsmI8IYa2+ttbMdzj3ti0xcTJCk36T9ffDsQiQb5eHSOhtrllgiBJoVT2Xxc6YgHeS5k/liWC1TPqYqaM6H3l7YMIjub2WRjpYaMaRUfhmDpPiVb4Cuk0vbaMNZK5vts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=R0I+M3zf; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="R0I+M3zf"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 82F091F8278;
	Sat,  6 Apr 2024 13:03:44 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=uDNL1Evm+gcizgAytVImERRHYQLjS1KlDqcuhI
	SQOHA=; b=R0I+M3zflyaBce+gQfrOUm/UvlolmN9ahQOeh438VUCQBxUH9AduhZ
	8nDxYl7t1jV0ew5QuoocofiUDwD81XHO+A37cWGmHUEPcty4sQ8hlRalAW8bfQhH
	y5DRSDKaQOVzmq7r/8EeCTCu54AP8pxhMFzYWkxz67giPT9GkkLa0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7ADA41F8277;
	Sat,  6 Apr 2024 13:03:44 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D97951F8276;
	Sat,  6 Apr 2024 13:03:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: Eric Sunshine <sunshine@sunshineco.com>,  git@vger.kernel.org
Subject: Re: [PATCH 1/6] CodingGuidelines: describe "export VAR=VAL" rule
In-Reply-To: <87bk6mc0nj.fsf@linux-m68k.org> (Andreas Schwab's message of
	"Sat, 06 Apr 2024 11:15:28 +0200")
References: <20240406000902.3082301-1-gitster@pobox.com>
	<20240406000902.3082301-2-gitster@pobox.com>
	<CAPig+cRjqe-rgYf5UZr9KXmfSw98ZoYjPo5PKhwzRaC-svwshA@mail.gmail.com>
	<87bk6mc0nj.fsf@linux-m68k.org>
Date: Sat, 06 Apr 2024 10:03:42 -0700
Message-ID: <xmqqa5m6l8y9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 9FF52AF6-F437-11EE-90BD-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Andreas Schwab <schwab@linux-m68k.org> writes:

>> I suspect you meant:
>>
>>    ... and suggest us to instead write it as "VAR=VAL" followed by
>>    "export VAR".
>
> There is no difference between them.  The export command only marks the
> variable for export, independent of the current or future value of the
> variable.  The exported value is always the last assigned one.

Correct.

But we are talking about working around sub-standard (read: buggy)
implementations and it is of dubious value to assume a compliant
implementation when devising a workaround.

It is easily imaginable that a sub-standard implementation uses a
symbol table with a single "is it exported?" bit in addition to
(name, value), without a way to say "this parameter is not set
(yet)" (IOW, never value==NULL), and such an implementation would
not be capable to have "this name is exported but nobody set the
value to it yet".  Using an assignment to make sure it is known
before setting the exported bit is safer to protect against such an
implementation.
