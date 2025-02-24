Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCF4206F38
	for <git@vger.kernel.org>; Mon, 24 Feb 2025 22:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740437439; cv=none; b=KclStXTXBFVp8Yhp1aGyIOwhxKXnvLMCBD2rnI3VHBb8/Q41i/ZY9BxPqCfq7SV8Q952n0wR/8zGoVjDVOPAU6kq1IH6kBRhriTcoV69GnosXm2Ebh90tavNISF8oymZ+lt8CWtlLjS60vhg+q/Ae/Z9ig1wHh5vn30IMVZJv6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740437439; c=relaxed/simple;
	bh=s9wH2HhKX0QmXUuHZHef3T4BYVP3dYAb5RrhqNgyQ6g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tlWrXalRTMZAB5kirUDujlaUZruMpg+auKmGkrONxFYCRX58/hDOgRuauf0GTZLnW3ktBOhjZ/wsNePiGhFnvMGj6A7LA+7ymVTZTApvZH14hM1jJ3Nu6xgAKQy6Tqk7RQWVPsz8ZeGbxZK5n3RRAvw/Yiyp+V2GW7wp3YFeW3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XM5stVvk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oybJsFZU; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XM5stVvk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oybJsFZU"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 2CED511400A4;
	Mon, 24 Feb 2025 17:50:34 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Mon, 24 Feb 2025 17:50:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1740437434; x=1740523834; bh=2zDvWiz06E
	Yo9hAZs7RAWDNtgkNDdNGcIoJOUIDKW04=; b=XM5stVvkjMsCztl/ZCnZUEQBJG
	EJUOFmI7I08qcAi0Sz++QrWmoYeGBIUMGhpmQBb3/tNx0xQ1NUbeAXJhbB5SHHt3
	RKWXqWaj9gmIQDy0kMNJ16QT+12jMpy6FwbVzUUrzWS8+TYsiA6pmFodCMR/nDAd
	JYXc/auyYkZ0W/AK71Y+xIy6fsoTqQVSqAmxgDwre+5aA10FfxI/406g1wnIW4CB
	T0PX3Wqwf1tgUXaiauTLRhXXChV3nSAOWF1GdGN5sRAInjZSa4kqV4c6Pi6tWeZd
	GHGtc8lTUgJfo0trNxGJuFx0AHZ48QwAvsXGnQr07ZUUWU4jxF1mtEyAVE/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740437434; x=1740523834; bh=2zDvWiz06EYo9hAZs7RAWDNtgkNDdNGcIoJ
	OUIDKW04=; b=oybJsFZUe+eFtmnvashregI7rF95gBLqTb0v7UG6EAirzxk1yKc
	6CihWxVjuOkcQJ/y0g7iM38+S8vF3NzDpnUXfQ8CbwXd9DK0bo1Y8XOK/WcKLP6K
	7t5kSsotnBf34t3BKRp/DbTarAldCC8itwB8hdC3mpN+VeAJhJZENp/mz02gUXpc
	MDbf2VLnS1+kg/SPND3I0jU7BqI+naOIRF3RbdAo3dyh7Yyo/YmZ7PaX5EFkup6t
	/oKyXR+okyNXyBVH5IQTB+ijT03joLgBI31Ai/C1wNQfXp3mbM9Bf/fg54vbWhGA
	+XTKxqpqakA+VAKWQdOwYuRhoquBDsJdWBQ==
X-ME-Sender: <xms:ufe8Z8sTkgXzOiaX4P174wEJEbYUSbJmnTnfYjUHRzRan6-EC9xFQA>
    <xme:ufe8Z5frFC7jifcblYQtTi0q-A_VxwBD4QMdXJeXmfAK0lpPBiIJSaiY3aEeW1nqq
    _dQSPlj_y9YubSvFw>
X-ME-Received: <xmr:ufe8Z3xRJoN-ofbO6hsoL90n5Rs4W6rC3O2PQBXtdYhPTl-ycxcYwa8NvibWdjUbjLKRxOQ18L6RXXGD_278X0GX36pRyKznElaureM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdektddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfh
    hfrdhnvghtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesgh
    hmrghilhdrtghomhdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:ufe8Z_OFuS8hAFMvRoecKFSdkOuWChxsShPQ2JNKT13pDXj53PN67Q>
    <xmx:ufe8Z88ennKvAo3x9yqzA-fHCHIAqj36FaZFKD7_z7e7k8gf-9dU3A>
    <xmx:ufe8Z3W0u0YkU1xCmcw2zk0hSnkA3SOVN7mKhz-Ut12ZombZAOG7_g>
    <xmx:ufe8Z1eFhgYjE7nO2q7OU6zsxWAz4F7ZbSSgYqnys8pWR0c_esrjdA>
    <xmx:uve8Z8wBqFF32vglEHlCpdWK0Mc0pfPZUxB5c_o9OnfmHQbetfPnlzQV>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Feb 2025 17:50:33 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Karthik Nayak
 <karthik.188@gmail.com>,  shejialuo <shejialuo@gmail.com>
Subject: Re: [PATCH v2 11/16] rerere: let `rerere_path()` write paths into a
 caller-provided buffer
In-Reply-To: <20250224221914.GA193356@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 24 Feb 2025 17:19:14 -0500")
References: <20250207-b4-pks-path-drop-the-repository-v2-0-13cad3c11b8a@pks.im>
	<20250207-b4-pks-path-drop-the-repository-v2-11-13cad3c11b8a@pks.im>
	<20250222072048.GA3096947@coredump.intra.peff.net>
	<xmqqr03n7218.fsf@gitster.g>
	<20250224221914.GA193356@coredump.intra.peff.net>
Date: Mon, 24 Feb 2025 14:50:32 -0800
Message-ID: <xmqqh64j3qkn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> One side note: using timestamp_t here should get us the same behavior
> that the original had before this patch. But I'm not sure the original
> was entirely correct. st_mtime is a time_t, so we are assuming the
> implicit cast is OK. Our timestamp_t tries to be at least as long as
> time_t, so I think we are OK for the future. For very old timestamps, it
> is probably wrong (since time_t is usually signed, and timestamp_t is
> not yet).
>
> It's mostly academic, though, unless your filesystem has rerere files
> before 1970. So I think we can probably just ignore it (and I do still
> hope eventually to support negative values with timestamp_t).

True.

I do not think timestamp_t is appropriate for rerere records,
actually.  The reason why we have timestamp_t is for things like the
author dates that can be arbitrarily and deliberately set to any
historical times, e.g. long before the committer was born.

Unlike that, the timestamps we are dealing with with rerere records
are the times on the filesystem when these rerere records were
created and/or used so whatever stat() gives us for st_mtime
(i.e. time_t) is a lot more appropriate.

I'd probably leave a #leftoverbits here; we should vet our use of
timestamp_t to see if we are not overusing the type.  Roughly, the
timestamps we may record in the commit and the tag objects should be
timestamp_t, but the time we get from the filesystem and only
compared with another timestamp the same way should use appropriate
system-defined type, which is likely to be time_t, as not everybody
may have struct timespec, and file expiration should not need
nanoseconds precision.

Thanks.
