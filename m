Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE042E7BA3
	for <git@vger.kernel.org>; Wed,  3 Sep 2025 08:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756886852; cv=none; b=lChzlHJEJtzeEIm/Fw66tbIi26ZicL/gi2c3+awggh+cILAvXuw+A6qmhHXQ6FEmfMMqcYgf5rV5Cq1k1GXaaj4khjKIKMl2nPUnuStA1sK1xyLyL2r9g1wuAOQLMfqo1u+3T4a7Zo1SY2Z7N3gmzrgm3J4cRIAYHr3nBC9rJ0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756886852; c=relaxed/simple;
	bh=TicSmoOAT+EjHIMILntBT/0iIEgZthHt8zo2b03cyjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XBoxy54BEH1B2SjUnsJ/X9VDHG41EPKfY1IzkC88fLxFiHtoKuZdaHQu6QJAa1wWAYadG0b9Qe5PeLB6t7O5D+z87sywBblvgVoODRxDi7Ks08aMyPDZrmlIbuqhOrsAywZfogAKhYEGw/+6Pm6sBP/u5CoylrmHvfbBFpdloPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=X291l3GX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=geX8LttU; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="X291l3GX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="geX8LttU"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id F21A0EC037A;
	Wed,  3 Sep 2025 04:07:29 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Wed, 03 Sep 2025 04:07:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1756886849; x=1756973249; bh=TicSmoOAT+
	EjHIMILntBT/0iIEgZthHt8zo2b03cyjs=; b=X291l3GXXuQU84rk73bhBpvYBj
	JvveJuomChKSKJa87+bPht61u+1a7ga1xSPMNWmeSUIHBdKZLjmMfHMc8+jK0HvX
	tEWcCOezgS2+e2RnnS9gBXvfGD0XIeQFVYW4exf2ZrCBr4nZue8PRDOa0MDgF7ya
	20Ytx3LSWwV4iLFam28fZN7be8zzE0UtnfQpAUmRoOD2KmMBdk+OjumxUHkSW5O4
	9elHXaOnaNU8hcEAJ09vFzsp0wbGrarzc/M+mLlXp2dNAp2v6I9wgO21oLZuU8/u
	otmIPgS8dEVDabI4GZpoD+gl/fYviYGgT0eiVxbRSQNRr+Yk5w5DLQ9hrp1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756886849; x=1756973249; bh=TicSmoOAT+EjHIMILntBT/0iIEgZthHt8zo
	2b03cyjs=; b=geX8LttUTKL5bhFMtRoGMinIxBO59WV2qZhHzYg/HsicabwJEaz
	uHVZOvZPzMPTzO6F5zo0yb1WrcCt4NlFk9p4RU/ChiX39jejZu2Cbf10bKO6BAjb
	0Bc2zzfqlaGsVnT4OSQ03yoJb4pdTyiIpddb090Fqb8fL/9KegkNt6balAiE/r4W
	ogXBGVK2LIOaoK7jxz5ncgdez8ImoY6l333zvRsfCA4h+3CTU9EKD1u6e5xy1zev
	H+vW2FM3yXCT03SsyP4upTPDggK6l6MPyJKyCaAAl3zXTu0TVAxFRPVDUEAvN3qh
	7lx3eKgLq5yNwnPvVpv54Veinc/VilH9Ldw==
X-ME-Sender: <xms:Qfe3aGsbrtJuCB7LGq4_J7_dNGLQu_7i040xCA8pdlUrmyT3lWUzSQ>
    <xme:Qfe3aGDcUZ-hFxorPxA1ErxmcEsYuIOihC6xMDLH4mYDgXibWwMlzCZI3cprmSKoj
    lymLuEARwLyjjeBkQ>
X-ME-Received: <xmr:Qfe3aOUieaNsOT8QfI_k2N7-5kuhQpop8sLIqdb-9MhITlJiyf8KnnrXrqKJuHPpBHWk3wZ6G5QiVzTpqWhjKUCvxSWTpvPhkyijyo8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvieduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepve
    ekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    shhhvghjihgrlhhuohesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:Qfe3aEDPSt4o3Tqjpa4O4Mp9DAI9JHou2qLoU0ApLD4HSv3eQjlU_Q>
    <xmx:Qfe3aB8MpLnD66N6oE3IOFXZnt85bRnUn-vBJmqHgOp-HzSOcACrXw>
    <xmx:Qfe3aLEWPATRZ1wpSzR9poCn2NnXkQh4ZvLPDQ61XRHCR8139gjqRg>
    <xmx:Qfe3aPOVUU6h7UPYSATTS2r2L8m0ustSOgqTQg3gYMtrd7O7isoa-g>
    <xmx:Qfe3aNBIAWf56PhaAF9k7eyKcqlE8HjulWaxQBR9ydi8QYkJWEE1PSpI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Sep 2025 04:07:28 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1c8a48ae (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 3 Sep 2025 08:07:22 +0000 (UTC)
Date: Wed, 3 Sep 2025 10:07:19 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, jltobler@gmail.com, shejialuo@gmail.com
Subject: Re: [PATCH v2 3/5] refs/reftable: add fsck check for number of tables
Message-ID: <aLf3NyodTZ38N8vY@pks.im>
References: <20250902-228-reftable-introduce-consistency-checks-v2-0-4f96b3834779@gmail.com>
 <20250902-228-reftable-introduce-consistency-checks-v2-3-4f96b3834779@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902-228-reftable-introduce-consistency-checks-v2-3-4f96b3834779@gmail.com>

On Tue, Sep 02, 2025 at 09:05:23AM +0200, Karthik Nayak wrote:
> Introduce a reftable fsck check to check that the number of files in the
> reftable directory matches the number of files listed in 'tables.list'.
> We do this by iterating over the files in the reftable directory and
> counting all the files present excluding the 'tables.list'. This is also
> exposed over Git's fsck checks as a 'badReftableStackCount' error.

This feels overly strict, as it can always be the case that a concurrent
process is currently updating the stack. Furthermore, it's expected that
on Windows systems deletion of an old table may not work because the
file is still kept open by another process. The reftable library is
prepared to handle this alright and will re-try deleting the table at a
later point in time.

So maybe a better check would be to verify that there are no files with
unexpected names in the directory?

Patrick
