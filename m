Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AF01E2617
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 08:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729500307; cv=none; b=pHOcLyDaRX1V6qr5tbjbmwr170i1UjMlvwgcWecuFHC6cj3/ZPdhnCz15Szvf8nL/YKLMsi46/RFwjbFjH7YEA0+53LydMUOASA0JA8WsusDgpgPftkd4QWErxk24OY65F7Y3BkNrwUD9jfLSQ0zXBv3FzuBtg0UR9/K0LoM6jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729500307; c=relaxed/simple;
	bh=jb5eOAsDiaA7GbAnWKlON2Y+vIwAAeJRRfugUF8u/bI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tRD3wgN35cSeRUV+OnFhpYMN7vw0r0/6L+6lq9JFU72Y8DfHJCx0KaO8UU6yfio1AKJuaGO8+4GVmwv7pCSYCl+fqYfz3byx4B8LHTA7e+6rS+XNoLOK78LvV/bSaCNr26TLivTsaS5SIitIyiH8wI0goYmtswWmJ30R1ZI3+vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=3z8rAfDA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KLDdakgX; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="3z8rAfDA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KLDdakgX"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 555BD114017E;
	Mon, 21 Oct 2024 04:45:04 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 21 Oct 2024 04:45:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1729500304; x=1729586704; bh=2EPU62U/K2
	eiDh+qut6kUQBm1V2vM11v7sX2nH/VF2o=; b=3z8rAfDAHUBdFHR6WbQV4AtpR9
	xZJKncWZ9eUCFTpuhof4J0+xyfs6SAbm3x3jaDzrIINrvvxTpbV1RRDLl6S32fi4
	HJqAhTRoLbLzcy26gVb5PhNI17VED2Johyp9K1uYdPBZ0FFXeKiis02M3CZfHHte
	PPTplZFY35Wzfyurmp6bLYRe5AI0HZ4fqvsA7YcGONkpXnYJ9ZQVLkO3ORmIDF8s
	1kYgKJLKLFjBz9F9N9mwHW0fRgEz+uly1Iefd5xeaPP7epgulTV9BsU0tkl/k2za
	Dg+J1C/l48XSHwigI/Zgo6SxuJSaNd1TnbUYzVb9wL5oi1GD7I0TJb0UIs7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729500304; x=1729586704; bh=2EPU62U/K2eiDh+qut6kUQBm1V2v
	M11v7sX2nH/VF2o=; b=KLDdakgXB4y9P7J7VIbHXA0fL945DLDz98cw+P8qYg2M
	DFrs0DAzr4LoM1rNx6C26k7GLApt5rUk0SRQnMK1Zh8sx9uw0g99wB5roZ8aLyYd
	0NQv7ajvntp+n4hFNJpfcfs2babvhurnWxM+UKBzFVz2yoPFifqT67XvBk5q+NjY
	qMKN9H0wGxtMXOwLeK+p1CuhwN3smjFQRIcFGLv/8uAWsARKmspfE5HDYgY2BtJd
	1Rm0eVrIy0CNm6xcF+ZIG3DvJ27R2nnXcoc9+8skHYywHaoa1Hci7S6Z4oY18jGh
	mhRgtxyMQo0j65jVgXUGAbx4j+xXoUvv4mHgt9r2/g==
X-ME-Sender: <xms:kBQWZ5_b6pBY_m68NosnnexZlHzswAJmVYS0DgfyHDFN3WXZAG763w>
    <xme:kBQWZ9t42lUAk3c07m4z5gkgiF19B5DvBgot8jp9M4xYif4tibNDF78gSXuJVFb_d
    GOhYu7_2uw8mtKU8w>
X-ME-Received: <xmr:kBQWZ3CP3iEj0K1gcomnXfXeP5kQXnAqBKUGGhOAWwWXuUdgg4fZfMDDj7lvDOrTg8x4J2F-FAffPkLt-pNAeyxslSz856pMMIjvL9r1cANg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehledgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:kBQWZ9cexQD9s2pA2EP8mw3RlBH_NIYrki7DzmuNJny7ApInK971fg>
    <xmx:kBQWZ-MPG4r1IbwmSDXwyfyyTNC9NDHqzUwyH9V12NfrbMuCBbwkaw>
    <xmx:kBQWZ_lR9h35TsNRQjZyQedZfodXQddD4DrMgHPShMEDaSay5ftYEg>
    <xmx:kBQWZ4susAFBr24Z6az-z1dPE6TRe8V2PlIYFH3X0zf72yr6X3Xbag>
    <xmx:kBQWZ3YW9aFc6I9w20VkThHchlTEABAwyPn_rU5yeGYsdlpq3qjEKBZW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Oct 2024 04:45:03 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id dd935947 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 21 Oct 2024 08:43:36 +0000 (UTC)
Date: Mon, 21 Oct 2024 10:45:01 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 20/21] builtin/merge: release outbut buffer after
 performing merge
Message-ID: <ZxYUjY39ihqUEjH-@pks.im>
References: <cover.1728624670.git.ps@pks.im>
 <bc2206aa47e7e8be0642bb4540e7ddec22fbac91.1728624670.git.ps@pks.im>
 <877ca5d3dn.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877ca5d3dn.fsf@iotcl.com>

On Fri, Oct 18, 2024 at 02:03:48PM +0200, Toon Claes wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > The `obuf` member of `struct merge_options` is used to buffer output in
> > some cases. In order to not discard its allocated memory we only release
> > its contents in `merge_finalize()` when we're not currently recursing
> > into a subtree.
> >
> > This results in some situations where we seemingly do not release the
> > buffer reliably. We thus have calls to `strbuf_release()` for this
> > buffer scattered across the codebase. But we're missing one callsite in
> > git-merge(1), which causes a memory leak.
> >
> > We should ideally refactor this interface so that callers don't have to
> > know about any such internals. But for now, paper over the issue by
> > adding one more `strbuf_release()` call.
> 
> Shall we mark this as #leftoverbits?

I guess it is now marked as such :)

Patrick
