Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF92270540
	for <git@vger.kernel.org>; Mon, 28 Jul 2025 16:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753719689; cv=none; b=b0W8ltz/QUIRSL+VKX+CQXc6cre5G8RgaehmtWKQM04esmMa3Q0gi4bQeHSrbtNSVMVLgn69Xpbu+6coDCwUMk1RXHJ03X0WCYR3FzdCpLFUpVrsS+86DpriYhkKpD/NIJmvVVC8rSf7snTt6OrrgLjMUf8/3Be8t0dsIlpyvE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753719689; c=relaxed/simple;
	bh=CRJoNqJtvWyOAGZSbkHvr/6BkgUAELh+oBq87KnoZPI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uue82U24hSbyTgHrOs272zpdE8Sx8XznuHsUeS0aQcaSwk8i9WYAN6YDNxMuA7ZabM5xrJEHTAr96sC7ltyYgsclXcMGzwIo4WF1TUhf6fODcXPq+mFudwMCgCJF+TGqamYEKdfqJ3j6Lt604GE8qv8qP9EKUHB0oTNLk/2vb0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LW1+0pN8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z18CNCK+; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LW1+0pN8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z18CNCK+"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 6BE51EC007A;
	Mon, 28 Jul 2025 12:21:25 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Mon, 28 Jul 2025 12:21:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1753719685; x=1753806085; bh=WAOoo8djLV
	ggcNNePmyF0drJkivqhvOfusnjWbfjrxw=; b=LW1+0pN87sbzZUyc04R8LiFKg7
	Zttu6Ym0w3V5bGuhXU/+eqisE25+2fMHbiz8xvwUPsFBc3FRL69GmDyZvVofz1sw
	AkkexS+cF/8riUaCl9l1pKExTwNd1j9x1LDXtpL9grLp7J0RN5q7kcHBQRGVb82z
	CuTjvNZBD4R0//5b+aJRhHQyIChNPDZ+JVTEkyugfU3ZpmD+IW2B//O/LGBcCRSG
	D1pVxzYWymBJwi5N8N+2hodzEV5n6mcCRLaTZePEQaGXJAzce2S98mtax1an0Y0t
	FMLXprYyjV6M05xfYHqcMMTrXlNJ9Lg8goq7c1Mh+g6a53XUu8AcmWY9yjYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1753719685; x=1753806085; bh=WAOoo8djLVggcNNePmyF0drJkivqhvOfusn
	jWbfjrxw=; b=Z18CNCK+1JiITpefb+I4jP4NVrmgbB8uZN2DIbg9WkqzzF7eaYS
	3kVsNDG/6bNpyhswk7btfmFoBAPUNZ0O08y7dlzeGVPpY82jS8A8J4akFrb1L3m7
	PB5xytng5JWkIQmgy2NQaeRsUXC/q44LqPoLhfpTz57bUPbt4jUbQalT2eesTLT8
	xjUHhLLNIw1D4XrQ++LeK10j8tQDtjM+pdK1IVF+5ymKPuuV8vYtmgiChIJCHz+M
	mf6zgxRD61YGC30P4xPzfwxzNj7Xoxy0qzd/Z7biByGuujQ7UlW2JwYKYluKk90u
	QWlVWtZVI6aBkCBj6sEFImpgeSZNNfSFgjQ==
X-ME-Sender: <xms:haOHaMBAv2STfjhlp-Pp-_PLNOzstEpVXujagTxzW9YShR828Dwa3g>
    <xme:haOHaKCkrY2VvotBsxHqB5HiLn29AlZFVYfzrD8En2qJ4aB9vdokPhu5EIzs5Cj-X
    M4KqnYs49mb4sNOMA>
X-ME-Received: <xmr:haOHaGAC-F3x8J3ER3zqnw763AF6-n_S_M5GJsEd9fbZSpgFrPwxS2jrSi3FSqUdYcBP8DP8zRGrr9DTpHF4vwJ9-sGmK4wCxpmIUXo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelvdeigecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvght
    pdhrtghpthhtohepjhhhtggrrhhltdekudegsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:haOHaNr_UHqZceaDg5XmYMTSZcv-TqyR9V_1eh26Cfntqr8Vqqfywg>
    <xmx:haOHaIklT8c7CskeHwM6TNTBPPg2p15kmn9Kl5AvS0qVth58OWbjCA>
    <xmx:haOHaFxZ8bZzP9gSNHt_PCMi5zLZnT4pNSDY4CLzfp8eNQQv4dbnpQ>
    <xmx:haOHaI_1TNtfSprETRZXtUeexjn3xfja112jKPCeQyH8DHpQyCc_SA>
    <xmx:haOHaIdOr9-fF4uuVazwMpGnDAEwcOF3n59i3c2kp2JoAkT-q0NkaLyv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Jul 2025 12:21:24 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Han Jiang
 <jhcarl0814@gmail.com>
Subject: Re: [PATCH 2/4] refs: simplify logic when migrating reflog entries
In-Reply-To: <20250728-pks-remote-rename-improvements-v1-2-f654f2b5c5ae@pks.im>
	(Patrick Steinhardt's message of "Mon, 28 Jul 2025 15:08:46 +0200")
References: <20250728-pks-remote-rename-improvements-v1-0-f654f2b5c5ae@pks.im>
	<20250728-pks-remote-rename-improvements-v1-2-f654f2b5c5ae@pks.im>
Date: Mon, 28 Jul 2025 09:21:23 -0700
Message-ID: <xmqqqzy0wakc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Move the index into `struct migration_data` and drop the now-unused
> `struct reflog_migration_data` to simplify the code a bit.

Nice.

> @@ -3015,17 +3008,8 @@ static int migrate_one_reflog_entry(const char *refname,
>  static int migrate_one_reflog(const char *refname, void *cb_data)
>  {
>  	struct migration_data *migration_data = cb_data;
> -	struct reflog_migration_data data = {
> -		.old_refs = migration_data->old_refs,
> -		.transaction = migration_data->transaction,
> -		.errbuf = migration_data->errbuf,
> -		.sb = &migration_data->sb,
> -		.name = &migration_data->name,
> -		.mail = &migration_data->mail,
> -	};

We no longer make this copy, which makes sense.

>  	return refs_for_each_reflog_ent(migration_data->old_refs, refname,
> -					migrate_one_reflog_entry, &data);
> +					migrate_one_reflog_entry, migration_data);
>  }
