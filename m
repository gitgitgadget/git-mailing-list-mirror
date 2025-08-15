Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C629C946A
	for <git@vger.kernel.org>; Fri, 15 Aug 2025 05:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755235049; cv=none; b=S/f/vqKbXy5+YNeGTP8BgbzzaagA6Lbwg8Huzq2qczHMRWDOmPoo2xCM07Bt2WSW6pKbIGEmBOKgILUzjJ9Vp8devSVxh7sa7a0TBvk8vZ4mt3Y/KOr6r1ofLB/3JnM6fOJRErsgzWbTqoowdE4Oixjy/Zd54fhijKmlq9MIPqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755235049; c=relaxed/simple;
	bh=90/iqkhty2p2HPmHyAD7YC9V9tm6qjRu3FxsAzK1KV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ddij4U7GqoVaACqXyHFoG1cWD98PCeK5VtAlCle0IAmL8XdeD5cp8+YJLB9u5QA+PQLJEWAaUaeV1meAkA7q/+x26n1hJhfvVN9HxwYX4tgH4kMNjzsolT67bM57f3uI26XodA0w+XRhY+tJaNnMoA6ey7TeRWZRg2YHY6IIU+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Nd16DvRK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XfvzKXfB; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Nd16DvRK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XfvzKXfB"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9099A14000DF;
	Fri, 15 Aug 2025 01:17:25 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 15 Aug 2025 01:17:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1755235045; x=1755321445; bh=q9zQzSHKID
	8VjcyFkSbSGaR1Ithq93X/+3FRTZNTgG4=; b=Nd16DvRKoW+Tkz1lkxUiz6GI3y
	88Ghhbn02rOAY6N6A8DkKh40cWUZnMjMR0BqszjiDLVjMF30o2SriLPDZYns8Bzv
	+AJZ6VCXx1aX7KVi7Yvx9/IRT4tUrCB7ax5TvIQFjbZFbVo+C4/4ns4jbZA34tCK
	Be1DAmIW0uflJ9UtMLMLap0wLp4KL5ppAdZ34TFx73agr0eHl3PDZDLgUbGTZUbL
	pC8Xn2Q/n2RYhVw7HnyNxNfJBp10WqAvbd2TGbiibBUtHw+/1HKwP0NgsT7/hJEO
	keFUodWy+T6Yz7KUDOJ90TpY3FAMVYav4gQVo4vriOL15Gb0OXE6zhkXxC3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755235045; x=1755321445; bh=q9zQzSHKID8VjcyFkSbSGaR1Ithq93X/+3F
	RTZNTgG4=; b=XfvzKXfBaEmFSc1FOYYTQEZaimXUZCG9wFLcEynS6Jcfyuy44Pt
	pk8XoTyPgTddNXsGQKyhExc7QlLgSWXzePI8WB1oxZM9fl4Aag9e/apO5J/Gtu3M
	9L4ZdfQK8wvgMt2mYlo83AXYMVwrNVwWq7Gp0ORdm+Z9Y69UofNHZ+qXqhF7ppSU
	UJ8EWSVPNfzuvd1BEI1Q7OpibCPZ5RzbgEbuoorhFyM9EDIHx1f3waYSzmZHdoCT
	ra0qTyD3ftpZjCYXzhV5p7aJ6rH+UKQKYEyU5FC+U1LJDd3rmYQrpEKgrFwHBk8w
	zU0jFZmUG4hMXdXZF482jPSb5rAf1mkeRdQ==
X-ME-Sender: <xms:5MKeaA7T9uaVqcvbnUgFN-45OSVsNEgICqRRr-QDjVKs-IxQp7KZaw>
    <xme:5MKeaNYDsXDLY95Oz2TGHgqTcpR2pavz4wEQwipKvjqFU7O8zpwKoxefnvUL98htm
    jXpdhatyQHUI8rDlg>
X-ME-Received: <xmr:5MKeaF4QuqdMGauGEA68hfMjRRvU3Ly0VD-At6EGY9L9S9bXGgqBnTLHHpVcrzIpH-06KlGPYCoV8UwA-wLpkc4wsEVekNQ6BL0ueniPHg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeefuddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epjeevudeggfffffeigeethffgieekveeffeehvedvgeeiteegueejleeihfeitdeunecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeh
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpd
    hrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehtohhonhesihhothgtlh
    drtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:5MKeaAApq2Q7pycYtGK91Tsg8KOLziJuqtLfBiDf9Z4XozUXTQnUPA>
    <xmx:5MKeaLfOsnNh7J7qLP6KYC8cbeIs_WpM3BZzq1tD2aic2i_1rcjTbQ>
    <xmx:5MKeaPK1x4FdrhFxZEVMESc_9aP5npkUwGI9CijqXQx15b_KGqUUaA>
    <xmx:5MKeaG0lCT4qlPkYuDHKqvZdfxyjmGUr0Lghs51pdwKpn1JFdMiIVw>
    <xmx:5cKeaAY5-Y5tvfREEi4Ms1YTAS9jgkO63Dsa3MD6xU537KZxSDzMfcT1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Aug 2025 01:17:23 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b12af95b (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 15 Aug 2025 05:17:22 +0000 (UTC)
Date: Fri, 15 Aug 2025 07:17:18 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Toon Claes <toon@iotcl.com>,
	Jeff King <peff@peff.net>, Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 0/3] Teach git-diff-tree(1) option --max-depth
Message-ID: <aJ7C3pK5WmDv7zIo@pks.im>
References: <20250729-toon-max-depth-v1-0-c177e39c40fb@iotcl.com>
 <20250807-toon-max-depth-v2-0-50b7e5c81665@iotcl.com>
 <xmqqbjoi6ijj.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqbjoi6ijj.fsf@gitster.g>

On Thu, Aug 14, 2025 at 08:15:44AM -0700, Junio C Hamano wrote:
> Toon Claes <toon@iotcl.com> writes:
> 
> > Changes in v2:
> > - Added unit-tests for within_depth() in dir.c. Originally the patch
> >   was a oneline change by Peff, but I've added a bunch of code and
> >   extended the commit message, so I've set myself as the author and set
> >   a Based-on-patch-by trailer for Peff. I hope that's okay?
> > - Added support for --max-depth=-1 and extended code comments why we
> >   need the max_depth_valid flag. With these modification it did no
> >   longer feel appropriate to keep Peff's Signed-off-by trailer.
> > - Made die() messages translatable.
> > - Small tweaks to the docs.
> > - Added some const-correctness.
> > - Switched from `die("BUG: ...")` to `BUG(...)`.
> > - Link to v1: https://lore.kernel.org/r/20250729-toon-max-depth-v1-0-c177e39c40fb@iotcl.com
> 
> This round seems to have attracted no comments, after seeing and
> reacting to a few comments in the previous rounds.  Should this be
> a part of the first batch after 2.51 final gets tagged?

My nits all got addressed judging by the range diff, so I'm happy with
this version.

Thanks!

Patrick
