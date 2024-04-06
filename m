Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5080A1DDF6
	for <git@vger.kernel.org>; Sat,  6 Apr 2024 05:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712382430; cv=none; b=kaZkdcogP5edt7w+kVV93DoJ3jKljjyqz6BrVv75gUE6TUManLjzW7fZSkkeBWthL42OKC/uqu1VDY/NtssuuUirn1MlkRi/LSZ8SiEGf6PEHEZ55dkZOmlUleKSOvAHENR0plKKfBtaMgXqPIkysen4Tg1IPUQs4Thl/v0uZbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712382430; c=relaxed/simple;
	bh=meQ0APcuYOS7+Gr3kTWwPU7VgXC2drdUWgnfv+GM0BE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jsJxAkXlzHo7yM+BYN0NzIYB/tTisFRQvkmMqv3KiiWjc/K9aUVhpbqPceP3K1AtjodUqfRqsBFnONEtHGbbbCVnDju5JRC5akVVuDSi2LIf7QxWTY50vhJVAwgWxjBQc7rndsboOwIwFh2kOAGL934SN9TN+5E+YLDIItK6MzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=GY1rfq5R; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GY1rfq5R"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 91D91299AC;
	Sat,  6 Apr 2024 01:47:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=meQ0APcuYOS7+Gr3kTWwPU7VgXC2drdUWgnfv+
	GM0BE=; b=GY1rfq5RcejhFVsIDGhEXmn3QsqTRQh1hkSmpXJZBkyJHgz7a0XKN6
	OkDfLTb/rniqlZMCescFeRhqtWpmy2rCH4KLpRfMBxHcSQ3J7+WLKe+lEWet97Ll
	XJtFGlqp1f85tG0WA5szKA5zvFOJeij871zzo88ws82FLTGoVmgQc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 7D229299AB;
	Sat,  6 Apr 2024 01:47:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id F1AD0299AA;
	Sat,  6 Apr 2024 01:47:04 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/6] CodingGuidelines: describe "export VAR=VAL" rule
In-Reply-To: <CAPig+cRjqe-rgYf5UZr9KXmfSw98ZoYjPo5PKhwzRaC-svwshA@mail.gmail.com>
	(Eric Sunshine's message of "Sat, 6 Apr 2024 01:11:29 -0400")
References: <20240406000902.3082301-1-gitster@pobox.com>
	<20240406000902.3082301-2-gitster@pobox.com>
	<CAPig+cRjqe-rgYf5UZr9KXmfSw98ZoYjPo5PKhwzRaC-svwshA@mail.gmail.com>
Date: Fri, 05 Apr 2024 22:47:03 -0700
Message-ID: <xmqqo7anm4a0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 19203128-F3D9-11EE-A9C3-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Eric Sunshine <sunshine@sunshineco.com> writes:

>> +   lines.  Note that this was reported in 2013 and the situation might
>> +   have changed since then.  We'd need to re-evaluate this rule,
>> +   together with the rule in t/check-non-portable-shell.pl script.
>
> The bit starting at "Note that..." seems more appropriate for the
> commit message (which is already the case) or a To-Do list. People
> reading this document are likely newcomers looking for concrete
> instructions about how to code for this project,...

Very true.  I thought I'd move some to the log message, but it turns
out that enough is already described there.

Thanks.
