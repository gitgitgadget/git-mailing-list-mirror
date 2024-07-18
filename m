Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A83C374CC
	for <git@vger.kernel.org>; Thu, 18 Jul 2024 04:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721278068; cv=none; b=uqwE3S9qPigivpHOYqDQK4rQRclfNxrLvJeLGVxXWQGgQb2ZcAnarKNdJvn0Zj6GNXb6Aqfv3iiUmqnb8ZWU1jvwjplvQZ2IOhjIyVRzwOWWyfSWqf6p5Ms8BePvfEe30poI4OC5BQf0yLzUTrg7x6pqDjZnTr7pF7L6VFwky9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721278068; c=relaxed/simple;
	bh=fzmova5BwzurH4/6k1eqTA+1UAQmUPCM+OFthsuVd30=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eJojul6uKNjjWpeR3nJn6xQjMlX4MiLaX15Obpk3VhK6qGXXuoQRdDBrzku+DXAbH7ik0w9Anoqpct4yVWbFrnLPpH99OF+jwqlCv2bXhL7J0eAVE7dk2olICq9hs08Q6ku/c6CE72Lt9A1BkW37BfGz8qKR+HBpWvQ2oHawaAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=brSUNF8j; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="brSUNF8j"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CBB4C267CC;
	Thu, 18 Jul 2024 00:47:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=fzmova5BwzurH4/6k1eqTA+1UAQmUPCM+OFths
	uVd30=; b=brSUNF8js6yDr2h43sNoh6KpQGim2aDoWO/vaIq3V/6KpLWmx1XE5q
	6uE0kgjmhO5W0pI03IWGO9bNsm6/ZKlQ4jG7Z6IX9jFDj8rKFRthUPx8o80vh/yW
	4gpYYBlcXV8fWqe0r7bJdJS+ODsrvu9Oz2ZBgCqw9Fuv741K9K37A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C1860267CB;
	Thu, 18 Jul 2024 00:47:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 36390267CA;
	Thu, 18 Jul 2024 00:47:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh <congdanhqx@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH] sparse: ignore warning from new glibc headers
In-Reply-To: <a1a771b5-f8fb-40e3-bae0-6307abbce58a@ramsayjones.plus.com>
	(Ramsay Jones's message of "Thu, 18 Jul 2024 01:02:54 +0100")
References: <a667da3985a0fe943cc0ff6ee8513d731d75a299.1721171853.git.congdanhqx@gmail.com>
	<xmqqikx42c42.fsf@gitster.g>
	<9bdac465-5f43-42de-9cad-e6c43a5a53cc@ramsayjones.plus.com>
	<xmqqr0br26ok.fsf@gitster.g>
	<8dd1a2c7-5b9f-4e2f-9c5a-d5d5758714e2@ramsayjones.plus.com>
	<0e2c66ce-d870-4a03-a26e-a928183b9b2b@ramsayjones.plus.com>
	<xmqq5xt33a10.fsf@gitster.g>
	<a1a771b5-f8fb-40e3-bae0-6307abbce58a@ramsayjones.plus.com>
Date: Wed, 17 Jul 2024 21:47:42 -0700
Message-ID: <xmqqplrb1f2p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 DEB1A2E0-44C0-11EF-9D97-5B6DE52EC81B-77302942!pb-smtp1.pobox.com

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> On 17/07/2024 23:53, Junio C Hamano wrote:
> [snip]
>> That's OK.  So in short, with a separate SP_EXTRA_FLAGS with "-Wno-vla",
>> Luc's patch is a sufficient fix without any downsides, no?
>> 
>
> Yes, assuming you're only concerned with 'make sparse' usage.

Is there anything else in the context of this project I should be
concerned with, wrt sparse and recent </usr/include/regex.h> that
uses vla in prototype parameters?

> BTW, I didn't expect it to take this long for this issue to come
> back to the list! I expected it to almost immediately cause
> problems with the sparse ci job, when the version of Ubuntu was
> updated to the LTS (now previous LTS!). So, I just found a simple
> solution for now (which turned into 2 years).

;-)

Thanks.  It really makes me appreciate whenever I learn that we are
blessed with project friends who are involved in many other projects
we rely on.
