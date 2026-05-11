Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C8526ED46
	for <git@vger.kernel.org>; Mon, 11 May 2026 02:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778467984; cv=none; b=O0En1i8tkTTSE7/xtsd/RwY9dUfC1Aa7mClwuo3e6vAuw08uu29ACGNR2ItNkMYiRjKFUWBTzTUNX7RWj76D0J3Q4tyrfbfTjvRwoYBxuXefj4gJnJ1bJ/sd7molqMEwLlNyEM2QhNlEVzvmEWl+68IfoguGI9bhg26o5JOKgpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778467984; c=relaxed/simple;
	bh=LYRyrJJhz0doiPEpjgusuIyPbSMeRP4S2pvbzPSi6DQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KftEiygzYirB+UqeoQeKYxAieQj12fiv3fO2BZiHbDacU2b2ihm+96VtbCPlNj9IOlpeTrhhJE3fsmxLDh4qTVaAfVC/LKh/K0KNO6szsZsQlOicHdI83KgxTGIGk+ZFj6DX8EdIDIMR7Xp3c0o9yRbUYjVtZPr4rt35FE7E1T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PWQxJY3g; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CsmxgrPY; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PWQxJY3g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CsmxgrPY"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D4F687A0063;
	Sun, 10 May 2026 22:53:02 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Sun, 10 May 2026 22:53:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1778467982; x=1778554382; bh=7Ihy/s7CUM
	AM9MQM4KICOO87yKlklegOULdWW78MFlo=; b=PWQxJY3ghREZ8Oh90y9RsAngo9
	KaVkMZMPFAKbKhlymBXHipUuyOSHAHKq/w0KllHir9purSPuifUHFgmp1NDGmo0J
	k78P8IzNFwtHAvElQVdqRQccMmYNWyNae93RzgPkFoKbbUdNyrqytXSpq5wYmPUe
	hh9fL2sHTcQ3wmCdRsNGnNxR3shJGPkaVMdD+Ow8SAPtkKvJvf+5S/0uRNRNnCkh
	7x6G9amYtCoS1Ja6cF6vTHjTqnsRmCmE4PFpaXXcCUqUv6dlDHKAU7/Rkfml5s6f
	l2o+60nYDMAlP0oezLQe7rU9iP2qXeQ4XUbWxH7wBJxlXSn2YI0VLnYbzn5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778467982; x=1778554382; bh=7Ihy/s7CUMAM9MQM4KICOO87yKlklegOULd
	WW78MFlo=; b=CsmxgrPYG9hY1OGu2rXLdjyL4sK5o+lYl0hcl7eDL3gl5mcj06f
	8/X9/R4EvJJ8YVmc+EkUm5EOfDWS6EEJBPpAyodRKs+7nvt6cDqXNSUrM9Gam24E
	AQyaLd8hwi024KHI/EzpOobcX0MlyxIbA+Ws+jQONu/ULQSJChh5nKeFeYOuFavn
	nrHlOSYvWH0s1tnq7sXBdvaRkjWXoDDTzscly+b1CKse3/v7xgMX3CwkAcV+wwTx
	i7Nw9o45XnUWcmXAx6vcriPRPBdvDSY0jk4f5NoxE2Azvt5uslCMXrOmAtzwLS0y
	BmxmK2uzdYkMwVDIi2qyBWj1JE//6T82m4Q==
X-ME-Sender: <xms:jkQBainFCmvMgocp04_HpLXjxAxnIKyfKyXspW9NRLivS52Sx8nmTA>
    <xme:jkQBaguvsasQtxGe2Zo_V9cEMgyG1XwaHzZWoI7-WLmy6M9bY2AkgFX076PEWpgSd
    1FRNcqPkFAquyzFm_2AMGUNX4G4-wGxs5njxSEHWgc88rapPLQ6xjg>
X-ME-Received: <xmr:jkQBao_8IUkXuUCNLwL1SXJdLfKlr3h_OfJ_Qdm2YQ0qmxvaABlBRj7s5538WjdjA7xlqtXguhotlzvDE2NZdwPwgKhdAvVW6g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudejkeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtth
    hopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:jkQBaiMt1gflwxUumAKcw0q1UqNwDXctQSaRnpA9PQNxMs4xj3LQXw>
    <xmx:jkQBauFmGO4PChVsqHL1Pwo-ucGlWR2FBNbaq9W0DM39nngfA8Z4qQ>
    <xmx:jkQBaoRNOkb1_krJlSWiQ-Wka2caorkGYvwnueUJNGd-aase_E6U0Q>
    <xmx:jkQBajvhYIzE2HAmfuuoswLWZInjdeEFplrp-2-Ja9FQ58uANCGnNQ>
    <xmx:jkQBahS7V7c2wE12N9iAAxCMb8_ZdOl-fIpQHF3Rec6Zr5-tKRrBZIay>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 10 May 2026 22:53:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>,  Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/9] pack-bitmap: fix various pseudo-merge bugs
In-Reply-To: <CABPp-BGkfavqezk2SV3+K6iF8MLm8j_=ijHiPDLmv_U_o_Ykgg@mail.gmail.com>
	(Elijah Newren's message of "Tue, 21 Apr 2026 18:37:45 -0700")
References: <cover.1776124588.git.me@ttaylorr.com>
	<cover.1776801694.git.me@ttaylorr.com>
	<CABPp-BGkfavqezk2SV3+K6iF8MLm8j_=ijHiPDLmv_U_o_Ykgg@mail.gmail.com>
Date: Mon, 11 May 2026 11:53:01 +0900
Message-ID: <xmqqpl32u06q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Elijah Newren <newren@gmail.com> writes:

>>     +   git init pseudo-merge-fill-in-multi &&
>
> Here you fixed the order, but...
>
>>     ++  git init pseudo-merge-fill-in-multi &&
>
> ...then you immediately run git init a second time?  I'm guessing this
> was a stray edit made while trying to fix the order; could we get rid
> of the duplicate?
>
>>         (
>>     +           cd pseudo-merge-fill-in-multi &&
>>     +
>
> Looks like you addressed all the feedback so far from v1.  There does
> appear to be a new accidental double-init that I noted above in patch
> 4, but I didn't spot any other issues.

The topic went dormant after this comment, and it seems that it is
so close to the finish line otherwise?  I'll leave the topic marked
as "Expecting (hopefully minor and final) reroll" in the draft
"What's cooking" report I work from for now.

Thanks.
