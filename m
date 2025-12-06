Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3988C2FD7C6
	for <git@vger.kernel.org>; Sat,  6 Dec 2025 16:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765039116; cv=none; b=MTTy4fxEnTacIZaNxhzW+ba1w32HtDyqY6V/5hqkh/tqaYL5Qfa1e2ek2ljitRzxoGxuxUxNZE+9iiTO9wT6YI2kGArPiziLciZJIRO7ig2ioLi944OK4LCTQI6h4CEL7RgYgEnvNt9qXxrWFBhY5/dd8HvzzX5Ks6u04njToj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765039116; c=relaxed/simple;
	bh=BgxfRSMaBYh9tzWaPKwrg8WgrQr18khmEmFxt1gT+ik=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=j1YJJa1QaNJR3wTNwJrTYET1DMi6YL7786Y1S3j31tzJjc0wf6sdqZRof8Iz6ObuBD3rXnY9f6fpnGGg7x+iGdmOgJWbS8jN/8Fv/K+qn5KPN5/9DImnCawhw7mv/yU8YVz8Hqo4vm57FSL6LUe+SSe5H6ZAGDIb6UtjjwUsESo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=k0x5u4Yi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Osc8xPcJ; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="k0x5u4Yi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Osc8xPcJ"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id EA971EC0375;
	Sat,  6 Dec 2025 11:38:31 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Sat, 06 Dec 2025 11:38:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1765039111; x=1765125511; bh=V+GjRu5b3x
	2+UoFRhJPKle7mGjE0NmEY4aMuEN02clw=; b=k0x5u4YiswF0hyRukiqQZfkkxl
	vy/cq9KGWNehHsOmjqRtcug383n2SPmDh4UEAfIh/m+k9j521v0gkelGbiLeweAh
	XsiuQAPLN83YnviAca3iR9XA+R5RIF6pR9tqcIu9rrqT+pg9hdioFBHsm0/eJJou
	eJ4JKRV2dNpLT7dsQ0viImvKk4I55M1FB6SpzFpUFaB4JbnTCcwJ3FV1OhJGtZFF
	Zu6zSmHEzfxvlOoIJDO+CkUpyaAKqMdAt7qt3L2X+e/t5UdKhpEm+8B/vPKUvxpD
	62qjDMXHP0D/24XYlXLTQfN4pncF4wuKmidZNWcdbBi5HIcmOjgK38n4NGVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765039111; x=1765125511; bh=V+GjRu5b3x2+UoFRhJPKle7mGjE0NmEY4aM
	uEN02clw=; b=Osc8xPcJwKtBryiX6UFxesN9NfHyIP+32fdm8aJhfS+L6Kf/QXd
	+vXXX4IMdBtESNmbH72wTQe2QtamsqRdfTbkDh7B7ZWWwAmnIWbtowiGK/IJaQYT
	/0M0+WUTIhatQP2fdW192g/E6SFJJ+ZI4cU9h4717Cdzo1qz+gTzEgOKmiOw6Nl0
	myEP/zDq3T53ZHrhqMcKAFA5Oh74FEykWbW4m+xtnobzmSaEPFEtIvvyB21D0aTc
	dk2pdYoTH8cRewXaCp2Y14xDx0jLyUCAVVmzX3xk8kplKI9MHYv1u5ZImRiRm2rc
	BaSD5ih+/qg/umwiedwk2BVbO5ko2V855fw==
X-ME-Sender: <xms:B1w0aT1F_UrYvNNDlJOCuE8Eh_I3S0htLZEFcbvjSxBeLiT_sM8BCA>
    <xme:B1w0aYfHsYaIinsKqc7P2JJUYAu0ubvj7e4HSsOy54Q2nczGK5f8NY2PFSJVjsPaq
    mDp7iUejoNY8NTG1nC8JM1N__QVRem-9fTARATKgJ8qRsOIw_ihvw>
X-ME-Received: <xmr:B1w0aQJgWZI1v0Dmo5JKL-Yh-tCPkpFOPeMPCPssU7CkkfLyhVycKqi4NA0Id3hkcK-NhiKoKT5CyA1yexlANn2vmWnH-mF_1A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudeggecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopedufedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopegrughrih
    grnhdrrhgrthhiuhestgholhhlrggsohhrrgdrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvghmihhlhihshhgrfhhfvghrse
    hgohhoghhlvgdrtghomhdprhgtphhtthhopehruggrmhgriihiohesghhoohhglhgvrdgt
    ohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopegrrghroh
    hnsehstghhrhgrsgdrtghomhdprhgtphhtthhopehjrhhnihgvuggvrhesghhmrghilhdr
    tghomhdprhgtphhtthhopehsthgvrggumhhonhesghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:B1w0aWpMlT8oi307UoLsb5WvsQDBWt9YLe9B4soxk19SAfzqGjbBjw>
    <xmx:B1w0aevP2is3CvkexPu2YVWDyPgZQS3hW-5uYDMuV3FpWyx1jIwbFg>
    <xmx:B1w0aQL1RcfDlOnCz2rz02vM3bnQE8JaibdVau4-xaX_6koOMDxt-Q>
    <xmx:B1w0adoAr8YVSuWhq4IREBlqpQnH8o_k4NuJVUPG2_NciKwASRVC4g>
    <xmx:B1w0abPg2x2kmPznFG39dkDKvo6tm5-8zWnGGmRbUfP_xZQnW1hPRo1R>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 6 Dec 2025 11:38:30 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Adrian Ratiu <adrian.ratiu@collabora.com>,  git@vger.kernel.org,  Emily
 Shaffer <emilyshaffer@google.com>,  Rodrigo Damazio Bovendorp
 <rdamazio@google.com>,  Jeff King <peff@peff.net>,  Aaron Schrab
 <aaron@schrab.com>,  Jonathan Nieder <jrnieder@gmail.com>,  Josh Steadmon
 <steadmon@google.com>,  Ben Knoble <ben.knoble@gmail.com>,  Phillip Wood
 <phillip.wood123@gmail.com>,  Brandon Williams <bwilliams.eng@gmail.com>
Subject: Re: [PATCH v5 4/7] submodule: add extension to encode gitdir paths
In-Reply-To: <aTQanNSlj6VxDY-n@pks.im> (Patrick Steinhardt's message of "Sat,
	6 Dec 2025 12:59:24 +0100")
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
	<20251119211030.2008441-1-adrian.ratiu@collabora.com>
	<20251119211030.2008441-5-adrian.ratiu@collabora.com>
	<aTLNwHpLUcy-WsZs@pks.im> <87v7ikeng2.fsf@collabora.com>
	<xmqqqzt87dgj.fsf@gitster.g> <aTQanNSlj6VxDY-n@pks.im>
Date: Sun, 07 Dec 2025 01:38:29 +0900
Message-ID: <xmqq8qffpnui.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Maybe the right approach would be to tell users to never manually enable
> the extension and instead to provide a command that both:
>
>   - Persists the submodule gitdirs for any populated submodules in the
>     gitconfig.
>
>   - Enables the repsitory extension.
>
> If we had that then we could count on the submodule gitdirs to exist in
> the gitconfig, and if they don't we would die with an error message that
> indicates that the repository is broken, maybe even with a hint for the
> user on how to fix it.

I personally like the simplicity of this approach.

I haven't however thought about operational complexity, if one has
an existing user base that have been using a custom pathname munging
code that needs to be migrated to the new scheme.
