Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247BC29CB3A
	for <git@vger.kernel.org>; Thu,  6 Nov 2025 18:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762455407; cv=none; b=gY2E2O61SxDZVxxZN8ZBtxHJ1jMLbywwYvy4Vg8RNX5//ZO1imj+1JuWllslgIuVMu7xdFqKbWYW2ylrNuydko+q88WsGAKr9xtXE9OFWc9uOn3FBCyS0dlb72/NBHE55fvwEgYTCr35bb7KDjYn0DxpHIl+OMNKGcXTn/ei4uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762455407; c=relaxed/simple;
	bh=GWoOSXMJ1nj3Q+NaNL79MVyAzCc5dh5EnzkMyntSm3Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uVf1NmnZnrNjN5+8+1ZmOBLSZznOnajO3y1x4fT4zHgzrYj3kYHxq8esPeyEDJiZEcC8yucVGTZClG7//E3fwyGY9vmCEcg3m3lDnZllN+moX4/67mE/RV/P4Pf0xWH8kKiBJVAHgcv/MH1N6r52WDk2rCwkslmoHPMyVDeGKTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Xwz7O8Wf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=y+08+en3; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Xwz7O8Wf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="y+08+en3"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 275F5EC0178;
	Thu,  6 Nov 2025 13:56:44 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 06 Nov 2025 13:56:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1762455404; x=1762541804; bh=GWoOSXMJ1n
	j3Q+NaNL79MVyAzCc5dh5EnzkMyntSm3Q=; b=Xwz7O8WfFpPyX0FiFtEOvW6Co+
	gefKtJ7a3s6GyUImjtSXEWhHvbZtYMEnYok90auI6fRAWmXwomSBadvGKqTrzog5
	Hda1RHlF6A/yIN770tEJiHrCtOn2a55GhVZ6BIXqkYzg9Oq+bOYLOXRT8K1CgMIo
	QOSVF5xj4pXDc7FpjdEVWCddaNo9ps5BSQWjwp0bh8DOS6BDLf5iK7xiS5Edc8XS
	VrMe1D/es77E24vnA0JH3+wavZgcsf611qNSC1CHfYhioYJ55SgafouaRzrxM3l5
	MBM9/VXqYwZpOUL7ybiqDAZ4vMFzzh/QnMQ7Ka+dOmN7XSl5nIxaHOJkgCDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762455404; x=1762541804; bh=GWoOSXMJ1nj3Q+NaNL79MVyAzCc5dh5Enzk
	MyntSm3Q=; b=y+08+en3SiYS7qxT+5uVXz7WvgkEqwgp6o781PdkqZp+n+x2Op7
	UrQNr9kqCj2j24XPvlTIVvldrWYc+rvBlUVuKxli4Dgr++hhTk+KPFJi2sJgUkrN
	vYJty8sES0uorBX/a4iGDBe/G8vegMHK7U0/SeBnZdx/1DrbmiVifotrNVErAxwU
	HtlJ4NnXHBgxCb5iiOwmM66ByzK40WicheJfnQ5V734MMBK3kekOlTSOs09dcHNE
	M9QVL14KDxi03G14qXz0FwdfwmRNfhAJJBQIeT72mjhu38yjI9hyBiBFBwJ2FaIP
	vxgztm3xDkLP/ezevQyMushyQav5fTv3lfA==
X-ME-Sender: <xms:a-8Mafpyqy8VmGwZMfGEU5gCHSzkSfc8W2hF6BWhAPHXXvsGySHoZw>
    <xme:a-8Mab6Ukh7gSv3MKJWLwRNv9EHMO94U-6W35rr2GkFtIRgEHexv6M5Ppbu4XTF8q
    K7YpS04enDq28NHoCSeG09-_7YStPM34WkN3vZqRqBRqOPYhQVlkg>
X-ME-Received: <xmr:a-8Maefkd4RoPZREkliVpFAdic4bPbfbB4-uPb5L9O9n_ZWhDYsCuZYkOpUhc7-GAKTSD3roUP07lIwZTS9r6ECXcMf3gwm4O_Xm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeejheeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehkrghrth
    hhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomh
    dprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghp
    thhtohepuggvsghohhhmrghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:a-8MaY5uVwTz5ZI38gbsT-o-Awx7rnWM9uMvnUY93rCric6OuF3-GA>
    <xmx:a-8Madt6Kr0patqo8WpWiBYYXEEFBs3lGxQeuLFMRu5gcwTNRgbv5g>
    <xmx:a-8MaQhxqDN0uDAAmIm8SFknbb7b1x70cmzPurgn3JmtbBKy4rW5BA>
    <xmx:a-8MaQqsf-vTsL3dGd3g-dlG54VJnawivjGX4t_DxXiZJLcUAtl2GA>
    <xmx:bO8MaZhk3djAGgzlw9eGNsKJ369OIsOdkTvH-D4_E7MRBOS0MARqT4gY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Nov 2025 13:56:43 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Karthik Nayak <karthik.188@gmail.com>,  git@vger.kernel.org,
  jltobler@gmail.com,  sunshine@sunshineco.com,  David Bohman
 <debohman@gmail.com>
Subject: Re: [PATCH v2] fetch: fix non-conflicting tags not being committed
In-Reply-To: <aQyLfD_zx0ndCLvU@pks.im> (Patrick Steinhardt's message of "Thu,
	6 Nov 2025 12:50:20 +0100")
References: <20251103-fix-tags-not-fetching-v1-1-e63caeb6c113@gmail.com>
	<20251106-fix-tags-not-fetching-v2-1-610cb4b0e7c8@gmail.com>
	<aQyLfD_zx0ndCLvU@pks.im>
Date: Thu, 06 Nov 2025 10:56:42 -0800
Message-ID: <xmqqwm43gfbp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> We now have three different callsites where we commit the transaction.
> It gets better due to the newly introduced function, but it overall
> feels somewhat fragile regardless of that.

Indeed.
