Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7299D386424
	for <git@vger.kernel.org>; Mon,  6 Apr 2026 16:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775492864; cv=none; b=biYsgJY88R6gZdkG+9fyYxcDXRcgg6L04Gj3t7WE3XULgtd5SX8XlKrwMdYdV60gxo2d8Go1kw2W5/YD1dp4Pangv00vJwGRYENJwFGAdMs0IzPSwBWZfV/SC7fA5O+dFv/Tc3sEhLAYOY2YGsd7TZ0Khjjde5ANoHtc6ZqgXow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775492864; c=relaxed/simple;
	bh=7jMmvq3f7rHU99isyhOTmH5qE6fE7tX9zq5MIelYqXo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SKfmgBYcZqzDYtsmpxaa7zISF6IlNdse7LVp6kIZEHSxyW5oA/vGXIWS7oc6EQdjIfG9Ipj6VmCUnECtHMzEDj9eU6blYsKzNgForT7y9XkzjJEPQ3vnAAWTXH6Kir9vWdvQJ97IzDZmb0HNF338YVoFJxYLLtEV4uIj4fCBr4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=rUb7xf8L; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A5xLB32T; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="rUb7xf8L";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A5xLB32T"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id C45B51D0022F;
	Mon,  6 Apr 2026 12:27:42 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Mon, 06 Apr 2026 12:27:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775492862; x=1775579262; bh=KVVbEnXwpn
	nZyNPCIQeTCcoYNPzFCSZVM1mS372Ntbk=; b=rUb7xf8L/bJ6/naubEBZEktuU/
	Qdk/JCYfrSphmb2SKTA74lYTB63pBlQSR4JWwFniIkc7xizuOUvosDZVOmecacty
	dAm3jsMOkdvapQPbHN47i5b8soiEOv3c6YghGTQnfOEWn+p4ZYtTcF2HSs5LQwX0
	kFpTByjiF5sHT2nM7pxIM6wRXOMYpVvaRFhQwMb5GigegpdQwxHOnfixs6OQotwF
	aRZHZ2S1kdQv9Ml3FVd3fdZmOWB972ymQ2ojAXuuLFaWs+p+Xf7poGv8ypSn1KE1
	kzW4OU+1SdTtU0CWnXnxMGf1SVi2SE6hOajZrZwMbwTNgRjl1tHeP1wHi//w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775492862; x=1775579262; bh=KVVbEnXwpnnZyNPCIQeTCcoYNPzFCSZVM1m
	S372Ntbk=; b=A5xLB32TtxuYKLFUHlvtO3IWo/FVLwH9+G+u6G+1zP0ZBsVilXf
	tnMhAhF+Px1bcuLczfEhjruNvCor4GIo8oABI8ZHA2yc2SKhrSSmV3NMRvcSX0d4
	6+uAJKL9i1X0gn3O7T5Nv6JT0wgsKulGnqZ/cJtz06TO8fdznmMHkT1LtIGPunap
	/aXHgPy7fy2F/ZsppB7T7IBa8X6bywlyBNk1/82klwvB3tR0QAl2Bo2peaFp6mZz
	2oKjnnBMO2sCQitPHsBZNllzL3HIyJMoFmWeBMY2owS3O4yYFj9z8gccKmtSr5IW
	s4GrIGqsdNhHmcxa6LjgMivPw0cQCTYKdxA==
X-ME-Sender: <xms:_t7TaSjruFohPzMHEs8hzvloI8mM45HlMgAdSkxT1_Ad3OjfRXzCnA>
    <xme:_t7TaaDQEKCpIMZf6UFc86b03Sj2d8XBLvVKLnpT0FZd_pyQDd1ufTK4YyrhrLdHu
    tRNJFORowcQz83aeOcmDn_VAmiPjaulX7SqdECDC7WgqIS63vuGdg>
X-ME-Received: <xmr:_t7TafGhAsTmymVHyhAu4mB0rBmu-TtWcYv-Uve8eqa5K3b_EvfTJLKja0Ar22nNfOPWxdNVgnX13F-b998XdaRYmV0o4qIkdg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddukedvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtth
    hopehvihhkihhnghhttgegsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:_t7TaaKH6fOsIjmYdGQPI1fsr-kUmzaBjtZSgn9Y-0uLh6aI6iB1QQ>
    <xmx:_t7TabmB49wetx26ulxCbbvQqQJBi6MXfCrfQZQy5mr6enJVgxK7ag>
    <xmx:_t7TaaS_jMYeEbZ73dp0GI6KgBmrU62Ly9a_EA3cFynQ23iEQe-GXA>
    <xmx:_t7TaVIENmldjO59s_5h1ukOnlML1Xk-eEWprBXQOjrVD7BbAwxBnQ>
    <xmx:_t7TaWk_-CQgymlbNDVHb6BgmTI7RBZa8FZ9c-So3DljRejixxndez70>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Apr 2026 12:27:42 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Trieu Huynh <vikingtc4@gmail.com>,  git@vger.kernel.org
Subject: Re: [GSoC PATCH v2] backfill: auto-detect sparse-checkout from config
In-Reply-To: <e16edc29-a281-42f8-a712-4114d6a3288c@gmail.com> (Derrick
	Stolee's message of "Sat, 4 Apr 2026 13:36:52 -0400")
References: <20260404111557.17220-1-viking4@gmail.com>
	<e16edc29-a281-42f8-a712-4114d6a3288c@gmail.com>
Date: Mon, 06 Apr 2026 09:27:41 -0700
Message-ID: <xmqqjyukcav6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Derrick Stolee <stolee@gmail.com> writes:

> On 4/4/26 7:15 AM, Trieu Huynh wrote:
>> From: Trieu Huynh <vikingtc4@gmail.com>
>> 
>> Commit 85127bcdea ("backfill: assume --sparse when sparse-checkout is
>> enabled") intended for 'git backfill' to consult the repository
>> configuration when the user does not pass '--sparse' or
>> '--no-sparse' on the command line. It added the sentinel check:
>> 
>>      if (ctx->sparse < 0)
>>          ctx->sparse = cfg->apply_sparse_checkout;
>> 
>> However, the ctx->sparse field is initialized to 0 instead of -1,
>> so this guard never triggers. Consequently, the repository config
>> (core.sparseCheckout) is never checked, and the command always
>> performs a full backfill even when sparse-checkout is enabled.
>
> Thanks for adding this context. This patch LGTM.

Yup, thanks, both of you.  The original patch without this
explanation may not be so obvious but after taking a look at what
that commit did, it is very clear what went wrong.

