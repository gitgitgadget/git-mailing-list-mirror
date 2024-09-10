Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1221741FA
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 06:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725948557; cv=none; b=o73tDcN/JAsxzdCcKH0xeBMp/iFY66n07gOfHMmIPx+7kNsv+HC8VgzERP70+kUEiDSF4zWmzFe7V5JUiTK6XooOgvgqwZvSVefugnoYJQJI0J5ag4r3OWfYUDhPUU3DDeJLwtJVIaHkz3sBtUxm3t4zKV0+z4mAcqi14coYvA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725948557; c=relaxed/simple;
	bh=e/xNlugWxaYHXzl8BVFwQEKa/W3IqF8mD0+yGeXEQZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aCysbPSIdADhG2sILwkn7tBOIIwGo/M/3MINkfkIjcYQ34BHEzYnwBjUIPNAgI3Kx+4jNGuZbeDZbw8Iv3/v/RhVRmp+4IrQfoknzNnIWCe0d0TvMlNfB0A2g8jGRewsvunKNHButJ6QlSEnVTy/7g2jGbCKVcS3oaPa1m0HqOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SWgrenIH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=REtPin1h; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SWgrenIH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="REtPin1h"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 5C6B513802B8;
	Tue, 10 Sep 2024 02:09:14 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 10 Sep 2024 02:09:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725948554; x=1726034954; bh=e/xNlugWxa
	YHXzl8BVFwQEKa/W3IqF8mD0+yGeXEQZ0=; b=SWgrenIH013VgdqW8TmWSeI7ij
	KaCkiUblKWYK0wTdSAmgl4PQrdNvkP/JfKXtafz8JFT7KSdelNK/mcaKmoexjUGx
	nU081zWCcptx+xldFEHIjXjIAZCxTVZPkO4JQHwSlfmqJ8Lqt9icPmkNLK0Kx94n
	eYeJQ5DlktWrRFNOD7p8F4d+MZmFHtwN/DQV35EtwX6KCjP1x73iCKJ3ytk9t2yG
	EVuvsFjY1mevcu1hMScJ7m9lfIHqEpIsCZYFWqSkSHivE+L4DHZd9CF3QYmBbHJ2
	t1rm3MkcUU98+jmliHO/PBhh5bN4ot0TH8YzQ9BjCsEMKTs2jKlN9pXag/ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725948554; x=1726034954; bh=e/xNlugWxaYHXzl8BVFwQEKa/W3I
	qF8mD0+yGeXEQZ0=; b=REtPin1hnDgpJ5KOZDNFoxgMisQbTtdN36JQ+JiM+rca
	aud+CObaBEfUyC6a4Q5DMulyC/oZm21f/iv2JuuUNfmKvze+fsR/vMQY+lk5AOmb
	Tq7n0Ehg3LaoCdM3hLMEJ6mLdCL4lUtweVi/SyKxcGeEzd3anu5QzaEElOW0KP1/
	SEkFrbNKGIm+yBdCeBOQoVHna4VR6jYVEsw8lq1GRLuSQiQ+LgnTaObO+7LBT5jp
	Ul8Wa2YAsw4rZOVSDbe5wsGPK2KYb7W/wRPC7MC64aykKGBR6X8JrYZV6sLB46jH
	m+hhMR/SSXWCn6SV/9968lSWcA+m8xGBVQFV4G6KRQ==
X-ME-Sender: <xms:iuLfZvPYlUaaS3i-q88dPKaavqSHXpgMXMMRpK_TV1t78bPmvHrLTw>
    <xme:iuLfZp_NsbDTxgobSVN3NYp7ICBtG2_VIVN6Qo_FcBwq-oD80qSE0zZ9CwRm_tYPX
    04lKpjbgTlW9ilBvA>
X-ME-Received: <xmr:iuLfZuS-ZWLdszlDXm8KlQgPxSefQCBisKK6tldsfCzruRmsSjnxBtx1aHDKcnszfeESTOWFykQaBb17xtONimLEBFM4dNvYyyk7Kfp2AofJyh4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeikedgkedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegsrhhoohhkvgesrghltghhvghmihhsthhsrdhiohdprhgtphhtthhopehp
    vghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:iuLfZjuL5kX1J1kPdTVpci8p_y_7UtJzUNTYUtXpDtUnstOTKv7bjw>
    <xmx:iuLfZncO6KTXlFKtgOhMLj9pykTLRKBy8IbiAo4xc_tYz4V8YBEmWA>
    <xmx:iuLfZv2uZ7w7jqcUHe8_n2-99fCRAvHLlIyX9VGps8DtJ5g4gWo0Ng>
    <xmx:iuLfZj9hNolfcYCHwRotePFJq1pf9k5dy1gzvOqmW2NyAqWVRn31eg>
    <xmx:iuLfZj4XRgKqwC4QsJ69Ka1WDq7IfR9OYCmjyOGX_Oh7kM8nDKloUgWA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Sep 2024 02:09:13 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8972cbfd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 10 Sep 2024 06:09:09 +0000 (UTC)
Date: Tue, 10 Sep 2024 08:09:08 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Brooke Kuhlmann <brooke@alchemists.io>
Subject: Re: [PATCH 8/9] ref-filter: fix leak when formatting
 %(push:remoteref)
Message-ID: <Zt_ihDoECjCKczfN@pks.im>
References: <20240909230758.GA921697@coredump.intra.peff.net>
 <20240909231951.GH921834@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909231951.GH921834@coredump.intra.peff.net>

On Mon, Sep 09, 2024 at 07:19:51PM -0400, Jeff King wrote:
> When we expand the %(upstream) or %(push) placeholders, we rely on
> remote.c's remote_ref_for_branch() to fill in the ":refname" argument.
> But that function has confusing memory ownership semantics: it may or
> may not return an allocated string, depending on whether we are in
> "upstream" mode or "push" mode. The caller in ref-filter.c always
> duplicates the result, meaning that we leak the original in the case of
> %(push:refname).

Ah, I remember this issue, I think I also have it pending somewhere.
Anyway, I'm happy if I can drop one more patch.

The change looks sensible to me.

Patrick
