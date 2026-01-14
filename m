Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A32A33C187
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 06:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768371252; cv=none; b=A69m3UoqlNdPPqTi0v8G0GNCJviCmfrhlsE+BbHHiPmezgObJoQu6weQSA+OWHQ/u96Qp0MP3tcmVscbcHRxivVUIXM842olTe5oVc6zFefRFm3rsKaxvsU3CMy5OqaZqB+rC4CsxWE7dR9S9dRPwSqIvKfseImIk/4tNJ4pO0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768371252; c=relaxed/simple;
	bh=Rm48HOTDZYYVrqY5f9jY9CtUkbg2PEQJq+NeLptlGYk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=E8CQbxyZRt9gApS1i6yWYaX28TLya6YEOu5d3VJh7Ih4B0okUysE4YZmbUMIXtnejV13DBmCXcMe/KATTi79mK3Z5Uu2j9cSEr3mLqN5hipICFVkqxIAqNXk+Jisx+2S1WkUxJMEEhacoLpTeysOgiODBvzdS2/6RHGX/6p5Ys4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=X2Osdw5h; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IVCjQM/5; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="X2Osdw5h";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IVCjQM/5"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B01A614000A9;
	Wed, 14 Jan 2026 01:14:03 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Wed, 14 Jan 2026 01:14:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768371243;
	 x=1768457643; bh=Rm48HOTDZYYVrqY5f9jY9CtUkbg2PEQJq+NeLptlGYk=; b=
	X2Osdw5hmW6I007Vc8IMpdhxPSgVZCCBxuprlC6VVQWTxNVvuL7b3F/jdp0v6vjn
	Bc2c5oC9W50To/J6h7a8ovAB9QuNgw5hbOVKYrx3WUxC38ZRC3aX0KBWL0/GrVG+
	T6jy5+PyTUVyrqPfIpFlm+0vg4d+HqioNqrs4cM33aRfQsc48TTqDbGWXa5dKvHj
	YgUIYFY3MEtzOlVl07hcmr64Kv1wscRywkxY9pRCZB4tWhNV5oR56bqxUIB39w/T
	cOIwLiNiMH+zKAMdRwRE+zdkOpQ/3iSgHlD9VrwhZ7EIbbIWXItIsKsM6DmKhb5W
	80OFT9Pv9xomNnKgUC6d6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768371243; x=
	1768457643; bh=Rm48HOTDZYYVrqY5f9jY9CtUkbg2PEQJq+NeLptlGYk=; b=I
	VCjQM/5qDmbDi/j+DdXb1380dHJ253GUThfDr9eLv4Z3Ey+f2A+P5SjQIiRP+3LZ
	u/pOarW1zu5HqcJfVRHUQoMNtNyhr38RW7ctv/KH/JZVyoKxMxcPP8R618iXSIW7
	sswZIrOuLr5ofdcd5naH/BoALWDHBEjo5RJdNYQtlm2mBJc8uqjcsSm/84QPhUD/
	TcaLR9A9JsX6WPSsLy7b3mPm9LqrTHliMl4zH30aKz9aTC0sBtP9WmvBGOGcgLIv
	ozle+WVX3l1MurbwDxa/j0AjmkH88ToNVdzOGcXT+9mKgUk9OZLp0aTrbeep6MHK
	pA3Q0XaQCsEWzyhp8nkKQ==
X-ME-Sender: <xms:KzRnaVMj_3xtOiHrHgRnZ3vb2enIuROT7Rsb9DoVZZSROII4n5y_TFI>
    <xme:KzRnaSxwcdj0z8Y2hTXBZJ4RFsNBb1O_wol11qwU1cIwCEbRTsdPFYoFXRZPLOa-_
    72ISFsp6kb17ZVHAxqbG0zxDUi5v-28--_oQ9lPd_a0VGW0O8wjlQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvddvgeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepffeuueeiheeh
    ffejgedtveefhedthfevvdegudeltdffheejvdfhjeduffehgeelnecuffhomhgrihhnpe
    hkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilh
    drtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    oheptghhrhhishgusegrphgrtghhvgdrohhrghdprhgtphhtthhopegrughrihgrnhdrrh
    grthhiuhestgholhhlrggsohhrrgdrtghomhdprhgtphhtthhopehsrghnuggrlhhssegt
    rhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopegvmhhilhihshhhrg
    hffhgvrhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:KzRnaSlBwwftNc7nsue2ikGxJBhBmbtWr8qYl1_NRhaTWlSVt6fQKA>
    <xmx:KzRnaagCKelAxOWQHeUNhaEVB1AvD5R37_2rIqdf6GLYIy7J2YsABA>
    <xmx:KzRnae3lbYmIM1UdoCNKG3zoCz-z_DsjMUftFrTEvw1QHiyNboyfhw>
    <xmx:KzRnabIzJw_FSTknvoC7PMi-gzrhiaIi6SVy_-Y-8zrhtpceEgu7Yg>
    <xmx:KzRnaWsMxuajhmA3yv2CXxlcEbLqF0XwJJ-SeKEoTJMZg7GCzN315m4a>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 5ECE31EA006B; Wed, 14 Jan 2026 01:14:03 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AevOCapFdhMs
Date: Wed, 14 Jan 2026 07:13:43 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Adrian Ratiu" <adrian.ratiu@collabora.com>, git@vger.kernel.org
Cc: "Junio C Hamano" <gitster@pobox.com>, "Patrick Steinhardt" <ps@pks.im>,
 "Emily Shaffer" <emilyshaffer@google.com>,
 "Chris Darroch" <chrisd@apache.org>,
 "brian m. carlson" <sandals@crustytoothpaste.net>
Message-Id: <6746acf0-4538-41fc-8699-5acae6ec936e@app.fastmail.com>
In-Reply-To: <20260113234528.1749921-1-adrian.ratiu@collabora.com>
References: <20260113115633.230479-1-adrian.ratiu@collabora.com>
 <20260113234528.1749921-1-adrian.ratiu@collabora.com>
Subject: Re: [PATCH v2] hook: allow hooks to disable stdout_to_stderr
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Jan 14, 2026, at 00:45, Adrian Ratiu wrote:
> The last batch of hooks converted to the hook.[ch] API introduced
> a regression because pick_next_hook() always sets stdout_to_stderr
> for its child processes.
>
> Pre-push is the only hook API user which requires stdout_to_stderr
> to be 0, so it can be argued that pre-push needs fixing, however
> this will likely break many pre-push hooks, so it's better to allow
> it to be 0, i.e. to match the previous behavior.
>
> To prevent such regressions in the future, extend the hook tests to
> verify hooks write to the expected stdout vs stderr streams and
> maintain backward compatibility with the hooks output assumptions.
>
> The tests are independent of the actual hook implementations: I've
> tested they work the same before and after the hook.[ch] conversion
> and will continue to work after we eventually introduce parallel
> hook execution and config-based hooks.
>
> Reported-by: Chris Darroch <chrisd@apache.org>
> Suggested-by: brian m. carlson <sandals@crustytoothpaste.net>
> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
> ---
> This is based on the latest master branch.
>
> Changes in v2:
> * Extended hook test coverage to detect future regressions (Junio, Patrick)
> * Reworded commit message and added explanatory comment (Junio, Patrick)
> * Set ungroup = 1 because grouping overrides stdout_to_stderr (Adrian)
>[snip]

This fixes the issue reported here: https://lore.kernel.org/git/249f08d1-4457-4a41-8dbe-9725c0c392de@app.fastmail.com/

(Subject: [BUG] push: pre-push hook that waits for stdin is slow)

Via: https://lore.kernel.org/git/87ecntqd9f.fsf@gentoo.mail-host-address-is-not-set/
