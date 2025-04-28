Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBBE289352
	for <git@vger.kernel.org>; Mon, 28 Apr 2025 17:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745859923; cv=none; b=OMOQVY+cd06N4BXo7GiwmF9P1VUkF+B61taTSSaiMYo/3Ms74vj5XLpwTHOluuYGCE17qczTbq9R5GgIsedHsX/2OnOQmn1D76RnrQRwJHXqFeDfmAMxrboZzB5LcWpCJMt4tbl1My/I0wLBDYrrUN86M94Phg4fugniDLLzI4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745859923; c=relaxed/simple;
	bh=soKlRNJwtM88BIYvyH1jbpd/TlIOXtAvO962T9FodhM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Yc28XgjSQ15zScAd7x+XDtQQGeDhcuK7dAaiT5HxkdugPxrQCyNLoRbyWthPISBPCdbpYpGVNRKSBjqU0NllYV4t5gbyiCj69VZLwfrw9vdHpbQMCslZFO3wV0RjZUDA6nJz20JemC1G0finfx/urfcaz6Hc9u3986/22zmMLgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cS0K59DN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NyWFIs47; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cS0K59DN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NyWFIs47"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id C4AF01140213;
	Mon, 28 Apr 2025 13:05:20 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Mon, 28 Apr 2025 13:05:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1745859920;
	 x=1745946320; bh=6kap4rHg2sypvPvLFRN9YmUR24EAYj2Rh6vN2fymIyg=; b=
	cS0K59DNaKrg4VlYwDzeMa7eTCGEHUB0Ori8Fre00KX90X4U2f0pH43wWE9AKp+d
	jzKkCakQQOo4ZwiSwtmj4rHbQcWufGvCT0JnS77LReoBm19zmGYK/dNzt96Q0Drc
	0orHTRU7IwXwCpG0M6AIOrM5MCtwgssxZVmv8uX3g2+a36Z4yhc4/HzfIASb6viF
	BKW+Y1O9vFXfSqzL7wHPSnYqUGq31kPVjuTnExOWd8V2gQFw/IJsuUkDrFDHol35
	onF4aHblcCQRr/WB2KQQYwH00bb6wx/udhcbRKrADf3ba9za5Xf0YnzWs7B+NsC2
	/3yX5DrznJtuW6gF+9N9IQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1745859920; x=
	1745946320; bh=6kap4rHg2sypvPvLFRN9YmUR24EAYj2Rh6vN2fymIyg=; b=N
	yWFIs477BvYScJxSIqGnO06pBmRLN9oDDkk3ikugjYeEa4G10v4ZLiTKzaJ8vwAW
	Gdk2d9JuiKYFwwiumCTwMeEoDTZO8KBxyWA5K42euGUjSz10MmMOgccGWKoJMIzQ
	bwOdLyhz2wOuKxxS9lU2Pa+IQICjzSOzbt3g2EYyBgHWe0PyVnjPYmcpkFAh0140
	iggjZJ7y5lt7jz6LCU4PIVELkgaPqHFaW5HVYxhN3dnSJjygyCJT1qD/yI6gE1Pp
	/3AM1ojsho5b9fexe18CpLgZVon3hSXkTus4DxPHiVIRsiN34Hf/jX8xJHuIyiNs
	ZEb6p39U2k6bjynl4/Phw==
X-ME-Sender: <xms:T7UPaAXjYCn4SDBkeBFNAczHvGmVLZSIckJZ6iQANkrj0ib4s1MQjw>
    <xme:T7UPaElDyZBZnBF3mDxavAgZvX-ThL8uGUtkPhQQ8vFTBTw8JaFSdap_I6AKPoORj
    xL-4s0HeBPTXSNxyA>
X-ME-Received: <xmr:T7UPaEaU0cSHS0ZMwtymww6cVM5C8zs0elfH-XJURFdR3kECJkXAf7_N5Ida7-sTUdxogcM0HyZuKZct5UnrMMBGp7Zjz2FqE7oo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieduhedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddt
    reejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpoh
    gsohigrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevlefg
    keefheeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggp
    rhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehnrdhglhhoug
    hnhiestggrmhhpuhhsrdhlmhhurdguvgdprhgtphhtthhopehphhhilhhlihhprdifohho
    ugesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhes
    ghhmgidruggvpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:T7UPaPVx3sFR6TnEw6_guMFa4T4JCI86mnM-fU7kI8aR2uY6R7juFw>
    <xmx:T7UPaKlnOCaQb6itxoDL9WkYsz8iUwixxfBe-lv4O4Wg144ynCW_IA>
    <xmx:T7UPaEeV2JEodMo2dmZ5ZYdEkC_SDSi0q55HPdrgcD-u4eBJ5szR_w>
    <xmx:T7UPaMHqZlG97S6DLq-Gnw4tixevX92zqoe8KkJNhSNCBzZGdSXRWA>
    <xmx:ULUPaLK5NiJOg6l08xSZG6kZFgpGAj0ahyfQTBKOCKSaQhqXvdVH40AO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Apr 2025 13:05:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Niels Glodny <n.glodny@campus.lmu.de>
Cc: phillip.wood@dunelm.org.uk,  git@vger.kernel.org,
  johannes.schindelin@gmx.de,  peff@peff.net
Subject: Re: [PATCH] xdiff: disable cleanup_records heuristic with --minimal
In-Reply-To: <f3140b32-5a25-448b-a99c-1604f6237cb8@campus.lmu.de> (Niels
	Glodny's message of "Sun, 27 Apr 2025 23:44:21 +0200")
References: <20250425155951.1227700-1-n.glodny@campus.lmu.de>
	<23078e29-8f1f-4eb3-be71-7ef419252bab@gmail.com>
	<f3140b32-5a25-448b-a99c-1604f6237cb8@campus.lmu.de>
Date: Mon, 28 Apr 2025 10:05:17 -0700
Message-ID: <xmqq4iy8dxo2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Niels Glodny <n.glodny@campus.lmu.de> writes:

> Hi Phillip,
>
> thank you for your detailed comments.
>
>> Have you got any numbers for the performance change?
>
> I have been using "git log -p -3000 --minimal > /dev/null", as in
> p4000-diff-algorithms.sh. With this patch, I get
>
>   Time (mean ± σ):      2.363 s ±  0.023 s (25 runs)
>
> Without this patch, I get
>
>   Time (mean ± σ):      2.362 s ±  0.035 s  (25 runs)
>
> So the difference is well within the margin of error. It doesn't
> look like it has any measurable impact on performance.

That is an excellent observation and result.  It should be added to
the proposed commit log message, if not already.  The commit log is
where you answer questions, similar to what were raised during
review by your reviewers, that future readers of "git log -p" would
have about your change.  For them you won't be easily available to
answer their questions, and that is why we stress on the need for
well-written commit log messages.

Thanks.
