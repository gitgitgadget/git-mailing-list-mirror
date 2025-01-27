Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E92748D
	for <git@vger.kernel.org>; Mon, 27 Jan 2025 21:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738012732; cv=none; b=DDDkXwRs+WLBWeaJ9Obsqrho/905hVL3XYsEP/ol1jbPuP7RE3YO+mUy8btRp9YG/akQfy4E5dtPuKnJ3FGKVDe04BurZwWDcq4fcpEWSKwkGbNVvxkltsShCu1f8oHHktdeOOTndV7HoOrZgLQvO3PG6WpnksN+PnIIBAr40EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738012732; c=relaxed/simple;
	bh=RyqvBkikpYOR7VUpZ1KfluipCNC7bwBzS4rR+QR9eg0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Al8yk26rP62B2pEgK9w0LSgrok5NPCtdDfe9aSb67ynY6vdhg2SR4s7M4+anPK5teFN3eTQTtvhAM0UjIUZSROwkUB1ATLKZ66jl1bzTidOdrOco0TnAFwSETA12V8j44lsYU/Fczipb70ySAupndytF/pFeVUMnWe2du3ahhm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UMp/ezCc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MOVa5E+x; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UMp/ezCc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MOVa5E+x"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C486A2540184;
	Mon, 27 Jan 2025 16:18:48 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Mon, 27 Jan 2025 16:18:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738012728; x=1738099128; bh=jd7px20gpp
	ehLwtA9UcaPmx8XfdW759k2s8QsxmFE0k=; b=UMp/ezCcqFgE9liGy3coDht5wi
	pBgY9NBGQCyOT7rECU9Kwi4P/9m3DKYewQqwJWVT3Dj0av/hxsTqTqoaNOg4Bt/v
	iH5EoMb4yWkdV6p8qbtb7zR6Zvr0IAbP2VSKg1yY11XrK5+Zfka4rysSq+pAqkFZ
	rxCAiNP9gSBW0G4tXm+N5Ls8zWf33l8hLBwA+pIp1FqihzmzlrpnKcjgCibIHKDy
	xVYjAhcbdbReibc0HE8x+yuu9mLkc0ZGtklwJ9x6qan6DK2nPtHOuQeMGfRePGyv
	L/r+RkgbpVNfuPfQ56TlgWVimnbvFrwiJtgzyiBWmqCJC4YGmvjK3QnBKlJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738012728; x=1738099128; bh=jd7px20gppehLwtA9UcaPmx8XfdW759k2s8
	QsxmFE0k=; b=MOVa5E+x/fuC32/Rk3RTmc/+J4Y+ukr3yMsoGNuyrPIm4YAMcrD
	kkQuYjQq8f0ZfpFaYngb5gkTgN4IZLpiRvZEqlwvG4iogv7AhEsY4OAtwBSNyzjS
	7TmfraTOm+09CKn0wfZJH1myqOnM/edd4B0wZmpWSFcG/qy5RzlslomQPtxSo20R
	FzgP3D+IufYC/UjyY1eu70yKOUhhQa+vEDQNl0fT2TXDjGVSD5ejTgAxDnPImHc6
	6QyY4QKVUtocHvPRegT1FlWmdtNYHGaYkzHHY3LsY+VlGnGuU1OoZn2+u2944jZ7
	mJR1+u+WOd6ObvucR5yV0KoscP18OVGyqFw==
X-ME-Sender: <xms:OPiXZxkJtn7oso0rtb2Kt6_LapHn4sR3D8yADfgcqkteDWq92K0Wcg>
    <xme:OPiXZ81xsNie_cvvQugh9ljU4goQ7390IUu6OnEuHtXZ39zTccxZSPCsBwgFmc2t_
    J3rtGprdQEBbK9yNA>
X-ME-Received: <xmr:OPiXZ3r6um920B-M22PZkUrx5nNlPuSaLGSeBDtZvpDQijzoG8_m92LgnTnhXoG95vJImqm3TY1hW51oNIANbDZIue0I-iZiPYj9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgudegvdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepuddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhith
    hgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinh
    esghhmgidruggvpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthho
    pehpshesphhkshdrihhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprh
    gtphhtthhopehjohhhnhgtrghikeeisehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgv
    fihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhonhgrthhhrghnthgrnhhmhi
    esghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:OPiXZxmuAYnZkW-ijZhPbI4g1n4AEc7bMaQ45Z6y29AN3u0AQ4ZOKQ>
    <xmx:OPiXZ_1acUGGKQLt-02X_7LdeIYOcks-RMci6HJNvdbSATNXdf2zpg>
    <xmx:OPiXZwuoJX2TMBHJNmyVV26olKERrLkVon2XsNyahzdwCz8bjCzwBQ>
    <xmx:OPiXZzUAxAR9uiZxblW4HlExWhq7AIhaLsg039SuVRNkiPvS-XZu0g>
    <xmx:OPiXZ9N3dFxZ-zRqAHfediEu8LXDr8a3YBgT5HZmHxvabjP9cnjuSXuI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Jan 2025 16:18:47 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  johannes.schindelin@gmx.de,
  peff@peff.net,  ps@pks.im,  me@ttaylorr.com,
  johncai86@gmail.com,  newren@gmail.com,
  jonathantanmy@google.com,
  karthik nayak <karthik.188@gmail.com>,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v4 2/7] pack-objects: add --name-hash-version option
In-Reply-To: <7ee1845144fda5b8192dfa13eaab3cbd669b39ed.1738004555.git.gitgitgadget@gmail.com>
	(Derrick Stolee via GitGitGadget's message of "Mon, 27 Jan 2025
	19:02:29 +0000")
References: <pull.1823.v3.git.1734715194.gitgitgadget@gmail.com>
	<pull.1823.v4.git.1738004554.gitgitgadget@gmail.com>
	<7ee1845144fda5b8192dfa13eaab3cbd669b39ed.1738004555.git.gitgitgadget@gmail.com>
Date: Mon, 27 Jan 2025 13:18:46 -0800
Message-ID: <xmqqy0ywoszt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +/**
> + * Check whether the name_hash_version chosen by user input is apporpriate,

appropriate.  Will tweak while queueing, so no need to resend only
to change this.

> + * and also validate whether it is appropriate with other features.
> + */

Thanks.
