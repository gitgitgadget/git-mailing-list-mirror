Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21D73B7A9
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 18:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DQrrEQW0"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EEAF10D0
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 11:16:56 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 663B51C947E;
	Tue, 24 Oct 2023 14:16:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=n1EUHRJ8GI08V5NHRxMLQ5LwFgh49pQj/f+baF
	samws=; b=DQrrEQW0pdqH9WCKcbGTt/8Bv5+DIrVRZRI/FQqVakm7AlQa8K/sHe
	4NHim8ZiRiG57orsKMClf/lIXuktHthLaXaNZJwsxt9gaygMxDcmFqENY8Xd0xfi
	q4OEeKEuJL9nSOC+5AlpAN8ChN8PdfzGWluTsunZom2KgqZv/OR1s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 596CC1C947D;
	Tue, 24 Oct 2023 14:16:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BB71E1C947C;
	Tue, 24 Oct 2023 14:16:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Jiang Xin <worldhello.net@gmail.com>,  Git List <git@vger.kernel.org>,
  Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH 2/2] fetch: no redundant error message for atomic fetch
In-Reply-To: <ZTZF3AbNNuGpy38l@tanuki> (Patrick Steinhardt's message of "Mon,
	23 Oct 2023 12:07:24 +0200")
References: <38b0b22038399265407f7fc5f126f471dcc6f1a3.1697725898.git.zhiyou.jx@alibaba-inc.com>
	<ced46baeb1c18b416b4b4cc947f498bea2910b1b.1697725898.git.zhiyou.jx@alibaba-inc.com>
	<ZTYue-3gAS1aGXNa@tanuki>
	<CANYiYbEJ_mHdsPM3-huDPFktSWFhrpoz7Cvf000JSfZM2cco9w@mail.gmail.com>
	<ZTZF3AbNNuGpy38l@tanuki>
Date: Tue, 24 Oct 2023 11:16:53 -0700
Message-ID: <xmqq7cnb51ii.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 82F72A32-7299-11EE-9026-25B3960A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> With that reasoning we could get rid of the error handling of abort
> completely as it's known not to fail. But only because it does not fail
> right now doesn't mean that it won't in the future, as the infra for it
> to fail is all in place. And in case it ever does the current code will
> run into the bug I described.
>
> So in my opinion, we should either refactor the code to clarify that
> this cannot fail indeed. Or do the right thing and handle the error case
> correctly, which right now we don't.

Sounds reasonable.  Thanks for a good review.
