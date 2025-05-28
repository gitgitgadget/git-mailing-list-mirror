Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58019E55B
	for <git@vger.kernel.org>; Wed, 28 May 2025 06:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748415494; cv=none; b=mdQScHZIf/YI7/WcoE8sBDumcok1b9bQ30qSVWtaFLWC5kffmmH06nXcOY8i9+Zt2NzAoUdkaXh+8B0p0yGtB8RIo7mG4zfi54fUiFM7Jgb2upJxw9BXGIJc9Rj3XoaXyKKJmJKcGg0IHJPV8pg8MRBPutVPn01zFj6KRjDQRiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748415494; c=relaxed/simple;
	bh=TTKkB4V6usyM7WkySFWRBR/pxKHbd0xTiQm8E2EA6b4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Qr74ntWo7i0AOgkFEHCWhIIlimSTsy4zDr1fx4aMaMsN7EkgzJVMlZtiJv3I2OMJOlAXy/2c4YnaIfIu8vo05G6JHyee937snwrifdergK/i1Ezv9YbJ19peCPFeghF6Tk4wOjY3emVOfOhJBiZp70RWj6CRYwTx0cSAXtq6bV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Qkw6hH1v; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nLKb5mNY; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Qkw6hH1v";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nLKb5mNY"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 0BFB513806C3;
	Wed, 28 May 2025 02:58:11 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Wed, 28 May 2025 02:58:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748415491;
	 x=1748501891; bh=fJM06hYiAe5NfUW/D1LdXaIJkZ7roc/ffIb2XA7TEMI=; b=
	Qkw6hH1vFb7/rRPyMATNyCuU35sLUIx9nRdQkU9fVOOn/2IVz66l1t52l9zIpWyb
	n0hj7aibcvTBU8aBDUVpNs6M85YrizM9zN8VgMOU0Jakm9gW/mmoGy9Cz6YswQpY
	GeOO97wfD3VemhnRXNs2owEr6hBM1yl59dxVzxiyHGiY6TUXl3KYj7ZpmiRByu1E
	La7DkIXmCi+jWX9GPRjrjTzg+O72ZWv1P64UQnI5ecVxyugfUamaexVtk8MbLzQW
	BD788T79Vo+bytKNdesarsh64UB4yUULKWP6vE3q8pFyJhE8ZXYXkl5iOp59+ZGy
	uAhHJ+EhYePVvYULUo0KSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748415491; x=
	1748501891; bh=fJM06hYiAe5NfUW/D1LdXaIJkZ7roc/ffIb2XA7TEMI=; b=n
	LKb5mNY7s+u2oryG5QqxLY6jhtNnnuWy4zFmBe2q4pvd5xYivgmy6XpjqhmsSjyY
	8AiWEh+RxzOsjRhBVq3YnUdVkYuwd3UyTIdvCghKxT+LhFXRnleIiEiDY+nn65uo
	9/2LC8PERqnJK16/aqsr6RNmtCxzlbCeOy9Tp/R+/jML1n+EoeLIhR2tVSlgEZAf
	1S7LeYokgzWkhEER5grn76i2VlpZCGTKOIxz+lIZILor7T44xtQ7MMrqUqcjwfYU
	KR9pTPrOuC5lro2cveFcJddQhQWotNUtE9Ld02vabh43xCSWA0Xjyj02PLHwmAe0
	1HyNU9tXQv8LBOmuwlP+Q==
X-ME-Sender: <xms:ArQ2aC61o-t3KW3_H5nxSQJrJ4_F44sDdsmsZPmwmX7P0eNX2FCMVyQ>
    <xme:ArQ2aL6U2Zt1sVFuMfRXxBYfJ7DOrVG_mAhs1VodhlODm7jdEVDb8WC0r4Uu1L5G8
    zCqSptFuhXPAH7K7Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvvdeitdculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecunecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhm
    pedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrh
    hhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhep
    tdeigfegjeegjefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfeekudfgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthho
    fhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtth
    hopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgv
    thesghhmrghilhdrtghomhdprhgtphhtthhopehkihhmfiiftdeftdeisehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ArQ2aBdhz7GbFHzd5WNEwl7hhFftmlGqMh0RNqoabOAVWw0KVgw2JA>
    <xmx:ArQ2aPJsnr4ejwpxkznzytJt2q6QVHQSMcuuahInFQmNV7MZ4kgczg>
    <xmx:ArQ2aGKTsQZQWnFQuzTSZ_WeDw3FBZnEzKRAOsXZ7GFTipEz-A7WzA>
    <xmx:ArQ2aAxpRL_oLtE0vEfu1m_PGebGtwzw4El8CWBBJ1KoPL70-lsRQw>
    <xmx:A7Q2aNmtuGvHeKT5XgoC_cw3JhdnMl1X8SzzysQghJjoDNheoBwdaAGy>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C32561EA005F; Wed, 28 May 2025 02:58:10 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T05d811ea5ebcca3a
Date: Wed, 28 May 2025 08:56:50 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Josh Soref" <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: oneee <kimww0306@gmail.com>
Message-Id: <d8d8c10d-4f4f-4fde-8b91-b979e2931fad@app.fastmail.com>
In-Reply-To: <pull.1948.git.git.1745239300668.gitgitgadget@gmail.com>
References: <pull.1948.git.git.1745239300668.gitgitgadget@gmail.com>
Subject: Re: [PATCH] doc: sparse-checkout: Fix list markers
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

> doc: sparse-checkout: Fix list markers

s/Fix/fix/. The initial word after the area should be lower-case.  See
`Documentation/SubmittingPatches` (SP), =E2=80=9Cdescribe-changes=E2=80=9D.

On Mon, Apr 21, 2025, at 14:41, oneee via GitGitGadget wrote:
> From: onee-only <kimww0306@gmail.com>
>
> Changed the list markers from a mix of "(1)" and "(b)" to a
> consistent numeric format "(1)", "(2)" for clarity and consistency.

Commits are described in imperative mood (SB, =E2=80=9Cimperative-mood=E2=
=80=9D).

Reading the message I thought it was about a larger change to
consistently use one style over the other.  But you are fixing one
application of inline lists to use either numeric or alphabetic(?),
specifically falling on numeric.

I would write it as:

    doc: sparse-checkout: use consistent inline list style

    Fix this inline list to use a single style, namely numeric, instead =
of
    `(1)` followed by `(b)`.

(Numeric or numeral, I=E2=80=99m not sure)

> Signed-off-by: onee-only <kimww0306@gmail.com>

I=E2=80=99m not saying the following is not the case.  But FYI the proje=
ct
demands that commit identification needs to be your real name.

Just saying in case it is a pseudonym.

> +	word "patterns"), and (2) the sparse specification might

I would also use a semicolon to separate `1` and `2`.  I think this is
the correct style for any list introduced by a colon:

    see here: (1) ...; (2) ...; and (5) ...

Because then you can use commas freely inside each point.
