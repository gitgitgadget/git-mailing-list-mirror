Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CA32036F9
	for <git@vger.kernel.org>; Fri, 14 Mar 2025 17:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741973322; cv=none; b=BsMOsT2issvZkmYXcoMuQUhKkIiWn53NxY4rkLeX8r9mkfmADHztK6g4iJ0qggJK76Kb0l8gMFCLtOoQ64JQjpZTV3o4l+XH/0z9O+TV1cmvHyfI/kE7h0AA7fSe0zzo5ZZs26Xtj1pbuljhcK8cexbIP/m/fXc3h/Fs3XZe+/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741973322; c=relaxed/simple;
	bh=oggTFNw746HKOtrqjxyR1KBPfYOe9jZik6xYkEc406U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kfVO3A4lin1MFC12zF81Hvc9Z96EHMzjPJxV+ByGk4Dyo3gkx8lHT8X1NpIxHvcyUz80XpBUba68RK4NKWNPqqat2Ei/KI7AwRvEDPZ2/TncZfaU9G2O6buF9TvRUxPfBEKWc5d3/sWHSsKnTj7knkNzmyMm5IGbUoE6iIsu0bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=EB0P1xOf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EIZFTJbC; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="EB0P1xOf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EIZFTJbC"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 7D6841382DA3;
	Fri, 14 Mar 2025 13:28:39 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Fri, 14 Mar 2025 13:28:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741973319; x=1742059719; bh=0kRCyb0+NI
	iJqoiHd+EXXLOrjXrYMV3jEDVhvfGL1Es=; b=EB0P1xOf3ke8IvR0vYLhzh2AAd
	djAoMDdb7x4Trk9PmQaPRHiAmJm2a03qXqMs6S739OCu5LOGDnqC0ZzN3S/inBHY
	GeYK9D+hHoU9Q5nPV5Pnl1whMeKWyVs/PIo5DF4QSZCBdJaoxsUUAmPM9aYnrCii
	LlGWG5TeNyV/nq+HKZkX8KNMp4Q3rxPMz5mtuwqOl/ChecVCwTfPi8ruazUF6FEe
	LYzvdtoPGv2iMJlhxIhFmlQg7dNDxLcIjXmhPAqyGqaFwGo1WA9/VJRAHomx5i+p
	NCNA6GOlpJaMoeetiNIjR9Wf5+BA5cOJGARRcO0mKc+V4BeG+yKkaEKGFYpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741973319; x=1742059719; bh=0kRCyb0+NIiJqoiHd+EXXLOrjXrYMV3jEDV
	hvfGL1Es=; b=EIZFTJbCirZVXh95nkALSjGx3jlQgowHPTBDczOdePKdvkObXaH
	rLcjlbZvNtWIF7kuAbwvx7lgP+sjK9Wn5I1SebBiCmzUzP4WCY3bA4owUT1/z5tW
	aQnRCOBl6Bvx75h67tqON41Jvz07llk7FHffH6/KQ+fe0IhsQQQt8abllDc+NsWm
	uvtaM3ttfZIaazTn+/h4yTX5K/2/OyFIX1eMkrymau0dRnBWlDcbU8GIbl5cFhN2
	OGsRbL4wgoZjQSzwhTmvXS1tyni+Ijl+oBTGRMeIic5/BT0fW+5jBrBbXdfMk6Di
	fs7wJQGiEqADUpKEQHTKL9blzIQLYZoj3pA==
X-ME-Sender: <xms:RmfUZ_3e5h0Lq1dBuXrm_Bu5p3gx7nX1rQpncthbyBWGHiOlNiTGRw>
    <xme:RmfUZ-Fb1maLJp6botrSLWP4QpUEG1JpHABeP71Df0sdJP2DuvkLyWOuQk4wZC9Io
    iZqaeh6z2bYbP918w>
X-ME-Received: <xmr:RmfUZ_6cnShfGRQV73kqF0qqKOpdCOJH7-s5hIZYnzsvA8MSaCjdefdnlvOfIneKjow51kfRZFCXJs3ZY8a0olZGnJv5Oy_Gd5Mq92E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufedugeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepuddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegthhhrihhsth
    hirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprh
    gtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdr
    tghomhdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpd
    hrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthho
    pehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprh
    gtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvth
X-ME-Proxy: <xmx:RmfUZ014MynBwQLsjEgCug4FHM4APzjZPPiHsYW1_LLCbXvLEDsyqw>
    <xmx:RmfUZyErP7LYidzvQpSYc8bR61_hjs229PxEq015gLSgx0-Xrre3zA>
    <xmx:RmfUZ1-f94br0uW3NLcFcwGOI83udYow5OhOc6JZnMRJr5QbpfGQ8Q>
    <xmx:RmfUZ_nGz7AG70uoL3fidj_Hoc90Riq53Opp9aneYnVwuQ0xrQj75w>
    <xmx:R2fUZ5d3z7P14GydyLeTOpxzMBAf7FkaLLFktkmSqQ-oeQYYSZ4ffTm5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Mar 2025 13:28:38 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Patrick Steinhardt
 <ps@pks.im>,  Taylor Blau <me@ttaylorr.com>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Karthik Nayak <karthik.188@gmail.com>,
  Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,  "brian m .
 carlson" <sandals@crustytoothpaste.net>,  "Randall S . Becker"
 <rsbecker@nexbridge.com>,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v5 3/3] promisor-remote: compare remote names case
 sensitively
In-Reply-To: <20250314141203.2548803-4-christian.couder@gmail.com> (Christian
	Couder's message of "Fri, 14 Mar 2025 15:12:03 +0100")
References: <20250313103859.817127-1-christian.couder@gmail.com>
	<20250314141203.2548803-1-christian.couder@gmail.com>
	<20250314141203.2548803-4-christian.couder@gmail.com>
Date: Fri, 14 Mar 2025 10:28:37 -0700
Message-ID: <xmqqo6y3h67u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

> Because the "[remote "nick"] fetch = ..." configuration variables
> have the nickname in the second part, the nicknames are case
> sensitive, unlike the first and the third component (i.e.
> "remote.origin.fetch" and "Remote.origin.FETCH" are the same thing,
> but "remote.Origin.fetch" and "remote.origin.fetch" are different).

I double-checked what the control flow that passes through
remote.c:handle_config() does, and the above is in line with what
remote_get() does.  

remote.c:read_config() populates the nickname-to-remote hashmap by
using handle_config() callback, which calls make_remote() with the
second level name (e.g. "Origin" and "origin" in the last example of
the above), which is passed to memhash() not memihash() when looking
up or registering the remote.

If we used case insensitive comparison in the new code, a malicious
large-object promisor remote could have told us to use "Origin" as
an extra promisor and in response the new code may noticed that we
have "origin" and tried to equate it with what the other side told
us.  But when the existing code actually interacts with the promisor
remote, it wouldn't have found any configured remote under the name
"Origin", and something funny would start from there.  By using the
right remote consistently throughout the system, we would not get
confused that way, which is good.

> Let's follow the way Git works in general and compare the remote
> names case sensitively when processing advertised remotes.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  Documentation/config/promisor.adoc | 4 ++--
>  promisor-remote.c                  | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)

Looking good.  Thanks.

> diff --git a/Documentation/config/promisor.adoc b/Documentation/config/promisor.adoc
> index 9192acfd24..2638b01f83 100644
> --- a/Documentation/config/promisor.adoc
> +++ b/Documentation/config/promisor.adoc
> @@ -26,5 +26,5 @@ promisor.acceptFromServer::
>  	server will be accepted. By accepting a promisor remote, the
>  	client agrees that the server might omit objects that are
>  	lazily fetchable from this promisor remote from its responses
> -	to "fetch" and "clone" requests from the client. See
> -	linkgit:gitprotocol-v2[5].
> +	to "fetch" and "clone" requests from the client. Name and URL
> +	comparisons are case sensitive. See linkgit:gitprotocol-v2[5].
> diff --git a/promisor-remote.c b/promisor-remote.c
> index 0b7b1ec45a..5801ebfd9b 100644
> --- a/promisor-remote.c
> +++ b/promisor-remote.c
> @@ -370,13 +370,13 @@ char *promisor_remote_info(struct repository *repo)
>  
>  /*
>   * Find first index of 'nicks' where there is 'nick'. 'nick' is
> - * compared case insensitively to the strings in 'nicks'. If not found
> + * compared case sensitively to the strings in 'nicks'. If not found
>   * 'nicks->nr' is returned.
>   */
>  static size_t remote_nick_find(struct strvec *nicks, const char *nick)
>  {
>  	for (size_t i = 0; i < nicks->nr; i++)
> -		if (!strcasecmp(nicks->v[i], nick))
> +		if (!strcmp(nicks->v[i], nick))
>  			return i;
>  	return nicks->nr;
>  }
