Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EA12C374E
	for <git@vger.kernel.org>; Fri, 20 Jun 2025 15:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750434655; cv=none; b=mu9wTJUuehwaYu/XDA71+64vXQTGrIErHrHZ9oytTMlysFp6m4+s/a6VCLvZdoGzJ2yJ73RnH/Xb5Y5hzdMkQVAgFC25T/YegQfu6rRXkOf39kSmJ+yWUH1SRB4BuKWfq8OXgh/6bjO7dli8yy7bwOi8AOmo64tEKeCvno8N58M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750434655; c=relaxed/simple;
	bh=UJwKZO28LNTCu1j1UnC2J1NBX7/WVh3xmKMV39yUPYU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nAZK7g5T9+sAKPHGvDMGSYwO5Pq9kkY9MsxBUHk2KGmES/aLy5DCyniPrGS1XEe2U62Rt+OLVffA8DJMnoRjaL3uUn1xn6S4LlMtXEVFsEbiMpRJxqP8pP6hD5lbXXAsnUxLDaCH/zHuPYsyWopcVNYDr2++Tqb3IvoL8rIxwMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SXru1brZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mJqO6nmQ; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SXru1brZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mJqO6nmQ"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 9A73513804B8;
	Fri, 20 Jun 2025 11:50:51 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 20 Jun 2025 11:50:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1750434651; x=1750521051; bh=LIsOlwzXmG
	8SRlgk6heEOPgKbW/NFgqK957s3RW4H5Y=; b=SXru1brZlq7J+GfofZp7ieDyeo
	tosxM1QnscX5LWI/SxAAlpZ94yntqpcBNQCEBsMhDcAcUllRx/WhRh6rbV6LPmVg
	StfO2wIEpom0NsE5EXSfXJbtfKIvL851DnDTOWHGkedme8rT3mW9seHADbdx5Auk
	E4OOSPr495p9d/3AtDVj6t5t8pLCz8xih9Nt3pvy1+Mj4s5OqQmY7dlK9PiGUS5F
	aFeGGcYS2sp5NUigPHXkx+RI8hXQdDUMLuCB90KgrdeAKI+eaL2QhRg+YQKG+srA
	6tHPMDOE2fu6hri1eAuNjqIrG77ITjf+X8DMZBecO1cniK1voLuuw82WTLmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1750434651; x=1750521051; bh=LIsOlwzXmG8SRlgk6heEOPgKbW/NFgqK957
	s3RW4H5Y=; b=mJqO6nmQQIY5TrXKMc21fwReYVxAEauQPQX6HCldmd+6225MYRM
	gDdcPwwKw5Nq8vygfv1U5wcJ3TvhhHLjZIuX/umWJ3Y19Xs53MgHma9f5X2vblN3
	OCtlXVajGlAY0jujKhP5z02inRwWgFyJhFSGRjTaan2SDIfG80Nl6pwp24RY0rVh
	YBwA9l7ehqThAHUqyuzT5M41jpFKWwwtGWM0PC69F7gMjJNhUDYS4GFekpYp+EOd
	+MM/NIPYwNdfyDvAi561c3jIsBdONA/eg/+76rc+jals6wih3FLbpbIJF8AMAS6t
	ELykIvRbM3rnOV8aENn2ee/KrDHcGccD7tQ==
X-ME-Sender: <xms:W4NVaAMQnk1LH8uRZIL6A6JzynPAvsEOQCNzhZq4BOE_YCgjk46PdQ>
    <xme:W4NVaG-fabMKXs7b9lRQ0q-V1LvdveSzp0HVu3VnOX14EJCMtJ0w1Bv3iL9GviLdp
    0GAkwEcFLLQ-qDVSg>
X-ME-Received: <xmr:W4NVaHT06nxMIKyO-duPsOrTaMmaqDaxdnYFylB4wileKsgXhrVp8ehLArEhS2gzoZ58E--7EkBVQ5resoedEkovJnLTCtKfrwQR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdekkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepghgrrhhgrgguihhthigrtdeksehlihhvvgdrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhu
    nhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopeiiihihrghose
    guihhsrhhoohhtrdhorhhgpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthho
    ohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprh
    gtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehp
    hhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:W4NVaIu5fX_Af1vgRiNIPzGWhsyZ8sO7L8Gy2BM-T1LU6rBxg28X0g>
    <xmx:W4NVaIemog8NRjHL3q7sBkHQD7L5-XhNry1Ra-lQbQWJY76H9NTSow>
    <xmx:W4NVaM3NOOGT7Sublsy94xbrQQk1CF09zURVbsKtSJwaxFdZ5B2aNQ>
    <xmx:W4NVaM9fr99B0jkTAlsFvsYnL2ZCFBaPNaIoc0EYfHyku5WZVt9Bkg>
    <xmx:W4NVaD4nZ7qIRCQZlMkBUqCkah4eoyXQoLJWNVuOasctflwfI-_akcBm>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Jun 2025 11:50:50 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: git@vger.kernel.org,  Eric Sunshine <sunshine@sunshineco.com>,  Zi Yao
 <ziyao@disroot.org>,  "brian m . carlson" <sandals@crustytoothpaste.net>,
  Jeff King <peff@peff.net>,  Ben Knoble <ben.knoble@gmail.com>,  Phillip
 Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v19 00/10] imap-send: make it usable again and add
 OAuth2.0 support
In-Reply-To: <PN3PR01MB9597F9CAD0DA83152E651194B87CA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	(Aditya Garg's message of "Fri, 20 Jun 2025 12:10:23 +0530")
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB9597F9CAD0DA83152E651194B87CA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Fri, 20 Jun 2025 08:50:49 -0700
Message-ID: <xmqqh60a4dk6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aditya Garg <gargaditya08@live.com> writes:

> v19: - Use xstrfmt() for OAuth2 strings and strbuf for PLAIN.
>
> Aditya Garg (10):
>   imap-send: fix bug causing cfg->folder being set to NULL
>   imap-send: fix memory leak in case auth_cram_md5 fails
>   imap-send: gracefully fail if CRAM-MD5 authentication is requested
>     without OpenSSL
>   imap-send: add support for OAuth2.0 authentication
>   imap-send: add PLAIN authentication method to OpenSSL
>   imap-send: enable specifying the folder using the command line
>   imap-send: add ability to list the available folders
>   imap-send: display port alongwith host when git credential is invoked
>   imap-send: display the destination mailbox when sending a message
>   imap-send: fix minor mistakes in the logs
>
>  Documentation/config/imap.adoc   |  11 +-
>  Documentation/git-imap-send.adoc |  68 +++++-
>  imap-send.c                      | 405 ++++++++++++++++++++++++++-----
>  3 files changed, 407 insertions(+), 77 deletions(-)

Looking good.  Will replace.

Should we declare victory and mark the topic for 'next' now?

Thanks.
