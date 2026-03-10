Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CDE3BD231
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 12:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773145440; cv=none; b=k/t2t8Z9yVhzzmTlrGIcpJqUoXK8662Ujz7XwBuGk4WPjOqBuB9iVPkp0ogAxvokmTKB8n0a8xeqadJoYtQvuwDLkWmvlYzB6nB0Ti8Jml1u4GVFNjmxGpYD0cFP2LPMe7lVIjw29W8iWRzGxiMIGnv0Ulc1dK9x2/kTz44qC8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773145440; c=relaxed/simple;
	bh=ouKCY4WKNCwxHJgGxKx9po2AwEw5dJAwYzCdPcirl4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nIOzWGy5jzU6FDuOXRr7Id99aMCJwGU9zgr3AmcQ2DSYVClBRJkMAxWVVnU4Rs5a4Eo+Y2s7UCo9sIPGXUg9lAkhdsCb8KE4CL63lWmRcy7ljP7BFx1MNA3Ys8XIAyJnNw8/r9uzzw6TcYDSpH+Nb2w3xMVyw4rQA35BJ9hj6OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LCmT6Eur; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yJ2on2T+; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LCmT6Eur";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yJ2on2T+"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B6C3C14001E3;
	Tue, 10 Mar 2026 08:23:58 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 10 Mar 2026 08:23:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1773145438; x=1773231838; bh=yY31WN3iPN
	t7ptNR1KGnHqmZiXb939mXTuGvZNHEFo0=; b=LCmT6EurNQmg8/qllnh6unsYHO
	g4U8K2XVIs0v6/OVUGcVQthS2RqTVUKXsk7m41RUdB+0oFSZIhCuhV0oUeegnQnt
	pAWBq7YRAZO8rekeuzQtSbrlkVDggEQRljDqkrwPcOtmm2sHnhLeW1/4JRUgt+vM
	z2yUx/vdz41gQwiyiWJJPaWVBvbfSsQdwaX7xR6PTQYHw52Dwg2sVvFAA0m68P+m
	N7XWjktix6PdP+rlComlscPm/cMJ46LviEXalKG+bl/A9B+5go67bCrD2vK/8Uh0
	TfgikBnKqeCGEkj0nq5n9G4YD/Qs1+kfP04nNt1PNRIYd0ZWBCh3SOXhlv4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773145438; x=1773231838; bh=yY31WN3iPNt7ptNR1KGnHqmZiXb939mXTuG
	vZNHEFo0=; b=yJ2on2T+iEuceTi+4oNXb8oObY8z4Y8AVnIhyEsaOsK09EHzJBU
	Eylr0n/46Hj7ZMHr2DxwkNe8+iGvZuLWfGcAgI87gbVNmQ30Z2w6ZogBisIx8Lcr
	hEmV4N1DWDdQuIvhwbdwGqz5yG/Ug85GrgyJg9Nh7ckzY+3fLd8hPpkoHFFcuz3u
	SjyXRut31meTkDq9a1keaN9FQJvgbu3ZaOZgdDYtkgowuymjT8aWmGFVlMWMaJlH
	P8IvKixxQe6BnKPjE1F+7I8DnCnS6WH8rBgv3YKuVMDjrGf2WZ3DnlhOgQmxSIuW
	Kw2oHkRuaOulzTRaYdzlql2rjNmScwJT7hQ==
X-ME-Sender: <xms:Xg2waeJRKdzR2BFuItJQw4n0Y9mWqaPRmh7oR4skXGLIqeZm24vtcg>
    <xme:Xg2wadKpr7guRcLDWhSAVRlnRXZyUDRnfkA9DqM9evLm3jokNiFhC9FQoE3V3vnYO
    0MVts4ZkRkcOZB3xVzydbCSBxBBl7QbAXr4OfS6l62pqJIoSwFRUA>
X-ME-Received: <xmr:Xg2waTsI4IyA0rQMJllKRF-4DFtIYf7F0qbeeb7-HFFp9U0o7XcZ1BvyzrC2gEYF6m2FVAm98TEdYtR4t48IgXqqk7egB9WR1NEi9JTe>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkedutdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epgfffkedugedvuddtuddvgeeijeeghedvgfegjedtieduhfeuuefhueffteejiefgnecu
    ffhomhgrihhnpehmrghpphgvugdrihhtnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhgr
    tghosgdrvgdrkhgvlhhlvghrsehinhhtvghlrdgtohhmpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Xg2waSSRTNxwe9OFpxgZzhNf_hKVgmfKNqcoozeBBOeBjJ7gBQTy8g>
    <xmx:Xg2waRNacUkncZwgLtbZS_IHM_ILwoQoBBV7n0FoqRDxN2MYNpqEAQ>
    <xmx:Xg2wafa5Su7ZTk35--lEk5islnN1SRTNpDeK4MEjob0Ysvc23MrtEQ>
    <xmx:Xg2waTxFl-NzQs07_I9C-aAgS0xeR2uQxI4-1g_At9OiNbYjOIYBQA>
    <xmx:Xg2waVqi-elR4Hhou8D42F6KCQBMubwTj1tdD6wiwIOMmL0mu17TEbAc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Mar 2026 08:23:57 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3414633a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 10 Mar 2026 12:23:56 +0000 (UTC)
Date: Tue, 10 Mar 2026 13:23:53 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, Jacob Keller <jacob.e.keller@intel.com>,
	git@vger.kernel.org
Subject: Re: [PATCH 3.5/4] object-file: fix mmap() leak in
 odb_source_loose_read_object_stream()
Message-ID: <abANWS_j2g-ae89b@pks.im>
References: <20260305230315.GA2354983@coredump.intra.peff.net>
 <20260305231305.GD2901305@coredump.intra.peff.net>
 <xmqqqzpwv3t7.fsf@gitster.g>
 <20260307022459.GA693632@coredump.intra.peff.net>
 <xmqqv7f8td6b.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqv7f8td6b.fsf@gitster.g>

On Fri, Mar 06, 2026 at 09:35:08PM -0800, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> > Subject: object-file: fix mmap() leak in odb_source_loose_read_object_stream()
> >
> > We mmap() a loose object file, storing the result in the local variable
> > "mapped", which is eventually assigned into our stream struct as
> > "st.mapped". If we hit an error, we jump to an error label which does:
> >
> >   munmap(st.mapped, st.mapsize);
> >
> > to clean up. But this is wrong; we don't assign st.mapped until the end
> > of the function, after all of the "goto error" jumps. So this munmap()
> > is never cleaning up anything (st.mapped is always NULL, because we
> > initialize the struct with calloc).
> >
> > Instead, we should feed the local variable to munmap().
> >
> > This leak is due to 595296e124 (streaming: allocate stream inside the
> > backend-specific logic, 2025-11-23), which introduced the local
> > variable. Before that, we assigned the mmap result directly into
> > st.mapped. It was probably switched there so that we do not have to
> > allocate/free the struct when the map operation fails (e.g., because we
> > don't have the loose object). Before that commit, the struct was passed
> > in from the caller, so there was no allocation at all.
> 
> Makes sense.  Thanks for finding and fixing the issue so quickly.

Yup, indeed, this is an obvious fix. Thanks for cleaning up after me!

Patrick
