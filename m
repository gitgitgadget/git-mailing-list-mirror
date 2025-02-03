Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4961C695
	for <git@vger.kernel.org>; Mon,  3 Feb 2025 07:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738569087; cv=none; b=WkP6U3Xe7ScajrUa7HPp6P64DjpLF9H+znm+6qXUZDrc7Yxm8TT6v0JjD43mB0wAQHxPacId6OioZFa/cm9F3rkQ38OsczAv9mFG+sDtYTdgEFR2ZrRw37Y3kQ2mktH2CqdsR4SV6ltV4djC9AQgp19nc9aIjodIAPQYdilkhs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738569087; c=relaxed/simple;
	bh=phzFRA5FbmK2cr3C32w5P/tpAZLjQq5mau46G3srMy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LPTReYG5kfZJCWAJjBU/0lp7MwU9Sf9ECF/Z5nqh8iDTBzAfgxFWvFRVJpdUgjXft/qX5DdQDiyfYtmEIPOt3859yEYhsq2vfL/X7Iou1IV51SSnnjQmKtb7aGQfYH/g4bomUiKW3ka+aqMcKLTupK2j3MOwiMsCoJYYODiyTZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=E+UaVvG6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=t9rwPNUH; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="E+UaVvG6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="t9rwPNUH"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id BFC78138074E;
	Mon,  3 Feb 2025 02:51:24 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 03 Feb 2025 02:51:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1738569084; x=1738655484; bh=vtZhVVux+J
	g9Npfw6f6sAE4UJeFSpnNfd1l/UwpdNt0=; b=E+UaVvG6/XLXXvgereZ/GuN37R
	pizpK/BzOhtxB02vuNW1YEC4h6aXcR468V9SYUw0sc0faERWTl/3VBolyE7gs7jZ
	fMw/Nir+0Avlkgf/p+3Vn2RoUjIpKKaciHXns8MKTOLW4IxEaGn8r2wgHFx4Di3T
	pFRm6zt55+doXnpCC63X/RXuK+NH8PLffs4IbQjT5OPHLhMfk4RBXkt+gNEtJI3I
	WMXnnBgkkoC2ikhvhQSeOoopzI+sQ4tnq+j+Sc4Mh1xI/DNNSnkBtcFACzihfjsr
	4jyDNcR7zjTwucICDNjrsDQ+OXlCJklhug6NfJhCo44/vMoNrXtCAlT/rHFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738569084; x=1738655484; bh=vtZhVVux+Jg9Npfw6f6sAE4UJeFSpnNfd1l
	/UwpdNt0=; b=t9rwPNUHVrBSsy933C32PpTn8eV1HkSs+qlpmqyYUNfawkrMoAl
	vV1ILvoj/7psyf+6TT7HDz9aC9C7geQkKLRBZjEIk82gPa8/GWf3LzIWMTvgXF7b
	xnATkuNUKNqXUl6/3JOyDCf+B/6RM9AYL+uppr3oOW/qkJJcaf4s0dMH+zjaOmxG
	UQNKAEAyuttI5GAAyS6h4dWIgOrNvhAq3VVbdqwVJaVl1aIKp9Xqoode1LLlL1rw
	ZPVIaRpTqGEqajB/RnU1Z1c2Hc8ByaTUDy8QX8vnnmmVEhZbyoyC+FbB6mqe8fM1
	gZM93q5f7QxeSY9OQJz2VM8lB6+NgmEqzIg==
X-ME-Sender: <xms:fHWgZ8m-BFT9R3h6m451tI8cWTI-X_gvEtm3dOutqxtGMISh2ngOWg>
    <xme:fHWgZ73tr4DPHZ1La9PWalrv15peFS1ZvreZsArulV8BL2c5LER0pIqZtapWUO-Se
    mYAwtb9uQV6C4mn1Q>
X-ME-Received: <xmr:fHWgZ6pfHOL5W7c_2jnFS7x4VcVD_yOaPx3Kctd2KdiWVsiqteYWc8Tufqwqkn4RNj88qZaaIUb45A2BxmVXPPnhvWovKhNCM7w7PIVIeofDHQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujedtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhkse
    hfrghsthhmrghilhdrtghomhdprhgtphhtthhopehmshhutghhrghnvghksehsuhhsvgdr
    uggvpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehtohhonh
    esihhothgtlhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:fHWgZ4njoqUvZWTnULcH-UUQeqJcA0eKRvv4rGtMdClkkTxMadvyYA>
    <xmx:fHWgZ627V6uQgYvgENXEfiikEEmT0Uh_lA4Cll006sGa6hO7Foy1JQ>
    <xmx:fHWgZ_vyWlFjOs_3beIfm6GcGf_E-Uy8rlnLXjtG5sl7MkGhQ1QWXw>
    <xmx:fHWgZ2WICHYcDZA3CCpv2m6FJzes3YK0rUfnfUDVfPilPmdyyg4Dkw>
    <xmx:fHWgZ29OnMScaDdPFOPxrWgLU0q22SHp1MYirRoLoPUatUD5NlYkl8Pt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Feb 2025 02:51:22 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3c799a45 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Feb 2025 07:51:20 +0000 (UTC)
Date: Mon, 3 Feb 2025 08:51:15 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 3/6] clone: refactor wanted_peer_refs()
Message-ID: <Z6B1c1lrmK3RYzKi@pks.im>
References: <20250131-toon-clone-refs-v4-0-2a4ff851498f@iotcl.com>
 <20250131-toon-clone-refs-v4-3-2a4ff851498f@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250131-toon-clone-refs-v4-3-2a4ff851498f@iotcl.com>

On Fri, Jan 31, 2025 at 04:30:31PM +0100, Toon Claes wrote:
> The function wanted_peer_refs() is used to map the refs returned by the
> server to refs we will save in our clone.
> 
> Over time this function grown to be very complex. Refactor it.

The diff of this commit is a bit on the harder side to read, so it would
be nice if the message guided the reader a bit.

> Signed-off-by: Toon Claes <toon@iotcl.com>
> ---
>  builtin/clone.c | 39 +++++++++++++++------------------------
>  1 file changed, 15 insertions(+), 24 deletions(-)
> 
> diff --git a/builtin/clone.c b/builtin/clone.c
> index 69d1ad029dfa84a2f7136fa4a3c4c8a594b179c4..d652682494d0d27dd73cd0585e28b23f2883786d 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -434,46 +434,37 @@ static struct ref *wanted_peer_refs(const struct ref *refs,
[snip]
> -	if (!option_mirror && !option_single_branch && option_tags)
> +	for (int i = 0; i < refspec->nr; i++)

While at it: this should be `size_t i` to match the type of
`refspec->nr`.

Patrick
