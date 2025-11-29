Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9008D26C3BD
	for <git@vger.kernel.org>; Sat, 29 Nov 2025 09:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764409127; cv=none; b=Pn1p8Ks961j3N1pCNuCcPbpdTSN2TGIb9Az6jhKZhTaYuvmmoVdGtGA6aSnyAoEm5/HznphzYsEVKoIr/hqA5LVOonIXkY+jza/R9GJe+epY/5Sh1ZnF8w/gsNYq6yyVW19EKJljYrdowY3Bm0c0jIRZr03a6GdwWFFbGnB2st4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764409127; c=relaxed/simple;
	bh=vawBevYgM2NCe9xwjA1PHN0/khkHrDKCUCVhu9Zs9Q0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=n9ThrHAXMoWHP/mhIuEuLsdF1p10yrvWmOWp8sIfxmDe/p41ho4mrDYqJzb4j57vLawF8RILuQDyTK40KbzJmiZ3E9/ZjUzQWeYoi99BR9v8Qs079Vowva0A2g+R9iaNqqUNBbhgpgvnjZ/z4naTVa6aCd/3v63SLUiGoAbSdhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=EdTn1PTa; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="EdTn1PTa"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1764409120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=djPIWBLsjxhjnAhhDbiPIA4WzoUYYFPkSHw/NRXegEE=;
	b=EdTn1PTaKoz9Kpq9rwytB2MkNx+MHsXhYVUXBwpBTlz9DpWQxW/85tmVhcCUd4yT+RxGeb
	ZUUj4BglGnVX25oPK2Bv1hxFfghutcPrOg8g+LYf5Ew7qNWuei/JeE+2xzwe61BmTA5Anj
	x5SBWqs3RWnQ3tI6j7LJnu3MqQadc7k=
From: Toon Claes <toon@iotcl.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, Karthik Nayak
 <karthik.188@gmail.com>, Anders Kaseorg <andersk@MIT.EDU>
Subject: Re: [PATCH] last-modified: fix bug caused by inproper initialized
 memory
In-Reply-To: <xmqqwm39h9kb.fsf@gitster.g>
References: <20251128-toon-big-endian-ci-v1-1-80da0f629c1e@iotcl.com>
 <xmqq8qfpioln.fsf@gitster.g> <xmqqwm39h9kb.fsf@gitster.g>
Date: Sat, 29 Nov 2025 10:38:10 +0100
Message-ID: <87ms4518n1.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> This dates back to v2.52.0~4 and is clearly a maint material.

Makes sense. I appreciate it.

>> Thanks for finding and fixing.

Yes, I'm happy Anders reported this, although I didn't expect it to have
impact on all platforms. It would have been a nasty bug to hunt down if
users would complain "the results are incorrect".

>> Subject: Re: [PATCH] last-modified: fix bug caused by inproper initialized memory
>
> Let's retitle, as inproper is not a word.  Is

I wasn't sure about that. But my spell checker didn't pick it up, so I
rolled with it.

>     Subject: [PATCH] last-modified: fix use of uninitialized memory
>
> good enough?

Absolutely.


-- 
Cheers,
Toon
