Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B16317D2
	for <git@vger.kernel.org>; Thu, 18 Apr 2024 22:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713479673; cv=none; b=q6huBqZ5Qmutlam7MibvpN94QJLrVMRaWEoK0RxqeT3H+Z2BdUh1Op4JjBvfnAoWJUGvnEtL41+653lJdlDDvMEQEBISICIOargY2fnS35wS4tYNOmuOF16WUDOE+Lzk0EtzUlH5BjeR38RNDl6NMAvBAebLu4oPSdg5HqlrWF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713479673; c=relaxed/simple;
	bh=FrCujJRUEYLJgygpWZrj6blMFNgGWvtXkNRrJE1P/cw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Sx/DdKSz6QKP9mA2CLUPRdou1kegAX4AlkIwWcuAFcZxS1C4r9fGnTTz650m4e7nuy+p046Mo11xwATDxyFw6vVs93OOBMP+F8dYFqEEVsHTvGMIZn9+E/lHMIj/g0cFwJ1FN6ED6E7aLE7pCJsXJPjA1/zCcws/XP8s9rolzxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=yZpV42g/; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="yZpV42g/"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id DDFF82C33B;
	Thu, 18 Apr 2024 18:34:30 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=FrCujJRUEYLJgygpWZrj6blMFNgGWvtXkNRrJE
	1P/cw=; b=yZpV42g/cUAXZEmN6dvHWYN00mg9ksAZ4p7sO4MXV08OqefTkv21lE
	eO1787vBxgZRxAQxZhRGjdUCmOWG13+fDYTQk+tPf6a3U+GwKjCTVKcXGMFoQA+G
	znJ4E8Ionws9A2jnZTXGXhumDuzUgtvxbI3mhPtBacFPI3wtYbams=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id D66EB2C33A;
	Thu, 18 Apr 2024 18:34:30 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 39D862C339;
	Thu, 18 Apr 2024 18:34:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: Phillip Wood <phillip.wood123@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 3/4] format-patch: new --resend option for adding
 "RESEND" to patch subjects
In-Reply-To: <84dcb80be916f85cbb6a4b99aea0d76b@manjaro.org> (Dragan Simic's
	message of "Thu, 18 Apr 2024 05:12:55 +0200")
References: <cover.1713324598.git.dsimic@manjaro.org>
	<1d9c6ce3df714211889453c245485d46b43edff6.1713324598.git.dsimic@manjaro.org>
	<154b085c-3e92-4eb6-b6a6-97aa02f8f07d@gmail.com>
	<xmqq7cgwau1v.fsf@gitster.g>
	<c2cb9268c29ae4a5cac34383b7443763@manjaro.org>
	<xmqqle5b66sr.fsf@gitster.g>
	<19d5f3d4c99fc1da24c80ac2a9ee8bf8@manjaro.org>
	<84dcb80be916f85cbb6a4b99aea0d76b@manjaro.org>
Date: Thu, 18 Apr 2024 15:34:25 -0700
Message-ID: <xmqq5xwepafi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D078124C-FDD3-11EE-ACB0-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Dragan Simic <dsimic@manjaro.org> writes:

>>>> With all due respect, "--rfc=WIP" looks like a kludge, simply
>>>> because "--rfc" should, IIUC, be some kind of a fixed shorthand.
>>> I wouldn't use "should" there.

> How about introducing "--label=<string>" as the new option,...

I still think --rfc=WIP is a lot more natural and easier to
understand, and it is just the matter of how you introduce it.
I'll show you how in a separate patch later.

The problem I see with an overly generic word like "label" is that
it would mislead readers to say "--label=important" and expect it to
appear on an extra e-mail header, not as a part of "Subject:".

But we can do this to get the ball rolling, without bikeshedding
what option name to use.  Until we find a good name, users can
use --rfc=WIP and when we do find a good name, it can be added
as a synonym, possibly deprecating --rfc, and if we never agree
on a good name, that is fine as well.
