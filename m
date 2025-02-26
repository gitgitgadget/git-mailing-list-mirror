Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B692C17F7
	for <git@vger.kernel.org>; Wed, 26 Feb 2025 09:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740561691; cv=none; b=IMp5/unXipbfJ5+TjfnD3cDvmRI4E/BL1ewG1Ck9OjyBufQ7u2QddNU4TbA10xMBTD39UweuynAYR80X1vF9We/Its84zkShZQk+iwcg/JD8ISI4n5rsPXh1GtKtD6vvbbHCSA1U7VAzFVxspcKvjcpkcbRwcLrrD/z89OyAcrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740561691; c=relaxed/simple;
	bh=7WDwAPeWzlGKSwiLk28yOSxD33LJvRukYvxs02GV230=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fRt/MiNcKaoZ2ACO3/S1FX6Zludb0UiThw3LgiXrV2XA2tNSrM6xIPbfE17b6BKQRxeUaiozWpZfSM/1qb/vbbkzukRTlNQHqFblo3RZ3gQgEMSA8mWBH3ZHYECG/Tb48JWa05JqqFMvAixf0AEWxXadjtX9Pf9DMcCjD3t1yy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=an6iXqGQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Uq8pjxtm; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="an6iXqGQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Uq8pjxtm"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id A9C501380A0C;
	Wed, 26 Feb 2025 04:21:28 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Wed, 26 Feb 2025 04:21:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1740561688; x=1740648088; bh=Vwlt9h4Ns7
	wRwR73nLsTg1wWF/yktxsWyXGo+AudSNw=; b=an6iXqGQ1C7Bt8AfKumQoHeJqK
	nlqudhRg6n9h0OIwTEHVwZkU0SuY0WE0PFY3mu+anz420v5UuIKtcHp4npoG0op3
	U4NQKmh6caa0s416oJ1VTvtH5JVcm87lKwplu3RS5sxa3N/MzV5jXfPCVXWBFdOK
	eP3WsQ75zgr7qcXmuIUGrELlnuzuP8xO7O3GAlKWjNAOsuNn4loTQqhOZQLar6ej
	vtJt10309mBTgo5QGgdISDTP4fyyKQG2Egw4e4riolE0meqh1PcNh6Bu37HbnEaf
	hR4Sz6qkyvQhc4zVsPC31STwkXlXR/RgFFKlFekI3F5rxBJRl1stULCw8NuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740561688; x=1740648088; bh=Vwlt9h4Ns7wRwR73nLsTg1wWF/yktxsWyXG
	o+AudSNw=; b=Uq8pjxtmEAEhg7jbIvz0dfDUnTlqvqbKxD87rHgwWAWv6iKGUrO
	sHDfdPU+lLKbm+qXKfff8eHi03CWC0eGtn2J0F2jfBQuMsZh6w7AMWb0x1U5EBII
	g7BAcJj/oPA1I5XClUarD1MgruTMTm4lSFzja1h+oHjTQqaSjXhhy1fPW9Us6VK3
	8Wibi4EosfBCBk8/UO31KZ9kNyxmuquao5C7ntvVkMN7fUZDHlzCektRsoKn+Qt5
	0VMmbZCch8x4M3aMoou11UUqGCrimtcPRaWPp3VBK6gdSNBsh+656nhBpq+8a3zN
	mPhxSgCrvOAQJrNRdNg7PVFfTZE6N30PzoQ==
X-ME-Sender: <xms:GN2-Zxg3S9XFMGRl94c0cJ0nUWt6GhIxNLvCmVnt-m6bM1M8Nk3oXg>
    <xme:GN2-Z2AhnEa4GOAPgZ3VRSjzUpwq1IQM2nP8K7ltwxHLZTbDczr55ljuvVmUEivVE
    zrDMTvhFPS5R9kGHw>
X-ME-Received: <xmr:GN2-ZxHOVlLwRmSkFeJbMmYp715qG7WNwaKdz8-mAP1v-b-4qSfQE0IEwII1aef6q2GrNvrot4Z1OFTZwOOBN6mEb--Eijgnnv-IGOVtEKqlJ_Af>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekgedvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepjhifihhlkhesjhifihhlkhdrnhgvthdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhrtghpthhtoheprhhosggvrhhtrdgtohhupheskhhooh
    hrughinhgrthgvshdrtghomhdprhgtphhtthhopehrrghnuggrlhhlrdgsvggtkhgvrhes
    nhgvgigsrhhiughgvgdrtggrpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrih
    hlrdgtohhmpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidrohhr
    gh
X-ME-Proxy: <xmx:GN2-Z2RvqAYGjr0Fp9yx8GzxtQ8X4yPuyyge6ndbccI8p_ed4tlUcQ>
    <xmx:GN2-Z-wJP85ty-QSpJ2sLT0wVfa1gBPnIMMd5qgGHZniGCMLYb0NtA>
    <xmx:GN2-Z87dN8IVq-yoo_EZO51d-gXApcUsKCkZhP4Ya6uJ2AUo0Pmvuw>
    <xmx:GN2-ZzwWlnPBuQLHkbJbpjM7Yg62fZTFPBi3xuKoBCz6apR_3MAO6A>
    <xmx:GN2-Z5zD0Df7N5YtHdGrPo_qpObhPDdjdOeAhTrp6JM8GTMK7SW01amR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Feb 2025 04:21:26 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f5bea79b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 26 Feb 2025 09:21:23 +0000 (UTC)
Date: Wed, 26 Feb 2025 10:21:22 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jakub Wilk <jwilk@jwilk.net>, git@vger.kernel.org,
	"D. Ben Knoble" <ben.knoble@gmail.com>,
	Robert Coup <robert.coup@koordinates.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	"Randall S. Becker" <randall.becker@nexbridge.ca>
Subject: Re: [PATCH v4 5/5] remote: announce removal of "branches/" and
 "remotes/"
Message-ID: <Z77dEqpX-NbUWICx@pks.im>
References: <20250122-pks-remote-branches-deprecation-v4-0-5cbf5b28afd5@pks.im>
 <20250122-pks-remote-branches-deprecation-v4-5-5cbf5b28afd5@pks.im>
 <20250221152644.o5ni6vn6rncvmaq6@jwilk.net>
 <xmqqmsef9mm1.fsf@gitster.g>
 <Z714F8mLHZcoHptI@pks.im>
 <xmqqcyf5io61.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqcyf5io61.fsf@gitster.g>

On Tue, Feb 25, 2025 at 03:45:42PM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > On Fri, Feb 21, 2025 at 10:30:30AM -0800, Junio C Hamano wrote:
> >> Jakub Wilk <jwilk@jwilk.net> writes:
> >> 
> >> > * Patrick Steinhardt <ps@pks.im>, 2025-01-22 12:31:
> >> >>+As our documentation mentions, these directories are not to be found in modern
> >> >>+repositories at all and most users aren't even aware of these mechanisms. They
> >> >
> >> > This isn't accurate. The "branches/" directory used to be part of the
> >> > default template until very recently, so it's found all over the place
> >> > (although most likely empty).
> >> >
> >> > I'd say: "... these directories are unlikely to be used in modern
> >> > repositories and ..."
> >> 
> >> That's a very careful reading.  Thanks for pointing out the
> >> distinction between being found and being used.
> >
> > Indeed. Do you maybe want to send a patch for this? Otherwise I can
> > handle it for you.
> >
> > Thanks!
> >
> > Patrick

Ah, I didn't mean you, Junio, but Jakub. But anyway, thanks for sending
the patch!

> --- >8 ---
> Subject: BreakingChanges: clarify branches/ and remotes/
> 
> As we have created an empty .git/branches/ hierarchy until fairly
> recently, these directories may be found in modern repositories, but
> it is highly unlikely that they are being used.
> 
> Reported-by: Jakub Wilk <jwilk@jwilk.net>
> Acked-by: Patrick Steinhardt <ps@pks.im>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/BreakingChanges.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git c/Documentation/BreakingChanges.txt w/Documentation/BreakingChanges.txt
> index 7c388e56c8..042709a461 100644
> --- c/Documentation/BreakingChanges.txt
> +++ w/Documentation/BreakingChanges.txt
> @@ -169,8 +169,8 @@ started to migrate away from ".git/remotes/" in favor of config-based remotes,
>  and we have marked the directory as legacy in 3d3d282146 (Documentation:
>  Grammar correction, wording fixes and cleanup, 2011-08-23)
>  +
> -As our documentation mentions, these directories are not to be found in modern
> -repositories at all and most users aren't even aware of these mechanisms. They
> +As our documentation mentions, these directories are unlikely to be used in
> +modern repositories and most users aren't even aware of these mechanisms. They
>  have been deprecated for almost 20 years and 14 years respectively, and we are
>  not aware of any active users that have complained about this deprecation.
>  Furthermore, the ".git/branches/" directory is nowadays misleadingly named and

The change looks great to me, thanks!

Patrick
