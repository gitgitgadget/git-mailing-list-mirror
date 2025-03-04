Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CBB2862A3
	for <git@vger.kernel.org>; Tue,  4 Mar 2025 15:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741102865; cv=none; b=XhbOfOPjNFHYmcmnjBAdjjL/d8nEtXwH8NI6OwCDgqplcXjHA+vFPbl6QQC/Qn6pamXBHwCYvpX1PuKci5Z4X6N/90pdwONemRbkNsNe6FqXO5WVR8MBglt1U6UcA/d4Z/nZyO0NMqy0wi35CzbglcPh2CHVmSlw61MDKGtuCvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741102865; c=relaxed/simple;
	bh=RXse5+YPs9dfTDQskFaFKheQ+fxPNJogRdiBLKwTNpw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=vA9FHB1l1oXpWcCUUayTlcnppBmEsmc3Us0r0UwNcTrn6VQn2T3Tkj/3r0KXjLuakP0cbCtGrjAmgfGsESVG9stjvTlecEg6qIMbBx35MaCv9mp+mSk57CYkQYP+fv3+N5RjC6PRLVUjvN9KLG3XUwOrpGb/Qc/WwqGACLrN0CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YqA050t3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=y7nf9Nss; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YqA050t3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="y7nf9Nss"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EA4C311401F6;
	Tue,  4 Mar 2025 10:41:01 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Tue, 04 Mar 2025 10:41:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741102861; x=1741189261; bh=CUomER8UGh
	8R0djCgtNRbBiY2Vq1uWOQVfDmQpLddTM=; b=YqA050t3MHQpBGQUp+Z/P2Ka8j
	geS1pG++EOmeFV7ZmjjxVgKGOoDZ2xIHLQpA4ItmRsK7leI3WIVjDOLtp79+9TiO
	oqPOYCqIpwRDwK0QVtLXzWBjqmjmydRz5JnXwYRdMOZyCBIoH0vzFTAu9QzJoHgl
	4R98/Y5BppXwL7Bl9iN2vM/wUnXWfA/RHUk0FMcD1gKYkKfPJL9eXPiKu2+XL7x+
	LLmCQfo4Xb6xG0hPb6F0WYZ6PQpltqqbyLrUmelGc519myTZyK6ajT/xXLBz1Hj7
	fc31sDGx+sSpStOh1pIUwkxqWwy082G4V2KqX+aqUROCsQBbfplDrA7cH2rw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741102861; x=1741189261; bh=CUomER8UGh8R0djCgtNRbBiY2Vq1uWOQVfD
	mQpLddTM=; b=y7nf9Nss2hO/Hvac8RhkeJ/RpK608MAlxEnyifuXe2fGJtkegrX
	Gw1PaOAh2SLJTQ3kC3804Jy934StTVzD77/ls/Yr6LliGAu4e7jjRPCh2fxbkXnS
	k1yLkPXHXplA5ZwyHpAXpTrsFHHeqEF56DwU+XpibalSdCK5//3cQBtzdZ3q0ffs
	rFIMTg8EhvQUDoHQCeOpJSUF2nRWT9aAUANkVl8uqsdW3u0+XnRGhLqJKGuHGcc2
	S0e0wETZwUkwnvrgxwcSC5nm2K9j2Gq9OTxjYttxLB5kbj44/mjZRbsPhPCauc5W
	rDUmn9ZIevepq2puuI2k08IWvzaPtl+dbxQ==
X-ME-Sender: <xms:DR_HZ1d27YaAJ7VjKM6TsN-mv7-CX4ytftu2VklZYyl0DS3X6OzxEQ>
    <xme:DR_HZzOpl52LR_IvdMdfyYx0CiIYZndwg9ALNvtBej7JOpJtuyXpbkegl0N9sEgrA
    fqsvj0Y_013ud3b9w>
X-ME-Received: <xmr:DR_HZ-g0-4d_RQAoBQ0X3a5ZWZz8b8XDr6U4ZG-iDcPpy0pLZXI4P3q6SjA-OEFbPx6ml6fSeKPw5DMxK6CrPEOROGKsuu2AAURi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutddvgedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghm
    rghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpe
    efveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepmhgvsehtth
    grhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:DR_HZ-9iQdJukt4POpza-UZ7pIh0hSH7-tsULB_Sen7MIBOdDkAgGA>
    <xmx:DR_HZxueUfcIyb7LQcNp8UJj-KeTxsHKbGr96TOBXM0Zql0ciM3NXQ>
    <xmx:DR_HZ9Evl01EoSgKGyk6Xfw4SvN-HmKtgl5kRK30znJAviXOYMaeyQ>
    <xmx:DR_HZ4OznqM12pcmNpYdSbBnIgxGYzhMANCjyPUnCnR0ZjUYIA1LZA>
    <xmx:DR_HZ7IP1Ez09ekgEyD1J7YB9vnUFSzJCa_s780HS2VwKpXzuj-_jUNR>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Mar 2025 10:41:01 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Taylor Blau <me@ttaylorr.com>,  git@vger.kernel.org
Subject: Re: [PATCH 01/10] loose_object_info(): BUG() on inflating content
 with unknown type
In-Reply-To: <20250304064308.GA1283901@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 4 Mar 2025 01:43:08 -0500")
References: <20250225062518.GA1293854@coredump.intra.peff.net>
	<20250225062824.GA1293961@coredump.intra.peff.net>
	<xmqqv7sxh3xv.fsf@gitster.g> <Z8EAXIHB4dVYS9t/@nand.local>
	<20250304064308.GA1283901@coredump.intra.peff.net>
Date: Tue, 04 Mar 2025 07:41:00 -0800
Message-ID: <xmqq7c54u7lf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> But this unknown type stuff is not and has never been usable. So I'd
> propose to keep --literally but always reject unknown types.

That sounds like a good way to go.  Thanks.
