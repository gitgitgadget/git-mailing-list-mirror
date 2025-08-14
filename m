Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0322A321425
	for <git@vger.kernel.org>; Thu, 14 Aug 2025 14:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755181344; cv=none; b=FQA/eIf135U5YmNLjAZRkSfmTzPRdT1ycIbbqJoYZvEJ0sO3XYBtqR1OqLj7N73ZV8a55ZFFDcxJoylbTl1fMOBtRcB8ukCxF7Atd8uO8NN3J92r9lbR6a7+iZaPZDah6v2Ee9/ImSVeh/V2w2IcHJOozA6QRLzxwVsNKiipaiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755181344; c=relaxed/simple;
	bh=+BmdJKiv3dciw79gD3W8HawbMQtJxe2wLnCthI8u7QI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iU5hhkha5y5oRDwXJ6rU3b5yv7x3eI9ABDmdsOlwjliq6mW/QS0EhtVhjoaqviP+dU/qSSVM5KJzef+18URrKdnkcHN5gdiVgK8BT7av+yQ2Y6cOGOUfLDyslPac+EhfHLNvvPPa/6CZXQ/k4x+pHlj2C+6COyRyWNBKE24H25o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TVacqDPz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Psye5rE/; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TVacqDPz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Psye5rE/"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0F8EA1400149;
	Thu, 14 Aug 2025 10:22:21 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 14 Aug 2025 10:22:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755181341; x=1755267741; bh=avIteoU/YK
	IpYCx15j8QdxwnBOZSt0xyhU/HNgPeRNY=; b=TVacqDPzh6DTbhThgXlIFGVTH8
	MYf9Rbkkf+l2+r8vstD9PGzbq7yMcIGo2oEcDgUbtHAAW6KB9hIsShGLTXM6AZXA
	QsoIYs4CSTUCXpH2mDK4t6IkEHCFT4vnMVx9/MZFwZGDV3j2yE9ZyMeD4tiIrzte
	14tIQWMkA02/wrkTBoHCFJ1Ps10MykZ5JiL+eQeoPKT4MXhvWATnCR/ObXwdQPp3
	Z9y63wtli7b1MgJ0gCm+Kzd5dalyZ/9lwiG0sjhbpu3ryexAt8f1Di7pd6m3ytv5
	z0zXfrglVqLgDx0hmvMtHz2cKdBbiTrKnkCaH00gd2w+yEXkWhHGx04wDx+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755181341; x=1755267741; bh=avIteoU/YKIpYCx15j8QdxwnBOZSt0xyhU/
	HNgPeRNY=; b=Psye5rE/zRWmJKVnHNbgToQgqxv7iUAusYzlaK5ANvYKEnlE7vt
	RPgmT57j5HxRj4TaVi1ZzJ7Lwsw1Mvs8WkIMeJn/b6wMowF3CVN+4IdEA2ULrrq7
	Ubt88BA/vjqtHXaY1vyBcc7CXKC6/NJLT+X5yqquaQQVTr+JL1M28oJnYpT2Z+U/
	uX6r/arrWQl2bTzmS/mwiJwA2HlaqyDA7HRQg3yw5rxtmxomOUIvAUwah1SVvIot
	59q3fMiV+G42q+3OvGYPzhoOug2a69jqxFphVGAntc+//jozyLXURNFQ+aDiPkVg
	JXJ1ogYru8h23tuWLif/dLASod328SgQPIQ==
X-ME-Sender: <xms:HPGdaJSrYqXPeuFed4_8PhZZvvkhRpf193AM1flWa5Ah6hAoyYa3JQ>
    <xme:HPGdaPvDJik2hZZLv3LmdADPJqY4vKpJvXKwSbhx4g-gcNksfEX3AkdzQsVl0-p97
    PSGAKnNZbwGtFq7wg>
X-ME-Received: <xmr:HPGdaKcR4iOOvP2anMpn_UPrUWL7JDJPbt6oSDBQ-NfP_x2-8pzNh1oPBkWpZ5uScguxNabJsdPqnYs94efaOdwVB2TjvCFDCESLcbw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugedufeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepgfetheeukeejkeffheduhffglefgvdevhfelleduudduffejjefgteeltdei
    ueeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprg
    hsthgvrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepmhgvsehtthgrhi
    hlohhrrhdrtghomhdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgt
    phhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepjhhrnhhivgguvghrsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:HPGdaJYcUKPfBYLDKI0AV4IsW3ONzQJp0JURZ83qY940pxrr68YeOQ>
    <xmx:HPGdaMbtytGDtpiK6lLXE_rY-xdIvMno518E_aCf6Ki_nubaPv3lrg>
    <xmx:HPGdaOJxUg5skn0pkO_S2C3sl5z5nESol1TEczbSHvrJokIfHI-VUA>
    <xmx:HPGdaItpd1bqevoFSDTxUNZYDTnvoFiogtsQti8glK2Nhi2mgRmhTg>
    <xmx:HfGdaJSBRAscNqrk953Mm00GfsV4O89Wfe_xeV6qv03h06yIJv-bBF9N>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Aug 2025 10:22:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Taylor Blau
 <me@ttaylorr.com>,  Derrick Stolee <stolee@gmail.com>,  Patrick Steinhardt
 <ps@pks.im>,  Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Efficiently storing SHA-1 =?utf-8?Q?=E2=86=94?= SHA-256
 mappings in compatibility mode
In-Reply-To: <aJ03RTHaE_JvHA1t@fruit.crustytoothpaste.net> (brian m. carlson's
	message of "Thu, 14 Aug 2025 01:09:25 +0000")
References: <aJ03RTHaE_JvHA1t@fruit.crustytoothpaste.net>
Date: Thu, 14 Aug 2025 07:22:18 -0700
Message-ID: <xmqq1ppe9e5h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

I do not know if you want my input (as I wasn't CC'ed), but anyway...

> ...  We can store them in the
> `loose-object-idx`, but since it's not sorted or easily searchable, it's
> going to perform really terribly when we store enough of them.  Right
> now, we read the entire file into two hashmaps (one in each direction)
> and we sometimes need to re-read it when other processes add items, so
> it won't take much to make it be slow and take a lot of memory.
>
> For these reasons, I think we need a different datastore for this and
> I'd like to solicit opinions on what that should look like.  Here are
> some things that come to mind:

I do not see why loose-object-idx is not sorted in the first place,
but to account for new objects getting into the object store, it
would not be a viable way forward to maintain a single sorted file.
We obviously do not want to keep rewriting it in its entirety all
the time,

> Some rough ideas of what this could look like:
>
> * We could repurpose the top-bit of the pack order value in pack index
>   v3 to indicate an object that's not in the pack (this would limit us
>   to 2^31 items per pack).

Nice to see an effort to see if we can do with a small incremental
change, but would a single bit be sufficient to cover all the needs?

I suspect that the answer is no, in which case the v3 pack .idx
format would need to be further tweaked, but in that case we do not
have to resort to such a trick of stealing a single bit from here
and abusing it for other purposes.  We should just make sure that
the new .idx file format can have extensions, unlike older format
that has fixed sections in fixed order.

If there aren't any radically novel idea, I would imagine that our
design would default to have a big base file that is optimized for
reading and searching, plus another format that is easier and
quicker to write that would overlay, possibly in a way similar to
packed and loose refs work?

> * We could write some sort of quadratic rollup format like reftable.

The mapping between two hash formats is stable and once computed can
be cast in stone.  Other attributes like the type of each object may
fall into the same category.  Multi-level roll-up may be overkill
for such static data items, especially if consolidation would be a
simple "merge two sorted files into one sorted file" operation.

As there are some objects for which we need to carry dynamic
information, e.g. "we expect not to have this in our object store
and that is fine", which may be set for objects immediately behind
the shallow-clone boundary, may need to be cleared when the depth of
shallowness changes.  Would it make sense to store these auxiliary
pieces of information in separate place(s)?  I suspect that the
objects that need these extra bits of information form a small
subset of all objects that we need to have the conversion data, so a
separate table that is indexed into using the order in the main
table may not be a bad way to go.
