Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E40D16E895
	for <git@vger.kernel.org>; Sat,  2 Nov 2024 10:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730542154; cv=none; b=G7Kq3HtpKknNXo3D9TrXFuyBbMUAOjoMj+rmeHbNKPZnvWk3gGgGmF4nFKWaI7axHJGyz3o6mZi7jTzWMWVR95t6gq6v3vXO3zfp7BtFjjX+lST4Fu62ZGpwKHp02TwhHnqmd/wjXXBAPVfuJr8cYZYLEAfFCH6tRnMYtlhuBf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730542154; c=relaxed/simple;
	bh=h5uWtqHkVT5t2GGrlJvWL7C5TDFeUTO9cQzUT0H8RtM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WN8Az8h89bQr2danJ2c6CiuGKG/Z/VT+AnHJJNyELTvY764wDsz73AxD4XoGI9rfeoLpt6Vz8qh7ncNqLKBCg7VKIefml0SUEgGqY0Jo0xe1wxEy5qtWixX+Mx5ezeeTi8vIxmozBQFQyzvlBrm35wPAt1SdAYyO+Vy28Z5bGLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ePyOFVJT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CtMuwWOt; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ePyOFVJT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CtMuwWOt"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3D29411400E5;
	Sat,  2 Nov 2024 06:09:10 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Sat, 02 Nov 2024 06:09:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1730542150; x=1730628550; bh=RtO1OER0zy
	+PoVIzm7pCgjbXnaTVJUbtO3SlKtoISw0=; b=ePyOFVJTdplukbF8Z/kQl2y05j
	Yq6NMQyXx4B0fL4AfVm63+gDqhjzFUKAW8dbobqDVYTh+XCeT0p3fY60gl5+LGOJ
	WQY249dGj1C4GK+WYkX0lNEtJQOL/L8p+oiHD/yOrx/d5N5T82pERIEgWvHqC+EG
	JQGo4Py65kGMeX0AdmXumoluI6mqvvIaIJU/adRCgQnT3mA3mxedGMMv/CmEwWMJ
	Jp/6VQsuHFjq64hhPWrUC6TpTyr9xirbwPnpCTpyfhSR5oERwXiSAe5oXoLQt5b1
	zQ2wlsF2gfgxQfARJQX6IjjEmheZ7B4jzs515TvNx8uQT3s6dcUz5RPDOh1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730542150; x=1730628550; bh=RtO1OER0zy+PoVIzm7pCgjbXnaTVJUbtO3S
	lKtoISw0=; b=CtMuwWOtAIbpYPV+ooNUT28ZN60/64cPuXaadxobOzlDdsvQv1n
	sxuraWSnTdtl8/pyRyP0+KLW48iP6M45EGFRsIChynQX05f5PM2H6Rwmgt/4G0tD
	oF9eHRDYWKFLqbyxxDpHr7kPToR9rJN2e2z/menu7K/h1A5kauw9295nFBNcoVpO
	B+r4zrWD/ZCS5KxcQjZ0Yes7JErNi/RAAoJ1k2jzwVwYPHmkw2OdUf2x+ZbTBz3R
	s5s1rgSkq+R42WmjpIbWsNia0paELZCNfBo4QF+V7oKpvEs+tT5wnNuu3JLUXZVw
	9xVAAtD4MH1e8nGbbM27Lwg54V1401mX89Q==
X-ME-Sender: <xms:RfolZ_XLbCTiMf_9Hz1XeHdJ-3BNRfiz9NwlpnHKFTRhUNZzdNyCUQ>
    <xme:RfolZ3kRYwXtd7P06zl3fhLSwZ7svF5FLoh6xc3ptCI9sBakV2LmInst4ROxMp2LT
    yq3LJHf4UAS_fBF2Q>
X-ME-Received: <xmr:RfolZ7Z-zU0vVI_hXXP9G5psmKA7RoSjfQhNIB8dr2ZjY458gMNNm-aN4UhhJs5bDuDa-wNovrKgOtcYeziKsiBpHgpI189Ukhc2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeluddgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptggufihhihhtvgefse
    hpmhdrmhgvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepphhhihhllhhiph
    drfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehsuhhnshhhihhnvges
    shhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:RfolZ6XjAan1m9LqmvV05Z5JMu5Gjfvgya7uwJyveb0hEfe9VK3spQ>
    <xmx:RvolZ5nvs9YRZTmfSweGvFCOUJq4dZZCaMQTKpSUMySaEp9UqgFTQw>
    <xmx:RvolZ3cW0yNawgTc7hQB1q0dHb-rEvcJAYVgfTxVw9QJ8iqJEybZcw>
    <xmx:RvolZzEMYUEHMjyjuOdI8coDXnd043-A0WwqgWAbe3qCRIXbnrdT7g>
    <xmx:RvolZ3YYqQ8ohP239R8aCLycWlbijTgUSZorgkKeQXrSN-sF-gZjxr-i>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 2 Nov 2024 06:09:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Caleb White <cdwhite3@pm.me>
Cc: git@vger.kernel.org,  Taylor Blau <me@ttaylorr.com>,  Phillip Wood
 <phillip.wood123@gmail.com>,  Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 0/8] Allow relative worktree linking to be configured
 by the user
In-Reply-To: <D5AVE5JXJ2AE.29R7FKWCHWIKQ@pm.me> (Caleb White's message of
	"Fri, 01 Nov 2024 13:18:28 +0000")
References: <20241031-wt_relative_options-v4-0-07a3dc0f02a3@pm.me>
	<xmqqzfmj2zp9.fsf@gitster.g> <D5AVE5JXJ2AE.29R7FKWCHWIKQ@pm.me>
Date: Sat, 02 Nov 2024 03:09:07 -0700
Message-ID: <xmqqh68qymkc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Caleb White <cdwhite3@pm.me> writes:

> Ah, my apologies. I will make sure to do that in the future. When
> I first added this note, a topic branch[1] had not been created yet and
> I forgot to update it when it was.

I see.  I think Taylor has done a great job maintaining these
topics, so I'll see how well they have been reviewed during the past
few weeks.

Thanks.
