Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A241A08A6
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 16:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754066465; cv=none; b=BgViUKnt1uX1aH1scP7QVnw3aKjJ6dNWcFMXIzM90V8qhKs3Yu2X6J5ItKWmxvHWBLXKDSFCCbGiP0NzYod93h3OmMq8a1NxYgdHPBCHRo08dAtdtEabaQXezWch6rBxcQ00XpMsDhDWm2VZIGeg32Hi5hwRaQDQh/sBwXyY1kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754066465; c=relaxed/simple;
	bh=TB8t1uR2CVG4F7hEIbh7aUESG9Bp1o2EIGn409eMnts=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SufQQLRpdUYKGYyNaLTEPfaX8eqygsnngEOW72uK2gPnT30vp3/i4DtAHyJ1BIWen0w5SiUQ+xOuqtD7QzQx27obwQyTGNkpMLxl1pPbImL2JaANjL5y9Isy4EhNywZPEdGCzEkurhZcOWZDMlIdNxMzW6mUSZkQzz2MF5w+V80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hr1hLDzB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CP4Q001V; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hr1hLDzB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CP4Q001V"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6F46E7A09D8;
	Fri,  1 Aug 2025 12:41:02 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 01 Aug 2025 12:41:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754066462; x=1754152862; bh=9WJm+cdEor
	lvwF3Tn1wk58sNz9xskpWU4cprMJiCEs0=; b=hr1hLDzBdIC34UUn65cyeiuu4D
	eRJuN8PiV3ecx/bfb1nX9PMBMHWzWYsswByyptBRlIDWwnPnQh/NoSgH1hZON/Gk
	MJ3DvYmYI30tbB7Nx7454/HFlgLMmofgf2biay30QV8KQ4HKjuH5t8Q/QAJiKof+
	ddIsNtjMpQNYJvbJUQ5twJNmu7smbqtdH4QrF2i503pX+trGgpVDUocdcA6S1MCB
	CeikBbeimAq5bfZkuJ6LCKdGeoMmNciqpIgS7kyqfi/WtcWmMgUAjBhZ4NdnFAFV
	fBajONit7NWyrYJBU0SO/AQ8mr83qyIfcuwYJZxhxJnIFaM1PfdNDVV5Gq2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754066462; x=1754152862; bh=9WJm+cdEorlvwF3Tn1wk58sNz9xskpWU4cp
	rMJiCEs0=; b=CP4Q001VtXSEdnFYn5f9yPxm7D/s4ANQ/SYXGJ1A0RrXBDSaxde
	Ynvfu9LBBFI3/VMmgXkhH8WXBzckPrJcCAkpTUC2kW6PZKwy3mLOnk020yicFRYH
	0JzoGrFPro/VUctZitfTkUx1IxdE+rETAtfykeFgaAygRysqIudUL2VpCZFKNDVF
	asWhXyHrt4rLaa0OdXojHXbTbYnqrlrYUZ2eC9OP3MA0MnIm2N+6ynEEfpD7xv+8
	DYO8RfPCN4VzLzXzIWh6WY8c+sjYlTUXZwI8jjf5WMKkLlReW4u6FcCCJfxfLD25
	rh+s4UYMsEzUU3p3pxfn88zVyl2wAc/3bXA==
X-ME-Sender: <xms:Hu6MaDNSke1zJqEcAC41paWt8nwuGGXEyPiOF7Y_1GjmfIyUSe6c3Q>
    <xme:Hu6MaLitAaOhJDllcGy0i_kLtwcwiD55j98MC2ApjOnYxwXhCKmNbJfbaEobg0FKB
    TDgxjz3KZUNDxddrw>
X-ME-Received: <xmr:Hu6MaIu1GS6YdXmpAfYS10CASGSVXjEinQiSFy5SQ_ggn0o_rvqW81F8JLYuEaK0cvLROhNC2oOheHSV1JIGgUbpCBjlXbKdKatsqeY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdegvddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtoheprgihuhdrtghhrghnuggvkhgrrhesghhmrghilhdrtghomhdprhgtphhtthhope
    hoshifrghlugdrsghuugguvghnhhgrghgvnhesghhmgidruggvpdhrtghpthhtohepmhgv
    sehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghugh
    hssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhm
X-ME-Proxy: <xmx:Hu6MaJQC5ufKvzSEwS0NoWs7UYxnIulaFYBKtnnyxqx8fYrLRcgCJw>
    <xmx:Hu6MaM1w_W2-BQoXRueLiTeRzXWxM6RXi7eUvFBDFJ-9vIz2vrwCFw>
    <xmx:Hu6MaOuQF78iITaSBkZ-zifwN4ds3LsL7hDxCT7OIC1ibYnh59YTlQ>
    <xmx:Hu6MaCjRSHrZ17Yo9ZXyQqA625qdNZaQWq_GcxVcHLUX_5jV9K-17A>
    <xmx:Hu6MaGTZKXXDroeKRDhHjc5aDccb3soMmKMZdfSW05z_ovmnKfeQqPmk>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Aug 2025 12:41:01 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  Ayush Chandekar <ayu.chandekar@gmail.com>,  Oswald
 Buddenhagen <oswald.buddenhagen@gmx.de>,  Taylor Blau <me@ttaylorr.com>,
  Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v2 0/3] breaking-changes: deprecate support for
 core.commentChar=auto
In-Reply-To: <a9ddf6cd-28c5-4030-9e63-80df191f1397@gmail.com> (Phillip Wood's
	message of "Fri, 1 Aug 2025 11:36:57 +0100")
References: <cover.1751983009.git.phillip.wood@dunelm.org.uk>
	<cover.1753975294.git.phillip.wood@dunelm.org.uk>
	<xmqq7bznog2o.fsf@gitster.g>
	<a9ddf6cd-28c5-4030-9e63-80df191f1397@gmail.com>
Date: Fri, 01 Aug 2025 09:41:00 -0700
Message-ID: <xmqqv7n7m1ur.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

>> I guess I used to carry an equivalent as a recurrent merge-fix for
>> your topic branch, but rolling it into the base of the series is
>> certainly safer (i.e. we have to do a merge and resolve conflicts
>> just once, and after that we won't even touch it---as opposed to
>> keep recreating the same conflict and resolving every time we merge
>> your topic via rerere & merge-fix mechanism).
>
> I was hoping that rebasing on master would eliminate the need for a
> fix as 'ac/auto-comment-char-fix' is now in master but in the meantime
> 'ps/config-wo-the-repository' came along and moved code from config.c
> to environment.c without those changes. I'd assumed you already had a
> similar fixup when merging 'ps/config-wo-the-repository' into seen.

Exactly.  That is what I just said, in case it was unclear.
