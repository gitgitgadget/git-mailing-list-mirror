Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B6A322DAC
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 19:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757445680; cv=none; b=GELclXIPzRpxVxIEe/ovhy05buIWtCfLraUFZuHE5YE5XvKxNk5TnH9cCJrd8gLxk+ttc77biogWxNEx9jpbn3FsUXyXQ/oakxoH46rBK07CXudSraOWGPItYIjhzNAwA3AHlcikYz1Wxh5rNpxwikdsngvyE7GnSVwPGufbwYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757445680; c=relaxed/simple;
	bh=4qhn55ypVs6oaFtuu8OgXxBPi8hD3DRM5EWZikS0djc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ELOma6NpYTuMBQdTnSdosFQhQDfiU+AXSg+KCVmFmmJgKXBXQEFIDEt9Y1ee3mi7iHbPGkFNzmlP7EbbrSTY2KcJA3uBgjqjJy2neVvOKyx0/h5kQGFGlsGKNIywLDp9omEzjfNvM8QvK5w8imwR1BaE/DQrkd0K6n5k68qzsj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DHCqFnsx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Fv0CtyK4; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DHCqFnsx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Fv0CtyK4"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 228DA7A00AD;
	Tue,  9 Sep 2025 15:21:17 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 09 Sep 2025 15:21:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757445676; x=1757532076; bh=IXoK8vG+Nn
	rbgGZXSBueH+6M+/s/TrSI9Pc/RHrbLKU=; b=DHCqFnsxiCFIQ63e3hN0nVJ1GB
	lfzA4MopO/Tb1OXw03FugneldX3beEMC5/u0nvJlxom93BqIYTSKXTLzIJqc2XcY
	B8dE/e8ZbG6yQGtoDEA1+kWCnLvYjoNV6bBFSzFCg0Fwem1cwtakpUyKPiCDTTd5
	CXvw1uCOfW7IC5WNZ21tyk5FWp4ZzmwTAMSOUd2fmyexKjr6ylnELvVTR+fXxwJl
	l9+aplfzoOWLuxTvZFB5zR8QX3pGYjvuhCrZbVPixkHZlkPRI+JoEYMRc6wRoht6
	RLhuDLnYlKziJfl5fOe6QohVuoCmRMUwBQ7RDp3Vc6EiRoinD+3HpzcbXzUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757445676; x=1757532076; bh=IXoK8vG+NnrbgGZXSBueH+6M+/s/TrSI9Pc
	/RHrbLKU=; b=Fv0CtyK4WVaLw7dh+kWbL5PpWJIS9KFP1bzBi2X+9+4/9iCQEb5
	HJoMNk4LcoB0tLFwHaPh1gRwuuEszVW0gacAy8kF+8W60PRJmdM/YH/AXqPDytM0
	EN7cQ7sagTrO9OjXkkKrZ4OLnmafKf68MRNgNknXNpeJiptHE9XHbFwMKtkzQxWI
	wn9gZwPE7iqD/rvlm0qRCNFZwPyf7JDmu3iBNP1WVSezbgjScclY7sFMInZYI5O1
	aHBiEsKq/Al2nCAQ2+UAMItYgOsDWlkzrMPgnQ75QbYQnTaMSlhynCSjh8y4W781
	sjz/+7AdUu/rHY+Z6pYC2dqsLF5LhPt2dAg==
X-ME-Sender: <xms:LH7AaDCiVox3N3qJRxceaE_c0yC_6T2OkvJ2W2vRWcIyehCFXR8fRA>
    <xme:LH7AaEE8xChQyPxeqFlOOD9-LqjYBez2Sg6umjkQElj589FTtdh1L8agC17976igU
    Eb4obtCZTl9o71uaw>
X-ME-Received: <xmr:LH7AaLIbvGwiKEibJJ-Cio2sUfotUJiRlDg58hCsMroEP38W4p3WoxsDq-U5xvgp1Jp2nJJ0a_AAMx2ZjFr7FGx6JGuZP9dOKOvtK64>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvuddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepshhhvghjih
    grlhhuohesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:LH7AaInsUt5ckBWU0N_rA7wtTIWSD6stxav-MCU-1vIm5QizpfKE0Q>
    <xmx:LH7AaDQatFRwVg53ZYYUoZz5iLIjdNjxD-21Uu9Yu3B5NjezqRlkSQ>
    <xmx:LH7AaKLzFKhDlqLRzWHCRXz7C9MulyzbZIEZoEmtgRpMfjO8hjMElg>
    <xmx:LH7AaJAuVJQXkfFJINlJigB7exOkGJzZi9W8TeLdmGyyYQMLpY8-hg>
    <xmx:LH7AaB9Yg1ryxRBo08qYPWbPLRT1v_jkdi54vLLtFcI9c_YprMIfr5u6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Sep 2025 15:21:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: shejialuo <shejialuo@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 3/4] string-list: change "string_list_find_insert_index"
 return type to "size_t"
In-Reply-To: <aL_HySU6d1a9qIBf@pks.im> (Patrick Steinhardt's message of "Tue,
	9 Sep 2025 08:23:05 +0200")
References: <aL21cEM0OcnrKtBW@ArchLinux> <aL21_e9B8aCpPRyX@ArchLinux>
	<aL_HySU6d1a9qIBf@pks.im>
Date: Tue, 09 Sep 2025 12:21:15 -0700
Message-ID: <xmqq1pofv3dg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> @@ -266,7 +265,7 @@ static struct string_list_item *lookup_prefix(struct string_list *map,
>>  	 * overlong key would be inserted, which must come after the
>>  	 * real location of the key if one exists.
>>  	 */
>> -	while (0 <= --i && i < map->nr) {
>> +	while (i-- > 0 && i < map->nr) {
>
> This could simply be `while (i-- && i < map->nr)`.

Yes, especially if the reason why we avoid "not negative" aka "0 <="
is because the counter is now unsigned, yours is much more intuitive
way to say "as long as i is not yet zero".  Alternatively you could
say "while (i-- != 0 && ...", but not comparing with 0 is more
customary.

Better yet, shouldn't we stay away from "i", if the point of the
change is to make it unsigned, as "i" has a strong connotation with
"int, the platform natural signed integer type"?

