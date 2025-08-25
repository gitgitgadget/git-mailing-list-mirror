Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6E4277C8C
	for <git@vger.kernel.org>; Mon, 25 Aug 2025 22:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756161991; cv=none; b=CRYzx04xrMgZkMiihwzyF8ozVRLUWJ79lEzEdUGMQTtbAmHGoJuayR5g/4sQ/i9Vpuf6dJoP/vgCwbP4mGL0UgCSoDqshBl2Hs55y6PEWDnsH+2ZbRQc52hA8653UNN897i3QFJtErwjLW7IuOGbSoxKr5ChwDG7SdirR46X8Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756161991; c=relaxed/simple;
	bh=2K3xvYjHKv12lv8d8rFC9tkeerp/i/7QenKurA6yDhI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jdpbAmslEv+KmM4bdLGaOUCzLx26M4kkbu9U/0MDqkwgk5rmFE812L7a4jIN7p3yAlHbiSRT+DgxZVru76RnDLE/6Jtg6dn5uacV6DsC5ROuEien41m/zZrL2p5Phwgm2oo/DMoDFVRo/aM2aoYuceimgMm1Yh83ZkuOvN5kx2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MR+1ZH5R; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IesPwot5; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MR+1ZH5R";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IesPwot5"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id B98C9EC0443;
	Mon, 25 Aug 2025 18:46:28 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Mon, 25 Aug 2025 18:46:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1756161988; x=1756248388; bh=QDMmJX2GRN
	EKmU14VQWi6Pk2RNcib2fMPtHFjLjlLA8=; b=MR+1ZH5RFX9qE9WzO3GXCNqsaj
	OM3aq4thN14k3NjzpOB/XHAn+YwZ+mphSN4yPHB3X5/6JiTYtlsn8IIcgM1xb7ds
	5+HAw1V7JIwMiJHFPJ9UbB4HgonEoi/IO35ntc3Waif223UNOrnaDPLUId8Om2gi
	KRzA1fGyRLCs7OBj2OxkNGueshBn6Tj6u0NeXKLguyBn3y25xVSHQrARAt4ZcIny
	iTjlXAAfSIpzRYDLcvU85oFCnSyaHGYnSIcvkpxJiL13ZwSEY2i+wd6+egL0cmPl
	HKgE6liHSJDh+nNvAH7zOXBk7GqAg8p64UYakbPpYVtw7qdK10i2r8bfI2SQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1756161988; x=1756248388; bh=QDMmJX2GRNEKmU14VQWi6Pk2RNcib2fMPtH
	FjLjlLA8=; b=IesPwot5NgT2ck/Ct19ynrNgQevLAqsfj6ef4aUUoqHbEh7uHDT
	x0fALfQ7+YNfOtKjPQG8n5Jbt1QZ03GChHgvQI3n+gLbxUuup4kqfsa6U4daDbUM
	sPI9d9yNwBV+wyKs1P+SF77VJdYpxlpC06S+E5hTmwkaGuNjFlgApFSS+nIO5R05
	fAdWqUva4SZ7N4jnuDpTg71G2P+abdTn9cbHxp1XGwDKL1B86uREMB09z2kCGq3e
	/xkvrXdFON//1cLJOonVh83lGbq6n4VqXzqSa9fHJCwzzb1Jvdrj3TvSW4rNQ7j5
	ILjdBHZVQftSvIhdVSb8QPTuNYJaUN8t3Qw==
X-ME-Sender: <xms:xOesaAvppS1z7M2RZ8pzVkqMoe9XBa15KSuh0SneD1N4izu9OS6r-w>
    <xme:xOesaAskphP9ByOGY9KCoMMuZ-CEKpapfpOA-y5-lbM5pcfc0toKJKCyNKCF_M-Dd
    wzIR4IVrqeOTBhnrw>
X-ME-Received: <xmr:xOesaFO-DU8_LegSQxICuELsDj56yILrSVXjQ-DJ6aV9YYxDusGR19tPNU2SjBcDwgRaLinFuQLyCoxXkyI8ZPeqjZRnvfcx2T3Qh-U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeefiedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsrghnuggr
    lhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:xOesaO0WvtoSn-O1_zfoYS7WrXiiJUPV3AilXpaZlMSP2Nr9fP9VkA>
    <xmx:xOesaBMylp4PDqTxFqELw0V2IdR_OhIRseq1j7s0DyhjwOjy1cvAMQ>
    <xmx:xOesaO1tR4hYscgGxr8dKmgMGxluU4UYQJcjbGOQ3nbDZCYG8aRMPg>
    <xmx:xOesaIF813IAsFpPIxrUl4JXA_f3YqiZa7Q8OQoIm5-fUadOKwSmMw>
    <xmx:xOesaCiid6qMfTUL-_Qq3dh0KwpF7lLLwdHMD4Fkrp326pv5D4S2Xsh3>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Aug 2025 18:46:28 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>
Subject: Re: [PATCH v2] docs: note that extensions.compatobjectformat is
 incomplete
In-Reply-To: <20250825221101.611876-1-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Mon, 25 Aug 2025 22:11:01 +0000")
References: <20250823220601.336079-1-sandals@crustytoothpaste.net>
	<20250825221101.611876-1-sandals@crustytoothpaste.net>
Date: Mon, 25 Aug 2025 15:46:26 -0700
Message-ID: <xmqqms7nnhod.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> diff --git a/Documentation/config/extensions.adoc b/Documentation/config/extensions.adoc
> index 9e2f321a6d..df448da813 100644
> --- a/Documentation/config/extensions.adoc
> +++ b/Documentation/config/extensions.adoc
> @@ -14,6 +14,10 @@ compatObjectFormat::
>  	compatObjectFormat.  As well as being able to use oids encoded in
>  	compatObjectFormat in addition to oids encoded with objectFormat to
>  	locally specify objects.
> ++
> +Note that the functionality enabled by this option is incomplete and subject to
> +change.  This option currently exists only to allow development and testing of
> +the underlying feature and is not designed to be enabled by end users.

Much better.  Let's further do "This option" -> "This extension", as
all the others described in this document call themselves as such.

Thanks.
