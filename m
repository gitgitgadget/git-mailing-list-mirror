Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD89142E73
	for <git@vger.kernel.org>; Thu,  3 Jul 2025 08:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751531192; cv=none; b=Edlym+8GSrgUYdq8S1me6Hwl6HlTEXbDqUJ/J81S5CnqWkerYcxDgLQSkt3HYo8z2Uoi8WJC5AOy5z2S9GoDktVWGf+KFBD9aTDpnqr0Ifye3ok/44FrqNcstTR/HlUtuyJecASr7SRJJX5L/bYa+Ng8qhk96bBByb1g1fuyuV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751531192; c=relaxed/simple;
	bh=WdGziK3zZ3fDl4D/gp/p2RvsxVHVKgCQry6FBEnFxl8=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=g/TuYQx2x3UIapqdkJEjGrZeKyGgagwZWUBLyBiGam7v6bqx/gpfg6uIgZs2rkVPggbd4WdSr/1f+WfnQNh00UHh13et94CRFBXk+l+sycK93nDn3gU4uMbkfRroyma79/7VmFEL6mDWAIaa3gPb/5Z2cRk9IqksyGM1ovjZjzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=kOyv9mZR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j86kjxdO; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="kOyv9mZR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j86kjxdO"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id C4C681D0006B;
	Thu,  3 Jul 2025 04:26:28 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Thu, 03 Jul 2025 04:26:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1751531188;
	 x=1751617588; bh=WdGziK3zZ3fDl4D/gp/p2RvsxVHVKgCQry6FBEnFxl8=; b=
	kOyv9mZRSwidEmgIQ+j3xubqc45DGh2lEcFRDLpmhyVSgYYOqGvLp+mLnFYFXl3f
	wpgJNw5vuZI6qYL8jE71MW55EBMHgtGuU6KbyPoCf7o+TG9Ywut+d8Y5pLd9cd5W
	+DVIcWEEwTsDBrWJ9+PX52IoDRbgibrFFekU6i2ClUXE11Pwt+MQ2KZT2qTtm6Hf
	DFzdL+K2b3V9kegP5SSndp53Cq3zqQIJ92ANw0Lgjzz0Hth+C+elG1/UWnQjvlA9
	yGN+l/CJBXMTLyROq7kEmGzsj5cd9bxfA0VlCysVti2vlRmjAZnngUhH19ZdgR6d
	OMlrEWuKKRWLzVJ92masmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1751531188; x=1751617588; bh=W
	dGziK3zZ3fDl4D/gp/p2RvsxVHVKgCQry6FBEnFxl8=; b=j86kjxdOK1Gtn+OeI
	u+HoRxSVl1UREv8ucDeA6s890q45dUqL3yNkbBAiFjlfmoVfR1yK45vb06LOJpAs
	ibOrwCKI53GePcAVYtJ1wDVJYFYWzByvKMVCPhKJK04Id4AR/S8MH4NGqMuXvJM+
	twZqmK8zpGMmgBwayxp0upE8IljY3icuAtRRkGXjva+ESmbraSiPH2siZal3ocwu
	VFftLJdCo0erQSH/7XoF44sOlw79/vylv9QtDSMgqRVhNU63YRjelPvk4yCA5niK
	xK4EMHqff9UkEprevQcm8KgMXLHx5I38uCGHAip1A6M5RSIlLJEcgzbuFKm7z5yP
	6zDwQ==
X-ME-Sender: <xms:tD5maHCxb07Rq0a7M01wm0Dte5HmWbVTFketUdE3SfTZ2TnqaxMFZ0A>
    <xme:tD5maNhIL7or2XPQKKtlbWZNhJ34BKlHKUik9LthRGGUDM8ZimjbPD6cqHmzkBueH
    JlrZAJFOrbSuel4kw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduleejlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepofggfffhvffkjghfufgtgfesthejredtre
    dttdenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhr
    ihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtf
    frrghtthgvrhhnpefftdffhfefffejfeffteetvdettdevfeetheegtdehtdeiudefffdu
    leffleeljeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhg
    shgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopedvpdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopehfrhgrnhgtvghstghordhnihgtohhlvghtthgr
    phesrghmrghruhhlrghsohhluhhtihhonhhsrdgtohhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:tD5maClsFDBbyP2kR7BCDeZOJIiTPAUO8pf5dH3ArA7L3rnJfFIAmg>
    <xmx:tD5maJxPjloLFQRQsuWs-5edSJd4arnGe0TW1K4JPvUGGQ3JKfdg8Q>
    <xmx:tD5maMTRMVJ-tOgCEKjeeMmPWClzgb9I5bNKKkvlscImTfH6bbFKHA>
    <xmx:tD5maMYEQ5tRGUoEixvlc24c8PUcZsHNxGkScForcQiPwG_fZzk79w>
    <xmx:tD5maMvQJYVQU1RtuXTAuuWgbjvStTNOhVdnab0NK9yxEeUb9akigaFk>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 52D561EA0068; Thu,  3 Jul 2025 04:26:28 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T296588d16e96e508
Date: Thu, 03 Jul 2025 10:25:21 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: 
 "Francesco Nicoletta Puzzillo" <francesco.nicolettap@amarulasolutions.com>,
 git@vger.kernel.org
Message-Id: <099c2a59-ac60-474b-a535-ec7dcb1f44f8@app.fastmail.com>
In-Reply-To: 
 <20250703081838.190603-1-francesco.nicolettap@amarulasolutions.com>
References: 
 <20250703081838.190603-1-francesco.nicolettap@amarulasolutions.com>
Subject: Re: [RFC PATCH] blame: avoid failing if ignoreRevsFile does not exist
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Jul 3, 2025, at 10:18, Francesco Nicoletta Puzzillo wrote:
> Setting ignoreRevsFile globally makes the blame command fail in
> repositories that don't have the file present.
>
> Check that the file exists before trying to parse it.
>
> Signed-off-by: Francesco Nicoletta Puzzillo <francesco.nicolettap@amarulasolutions.com>

Relevant thread

https://lore.kernel.org/git/20210807202752.1278672-1-noah.pendleton@gmail.com/
