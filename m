Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB5B27A919
	for <git@vger.kernel.org>; Mon, 22 Sep 2025 18:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758564758; cv=none; b=FVurFQMqj3fek7dpWvftiOqCqRvbNjtStmbi7Smntf2Q7yo3IRyk1QmsyQzNvSsD5P900Q0vDk6J8c5nSg585eyRTtolyX6V5aRyyLYuo4/7t2CF27FKI/vSTifYFkowq1DZnFQWyUFY1USUEux7Kfozbr0qZOju9e0yo0e6fqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758564758; c=relaxed/simple;
	bh=m1vOQ6GUAUKPApNNAE+B6b41Y0NaPczB5ZUAoauGTqo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ThyXM3LWOz4HFtZTfAiJ+8g2EW0jhENgs6wg8qT4fEZWjYpstlTutMBDy3/b+f27/tbIqwoQqiC6nKloGipCxIsnwJYPnc8k6oSO3Ra50wAiiKTE8Wo0raOuLDluGEmBLG0zXytCFHQVH5yCLcDy6D7sM2NN1ffKRKwO+5eBEEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LgX165h+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NFYAZCIk; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LgX165h+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NFYAZCIk"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E982B7A0136;
	Mon, 22 Sep 2025 14:12:34 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Mon, 22 Sep 2025 14:12:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758564754; x=1758651154; bh=m1vOQ6GUAU
	KPApNNAE+B6b41Y0NaPczB5ZUAoauGTqo=; b=LgX165h+diEWuHYTCvkGrtDdUx
	Yby3/Zg/yPdgH5sPx1ZG+NUBOqX90+ZJ6yAMzvIBFAkCvjZzxUZfRHoaLdCJ4ht+
	vmX1YsmarblEm5c4qZFkph7MZ2m+HUBJwsiUZ36Wb+aQATJABYf3VVqOSbDQg0wu
	2Yw9IxF/99L22qR8fj0oPwm4KY1DfLp31lLB7LDHyq+WBSYgwYwLiBU4lOmHQxvu
	iJQO2wlQMFzRYetwf/ycdvPiYUO/twv+OPPUBc8gDlsiYHGobXHn3L3P9UYmpk0M
	XurZ5dPbcmwcRIifb0y7s0sFu6K3UHRfuhgNKk5dFXJ1ch352Bn9w72tiJng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758564754; x=1758651154; bh=m1vOQ6GUAUKPApNNAE+B6b41Y0NaPczB5ZU
	AoauGTqo=; b=NFYAZCIkkYky6lK4w9oVMeUPrl0sPSVuJ0yGDjRW1SjPhhEdj1s
	/O8IHLmH7iXP2bXuZWz5KfNTuYAGRB1r2yD105lIzRflim2a1JTdsRPTqbnKo2oA
	Ux8kX9Zl6ZX7uAOp0uL/rNibxlG7W36cvGPbwmWt2YpybPYFXVFsglTd+jwcl8Pz
	IIGt0SVSLNarG1bgrf5qXrVuI5l8Fn8XjVw8zhzg9uK4rsblfJlsED3/qpIBCcm1
	12vHeri4NT8hrhanUdIzl2ehdpf8hT1ikSxM4GQ5NIEXrcIc7MoZXwsIgn+R1IuC
	OOiiW5xKuNkaChugdV4gAeDP9dXvYNnSYGA==
X-ME-Sender: <xms:kpHRaG7JEeW3_HtZFZ-OJ30lXP6x8A7tDG1rZ4yEWHaw6AJj-I7mBw>
    <xme:kpHRaGx-ILRpDsYxiezfSKSj4thWgtUsEAh7yrpsXnUe_1gIhneHgVr7m0JHIckQ_
    gfTIIwn54vtOBlpwhEYe_2xrMNMNOU13Y6mt412JfiaMzw1b5M6cw>
X-ME-Received: <xmr:kpHRaNxuDboI_Ti3UmJig3XjxxwDC_Kaw5jnKtb_Kf8YFgTPflGsB2vPzW4WhniVyL-oO5HGeDc5MguVfsuov2Spg1Jrzc9zS0fR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehkeehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegviigvkhhivghlnhgvfihrvghnsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtghhithhgrggu
    ghgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:kpHRaOwFw8lL-UYc-d3c0AjBNDreeDbWI39hRJtR1j8oafWU4vLi9Q>
    <xmx:kpHRaHZKAXLTGFT-4iWGgqztEMQVLJ1iNciTj_JiZ9PxoZu0AEfHNg>
    <xmx:kpHRaPURN7BErlVK0hXtPcLQl7MmBLnHenhiHFb5O4I4l15nldLNCQ>
    <xmx:kpHRaFgLqtueXyxFwjb5NxiQ1-HGsDiUwobT-Bm3D-ee7uKoQGGSbg>
    <xmx:kpHRaCCHPyP9tNuNrSaQZvcjNLa6NcI1Qm9cFudnpCi9G5-ubcmre5eF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Sep 2025 14:12:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ezekiel Newren <ezekielnewren@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  Ezekiel Newren via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v2 00/18] Introduce rust: In xdiff
In-Reply-To: <CAH=ZcbCsKdZAPxBEPUMvE471ogTNptjFy7FFksWnJfnX=J-F2A@mail.gmail.com>
	(Ezekiel Newren's message of "Mon, 22 Sep 2025 11:23:39 -0600")
References: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
	<pull.2043.v2.git.git.1758071798.gitgitgadget@gmail.com>
	<aMpODEpyaaVhFMO0@pks.im>
	<CAH=ZcbBNFSwU7E+P7hkQnt9UrMKiCRESgGvWPL7pRUa0i2U5-Q@mail.gmail.com>
	<aNFIozagGc0MoseL@pks.im>
	<CAH=ZcbCZXavx52521cFHdXZn=BCWBiR1aG10ekZVg3PVVJb2VA@mail.gmail.com>
	<xmqqikhav3i0.fsf@gitster.g>
	<CAH=ZcbCsKdZAPxBEPUMvE471ogTNptjFy7FFksWnJfnX=J-F2A@mail.gmail.com>
Date: Mon, 22 Sep 2025 11:12:32 -0700
Message-ID: <xmqqv7latkz3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ezekiel Newren <ezekielnewren@gmail.com> writes:

> If a field in a
> struct uses u16 as the name then Rust won't compile, and cbindgen
> can't create the C header file.

Do you mean that cbindgen fails to help us make a C code we have
that says "struct { uint16_t u16; }" to work with Rust?

Declaring "typedef uint16_t u16" would not help such a case at all,
as it would not make "struct { u16 u16; }" an invalid C, and would
not force us to avoid such names that cbindgen may have problems
with.

So regardless of what to do with type names, we would need to adjust
some variable names to avoid clashes with Rust, which I am fine with.

> Using [ui](8|16|32|64|size) as the type in C also spreads
> awareness that those are reserved keywords and should not be used
> as variable names.

We certainly need to train our developers to avoid problematic names
like "u16" just like we do so for "new".

I am skeptical that using u16 as a type would have a good chance to
contribute to that effort (otherwise we would have added "new" as a
type to solve this issue already), but I am willing to be talked
into trying, with a few conditions to prevent unnecessary churning,
i.e. We do "typedef uint16_t u16" and friends, and new and old code
that are written to directly interact with Rust written code would
be better written with u16 and friends, so the same thing is called
similarly across the wall, but we want to avoid replacing uint16_t
with u16 blindly.

