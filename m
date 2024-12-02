Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F646A94A
	for <git@vger.kernel.org>; Mon,  2 Dec 2024 07:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733126058; cv=none; b=dAyl7jI0vt1iQAL4YxPMt0xFnVm4/nnjAP0MCLod/C22IVF5NbD4hCTeOmWpJIPyxb7q72S60Ok/52AWskW+cbTVlfI9h1C+BX81zlnHXxe22U07hHeWxiG+tAodXaiUAFKmKEgHu9Bo66iDwEJ80YYAsFnmHGipkHgxhlzNJw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733126058; c=relaxed/simple;
	bh=8aQZw5AsVJ9w1quhf+wlgoSujok7KVLeeAtI0x2GpOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=po/rx6c1Pda5tgV4nyZgpnu5BtyLgDipdhF275OKeTpvm+PYK3Vc19pZfXzpkBiUcvI2EnAF9MuUQvU3BZcpzJpOWN8woRhMaNbjsnr5eYRS8KzLqxxsu6MyXA3OnMztNVmQMTVEorWVgeTcSOcJGfA1h6EtC2hpMS064wMTMBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OmuU1eTp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lLOU1ZW1; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OmuU1eTp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lLOU1ZW1"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 005A81140145;
	Mon,  2 Dec 2024 02:54:14 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 02 Dec 2024 02:54:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1733126053; x=1733212453; bh=/BiTcjeLxL
	eLvLUAEUcjI6qbBz3rq6HhvUOq65JZ+sU=; b=OmuU1eTpp+SJjJCrsruyNz/Z8Y
	234Xk5PYhQwCh+Pn/eHY0EZp4Vih0VVzLGY7WbBB2sdXSAZ5Y7HlOGNKJ84INLsU
	5RI8b4St87PE6oni45ruLigAXqFAR3BEmpFQe92kfrVbj+Q1obOZbznql3P4e2bn
	MwTHB2noZ7ZxjQ130/3U6hw/F2EcTk1oZugmpyOFkq8LAQnfWm43k+euudcPz0n0
	L8Vl9Lb0ILyrp67kH+IWyVJWXtMxGi5qICHx2vP5kDV3oR5iOsCRanHwyLXWDuDT
	/ic++smZoRAOVcASQe5nxo6nDUGOfvZkoKwivatWY/vX9r8f5j2+aHsICRqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733126053; x=1733212453; bh=/BiTcjeLxLeLvLUAEUcjI6qbBz3rq6HhvUO
	q65JZ+sU=; b=lLOU1ZW14Bp5oP2wB7bZ/EwOMsD3iNr7NU5Pxqw228+fpNLX0uc
	1tzYxRh4Gn4WK2LhXF8ySlNltn+vg3eW8oYJqjvSH8nP2WSMi4RmCIyN7LDgFYg2
	t3t9Nu29+TD+R2UhdvZmnXkm7HoddZirlb+G4mxBCVagIJ/JRSpvs2tDy2IUXQU4
	REZqVJQ+pksM+JwMyqP4YxdaLyWiDlEtN/11tORHznrzdnv/nZ4/Z9YSm5sT/PXk
	3FWhwmiGDZIK0wdzLk1iuOyNKQ83+JlAt/9tJ2lXQuiUWnz2EB71oIAgo5HHfpv5
	7rpvH3jcPfuOw0Q7Jv/kvmpFRpwNf52ULsw==
X-ME-Sender: <xms:pWdNZxCUBcQYTvHMHL9WZY2jYFj7TMYoMr9mYE5JWEf1Gi_xVw4mHA>
    <xme:pWdNZ_iGHCCYK6ECbi71HpnuM6iZejRi8Up7MNtLrF0fQ-fDrarq4CAzCACxN0KrS
    3Bevc1aftCc0q-fFw>
X-ME-Received: <xmr:pWdNZ8mfaMGM1j-SD4edYRBOFArO9I-ddHe1kZyLURXsL9IvZIYqiUJKE_pS3GtjT7dsmy8uCAqcJGM_F77529-Tr4u9GY-7s_J0p-65GaXwPfHhLQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrheekgdduudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:pWdNZ7wKSjmyt397wHe04sMEROvXJSjRRM8TjH4S7KYzbr4y7hI6hg>
    <xmx:pWdNZ2Q-vxOuUMwPX00kTEq2umuf8EBO2CCQA2AkMmOg4Zc-2-n6Qw>
    <xmx:pWdNZ-YEkvdKPgXDibVJBSoTJjC3x7uIXgu3tbMcMP6e49kmG-mowA>
    <xmx:pWdNZ3RLOATBzJ4ENcmp6Q_8lllZrrE3ySfSHqkoIlNDspxStyj4og>
    <xmx:pWdNZxc0pjCZwT6bSXVvPituqb7pIlGc9Td7zJTcoNtsMvgbNIqoPHCr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Dec 2024 02:54:12 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0fc76d1d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 2 Dec 2024 07:52:55 +0000 (UTC)
Date: Mon, 2 Dec 2024 08:53:56 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 00/10] Start compiling with `-Wsign-compare`
Message-ID: <Z01nlG8MbNNBChlW@pks.im>
References: <20241129-pks-sign-compare-v1-0-fc406b984bc9@pks.im>
 <20241201222913.GH145938@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241201222913.GH145938@coredump.intra.peff.net>

On Sun, Dec 01, 2024 at 05:29:13PM -0500, Jeff King wrote:
> On Fri, Nov 29, 2024 at 02:13:21PM +0100, Patrick Steinhardt wrote:
> 
> > when compiling with DEVELOPER=YesPlease, we explicitly disable the
> > "-Wsign-compare" warning. This is mostly because our code base is full
> > of cases where we don't bother at all whether something should be signed
> > or unsigned, and enabling the warning would thus cause tons of warnings
> > to pop up.
> > 
> > Unfortunately, disabling this warning also masks real issues. There have
> > been multiple CVEs in the Git project that would have been flagged by
> > this warning (e.g. CVE-2022-39260, CVE-2022-41903 and several fixes in
> > the vicinity of these CVEs). Furthermore, the final audit report by
> > X41 D-Sec, who are the ones who have discovered some of the CVEs, hinted
> > that it might be a good idea to become more strict in this context.
> 
> Yeah, this is something I've wanted to do for a long time. Your subject
> line got me all excited that it was done, so I was a little disappointed
> to see that it's the start of a long transition. :)

For most of the files it only requires a couple of trivial changes to
get things working. But overall we have been quite lenient with how we
intermix integer types, so there's simply too many warnings to address
in a single step.

> Still, I think it is good to start, and the way you've laid it out seems
> pretty reasonable to me.
> 
> Regarding those CVEs, I suspect that -Wconversion is at least as
> interesting there, as it catches direct assignments that may truncate
> (I think those two were a little more complex, but a common issue is
> then using the truncated computation to allocate a too-small buffer).

Yeah, -Wconversion is on my radar as another step. I hope it will go
smoother when we have already addressed -Wsign-compare, as that require
us to fix a bunch of the same causes for warnings.

We could also try to combine this into a single step, but think it might
be easier if we handle these transitions separately.

> But we have to start somewhere, and this may be a more tractable place.
> The patches themselves looked mostly good to me, though the one with the
> casts raised my eyebrows a bit (I left further comments there).

Thanks, will have a look.

Patrick
