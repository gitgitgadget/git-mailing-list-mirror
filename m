Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB0E1D5ABF
	for <git@vger.kernel.org>; Mon, 25 Aug 2025 17:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756142764; cv=none; b=KEOnF17dW3QXWwRbn0Ydh3/DwT0ygLc15wVNR4CCgLKcka+Lwzx+3UUYjiYaUHVsIdsJC5ooM2gxrAy/sg0TMBZ9Qiog+/F6TZfzWXWJjkbrjIVPqkW/2wE5dPDrJS0ijMKsGM6cBCsHxtWirrA+lW0LEapJg1i4NoZXDEk4sDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756142764; c=relaxed/simple;
	bh=NqOVZfaJloIkCF4od6Rsgw6d+3Y4N5UZkk/qyx//CWo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EFxB7zuRgb1zkUQHVj65/UR8RTyIuiC8Y8xLc8ysBIa3ugVKB/3wkFjQo3wDLC1idvw8TegYjzhUKo0KVq5oY6e/3xsjmi422W6/F/6TxJSaWNBWBFgsi8CTUkFQRlJ1miYkPbJmC9PIpqmq4TG3DdhX6w3EhYCtrtUx6KvNuEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JFEHrJ3/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gxkrqOXG; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JFEHrJ3/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gxkrqOXG"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 2B39D1D0015C;
	Mon, 25 Aug 2025 13:26:00 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Mon, 25 Aug 2025 13:26:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1756142760; x=1756229160; bh=8gCtRIyZOd
	IYbqYqZUEQIvfqrChRVpZc6keB9hwipAU=; b=JFEHrJ3/hVII6fhj67Fooho68t
	mQKe5ckTXmOE9tejO0FVOxlhTLIXURq+wH71rxY99beK7UpsCCAVa9UfvL8znWHk
	E1fU6W+kPRs5RjsjcFwE8d926OIRasPMC0coQRdZaCO6cDNgw0DrH9nua0AaVqFE
	cO2ErTZNmmbJh2yr9P+p3gDX34V1pqPsRlL5sPAkzm8Mg1jL0pa6AfQNY/hmDoNK
	0p+TuSVRbLbW+ZrRYk6ZuE/X4gJDvOkimJk7EmWai29s1xNUiDi9HQsKbKITHnsL
	dl5wWVqn4FPjIr0Po8dNTtYbXdBioLHIvvF/gmap6IX0ZRmgSU3HFLKcmQeg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1756142760; x=1756229160; bh=8gCtRIyZOdIYbqYqZUEQIvfqrChRVpZc6ke
	B9hwipAU=; b=gxkrqOXGGK3+sYdcfjc3yt91k8k6iebehCNvuCM7HCCN1b6BjHo
	CylSRM7ZJbnJyQUwlI4jOiU5tOz58Ugyia+8VRsp39fTFJRwYJFVNUP1D1ZsNOtH
	g2rli32mwFdPeAt53XMmbK9yPdfOR5nCHnm3Q5gDRsYsAEijuvyGq0cDkoaWsUpD
	6QiKCQ4UK2riTuGTO0ISFhuqlbX6SOzFUUPV66R7r/qYS3rDEZ9XNo4hfLXBHkit
	TnlSmflAzUpJSaPquuJU9De5zSHUihZd/Ae9+hRE5RVwJ4rf6TJS8fHFEZDmHB26
	TzEqAGuZJ4LmEHvjFhXcHzL7KhTEzHPfYtg==
X-ME-Sender: <xms:p5ysaGHF7rGUJkJhhzbF4CfHPdm134xQkf2l6EM-8n3yt8u8nqf5Eg>
    <xme:p5ysaKk46Y82_L2jq6lTguZ4MBczADJO8WIqg2YTBmRRJFGhW-8UoXuB0OPpupX5f
    4Lc2Rlei9obBK5lDQ>
X-ME-Received: <xmr:p5ysaJl5y4FsjtS4g7Q7v7Cc0sjRGfY-yYeTdJ7FlbKTSMWQXdOtGXtMGF8xKaNr5mtFcZ9kgICJzq32_EE1pf11AOEg2i5OOdVqbZY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujedvleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsrghnuggr
    lhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:p5ysaLu3T0QXHjqHsFaVi1Bw7tQESjGeTH4zCvXLEaelh7-S1vI2wQ>
    <xmx:p5ysaMm9-EnbCODCHKmlC4Adv2J84tOTGVlv_-MXyJTmka1cRbvfpA>
    <xmx:p5ysaGtuiqqx7ZCzKN2pFk-aekp4gJha13pC64JG0g4XVnTvDtCVYw>
    <xmx:p5ysaCfm9_PFSvpA4ec_mGt0sHmsRTX8XnGhlF_exa2gv64Fp0au_A>
    <xmx:p5ysaNYw1x_piNXaFcwDgJHhR6JgncCQbnMdMdN5il0DA7Eq5asuzXYB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Aug 2025 13:25:59 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>
Subject: Re: [PATCH] docs: note that extensions.compatobjectformat is
 experimental
In-Reply-To: <20250823220601.336079-1-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Sat, 23 Aug 2025 22:06:01 +0000")
References: <20250823220601.336079-1-sandals@crustytoothpaste.net>
Date: Mon, 25 Aug 2025 10:25:57 -0700
Message-ID: <xmqqo6s3qpne.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> The compatibility object format is only implemented for loose objects,
> not packed objects, so anyone attempting to push or fetch data into a
> repository with this option will likely not see it work as expected.  In
> addition, the underlying storage of loose object mapping is likely to
> change because the current format is inefficient and does not handle
> important mapping information such as that of submodules.

It is "experimental" in the sense that a developer who is interested
in making the feature work end-to-end for the first time can use the
code behind the flag to prepare loose objects to prepare what is to
be transferred; it sounds more like this one is "not working yet" ...

> diff --git a/Documentation/config/extensions.adoc b/Documentation/config/extensions.adoc
> index 9e2f321a6d..292e95ddae 100644
> --- a/Documentation/config/extensions.adoc
> +++ b/Documentation/config/extensions.adoc
> @@ -14,6 +14,9 @@ compatObjectFormat::
>  	compatObjectFormat.  As well as being able to use oids encoded in
>  	compatObjectFormat in addition to oids encoded with objectFormat to
>  	locally specify objects.
> ++
> +Note that the functionality enabled by this option is experimental, incomplete,
> +and subject to change.

... as the only end-user-perceivable purpose the compat format
serves is to exchange data between two repositories that use
different hash functions, no?

The word "experimental" to me implies that it at least lets you
complete a minimum end-user journey of the feature end-to-end.

There are different degree of experimental in this project and we
may want to do something about it, but in any case this is a welcome
change in the right direction to steer those with mere curiosity
away from hurting themselves.

    Note that the functionality hidden behind this extension is
    incomplete and the extension exists solely to allow us to
    continue developping it further.

might give them a stronger discouragement?

>  noop::
>  	This extension does not change git's behavior at all. It is useful only
