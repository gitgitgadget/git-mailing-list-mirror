Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FF31B85FA
	for <git@vger.kernel.org>; Fri,  3 Jan 2025 06:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735886754; cv=none; b=ajqNaKW0UyUyLT0VgGrrfxNHoVxld6r84Rg26lbIytWhE/3edFNPrAJXwXIXWgE9JlscqaDahGdaFcpD1DpdPvkx8wlGwBiTkfXrNAI9oq17+7O6uT7cadNZjxK/yMWwjFMQx6nzblmEGkL/y/XeJc0YiYyoq9flwhpXgo6RxFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735886754; c=relaxed/simple;
	bh=/fq+nr4MHYk9ovPoSuz2eOI+hbkteDpOMMHzLlXkGHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JNZZ/q6Frs6h8ut9NOYhICZjwqSdnw3p4MKdmddAC11PqdvSI1oIAck1TcUpBCjIQsEYOtaeRytPblnfM4cuHOp9qEOo4j29RWQTlPD+P7A/HmNmdMTlyMRSGipBR6nMtTGDY11J4iSiwqi0NKE+oh0Zpp+5ZvwRxBFsDtsySzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gNlSE43K; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rjbTJGtw; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gNlSE43K";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rjbTJGtw"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E8AEA114021D;
	Fri,  3 Jan 2025 01:45:50 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 03 Jan 2025 01:45:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1735886750; x=1735973150; bh=Bul+2uAQkc
	iVu4Tb/IDDkXhM5A07JUIykjte1/ZVdEM=; b=gNlSE43K7A8WvJQDfyfu0+nfco
	Nx/H0WyAqfU5j48IOQLx9doRCObbmYOCLNbOmRePELPf+sWrGj6xNu2UAizJKrXw
	obvsoaChx8qC3TOAeLpkCgOYoQln7dGx5E4Y4hbilVqS1E7l0K6uXdzvS+LWZxzR
	kJTGYCVKHSM2r+Ebbvli8E27gQ3giiOfHS/si/+/POcfzRmzpHUgXphbMANRjhN3
	NcutD1N3O7XtfkywigBVhUmUTri48xNlBr5lrTzznnV3oxu+gCX0JmN0D2gExUXd
	FczZkqxhBRNgDNjA0FsZ0h9muBnfDVoJKOCEs58SwZk4+z9xyi60XpGDL0Qg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1735886750; x=1735973150; bh=Bul+2uAQkciVu4Tb/IDDkXhM5A07JUIykjt
	e1/ZVdEM=; b=rjbTJGtwRowZ2xPvQberdkiGa2yv5n2PE6TwJZancbIDo/6kFlJ
	yuFmYDGBdcsFjbrLKHPwXvKbwcaSUQA86WF/+vU3KMWyL8tnJW0t6nA4gejqiIpe
	V0qyhyRDjo33DjN4DIxYRY34pMp9Hg3mOd4+c+KXZCbl+q4rc+14oE/6JArPuevg
	Ct43wwOiPWA8jXkrwUEd5EHsKUprUOdBDEi/UhIqzGTLvPrajGSJ4chg1KpxOkVJ
	q19WRynxXzhHzmR28SQuZzZohgiDpy/gQikCBW7s23X+djqsS2+FQJBvemIOvdce
	NtoZikUdPT4Qm2+2rZEz4QeBLD2YfUJ8q1A==
X-ME-Sender: <xms:nod3ZwsBn5h8bXUuHQ_M4rrgXjOBvZBgGbVZxv8uGH2zhs8eW6nBXw>
    <xme:nod3Z9dvvZ7eVzHE9OEdxus7WisHr1o-J8z-DXBswEq2s_lV0oJqvcYOfbKFJWtYs
    mCpNNySf7VVgfX8_g>
X-ME-Received: <xmr:nod3Z7wguEx745O5L-UR_-5srLPEUH-5q-qaC8G7RRKSs6Wrx4_6EJFNzztPG_O9cG8MsJWCcWY4tlF69xxF-305ikf6DNPdZPxf7RQKAk2KPZE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeffedgleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvth
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtoheplhdr
    shdrrhesfigvsgdruggv
X-ME-Proxy: <xmx:nod3ZzNEApKTn79fcQp6zYemLJe-LuMZAqq0ZYA-Ndlxp3GHzXYPgw>
    <xmx:nod3Zw-ghIkNNJw4Lr9_a-HJPKGa-eQOJbwO2y6knjUX1xE4SNrWGw>
    <xmx:nod3Z7U8AMYBFaZIlSd6gFfGYe1tjEfY-_skKRUcpGHESPkIeEp-uw>
    <xmx:nod3Z5cIHuRTv17_WrBwRNIzGBjYfbwfumJdtDWf3KctYBInwVVcyg>
    <xmx:nod3Z0Zz-WqWKTwB8QL3ILNWPp-JZ6lGl-zzap6uSA0lbjx_giVf7sd6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jan 2025 01:45:49 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 46ab49e1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 3 Jan 2025 06:45:48 +0000 (UTC)
Date: Fri, 3 Jan 2025 07:45:47 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] thread-utils: introduce optional barrier type
Message-ID: <Z3eHm-X39LcE8vMy@pks.im>
References: <20241230042325.GA112439@coredump.intra.peff.net>
 <20241230042830.GC113400@coredump.intra.peff.net>
 <Z3JFyniivEd716aX@pks.im>
 <20250101182826.GB1391912@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250101182826.GB1391912@coredump.intra.peff.net>

On Wed, Jan 01, 2025 at 01:28:26PM -0500, Jeff King wrote:
> On Mon, Dec 30, 2024 at 08:03:38AM +0100, Patrick Steinhardt wrote:
> > Okay. The Meson equivalent would be:
> > [...]
> 
> Yeah, I figured it would need something similar (but for our CI it does
> not yet matter). Do you want to prepare that as a patch on top? (Though
> also see the message I'm about to send that we might be able to avoid
> this series entirely!).

Looks like your version was reverted in favor of the new version you
have sent. So I'll refrain from doing that :)

Patrick
