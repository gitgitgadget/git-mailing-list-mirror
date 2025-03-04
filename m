Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FE31FCD06
	for <git@vger.kernel.org>; Tue,  4 Mar 2025 07:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741073998; cv=none; b=GoiJtBZyRKKktv0DDE2kJ7fGmGxSOA+Prpbn/iQGS+GNsENXIHSom/7ATLJc9+Fv/I4TQXpop/wBEoQygJ5hIf7zP2MK3Fxbq/i/2hOrW+T48Fuj0XVqkSAuVeV2S/s+3h0oWJh0Vdx5lancKXxC5OkRT5X6iy84BO+GJeXLGX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741073998; c=relaxed/simple;
	bh=oy+h6fWlbwtjNEfYaMyiWEMNhb5jbheYIdADAF1E0lE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eq2x402GNgxnSNJjsAwj1cr2L94+0sri4M5rJMhLfIVDfEaD5vDb4clUiQbLhtE07N+nYaY2611MOMIO+1LkOnsOLPIDsNf+6I3oH2XBZJ2b4CKLVpKfG950FIe48jZJq6KPql3KZzp1mDHw53pZ+Yk4RGD5wxOu1/hCxt06xBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EOywt8PK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VQQdmXi2; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EOywt8PK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VQQdmXi2"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5DD911140227;
	Tue,  4 Mar 2025 02:39:54 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 04 Mar 2025 02:39:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1741073994; x=1741160394; bh=F+Jn0Fde6F
	jGPu+nuQmU7TrIlHRFizW7NynooMRzBbo=; b=EOywt8PKVrLr9Ka927lOlESzXd
	DJAwfWPCecvxrhXJ7/W8gxE1yKzGzeMwghkFjJq6snE6xLJGAQZElafFK/mLNx/l
	x2i5YQwCPPiC7MYCg5x91hCCJh2COOr8zLLL/80NYp3kcIcPh1Aj+dKUryzBRhhf
	WZuWUNiGX+hidh6dNg2ubr98sZVSN0rlFvCOiCofY/0hNgwn5fc5VY3agoMO8t6E
	jeeaVgNFss9j/52bsapWNiCZkLEOLBla2sUqjWVq8U2Z4fVCObPPjmtZZiKqqJ0B
	VVN+/35PTCr8XJ9J1rlpzbobLK7togHqkGf472pPf4pJDyjD1w4njuLNYgdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741073994; x=1741160394; bh=F+Jn0Fde6FjGPu+nuQmU7TrIlHRFizW7Nyn
	ooMRzBbo=; b=VQQdmXi2W3vCiDHr9exhqQEoXOFNsADaxrqCpfIhqKWw7Fo2fin
	j6Wf8JWB9cwlI+tRqz0j/bJlgPLzLJ9p+XeDspoq5eRu7sjpFl5og9ch3CEKyCHp
	OxY0gDng1H+zvFQDi4oYqLBm7P64pcYrwhhdwrZg0oKR8iqMzGVeOJNMPh7cnPSr
	ORMJoI3jKTFDA4LzaXIp3LnW6eXmVkdZI3zGRUNIqGT0uVa43DdSYLryPEjilsiL
	m4zB32JzCGA9DnuBAHkqpWj4a724EFVik9VbQtlQMfSO4ALVHwo1jaJxlayzglzl
	ppvphZGW2H0J1Mep3SYxsPkt0Bsm7eHrLBg==
X-ME-Sender: <xms:Sa7GZ2MCmkvNpJypHkLOIDDtag8DIn8oOm6tLN20oRX4eNvm0gH2Pw>
    <xme:Sa7GZ08S8uPaWk1uD4nwHQjCoUsmZra9wyps3Yiq0HXI17pT3j0_tg3Dsith21cEE
    e7sbXqblqB4G0jFuQ>
X-ME-Received: <xmr:Sa7GZ9QdueR6jll1t9uiniP9ApzmDlO0OZCuiKbBzoUOf8yiHgCcCU6rIDQ-_95sBsN757Lokly5zNtilpudH_HPPnKLwaSLsvCjkb4oWxrz6MU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutddugeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekff
    fhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghf
    fhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehgihhtsehgrhhusghigidrvghupdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Sq7GZ2uX8U9ta2gNq6aDH1p232uXHC7xiiQ9O_ESz-A0zY1n3FVk-g>
    <xmx:Sq7GZ-dez7TnU890nHfAY4nKoeqUqKNUFkYRKbQyHse5RjlCjcSyhw>
    <xmx:Sq7GZ62OaZtgx4LBZYjxk960s1JtIsPRDuaQgFgRn7Bl5gLlFA2z8Q>
    <xmx:Sq7GZy-_OgJKVhkOvK3vbF6bi7HFR2Mu32FkEFDgJWPiBr0eMjDyNg>
    <xmx:Sq7GZ95kDe5ucv9PRPaQBM0xy98gG-_EE-QbayLi0sGR0rqinHd9GCfN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Mar 2025 02:39:52 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d7175fea (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 4 Mar 2025 07:39:51 +0000 (UTC)
Date: Tue, 4 Mar 2025 08:39:50 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, Michael J Gruber <git@grubix.eu>,
	git@vger.kernel.org
Subject: Re: [BUG/WIP PATCH] unit-tests: use clean test environment
Message-ID: <Z8auRqylLYuwalAA@pks.im>
References: <e3be6705d103ccbc165d0fd3b9b7c818d14001e9.1740516033.git.git@grubix.eu>
 <Z8GVAjwZWOM7c2fR@pks.im>
 <xmqqseny40kx.fsf@gitster.g>
 <Z8WFcaEtMCD5C0EN@pks.im>
 <xmqqzfi2xl5q.fsf@gitster.g>
 <20250304073010.GC1283943@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304073010.GC1283943@coredump.intra.peff.net>

On Tue, Mar 04, 2025 at 02:30:10AM -0500, Jeff King wrote:
> On Mon, Mar 03, 2025 at 06:07:29AM -0800, Junio C Hamano wrote:
> 
> > Patrick Steinhardt <ps@pks.im> writes:
> > 
> > > Maybe. I guess for unit tests it's a lot less clear cut as most of the
> > > tests won't depend on such a controlled environment. So sanitizing the
> > > environment would be a good enough first step for me, and if we see
> > > demand for making specific information available to lots of tests we
> > > could still start to expose those at a later point.
> > 
> > Fair enough.
> > 
> > To put it another way, if you write a test and if it gets affected
> > by externalities, perhaps you are testing a function that is at too
> > high a level that is not a suitable target for unit tested?
> 
> I think one problem with this approach is that breakage is likely going
> to depend on the user's environment. So something that works just fine
> for you, the test author, may introduce a hidden dependency that breaks
> for somebody else much later.
> 
> Some examples, assuming we just suppress reading Git config:
> 
>   - Without an explicit ident, we fall back to constructing one from
>     system info. So if a unit test ever creates a commit, it will work
>     fine for most people, but not for somebody with a blank GECOS field
>     in /etc/passwd. (We do look at that field for reflogs, which current
>     unit tests already do, but we are more forgiving there since we
>     don't pass IDENT_STRICT).
> 
>   - Other programs we call (e.g., imagine gpg or ssh for commit signing
>     or verification) may read their own config based on $HOME,
>     $XDG_CONFIG_HOME, etc. I don't know if Patrick was including that in
>     "sanitizing the environment" or not.

Oh, yes. I didn't mean to say we shouldn't sanitize at all, I rather
meant to say we should sanitize to values that simply cause us to do a
no-op in the relevant parts. That means we'd:

    - Unset a bunch of environment variables where we know that they
      impact Git.

    - Set config-related environment variables to read configuration
      from "/dev/null".

This is in contrast to the more involved fix here, which would be to
populate a temporary home directory with gitconfig files and whatnot.

Patrick
