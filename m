Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDE73E8C76
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 17:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772041351; cv=none; b=LH73R14ZC9iY6Y3GU/LBY3LPZtm0W16kBXg1Rve9dJDtp+lG1nluFApDjzWozBt3ym66E/cgGIdvx8H9GRqdg/VvaJJezH+pWbddEqG+zArSaUrWMus1qdPrLBBOd/ed6Wz8+1deTnVaf7X3LL2RnC+BpZB9/uN1hxIrZdZKKGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772041351; c=relaxed/simple;
	bh=WwItY2YDR0awjyimnnEGOPUbUgWb0rykEgzxyyJEC7s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SGcFNvzZQGFdIl0e59awvkPOCMHIBvI1zDr72zP/GhoLzFL0YNxvW/qmRCdd2RvPm2uqBLycRycx8RtQLlMB7fxU+Mq5ROZv46vZDWCRtF/pO87wGT/TCcYbbRauIeeUzp8UfB+r1pc/mKOABWQpdHbygEVPgNALR9n3c7sA0Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gv/ZyLYZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pcOizTEI; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gv/ZyLYZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pcOizTEI"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id CA311EC0305;
	Wed, 25 Feb 2026 12:42:29 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 25 Feb 2026 12:42:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1772041349; x=1772127749; bh=gbC/G+wk/X
	GAk66dODWP4Roy+iCeT8HlgOqbkJqfILY=; b=gv/ZyLYZdbVPX3W9A9D2He66/Q
	ViPD089S32awcY4mfhh+N8CVmdIc52QLb2ujVfU2Q3yw3K59miElPLVRPxmHXrJy
	opycsx4+3k6XAuTjtCJVqfpj3AZrk7Hr18DAnrECIHLo5oQ9tEGcHGMJ4Wdv+XbW
	loFUjEhUelNJ2RVg8is3mKZX76PJcaGQWyYfGI0dFFkXRHVUHjhzohoz1cXgT07l
	K+KpEXOq5oOSepl2/IpPmoeVchIloISsvjoQT2Z8WcRv/iRetGwLT49itOnmgbJe
	DoMKh/HhKuW4Xj3PE2BgQBL2pkcyW3jPaz9Py26UCwK9ycrpZSNEYU46ghTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1772041349; x=1772127749; bh=gbC/G+wk/XGAk66dODWP4Roy+iCeT8HlgOq
	bkJqfILY=; b=pcOizTEIfYRSn66uVM/LUN4Ivu/41sxGWuhp8yhQQ0HLhmBMVo8
	0Iy89j55I90qTyMHPztzJ9zrQVGeQGAm+am7SU/VhfjiDHQ1+nN1w8kwfVFUXUsX
	gfn4aMlo71WV8NEcfk81P0u3P9UOJfCkn9QRfc/AEgbGx0V/0wP84EE9W2dYf8Jq
	yuexVpXHA1BGNl4LP4gGsWiBUkV5jnAuZ5Dz9el0YX1yIbwL92Rh1PgPemJrAk40
	Za9R1yrp/yF/PyA1GdTxKU2chR/JllsCk+agR+DaVAcgcoSyszrj9EN4ac136KqW
	IiJ0oObTXrW+C3eki6M4vl+2T2smHZUOTyw==
X-ME-Sender: <xms:hTSfaSX-S9XGEUZcffqCRCffVvgFt61bOMnY11hvP-UVVUVprzs-cg>
    <xme:hTSfaVda-ZJ2tqI1pHfhVHnklm4Ywg0Cx7Mru_SJjXZ5Xid9WorQVHaJL_CWxry4S
    2YUv9coHTCYtOOWOE0ESSMaZ3uuW0_ZD4Zxtqn5vV--bGBlKID8Kg>
X-ME-Received: <xmr:hTSfaesznPji8Y09H8nFmm7y0QNKLfTiVXK8_dNLehXsgJ1w7NSXawqFYL-Cvm8ydmSJqcUEtCAXE9okmmtn9l1QMglzwxkbAQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeefjeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    phhssehpkhhsrdhimhdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:hTSfaU9nbF3RuWYyMBvyC7fekqXyhLzlcJwnEqEQt9JjDvm7kFCafQ>
    <xmx:hTSfaZ2z4h9CHkZHmnTsd8vO7VEx_z-F7ey3suDd4QTiZ5ozWlRRuw>
    <xmx:hTSfaZDhnf-tXCjK1XSY4MJDZ_Bg5NX-HyjG9Iahe_J6oLkMA00Hcg>
    <xmx:hTSfaVey2dVTTRXLqoDK6bNyc2_Cjg5_oLK5jhgFfhxRUunZMvJD7A>
    <xmx:hTSfadYO4uYXchDMz428Hcd2XFKysk6VuFa3dlOhacjRvp2qkaGRFciq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Feb 2026 12:42:28 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  toon@iotcl.com
Subject: Re: [PATCH v9 5/6] refs: allow reference location in refstorage config
In-Reply-To: <20260225-kn-alternate-ref-dir-v9-5-3fe118e40e28@gmail.com>
	(Karthik Nayak's message of "Wed, 25 Feb 2026 10:40:45 +0100")
References: <20260225-kn-alternate-ref-dir-v9-0-3fe118e40e28@gmail.com>
	<20260225-kn-alternate-ref-dir-v9-5-3fe118e40e28@gmail.com>
Date: Wed, 25 Feb 2026 09:42:27 -0800
Message-ID: <xmqq8qcgbtz0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> +run_with_uri() {
> +test_refs_backend() {

I've been fixing these style violations (and another one in 6/6) for
the past few iterations, but forgot to report it.

Hopefully this will not be rerolled and we can merge the result in
'next', which would mean that I'll do the local touch-up for just
once more.

The changes relative to the previous round all looked sensible.  The
changes to the tests to swap expect and actual so that they correctly
hold expected and actual contents are nice touch.

Thanks.

