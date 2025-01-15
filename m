Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4DE1D5143
	for <git@vger.kernel.org>; Wed, 15 Jan 2025 09:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736934718; cv=none; b=GUWo6Zhtq+MLlZo7l7RZk0zkndP8IuPwPvQQjNDlZNXvUcLW1YJrnkqG6COfpUtGcV+Y/W4LYmNIykkT6uKFHVqug+DTAWvFqX8keq56vW68krf2fuAm8sf8G/071Gv4eobo5RYSBaWA+Jf0YAPmkrQQ332sC/DHLdbRksTZk1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736934718; c=relaxed/simple;
	bh=zf17f0QOQ427GXdtIkWJniYn8GTjqnRIi+8Fm4jV2yE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=NLvjVU8M9bwBJEEqzp9nIO6axwaCJvABPitfvAcqvLE6mj4A4xu0jyGgBbipV3KVVPYVDZ6G3hNQ4M27z0LyzbKqb/xbKNeKrV5KJ5GaniSqU9Rm0iF0gQSIN5CimEccmXoYOzIbJO4f+PwWxjGwCY1pFHpqEohO5eA5Z1YLTLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=aV+vxDrl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Fl+7I2+T; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="aV+vxDrl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Fl+7I2+T"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 14B4013801C6;
	Wed, 15 Jan 2025 04:51:55 -0500 (EST)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Wed, 15 Jan 2025 04:51:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736934715;
	 x=1737021115; bh=60L3qMF7mRVStNIiTjKKNkeTM5dUyeV/hTLtvnV8z08=; b=
	aV+vxDrlmrOPxFhxS1BeF6STbhTVAl8KIRiWQQW95QmBvvjkukgTnMe9IaDuNo4f
	CryhEOVYrY4KI71N5UDag6EgLxUZ+gRlvtT8I1YpVkbfplof1noVNDBXn/e/kIf/
	5O70CzQBkq6SfQQRmzQugY8354tTDfc+oe333otGj89gAVMuDn80z2nyEgYH4vkd
	HAnWweZd9lMoYXoIK07CoeUCcLTh6V0mJtkwDo1SLtsfdm6rMr9fCstU5bfys3DH
	EboXqXUxDg4SpVxBWyP3ZFa62mWLElXaa+F+yXbU1oXYWV+szjoji9Kzh71Iaq6x
	3GrJKFKZSaUAf0QTJsvVDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736934715; x=
	1737021115; bh=60L3qMF7mRVStNIiTjKKNkeTM5dUyeV/hTLtvnV8z08=; b=F
	l+7I2+TEQOB3ctir5KQnq3fdIoLgymXFxgjgWvQoYn199RdMiGMEFy4EB4dPJ2+G
	caz4EEb3up8lAIzDMzwUAVmuLmQt6C0Fdwvv80b0IRhBaGWBPty1xvkckP4BTK+O
	+bvbxW6mb0Q/ymuxHjjwW0Ji4R3GzubnEuQOrb/RQIpdI8X4qPgHZDKS3KFANubQ
	P8/Ejma9P0sVRsqw6nTEhXUTH/XIpQBUiH82ERC9NCQGfLCVQwx4YpLMd0N2pXTt
	mzL1F5PQvWp9Vl3+JyoFiGQ9Roi9Icn+KzwEq2pTNJ+gt3U5HFJNiMWmosbSvZX9
	U3irUxGCtu1AmtY4NvGJw==
X-ME-Sender: <xms:OoWHZ_xXibZDot9LmWI0gB1kZKdX3hDQqQF0DdxxPzZYqlDAEgC9DSY>
    <xme:OoWHZ3T6zAm1umkSqN5qigea0sZ03YOABm6fMCHVWHkBkzOT-1jOuim7d8n_xXcgp
    lUNyXB8kXLw5yyM3Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehkedgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgr
    thhtvghrnhephedugfevgfefgfffvdfhffdvveevgeehhedutedvgfeuffejveejudegve
    efvdefnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheptghhohiflhgvthhttdelsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:OoWHZ5Uzm8fmqPxcze4PHxr8KqSBmhjEbrNVKWp3oD-diqWylvXP6Q>
    <xmx:OoWHZ5hArHUrenSzdEg4GnBT3whLUeJT9g5Z_SK_jhYOjoJXgOo5WQ>
    <xmx:OoWHZxDVw3SRSyQgJNDg0TIcTYA_Tc75UgnaVTWJbc2pOrKq29qlJg>
    <xmx:OoWHZyK0dHQbYLlaI0dMEQbB10zI-vQpoxLiLcgJL37QtxtrN6G__A>
    <xmx:O4WHZ0N0riaEJCbIstfpTu3B0EycNteyFKk6xUsiVmYdT-NyegiJcRBY>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D4118780068; Wed, 15 Jan 2025 04:51:54 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 15 Jan 2025 10:51:25 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Josh Soref" <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: "Chris Howlett" <chowlett09@gmail.com>
Message-Id: <1c220376-4b4b-425f-9797-abd1728aacc2@app.fastmail.com>
In-Reply-To: <pull.1852.git.1736933815236.gitgitgadget@gmail.com>
References: <pull.1852.git.1736933815236.gitgitgadget@gmail.com>
Subject: Re: [PATCH] help: add prompt-yes setting for autocorrect
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2025, at 10:36, Chris Howlett via GitGitGadget wrote:
> From: Chris Howlett <chowlett09@gmail.com>
>
> The help.autocorrect functionality is really useful, saving frustration
> when a dev fat-fingers a command, and git has a pretty good idea what
> was originally intended. The config settings are a nice selection, with
> "prompt" asking the user to confirm that they want to run the assumed
> command.
>
> However, with "prompt", the choice defaults to "No" - that is, hitting
> return will _not_ run the command. For me at least, if git is confident
> it knows which command I wanted, it's usually right, and the golden pa=
th
> would be to run the command.
>
> Therefore this patch adds "prompt-yes" as a counterpart config setting
> for help.autocorrect, which does the same as "prompt", but defaults to
> "Yes" - hitting return will run the assumed command.
>
> I have not added any tests because the test suite doesn't have any tes=
ts
> (that I could find) for the "prompt" behaviour - I'm assuming this is
> because it's hard/impossible to simulate the interactive terminal prom=
pt
>
> Signed-off-by: Chris Howlett <chowlett09@gmail.com>

This seems to conflict with the patch =E2=80=9Chelp: interpret boolean s=
tring
values for help.autocorrect=E2=80=9D which is in `seen`.  The latest ver=
sion (I
don=E2=80=99t know what version is applied right now):

https://lore.kernel.org/git/pull.1869.v4.git.git.1736760824201.gitgitgad=
get@gmail.com/
