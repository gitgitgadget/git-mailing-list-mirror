Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFC922E3E9
	for <git@vger.kernel.org>; Tue, 12 May 2026 01:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778550584; cv=none; b=RIX5b+Sfaz3tcs56y2mkQqwPdC/mov8L3l3GywQcMp3eXQEv9vSQJ7CliVsP/IBROoW8NIwebOUzxYUct/UktM0m0Xn+nSA2rZpdK7I6YeWMF2n1fo6eXNIsK1i1iqkARu4O/VN8MP9UnV0PfDeFdN+uzCqC342yODl1/OUaZbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778550584; c=relaxed/simple;
	bh=6Wci1N37GObymmhWFYgOYbr5tTZAkH3IWiS8hBnSxHQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EK27lN5+ihKfLEr2SnceOcj1JPFFMdbDzYjpoRtS5tFYDV2bZDuCb5Az+fZ/V2S9me0Tn9L5trunjipDm+LLpkpJv9yZjxLCyZEwrmdSExAFTL6/wq39iQ81YP7LF98jrJfe6p6nQg/dfYdvMqbxOFKHfBQH9sDOlPOtk9IZgX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KIz1Fdfq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=n6TOTrg0; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KIz1Fdfq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n6TOTrg0"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id F20877A00CE;
	Mon, 11 May 2026 21:49:41 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 11 May 2026 21:49:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1778550581; x=1778636981; bh=v+x2EROTNO
	4LrArpB9VMCnfaALJKC51OtK9jt+QJ6VM=; b=KIz1FdfqvrfPYEKi8fEdDeKXPU
	/zM9RVR8JvWXlnjI8RZCOYo7JPc9BHkI09RzwyJd9EuEtChMUZjEvBqjpMy6S3ZB
	rJAmvfkzzpBbhoZYyDgwZ0qWpqOEjQC0mgORx9940XK61YIn3qadMmCWq1j5IYCk
	yh8V/ynAUvtYF/crITwcIg+hT397lNxtZ9x1iIcecs8wNPKxPapnx056txoE8cUZ
	BafoqGxHLxp+1T5q8Fb4PK8ZtFR6tyoTzRCvYjV/Nfvb9GoDyxaJuyHWlOikgb7b
	I6QUAmeEVwBCB0pNXxC9pICKr8J+nOfqooAMTZ9ZnZdmvwuytnvSCVqg0g0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778550581; x=1778636981; bh=v+x2EROTNO4LrArpB9VMCnfaALJKC51OtK9
	jt+QJ6VM=; b=n6TOTrg0YvwbfTyYu1X0zkBhJRkQCBwyHsftAlROs17gdBaSsOz
	tVDNpW5MY0q3i2G58kWcX+Dgx+ezxlMKdE5hahzo1znDkdmgdNNgC2UaStzCAdGI
	VMTndhIlbhmp/xcZ7YLSLFnJiEBLT4gnmZLzUD/nGEPkBKTyFffnGGGtH6f67scl
	kRhX+rGMghBGST8DL00imQ2VHnjN6+EudYUovySNyvClsIIPSwjFrOixtQ8yOOqF
	D77A3qGT+pj1zwB6ISnTUZcuGnmxgogvz9x1iYyfObRwOJs5EbO0SNXVXuZnaHkc
	YUiU+f57arv0l6RrEuOGn2ADpKygQiQ0paw==
X-ME-Sender: <xms:NYcCalD49RWBGQAR3Foo4_nMRU-9NEZUvm9EJsC-ZYGQuH19bgFWCg>
    <xme:NYcCaqaAv7tDpzSiJrgG9i6k0WIRqxTzONEKAQKVJrnvFy9LZifD0FTfk2U8_76xz
    ebx9R9lh53ghpzmegELFLk_QSTwykK0Sbq0fg1v-PGBIQF83bMu>
X-ME-Received: <xmr:NYcCao59OS7GG9nmcXP11ipvcPbSxqkCWCEyeafiO0QHOYq-2YL6Le_PU3TRspATfuNLKZRWms08b2oGEMMn4-7Emdo-FuGE6g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvddtheefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehp
    vghffhdrnhgvthdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:NYcCarYz0b2nSkAA6_HQxoF5op8MJ30E6ExukZjsxJhcvR64pJtfrA>
    <xmx:NYcCanhFZnvrAT2Cs07GyESjhTYWnyXqyP2pJw1YFNdoejAfDCDHfg>
    <xmx:NYcCas-9kYsVrDNyzolXksaXVLLoDxCvcWTtIR4nzqu7QR3utt86VA>
    <xmx:NYcCaioTozBWJwknic4pfRwuU3SytYdpPkHwKUj00CB7Ddk75JcM2Q>
    <xmx:NYcCan7VktD0Uk3KhEBvPxvCI-XGRKwtGW27N43LOtzBvnYkzNt6t4b3>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 May 2026 21:49:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Elijah Newren
 <newren@gmail.com>
Subject: Re: [PATCH v3 0/9] pack-bitmap: fix various pseudo-merge bugs
In-Reply-To: <xmqqse7xpftn.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	12 May 2026 10:38:44 +0900")
References: <cover.1776124588.git.me@ttaylorr.com>
	<cover.1778546804.git.me@ttaylorr.com> <xmqqse7xpftn.fsf@gitster.g>
Date: Tue, 12 May 2026 10:49:40 +0900
Message-ID: <xmqqo6ilpfbf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Taylor Blau <me@ttaylorr.com> writes:
>
>> [Note to the maintainer: this series has been rebased onto the current
>> tip of master, which is 7760f83b597 (Merge branch
>> 'jc/neuter-sideband-fixup', 2026-05-11) at the time of writing].
>
> A note like this is very much appreciated, but please also state the
> reason why the rebase was necessary.  "Because the current tip of
> 'master' has advanced" is not a good reason.  "The previous
> synthetic base was made by merging topic X and topic Y on
> then-current 'master', but both have graduated" is a so-so ok
> reason.  "Because the updated implementation of this series uses
> facilities that appeared in recent 'master' that come from topics A
> and B, which the previous iteration did not use" and "Recent updates
> to 'master' brings in conflicting changes from topic C" are
> excellent reasons.

Forgot one important case.  "It turns out that this fix is important
so it was rebased to be applicable to an older maintenance release M"
would be very much appreciated as well.

Perhaps after coming up with a few more good reasons, we should
describe them in Documentation/SubmittingPatches somewhere.

