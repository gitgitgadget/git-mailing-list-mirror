Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56464224B0E
	for <git@vger.kernel.org>; Wed, 20 Aug 2025 04:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755665912; cv=none; b=m2g5vMmNIR4bIciFioabYVwMEe5syw8ZKwOd6veUCmhxtcE+iA/uHqm7QzJz99Z2pamFrCw3JZ4+MOZmMcp/BBsLNESjq0EgRTkCJYu1Kp7PXYTDlD3ZNkgJvD9RQBXaoExPKzZLicK0M0Ox/cOG3R5aoZ/8NA1/zR7hTp8lj/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755665912; c=relaxed/simple;
	bh=u9dzhfvYo9gGKrMmdkd9iERHOSgtu5lYaIDjS10fRn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ipXpNlM04xf84HMn8McxeY2SBJzdomCdRDAZA6APOuetEc/XJgO1OqOqoBGFQX9bvuDd92r35B6L2QdfqB5lvp3qTsIDG5YQQwLjZoKEBAwXi3KrLItEjdxP08hu17Omj1Fdb5jvTurBgT2fBP5/S+ItVzZEjkkQ1hNJ4iftnng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YmHthSWW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KSegrEVc; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YmHthSWW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KSegrEVc"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 52ED4EC05DB;
	Wed, 20 Aug 2025 00:58:29 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Wed, 20 Aug 2025 00:58:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1755665909; x=1755752309; bh=IT7oqtBOwF
	29t5oQS6XFNuzHl+MQbr3I89v8hTWlQDg=; b=YmHthSWWr8ChoWs71hCollT1Zx
	fgm7nyPb+HBmGVS8tsip1DwLebrTzgBx7jtKzRUiP6uP3o6Kq+cPeWarXm4qEIBp
	TyVa0/cS8ro5L2DjT2rJhYVkZwiw/K34q8yboqbYkkBV/K1OvpsUznqUS/mw4A3n
	odWqUQ6NVCY4kBeCfgd/TPIUTz2WcEsPbbPENBuB/RLVZ90KCipfObhB01v8+gjs
	bO13XeNqAp2tyKUO/wSSpdl5l7aKXas7GFeCFj7e2sm85xlENW3Ox4WtDdiiYUAw
	2BERsPdKrq1tn1XaNtpCvCGdUkOk+z4+fKgAA6lrLwrP/GtlqZ67sDdo1BqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755665909; x=1755752309; bh=IT7oqtBOwF29t5oQS6XFNuzHl+MQbr3I89v
	8hTWlQDg=; b=KSegrEVcl5iL7qBUtfp0NuBwN4s9KSXwXGfgKqD/9aaR0i38WDy
	dIVqd9/YqtXbC/1HBkXlMpI/xLSD5yPDUi+Fs3MsYbLEAhDn1XHOYznAyjmG8BwD
	4NkfH95CJ0c1ki11zNFDPb0rzF0wsRB2TXjE820oUJRf/yjc5GXMGQCsJ+oCGXsf
	tl/O9uNgSPNssip4h+22dFBjwSfbDHVKL2JlIfNcAInVViaB/AuzDlKKYnw5RPK9
	eiykXddl5t512w+mXRkEY2Ye8STtLBRDRqXqsGK02HvYxhEmZLrF6b7ozUrunaxI
	VKaCoQMO5Qref5OTaAq2eOcxZmqXCrs5LNA==
X-ME-Sender: <xms:9VWlaPXXk0EGtjF4xvlbEAoHvG4U9vXVNGftFvA-NaHNUbmWKbFaZA>
    <xme:9VWlaHwHHoDdtS6R1HDNoPYiVlWxOjV1YhHfnmvvDnjZVJXnbmuciqzT8KVL6fDxP
    FzrzGSnOWjNe8NByA>
X-ME-Received: <xmr:9VWlaNPgrB2ZB7Zwya9bG5AzCZ5rfKXxfbxp3T6lMFULTtY0ukW1EdNuUOvfmuuTKMv2m8M5nFTORHmqpuUtKIrmb6k3Emac--o2DiSkZ9u1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheejgeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:9VWlaI7J4xoJp2Ugu8n2LtrkQuq4cdS-xPqHNM-wtP8u0ZyBG_YpAg>
    <xmx:9VWlaONQkqp2U6t996dBKjDAK6Nfu0g5_dhFp1Wm-wxE6-MHLjriiw>
    <xmx:9VWlaGkV0VurwYaNPYVjgbRGYmrGlxBUXunKnfpb4_ReN52APx3W-Q>
    <xmx:9VWlaFRr4G177JSwITLw-1j5WPyI3Xab7QhdECC-nOkn9gFn_ZHDeQ>
    <xmx:9VWlaB7y4OXwvZDbIaBDRQz_TdrgNkhzlcPCyeCr6wSXXEO6K4KdDXzC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Aug 2025 00:58:28 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 79f251d2 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 20 Aug 2025 04:58:27 +0000 (UTC)
Date: Wed, 20 Aug 2025 06:58:24 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 01/16] packfile: introduce a new `struct packfile_store`
Message-ID: <aKVV8FoZQQB39VKu@pks.im>
References: <20250819-b4-pks-packfiles-store-v1-0-1660842e125a@pks.im>
 <20250819-b4-pks-packfiles-store-v1-1-1660842e125a@pks.im>
 <xmqqect7dxp7.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqect7dxp7.fsf@gitster.g>

On Tue, Aug 19, 2025 at 10:32:20AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> >  	memset(o, 0, sizeof(*o));
> >  	o->repo = repo;
> > +	o->packfiles = packfile_store_new(o);
> 
> Shouldn't this be called o->packfile_store?  It is not like a
> packfile_store is merely an array of packfile struct, is it?

I was mostly aiming for brevity as there's going to be a bunch of sites
that access the variable. But if you feel strongly about it I can adapt.

> > @@ -128,6 +129,7 @@ struct object_database {
> >  	 *
> >  	 * should only be accessed directly by packfile.c
> >  	 */
> > +	struct packfile_store *packfiles;
> 
> So odb has a pointer to packfile_store, which in turn has a pointer
> to a(nother) odb?

The ODB has a pointer to a packfile store, and that store has a pointer
to its owning ODB.

> Hmph.  It is unclear what this step has achieved (in other words,
> there is no obvious thing that the information stored in the new
> structure is used to achieve at this step).  Let me read on.

Well, this series really only cares about encapsulating access to
packfiles so that it becomes easier in subsequent patch series to move
the data structures around. So next to carving out the subsystem we
don't achieve much, but it's a necessary prerequisite.

Patrick
