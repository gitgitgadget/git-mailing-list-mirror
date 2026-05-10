Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E572F872
	for <git@vger.kernel.org>; Sun, 10 May 2026 01:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778374879; cv=none; b=HWsuv8f+02wdFKix4YbRJ1UxWH7zM2yCciZOOW1g9Y4xrZXiR0J1AQDHP9xZNGfxVjoyh/MYmkjhHvUCpvTfBE4B/29ha7b8fvSgvfidnRdA6vZCqMxaFVDuEeIO3l/RGI5Zq1j8iC4uyCxgZ27C0aCQ55cLF705tibuyc3+m98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778374879; c=relaxed/simple;
	bh=UzTyxU0CUVeIcvA2tpK5ipDpyQ2J8g97mCYnXOrJ6sk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XqcN6kuReibmxPst4Dp63VqumyKmgWtFjpjTtP1qnVRjvBBt2E7qWfJQhjv7lfyEXKbwJzBTWKw60PHxGHkv4OAVmcQRekhhvJOef+z/LjQZRfhX53Qdpu8riJn9t4Znm+HZb6mFJfCozkrzvB4Yt2uO9zu39UOIEfJAGefhPNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fuwssU2X; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nzgPqEkW; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fuwssU2X";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nzgPqEkW"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id CFB13EC011D;
	Sat,  9 May 2026 21:01:16 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Sat, 09 May 2026 21:01:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1778374876; x=1778461276; bh=i70XPthc+6
	CbzFm+mdd/WftnyI/89etNfmda/fH6YMI=; b=fuwssU2XUaOFrBnQRzG5BBpd5Y
	PC0T2G2+phNteiqQl641Rmc9f7nckbXCMRi+JryN+0eMvTjx3jXsxVNzOHDulZ6w
	g/IVxVCrPZhBINFkUOnq6nq1a0LZNIDkRgX0mh46MMFXRs3B5Gw6Ajcsb4YDAudb
	FS5f+yvXObEL5HZXsmJnPmmDfcwd485aLmliiaUsPldpf2UtFGxh0eU7cj36ug4V
	5YAqmEFH0z+MT2Jw6LsJfr8gwZi4s2XzZR+Cay/FMUAcTnIrVHKc79icpn1aMbAN
	dwhtMK7VyXsXJd0BFR6Kne//VNwDUiwtPhatbYel0byZzZOJuGXk0Kcb247Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778374876; x=1778461276; bh=i70XPthc+6CbzFm+mdd/WftnyI/89etNfmd
	a/fH6YMI=; b=nzgPqEkWgAZO34zz598sI0fyVjHHgWez/v+aoPafDzhCaF5Fkdf
	752IQgwS8e42K2wboWaqzPryAR+jH5BhfMEoX8kBBqnTUmCqBYaf0dPBnpdBu9SK
	sPVWAA+mmMPVNxMsP8RubN7qF+2ZvUGnnXetRG9h30owKdZ47p23qhFpxOVNpmuF
	sUrHRnZ9LcYn1Wa14HVLRnDQt34Oi+0ZXQ/ETZuwJUcPCAmf16BGEpE1RNkaUtCp
	MZwH1ZdSvITnJ2EzS5STmTUmfBqIqLApPXHIZCUse9aVt2th+pfYsD5i235GZIdk
	UZ7DBJFSS3zdNFUo1rq7a1lJHJSw+4DSE/g==
X-ME-Sender: <xms:3Nj_aaV8WVQMUoJzOvRXs93EaMFSg3OWyeFrc-9p38MZY7N6MNIaHw>
    <xme:3Nj_adkQYbEEYb1vcSzJDYP1mnvhEPOQZ5McoiptZvGl3lOUAVVDjztY9u3fsAiVi
    uOhjCWG0V03dSgaOTqio9gHW0pHkSdHqs27v7bYPIG39agHFZy2Nw>
X-ME-Received: <xmr:3Nj_aTYwbd9F0fgvd2mq4vGRtDBcp1aZRoImDzuEIqnclkcqAu5N5UGsN9VvbY74PNHZssrQwwimmD9tUutzhovKo0KMikf_Mw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudegjeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohephhgrrhgrlhgunhhorhgughhrvghnsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:3Nj_aQMZtlmWGR4NsO_L8UZr8IC_mmO3AUyyO4z-2zwgkcgzhkVF2g>
    <xmx:3Nj_aQaOBiNjtgk2DChABBpSfMOPDcQmRiZEjbQxLG7So19zjNrdDw>
    <xmx:3Nj_aW0qgj3JviSKkbjddg9lOxjR3mhATJDut_waQeBukfh8t3k2lw>
    <xmx:3Nj_aecR8UwOcSksfAeRjhWAc2gOEqeZ5S0VPPKejIfaGIAq9L1FRQ>
    <xmx:3Nj_aY2IWuKpQHbBXs6VudsX2P5mFeCDWFoyW4cqUOQ31E4_F_4ravhn>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 9 May 2026 21:01:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: git@vger.kernel.org,  gitgitgadget@gmail.com
Subject: Re: [PATCH] checkout: add --autostash option for branch switching
In-Reply-To: <20260504182836.52258-1-haraldnordgren@gmail.com> (Harald
	Nordgren's message of "Mon, 4 May 2026 20:28:36 +0200")
References: <xmqqfr48rubw.fsf@gitster.g>
	<20260504182836.52258-1-haraldnordgren@gmail.com>
Date: Sun, 10 May 2026 10:01:15 +0900
Message-ID: <xmqqzf289ixw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Harald Nordgren <haraldnordgren@gmail.com> writes:

>> I do like the feature that allows you to identify which local
>> branches are already merged and prune them.  It will help users keep
>> their local branch namespace clean.
>
> Nice to hear!
>
>> To break the feature down to make it easier to use by our users with
>> various needs and workflows, we would benefit from having a
>> collection of smaller features that can be composed, like these:
>
> I gave it a shot to implement these, and then I ran it one some local repos
> it works really nicely!
>
>
> Harald

It was baffling to see a message with the subject "checkout: add
--autostash" as your reponse to my message that was a response to
"fetch: add fetch.pruneLocalBranches".

