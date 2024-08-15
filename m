Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15481553A6
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 05:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723699750; cv=none; b=Hu7EWpdghI92lFeunyaBXcstYH5KPn0iHZX8J/H94n2HT6A/PlLGi8Ph8NZGOZdNllZFY67MlCHtVUDOJgKeIjrOEIShkEHDlNiZQ3w6b85LH2tp3CeHlH2nlYFq/vXaPbbgeEzhd34bqpIfGLYgZQY8hMAnah8VuKGWmZ9/PXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723699750; c=relaxed/simple;
	bh=ze85ssnkg8mPIm7d5Z8pTQJdJ4OV7Sy5mrinYhXetCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tw3tM6E8uhYePMVvfRcxfDOFspKKVMMKt6StMWFrDjrJiwkXxyZHQ9/U7vQyh11u96K/8PDXPDlPgniL2f/0cR0lIdQsWpGqTGu/5xn2U6ffQw7eQndllk+y8sve+yjHpEkqEtSYbFk2NjyshDSHNcViR3Dv7xFeGx0DF+dN/aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jfAu9Uk7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QQ/x+qSf; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jfAu9Uk7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QQ/x+qSf"
Received: from phl-compute-03.internal (phl-compute-03.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id 30A5E138FF25;
	Thu, 15 Aug 2024 01:29:08 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 15 Aug 2024 01:29:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723699748; x=1723786148; bh=Shr9P2SyKk
	XmXAJY8+GOx4lraux8NGoqn+65V3nLqiE=; b=jfAu9Uk7ry2mypJX56OTKJjxRr
	ssetjkobB9iwwGM6ftk3Icdt8f7dZHIGynE+wx6vjkbYJBquv7FGCAiIE7vSrbLe
	nWidgDi7I+ZKWGRZe3gzreqqfs+3AvXwWaAw92vG9otYZ1PHxQVFZkXL92sJ93EX
	cz95NwD0sBQZiM/HPt8Zy2pqNY2rXH9Yo5pAyG3Tlvc3+qt2tvPL6CZXNCD5T/Be
	PQ5chFhbiyD9T0kac3UsidGcoehMyZ6a5kFssyKUyTjV7UjV/AVzerZ8rOF5dE58
	mbRi74YR8cwMeVmkT9Ku77hDxHlmrZ9mSzj4qyO09GhFzlJ+SgM7+9cbTktw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723699748; x=1723786148; bh=Shr9P2SyKkXmXAJY8+GOx4lraux8
	NGoqn+65V3nLqiE=; b=QQ/x+qSfQhszucnViq+gY6o7DdyBFcmQfjW+U0R8KLkr
	M6PrQBXGczxztFVtCbN3cIAeaPowqPjfVdXmbDI6Vh4a+QSUgnsRfogvSzgsmPLy
	Wy6zR6GqPWXTCnw1fYak6N+gNK9iwPkDp5DolnWGOycQl6oKlKACwlXXnlu7IQas
	1cto8lCDDa7V867/JrF+CBIjwn6Xqwl57XtZ0R7tBa3/C06B7MbxltXzclli6sD/
	SHI9CONoIc1MPSZ52oYndW1zClRZOyiv2vhwMvCaIs28jPjMntAqTQcHq6yy3kfs
	ba0kxmB3nxg/c06bMuEIBGDHEUmAISeZAf+pJzt8gw==
X-ME-Sender: <xms:I5K9ZuwPr9OarOTIxRYNPqxReQY98YYc2k_U-A2aScMrLoLk9ojFQw>
    <xme:I5K9ZqTrXQcYurDUfbXjDqVOUFzEcGGGk7V-MG5pmBwtkQjqXi-O4AklVLAi8kVHu
    cTDXxCg9MxiCvv-1Q>
X-ME-Received: <xmr:I5K9ZgUFQ-8Qqb30KkHMBlaktDH6pUDu-VoPzANlBpPEIGG-anHLnCj1t7A7J1pfHCIrEHB62riSQSKLdZGlEIvUJ956DRjvDgwUeNxWttxndQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddthedgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepjeevudeggfffffeigeethffgieekveeffeehvedvgeei
    teegueejleeihfeitdeunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
    pdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrg
    hrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:JJK9ZkgNi1Hpd7K7WPMXR8mW9p8enFp7urLiKXcYjqIa31StYU70iw>
    <xmx:JJK9ZgAcx5CgO-yxMONdpy6d2__0cN_VQ-b4qFzIuIOmzjJtSWeg4A>
    <xmx:JJK9ZlKI1dgNCcFAjwsI_BzHpg7X-917JmVVA4V2NGPDNmlPtohoIw>
    <xmx:JJK9ZnBImmWJZWBdzI48aGBMrPyYrqsL_BADixy3d3dLRfp9gUPS2A>
    <xmx:JJK9ZjPmsxollpWylGarlj-1jdLRfwQ8myS99QxhKYvK_NWsFC0u98OQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Aug 2024 01:29:07 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ea9417db (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 15 Aug 2024 05:28:46 +0000 (UTC)
Date: Thu, 15 Aug 2024 07:29:05 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 00/15] reftable: drop generic `reftable_table`
 interface
Message-ID: <Zr2SFNUhKF8_0hHR@tanuki>
References: <cover.1723640107.git.ps@pks.im>
 <Zryxwirh2z4gOltc@tanuki>
 <xmqqcymbyq88.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqcymbyq88.fsf@gitster.g>

On Wed, Aug 14, 2024 at 10:21:59AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Oops, forgot to link this to v1, sorry! You can find it at [1].
> >
> > Patrick
> >
> > [1]: https://lore.kernel.org/git/cover.1723528765.git.ps@pks.im/
> 
> And on what commit are these patches supposed to build on?

Whenever I was out of office I had the nagging feeling that I forgot to
mention the base for one of my patch series, but always forgot to double
check when I returned. Seems like that feeling was right after all,
sorry!

This builds on top of 25673b1c47 (The third batch, 2024-08-07) with
ps/reftable-stack-compaction at f234df07f6 (reftable/stack: handle
locked tables during auto-compaction, 2024-08-08) merged into it.

Patrick
