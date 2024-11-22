Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB071DDC34
	for <git@vger.kernel.org>; Fri, 22 Nov 2024 09:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732267032; cv=none; b=mQEoHzW7FlXkULXeOH2gFAm9uZcxXUUKe4cJuB/tarfds1yfk/ZZYpK6XLby6f1ydQbfmvF7c+5sEvoCfJQDTaLpmvPDS/NriyzaHoKiTzxPzp3P9tXfDUvZFCIArUHGiNU3cyrhuV3RhCCcSoq/BKSHYMWcF92BhMTlARxbJyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732267032; c=relaxed/simple;
	bh=jFD8tT6R8mdbU+z6ny4zOBfg1xuom69ssEqZROlEyQ8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=DyOtdvmI3UrVh7pV8Yk9AZEZHNBWs1u6i7r/RkZR9RvtJWGSUZZ1iGCdGO+AuvHQh3yMsVH0o+g0J6RnQjvsD5cDKWHlW4mKL5TLrabvXQEBDJkDw7HBCiYLtIGSzpYv/oFztm2ievhSDvRX4/R4yHxvuo/GXBBY0ZZXg3BRPx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Z0RVpAK2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rqlz+qEy; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Z0RVpAK2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rqlz+qEy"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B6378114010D;
	Fri, 22 Nov 2024 04:17:08 -0500 (EST)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Fri, 22 Nov 2024 04:17:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732267028;
	 x=1732353428; bh=jFD8tT6R8mdbU+z6ny4zOBfg1xuom69ssEqZROlEyQ8=; b=
	Z0RVpAK2CqdhjmmdhsyJcqxEMTNE1PH/1VxfwJa4hcF9BNe6CAjUpA5OSxCcGEml
	DI9j+/jBtn2iXo4K1PO9gud2Vh3kiJecdNVVLkq/xAY7t/jRocaortMjMmpCP9sI
	bpg9Pt/Gf/euu03VSkBZczCRVz0iDirdHc1Lqxde0yCAKK8BNNMAx4n69shS42Hk
	r0XRG/Dobtn7CLYFNWEZJ0gXroyAX4+qn4ZDm5bYW8IEFaujvt0nn/b9ffrUd0wA
	1yYhitcRHp+Us/UiRs+XmSQF6XUfEu8fyqncZb2HNV42E0vy29q65pUCQ8pZgwon
	ndj9Dobb5hFUHDmv6rA4BA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732267028; x=
	1732353428; bh=jFD8tT6R8mdbU+z6ny4zOBfg1xuom69ssEqZROlEyQ8=; b=r
	qlz+qEyAVdXdl+SNMQavoCwGb5SBhUX3GcJKDMiMb+TGh+TsjxztT19701zxEnug
	gwg7T1dI5iczQazK4jV/T04gXNbxDPI15+SEShm1QFs2Toong+2STjArZg6uoXBi
	QmAUQ8Aa8EWIeRJTGPrBW+8pkdrD02vA1wBjBzLybdJOYWUzoTSQPj5sFm4jv1KR
	J6XrccxK+Ux7CcSe2AdZ8b47REQATaO2Vt634IfSrlQEOvJDeF4qq0coYmYGwCbZ
	9105xTIEqjUo8efp6IH0bT6TWx8QZSVHN4y+OBewus/w6N6m9IfRmkh6H6Mt+p5X
	UOAr7Njdu41e/SVZmIk+w==
X-ME-Sender: <xms:FExAZzpNcOvJ6AEcjAbDxAt5_F3QYEB-s0kvJMkoo6HH8L8C8uH6GQU>
    <xme:FExAZ9oZoemG9_VsANuYwdXivlWChBkSmmKtrJpdFnGjkhU0st_eoYe4EM59LkhhH
    bfwj6A8vk77q9dhiA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeejgdduvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgr
    thhtvghrnheptdeigfegjeegjefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfe
    ekudfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    khhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsg
    gprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehnvgifrhgv
    nhesghhmrghilhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehmvgesthht
    rgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrgh
X-ME-Proxy: <xmx:FExAZwM2Kg_4ejtImnQnpmr4dMTEjibmva0oKHukTC7hrBAjl2So_w>
    <xmx:FExAZ24dJwuK-VdNBe1bmYOqFkYBSlzfVjqHXySbrvmKv8l4pvhLjw>
    <xmx:FExAZy4gxKXfXTKcpVZraqOF3MUbRy6rLcVC1aP5oVYFtVcns0vOAA>
    <xmx:FExAZ-ijudgcuYugWhhq9M_YpyIUTOW0kQy-KpspzK8fw5zGORx9Lg>
    <xmx:FExAZ901oYMRoq6AlTqGIQeUrrIFLnLyL5WvYRuGvBgOt9HBDn0uJddD>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 80074780068; Fri, 22 Nov 2024 04:17:08 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 22 Nov 2024 10:16:47 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Taylor Blau" <me@ttaylorr.com>, "Jeff King" <peff@peff.net>
Cc: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>,
 "Elijah Newren" <newren@gmail.com>
Message-Id: <9aad5aad-707e-4dcf-aa8d-8b3c82724133@app.fastmail.com>
In-Reply-To: <ZzX9vT4GVqCyfFUE@nand.local>
References: <cover.1731518931.git.me@ttaylorr.com>
 <2520abf24a8a194b3f7040e218f878dc88a740a0.1731518931.git.me@ttaylorr.com>
 <20241114002504.GB1140565@coredump.intra.peff.net>
 <ZzX9vT4GVqCyfFUE@nand.local>
Subject: Re: [PATCH 2/2] pack-objects: only perform verbatim reuse on the preferred
 pack
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2024, at 14:40, Taylor Blau wrote:
> On Wed, Nov 13, 2024 at 07:25:04PM -0500, Jeff King wrote:
>> I do think the explanation in the message of the first commit would b=
e a
>> lot simpler if it were simply combined into this patch. With them spl=
it
>> you effectively have to explain the problem twice. I don't feel that
>> strongly about changing it, though.
>
> I always seem to go back and forth on that. I feel somewhat strongly
> that for complicated regression fixes that we should demonstrate the
> existing failure mode in a separate commit with a test_expect_failure.
> That forces the author to ensure they really understand the bug and can
> produce a minimal (or close to it) reproduction.
>
> It also makes it easier to demonstrate that the fix actually does what
> it says, instead of assuming that the test fails without the fix appli=
ed
> (and passes with it applied).

I recently made a parallel branch for a topic where the parallel branch =
had
`test_expect_failure` for each commit (i.e. the commits had only `t/` ch=
anges).
That ended up catching a bug I introduced when I tried to simplify the t=
est: the
test was OK on my topic branch but didn=E2=80=99t fail (`test_expect_fai=
lure`) on the
parallel branch.

I use a worktree for `master` so at least I didn=E2=80=99t have to build=
 specifically
for that branch.

--=20
Kristoffer Haugsbakk
