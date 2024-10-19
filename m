Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F1E56B81
	for <git@vger.kernel.org>; Sat, 19 Oct 2024 10:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729333732; cv=none; b=M6uldXmYs4h6zjzajp381z9zNc445jiKbRE7NVHcCxXKoNfXsBfj667QyvDi3ZclWbBXbgRJIUceZvEkEEN7aPkO8ZpNSOZKksb+RJnu7nThfn0t8q5NMlu0gYuTmk2g966Djy7JeszKvitB8kDvHZGnVjP0ZIGv2fBUm5BeCpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729333732; c=relaxed/simple;
	bh=/IDQIpZCDEkG3mky/SN3aaCIusIlxYtiCsa+6yKIYZQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=LL+6TZ8UpM3qYYQQnQLH1YzT/YSvoRXUQ9ZNB0nZ7TeNE6JQ8huwoos5X9CFH7fl8th9dpl67MFyi0MpT6L1bCmK1I3t+b4t80i13GvWnES/1Ou0tu34//x+oGJklEn3c8sQCDEg0pYT1k/BrH59kJfuWT3YyIdIoxj+OwPux1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=OxjAAdBO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Gem3FZkB; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="OxjAAdBO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Gem3FZkB"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id B47A41380247;
	Sat, 19 Oct 2024 06:28:48 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Sat, 19 Oct 2024 06:28:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1729333728;
	 x=1729420128; bh=6xtOjthShZnZxgclOUT3IdzMbdVnbJNOOhnxbx68sE4=; b=
	OxjAAdBOfCEmOkksdNfVXPYq5em8P1c5Rk8G09Eh4Q8aOCgnP2+hKWrK6Xab5zTn
	6Wc41IF5P2VZg/n95lWbZyJAghe2EfQUjDpb8uTSHdcc3cYBkmar19aorM0s0wOi
	pG8/MwSaGr58zW6+9gYwc7lqsdR4COrgWARBM8bhX6/f6FYoWZxAt8wGZG56K0G7
	0FyfUGlvHckXTzzEIH6T32grmo/9lFzkhlwVySJ0OaykB6U/25Jk+UBAFDv36lZf
	1W0v/Ob+iyIUQ5v8FhVHYF7V1I72RgqV9SxzVw4gOkypcsVtE5P9liTDLMROFt9C
	ldzfgYdOukXGtZMVHrbI6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1729333728; x=
	1729420128; bh=6xtOjthShZnZxgclOUT3IdzMbdVnbJNOOhnxbx68sE4=; b=G
	em3FZkB9AjySJXIGbm1sDoQi8hCUWsXMcHAKu+rQwtwgHBiOCdJsfpemu675CA41
	jG2bfdS+Cd26Amx6q0T3mxmyBfjiJckIQ83Pl3pGvi8AYAwHmKvB6tmbXJZ2bTqa
	enynmhrrYCNVU91qEoNPlm1p1qyoQYcHSG9mv9rzxcCe4vgRbkPlMpLE93eZFDPV
	t9uFAa6hHpsfJfurmisAmnJ1dvrOT8wIFjbXUtlkVOU3DVWgWAvyTsjOLTVImuzF
	P7Oc47poYmhuero1erwwnl1fnCkDSd+B9EifN9OfZquNtjuum8eXdmDGgK+NVeUg
	EkcISAN+IBPrRwCqfdkXg==
X-ME-Sender: <xms:4IkTZ_tEYIKaK6DzrGFzY9SDwjFkdEoYwy9M2pOHS0pxC2-JKDGg7I0>
    <xme:4IkTZwf9UIoZucE4bzxxS6MTB6gh9gdhWKtHx9M7_FLxEulIoqZRD5y-q0UGQCYy-
    Ke7hO3pFgNU0oV9yQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehhedgfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgr
    thhtvghrnheptdeigfegjeegjefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfe
    ekudfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    khhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrsghrrghh
    rghmrgguvghkuhhnlhgvhedtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhgih
    htghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:4IkTZyxepPMqX5-YrMMVQYfa93edYpevc-lyKIUEjnO6vQnk2NWUMw>
    <xmx:4IkTZ-MMC6f2tLn92IHyz6pnd416myC8rGUrcfS5yIzoJZNEiDgiNw>
    <xmx:4IkTZ_8y0AS8CYEryfwECkzgt-Hle-ANLtsJNUzYtBRxYQfX8tBRog>
    <xmx:4IkTZ-VsccCOOPepInTbdcliLtZtpJmwx7U7uZXYyswSEoaLiB1NAw>
    <xmx:4IkTZxIBKWtd2ExamQW2uWW_2ek43rDIrhH8d5j_tvc_9cCZ5NMcxE9L>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 70C17780068; Sat, 19 Oct 2024 06:28:48 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 19 Oct 2024 12:28:19 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Josh Soref" <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: "Samuel Adekunle Abraham" <abrahamadekunle50@gmail.com>
Message-Id: <5e41f019-f37f-4860-b672-78b85e24d9bf@app.fastmail.com>
In-Reply-To: <pull.1817.git.1729296853800.gitgitgadget@gmail.com>
References: <pull.1817.git.1729296853800.gitgitgadget@gmail.com>
Subject: Re: [PATCH] notes: teach the -e option to edit messages in editor
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Samuel

On Sat, Oct 19, 2024, at 02:14, Samuel Adekunle Abraham via GitGitGadget=
 wrote:
> From: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
>
> Notes can be added to a commit using the -m (message),
> -C (copy a note from a blob object) or
> -F (read the note from a file) options.
> When these options are used, Git does not open an editor,
> it simply takes the content provided via these options and
> attaches it to the commit as a note.

Thanks for this work.  I think part of the motivation here is to make
git-notes(1) act more in line with the conventions from git-commit(1),
which is always nice to see.

It=E2=80=99s also useful in its own right.

> Improve flexibility to fine-tune the note before finalizing it
> by allowing the messages to be prefilled in the editor and editted
> after the messages have been provided through -[mF].

Here you explain how the end-user will benefit from this change.  Nice.

It=E2=80=99s important to explain the background, what is being done, an=
d why it
is being done.  And this commit message does all of that.
