Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509C51A9B46
	for <git@vger.kernel.org>; Mon, 13 Oct 2025 15:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760369894; cv=none; b=M3n8eVnhRi1xbcTijzuaN6ZSQT+RZx8lYnhIiORJ6EFUQUto6rDReGPXHkn8ecfVHZE/4jopN3n/E4+bDMV/ePcv2A9u8SrOgYrnOMdSdYofFC6YHDvnQ20ZMkjzij12TMyGOxDp1a2TIDjtdDmH3NHZSQ7YW8Sqb7DIgeuHZjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760369894; c=relaxed/simple;
	bh=WES5kwQobJAen/qxRECh9Y5z1xyt+uKTrR5yXMTUNLA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g2eKDqZYUkBW7LiGD0+8F3Po9Lmqtd9xlWnq9U/6h2JXGg0pjCaDFyy8YzPpTkfA5FW/HisF7SPg852DD4JL9GdFP3sNpzBkwxbnhl7ilV3TMBR1Aq/tlxP9NPvP1YktQlsJyPE4AhILMy2Gl+f5dCTLlYvjgA+5h4HvK5rzCHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RDvLnIrl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q7huixwC; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RDvLnIrl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q7huixwC"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 806EFEC01C4;
	Mon, 13 Oct 2025 11:38:11 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Mon, 13 Oct 2025 11:38:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760369891; x=1760456291; bh=Y20RipWEGF
	IXicqwsZ6SEw0Cd2D7vqs/wagu0ymNy9Y=; b=RDvLnIrlCtByLb7M5f72MBM9la
	wZJF7mXxjDHavpPppukauCAkpfJvif72vcO+O6biC/hNiY0PCKcH93J4dbXg3OR+
	jQ6XlyQzeInhGMAiFASjpljmoIBurZveo7dKLTl6qipZfHNxU5KE0fjxyDrVp3bq
	CLMmNZHynO3Rsn45v3ptoLL7SPD8ATofdApADqw8aytlqbuM7V3d6trxDhXxWnFs
	JQqUHgE81Xg/cNmeONYRhaH5hCwHa+vLJPM/qSQM3BlXfr9ZwgpJLIafojbKB8PC
	CCRB+1wM+Htu2K8MvinIuIqNK6lhYnzBJoqj3w6K2l5CXenKbd9NBlp78vRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760369891; x=1760456291; bh=Y20RipWEGFIXicqwsZ6SEw0Cd2D7vqs/wag
	u0ymNy9Y=; b=Q7huixwC8XU3NhMVP9kK/Qio5YGSTAGJl78ffUnA4Ni6HU398Mw
	ZSnbv7Lt6Q1R4VTnTPW7yu1zO+ADOR0b2XnIE9E81jnW1CKCd2lMlxKrO7IXmI85
	cceHCKY0Y9TCRURalZcnGm2Rpg28rtTaPCHDufu94XDun/3MNgQ6a24qocV4Y1yU
	hC97kg2mZbUUQ/EA8ude4zldXGD7+I986Mi9VhR+LLqVwsI2jKalrEU+Ud7Czpp/
	1nyOnD80ByKK0wce1ZgIAxlIkAE6KNEc0yykhotJrTcYv9t5V50C1394aE4sk9b+
	EXl+D0gdBEqGu8QUadYLYR8dH98FVtJIMgg==
X-ME-Sender: <xms:4xztaKurGZmK9ScqPEnqRg-xOk87B_vmrtKAyor57c4sjubtpGPjcA>
    <xme:4xztaGWg-uaCp43OXLh8MPAxfo7AsckgpDur_KIYbIyR7JwwYolw8KDuX7O8i1FOt
    1YpadsYkEr4eDShb8OMclavdP3OnOfCgZgkbE0FDAM3YwNE3_hxo7U>
X-ME-Received: <xmr:4xztaOGb_5pda9Ijf5RlGhebL4M2UKnSDjQ0dwv8YG28II8craaMhDZiA4ppxwzxRRidRr8lO_sU8sf-khX_ZUDqnPbD4jFslIUd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduudektdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrlhhgohhn
    vghllhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthho
    pehtmhiisehpohgsohigrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:4xztaA2v7vszTOBRo7cfTip0cdrW38-yj5i0kuwXF_mO_RjBswddiQ>
    <xmx:4xztaIPz95D-F7CUI0tATssXn-0CiEsxPCXrZ6blhnZVQPithWHLFQ>
    <xmx:4xztaH66Gpn6YMfd7DWw4nGCkr-xfxwH6TphMNn7kzi6AR0q7Cf69g>
    <xmx:4xztaK3jT7pdvf-EYK3SyIdiAZ09cfX9Y1nbPaMx47ySb6dtK0oIpg>
    <xmx:4xztaDPa5WLxkp9vjuQ3aSjXBC2lf1Ujwlpnk0rjZrsfXP90BBdJKG6p>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Oct 2025 11:38:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Andrew Kreimer <algonell@gmail.com>
Cc: git@vger.kernel.org,  Taylor Blau <me@ttaylorr.com>,  Todd Zullinger
 <tmz@pobox.com>
Subject: Re: [PATCH] t1016: make sure to use specified GPG
In-Reply-To: <aOwSIgswyQwr1FGy@void> (Andrew Kreimer's message of "Sun, 12 Oct
	2025 23:40:02 +0300")
References: <xmqqsefq7947.fsf@gitster.g> <aOwSIgswyQwr1FGy@void>
Date: Mon, 13 Oct 2025 08:38:09 -0700
Message-ID: <xmqqms5u3j8e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Andrew Kreimer <algonell@gmail.com> writes:

> On Fri, Oct 10, 2025 at 02:14:00PM -0700, Junio C Hamano wrote:
>> Go back to use "git config" to fix this.
>
> Apologies for the mess!

No need to apologize.  A bug in reviewed patch is our collective
failing, and the author does not have sole ownership of it.

Thanks.
