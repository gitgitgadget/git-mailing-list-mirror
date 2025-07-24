Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620057494
	for <git@vger.kernel.org>; Thu, 24 Jul 2025 17:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753377481; cv=none; b=hrIMUXbfa4XV4BmAe3dxIjPVJn33W4OElhc+0G0oK4TKcqLNuH5ATqi06G4C7yi0Ih47uwAL5h8c9kkzuxP9q5RqBSQYNbKBbm4uW/6AOKp0FUzmOvpUhD0qItYR81AxVfmE2+Ggg8k6u/WO6b0aP+gU/gwWSbHm7RKEwlSGpjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753377481; c=relaxed/simple;
	bh=9+G25VI2f1nXq4VRA7/xYoRsdUftaNN1wDLiG268voM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=si8li89Zeiw1e0RYvQKJZ00nU0OOJPs+XhGlARIxBpDbxVbG+C+8YUVed9gePgGnnSakRjgr7JRMEaj9YBEECd2yioL8x2Jmp24KM5BXgrV0Wr80v/DM0Md7KkWypiCOGvTGyPTrHkJoFzF9F8uFjZx0UxUhnUF16U/HJju2m7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=P2RW1EAE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MQpIUqeO; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="P2RW1EAE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MQpIUqeO"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6A9B67A04FC;
	Thu, 24 Jul 2025 13:17:58 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Thu, 24 Jul 2025 13:17:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1753377478; x=1753463878; bh=q/VXQexw8Q
	BUIzj50azyFpHNfI9RnEJmVTgfKwxmpYs=; b=P2RW1EAE8J8j9ffqtC4GHxQN5M
	458XhBaEmURROvSIlAsEijz58Qv7YQKRqadsN6Y1rbW783wf70iPhRoJm76BtYgP
	y25Xpv+AHMqPTWpEmwwIrxNYjqXwfJN2htm5U7uUNjiuZ6UYXXbgHMdXyfrxcgi+
	js2JeHIyyXGAxIAOZXPuObKIHKuXOfSQ5Tzi0jh/IXrV1LjgEsb9FPyZox6S+gEK
	4xGlRhlWVo1BfN+lppDXvKAtqM6xcwQTxihsSZNZ0mjFJyzA4wpoG7AdJ2iOgd/o
	j4y+XhrsXrcY8hOKLIi8uyNeincxe58RlHr+FlJp+xXMNzVjUzAY8Oq446RQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753377478; x=1753463878; bh=q/VXQexw8QBUIzj50azyFpHNfI9RnEJmVTg
	fKwxmpYs=; b=MQpIUqeOZugK5USEt56OqCMmggcko+Lxty26m8o8mqo3+a0vr3L
	muqz+sTuXFNLwEeEffYCp8MVIzDlcjwc4PgwFXAdcEjBn52BeZsPy7J4Jc4hFEK/
	2XCWBn/Sh+pgAyRET8L4C8sXfZT3yjBYlmFttXofdAd1bPi9dSIUA0LfTaB36CsQ
	RZuKOoCPOc+v6M7zpua3JgfGGR44gtljW0LuVibQ+90xVmSh9NhZGnm0Ug+zdNja
	ztXJQF1THqErvJUR3sZA8c6FA3g+/VKdNYHqP4yJGiE7HabSz9O2kt3sY609lyVB
	ZELERW7JyqC6gOBaybJsQnmfus8Yvm50dIQ==
X-ME-Sender: <xms:xmqCaDz59eAXYGx7XKR9K6QRBzgSdEgDWhzvvpYebX1xP7wad7UpTw>
    <xme:xmqCaF0U4f8mUDFit8tHCi2sDJky-D3owrYFone-weUERqWwntSYpUseNHHC1JbnJ
    AQDgYUJf6FaUf_M5w>
X-ME-Received: <xmr:xmqCaJ5H_W_gqVdnqG0cP56D4KG8K8lGaEfZ_O_Ob2Md583dPQYf0bV-6_vN4oZpAi4Q6HT-bs0UoystFzogkn_nSP-QHU5XFuAOPdU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdekuddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeettddtveffueeiieelffeftdeigfefkeevteevveeutdelhfdtudfgledtjeel
    udenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdp
    nhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhgrrh
    hthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:xmqCaAWoGPRyqFpQyOHJCd4XILEj_89OtvMCO_faxh_AB1oqJmQX8w>
    <xmx:xmqCaABWpp4KJY81sCKXSEq6JvagWEQcd7e5O0N4i70Rx6M3UveB6w>
    <xmx:xmqCaH6xAc6Wb2id2M-QUb92qKbTFviCwoDB4fQKCloaZbv6vDqLvg>
    <xmx:xmqCaDythDsuvkz53VWYi3zZHCwJXUFEjpxLHAboZji35YY4UdfcpQ>
    <xmx:xmqCaIDgLZGJXyOm6fIuI59ieUWvDxFT5sYcTSRDfBikvZcWbgU9MMQB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Jul 2025 13:17:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/5] ref-cache: use 'size_t' instead of int for length
In-Reply-To: <20250724-kn-small-cleanups-v1-1-0c70f591de3e@gmail.com> (Karthik
	Nayak's message of "Thu, 24 Jul 2025 10:14:42 +0200")
References: <20250724-kn-small-cleanups-v1-0-0c70f591de3e@gmail.com>
	<20250724-kn-small-cleanups-v1-1-0c70f591de3e@gmail.com>
Date: Thu, 24 Jul 2025 10:17:56 -0700
Message-ID: <xmqq7bzxik3f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> The commit 090eb5336c (refs: selectively set prefix in the seek
> functions, 2025-07-15) modified the ref-cache iterator to support
> seeking to a specified marker without setting the prefix.
>
> The commit adds and uses an integer 'len' to capture the length of the
> seek marker to compare with the entries of a given directory. Since the
> type of the variable is 'int', this is met with a typecast of converting
> a `strlen` to 'int' so it can be assigned to the 'len' variable.
>
> This is whole operation is a bit wrong:
> 1. Since the 'len' variable is eventually used in a 'strncmp', it should
> have been of type 'size_t'.
> 2. This also truncates the value provided from 'strlen' to an int, which
> could cause a large refname to produce a negative number.
>
> Let's do the correct thing here and simply use 'size_t' for `len`.
>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  refs/ref-cache.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/refs/ref-cache.c b/refs/ref-cache.c
> index 1d95b56d40..8df7ae43e5 100644
> --- a/refs/ref-cache.c
> +++ b/refs/ref-cache.c
> @@ -498,13 +498,14 @@ static int cache_ref_iterator_seek(struct ref_iterator *ref_iterator,
>  		 * indexing to each level as needed.
>  		 */
>  		do {
> -			int len, idx;
> +			int idx;
> +			size_t len;
>  			int cmp = 0;
>  
>  			sort_ref_dir(dir);
>  
>  			slash = strchr(slash, '/');
> -			len = slash ? slash - refname : (int)strlen(refname);
> +			len = slash ? (size_t)(slash - refname) : strlen(refname);

The "strlen()" side is good, but was there recently a discussion on
how to safely convert (slash - refname) that is ptrdiff_t to size_t?

My archive search found a rather old ptrdiff_to_size() proposal
https://lore.kernel.org/git/20241227213729.GA796141@coredump.intra.peff.net/
but I thought there were another discussion thread about casting to size_t
recently.

I _think_ a vanilla cast is safe here, as slash sits always right to
refname (if not NULL, that is), and the difference should fit within
size_t (because the difference is smaller than the size of the
memory block pointed at by slash).

So in short, this looks good.  Will queue.
