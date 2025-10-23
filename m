Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36B926F280
	for <git@vger.kernel.org>; Thu, 23 Oct 2025 20:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761252737; cv=none; b=uADOJOyS0Lk3UzPMVcD2G2aJ2DE5zunSPlRsQiiPZJt7nb/qQHyYXU43GG+grTflffA4uB9sHDEAjg3aBjxs7qT3zjM6WxfSjNyEYk03ZRbm5N3ZByDPBJfVByv5m66Itjt9jwfanZTq4e18lzSg/OqeTxPlsVMYYBX7IZr8veo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761252737; c=relaxed/simple;
	bh=ucc1aPxR+s1SFDWAXEuwsnub66zy2R2HlitOOQ3MRmI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=vDWV2OCg77tpiXP/ggJu94AxnSxfXkIoL3Bw8iLTkq9KUqWi0j66Aj2gMT2rd3cHD+1MGyEhdvYH6HX2qWoa5sLQTozgzQKzvdNYmo0AA6+yZDEXQrh7L2fOZfljoS/dN/6uoSadWmA37QO563KR18N0cV0qgj6qX1jLPrrclvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=L9rISWMK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VQq7uwHH; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="L9rISWMK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VQq7uwHH"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D178E7A0044;
	Thu, 23 Oct 2025 16:52:13 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Thu, 23 Oct 2025 16:52:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1761252733; x=1761339133; bh=NGQySXoyr3
	a2jFyWZmo6vQPn5jBKgWA6LgATiCyU5wU=; b=L9rISWMKlApmQtus/aHUexenLc
	IXOyl5Dn4cEkii2ChxEwHOl3RS2su8zF0Eefb2We4lHa/B+VhaZ0btdNgfG5szuA
	nDMo3FEU4+EHiuXaKkNftYWnbTIFhQ0GrIgIot/dky4ta64+usNqnbSXQW5uO/aV
	jZ96JHC8ZpGiLkohr8dz+Z+LB5PdXDWaZIJ2Fk4dATvjG3s00gu+1e3UkAtIB9eJ
	pzUzplB1iqJsHeN3jXtwMeQglp+I8QKci00y/kgRyakNQBSfWwIEdudNFfVCp/E3
	FdAhasbGgNBYf+VRoGoJ38X/IDaiyueeKM3qtY9789j0wRE4+luAnIEwV06w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761252733; x=1761339133; bh=NGQySXoyr3a2jFyWZmo6vQPn5jBKgWA6LgA
	TiCyU5wU=; b=VQq7uwHHFVQ+2tKLzAretqdz6/+DaSE7rE/dG1jgwPUzbh5buDv
	yJSDmLqr1TaEeddEWym41pplrI9ekcL/t4toWgg4a5Ypkqm3xDCzTBDrD5o0imoe
	Q07y8t9OoEqv+lC6/VOtn6botZyhVn+MnN1Dr8ikcDgoI65iQD/f/n0KMEOdtDf6
	722/LHyQcbsShu3CuJsTR7/rXRv1/p25ULORF4gOEm5eb7UL8Ue4kqWKXGvsQBQU
	HRdqQ66FxtPu3WDpEwufa0HBsITT4m58O64bfMhdVVhvmz2rGS5GiLyBt3I5luFh
	OUKMCuWZ9fvsliha5m+vdXi7RRZ4tpQbf5w==
X-ME-Sender: <xms:fZX6aLQu7pJas9_7rihbUIA3uXpbvi0qU5usj2tp7JconS0VuhGQxw>
    <xme:fZX6aIQtYlarnH0fruspVPJ9eVQXiGCaVWzV3l_vaK6oplUW1ktpYEk8GiWtW2dhT
    Da8cMl1xV1FDfjza44RTajpPeG2OqYx005C0ui3e45-1wbOIqYMDg>
X-ME-Received: <xmr:fZX6aHQjA_DtATPw6kVlQ_13Px-GiGHAaAc0hnk5TT1hoobvsN3wcfj1MMIt5cyCyhVBarBUftb_MfIAgIbAJ2mQDtTQLkubJJox>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeejgeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehtmhiisehp
    ohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopegrlhhgohhnvghllhesghhmrghilhdrtghomhdprhgtphhtthhopehm
    vgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:fZX6aF4NNn98ELjYDqnr4fXQa-qvNvV8irk1Q-Devh8X76A9_1GFtQ>
    <xmx:fZX6aL1-qpQahtKfLrVTJFReCgOzI32jMyz4El8IZ2NFs1GxFTBPFQ>
    <xmx:fZX6aIAM64xoWekQzoMzggoAT6jrbpyNknjggDqbRebXmi_zNoNfZg>
    <xmx:fZX6aOOTwKpPVw4s6VreibOOBk41wzXTeqZH0zUjJcVXwOx4YSl35w>
    <xmx:fZX6aN33oIvbi55arvNQCHHegOMcTegJEBQlRNq6COXJqR3ZruPcRfeY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Oct 2025 16:52:13 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Todd Zullinger <tmz@pobox.com>
Cc: git@vger.kernel.org,  Andrew Kreimer <algonell@gmail.com>,  Taylor Blau
 <me@ttaylorr.com>
Subject: Re: [PATCH] t1016: make sure to use specified GPG
In-Reply-To: <aOvz-ac8JTCaRwIm@teonanacatl.net> (Todd Zullinger's message of
	"Sun, 12 Oct 2025 14:31:21 -0400")
References: <xmqqsefq7947.fsf@gitster.g> <aOu59eVs7tK6pCoF@teonanacatl.net>
	<xmqq1pn85f5i.fsf@gitster.g> <aOvz-ac8JTCaRwIm@teonanacatl.net>
Date: Thu, 23 Oct 2025 13:52:11 -0700
Message-ID: <xmqq3479tk78.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Todd Zullinger <tmz@pobox.com> writes:

> Junio C Hamano wrote:
>> Todd Zullinger <tmz@pobox.com> writes:
>> 
>>> Interesting.  And well-spotted.
>>>
>>> This _does_ seem to resolve the failures in our CI and in
>>> the Fedora build system.  I was able to run a few test
>>> builds.  With this fix, the tests were successful where they
>>> were not without it.
>> ...
>> FWIW, GitHub CI jobs are failing t1016 at the tip of 'seen' (which
>> has this change), but only some and not all the jobs, which may
>> indicate there are timeing-dependent flakes involved.  I didn't dig
>> further, though.

Let's merge this fix down, even though it does not seem to have
any effect improving the situation of flaky tests here.

