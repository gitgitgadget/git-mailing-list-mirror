Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1751A9B4C
	for <git@vger.kernel.org>; Wed, 21 May 2025 07:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747814183; cv=none; b=RSBKk8BUsMza5YiXSnbdZYb3pvw9TaK3CdteDUAJpIVloE6UD30NJYWwDHoj6fa/23q+a/G//i1c0gH8SRLEvy/iAq9UtgB+9GIIDAnhabaHVrRlsnHbn82JdZEQ3YuUfYteibGZvPObNBuMe2LApBXAVp7a6fxbKzVQcDBh5DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747814183; c=relaxed/simple;
	bh=+Co9um485g3J884RubL1PJwXMXv4btdxMQcmxTmXZf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mCqHjaEKtogYIvmSCLN2hKVNHMX7rbQwMeNCENaH1QP2A+j74qminyWAE7tZlHv7Tx7jUuEygNb+sfmBI5yv39P0o92OcaC+uSY3Yi+7OfongxtnX3xxR7owLQqaYsjPvlX2kGSFgFkyAwIqVD1MKIsmBcaQPTANDtJyxdPgK6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=tvDHbjYb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EqG2E3qq; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tvDHbjYb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EqG2E3qq"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0E967114008A;
	Wed, 21 May 2025 03:56:19 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 21 May 2025 03:56:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1747814179; x=1747900579; bh=1lxrj4UNuV
	wqTnUMyS0GSX5iGlL1AqZ/vdkr5/XWX7k=; b=tvDHbjYbTEuFhzfBDF/RxgSWff
	K1TxXA6zQT3BpQqDLaIPqN3z7XEgQhHSjft15VRMZMr7cY1zU3HoiVssZnLtZtA3
	5+f3QeSg0KhdyNCBdlrWQ2rsApa4qL6uozxNcL81B1lpRE2dXSqaIfGzS/SQKzx4
	zIJ9sZVaz0k3/hpAYHfzsbAyv+rdve8e3zwxUfiZelHaeGjatHE3RBztyAn1w8k1
	YCgtBx+rV7bIpNm84ez27qtZld+8ymwlEcM9h5bCbrM7Z5WA0cUOANrx0xTwJwVR
	jc5jbQXbq1ZzmO7Etez8SWVrfso61BH+KkZ1pep5M9UAtcp3lMRQR8fbn4PA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747814179; x=1747900579; bh=1lxrj4UNuVwqTnUMyS0GSX5iGlL1AqZ/vdk
	r5/XWX7k=; b=EqG2E3qqURAYBbp+aAiXc9SV3WKj1XkOlDoNAUcNsCY0tGyFpg0
	gaQaOsVMKaNdrAWVvxjdiOQ9oRLPl6M9GwTMGoDOvgvtMgmKVt6IEW7c3I66oFcE
	1e9m+YVSEIl3uwfu9xNY2XTh/+DE8n6QC3cfThBCD/dB4q4uqNiYOowytc/tDKqp
	XIhBRt5Ffdcc0CclGKlEGjk9H8uhDmsEllO4ndyWUQ1RJGoAMOxAz0aeROj4XjNG
	ZjzkYLz8w5PhoY1mjn2XH70sOkhrOfSMwhXUnxmPs5v5CLpNe/sYBx9y8Lj5AegC
	W3wXYTsRf9nhAIBobvhTdgYdFE1gDB0KvqQ==
X-ME-Sender: <xms:IoctaETYob4s-9Uzs9Iaw17jet_8Vi4Ypeo0HIKZWqrZQpICIL11iw>
    <xme:IoctaBxJ3DGdnLntnZRYBA_kDA7OgF_m7ophtF389ZxxGbZovsewWjBddL7eIffot
    af8oHR0qt19-26Nlg>
X-ME-Received: <xmr:IoctaB2hqslVEG0ZF6n1JbNAk2WbT2flCR8qBgTEXShEqajXZEyiqGaLbQ2c_BUnpp4pe_3Gxc1R6_f9TW3Z7KYfrJDNFqNqEQddxBzkwrlOUw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvheefucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhgg
    tggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrug
    htuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludei
    gfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghp
    thhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthht
    ohepsggvnhdrkhhnohgslhgvodhgihhthhhusgesghhmrghilhdrtghomhdprhgtphhtth
    hopegrvhgrrhgrsgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtoheptggrlhhvihhnfigrnhesghhoohhglhgvrd
    gtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    jhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggv
X-ME-Proxy: <xmx:IoctaIATBhw3BUcaK1N9wEtWVawOXg-Y8nbxpmHTj_0yfXevRXwynQ>
    <xmx:IoctaNgRX5q3AwKEYKztLv3m_70s1AjN-qfZVic7lfbRFb9mqeBqtQ>
    <xmx:IoctaEpFiWg7d4ok5RocRxlso1oiOT1tvymoQ94m6SYmeRoqAmU1LQ>
    <xmx:IoctaAiOiFX5Jp86Lh70MIMaPT7WyzaaAF2X0pFlGeV-_JDqWYHs1w>
    <xmx:I4ctaEhONNvZbqsXsvn9up8jthibFZo3VpIQ2b98vOkJnlim6gmM7YRc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 May 2025 03:56:17 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f1093ee5 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 21 May 2025 07:56:15 +0000 (UTC)
Date: Wed, 21 May 2025 09:56:07 +0200
From: Patrick Steinhardt <ps@pks.im>
To: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>,
	Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Calvin Wan <calvinwan@google.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 2/4] editor: use standard strvec API to receive
 environment for external editors
Message-ID: <aC2HF1VEosDMY_A2@pks.im>
References: <20250520193506.95199-1-ben.knoble+github@gmail.com>
 <20250520193506.95199-3-ben.knoble+github@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520193506.95199-3-ben.knoble+github@gmail.com>

On Tue, May 20, 2025 at 03:34:56PM -0400, D. Ben Knoble wrote:
> Going back to the introduction of the env parameter for the editor in
> 8babab95af (builtin-commit.c: export GIT_INDEX_FILE for launch_editor as
> well., 2007-11-26), we pass a constant array of strings: as the
> surrounding APIs evolved to use strvecs, the editor code did not.
> 
> There is only one caller of all 3 editor APIs that does not pass a NULL
> environment (the same caller for which this parameter was added), and
> it already has a strvec available to use.

Okay. It would've been nice to explain _why_ we want to do this change,
but the change itself looks sensible.

> Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
> Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>

The order of these trailers should be reversed -- your SOB should always
come last.

Patrick
