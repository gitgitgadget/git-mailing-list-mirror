Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EBC3CFF7E
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 17:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773165187; cv=none; b=t4f/h1gZcbfqrXwaKw7MgAE5j1GlAH6Wu5DeJG+Ug0brmdsmA0sIJJnsaLuqoGR/F4x50OAsf3jizgOYL9X1WiJuhG52Z87cwBdlm41lHcXRtUd8Nsq6CWCyUNhzqnfBBTFGRu/6jIIa+/lhofs6Hf+3aGIj882U7B6sE2zvs9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773165187; c=relaxed/simple;
	bh=UvqNt9dJvDVAbBcO+7yL3HWLCOPOqbeW2Tc22L+ZB0U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hPbnGw6raoKNALvSpq9DuZZGvlyUxmGBg29WNdkn2GPDSVegF0YqyUX0YDgT5FuHGZz4sTb4yAw6R/00WMbD08zJTCgBVh/b9rTHxlO5EtR180pWIh5h+9IWJe9qHUtzkx/91bnyuThg4+Hjfc+84eMJ73GVc3fihsm+n/4Rw6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=F4nDpHcM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VYhpz1ow; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="F4nDpHcM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VYhpz1ow"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1D2C51400169
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 13:53:04 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Tue, 10 Mar 2026 13:53:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773165184;
	 x=1773251584; bh=DQQmYG0SmW057t20G2Iufgdbkt01KyACzqJXES1+6tQ=; b=
	F4nDpHcM/vNeoes9/SPHK71WTq1LtxaeZyDeINzOE9qZ2ZfB+UlAp1B7EziJq8mz
	oUvn9nTCD1fTZ9HiEYrwM3jQAwlhZdjYAMJ6zPmCdCMTYIxTs09QSMHZyRleJTm0
	xVthtDYD0u1Q45fTtZaqBmMKHQ944kPIjcutjewH9wOj/TBeq3jEsRPvJen5NiOY
	UHZiRBNjxOLpuUoQ96DgGUESCissrJKxJMrkufPvq0Yuubc559VmGorosM+vfRVB
	jROB5iTIimvCab+7p9clhxAGZRT0sfxAHdhv6m/nkxorJL4Eba2WYu9eYg2P8GRj
	mE62yNPRE0IJwyNRdhyzwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773165184; x=
	1773251584; bh=DQQmYG0SmW057t20G2Iufgdbkt01KyACzqJXES1+6tQ=; b=V
	Yhpz1owfB2BbNEXEkDBUS4MmKNuaavDT1ijvSE+/yDjUxkPDFMTNnGxhRg9ZKor5
	VxlgKiPEbOoW2XP+l0X5oGNyOZ/rGmEoSU0FkrYzyWkP2TIHe1c5rQQ7uvsKevLJ
	3W76/i8uHFzI7mWOCu96uMaLfdLa1ucemwfDUoc5KemhojIrpdXqaxfEYGHvPYin
	YAt39cAm/g3ly2oLuccyuvspfdecr3M7nXsS6rsxwI6sh62z1Z07YvsyZS66lNGi
	E6Xzk01ND9HMIJ+oLFyhPraNZ1M8SNh8X7xYcQokBxYa6NWhvijgHCWGkHz16c2J
	C2T2iU9gLLBFi6j+HGDeQ==
X-ME-Sender: <xms:gFqwaRelZiku7iA7v-Y99GyAFo6d0SVs6GZyCZkIrItzbudxuoaP6A>
    <xme:gFqwaWIJ26I2QNkgqMKykMsK0Deu9zwJJxSDT1jyQZWykYl2TOc45H5v-5dcX7HL6
    YRwQLWKIGuiERVPUVldljs76HmloQY6sJvgTlO02HlzaYYcGcwFxg>
X-ME-Received: <xmr:gFqwaQJ2K0Dk-FLh9P_aIuXmxyVs0pSShsHGrNXffIa0BQ7IxDXfDdeYTUFm8i6s9AbshBNBc7XNoUzTZIOwKfZ6fuLpTpFJYWoIqTtT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeduieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:gFqwaQGM1EwUKqT53JGvkYO2fjfDr0WszhwaIaTnb1SzhDsuqlxu8Q>
    <xmx:gFqwadl3WTxfsZBKD3pNNcoPKtBfL2VL3wMYQnxXl39JR9bET5-N2Q>
    <xmx:gFqwaVLqe39lRKt9HGBXS5sGmGjsoIXEFr41XWbtJ8c_X916EdhLZw>
    <xmx:gFqwaWZ638qxhW_YeBOP1ORHBrGjkvL3zPJ2F3iGjS1umYDTJvnYWQ>
    <xmx:gFqwabPdd10CbmmWpalkt4e9kMtV0gYCQMdvp4Ho2YJ3xt3tvu8kWGtc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 10 Mar 2026 13:53:03 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 151abbc3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 10 Mar 2026 17:53:02 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 10 Mar 2026 18:52:37 +0100
Subject: [PATCH 4/8] contrib: move "update-unicode.sh" script into "tools/"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-b4-pks-build-infra-improvements-v1-4-ec75d0710d6a@pks.im>
References: <20260310-b4-pks-build-infra-improvements-v1-0-ec75d0710d6a@pks.im>
In-Reply-To: <20260310-b4-pks-build-infra-improvements-v1-0-ec75d0710d6a@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

The "update-unicode.sh" script is used to update the unicode data
compiled into Git whenever a new version of the Unicode standard has
been released. As such, it is a natural part of our developer-facing
tooling, and its presence in "contrib/" is misleading.

Promote the script into the new "tools/" directory.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 {contrib => tools}/update-unicode/.gitignore        | 0
 {contrib => tools}/update-unicode/README            | 0
 {contrib => tools}/update-unicode/update_unicode.sh | 0
 3 files changed, 0 insertions(+), 0 deletions(-)

diff --git a/contrib/update-unicode/.gitignore b/tools/update-unicode/.gitignore
similarity index 100%
rename from contrib/update-unicode/.gitignore
rename to tools/update-unicode/.gitignore
diff --git a/contrib/update-unicode/README b/tools/update-unicode/README
similarity index 100%
rename from contrib/update-unicode/README
rename to tools/update-unicode/README
diff --git a/contrib/update-unicode/update_unicode.sh b/tools/update-unicode/update_unicode.sh
similarity index 100%
rename from contrib/update-unicode/update_unicode.sh
rename to tools/update-unicode/update_unicode.sh

-- 
2.53.0.880.g73c4285caa.dirty

