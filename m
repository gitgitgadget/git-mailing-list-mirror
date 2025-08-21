Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA55C2882BB
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 00:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755734417; cv=none; b=Y2PDw71ssUg1+WIvqcLKtDt5nM2VndQL75dGhkO0Jhsts8G6pn0gV4lp83W4cTS9R3MA6VpVBi4yCQbKCIUPtA1y1HS32YAc0km0q4HiVAN9AhIRDzhCMtuF1n6nq1K4T55GZ5MBOm7H8+mW/8eCH4gMkx5Bey5Vciqe0IbrOZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755734417; c=relaxed/simple;
	bh=NCUfRaRPLzyH37HsGK1Q5lCVNKRFi1rVYXnZa4w561A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ca6fnMXixe2dfOMRFVkUF2iGTQp14uBcOYNapFKuvNfIszrR6b+YfdVIwJZMut/tJLCGN/tQa81pJI0FpSiMeGaSebIING6jrZupRZhMYdSXBWpkrx5CKRz3oaC6Wvh8ODcM9BoIqasaIGm5Fwe+RAvZBJzM9VnzHq7i0aH6MKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UoK0+sGH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ijmeZVo5; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UoK0+sGH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ijmeZVo5"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id D43B91D001AB;
	Wed, 20 Aug 2025 20:00:13 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Wed, 20 Aug 2025 20:00:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755734413; x=1755820813; bh=tUaI4vBGpU
	Ehbe2nGIT2bXtc0QI0mA/41zPsvEdPQT0=; b=UoK0+sGH+pICf6pWHb2H6nb4Sj
	4/TW6ziA+Q2s1ZSWo/Pi5hWfidz2fAszhKWXZo5sHLTtjRBhn8unq9AHE2F7vYKA
	QhyewqB7NOko4qBdAyg40tJslHXfZyVBTGQbrUDMNyStPrdhOlXCwh2qQ4ISvgV8
	oznyJyEE9DaoKGnoJ2XiMWtf700q90E/EULw6s92nQI4EkijCZsM/RyaN58u+G8g
	C2rxe4cgD/yc6PZDChW3XEWpS0wLyyb8iU6XYkZUsUG2XGnO8TVjcs2ds+dLWRYP
	USlj0tMBMVPoKrBP262pf1Wpao1ieukLBl1XAm2E1KTtZZlwot6RYeuPbu4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755734413; x=1755820813; bh=tUaI4vBGpUEhbe2nGIT2bXtc0QI0mA/41zP
	svEdPQT0=; b=ijmeZVo5o6YMxvhayfNtgT1MXHHXq18SB9/sYooVZtlUxDr6hdH
	dUzktmoNtWLj/rDnYa2BbgHqwUBiAr4hvv7D7GfXLA8rqINbjnkz6/k6LmYFozwF
	nUDSXxW0t+RPFPM8rc7haFnIDw4/UQoJcp8dWvbPqdOV9q8DTZ2+ynKpL2SRyYvo
	r57KTEhX/xWbrWK6FVPMmg0aFQBpXhNeqz3uH5HexgePbcWqAhaRiv2GnBGiwDnD
	QUdAS/X6M9hqaqikz2tBlfpLcLBYddC3IgkG3yQdPYhxC4TDuHIdSqN35P2ydIEo
	H7xY9CoVKAh0VKPabmDhIt/Vo78qrIyjK7g==
X-ME-Sender: <xms:jGGmaLBO6KKvogBnz2gDd0IwKNVR9PGsIH_djcShaebsE7-il5fx4w>
    <xme:jGGmaMGuxatPKEdWvnJitSApe5igT71Yf7zOkqPaLHnbUwnlOeVAYGSSd66z2Ka9l
    AAZJg9kKA8rD_MTnw>
X-ME-Received: <xmr:jGGmaDLcOA8B3wvD1fxJvcqQnwi4lZTgWr6kx83fmua_wimIAByPtieF6OPqIVEx-5sKT8vwb2TU-bH6QBz9GyziBvL9sKVo7S-C4QU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheeljeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshes
    phhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:jGGmaAnjY5hK4vqx2-D3FyUAK5r7CHyTNQueSNKXwbJ-B4wghJc1wg>
    <xmx:jGGmaLQOZAnWDV8J3TKZiZGOG8wksS9KPWzul42DzqGCXp-5oMbvrA>
    <xmx:jGGmaCIOqxKUINJdBA7ReW8PAvJWry8py8uWXxvZlWjIlvr7CQL2LA>
    <xmx:jGGmaBB3DECn3sqYDG9O85JasixcEoqZpujP7fqndRjUDrgbyaGFjA>
    <xmx:jWGmaHx8MM_HLSE6SubkHp-pl49OmnavirBJA_gi95PLqbHHRtxd3VsH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Aug 2025 20:00:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH 0/3] bulk-checkin: remove global transaction state
In-Reply-To: <20250820225531.1212935-1-jltobler@gmail.com> (Justin Tobler's
	message of "Wed, 20 Aug 2025 17:55:28 -0500")
References: <20250820225531.1212935-1-jltobler@gmail.com>
Date: Wed, 20 Aug 2025 17:00:11 -0700
Message-ID: <xmqqcy8p7ddg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> The bulk-checkin subsystem provides an interface to write objects to the
> object database in a bulk transaction. The state of an ongoing
> transaction is stored across several global variables. This series aims
> to remove this global transaction state in favor of storing state in in
> `struct object_database`. This is done in preparation for a follow-up
> change where the goal is to eventually move these transaction interfaces
> into "odb.h".

Wonderful.  I admit these global variables are left-over dropping of
my making.  Thanks for cleaning after me ;-)

