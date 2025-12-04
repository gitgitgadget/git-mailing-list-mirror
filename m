Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0648016A395
	for <git@vger.kernel.org>; Thu,  4 Dec 2025 08:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764836324; cv=none; b=OKI+nFomTCekL3yKn11kYE9rnt5rGqwpPMXD0+vQsaRKHS+aqIZPfWXj53tXIDL7erkPCm7w2a5BKmBmvOWgzObfi+0sglSNVP7Fc5x7CQV7QEUqYPoCs9ZNpJWFMHOFcHsKNRRhaNPpS5hZfhse4UFBBky5DOnTuPwDK58+qAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764836324; c=relaxed/simple;
	bh=6NG63uxm+G5i+mi40f+Lg7rQGwl5cALVFsA41KwW8Ek=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=GU3Vg/U/bg4+vh/MPIaMgWJGmXSfWJWWbSsTF3vXD8t70Aigqe/60tV2m5kGkEn1wrlpTbsiuRi4uh4f74h4bVRQJk1+8VNshCz89787+LlQaszYgrhGw13OC8CAqwQ6ItFQKj7+jXUom1BKGIHpyANXGpbhvgPJ7ZJreUthJrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Xjt++ECw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fKFoZNSW; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Xjt++ECw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fKFoZNSW"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2BFD97A0284;
	Thu,  4 Dec 2025 03:18:41 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Thu, 04 Dec 2025 03:18:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1764836321;
	 x=1764922721; bh=6NG63uxm+G5i+mi40f+Lg7rQGwl5cALVFsA41KwW8Ek=; b=
	Xjt++ECwMZBg58R+li7NG0z9gRbndC34cmC48hWX+OrzwKQSPs4ITrr7MS21pZEB
	lP7dJ5ArqRGLM8hw31OwMTZvSMfFrqKhmdXn77pFfFbnC1t/E5mUE36IXneeFOmy
	xXJy7DTe3zCpUayE21N3AQFPS/tbjlw9kDGzSpheFpbW4o5vR+omjky4tJwIKWSS
	UmpJL9SZ8cK9pwzO7ZKHcFE0OGb0Sd8xhIZszOt/EIu5FeFHADcdK/JqMIGisXxG
	s+lZOxdnBggglYSSjnx5FEE28hedqwBXi4VCB70R11nCeOnn2bKMydF2i5dnF3Cj
	I6AtZ8V9hoHFC3HW+qOB9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1764836321; x=
	1764922721; bh=6NG63uxm+G5i+mi40f+Lg7rQGwl5cALVFsA41KwW8Ek=; b=f
	KFoZNSWFEvz1GqN2sDuihTLMDtYGC5TlV2cS5mqeXfiCtiGwlJ0CYqBlXEfYImG0
	yS4h6mdnCIJWqTJ1btjCuIT145eOXFeGHDMuSgAsPod32xLmEzzLxvGd65mZyon1
	7l45Si4WWPROtw6zAv1Pkfeg9/a6XimYPJHS4iDatpMXiJkDHa+dkQzjIbqUkVeb
	lroe+wldpf2wxxoUKEsHrJkVtU/TqXxWWeanW7AWR/BMmHEU4vCiH2vtCIZGAMBg
	OWAgIpShNAVUNQWLTE+JpemAn4U/D9+OMQBdDut3jvkGdG94BAtbvjrXIuUVTG52
	W0fcp/qe6f+uy9lpxWRmw==
X-ME-Sender: <xms:4EMxaZkKhv-rm-kDHczTcPy_VjN2QaDEVbO5EgbVySD0LX-wos_b9Vw>
    <xme:4EMxafrMMoitXkB7wVDc7CbD8m4IXIJVaUsHRW9evHHGzdODPOMgWQEd0A15yKDjp
    2uj5vGXyK94HtHL6sP5v5-hS5gA_au2DVBm9LSe9BzXkEYKWN29Iw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdehtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhsthho
    fhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssggrkh
    hksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhephedugfevgfefgfff
    vdfhffdvveevgeehhedutedvgfeuffejveejudegveefvdefnecuffhomhgrihhnpehkvg
    hrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtg
    homhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    ghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhtvghfrg
    hnrhhivggthhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhulhhirgesjhhvnhhs
    rdgtrgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:4EMxaTORmKT4Jp_cL1Sv81KzEOAbnlzOkX5rUmdN8SyhL6FjqnsRlA>
    <xmx:4EMxabyyjRW5PfVgJgV-X-Rb0cxUH9hjsYHbAo1AjCd1VRm17Pgx4Q>
    <xmx:4EMxacs3e_awJpmZZlnG0IK05N7haw5LCcicBEyfwiFNKI3AO9bAVQ>
    <xmx:4EMxaU5xUW6SE8Y4IHDnSkeGLMUSfFxVDzX6ScbHf4EhUzrm0gTkKw>
    <xmx:4UMxaZDi0mgfnljlV8-0ZNlSyGjPBxcs9Ngmd-M7lImq9D-xwMJDzg0t>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D5CEB1EA0066; Thu,  4 Dec 2025 03:18:40 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AtmV10PLKsYV
Date: Thu, 04 Dec 2025 09:18:20 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Stefan Rieche" <stefanrieche@gmail.com>
Cc: "Josh Soref" <gitgitgadget@gmail.com>, git@vger.kernel.org,
 "Julia Evans" <julia@jvns.ca>
Message-Id: <e90d68eb-4e29-41ea-af29-b5eaf5988ccd@app.fastmail.com>
In-Reply-To: 
 <CAAnFMuChk4873TgYoypyNBg9dzCFfqVJ4To_s2_L35_MX0P=CQ@mail.gmail.com>
References: <pull.2015.git.1764776095597.gitgitgadget@gmail.com>
 <f4bdb657-6217-4ddd-aefa-10263e1af05d@app.fastmail.com>
 <CAAnFMuChk4873TgYoypyNBg9dzCFfqVJ4To_s2_L35_MX0P=CQ@mail.gmail.com>
Subject: Re: [PATCH] doc: git-pull: fix 'git --rebase abort' typo
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 3, 2025, at 19:04, Stefan Rieche wrote:
> On Wed, 3 Dec 2025 at 16:14, Kristoffer Haugsbakk <kristofferhaugsbakk=
@fastmail.com> wrote:
>> On Wed, Dec 3, 2025, at 16:34, Julia Evans via GitGitGadget wrote:
>> > From: Julia Evans <julia@jvns.ca>
>> >
>> > `git --rebase abort` should be `git rebase --abort`.
>> > (typo introduced in e9d221b0b)
>> >
>> > Signed-off-by: Julia Evans <julia@jvns.ca>
>> > ---
>> >[snip]
>>
>> There=E2=80=99s a patch for this: https://lore.kernel.org/git/pull.21=
11.v3.git.git.1764719353631.gitgitgadget@gmail.com/#t
>
> Are there any outstanding actions on me?
> I'm new to email distribution lists, so sorry if I've missed
> headers / formatted any emails incorrectly.
>

Not that I know of.

By the way you sent your email that I am responding to now as multipart
HTML/plaintext. I guess that=E2=80=99s why your email does not show up h=
ere:

https://lore.kernel.org/git/f4bdb657-6217-4ddd-aefa-10263e1af05d@app.fas=
tmail.com/

Plain text is preferred. Certainly pure HTML emails will be dropped on
the floor.
