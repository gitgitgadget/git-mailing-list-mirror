Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F4C291C02
	for <git@vger.kernel.org>; Tue, 24 Jun 2025 13:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750772601; cv=none; b=s8Xhjk1eAyyL7SL+nOrkrVu3O7sjz0EdfuuItfs6Owak/qJntjqsb6wjhUQBodgmdu6r40A3+xK2lIy5c0FrxtkPjMJoHzQ5630uuR+dh/f97F36QXHCwO1d6f7A/rdfUQEbBBI3iAqAkMH29oTFv8rgYutC8kdzR36n+pUi0ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750772601; c=relaxed/simple;
	bh=1WxEx+upU7tZtT9ArKZrmeYmvZ9pj0iarpB3BBPXlU8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PsSWAZwf77SloIrVaiNaVZUNywx3BMXp+RW37o0SIetTc2LvycInJPVuB1ddsvqNemhdiTAQ4mxOBXFXl0chsTVv30V3eTJ/siFCTrjUxx5wG0vf3g8IxyRiT0WpoetMvSJJYhii8WbF0dVRCP/G4tETK8HjdCdp5JcXJ3Z/DiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=zQ0y+3si; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DF2h0Pc3; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="zQ0y+3si";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DF2h0Pc3"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 91AAD1D0009D;
	Tue, 24 Jun 2025 09:43:16 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Tue, 24 Jun 2025 09:43:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1750772596; x=1750858996; bh=20A4eHJIXe
	PnvI2WQ7ic0CzcU72rVb5qrseIHiAyrAc=; b=zQ0y+3sizw/w75iwOMHrDpR9KE
	xVwmPns+XhWI91hx6qfb9PRqeWrkFXcmq19gl/VN6rJ/VQzmHeYfy5QDHO8d7fNy
	ApPdje89kJdNYzw6oae+5rcGRYgZPUn8luaOhcqBR81qng1oZ59sFNMqs3Z6ZLZs
	cwt3fUcix+NiouMnvaWUFs12+GuZAArV6R4nLyUTylxM837qW36nP1btZGx3eD/D
	i81CSieGPuJDOldMTYAgwd9zWXnFNKsRRfahjGkX/F5ELda9uHImIdlrJ+g09Mgb
	/Z1S8LkBYN0avKDMXb7KIC0V9IXsW7wtTXUMuJ1o9q1kbMR1TtglfPW6bcKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1750772596; x=1750858996; bh=20A4eHJIXePnvI2WQ7ic0CzcU72rVb5qrse
	IHiAyrAc=; b=DF2h0Pc3HvomjTHLUGZzfHWReIDEuXOw1pcrOgXOxJX0TEsmPdZ
	eaEACHF6bY0If/Y8/O9DFtIRvo1ZJPPx3306dAUyRKg/H5Ya/WLveQWXROAIwRd3
	yYwDyhx/B5S09YZtAVZTJ0Gg2GsQSSu1XwtdmKxNneXrEXHwEhpP9T21Jr5oY0RC
	GfoWRfTIct2eWzLcXLxxOg1lz4DxuGKE5oEctTJ0PMIhGzti0lx3Uitl1tn88gZZ
	j/s+rHvEqC1+p/PEPEMerSoiLx6KPLruMdkTEMLm8UztQWOW7p1i+IJHqNbQcl6T
	/4FCiZ+1RJESh6q+ayoUp9iE/Vursrf6wWA==
X-ME-Sender: <xms:c6taaLF_c-EVLiZITKnZFJsYmd05EUmBOBPWbSuJ2E0VMNt1hA14Mw>
    <xme:c6taaIWACEBA3CUsdO-gLWPk9Ker2xjZ-foA_7YmfEwDjYa20MdGzf2K58gRMUV99
    yUr_YjC1_oqC7OcEA>
X-ME-Received: <xmr:c6taaNKOEq8zlMBkKBs3gVitZH4LcHo_hn45Tns3z3BUzpwB95WcYTugEloAd7QyoAVlrD3zjpjAcm9kiJf9UgV4Tt7N2txQZTqzNOg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvtddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrd
    gtohhmpdhrtghpthhtoheplhhutggrshhsvghikhhiohhshhhirhhosehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruh
    hkpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehpshesphhkshdrihhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilh
    drtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:c6taaJHnskHoxoTsMja9LRljtS0Gor7BYqAqO1WtsdcevotD-7EcxQ>
    <xmx:c6taaBWjKCktUcf96EXf-STgU4H45XxrYYPqAQvzc1TPTU6GSaPDpA>
    <xmx:c6taaEPqFBdSkhE5wyxFN_Xqw8VyvugEPz6qZ2Sw6zVtMCsf9Rd3ww>
    <xmx:c6taaA2CwSALbBnYM1cUDLwGNDXMKH9F4ER-R8yB9oufRyMGwy7IOw>
    <xmx:dKtaaP8ytPICX3sw-DgFpTndWaP6kwSBBeBi7RoTdUT_8bMo-qD4sLIJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Jun 2025 09:43:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>,
  phillip.wood@dunelm.org.uk,  git@vger.kernel.org,  ps@pks.im,
  karthik.188@gmail.com,  ben.knoble@gmail.com
Subject: Re: [GSoC RFC PATCH v2 0/7] repo-info: add new command for
 retrieving repository info
In-Reply-To: <223c7cbd-610e-49e2-90e2-5914cbc0f1d7@gmail.com> (Phillip Wood's
	message of "Tue, 24 Jun 2025 14:03:57 +0100")
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
	<20250619225751.99699-1-lucasseikioshiro@gmail.com>
	<af27af92-73d5-4f0a-84f4-9c91de6ab6e6@gmail.com>
	<652FDA35-C20D-4F27-A22A-025CA08EB013@gmail.com>
	<223c7cbd-610e-49e2-90e2-5914cbc0f1d7@gmail.com>
Date: Tue, 24 Jun 2025 06:43:14 -0700
Message-ID: <xmqqjz512r2l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> The reason git uses NUL termination for other commands is to prevent
> breaking the output when values contain newlines. The output format
> I'm suggesting is
>
>     <key><LF><value><NUL>
>
> so the output for "path.git-dir" written as a C string would be
>
>     "path.git-dir\n/home/phil/src/git/.git\0"
>
> The value can safely contain newlines because it is terminated by
> '\0'. The reason that "git config --list -z" exists is to provide an
> unambiguous output format as config values can contain newlines.

For Lukas's purpose, I presume we are in full control of keys, and
can assume that keys do not have any LF in them, so it is safe to
treat everything after the first LF up to the NUL as its value.  

Similarly, even though "config" allows essentially any byte value in
its second level component name in three component variable names,
we do not allow LF or NUL in it, so we are safe there too.

Thanks.




