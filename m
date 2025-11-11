Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDC92E62A6
	for <git@vger.kernel.org>; Tue, 11 Nov 2025 21:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762898307; cv=none; b=GZcp9DDcF+Nu4pJimVkxy+GUw2iYKX2gaSb90X9vXrL1VkCS4MvIWT7GQuUP5rdsf0Xp+1WNCb/gijpcIZr7SXAHCIEgLD5fOEz9av3WaVqWhsp4OxoqEdmocI3z+0v928hkC/R9zPn74PJgpnmR/ppHL3e3ba7xa5o/Cmj25Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762898307; c=relaxed/simple;
	bh=r89v9s3uVufhB5watuyd6es/OgsX2qEoTxjGgwm2mAw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nEp6kgkpZjkDY/73Hk0pVKFUyaqiVw9RTt1G747d9OYzxU+g0JhBhbVjJ6yCtCX01q3qr2bob8Mm0pp4gLJWv4VgRijEP/cOIOGYMfxoA14mWFhhpoAcgslF6xYXJXDGk/X5jViV+lnSthafh7nWe78yx5khGPHnwY1fS8A2C90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=I92e9BG7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SRM6ENjW; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="I92e9BG7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SRM6ENjW"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 03F127A00EF;
	Tue, 11 Nov 2025 16:58:23 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Tue, 11 Nov 2025 16:58:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1762898303; x=1762984703; bh=BeUJ9YZD5z
	l/craBablmgwVL5S3Zo8uCCMZlelXLfQI=; b=I92e9BG7kb8OoiuDCzY/fLYUwR
	7m+1vFowOqwNhkNsFY3Zrt0yNaeII25SZ3YyUbrJ+bjQrNth0r/zbrYZbx10l81x
	ay/fEXYEkXaoIFmDcyKlptjuQyNQQUSIhGZdLl0Z/hPqzX6vJslxVg89a87Si2/0
	HLO50qVjFSE5yQsnbrj8cUAzs1iYvjaiVeLgjxT2AQrHSvUZX0utBd4qb0GSaiCY
	4g2v8eTy1VBrlaWizgQCQqzfotRmhju9v/X1Uf0N0lLncmgewIV7GJVhboUSfaA7
	XbtYQjN1+r3+tzsxzpMU1C0mL3dcp5HdueLl3v8H0QZlDg03jbL+i0ioo1gQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762898303; x=1762984703; bh=BeUJ9YZD5zl/craBablmgwVL5S3Zo8uCCMZ
	lelXLfQI=; b=SRM6ENjWAFaNRbaFL1kOp1j80DDQntxcA2XUMYFvupWfQDzb8g7
	UwDjbPmRZrzYowojsIo3zzVd4dwtcoXXKafQMAeywI0F842sOyGZlXzw6QitIgTF
	+MeWZZ9RSpqf+Gyscj8Z/umj34B/aZxwzGmslJ4Gl5B1QP9Bm70g+PpijQhx8n99
	c6po9+ChMEMw59zOccHVyxXLWw/xn3qwiEPmC6WqZLZL+B8kOtZ7dgv9ywhkuFJN
	Gqy6kw9owH9H42SJQngkIqUZyygIPJQCpu686quZYZCqtfgDFd4cZ1R/sYcM1H8L
	oRM1d/nmHhzVh/prT1grAe5i+mHeEpVW5eA==
X-ME-Sender: <xms:frETaZD86FAxxkZOjJT1l6hM16Ocjp24_eJJVN1-I6hulqb_FafgQg>
    <xme:frETaYNXjAnKiJj1AbWOijgPASXeDXDSTiQrWxEWr8t-v56a2PrVqA8k7j68dYshR
    kHD54Hc-JkExKGMXjFTuyeS55_tUdgaQjrJZUnIPzsRSODAsoNfNA>
X-ME-Received: <xmr:frETaSzJ2bUirwLfDGKJXiWHs8Pb19mbpQD-dcBZ_lUp_mml8MSS8HCnJRdw781LucCv0VKlwk9h60Md2ScGfncP6KsEGAGLKUJE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtddvfeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhope
    grughlthgvrhhnrghtihhvvgesghhmrghilhdrtghomhdprhgtphhtthhopehsrghnuggr
    lhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehphhhilh
    hlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehgihhtghhi
    thhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:frETaYWPVQe9563xJatkPFDpeA3iP5UwhOyweyPQ2KaTmFIrd5Dtnw>
    <xmx:frETaUP11RYGIVnHBqj1RPZb4hmpbSv2WUs8PXm2mgy8S4HGwO_OWQ>
    <xmx:frETaaCaoLUj9e36Lb7db0HFVbUtfjBilEDBI455ihVopCyo962vWw>
    <xmx:frETaRdUWn88Vo07LRkpYVS7244K3lxab4VH5pdaL6RD9Wh6Gq_9gw>
    <xmx:f7ETaV5MwRuEpF1h96kX6VxT4owHcSkyHvHV9jyBtvW9STn7bVAWL6nA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Nov 2025 16:58:22 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: ZheNing Hu <adlternative@gmail.com>,  "brian m. carlson"
 <sandals@crustytoothpaste.net>,  phillip.wood@dunelm.org.uk,  ZheNing Hu
 via GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH] commit: add --committer option
In-Reply-To: <20251111213339.GA4053071@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 11 Nov 2025 16:33:39 -0500")
References: <pull.1997.git.1762683774166.gitgitgadget@gmail.com>
	<6be20c41-15a0-4732-bd12-4927a59a9f59@gmail.com>
	<aRIoleD6nP-kA4Xn@fruit.crustytoothpaste.net>
	<20251110201136.GB127132@coredump.intra.peff.net>
	<CAOLTT8RweGOmxNK=vKDv8w-8AJM7QUfLBw4WOKeY1EpSVeB6iQ@mail.gmail.com>
	<20251111191508.GA1907007@coredump.intra.peff.net>
	<xmqqh5v0wcif.fsf@gitster.g>
	<20251111213339.GA4053071@coredump.intra.peff.net>
Date: Tue, 11 Nov 2025 13:58:21 -0800
Message-ID: <xmqqwm3wut8i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> I just mean being able to do:
>
>   git commit --amend --author='Foo Bar <foo@example.com>' --committer-is-author
>
> instead of:
>
>   git commit --amend --author='Foo Bar <foo@example.com>' --committer='Foo Bar <foo@example.com>'

Ah, I see.  Like

    git -c user.name='Foo Bar' -c user.email=foo@example.com commit --amend

Makes me wonder if we want user.ident that covers them both ;-)
