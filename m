Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3B22236FC
	for <git@vger.kernel.org>; Fri, 13 Jun 2025 18:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749841039; cv=none; b=S0R2h2EZD7EhpG0m1bbSxotNKuwrBatl1FtNwDc/7ss4S0SjgfhTnJauDPP656/HynYT7qDFiWhToKVt1W9nQ9faO44BOzkE9i2fUYDEINROnWhdRo+0cRdGinOuNi5G+XG0SxO2w77NwGCjis/Fsgpfdl6ciSzBItn5ur+xGkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749841039; c=relaxed/simple;
	bh=Upz2smk0v6Xs3YNmO0XuMazc4YMdzcEku/gUyur23kU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MutZX9PXr+GiDWLq96MEYfgqdYnBT5wDB3dtVIEoDoqa0ZA3bTMg/e6bWKZHYyTw7akka8bSdPepxkfn5bGnXFlvBnuLziR9Gkkb9icIO+SirjFurUH6W07C4GsHg9gkKpDHQtAq4Mu7cefI355wDSrdga6a3YfcHgSJuZImvLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=a3kG062j; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LL4KVqaZ; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="a3kG062j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LL4KVqaZ"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BDF1A1140156;
	Fri, 13 Jun 2025 14:57:15 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Fri, 13 Jun 2025 14:57:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1749841035;
	 x=1749927435; bh=SC+YSVU06wD1jSVCsZL0eXBAdgDC3+GVE88Y9+bwH+w=; b=
	a3kG062jCPCu6pTl+ourXqFi2mpB2hshlgFxejGFZZSdn0DXS4/u76j8YUHVsHdx
	fD/1FhpBtQDe3V+uwXtTel8N8JxTuVCIrLZ6yIIUMhcLzQOj1AaUCothAJ70R7KY
	XGipoXkiDc3BL+ht4lQhxTQoYgvl9u8wyJAf9Iax+D/HsAyM7iUO+qzJsXkOmoWl
	4Z+GHWVMPFlv/wRyTAi9pQa1ycgFuwMJaW2qUDACiPsO6sfbBZxD9m8P3F5wjdFx
	hMnX69T6UhTGh/PdxAqXO7GxhQw319/JUajt8CCwGzNfSdWiE0mJWXMJ0kJRjVAg
	9xI0L6LctnodwQDp3zvtLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749841035; x=
	1749927435; bh=SC+YSVU06wD1jSVCsZL0eXBAdgDC3+GVE88Y9+bwH+w=; b=L
	L4KVqaZIzv6nzhber4m7maNgOvPAoDZme8lEyNmuFze3Cyz0hZmN812XKaRjKYet
	r9+IhuTSz0LZm9zMB99m/abnhUYcv9QWxq9AOXON8Vk6zK28rXznzChYOJiHb/EO
	JomRtLbeWuyKUpSK3ETkwUZNo2Dt4CiNz3EaovamNXXpb9L9XPlvU6qxAYNB0tPZ
	mhxKayjn2etRTQ2vOJaQ78D1eKcgthxrLwH4EEow93ID6RKvZoJmwGihHIrQ+Gb1
	tFxeJn/Eoz83ZyZ9xEIIK43TzJQgopaupKCpmwt5/I3EBjgEur72hcbqEklWSvl0
	7enGx15EqRj0XFQuY2ytw==
X-ME-Sender: <xms:i3RMaHQYe_7N5X-X6sdUDN12cNBvBc9cl18nzbe8LY6t2cpgyh6GuQ>
    <xme:i3RMaIy9R12oA2WtkkX7uoEEGgrEXUeHLADj4Ik72Nxc6opqySzDLFzdO9suWGiZK
    Ls60Fvx5779wwynVg>
X-ME-Received: <xmr:i3RMaM3UR0jpXCUBOdUP_wb-rlhmRR1vavxlDYH1FLxwUgZdnPGF-zCiaC4bnTFGp-O_ZlZw7DJlJpGdsOOVGUjy5rwLiHtoXyhv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddukeejvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekredttder
    jeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhephfetvdejheduheegleehfeeivedtgeel
    fedvffdtvedtudffieekieeijedvlefhnecuffhomhgrihhnpehkvghrnhgvlhdrohhrgh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdr
    tghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhht
    ohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtg
    hpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthho
    pegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:i3RMaHA1pYdUXbFtbIHwoqPyRRrLFQPsRu3tmLysntBp6Yz2ba8mlw>
    <xmx:i3RMaAgl3s5_UCoi6IAZtZ7o0VruLwBWbNUa9_iKzq4h-iZDpu7jwA>
    <xmx:i3RMaLqQIT5s-klSTPX8c-uEgs19Fi9qTpcgLS4sOu9iT7MHF8Dr7A>
    <xmx:i3RMaLhMZ8Yt75iydhJ46LY9u0za14QTnRD6U6mQFCSQEGeaw42MYA>
    <xmx:i3RMaKTm_ED_UTfJX_ewDUlIWkAVa8MJveAlv-HPWcMbAO50_BNE3IZm>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Jun 2025 14:57:14 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: Karthik Nayak <karthik.188@gmail.com>,  git@vger.kernel.org,
  jltobler@gmail.com,  ps@pks.im,  sunshine@sunshineco.com,  Christian
 Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v4 0/2] refs: fix some bugs with batched-updates
In-Reply-To: <CAP8UFD2ZhXSE85EtQbA42UR0ds+nsQba4EcY589raMBAoOrfLA@mail.gmail.com>
	(Christian Couder's message of "Fri, 13 Jun 2025 14:43:12 +0200")
References: <20250602-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v1-0-903d1db3f10e@gmail.com>
	<20250613-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v4-0-ebf53edb9795@gmail.com>
	<CAP8UFD2ZhXSE85EtQbA42UR0ds+nsQba4EcY589raMBAoOrfLA@mail.gmail.com>
Date: Fri, 13 Jun 2025 11:57:13 -0700
Message-ID: <xmqqmsab8o6u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Christian Couder <christian.couder@gmail.com> writes:

> On Fri, Jun 13, 2025 at 10:10 AM Karthik Nayak <karthik.188@gmail.com> wrote:
>
>> Changes in v4:
>> - Swapped out F/D for D/F in the second commit, since we are talking
>>   about conflicts between a directory and a file, also D/F is more
>>   consistent.
>> - Fixed some typos in the second commit.
>> - Changed comment to single line.
>> - Link to v3: https://lore.kernel.org/r/20250606-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v3-0-e1c41693bd35@gmail.com
>
> This v4 looks good to me based on the range-diff and my previous look at the v3.

Thanks, all.
