Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FABF883A
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 12:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="l1UfW6LM"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3A910E
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 05:41:30 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A17FD1B37ED;
	Thu, 26 Oct 2023 08:41:29 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=1GTUb3SiHTc28nRSicySPDZggqKvxJb0Quphpl
	7/Zkw=; b=l1UfW6LMppqRQYkuqst7xqtEBm9620FeafxIXoTEKP3rBnEJEd2rkL
	soU4AlHh30sAYanjqx8irlQiBDjsygNeW1UQad78NFjDXkTJSZJMf7OutuNrzboA
	XMwpMgmZdxuEIh3fhyG/HlUtpYDlc0yi/6a/QPNJSAdmhs/0pZq9o=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 98DFC1B37EC;
	Thu, 26 Oct 2023 08:41:29 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 02CF01B37EA;
	Thu, 26 Oct 2023 08:41:28 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
  Michael Strawbridge
 <michael.strawbridge@amd.com>,  Luben Tuikov <luben.tuikov@amd.com>,
  git@vger.kernel.org,  entwicklung@pengutronix.de
Subject: Re: Regression: git send-email fails with "Use of uninitialized
 value $address" + "unable to extract a valid address"
In-Reply-To: <20231025072104.GA2145145@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 25 Oct 2023 03:21:04 -0400")
References: <20231013141437.ywrhw65xdapmev7d@pengutronix.de>
	<20231020100442.an47wwsti2d4zeyx@pengutronix.de>
	<68d7e5c3-6b4a-4d0d-9885-f3d4e2199f26@amd.com>
	<20231024130037.sbevzk2x7oclj7d7@pengutronix.de>
	<89712aea-04fc-4775-afd4-afd3ca24ad01@amd.com>
	<20231024204318.gi6b4ygqbilm2yke@pengutronix.de>
	<20231025072104.GA2145145@coredump.intra.peff.net>
Date: Thu, 26 Oct 2023 21:41:27 +0900
Message-ID: <xmqqsf5xr1xk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 FBE7FD86-73FC-11EE-B4E9-25B3960A682E-77302942!pb-smtp2.pobox.com

Jeff King <peff@peff.net> writes:

> Note that the bug will only trigger if Email::Valid is installed.

I recall we chased a different bug that depends on the use/non-use
of this package a few years ago.  Is the difference significant
enough that we may want to install on one but not in another CI
environment, like we have a separate CI jobs with exotic settings, I
wonder.
