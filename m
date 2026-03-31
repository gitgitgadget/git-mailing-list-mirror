Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A751990C7
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 05:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774934556; cv=none; b=JalGUErv1PAwK9taAR0yleryeQCfOpXTKLPsCe/CC9A/07BZZ6ieGU6XV9J3D9/0g/ganSXHBRuQ2Gmyl1IbPjtAd7COJ/BncO9CU2lN7eWd7ehiaGF75d6X1gK7ZtNBeTzISbqTNFl7DCZLdz6nOoiJFAnbphE65IvNqFb5E0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774934556; c=relaxed/simple;
	bh=RtZDwfy6yzBWdiIccGZPG4ZM1HG/LrIF3PXoD/+DbzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VX1jTazpCuLx3OUPo2NYQ0uEL2RdnaGjjHI5EbjAHIea9db6oxshlzp4RA3OIjTNegJ2SUbJhLFTwx18rL/FbA6/hBa3C9q+34RXiMm+FY4bXP2QcYE3pEVvrpnlDckANX+jPsfCfA8YxdeLyQiPPFUK+DdeYxXdDuXO6HCcst4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Metzcmpm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=0riZJ6s8; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Metzcmpm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0riZJ6s8"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A57B814001EA;
	Tue, 31 Mar 2026 01:22:33 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 31 Mar 2026 01:22:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1774934553; x=1775020953; bh=tlL849UDW4
	Rdz4YgJWIYgMxV6wBVHHTZzHwM++ugQnU=; b=MetzcmpmMVol2CvFnY5BMSrwk1
	hVA4wmJhBs/HmqQC+0a501tqECvaxlCI4xXKrUvEsO8A2m0+cCEYVAHRYx6RSX/1
	rz8OeT4xnd8NZtmqwkPrzvEE93LZdRLLhlpeMDvg+7HkZvtayJ0bccDMAAwB0GYL
	uUZzNi9h2SHbMsOJT3mT8M2WIIHy1HSWWJ6Uq93uAoHHn8lQNrnCmq57kgBjfZ8C
	SysenWgrxstnE7x7InOMxTJvlEMNX2doiaJXwynUuk0MiO+6bZMCNbODST/rx4L6
	v0FkWQ0vbDw5slzYBOgIoKoIdBFOfyRvNJIxBdA2LOiNwW8OqosTTB/cAokg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774934553; x=1775020953; bh=tlL849UDW4Rdz4YgJWIYgMxV6wBVHHTZzHw
	M++ugQnU=; b=0riZJ6s8hnGn1MxOlxwO5YPMhbH20AE31SS729n5hGxNImRhCg6
	kQsy+4hLIZWGyTi+21ptW6S0LhFm16vxTwhrJDxdYBkN/qVnzsvog08Iqnl2FONc
	HqH2RkMe2oR8ia9r9dZKzLcP4LslaRYGn9XZERIPphskqbmYD1KI/yri1b4ZX7ZW
	us0IZBvy0CQe4+z5q19xfrsDzY+pFhfUYMczpK+TrDFOajvYotZntS6tkBUB793o
	JZP0IaeNH3diV8wuDFPG87IcAlUNcViRIha2LHz1XcfzNwUUkCS23WGBuhPawzAK
	b6cDDnxRb+f22d98AV3ehOefGfEDlE0feTg==
X-ME-Sender: <xms:GVrLaYllNyUitwlwiXV-KcX6Te6RWhWER9FDoQNURcuq9UC0T5C3PA>
    <xme:GVrLad3wrt4wbFHPUz8u91hK2F3x6D6ruqrFIUVuxdyTxgWjaKHky68bfR4z3kQyo
    V6EVxTYFBxzfQWsPflO58R4YrqtoQ84LXKzzmS6NF8GuCC1xQXbsg>
X-ME-Received: <xmr:GVrLaUQS6OL-1KQPpobc6VLGer9zR4gHAvQ4MsqQO6qIkZPVadGL8UoxzCpdeM18ZBylBZbdZQAcoGdbrRTIgv3vAY6kEXb16ELqkRB0ryg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefgedutdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:GVrLafsnwxNA2TVfR5oc6jml913JbQzHdtGbFvB_nm7g_iImJTI6gA>
    <xmx:GVrLaZYFLi-frQqmM46N2QSRXoIvC9726Gpxw_cUlGLaPs6I7QWDBg>
    <xmx:GVrLaUsQfUdVVkAGc92bPBzctJm4hdHVcp4nlffzHss9MuZAdbcDVQ>
    <xmx:GVrLabEEnLe1KyPQIOFP0toxEi77G-V0gESlqP36Ua052dTaYUBGHA>
    <xmx:GVrLaT_sAtXSZXLi-SLLMcraT_YDJ1IKnv3odAgPw38fsy9WeKnGIch8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Mar 2026 01:22:32 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 81b68e7b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 31 Mar 2026 05:22:31 +0000 (UTC)
Date: Tue, 31 Mar 2026 07:22:28 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2026, #12)
Message-ID: <actaFN8ds0cfgWxI@pks.im>
References: <xmqqcy0k6epp.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqcy0k6epp.fsf@gitster.g>

On Mon, Mar 30, 2026 at 05:10:42PM -0700, Junio C Hamano wrote:
> * ps/commit-graph-overflow-fix (2026-03-23) 1 commit
>  - commit-graph: fix writing generations with dates exceeding 34 bits
> 
>  Fix a regression in writing the commit-graph where commits with dates
>  exceeding 34 bits (beyond year 2514) could cause an underflow and
>  crash Git during the generation data overflow chunk writing.
> 
>  Waiting for review response.
>  cf. <xmqq1ph92pzs.fsf@gitster.g>
>  source: <20260324-pks-commit-graph-overflow-v2-1-843568cf8780@pks.im>

Shall this also be marked as "Will merge to next" based on our last
discussion at [1]? I mostly want to ensure this is part of rc0 so that
the regression isn't part of any tagged release, even if it's just a
release candidate.

Thanks!

Patrick

[1]: <xmqqh5q1mf0o.fsf@gitster.g>
