Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A2C23BF9B
	for <git@vger.kernel.org>; Tue, 10 Feb 2026 01:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770685462; cv=none; b=WndW2CTARFo9Prg9gxTcsndBv6q9r9GYrgam2q8Q5NgiezCSoW52OvWitf45qN4x/Yj2fFlOtRZ3RoBZNCIpogH9KX8rvEusiZE2hGD/P/+u6koaQLEnn1guJr4k2s/X8cHWMD2QmyQGWgxGRXGS1Zm/dqr9+bSojdUApyGQMgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770685462; c=relaxed/simple;
	bh=F8YAYoPHaxcaxLH0a3dVwqPxNmoO2tJp4kMcTz1dHIE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=X/qHWOdOpO2FtwnL9yvObIy1D7d92Jusr6Aj/jlwCVtfDXWRyoBbftgIfIx3A2jH/gJqpA5aHy77DaokAg5AuVt+kQZcHZXiQ3z9XdC0uTA/6ryVxJUduVHpiPgpqNk/vJBlffRIliH8qcVSOgCO38LyiKnYCCbK+1hHTTV2Izc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TqeQ7RtW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RMwnd0AV; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TqeQ7RtW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RMwnd0AV"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 89002EC0595;
	Mon,  9 Feb 2026 20:04:20 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 09 Feb 2026 20:04:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1770685460;
	 x=1770771860; bh=cJ2TJ07Z+pjHlK6tLVuzCY/7REPb2Q/LOlPs9n66CYM=; b=
	TqeQ7RtWKsW+SBg9lgEUvi2r0+EK8wDK9oRwnOZ80KhuYoR5twSQYMDzraHFjwKL
	W6rQyNlQT+08HA377uGkDU6/pvqIfpC052cIQXj+CYLqAUe3y432AsyuFjhcrP+s
	NzL3ho/1cnurTxcgXI82YzhQLTErkuWKF1NbgSP0vNT15NdBG7ciV0frpnNtDe02
	24w+xPZl8HkYH/pfM6z2wMcbdXl9LDjj5gW9JZiMWs6PDVYuASWbi0PZakHKxGtX
	k+MVtDtoDQjzNEc5cAwWq4dKGgVb1G8eiBa6sGeG/1pNU4aMrNXjrvo9/TzaV1w/
	44ySBCXZwLCP+4tDlg+p1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770685460; x=
	1770771860; bh=cJ2TJ07Z+pjHlK6tLVuzCY/7REPb2Q/LOlPs9n66CYM=; b=R
	Mwnd0AV5mY5CDOcwPSCQF/BzE2tnwKkqcnwseyW/LOR8abVssKF4EiYjf8Aj+3xL
	GPtjVHzE0rNB0F8lS743OJU4ijHmyY1rGGnNqBJRn7U6mYC500Xi0plqvM0gELq4
	YCmte088fQDP4vl03RawvGcyX2N5GfVJQNe2/DoHy09kjG6Cxaf/ElIh7NN6qxWD
	8AJyo6HWVkL9g/hMzjwsVT+2qKNTNza2KpQv32V1IGk+UaSpPsRs2A9vGoLHesMd
	wDIrhFOoA8j8RMk1+hyyCztKtznluydSDjyr2Tu0U+LUsx4tJNU+mTyWU7PBTHFx
	KbzQUT9e7qs9xzKc7ap0A==
X-ME-Sender: <xms:FISKaaOm-8So13LW_O8gwj81H78DqwhDNg54c9PwYrcxXB4oUqGDKQ>
    <xme:FISKaf1LTQp8-gHvmMbT2JbPozWhLHIRtYWWJ4yusAT56ZGpWO_XZUUceTCQl8PDu
    MbevnZAwjv39uF8Qkm2CS0A9bNAS5TbGQ7GUTJNHZlIbGipMQxqBw>
X-ME-Received: <xmr:FISKaZk7fet0a9UpzJL_NhoOB8AyUIY79Np-s9KlRqZ5T5WJT8JBvPSQ7lijVtDM-fSZC2foEzotMQXmMbohPh_wJdxWrazZew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleekfedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomh
    dprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgv
    thdprhgtphhtthhopehjohhnrghtrghnsehjohhnthgvshdrphgrghgvpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:FISKaWUAi-weBirkJrhNsArkAJakookm7jCohoUb7g0g3f6pct5pGg>
    <xmx:FISKafulu8EZiXFKY6Tn5h_IU3_vUXEKBKxWt0pCpfol90rs5dVasQ>
    <xmx:FISKaZaHZcXSn_qVFtkkpaeviThS15Eaafcslr1aRc4SAxwDu_y5DA>
    <xmx:FISKaeXGjKw5LPdmaeIvA7-NB3Ngtpeh-rxXZPG3zSjZ_y8cim8YGQ>
    <xmx:FISKaYybQX26IpVvIPPIbpiFSsPAEb--yLAFkfyZtYfwBR-GZyMSmohK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Feb 2026 20:04:20 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Ben Knoble <ben.knoble@gmail.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  Jonatan Holmgren
 <jonatan@jontes.page>,  git@vger.kernel.org
Subject: Re: [RFC] Support UTF-8 characters in Git alias names
In-Reply-To: <D96BCAD5-5482-4BD5-B22E-82D34EBC1F0A@gmail.com> (Ben Knoble's
	message of "Mon, 9 Feb 2026 19:45:30 -0500")
References: <xmqqecmt33xk.fsf@gitster.g>
	<D96BCAD5-5482-4BD5-B22E-82D34EBC1F0A@gmail.com>
Date: Mon, 09 Feb 2026 17:04:18 -0800
Message-ID: <xmqqzf5h1ka5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Ben Knoble <ben.knoble@gmail.com> writes:

> In what way do alias names end up being pathname components? Or
> did you mean to insert « treated like » (as in, normalized as
> command arguments)?

Ah, they don't.  I somehow was confusing those custom commands you
would throw into your ~/bin as "git-something" ;-).

But you're correct to point out that for a command line "git
something", "something" would go through the same "undo macOS NFD
for all argv[] elements".

