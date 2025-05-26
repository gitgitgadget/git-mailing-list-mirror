Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34A21DF99C
	for <git@vger.kernel.org>; Mon, 26 May 2025 07:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748244245; cv=none; b=MIRnRiIHSNTYn8xkQRXLEs2o/UL3lKweiweNLuhgu1N6WAuGwvKUpGj2zN0zUrcdhn4+HBiU+5Sbr89VoHFyicEz88t4AcrlSUHiPOPZE2AId8SKydrqMqkES1EJBv6LAgNu0KvldKFDPjD9Wx9a/Kvo+AjWfTJq/Iy9cBybq8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748244245; c=relaxed/simple;
	bh=024fIKhHFiUoH8bYyitvf1YrHrsYHaHXlozHhB98LZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tnJS/Sx2kRPEp0aWRYiiwD9lpedjy5Sw5UpRHtSAPofiApFA2AUsvDeRfY+Zax6poRT2D1G1WmA/tHibLAlbsOqfVAfn6aIcMMgfm7CD5Ws5w+niuc0Wqib5zCoROKl9Pz6QtWqvrhMI1EMdaESSummr9GgtI8bF8Bf3lx0Siq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QE5L0ey3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MXTLrmj5; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QE5L0ey3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MXTLrmj5"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id AB886138044A;
	Mon, 26 May 2025 03:24:02 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Mon, 26 May 2025 03:24:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1748244242; x=1748330642; bh=FJ94acBMQX
	+sn32RaoD7dbnoFa3yXloVS0MNmdk5yzs=; b=QE5L0ey3AWTBOe5GsYX/7gVixZ
	KfHLSvbT8QPmFTUY6Qrj7lKDX6Du3GPRXglXV2VHnNzTTXDLmIyBf1pj6YYleMW+
	GXUrHXDwcdjQT43X/oBG0z0guVPknaTBVLIuIzbF58vizZkqnQYWhS9zceN/bIra
	oCc40XqQb6gTYxwKZkz8kSf3h0wWxxZHxT4OfWTfU2ukoOjDwbI8KGZhh+w9MREr
	uc52uNF+oZjQzQb+7RwOkvwkXCHn35FtcIZbx6x/7BX/0uw44e+jeSOwgLxaOFWy
	AUFnI+1Y4VLRPacFzEoYWQdGVZdbLhMbEYmLN8bwScamE5qvw0orROBkLI9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748244242; x=1748330642; bh=FJ94acBMQX+sn32RaoD7dbnoFa3yXloVS0M
	Nmdk5yzs=; b=MXTLrmj5OCKW7dy2XKyITjp1F3ls+HPFiv1HjyH/x1e8AKp5cHh
	0NtyA74g3IAToPj7w5+LeXxAGH3Enw1ElWka1CAuyiBF0V6d6zGXbbS+z8ax3DBH
	qtaypDHTlcpg76nn3GkxQ0OwAnLwzL7njjDLyxmyzC3QTmJhgtewPttBM+UcoOwv
	BeZ87T1f5DAtnrG3s+GsMlOvNeSG8P42cemfjLxyuvfLfQ13qHcSI8gOxdunMBYN
	QqBBdN8gPkjJ8uduL0J5+fvFNo6DlHhNVEkhT9BhP82z83zqmF1/W9pr53Ax87gq
	Rl64/c3qXc71dxzaSW1TkO4BlYgyYj8/hDQ==
X-ME-Sender: <xms:Ehc0aMvRLYNdfKbZVl4fLO_bt8C3dCBog4FEu127c89PIsT4fRkoQg>
    <xme:Ehc0aJfRGL6fv299RYs0tp4GMUsouRlHMAHNfOk15xHGmrKw8Sy6507OATJ8B_HxC
    0wz2A88c5-MF5FVHg>
X-ME-Received: <xmr:Ehc0aHw_c11U-5PQWCk9fMi3Q277GnL77DFEYCZdwXxjELkg17fmjbFbrj4utEDqL49S_9UXbcki-2G9Y5U2fYmWypCIf4QIe7QczjNDxbsM-w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdduieelvdculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhep
    rfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrf
    grthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefh
    jedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:Ehc0aPPbTqhbPhkfRBtDjRL5xEBKR2uxnjQJZ3u4NBs9StV3MfLyBA>
    <xmx:Ehc0aM-8dz3BYgvE4A7JmKwt3TOARFzgz0QHLkwgKsPldYY3EMsrUw>
    <xmx:Ehc0aHX6V9Fq7b71FI0IC7mDaA4FnQIZ_UmK9vq4oDJhKpGCHmNbsw>
    <xmx:Ehc0aFdT9PlVn7zSd46_p4Y_hBrNEblVW0oaihxIj8Ux8D0OlHjWMA>
    <xmx:Ehc0aDpTDqovTZlOrUkDupeLrPHV2FFOI_L62z94RK8ur0o-h9PFInko>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 May 2025 03:24:01 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 17e17b63 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 26 May 2025 07:24:00 +0000 (UTC)
Date: Mon, 26 May 2025 09:23:59 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] midx-write.c: simplify fill_packs_from_midx()
Message-ID: <aDQXD8EHD163Mijo@pks.im>
References: <aDC0bK+NOuuVvQtb@nand.local>
 <cover.1748198489.git.me@ttaylorr.com>
 <5d97b706e17117217bf6e90e5cbca9e6e408c5b4.1748198489.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d97b706e17117217bf6e90e5cbca9e6e408c5b4.1748198489.git.me@ttaylorr.com>

On Sun, May 25, 2025 at 02:41:57PM -0400, Taylor Blau wrote:
> diff --git a/midx-write.c b/midx-write.c
> index e4a3830d45..7802a4b694 100644
> --- a/midx-write.c
> +++ b/midx-write.c
> @@ -943,6 +943,19 @@ static int fill_packs_from_midx(struct write_midx_context *ctx,
>  {
>  	struct multi_pack_index *m;
>  
> +	if (preferred_pack_name) {
> +		/*
> +		 * If a preferred pack is specified, need to have
> +		 * packed_git's loaded to ensure the chosen preferred
> +		 * pack has a non-zero object count.
> +		 *
> +		 * Trick ourselves into thinking that we're writing a
> +		 * reverse index in this case in order to open up the
> +		 * pack index file.
> +		 */
> +		flags |= MIDX_WRITE_REV_INDEX;
> +	}

This change feels a bit weird to me. Sure, it does allow us to pull out
the loop in the subsequent patch. But honestly, that makes this
workaround even weirder in that we now set unrelated flags in some
function and expect a different function to only honor it in order to
open the packfile.

Shouldn't we instead have a separate flag for the new function that
tells it whether or not it is supposed to prepare the pack?

Patrick
