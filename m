Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70832F5484
	for <git@vger.kernel.org>; Wed, 29 Oct 2025 17:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761757437; cv=none; b=PC5cBje71FrPvu2e5nMW/CbawW5oj/OFA7HihRJRia2ppD6r8oXIyrj7xTfhku+HmV08PC6aqKeL9B7oDpOkkj0nr7i7CN9m5kQ4C34gSZFPuWga3ZsVKxX4e+fHra5hPnMsQhtvcCw8aLI27ZXdFAQHDDE1ZdytKeEhDfXS1oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761757437; c=relaxed/simple;
	bh=Hx3ODPutYZMF62DtiMvQ7Ku6oO/hNBQRZSsYpEkh0w0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QzyUJZnzA1/t+v8eCjrnInF3nHqmV+3viMfu/JO+Yd2c3iaTbi1qXuZ4y8x1CRP2lpjD5YQtlijIR1nuMswgBbtvSaDusGnB6suH4pNCsoVASsFX6rftSKedRwo8KNbhfCSKc72jT/ppKPVIR+e/ZPCv6xK5K5L1scFRbtsxM30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GxHq8Rs6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Bgqwgp25; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GxHq8Rs6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Bgqwgp25"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C73B11400179;
	Wed, 29 Oct 2025 13:03:54 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 29 Oct 2025 13:03:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1761757434; x=1761843834; bh=vQaXGgibMD
	pjwl14XVIwhaXtiWDCRA9pirF0miLGjvw=; b=GxHq8Rs6LqwxiTy4ToqscJFj20
	lBZxRpZWqdqPLAZdH+iKuDdHF2XpliIW+5/k/POpBwJImq0QwRhycqK5Hw0EGx98
	RgqvfL8SBKITLx2UedzHPz8CCIYfRLJ/T1qXLZHfeyWeyarbFdet7Ct2kbb48s4s
	4ZBPA1oHKVjliLTK3ySaUFmesCMqZg9aGfEQ4Cwf3EtaMxQkUlakXY/9rEsOCTp4
	LK6/Vbpuz+Uyfawwb3VX65sgkQumXiiLFdS2ACrJ/FDUCU11hgEI9qVa9KrSi0Dz
	2DNxqY0f0E8HR3ocV6rr3wfLN94djNvtZB1F4OBzw6v3r0Y0VIBefr0sN1KQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761757434; x=1761843834; bh=vQaXGgibMDpjwl14XVIwhaXtiWDCRA9pirF
	0miLGjvw=; b=Bgqwgp255GkoFprxJhbcZgJoH/RkDD007jnZjrjHhY2YcvsiAax
	tLELjW0YrWw4XzgfQVP69pCulKR9alcyyrRpBLZTOcNgD7Vss/K/IiWn4rk59zmU
	4pmiKYvb+dVCbp8hE1ibcvHO+skRg8IT3OgDCEyz4EDfDloDU/MktV8G28F2onBk
	2hkEiMI9+dAwmg2qwFUeEVfwvVA27e5iMlAXZwHv1zWfJDSl9P6GpjYJBP+knuSk
	bCTfmNmTu23J37tiSKPABudIo0ehWEmewtkMstaut3JmDcZ/j+niLIz3a4NtZG8x
	09AxpOiGkb/KSCE1ZqDYC3tbWH0umrG09Gw==
X-ME-Sender: <xms:-kgCaW8I09dhVauGPiEOMJli9OIANAWi-6KGsxIK-9lAM91wjluktw>
    <xme:-kgCadk376HbJIPXrka1rktohrkpoPseCr32K6b4dCZKT8wTz7Ke6IfVRrTLRF9vl
    HH4P7PxVKbvGVMbXSA3-mLC0rg9mgbq7ApW-rp31107xIpSi7r80g>
X-ME-Received: <xmr:-kgCaUVQJixG5VymPmWWT82HJPfrOzaXzehxlxMhpmffVSWsENMdJU0tYTgkTlCYxec8uD1YReVy_7C6laSbVznwyi7CHCPdmTIY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieegvdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprg
    hsthgvrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepvgiivghkihgvlhhnvgifrh
    gvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:-kgCaaFVq5PD1nzdfEsLP2f-EF4RMTkTUTRiN2gFBX6eCiKhS4GWdg>
    <xmx:-kgCaYfYY5K4sUpgB9nMB_PeCzXLQr99aSvevcQeyxr1K7XBZzb4CA>
    <xmx:-kgCaTLVfLsp5s0Qcco9bCYuuh2VqYx22j1O5k2mNnssfYDYFF0tAA>
    <xmx:-kgCaVH6Ajg8bFuJilNydgV9O2gp9zeQTvLatrij2eyNRNmXvSr0wQ>
    <xmx:-kgCaW1RskRNBsZTVdkyVCSJJX6-yADURiX6jLjJbwNdtAP7uVHPq9l9>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Oct 2025 13:03:54 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>,  Patrick Steinhardt <ps@pks.im>,  Ezekiel Newren
 <ezekielnewren@gmail.com>
Subject: Re: [PATCH 12/14] rust: add a new binary loose object map format
In-Reply-To: <20251027004404.2152927-13-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Mon, 27 Oct 2025 00:44:02 +0000")
References: <20251027004404.2152927-1-sandals@crustytoothpaste.net>
	<20251027004404.2152927-13-sandals@crustytoothpaste.net>
Date: Wed, 29 Oct 2025 10:03:52 -0700
Message-ID: <xmqqfrb1abd3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> Our current loose object format has a few problems.  First, it is not
> efficient: the list of object IDs is not sorted and even if it were,
> there would not be an efficient way to look up objects in both
> algorithms.

I was confused by reading the above, mostly because "our current
loose object format" meant to me the "<type> SP <length-in-decimal>
NUL <payload>" deflated with zlib, which has no list of object IDs.

As Patrick commented you are talking about something else?  Mapping
mechanism for object names between primary and compat hash algorithms?

> +== Loose object mapping
> +
> +When the `compatObjectFormat` option is used, Git needs to store a mapping
> +between the repository's main algorithm and the compatibility algorithm. There
> +are two formats for this: the legacy mapping and the modern mapping.
> +
> +=== Legacy mapping
> +
> +The compatibility mapping is stored in a file called
> +`$GIT_DIR/objects/loose-object-idx`.  The format of this file looks like this:
> +
> +  # loose-object-idx
> +  (main-name SP compat-name LF)*
> +
> +`main-name` refers to hexadecimal object ID of the object in the main
> +repository format and `compat-name` refers to the same thing, but for the
> +compatibility format.
> +
> +This format is read if it exists but is not written.
> +
> +Note that carriage returns are not permitted in this file, regardless of the
> +host system or configuration.

Unless it is zero cost to keep supporting the reading side, perhaps
we want to drop this mapping file format?

