Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEC02066FC
	for <git@vger.kernel.org>; Mon,  3 Feb 2025 08:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738572055; cv=none; b=KXQ++O3dgnkDK6IuFDkZlVjxvfdHO1OVPQeVCFSlZJjekG4nUDqzmiuv3tGHIWnBUbkhosGPrFdett4bVEfW5P0EU4Hr319jK+mkpiZ1F15WOa3qhpfZSUHCLfPIKY2zL2BiREWyb1mPyQ0WbAWfJIh4vMOGuzbkkQ/GU3xhpdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738572055; c=relaxed/simple;
	bh=PrCr4chN3k+45XqeupVX2Tku6XqcRJPmKv0ss+xTi5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bKwU6OzvpFT6H7DUjSGAKnA7ZriKau3YTlROKsBfgYG6b4QYqdnySKdaAOJX5aIC1XmMe6AGyFMhkbyA9DHJm848M9TJT+idNp7IICM67UcgXRqTAcakwG2TmIr2gOku6GMOPZZ2Bjig8PmZk9IBkQm0VVQ0H2nLprDhuDGOIdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jkRIS5mF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wkH8NDR+; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jkRIS5mF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wkH8NDR+"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 8EEF4138085E;
	Mon,  3 Feb 2025 03:40:53 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 03 Feb 2025 03:40:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1738572053; x=1738658453; bh=nidTdxBTEi
	1xRRNAYLkkWce1XJ0uidjRJpLYkzt5nz0=; b=jkRIS5mFRWlyr7YVmnxGrNg3x5
	vvb65mGBPr1Qo100nefOWIEDr0M1plh8YZ/PArWHFbL3KgZ8TXZpGwbMAJh2w2eE
	RRKGMElRkuDwOQ59TB6vF8XE2aaUVg6AWUIfvYZVJA6Zx22cMx8oMZQezzg5MvV3
	Uuu52QYDx89dTmVyr+hN/AT1G/YBuC6qj8PdlAGv9nxOQmvrdhWc0SiW6RHO0nzY
	2/Fd1YhCIpPg2nr59Yo3uOXi1U6Rc4goCcxHvdDNnwHcrA+o+QEuVMGRkPfV1kcZ
	dACodjwe2BWoS4jpWycL049eacFDm3eL28nJV+L0ZdZjhvdz1mMEv9S4ucXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738572053; x=1738658453; bh=nidTdxBTEi1xRRNAYLkkWce1XJ0uidjRJpL
	Ykzt5nz0=; b=wkH8NDR+fxGzBgkkOEmfAn7LPvFftxchoaMiOqavEk03Vw14NMM
	2WCWkFnfpAXrIAOdxixc99UjpqIVL6hVj23FjXDDNjmzcZo7oMge1QrlXHX0gD1y
	M1VR1XRvgGuVtmfgDuAtPBLCmXqDM06mLjdBPoDxb5xi/IGBSqUgQiFg8gIrign1
	1NB/wNIScseYToxn5JY7rjP26O7wjEjJ7dK8dtOxukLxAqHXzNST+zfvOq3SBdKB
	kpE1qfd+b44WSN5IwBedSmap1A94a2UZ8wFk991DieT1x5fKs4P0PNRIkgZQ2EeF
	3xoLkhpQCo3pVIQ1fWonCYKtAC21SjlL1TA==
X-ME-Sender: <xms:FYGgZ9N-mdzf39AZm0jb4AtHLSMaCtqEe9MH7BeZ0otrgkgDng71Qg>
    <xme:FYGgZ_-txgGUCk40S4YjVN5t--oC3eVfzZCELsBBUNHHTCx9WaGBLJvhcxE6wJN-5
    MQrgZkt1FlYstcaAA>
X-ME-Received: <xmr:FYGgZ8SHX8L0fdxbU7obq8nphuqFs37bkTjkBr-f_I_Xqk2hWXHSvk7RLWpfIDT-mKhsaqYS-aOyVBbgLXoSgKGfi6kzJwaFEaY4MOBbxPePNg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujedufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjieht
    sehkuggsghdrohhrghdprhgtphhtthhopegvthhhohhmshhonhesvggufigrrhguthhhoh
    hmshhonhdrtghomhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:FYGgZ5tSOvwuSBXmJgfBG1R9nx9ETZoPgUq73gkL25TNvCu-LylJ1Q>
    <xmx:FYGgZ1cyNJgJqS-PMC1VX2y8YR36T6zqLl7LK_J4fqem2FbCuW4gmw>
    <xmx:FYGgZ101jg49Sc_f8a72DVW85To8QXIgwBw0HFeq5iKa5XsslL5WRQ>
    <xmx:FYGgZx_Y10BVluQevCy_ED_z4bdEiwQbKsUU_fsfkkqyUvFw-bUfZw>
    <xmx:FYGgZ-Ewx50ZNKU5rf38HD7zQWysZ2wIDM5lIjxQtoJReFbJdhQQQw5y>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Feb 2025 03:40:52 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6b39ee57 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Feb 2025 08:40:51 +0000 (UTC)
Date: Mon, 3 Feb 2025 09:40:50 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Johannes Sixt <j6t@kdbg.org>,
	Edward Thomson <ethomson@edwardthomson.com>,
	Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 15/20] compat: consistently resolve headers via
 project root
Message-ID: <Z6CBEsI1E_TNnMvq@pks.im>
References: <20250128-pks-reftable-drop-git-compat-util-v2-0-c85c20336317@pks.im>
 <20250128-pks-reftable-drop-git-compat-util-v2-15-c85c20336317@pks.im>
 <c0ee472a-5ce6-4e2e-8922-65927f07029c@kdbg.org>
 <xmqqldutk8bb.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqldutk8bb.fsf@gitster.g>

On Wed, Jan 29, 2025 at 06:23:36AM -0800, Junio C Hamano wrote:
> Johannes Sixt <j6t@kdbg.org> writes:
> 
> > Depending on the desired goal, is it perhaps better to use <> brackets
> > more liberally?
> 
> I'd be in general in favor of that direction, as the semantics of <>
> is more clear than "" from the point of view of the standard ;-)

Hm. Semantics are indeed clearer when using <>, but I think that in this
context "" still conveys more about where a specific header comes from.
I know it's not the whole truth, but "" is typically taken to mean "the
header comes from our own sources", whereas <> is typically taken to
mean that it is provided by the system.

So if we now e.g. started to `#include <compat/msvc.h>` I wonder whether
this would really result in code that is easier to understand, even if
it is technically correct.

I dunno -- I think I'll punt on the issue for now and drop the commit,
because I'd rather want to not start discussing this in the context of
this series here. I'm happy to discuss this as a subsequent step though.

Patrick
