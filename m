Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2819C18A6DB
	for <git@vger.kernel.org>; Sat,  8 Aug 2026 05:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786168254; cv=none; b=oeXInROAS+jhMxx0VVjxCO9HqQ+Eut6i8tRrZ9RiOaXvad5Q8T92Zd7tR1BDEa1JBwY5JGmegosj/RyqLjTBDomBIGQplbcRmRckjnXdIHIEXSa30eNbVu92k6dAyUJra8/xqIHlOHEemNBKOvq7jjMkXcpNT+hX5mQgVRzs2vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786168254; c=relaxed/simple;
	bh=fLPdJY9T4zTeBMxf4cK7is587LyuSSe2JBvf34izEYM=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SRxYbOmE0qoFDuPKKQxDwsCar/E7WaU/xo5TbfgFV+POOVLqXUp3kyuJacpHuDYThqDH2m/JbDa6XAheUVkeiJNV2IDkJElgfuTYCA43X0www5Ukr1nsYcMYIlYrwvOSEjdcoK/tF5TRglhJWK3ihWmLANdmFYRiGAgIVxTEicA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LnrFvT1S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P/9NbEhz; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LnrFvT1S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P/9NbEhz"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 460E3EC0128;
	Sat,  8 Aug 2026 01:50:51 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Sat, 08 Aug 2026 01:50:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786168251; x=1786254651; bh=sAH94I70ti
	n/7RE6FZpxo8WUlqzPcprwIqsFBYL4V/s=; b=LnrFvT1SFpuu29aZHazge9VIu5
	cR3Y7Q7Frm88jxBVLk1EgSh6RJ1TY70rSpA4kuwNBwtNP5rItcvzSvjB8YMzoaVh
	z+0P5hDAENgPdOk1qHNdMiDBt9/RR0C8oNTRlrbc6KXuC/8Ucn4cnomWmiUz6jPO
	o94as+cCzzuJFRXa6rF9Daw1ZwXVrVk+lDY+npJMiT0ylr3FqpNCjlYVt5urjsOk
	/VpX5whFkM/PPrRCWH37iQW4F7MNh9d9NSPACU5tSahEnZnVhYrTZ07Q3QKomJ58
	acAZjZV/p67+9IPcs3rGlwNdyByZNFdfdylDc5k37G4eY0Z3Id0l+FIYg58A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786168251; x=1786254651; bh=sAH94I70tin/7RE6FZpxo8WUlqzPcprwIqs
	FBYL4V/s=; b=P/9NbEhzAr5fipIXZ2q8i8WvM35uEqAt9Oh9+51bW771PJ+eN94
	3TfaMvLcprOIKpfHttaPUPZ1vQ2mYo84wl9Soq9luhqNRv74c/ntcqxqO9J+3S/P
	qLTPYwpETQoLPKA0adS3AmsMnHgrhK5361NMcgVGNDhZWHGu2iNc67WZnLaLr1g7
	k8l3JnYdYjnp4EJVOFHV+BymnN79tXbXySRpoJU7gGx+97dKx0dCQKqjqtxYb/4j
	mgOJtlmJxMy5wlOJxeixLVkHt//SSLwb3/C6N7KGaEuQ6OwDri9oTlbx5a8eje8P
	AVEuy3tfYb4ylvHJB94s26ExYhzPg6hB7GA==
X-ME-Sender: <xms:u8N2atXeCnc2acZwJU_dwo679BDfo_07EfsmFF7nokSdET3S1YDttA>
    <xme:u8N2ajnew25DxNZZjv-IF84h4ssYvrFVJxd3NFw2xO0_V55uH_sNW7stxrNYJo6vp
    NcX-tXgAORJzRATjJHHpfQcOrHdWDFdgkd7cofplOpbVfWL9I02imE>
X-ME-Received: <xmr:u8N2anDK4aHLm_oh1SMJFXbFAV5IhsZxEVEYFe1R3hhaW8X4BIir3Hfnl-QaMCH_FQPJhyLmc-PRSTBFytmNK76qmrgh5Gst4g>
X-ME-Proxy-Cause: dmFkZTEvSMC2/N8OA2AFfNbNGA+FxzCvXmDd9aIJ3zHCQUsqMvWkZBvAtaPFDw/k0rSxNp
    4IKeb38qb+n4XScf+3bFa3bNPO/z/FSl3R2he/9OnB1TSucl5EjW26EuXdT8fpvh99w2Y/
    GAImMblzbZKLhXWk/5sZDvmgPU3K4HB+eufa5al7cMIKhiHIkrUV0wsvfuXCr/ixBMZW2t
    fgTs2SsRcBqsXr8ZVApPYAVUp/tsdr9OWmFY6anv8Fi8fPzNt4p7wFH87JQ8pIk29CHnmE
    2c7T6wMZgApD+gfCRnOPmBK60CnzifFZhKayumGE5H/dj0G7QpF9Ou8dw7ynYB68qPrKIy
    rBoorVQ24phdCfGBlGStquViziYua3MSLof4QaFp/2Ncocqe/nDNRfNIbpaZIapXL+ls7W
    aF9IJxh25xZrMF70hShmDDNPGSoWJHKG/zC82fIDX8UX6xtC8Aanqicltlz93/6ItJiEEi
    t3oan9zKg16Zj0iE7IYU9XCgXY2qw4dUmSscaXIh9AIht5SRj5a9Cr2fmRGrbT6DMHkwEQ
    dp5vZr8giRxNhepGdEvWOPA6oYGG3oCgPDKQ1ai5XJwGdz3TwTzXo7V/tWDu0jSL/ERp3e
    vMajrB9FZ42Xbah7niR1pRc8exuKmikCrqQVc7CxLXipvR5KTVqrysX7DTMw
X-ME-Proxy: <xmx:u8N2arcaHrDqjs2_EuPXXBfgh8YwBYYHtktqoxQ1SbopWLnyahVwkQ>
    <xmx:u8N2aqJHTEUoy0HjNmpWO_owDm0lFglG4mohrt13ttxGB9Ztzriyvw>
    <xmx:u8N2amf3xSynEczvbb5Vp_VvjYpDPDnuYdZNa66RkTONfP2SrobjAg>
    <xmx:u8N2ap2TGS1bFzOxG0f6_-ztIKdy7xWLfrXuIvEPOSZxdzQ2OA7FHQ>
    <xmx:u8N2aov7aNm8qCf4Gcixdoe4F7oC8Mn6fRdEuEEcALO8yvUvdQjLA_lM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 8 Aug 2026 01:50:50 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2026, #03)
In-Reply-To: <xmqqwlu1bck1.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	07 Aug 2026 18:55:58 -0700")
References: <xmqqwlu1bck1.fsf@gitster.g>
Date: Fri, 07 Aug 2026 22:50:49 -0700
Message-ID: <xmqqse4pb1om.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Here are the topics that have been cooking in my tree.  Commits
> ...

Sorry but this part is stale.

> The 11th batch of topics have now graduated to the 'master' branch.
> We have 401 non-merge commits in 'master' since Git 2.55.  There
> are 55 non-merge commits cooking in 'next' (note that some have
> been reverted), and 235 non-merge commits, including those in and
> out of 'next', in 'seen' as of this writing.

We are now at 12th batch, with 409 non-merge commits in 'master', 48
non-merge commits in 'next' (went down as topics have graduated, but
there are reverted ones that will never graduate), and 261 commits
outside 'next' but in 'seen'.
