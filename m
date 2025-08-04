Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F355A2E36ED
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 04:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754282366; cv=none; b=Nv+ff5s9yLf4c9AsiMuXqCTOAM8db9jVVjAGaQwhfYNjUvxIRAmDX6F8sP2aOhZ/kaCZYmCTzGFT5m+DMK429cWNUt2uFa8B+s40JeMAr5dXxcVfojkuDgT0X+K1Wv6jRIBHNWwgROpj9C/dngDUTls4zbAaL5hUrahsvDEsLHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754282366; c=relaxed/simple;
	bh=7cemExXvEgCnNs3aKKFtcj8G3tXv+CC6JqGCcdx7pt8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=d6DE+dYtcSgKc/4dWPuzbGRcORqzaevN+lPPYzi3kuUgfwMJu1jqUxtli2UgPzw+HEBUFSQX3WGWvhktzZBHsUxE/yJ/8IBvqXJH8fhcJ7OCdreCv6E4G/2Nc339LIQR+JZeyKkgammvqEyH+jeNV4Mel8uyF15726gqpEitrM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MrGDWCVG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NFPRRHCW; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MrGDWCVG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NFPRRHCW"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id D248A1D000B3;
	Mon,  4 Aug 2025 00:39:23 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 04 Aug 2025 00:39:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754282363; x=1754368763; bh=ILTQ+Cqmog
	DgBTkb4g6dFpGFN8os5SbWn7/1PdK/Mcc=; b=MrGDWCVG4QFQv4fNZ18XZW519Y
	W2O82S+CKcoUN29bI2gwqxmHzYOdlsHma8bTTOwfmSAblUgGGtvVoP1o7iFSUZEz
	t6vVJ2rDvmOOTHQ0O+r2Ftbq0czmU1DPpggSg5WQtdC8/F7lHwWG8UKQpVkDIz4a
	NPJCjkHiN9cuTEAwsKNe1JnyJOQ2zAAXuZL4FeSKE8iZ+gIBAlCZROlietm2W5u+
	t78iqEaV8MjmI8+e2aTjy7XrfVgU9Cnn/EPoqhmChQMebDdslJZPf5BYm0stpShM
	jCZg9G8Jh8y07FHI0Pk5jz4oydENTj14ZyBOPPTR8KsUYesVq6whrh+KzrHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754282363; x=1754368763; bh=ILTQ+CqmogDgBTkb4g6dFpGFN8os5SbWn7/
	1PdK/Mcc=; b=NFPRRHCWKVCF7ccUVyF7mKTwSyPlVd57cnjEY49B8Od2ku/Hp7l
	TryWZ1G44SK/DRdrv8aRStHY2J4DnqzCMomf6I4AZZ9H0W4fDQvs69YvdC2XzG4u
	beFgGxIA51+WdEP33o7443pf2/iIiUQCi1mVM/SN+xazeYwNB67Oxnmj2Sy4qmx0
	VUCb3mAT/+Uuf1LWfEpuLMZtIBCfLV2BtDt0Oz0tJZrkOwSoOBPkbFlpkOSsHq0c
	82HGtfwkp1BTYMPmwbhfYiig84HXd5t5BJh+TWRvAKfMXHQU9+dCkEl68REzt7pL
	29rBMlk+dVapdi7Gk+/e1Y2QzIoABgXa8cg==
X-ME-Sender: <xms:ezmQaNqbLNaKZvuEaCMnsNz9JI5sMeukXL1B_PLf2OvMradrS1XlGQ>
    <xme:ezmQaIGSv0aKHupCG04q3bAGCEghOFl1SoifWW9jvR47P86tAxLE2ogv-D79XaZmA
    -OMfKUQ298ImXeJ7A>
X-ME-Received: <xmr:ezmQaKq2Cg6hjws5QynazRnepur4MJxn3P3l7q0sYndWydolxmcVYFrVsSz6UDV6W9fkD3X8j-v_IcT3TLezxqeh_IYYDlvDZuEQElE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduuddufeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhes
    phgvfhhfrdhnvghtpdhrtghpthhtohephihlughhohhmvgdvugdvsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehhihesrghrnhgvshdrshhprggtvgdprhgtphhtthhopehmihgthhgrlhesihhstgdroh
    hrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:ezmQaJZR2tHNnAdt1rOOKSNXk9amhQQ8n3B44IWkup36IXurCxjemA>
    <xmx:ezmQaLWfuVjpgfPdLAUynS42a9InMrspo3W2CdqYAKOk4wHrgxEP-Q>
    <xmx:ezmQaK8UasurcAfLHNM98LwOQ2XKJ6gytH7njzX4aehB4qZicUqFOg>
    <xmx:ezmQaM8M4rwsYUi9otRgWrDgT438Pw77VNi1hReOO1riRhKihytA6w>
    <xmx:ezmQaGNBRqkq0Vmh6UYD3aPeIHVPQZce6yw_svkHRgSN42X9tVhN2Apn>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Aug 2025 00:39:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Lidong Yan <yldhome2d2@gmail.com>,  git@vger.kernel.org,
  hi@arnes.space,  michal@isc.org
Subject: Re: [PATCH] diff: ensure consistent diff behavior with -I<regex>
 across output formats
In-Reply-To: <20250802102249.GA3738980@coredump.intra.peff.net> (Jeff King's
	message of "Sat, 2 Aug 2025 06:22:49 -0400")
References: <xmqqikjg47qt.fsf@gitster.g>
	<20250729081820.34626-1-yldhome2d2@gmail.com>
	<xmqqcy9io73j.fsf@gitster.g>
	<20250802102249.GA3738980@coredump.intra.peff.net>
Date: Sun, 03 Aug 2025 21:39:21 -0700
Message-ID: <xmqqtt2nd7k6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> .... It affects all of raw, name-only,
> name-status, and checkdiff. I know Junio said that --raw should not be
> affected, but I'm not sure I agree.

I no longer am sure if I agree.  I do not mind a raw entry that
would show different object name for preimage and postimage for a
path to be omitted when --ignore-whatever is passed and the blobs
compare "equal" under the specified "ignore" criteria.

The behaviour sounds somewhat incoherent, but that is what the user,
who passes both --raw and --ignore-whatever to the command at the
same time, wants.
