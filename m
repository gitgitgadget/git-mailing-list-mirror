Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A5B21C9FE
	for <git@vger.kernel.org>; Wed, 26 Feb 2025 16:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740586227; cv=none; b=QQ3fhSkuLzbPCP7oVxVnndrq82rtGPACLx7CKhdPohSLBDN/q8DO7KmW0Ioe+J0yBnNSyfIDbm0+icch+j3OAHs9SSqGEr2Hry0aTxhaKd5HS6hNsJt4VDJ3R1ehIqerNydhAV3dx9s4Q4mssDwBywCDmfkfaChghF59NlaMEnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740586227; c=relaxed/simple;
	bh=mlV6BsMI/vq2X9B/mFOklKUf769kXb3tojy/2o77+bE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LFKc6KApdt78c8ai00TdhbPXaEWlXJoFk6Vb8ybs7clGPAs/2r+/WK1ne01oYFBSEc8RnYad/UZECGWZCx5erGB8PwBclzaDABXoxo9Pm6hrV63SYqF0RE4NhnBGrpHOBwbMkQ47KOaf2iSpGcwYGc2j1qnizaak4GYdTCSWVxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dGYugWOj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=2cYgxp1g; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dGYugWOj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="2cYgxp1g"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 5C64613813F2;
	Wed, 26 Feb 2025 11:10:24 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Wed, 26 Feb 2025 11:10:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1740586224; x=1740672624; bh=XKItSxzjQj
	Fs6jHD18rtz95tTZeYAiGLOPvsHRqf1fM=; b=dGYugWOjQRZOylnzntD6nwng5R
	nMqKx7/ih3doh6bvs9VkYxoQ7bflNhUwd4saJXtkBOYpgvVFlJc7Zf7ho2AR6BGl
	7PgInfJ+nwDnMIrUykoGLPgBr6ekBPcwZkdSAVIG1u1XshtvFB7mY6HflDwMvV2u
	Znny0nXpXSpxy44SX1Wzq2JX5MvqiX172W/2eM/GieNu3cLR0WTh5HRhagW17bky
	cb95kK9H27w5W83J1iVoe3/s7BF3krqfzwhuMB/Y3r8O2KBP2NJMKLKaiooDbl4E
	CMtsxeZfdxcGjsZh2J57CnOnbkYMscybQDGUXwNQaQsN9Ri2X+LpSaJaVYJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740586224; x=1740672624; bh=XKItSxzjQjFs6jHD18rtz95tTZeYAiGLOPv
	sHRqf1fM=; b=2cYgxp1g++2i9VXe6OdCYSCQNUg/cfcMyjTe2fWWA4WMetv79pg
	52MRThrff5KgXr50LErdhr1YLNVg6xBLheH1owvgal10jAQDq09oDu2BxEznmG0L
	o2dbAfNvdccUN7lEEqcpOvt0sQR6cKm65G1QUXAUdmdIC2FCjo9gijVV0BZjib6r
	J+q4A1j0lIte5gQoKogOO7lkLj2tGPyDUJi2kH/rU4VJh314BqBEB2/tRjVMuhKl
	UzZezfl9LWHszLlAAC/VOIW2jmaGnqzkbhyvhJ8XIrTGM5IQnGxQd/6txb1e1udf
	m6fnR4bLJfN+qvnYP9EWeEXdDk+pbAEaSeA==
X-ME-Sender: <xms:7zy_ZylGreitSFiQRsTFT1YIQZIDupzj1Z_7XB3d4L1TABp-9mHNqw>
    <xme:7zy_Z53RkUJqazouWBsaGoPByXY8Uha5K1KEUsUiZstwimKBBeQ8jmG76kwhlGwSj
    3j6BZBijFfWZP5wzA>
X-ME-Received: <xmr:7zy_ZwqmhbQwEaLc7cARLNomTzoxjBMNazmW-N5E3eAJSgBkaSwGJJSh5-oheTJXd3fhKGyifk5xmUKLuwyNH_WOXsdX5LuedepH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekhedtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrih
    hmpdhrtghpthhtohepvddtvdehsehugihprdguvgdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:8Dy_Z2kaMPIFLVdf7O2EVcswB-ArDAV9hG7_RmMmpKxr1MMBhPZ-ug>
    <xmx:8Dy_Zw1ZRfnM5U1lOxIpntfxCe8uDREsQbKlsmXix8tE_cP8pN44kw>
    <xmx:8Dy_Z9s0a0_32SUaSRUVUasIeddXc3Lx7nEZaoWTc3qQnAfLYSClWA>
    <xmx:8Dy_Z8XUozjB6J8ubJC3wghKiuQayJbcDHOGU4HVcND0D1HmIj_XdA>
    <xmx:8Dy_ZzRXr37STBAQqkg7WJ-KosvG4VIdQlAGyl8xkUYbxk_jMkNuL3HC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Feb 2025 11:10:23 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Markus Gerstel <2025@uxp.de>,  git@vger.kernel.org
Subject: Re: 'git gc auto' didn't trigger on large reflog
In-Reply-To: <Z779d7SnW5j8XcOb@pks.im> (Patrick Steinhardt's message of "Wed,
	26 Feb 2025 12:39:35 +0100")
References: <e650f4e4-e267-4f1f-bb3a-c71b1fe0b276@uxp.de>
	<Z7xQey4S0ewT5rs7@pks.im> <xmqqeczn70pg.fsf@gitster.g>
	<Z779d7SnW5j8XcOb@pks.im>
Date: Wed, 26 Feb 2025 08:10:22 -0800
Message-ID: <xmqq4j0gg00h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> No, there isn't, and computing it is also potentially expensive. You
> basically have to iterate through each reflog and then also iterate
> through all of its reflog entries to figure out whether anything needs
> cleaning or not.
>
> But probably we can come up with clever heuristics instead that don't
> require us to be this thorough. We could for example just read the
> "HEAD" reflog and figure out whether it contains reflog entries that
> would be pruned.

As we should be able to "seek" to implement HEAD@{2.months.ago}, I'd
imagine that we should be able to ask "give me the oldest entry in
your log" to a ref.  Ask that question to a handful of refs that
have been most recently modified (with the theory that a ref that is
more often modified is also likely to have been touched in the
recent past---your HEAD heuristics is a good approximation), and we
learn fairly cheaply if it is likely that we have entries to be
expired.
