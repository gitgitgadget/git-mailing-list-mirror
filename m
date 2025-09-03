Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D572E8E07
	for <git@vger.kernel.org>; Wed,  3 Sep 2025 08:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756886853; cv=none; b=DbFcGCZ7YxhXbFA376ru1FNcAmBFxGkXIDP+feeKeN8aluH1Q0514BbFZPLyNowFiGHaYCzywHw+Pg13mdjdRE8CD2grOGl18haIMniZiHJRWUtwLZyxV22J2fDpYz9gbG+FcHZ35y2MT4JmlXAVC6NIIytcCvbvfGROn6IsJV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756886853; c=relaxed/simple;
	bh=LuMcBFaER/tmXxr2lHBtH2zyUwxjT2JHYQBvOO8QXp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iUaZzw7xUyYsoR/zn9oOF1BVYIrpihoHfy/OlQ3ECyPsEjTzMrYZiM+C3T1hsRKAI3qGI5hL8LnmNjibG7yi7OPxYmdx3xSE1II/AvGYHIH8weIXOlIXufDd8fQfLV/oM00rg2bAkacG8SboYnnw8mo0TEkPqx1J+GySktYvQh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RD7HwgbT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VkzdY8F4; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RD7HwgbT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VkzdY8F4"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 436B9EC037E;
	Wed,  3 Sep 2025 04:07:31 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 03 Sep 2025 04:07:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1756886851; x=1756973251; bh=zC7Po1Ntvy
	MRGNWrjLKwzr9CPwD3Cnxv0XiQBu/FUbQ=; b=RD7HwgbTURoecZUqNODdFYyXqo
	vY3EyK/y88R4N2dE5ZC+7LOHwHAfGtDHWQjxl6Ytj6+iojUvKmp5NeclixSO2ckS
	TLvvp10Z/6mNNa17Z6U/kpr31DkbsTGmX1mE+xpzrwrYag+Ap3sTq0mByHJ1ZrL4
	hAIvhKO4rolFrMh7wLjDw/TxKr3Ga+7/vVM2ayBS1Lx9GN+EMMIs5/DP9uciOoaj
	4YJxhSsZMWMdWocZqnpuJk+iDxsT/UzvY4rbik+k7ajf4ouHMLzHhlK/kFkgFwyY
	7sHMyvn3bEpti5WTKhVKjM7DGQFgDCEvgJWIUO91K5J9d9jSmX8mOPVKlL0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756886851; x=1756973251; bh=zC7Po1NtvyMRGNWrjLKwzr9CPwD3Cnxv0Xi
	QBu/FUbQ=; b=VkzdY8F4U4EGVpixa/xG2ffgbNyra5WOEmfsIZs2AXGduCiMx11
	FSdsorZuIRp3lehcjO6iefakgUZAzIDLLvkYF4VOH87JwoHNBAqQujT1scl/cUFf
	sYcN7YC6ohALRtFSrBg4hz1zS+4edLzgGTe3pb43oRnnN1Wa1xfO8vquYD6xjZ+S
	CX/NcBySE7axlOCbuESPKhjUxYwg1tG/MFXnyfMjFI++lO7cJLHcnw7oBftpjjsf
	KuNvUwSuAb5t5IXOP0lV2lTvN4hfpppUTKJOmMxO0xWaW8wXiIDL4t13AjdSli7+
	oNZcZdL/v3OiyRWmGt/AXjbWqoyCXmFVolQ==
X-ME-Sender: <xms:Q_e3aLzgTcPlDixNo44-3psuaIgcuSw1Oqa4c9BqxHrvMU6sxfFyrg>
    <xme:Q_e3aOwqdPg6Eh2RucKOj93Rih4m1Oc4c4J_omCy2OOhaaNXsj8BrCWYSjYlifmnn
    6HAR7ViUWzccdHdgw>
X-ME-Received: <xmr:Q_e3aLx4N-cU7t79Cx2nem1Ns6FaPMMeg10ieX9CEIsdr_d09mAXz3CbYvZU6oEXItfMM-3dGOeBYHoTimiVgCKLe75-Qur2uLnBn10>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddviedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepve
    ekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    khgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehshhgvjhhirg
    hluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Q_e3aAYNfdNWAzMRsAQrm1hjyG5h1TpeSc7BXxtyj3TXuCrCVezArA>
    <xmx:Q_e3aEVJdp_rhaya4jdKRLgVncdn6lrI_WChvAqCVVkw6FEvBEQGeQ>
    <xmx:Q_e3aGh4BuMNgDN0j8fPLgOuuZ3oWkpFFGwOS31dxmdgeF_7B8Zo8w>
    <xmx:Q_e3aKv1P6Eet7Qfv5YED5-NxB8w3ORwZiLQrX9gNbe1uP0rf6TKyw>
    <xmx:Q_e3aPyR9Z9IKK9DH0sM5B22IN8qk6OehuFVYmp8Sw2B96UjOtGw-Mii>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Sep 2025 04:07:30 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e2e8eb50 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 3 Sep 2025 08:07:27 +0000 (UTC)
Date: Wed, 3 Sep 2025 10:07:24 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
	jltobler@gmail.com, shejialuo@gmail.com
Subject: Re: [PATCH v2 4/5] refs/reftable: add fsck check for trailing newline
Message-ID: <aLf3PFUkt49bvi1S@pks.im>
References: <20250902-228-reftable-introduce-consistency-checks-v2-0-4f96b3834779@gmail.com>
 <20250902-228-reftable-introduce-consistency-checks-v2-4-4f96b3834779@gmail.com>
 <xmqqseh4h446.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqseh4h446.fsf@gitster.g>

On Tue, Sep 02, 2025 at 03:38:33PM -0700, Junio C Hamano wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
> 
> > Introduce a fsck check for the reftable backend, which checks if the
> > 'tables.list' contains a newline. The reftable backend writes a trailing
> > newline when writing the 'tables.list', but it doesn't check for it when
> > reading the file. A missing newline however indicates that the file was
> > manually tampered with, so let's raise this as an error to the user.
> 
> Hmph, how does the code react to other kinds of "manual tampering"?
> For example, if an empty line is inserted between two existing lines
> (or at the beginning of the file, for that matter), would the parser
> detect it as a corrupt file and die?
> 
> If so, it makes me strongly suspect that we are better off enforcing
> that the file does not end in an incomplete line at runtime and barf
> just the same way, instead of "most of the anomalies that the write
> codepath would never produce would cause error on the read codepath,
> but only this one that the read codepath is happy with is caught by
> the fsck", which does not sound quite right.

Fair, I'm also of the opinion that we should tighten the parser logic to
detect and reject any invalid files. For previous checks where we verify
that the table names are sane I think it's fair to live with it and warn
about those, as the actual names don't really matter. But as soon as we
hit actually-broken formats I also think that we're better of rejecting
those altogether.

Patrick
