Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3211D4C6C
	for <git@vger.kernel.org>; Mon,  4 Nov 2024 10:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730717192; cv=none; b=dX69UuhHpfqkc61mYGzCRbXrHU/espcMczTMGw/bEokQHUDacuN6hYddzdVF2HSXqk8pfGxV8pO1DSaXJGp88moPZlRPFjXaiJYIfQJ2zBz+cb4LfIeJflBlhdr0dwg31Ca+rJfVljdya6v1ig1SxMtQkn9Zut/WJtW3WZi0adI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730717192; c=relaxed/simple;
	bh=0xoDAToUAOac3w7WwVpFz8zN/rRTq8P2Y3t8Od660i4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=QIb2qo5WTNxRQyY+eJBD6qc0SIL6Kn3VlSHyKhCBYOcknruDlVA7no3+eRFgJJg/Sm+M5HLoQNbT1bpybq4EEXK4Aqfay2FUV+XTnm+6P9PeTVPHoSwNg6qiZucnzZEOlcaC/Nmg1wIaX8RWAOfD7DNVi/mhN5O9ItKzmi73flM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=R7g1xjur; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K5GTwMWa; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="R7g1xjur";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K5GTwMWa"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 3E94D11400EA;
	Mon,  4 Nov 2024 05:46:29 -0500 (EST)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Mon, 04 Nov 2024 05:46:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1730717189;
	 x=1730803589; bh=1SR6FqCCUGYgg3fA+29B6X/le4rq8MhBv1H7twKL6CE=; b=
	R7g1xjur9rfrC2dljWp23x12JH3MIydi3F9Au8SJBGBwyPcTyFgYFBYhi08WLqqO
	WQZFCCUV7kTRDRXPvZiaqlYZ9S69Sdv3jLrap4H2ZSJWjX6RDTvDW+5hlLvKvt0G
	rOhkGr6AlPU064XnzOQu1qW+stqw+qLhEEjyN1npiY+UqI9MNbbPKwchTd3pTmYw
	scSn6mLUmMHMBbQ07APwoCE6FG4BJg9XCsR4jFbVd3ca0WMdvE4PCAvpykwczoEh
	w0TxrR4fnrNlkHAbpQaM5cBdMj+LM/kRiBtUeAr9QHr2Gcq8iVTLvyQdtXYVAe73
	th7YIZDZin3FN8GOADUDuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1730717189; x=
	1730803589; bh=1SR6FqCCUGYgg3fA+29B6X/le4rq8MhBv1H7twKL6CE=; b=K
	5GTwMWaxp6yaMQSrgQZC7rPPRuZUeRSutT4khJQXKLYXzvnBj9NBFuy4GjTgDIts
	mkB7PA6r8+/KevZWzq7GEIzE/kMaqIQymXeICWaBhKa5nXxbDydyypuHko7fDrMl
	jDuR3EsXqZ3KEgtm8n9SNKWUd/jBKEHfaE3pvL3NcnmhrPIe2OTpS3I/1yF2jMqL
	amA1E3RFHvBHQVzDSriETlzNxGiTOWbqorxQiv8Wr3tps46THHItbdCclN7iR7s4
	XAlGHP62C3EPO6KsS9V5vnnqNsuS/pV+FZkCXksmsxFDGYk/6USPV+LPtkaIh26B
	MgZFI2bylLZzCh7Lv2GpA==
X-ME-Sender: <xms:BKYoZ0s4Q6YNNsJhaFFHpnUC34GcOqBNy0dKEuk3m9bQZa70Wmb51d4>
    <xme:BKYoZxd2TGY8PyqO0rxOyKvniiF6n10Xah4xSJR5i1l-q5_bFdjVx5eMciQIeWF3p
    auwzgrBhOXTQiP9PQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeliedgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgr
    thhtvghrnheptdeigfegjeegjefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfe
    ekudfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    khhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhk
    shdrihhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:BKYoZ_xJOwdNERch6nn6VLIEwU8wbsU4ZDWbwhsMuhEbuVDihUbEJw>
    <xmx:BKYoZ3NU6ll9YdLXVLnmo4KNWq9eUsGVELSxtMCE57mmlj9gqGSfNA>
    <xmx:BKYoZ08L7aB3lI2gjS2tONxCFngVdgNe7LOD5IeYBfQgqCI9xZ3-Kw>
    <xmx:BKYoZ_Vm0eyh2Ugc9oaozjGtrFOOgtvXPwnYIga3IteWc-AQl0ufHA>
    <xmx:BaYoZylbnt5dRRBHB-Xl2TWW-jl1Q8TRoUYqHCdeKBToeSjOusmjZe7c>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D0AB4780069; Mon,  4 Nov 2024 05:46:28 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 04 Nov 2024 11:45:59 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Patrick Steinhardt" <ps@pks.im>
Cc: git@vger.kernel.org
Message-Id: <4e3c2840-37f3-43f8-9d8a-b4a106d8d18a@app.fastmail.com>
In-Reply-To: <7347e29a-f33e-472b-b993-06c4767a9456@app.fastmail.com>
References: <174f3704-6319-48f9-955e-b36a25836e3d@app.fastmail.com>
 <Zwzvgby2_oCjQpii@pks.im>
 <7347e29a-f33e-472b-b993-06c4767a9456@app.fastmail.com>
Subject: =?UTF-8?Q?Re:_What=E2=80=99s_the_intended/reasonable_usage_patterns_for_?=
 =?UTF-8?Q?symrefs=3F?=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024, at 19:23, Kristoffer Haugsbakk wrote:
> On Mon, Oct 14, 2024, at 12:16, Patrick Steinhardt wrote:
> > [=E2=80=A6]
>
> Thanks.  This makes sense. :)
>
> =E2=9D=A6
>
> I discovered/re-discovered a pitfall with the following approach:
>
>> Create a `refs/heads/<symref>` which points to a remote-tracking
>> branch
>
> Again, so tempting to do for me because you get a shorthand via
> `refs/heads`.  And this is indeed fine for read-only operations
> (effectively).
>
> But don=E2=80=99t be careless and do something like commit while check=
ed out
> here.  Because you are checked out on an ostensibly =E2=80=9Cproper br=
anch=E2=80=9D (not
> detached HEAD) and the remote-tracking branch will move forward with a
> commit.
>
> So I=E2=80=99ve gone back to using one-level (root-level) symrefs with
> all-capital names.  Because git-symbolic-ref(1) allows that and I
> haven=E2=80=99t gotten any weird warnings from it.  (I would presumabl=
y get
> warnings if I then defined a ref named e.g. `refs/heads/M` if `M` was =
my
> top-level symref.)

Another newbie mistake.

I used e.g. `H` (root level).  But then I was in a worktree and
discovered that these root-level refs are per worktree.

But this works across worktress:

```
git symbolic-ref refs/H HEAD
```

(Or `refs/h`)

--=20
Kristoffer Haugsbakk

