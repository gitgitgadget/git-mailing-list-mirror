Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034ED54279
	for <git@vger.kernel.org>; Thu,  9 Oct 2025 05:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759987844; cv=none; b=a1Auhll90tonFPob4Co6BX8cTNcUNJuQdRo4PXANqorNWBOO+szFiEKzXoEe85ajJktURgjYzMwBl44nV2fpLhJAlulnyR7blQrVcVCBgA4LjnDfS1Y0mo6JIpLwVEelR7rAD7WdtJwoPbvX9yz+c158GHSjnEmDixWT+B2PaSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759987844; c=relaxed/simple;
	bh=UbPdpRj0qziMEoXPT52nhmjva2P22GftRfON/N/Q0xY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZBzz149Td50DTfkrTskUIHRfWmqoI4v3Z59xSqMkPyF0tJTTfWnQvL8ca1Dd06fmmRaSZekP/Rvf9AE9pGi669+tlNBEqjmIoAZS0PFAiKrI5YTSu1JfFS1Qv4qBv9eM0JF6bdm1X8bpP3fmZztYp9Unc+hzQ0x3grHOSXFS8jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lkyYLVh2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kiw0LpkS; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lkyYLVh2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kiw0LpkS"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0CD871400188;
	Thu,  9 Oct 2025 01:30:41 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 09 Oct 2025 01:30:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1759987841; x=1760074241; bh=6izDfc/gck
	iWxQgkdMLXW6f8qnGwUWfwlug1pb19eh8=; b=lkyYLVh2ucHtseoJo2e2lbhVvX
	hSheIEuEZgaCScxsCSRNvpsYpE7loBdSf8xoweygV4jbQkBTjyiu+BFl9EQWLFVE
	p5InhUQxuFRoU8iKiwNs40xCPeaJry3APW3NR3LgnX2z+e4+2agLB4PmgGHYicve
	155fxnji6S8yyy7XrWw7TdIUyfsmdZLeZ4JVV0Jk8WkovZJU5zq62JOGE8qm1YCA
	Ebhn76ep6T4CmofZSMZBK5wKtLSChSkUmeNbvWccPCzfmKcE9Jz+4kMDVvSz0G/I
	qSJNdvXt4J+vOcAvgT2ewxhfXuyjSzfpUDJ//bsuHhzVKq5EIWyqYIp3ci4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759987841; x=1760074241; bh=6izDfc/gckiWxQgkdMLXW6f8qnGwUWfwlug
	1pb19eh8=; b=kiw0LpkSEbj1t2abY6m6aBwtsjBiTEgNweEgB4pXZqLmWEJx4r4
	lgkxYSJ19YxNP/QlKIPj0U8oibtoN2gHIvpndhdcSkYRnbBK89g7d7bbG1grSYws
	b3D14owHpznZSsbwrd1YrwCATfRG6DgdPTLpxo1tHF0uu5C2QsajUQGgqMyVCQAI
	E0MsQz+QgK3DXHR+DD/gaQRvaST/wbJQkAAVFbKis7NTgU+s2fxdMju4M0XAJ0Qw
	M2hOpotDnSBIoma1fPzf9c5qLegd2ARxwFRQBZ696a/a9kXBsUy0tL7nkUckNVoi
	hkQ0u68UDHHTbJCBPMC6oCADztFTYnTs8Cw==
X-ME-Sender: <xms:gEjnaOn0c48hb6q8EdjQwNfsuEzHAsoqRbLCLIISwAYY1aNPidQYgA>
    <xme:gEjnaPIMIvsU6SFtl0dfs8ndrXx4NA0gjTEB770Uv-1Cprf79wwFY_9lBYKWqSxLk
    XCR8WsfXWEK7DkKMuMmRTrkjhFhdf8fkpyPVBz315UBs6fDj4Nekg>
X-ME-Received: <xmr:gEjnaD6-rrZVJtqzsOQTvySMRwQL9xt7JCwOdY8KEeZXAY4VQAilb2nOfhxMIP8cPmbq91v1DIcDV6nbJsnzIfsdEEqdB4ZUpigGHiAEQEU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdehfeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeeiffegvedukeeuieeilefhgedtgffhffettd
    efgfdujeekteetueeiudeiuefgtdenucffohhmrghinhepghhithdqshgtmhdrtghomhdp
    iiigvdgtgedrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpth
    htohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhsuhgthhgrnhgvkhesshhushgvrdguvg
    dprhgtphhtthhopehluhgtrgdrmhhilhgrnhgvshhiohesghhmrghilhdrtghomhdprhgt
    phhtthhopegrohhtthhpgihsugiijhhlphgtrhhukheskhhithhsuhhnvgdrshhushgvrd
    gtii
X-ME-Proxy: <xmx:gEjnaD3TqnvLwvbaRa0fXjqCPmDR9QuiJg9QH2Yi14sk8jvEiz1tYw>
    <xmx:gEjnaJc1ydHDP0-ILt--d-kPRoS1sAwp8M5aXJzwmn98KejPWP9mrg>
    <xmx:gEjnaJd_03Dwtbt8Qy-evIKCQYzwTYfwYgsFHN5pziNvRMM0rOkASw>
    <xmx:gEjnaEzZJovUJOWuHYFa0QMdekf3brPffcZA971gzm1n7X9oeJPLEQ>
    <xmx:gUjnaDNacff8Nce3AFe5R7jNW2RGXskMqZxMcoplqoi3mHGFMfj903g8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Oct 2025 01:30:39 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5ab54549 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 9 Oct 2025 05:30:38 +0000 (UTC)
Date: Thu, 9 Oct 2025 07:30:35 +0200
From: Patrick Steinhardt <ps@pks.im>
To: aOTtPxsdzJLPCruk@kitsune.suse.cz
Cc: msuchanek@suse.de, git@vger.kernel.org, gitster@pobox.com,
	luca.milanesio@gmail.com, me@ttaylorr.com
Subject: Re: When should we release Git 3.0?
Message-ID: <aOdIe5fLAfiSQsfC@pks.im>
References: <d3f49610-bd19-4bbf-a3ec-c15be2c07338@frost.cx>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3f49610-bd19-4bbf-a3ec-c15be2c07338@frost.cx>

On Wed, Oct 08, 2025 at 08:06:18PM +0100, James Frost wrote:
> >   - Implementations
> >       - libgit2
> >          - pygit2
> >       - JGit
> >       - Gitoxide
> >       - go-git
> >   - Forges
> >       - GitHub
> >       - GitLab
> >       - Bitbucket
> >       - Forgejo
> >       - Gitea
> >       - SourceHut
>     - Frontends
>         - gitweb
>         - cgit
> 
> Should we also consider other frontends, such as gitweb[^1] and cgit[^2]?
> 
> [^1]: https://git-scm.com/docs/gitweb
> [^2]: https://git.zx2c4.com/cgit/about/

I very much assume that those may need to be adjusted, thanks!

Patrick
