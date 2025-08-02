Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC4078F4F
	for <git@vger.kernel.org>; Sat,  2 Aug 2025 17:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754155394; cv=none; b=bhDmdpEkW6FMus8jyxoLYOtdTIVK7NsbEDOx/D6lg35FLaxe0oEXIgLSxBE5kyO2wMAt/17X7KYtimy//ePuPYsqWSNhovn1gdrxspnFDTJY0tgWgXFO5iMAXz77tbuoaGxW1i+Y0d3LRiGDceT6zgpsAp09GSZw37kiMn+Noew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754155394; c=relaxed/simple;
	bh=gYt+d3+8IMesTAXBCTjb1IGtKaUBkKAHU0NYJGcVsZ4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qtImvz6nXdc6a8rXoLY3+uttwfqDUmnIaiS+ud5keUd8wOLQejjr5DDJYKaw1MEigsK4zP6SvdbNuM3ZAdvPl94G9Nnifng4ZvRCuedRUrSLu+twu+DbMsUXTw9W69lcxwCI6h0I73c+7NLKPQGUADt/VWSHLgzfuIrBg9oZJrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SJIPQ3ps; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c+kN1kIU; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SJIPQ3ps";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c+kN1kIU"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 82DA714001AD;
	Sat,  2 Aug 2025 13:23:12 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Sat, 02 Aug 2025 13:23:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754155392; x=1754241792; bh=YFHPWpGkPX
	Wf1Wa2RYi4oTb1tyd+YVKZnq49aMVENFw=; b=SJIPQ3psop5F789gSF6468FGQh
	z0HHnQSYVI9T+m/9cb3mPQasTpiO3Ho+Br6v+VzuN/P29mu3CtmlVQGiHs/wCpeU
	DqLz9TG7+Rptwn9yBCM9u0lV/sdESAvw+PdqZZ33vym+LYU5jjDvOvX4WZT2XfJJ
	FYacd3IsSIEKmyse5gXGfk/XJL9+G6uHyfxJ1tuHMVtMaJWGjeGjR3OWxewJntAz
	dJmvAydC7+8bVjbZThHJareDvwXeUJ59Mh4gEWeiXLgIPiLfNRrvwfO8jUgeGTvo
	Qw6z+P6Kv10sxZSKjb2YSmuPxBhdcC7SoEaE6p6MVhDtGjLkt0x8S2371MYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754155392; x=1754241792; bh=YFHPWpGkPXWf1Wa2RYi4oTb1tyd+YVKZnq4
	9aMVENFw=; b=c+kN1kIUX5IPWUArmkFR9kLWjvmk1Uy2Q46IzRaAowS04TMi0VW
	rMTD0eF1mJ5ytmMZrAD1NYz6EHxqDmObDh3LjPjdG5IJHKRXqiHP9N+L+2kUr1Kw
	GqEmzIJwBekMkr/JO3aWXN1qYTDGPOimJhnwEYBydbeJ+o6MPf3REVfq64CulTot
	oW/ENz6/ffyohXcbFBSIKZBiav8APVzI5tRrgXRlBPZIFAFOcaJ5wZCBOHjHbfe0
	VUctyYKwXXGL0qLWDsqpN7ZLxD5ONkJNS4C9Va6hD9wr9ju/XBPIi7ZTJtUke/+g
	oDXnaRBCKDD6BtcltWEAIayjU80J2+qAeLA==
X-ME-Sender: <xms:gEmOaNm6Ut_M5HRg_J0sYZ0OcfZnnPdX0HxLp-1h49pJJYDbFle_Dw>
    <xme:gEmOaMGMogyNraik_LkUt9SYFcUK_uUg1KtTk7W1TF1-ZIXwPt690twmqVEWj2CV1
    aDUjGdG-TDjKXl71w>
X-ME-Received: <xmr:gEmOaNHXYXRdHSLf7J1Pn_V6hjtcxzxtiLuLTpzU3T8JPBE1wqwCO6gZ1_YX2m6qMTZS92vQdoX5j0UllRYWSJwYoAUgVZI60MH31DY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdejudeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:gEmOaJMlnBJ6JKCY7lgpcerkohvoLFJZyNthQI3_xp0YAb6NXOsZuQ>
    <xmx:gEmOaMGSU16Imtq2dtFKMQsbR_nLO5KjWDl7ZBFbgMgE2-1EzBXD7w>
    <xmx:gEmOaAPsLVU-QfZw_WqN5lPZaEMsT5iW8aqLyLEsjaHdXMjackhywQ>
    <xmx:gEmOaN_vihap8U4xVvD8cjNYLgRB8bpQK3MxlXDExkJ8sKaGUC4g_g>
    <xmx:gEmOaIsc3eW0lR-lq_rciE6Pe7TFkzGi7Hw7xlHEBRH6fjSV89njED5u>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 2 Aug 2025 13:23:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Git <git@vger.kernel.org>
Subject: Re: Why does git-grep appear to treat exclude pathspecs differently?
In-Reply-To: <CALnO6CDgjmDd9kBCLzjb=JS6Rqg33aXesjthr_Q=HCA-ru2k6g@mail.gmail.com>
	(D. Ben Knoble's message of "Sat, 2 Aug 2025 12:14:07 -0400")
References: <CALnO6CAOOTBQf3s9B1G8AgwcbYnv5VNY63q-6bGPeoaLy208rg@mail.gmail.com>
	<xmqqv7nezdw2.fsf@gitster.g>
	<CALnO6CDNDfx6L7CmPwE0eBZFkd_JkZf6hDwrADccAb14QhJGDg@mail.gmail.com>
	<CALnO6CDgjmDd9kBCLzjb=JS6Rqg33aXesjthr_Q=HCA-ru2k6g@mail.gmail.com>
Date: Sat, 02 Aug 2025 10:23:10 -0700
Message-ID: <xmqqo6sxhc3l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

>> > > - "git ls-files :^:Documentation/RelNotes | grep Rel" yields
>> > > "RelNotes", as expected
>> >
>> > It is deliberately confusing to spell ":(exclude)" as ":^:".
>>
>> What makes you say that? It's documented in "git help revisions":

Because the most natural way to spell it is ":!Documentation/RelNotes"
not ":^:Documentation/RelNotes"?  

And that is why I did not say "invalid way to spell".  It just was
unnecessarily unfamiliar form to say the same thing.

But as you need more than one "prefix" to the real pathname to
trigger the bug in the disambiguation code, :! alone would not have
exhibited the symptom, and you would have needed something
multi-letter like :!: or :!/ in front of that path.

