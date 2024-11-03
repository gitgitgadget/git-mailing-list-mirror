Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F87171E6E
	for <git@vger.kernel.org>; Sun,  3 Nov 2024 15:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730646276; cv=none; b=COe+oA3OzngTmb9I9NvtYmU84mEEnCKpXjZw/w60HZlEjyHaSofRLqlLB8SE7GAMYqJ2GLzLM7h3lbEfZ6eiwmLkYreckjVZ28I5f4hupeTtFrOZRV/nBPugtqrzXWGU8cZ6k2CHqk5JiIg4nAzAvjDbbUzhD4WzJ1198pZIxNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730646276; c=relaxed/simple;
	bh=J+a0UUftqROBwajnshC12Sa2aTPYt30YnJ80Xk1Dm0o=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=phWHXccTD74gdThqgln8kkNTxudqWBBs7fEyJEnsktEbcGJ8NBWcZpEQfCokIZFKL8Vk3D0RmUFMmibg5kZh8aR11vhNArLry2zV1HKv+gXDATyC122PAshQmaJZUZDF9wCe37g4RinCrXVzazuutDafEc+jq28IC1j4SFh0rAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=RQ63lUIw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j3fQ+gYT; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="RQ63lUIw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j3fQ+gYT"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 8F2161140121;
	Sun,  3 Nov 2024 10:04:32 -0500 (EST)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Sun, 03 Nov 2024 10:04:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1730646272;
	 x=1730732672; bh=bYdraotLRQOkkUzv4QuIYvTKe3Vzkm7ORbSyLv33vr4=; b=
	RQ63lUIwLQkq9mKFHX6nfuL3kX/Lb3vxXhCEZ4XCdjo2yL6smLARaMvhr7BAdpBU
	MpG/suPpZ9KOshSD/iIoZllJurQvm5N9kReiiyWUk/WSo84kAA254whxTlzhrucb
	uZFAEUMzk7OFRucjDX0T8q1OwTeHenW9OBCOaA+JuDJt9cSnMloSKiDzxzKvD3CH
	KhmsursIqqV0xKhvfKOzZIazQlmmdVdmwEEosAXIeLAnzXPk1Gbwmf1qdg1aU1v5
	4e86OPzs/JiCXSwH3hF/OMLkRX0DLYIzHyveq7doVyJAax8PeaHfynlBCTIgL0Br
	s80sbsBPP3HGer+abf/ajw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1730646272; x=
	1730732672; bh=bYdraotLRQOkkUzv4QuIYvTKe3Vzkm7ORbSyLv33vr4=; b=j
	3fQ+gYT/eSCj6qwf5GEUiEd5QFaYVDqPbxB0nf+7EaC/IY3GM/6Uf7N+JkJfetfm
	EGMeEqgJVGkyrNImWWwaDyaJ4HVstbUxUW0pbY90YwgmrvlrMBSPIsLo1VCTooEP
	DZYQ+wJYS/7qqi7Y3ks1Tc1do6SLiHbhpJ1lqY1wxfmHXsyq06yTpztYimlhp9F3
	4t93UIrhEeWgTpJzDWdtGW+7pN9yaZ4/q3IDYlLlwCEjZYy3O6jLvOoI9JSD1/Ao
	6J2sgwEnOjjnIWixtlpK7O50u8VW6eXiqDqC/rjL1hRliljrPyEzBczGaLuhNNFS
	qBFun8zOetJalXyii9BaA==
X-ME-Sender: <xms:AJEnZ5OzBk5oXLBmCLSkiIEoMgOuGejRTI1dUuRgN_sfoNITgLYXc58>
    <xme:AJEnZ7-jqot7frxf8F_wVSWabtGJQ0S31qITqn_-DMhmDS3TSug0Eof7_Ue7iHwdj
    mG4RJfUoQMuPGbffg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdelgedgjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgr
    thhtvghrnheptdeigfegjeegjefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfe
    ekudfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    khhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrghrtgdr
    shhtvghphhgrnhelieeshhhothhmrghilhdruggvpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:AJEnZ4SqOVSRETL-mnzOlfbnbeguIR5ph2w1RC2nxUtV05pxHzoF6w>
    <xmx:AJEnZ1ueU5pLKDAtx5CyTDm4A7_moG_nQ9k3eSDX7lPokzqIoHji5g>
    <xmx:AJEnZxfzB_jNubSnxhEtPBXOGFBkWktsT-6e9EizGti73PUhwx7NIA>
    <xmx:AJEnZx3H40vluXscUsayDDy-hK8eiqvwzIuA6rFtmvXe1n5apQKgFQ>
    <xmx:AJEnZyqsHxH7ycDCwHBdRB6unBitLC_YtWhmVW-zSATm3ycXzsHBXygd>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 2E0F5780068; Sun,  3 Nov 2024 10:04:32 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 03 Nov 2024 16:04:11 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Marco Stephan" <marc.stephan96@hotmail.de>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Message-Id: <9fd66b8f-c457-451b-9862-6121128b2786@app.fastmail.com>
In-Reply-To: <xmqqo72xxcxo.fsf@gitster.g>
References: 
 <AM0PR02MB4980D186BDC087336C760132E6502@AM0PR02MB4980.eurprd02.prod.outlook.com>
 <xmqqo72xxcxo.fsf@gitster.g>
Subject: Re: Git revert cannot be aborted if the repository directory has been copied
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 3, 2024, at 03:34, Junio C Hamano wrote:
> Marco Stephan <marc.stephan96@hotmail.de> writes:
>
>> If you copy a Git repository directory to another path while there is=
 a revert in progress for the Git repository, "git revert --abort" does =
not work anymore for the copied repository. Instead, it will report an e=
rror of the following format:
>> =E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82error: Entry '.=
..' not uptodate. Cannot merge.
>> =E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82fatal: Could no=
t reset index file to revision '...'.
>
> I wonder if
>
>     $ git update-index --refresh
>
> is all it takes.


This is correct.  This successful test can be added to
t3501-revert-cherry-pick.sh:

```
test_expect_success 'cp -r repo in the middle of a revert' '
	test_when_finished rm -r new-repo &&
	test_when_finished rm -r copy-repo &&
	test_create_repo new-repo &&
	(
		cd new-repo &&
		echo nul >test.txt &&
		git add test.txt &&
		git commit -m "Initial commit" &&
		echo test >test.txt &&
		git add test.txt &&
		git commit -m "Changes" &&
		git revert HEAD --no-commit
	) &&
	cp -r new-repo copy-repo &&
	(
		cd copy-repo &&
		# Needed in order to avoid
		#     error: Entry test.txt not uptodate. Cannot merge.
		git update-index --refresh &&
		git revert --abort
	)
'
```

--=20
Kristoffer Haugsbakk
