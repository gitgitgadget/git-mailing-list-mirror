Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A209EC2FD
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 00:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742257724; cv=none; b=Io4IkBrBlhluTbP6zxFc6WeRCzIXIknBZcoLyzEjhNcX488qth5OEWhjJupmxgIH987lccPCKmsdQIADiKhJWlkrbUnJT91lc/KocVpS2QJ3l84fGcZ47KvJiKQ9XR6nipJ4RAM9oVlkC+La/W3N32Hb9vhRE7e1TKX3lT1vetU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742257724; c=relaxed/simple;
	bh=DvcuQ/JhVaCTNCMX5covBbnCi4xRJp9Ml46y8LKhB6I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FibsQlYDVtO1u3AFsKGSS71nWbniyGIPYyQW1FGUPaWM8mpIeHHEwEVTXhJzh9OgCR035njAaHRX6izhLdFhVB3em1FwHAIv1CLmKyA5KeM3eGNtHfC1sOJyihJtKNfvKI816AO+yFATHNVQeSYua/iz4mpBf6uKyEx0g2sraSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=V2h5jbr5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BhASaug+; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="V2h5jbr5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BhASaug+"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id ABB7C13833D3;
	Mon, 17 Mar 2025 20:28:40 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Mon, 17 Mar 2025 20:28:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1742257720; x=1742344120; bh=Z1uxqVFkYA
	6TdEU29pgpEvm0+KDevM5d9NEvlR6skGc=; b=V2h5jbr59gAhmYAmeH4QN1DQIj
	NOEcRxNg2qRxh/LXZUxjJEiM7Zry50Wg4zBmHz0sN4ziREvA3T9JvhJL3Ib/qY0w
	nA9arUL9GbYGJo59XXDwB4TUpM7WyW/Y4gqBBZXfqhf9cy34E4sMxlYdLWDcK/dc
	D9OeuaKhBRmqWJxIYc+LUU7bw8KN8aoF0BpXF8Zai6vat1pM0w2c9AZC/Nhx0nwd
	mEwC1gUM8Tycu5BlALbsFhmX+3JMVOkbjgkKaY702heFwpl9v85RFV/Ypufe7Mnr
	Qs+wDITIf4xrrF7BQe8KpjUspxWYmIMgxPN3ZfSlZ0d1Z9P56p5aK4OUZnlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742257720; x=1742344120; bh=Z1uxqVFkYA6TdEU29pgpEvm0+KDevM5d9NE
	vlR6skGc=; b=BhASaug+UA+dmG2iZljfbYHASoYquPSDDuvirdBvQql6Y/zDo3T
	pENpgKpKAAgP6ikNdVJznNgBg9fskzacxgSWqT9HYCboTCtTXVn2z5/nGd6n8GrC
	oYL2U3iRL1bjSul1j5vIEB2gcGEtKYBzPmahMomeCI7ubRMKYCiek7nQ90kr3N/q
	UK0EZgsImpWmtdTQWtNAz85mgiT3/QJCsskICPAVP8VAUX4LIqdr0q2khxaxh78o
	OIIS8nR6DLrRFxEe5cHRTRs6PSYSYIbXrxWobIJeRTmLZPtx+0DvN38TDeBR8K4Y
	DivtUAHx4/AUjjl9YEC8dhgVjfcVc0oZScw==
X-ME-Sender: <xms:OL7YZ6S_cm75gyeyW1S5B3INntPuA_GTRhFSvk1-j5Zf1wvVp6CFPw>
    <xme:OL7YZ_wML0riod6J65qgjXOnUQ4TDQSt8oP1u6M8UmG5hAfkm9hhlJ1GuUVZ3ZlC1
    CyKRRAHpS6Z5rbs5w>
X-ME-Received: <xmr:OL7YZ31HY1O-cOe_OJFBVyNUFZFEf2knVD_P88U5pCctoAmjgOTmAWZZKKZNzqFpi-oAzKEz-42r-0tXctgZAbNQEnO9ahSmthiqVNo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugedtleejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghm
    rghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpe
    efveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:OL7YZ2Aqn0X-jhmK7CqRtj6i1mqMLEz3sBsOV6NI0u2vOfWculYuew>
    <xmx:OL7YZzgPmzGLYBlFEGQ2Vk1wqDNXCDvnH1JpQgcfIXiuH-lCso5O3Q>
    <xmx:OL7YZypnOId_zRCVraZVg2RHGGa-bhPi729TlvHfHW9MZIdwaiNo2A>
    <xmx:OL7YZ2g6CTme7_m6PcMCWdFHZedBYUk0R_hOsO96vEFyu59PGZECaA>
    <xmx:OL7YZwvIEltIhVuwnCi3al5M_eTdWm3GFBQTyeHtmJCQY3ISilbWoKjg>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Mar 2025 20:28:40 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 2/3] git-compat-util: add NOT_CONSTANT macro and use
 it in atfork_prepare()
In-Reply-To: <20250318002012.GB1470172@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 17 Mar 2025 20:20:12 -0400")
References: <20250314210909.3776678-1-gitster@pobox.com>
	<20250317235329.809302-1-gitster@pobox.com>
	<20250317235329.809302-3-gitster@pobox.com>
	<20250318002012.GB1470172@coredump.intra.peff.net>
Date: Mon, 17 Mar 2025 17:28:39 -0700
Message-ID: <xmqqh63r5gi0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Mon, Mar 17, 2025 at 04:53:28PM -0700, Junio C Hamano wrote:
>
>> Introduce NOT_CONSTANT() macro, with which, the developer can tell
>> the compiler:
>
> This name looks great to me.
>
>>  compiler-tricks/not-a-constant.c |  2 ++
>
> And this is much better, too. ;) I see you dropped the "a" in the macro
> name; I don't know if it matters much to do it here, too.

Good eyes.
