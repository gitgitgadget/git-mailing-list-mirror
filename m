Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEA21F3FF8
	for <git@vger.kernel.org>; Wed, 23 Jul 2025 17:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753292923; cv=none; b=JDIf/QEn8bqrRb+CDXTCxFOFwu4mRXTwqVa4trvM/fP2Ks+3xBcIGGSbrAVVBmPO9luGfx+k632wtKjvenvKfNoUjjqhc4uxechwh1pE61ptInI/sRmJA2fkNF5+aMozcSX74387caOO3AvGa8DpOIVYRIzVBXvMx9JaqEd8H8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753292923; c=relaxed/simple;
	bh=bHYPgDR75bGi48DSxBdL/LBEkpLV0tX3bvSwVFafVb4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=T/BAi0z+3G32wPD2lu+B7i5mj/U5hX7m5bsNltgLcL1I53kCBO8gzLYCUQ+MEbUFiLDVE5IT+9o+ajWyqV6ghIseEgHoE8Hg6F0kupA3o8IxVL0Pw+hPh2zkbUQp3Zp399C49vJRMdTvZi0/aXUyz5ZwxLQR78g6LwY2llHHy2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=X4JrKiiC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hS48sFjQ; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="X4JrKiiC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hS48sFjQ"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 0C8B2EC0295;
	Wed, 23 Jul 2025 13:48:41 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 23 Jul 2025 13:48:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1753292921; x=1753379321; bh=1bxfhcTWkM
	7vaEnWSbmaWtCIezioemMnAYdg/XsSolc=; b=X4JrKiiCZOl8532cUJ9EzhNWkU
	bvwcB9jXrQb5qt8cxBDOxvw5omWe6wzUaSjGBlXq4wzV5y4wJ90J4cYJTD6mcPOd
	bAR4PYno4SbEC1zcJ1xdiDCn4EroZ/sn9thpvoh013EvHa5gT3WLUBEwv8HpLOWE
	LXnO3WjikeuRqIEzSmoCk0eF7IBDxYCtaFXf4ZXanQiYlsja9Tud/IUsZvbyMwrK
	dOURL3GkdFZZBbxU/5uhmN5GS9J4fbbQRF6J9vEL/UzkUtq/O1SIWgB+1p7TRc1V
	6I5K5WTxgsYnWFt3jPmnTbPhO6TbYoJHEH/N87ClAV8IAXb7/c5upzhLrBiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753292921; x=1753379321; bh=1bxfhcTWkM7vaEnWSbmaWtCIezioemMnAYd
	g/XsSolc=; b=hS48sFjQWiWaJTnKoVfK9CsTQdC9A6JsiA1Uilt8o2Gjgz6yBnH
	EbZb52f0kciNK8/P/AUBHwaL1+fmqbdaoewQzTpkEzMDwxMhCkLRmAY+PKpF/jsF
	W/epLPNb3Qn5QwH1bF9pXLRSt04XApAkaSOvW5m5hwvuvfirjxOjimNt1F21jWJ4
	fgxCNs9Jqt/M1GqTzLbncMlYbKqNY+Kbr7X2qBS2p9RrGdmlPHHjkHKdYfSYLnnG
	GSQllO4D42iCmyJ+ehpDn4KtMVu2tkxxJbwP9Eh2hop72z8/tMyYrGkEr6UVDulV
	urKg1YRJlROxaXjbARcAJTT/RrlYG9rxg0g==
X-ME-Sender: <xms:eCCBaA5_WTeVi2q8yQUrfkQoUFgovyuzP4CxxosVsmvOsIooKqaciw>
    <xme:eCCBaMjcqb8ei2yzxnslYdG_yzbiu1zx9blI_igWHXC-5z3Nk0lb4-zdHnvQstyiC
    wInlMc7EfEozfzeDg>
X-ME-Received: <xmr:eCCBaFdnsEFU7nknWFHn1y_oJzJq3fM8WFxhRmiUOWR0EpwjdH1W-tyxIrES2tiFksc4z0YZ2ADeU2pKpyHut-aCKhdriOmKvVfEXK4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejkeegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehluhgtrghsshgvihhkihhoshhhihhrohesghhmrghilh
    drtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehosh
    ifrghlugdrsghuugguvghnhhgrghgvnhesghhmgidruggvpdhrtghpthhtohepphhssehp
    khhsrdhimhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprh
    gtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgt
    phhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:eCCBaEwmL_Sk39DYK1LSvWg8h0BtohPf4lHNI8OAsWLnXIn-btilsQ>
    <xmx:eCCBaE19VwJBgmvpRvZcBGbuIgZRZf2lVDcRp2g7XSQSLUwqlpLmlg>
    <xmx:eCCBaKzAdVa01llbsYR6h0P150Is075UlyMq6p4s30KGvpkymnGNqQ>
    <xmx:eCCBaJWSQpJGHwzHuovwQzJAtcTZnLBIEMDufY1jJGU1zLAoAz5Utw>
    <xmx:eSCBaKiMk66qq1UUN5X4BbilxmR3LMjYj5CVAm95H-l6shjrkg8Ga_J9>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Jul 2025 13:48:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: Karthik Nayak <karthik.188@gmail.com>,  git@vger.kernel.org,
  oswald.buddenhagen@gmx.de,  ps@pks.im,  ben.knoble@gmail.com,
  phillip.wood@dunelm.org.uk,  jltobler@gmail.com
Subject: Re: [GSoC PATCH v5 1/5] repo: declare the repo command
In-Reply-To: <ABD6739A-EBE1-4228-BDAA-600104726808@gmail.com> (Lucas Seiki
	Oshiro's message of "Wed, 23 Jul 2025 13:28:47 -0300")
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
	<20250722002835.33428-1-lucasseikioshiro@gmail.com>
	<20250722002835.33428-2-lucasseikioshiro@gmail.com>
	<CAOLa=ZREo19jCj3i+XkRM15AzaAV9ZLOvt42pTiUFmcZpCyS5g@mail.gmail.com>
	<xmqqtt34tfna.fsf@gitster.g>
	<ABD6739A-EBE1-4228-BDAA-600104726808@gmail.com>
Date: Wed, 23 Jul 2025 10:48:38 -0700
Message-ID: <xmqq34amol1l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lucas Seiki Oshiro <lucasseikioshiro@gmail.com> writes:

>> Besides, wouldn't it possible that field may have to contain any
>> end-user specified key, including <LF>?
>
> In `repo info`, no. This way, it's safe to parse everything before
> the first <LF> as the key and everything between <LF> and <NUL> as
> the value.

OK.  Even "git config" punts there by restricting the subsection
part of the configuration variable name by forbidding LF and NUL in
it ;-)  So, I guess we are OK here.

Thanks for thinking it through.
