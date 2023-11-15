Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2800F396
	for <git@vger.kernel.org>; Wed, 15 Nov 2023 01:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DkzwLpWR"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E54E7
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 17:01:02 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A5AD41D259B;
	Tue, 14 Nov 2023 20:00:56 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=GxPdNpe5jjTNTQXAd92MFHMWR7VLXiJi1H2brJ
	JIYt4=; b=DkzwLpWReOeMABVffhNBY/2ValEHARCRGcqtLu2cbzjtY0cqygOLEj
	YSxjiGG2A0EUt7iyl7GUWGy0hs43gGX/r5edicnKupYnbZJZmSiiFV4pPnMeK0or
	O/P6i848QPcyXnqImpXgDiFdWOBXGOuFlPZuUCRFSi5wC1njwhBlo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 820241D259A;
	Tue, 14 Nov 2023 20:00:56 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4C9661D2592;
	Tue, 14 Nov 2023 20:00:54 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: Jeff King <peff@peff.net>,  Johannes Schindelin via GitGitGadget
 <gitgitgadget@gmail.com>,  Phillip Wood <phillip.wood@dunelm.org.uk>,
  git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] ci: avoid running the test suite _twice_
In-Reply-To: <ZVPm0qn6XsbLL8eM@google.com> (Josh Steadmon's message of "Tue,
	14 Nov 2023 13:29:54 -0800")
References: <pull.1613.git.1699894837844.gitgitgadget@gmail.com>
	<20231113184909.GB3838361@coredump.intra.peff.net>
	<xmqq4jhp438y.fsf@gitster.g> <ZVPm0qn6XsbLL8eM@google.com>
Date: Wed, 15 Nov 2023 10:00:53 +0900
Message-ID: <xmqqttpnx22i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 6D89604C-8352-11EE-95C3-25B3960A682E-77302942!pb-smtp2.pobox.com

Josh Steadmon <steadmon@google.com> writes:

> On 2023.11.14 08:55, Junio C Hamano wrote:
>> Jeff King <peff@peff.net> writes:
>> 
>> > I do have to wonder, though, as somebody who did not follow the
>> > unit-test topic closely: why are the unit tests totally separate from
>> > the rest of the suite? I would think we'd want them run from one or more
>> > t/t*.sh scripts. That would make bugs like this impossible, but also:
>> >
>> >   1. They'd be run via "make test", so developers don't have to remember
>> >      to run them separately.
>> >
>> >   2. They can be run in parallel with all of the other tests when using
>> >      "prove -j", etc.
>> 
>> Very good points.  Josh?
>
> In short, the last time I tried to add something to CI, it was not well
> received, so I've been perhaps overly cautious in keeping the unit-tests
> well-separated from other targets. But I can send a follow-up patch to
> fold them into `make test`. Or would you prefer that I send a v11 of
> js/doc-unit-tests instead?

Incremental patches to update what is in 'next' would let us try out
the new arragement to drive the tests from the main "make test"
eaarlier.  Post release, a new iteration could replace the series
wholesale as we will have an opportunity to rebuild 'next', but it
would be nice for the end states to match, if you were to do both.

Thanks.
