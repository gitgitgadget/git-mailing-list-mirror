Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139F12D5932
	for <git@vger.kernel.org>; Wed, 29 Oct 2025 13:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761744441; cv=none; b=Wwzwebn8LVxyf0D0b2nKZwgSO34hnMLumFetxCU0SzE+0UHs2LyPZQrgFCej3MJQPIa2fbktB+PDruKCq5o8zLS7MHD6WgtKOF3GJdVih/SKF27X+dmHSBZLA7goSYVYrHizF2ojb0n/75D/zcnaV+iLEQbE3qJAGM1Oa40UaU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761744441; c=relaxed/simple;
	bh=4H36rKtAflmWJ8Idnh6T4x+zVbtAHYAAnJLwfpakyHI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pGoB4ve9VBm8VOK/w6DjI00Ez8j8BRCvRrRNwQZuVKEnFu1HRiuRrdeEcJfdWYGqAskvMRFs/EgDllflT0KF4BSLXhlFo8BiivfIsxLJ68sVfUzgJZIQ9HQQl6McY1ccwKNDK6G4wySQo8m7XNQBeT65t2TJNVD3QMgN/Kc+1KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IxLUBoKh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Okabgb6a; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IxLUBoKh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Okabgb6a"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 31C2BEC08A5;
	Wed, 29 Oct 2025 09:27:19 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Wed, 29 Oct 2025 09:27:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1761744439; x=1761830839; bh=Upt5xXjg+p
	uBzygbOttcRLk7GQMxj94pGtEDkxjEgjE=; b=IxLUBoKhJTYPGToXBapYeZb16F
	Wx3r6VPuxWvkVlQddBlXxWj7ixlHrXGlDmgnVM6842zLqPwnD8SZ4yCgdTMzBI9b
	r3HOet+sJnB0EgeBxfC1PpUiYLMLM3wnZvhhcg12MIv2KAO9fzwoNQKREDV+1lO5
	4YIywraZ20yloGIauodA/nJhObZcyx3DRmyjKhQrpU+dnpE0mbEyj11urCGqNTmD
	mtOcjm6ElSoykw4RJI0cOYLkzncgdEHVk4g2mdxS3ButBJD3Y9JKQJ5E2vR3bBIj
	SFJOiMsow/lKH93MSZd+IxaKPrmxXL6HrBwCpSpoCImkk9j6fKiFXOQjUmGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761744439; x=1761830839; bh=Upt5xXjg+puBzygbOttcRLk7GQMxj94pGtE
	DkxjEgjE=; b=Okabgb6aY0x3U4//tXnwydYYhFZxuAbHuhtRP7Ued9Lw2QRse+r
	hv1IREsuG8wXg61LTAqXZN8HW1T7KZV0yybd+w7/yEnZ8AW0614FijfwLur+2qIG
	D2HVoqocGRMBWeaSkRGt3KrGS74I/tIEmK9XIYqjECezhXspyMdGoLSPwBIObyeH
	J146RIFjzcpaw2N37EuARVRdgxvL8j61pTHRFFAU7VVUXe42ie5kWhByX4TZN6NE
	kJYh5qyojlQ0+APC8te6BR/WceHxw3amYZr8Jg7yR5hEvcGXUBjo3u6Y7j/ZfP66
	fVHYcuDj6lGfsTdJmHg35S/rEQdgitrXkxw==
X-ME-Sender: <xms:NhYCaTwpYv5kX8oSTILRfrUU2ZGsYeROoPeho2AuPyH_WnyWb6fS-A>
    <xme:NhYCaSJdVKe4o2-xXKiCT6P2cXuar6ZgMsnrKe8eaA2M_G38ZEX3XZ0BKP8m_9nHZ
    Y6g_byjLFD3PeB-GogRUzHqwumt68mfpHrE1a85LH7D4_7-haZbcA>
X-ME-Received: <xmr:NhYCaVrGAgUc9D7r4n28Re6JtmvRxOsW9W1aKcJH-lJL_t1a8hlqiq5ujFeL65b6Fmrdtk_EQoru-b08brPgEq8582-SWozKAHMS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieefkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepvgiivghkihgvlhhnvgifrhgvnhesghhmrghilhdrtg
    homhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdr
    nhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:NhYCaZJ6_AxjIvnvvWAEliGnP7Qm5Smd6DoYij6P1oZrhQRDvWTnjg>
    <xmx:NhYCaSQZTS2uBOQ2VBVU5vJtiIaRXXHnRcFnP4Q6FCTa0ha5gQxF9w>
    <xmx:NhYCaQtmlvfu1qFrA57nzBqMsF7DI96EvcTlZYtbVpMGUAgvz6TWag>
    <xmx:NhYCabacFH1Noha4fisb_BuMToVbC640EpT8ItipFnILKaBgOB_V6w>
    <xmx:NxYCaRb0xQJ_hE3bEF49ahQ310ElrjKmPeQuv7ij457SkozyydqZq3aH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Oct 2025 09:27:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ezekiel Newren <ezekielnewren@gmail.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  git@vger.kernel.org,
  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 05/14] rust: add a hash algorithm abstraction
In-Reply-To: <CAH=ZcbD80RGeuxqcDiWr2KNaQzFCrd=9fQOGo_+pW9E6+HmtQA@mail.gmail.com>
	(Ezekiel Newren's message of "Tue, 28 Oct 2025 14:03:11 -0600")
References: <20251027004404.2152927-1-sandals@crustytoothpaste.net>
	<20251027004404.2152927-6-sandals@crustytoothpaste.net>
	<xmqq3472dcfl.fsf@gitster.g>
	<CAH=ZcbD80RGeuxqcDiWr2KNaQzFCrd=9fQOGo_+pW9E6+HmtQA@mail.gmail.com>
Date: Wed, 29 Oct 2025 06:27:17 -0700
Message-ID: <xmqq8qgtbzyi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ezekiel Newren <ezekielnewren@gmail.com> writes:

>> > +impl ObjectID {
>> > +    pub fn as_slice(&self) -> &[u8] {
>> > +        match HashAlgorithm::from_u32(self.algo) {
>> > +            Some(algo) => &self.hash[0..algo.raw_len()],
>> > +            None => &self.hash,
>> > +        }
>> > +    }
>> > +
>> > +    pub fn as_mut_slice(&mut self) -> &mut [u8] {
>> > +        match HashAlgorithm::from_u32(self.algo) {
>> > +            Some(algo) => &mut self.hash[0..algo.raw_len()],
>> > +            None => &mut self.hash,
>> > +        }
>> > +    }
>> > +}
>>
>> These cases for "None" surprised me a bit; I would have expected us
>> to error out when given an algorithm we do not recognise.
>
> I think _Result_ would be more appropriate here.

Perhaps.  But the Option/Result was not what I was suprised about.

When algo is available, we gave back a slice that is properly sized,
but when algo is not, I would have expected it to say "nope",
instead of yielding the full area of memory available.  That was the
part I was surprised about.

Perhaps as_mut_slice() side is justifiable (an uninitialized
instance of ObjectID is filled by getting the full self.hash and
filling it, plus filling the algo), but the same explanation would
not apply on the read-only side.
