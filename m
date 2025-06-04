Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2004224AF2
	for <git@vger.kernel.org>; Wed,  4 Jun 2025 23:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749079359; cv=none; b=N50Y+yHBlQbpHFd66oocbnoKFrcsuaGzPwCxoJoOACL24aeQ52XI/xkaWxNYG3cSkUJadHDIM04ZsdKNCJmkylKtvK92cCE+xbQ4lp8GbzNFkkRyoMTXp/NSP7iBqHLLoXOWTLaGQW6ruvxvyTWN9Dvf36h2iFS+ROVgUy7govs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749079359; c=relaxed/simple;
	bh=4u/NCr7GXFd0dhXkbKD8sZvpW8SwoXLsdwJjavTk81w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TbVIL0+NECGzQ3yVt8X+A9mrZdqMcSok6xAacpgsrc0QcT18n818pWdNqVzRQ/GRXtbacSgQ2KKO0S1Nz3+5eihE0ZegdfogeFP60jk5pUaxCLdB09nD1mZPwTk5QhuYOl+fBDCg+5pvQVXzT8M+tOMiOxEU/S/lHKSGdbbjFs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WM1gLdPn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hLOYpdCk; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WM1gLdPn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hLOYpdCk"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id F40C413805B1;
	Wed,  4 Jun 2025 19:22:35 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 04 Jun 2025 19:22:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1749079355;
	 x=1749165755; bh=rVmnei0I7n+U6sYEIVM7NVY1Fh7XImhxqAa5vIJLS6s=; b=
	WM1gLdPnvCgU4JanB7ZIGbvcI9NVfv0eZalfuMLRCPIBH0e298ht7FPw5wj287x4
	MIOTEpzgvjuJQjg6E3RoM8ofpAmcsfBwwsr5rU6kw/RE/yrYWNQ6WmIT/02oRNGo
	fe7s9hPVzHZA75dtncka42fqDBCpnnQ71TH1GvSqkUr/AtsuMABhOjAwFC0ETeeo
	1SxJCJFlOeMZ4ZM3JgwZkMvoR2H30VNC9UFzNwqGQBntq7RdnzQJB3l291v/CC37
	BIxxy4mnzTDxDUZtnHduJnEqJ2rlVSKEavbfIkWQPUZwnEjBwhz8mTPQo+o1ITqm
	577P0nUdX/ehV1LD8yXWlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749079355; x=
	1749165755; bh=rVmnei0I7n+U6sYEIVM7NVY1Fh7XImhxqAa5vIJLS6s=; b=h
	LOYpdCk+0hbl2NshOYry/Udou9DkVfSbvIzHR/2gzLC8FcuVuynwzndQitOecRAJ
	tfaX0t8USlEcgh2J83D8U1gBrsvjfmGAsrAxOw5Frwn1r32V1GiZm4gKOr4RpyFU
	Y1TONRJYn1PwDUu7bdLJD7spFUsWZPDC6Dkv8/rGO7FmbpKDCNCEjydcp01WdeGb
	8U8SxdzmK+zjZVFtDjHi/s0uWi86TObCuAON477012+TJ4UPRxwNPdFhmFiDqTge
	rLcydhIhBehTSODQ8Bt7TS0pa5osBUyd5pVxygf8NTrwNBjplZonNTwjwd2yaCmM
	76L8I3LZgk31KZlUH3yRA==
X-ME-Sender: <xms:O9VAaHhHuYDQjexUPdEqFSsyeVl9HrYnXNmvm8VCjwE4UkYXqEEmEw>
    <xme:O9VAaEBar39-Br26AQ28RZ0bkdAzrSXW61zwlJxNLiFmUWpucf6Pmj-WCEivrtBFN
    -eDQTvd5CmIbktjWw>
X-ME-Received: <xmr:O9VAaHFFH5P7a52IhFJSyuUBN2ZIOn-9X2X3h4hChIs0sEyNwxDb9oMZi1OTrhMjsXKVp6hnTy_nHgzZufOfbJJrp5HK33wKpHYM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddvkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddtreej
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeef
    heeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsvghnrdhknhhosg
    hlvgesghhmrghilhdrtghomhdprhgtphhtthhopehjrggtohgsrdgvrdhkvghllhgvrhes
    ihhnthgvlhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepjhgrtghosgdrkhgvlhhlvghrsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:O9VAaESDwwOeV-WRj-Cl6itfiqT3StAKRvSLNAYflhwa4KgsQuYn4A>
    <xmx:O9VAaEzAIXmYZ2wEbLNWn3xVDj7ks2I52Ayy6lgOH_Km7UqQ6JUppQ>
    <xmx:O9VAaK7EGZVJOrwc-ujwyxHpD6hGvpWbkKlhZN1onOOZsLBfm1Gb0g>
    <xmx:O9VAaJyjskmNtakzni2Yelt1VEIwu62NcFOt91r9SRXefmKHVUjcAw>
    <xmx:O9VAaEMTJW838tUqjaUHOfJ2XBmJ1V_ZC5GSAG2HN5lrbHpJBVj3YVvs>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Jun 2025 19:22:35 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>,  git@vger.kernel.org,  Jacob
 Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v4 3/3] diff --no-index: support limiting by pathspec
In-Reply-To: <CALnO6CDUVpn-G20sFJviwjXX0xfjkG=HiUAMnWw96JCX+qyqgw@mail.gmail.com>
	(D. Ben Knoble's message of "Wed, 4 Jun 2025 17:36:06 -0400")
References: <20250521232917.2333291-4-jacob.e.keller@intel.com>
	<374BC043-8FB8-4052-BDE7-6BAE7F182994@gmail.com>
	<f41be4aa-b16a-4072-8999-3c5874f2bce5@intel.com>
	<xmqqcybjb6pk.fsf@gitster.g>
	<04ea6073-16fe-43b6-919a-08187de030ba@intel.com>
	<CALnO6CDUVpn-G20sFJviwjXX0xfjkG=HiUAMnWw96JCX+qyqgw@mail.gmail.com>
Date: Wed, 04 Jun 2025 16:22:34 -0700
Message-ID: <xmqq4iwvay85.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

> On Wed, Jun 4, 2025 at 5:05 PM Jacob Keller <jacob.e.keller@intel.com> wrote:
>>
>>
>>
>> On 6/4/2025 1:19 PM, Junio C Hamano wrote:
>> > Jacob Keller <jacob.e.keller@intel.com> writes:
>> >
>> >> Would you like a v5 with an updated commit message?
>> >
>> > What we had was already plenty readable to me, but if you think you
>> > can improve it further, I do not mind waiting for another round of
>> > update.
>> >
>> > Thanks.
>>
>> I'm fine with it as-is. I think the minor nits from Ben aren't worth a
>> re-roll since there is no functional change, but wanted to confirm my
>> opinion :)
>>
>> Thanks,
>> Jake
>
> Fine by me as well, thanks.

Thanks.  Let's move it forward, then.
