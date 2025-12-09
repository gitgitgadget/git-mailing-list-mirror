Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F842E2665
	for <git@vger.kernel.org>; Tue,  9 Dec 2025 22:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765318716; cv=none; b=gdH2UdY2ltOEChJsmgV6yz7IBfft9Kz0YFt30h593aoUQ6g1ZQ3vzweivU8vFTnNRzOJO40OJ5F3I7MunIv7rxUd6owlQsDyRHVYfuITtx3Y4ih09BSwxNaAykU3GeLY+nwiGqG2sOHwizaTjrgaBUlSBAS3N2Pdlu/NQT0uSkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765318716; c=relaxed/simple;
	bh=BNeDoIdooTZieP7cna32J5cUsHh0mkHEhkACs+pcmkc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TywFJVX8UQkeyOVMMFIEIc5UkHD3cAe68jFmvLWU7cJj2puuK5/IX1KatW1YXqRI9ZKTvMPNX/BkmIA0XsblNBCa5F1IQ9mvLhwqWZp66xKe/Z9Gy7LjydUBZsX2/24E+wAqbazWyK1+SiFrR27W9VkD36rIj9HnTYVDpi4LS/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=lrHSZcFl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lpEib7e1; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="lrHSZcFl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lpEib7e1"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id B705D1D00197;
	Tue,  9 Dec 2025 17:18:33 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Tue, 09 Dec 2025 17:18:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1765318713; x=1765405113; bh=jTTEJYniTb
	1kIJgdvBnOKiiN0QmsBYhiioYglPNEOgU=; b=lrHSZcFlY8sdIy5RoBUvEyJ+S9
	O6oEw8cnjv3o+3B04bHYfDm5LgdbX4GenQBx9fQaFU8fmYAFA1a2e5nErUgoRTVo
	JuLZq+Y5+AzQVFAxoS1MTq2Q+Ly9Ez08g0ttDAc3ILaWefUzee8DgUdwTG0QidbZ
	tyJgmUlrJ2C8wfiUaBqS6OhoEIqmtkS3FbyJDRTbBXXzZmnnGJjPeOF4OpJqZ9yo
	GzIeP6zq7gKDzS1k7xyYtRVlWFWqAnrnzc0/7WYDlCPVjg944u8eNKakI3f8ro2G
	/Ri36nAWpTak3wejJRu09zXxegc8ByOLk8LuepftlqyvRwt+7E2jWnomMc3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765318713; x=1765405113; bh=jTTEJYniTb1kIJgdvBnOKiiN0QmsBYhiioY
	glPNEOgU=; b=lpEib7e10KM6Hz2O9DwDz8FQJMIFqdyZSGnzm3FeLLfhppZ3sri
	3fIean0GziJQiWMyLKUZZ230SnjdZhP1DUcQBK4S8PXvEhkd9oCHzgKfQRtaFhF8
	294XHvtirgIusto6k/vJ28xrBhvETE2ImPDupGpJtvFWdvFFzIdkHLS5ECwZGlRI
	nZGiyTvlbiSTDrEp3dY1rKNZRxQ/qd/gMfkUbNJ1clXzcSLu5efZylw/hPgMOPMZ
	dg+ypeEJjBY2GyM1wa9GvOOqyXu6sPwPSfGuOZ+MtIjpmGTtzcwZ/OjUHU9qSNki
	V/HJII3ow4voAUqgiGTjIKEVP/lKBEkO5WQ==
X-ME-Sender: <xms:OaA4aeOJ0Id2Bbl7HVfUMSb0dnuqQuhsekqGorucWB5_UwmcLk8IAA>
    <xme:OaA4aQrpYR5VOj5G2fCJ3SwdDEuGpq4ucvsyEzipIrODiWUPsXvJl91hYO3TRdVvj
    KoAVF0oKVInKtH2M9Bp_f4T1oQT6RwfBqSDpnVdEdSuR0rb94Bx6Es>
X-ME-Received: <xmr:OaA4afGPCrEL-3TDLaABIrMUyBSp-DPB72cVIMcZ9rc05lKm4beyYoLkriYxEOFYRbj8_3iuXP7qg-xvPhmXk0hLWAJ96SU-Sg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdejgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithhgih
    htghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtg
    hordgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhm
    gidruggvpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:OaA4aVo_63LzaF6UC-S3tT1y0qjCw5m1Olm-YHydiVTOsTfvyD8RPg>
    <xmx:OaA4aYakgiIijbzO6YOwn1SfgzOXp9uL-q3YerplE1cFsi4aBmAc2Q>
    <xmx:OaA4aeWPKIBE2_-F78oU6nw7s4TgUI4pLhbYYBr3KrwT6--GePsyVA>
    <xmx:OaA4aR95sU2ounNryVhSz6oDdNFOdebQX7A5S8l4bDZH3aM06pX-UA>
    <xmx:OaA4aTjgbl-fywCptugBViyMRUYmIOJBWjl3ery9eRh7el8Fe0GNMiKn>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Dec 2025 17:18:33 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Eric Sunshine <sunshine@sunshineco.com>,  Johannes
 Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 00/10] Prepare Git's test suite for symbolic link
 support on Windows
In-Reply-To: <aTfX-gMI1kByV7yA@pks.im> (Patrick Steinhardt's message of "Tue,
	9 Dec 2025 09:04:10 +0100")
References: <pull.2009.git.1764440906.gitgitgadget@gmail.com>
	<pull.2009.v2.git.1764946945.gitgitgadget@gmail.com>
	<aTfX-gMI1kByV7yA@pks.im>
Date: Wed, 10 Dec 2025 07:18:32 +0900
Message-ID: <xmqq7buvjo3r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Fri, Dec 05, 2025 at 03:02:15PM +0000, Johannes Schindelin via GitGitGadget wrote:
>> Changes since v1:
>> 
>>  * Fixed a grammar issue.
>>  * Using cmp rather than skipping the comparison (thanks Junio).
>>  * Extended a commit message to explain that it covers all the cases where
>>    core.preferSymlinkRefs needs special care.
>
> Thanks, the range-diff looks good to me!
>
> Patrick

Thanks, both.  Queued.
