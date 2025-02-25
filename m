Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF719267B0D
	for <git@vger.kernel.org>; Tue, 25 Feb 2025 11:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740483757; cv=none; b=cq55C++78H9jnmR6xwk/R97cXztoVCB98Wku2RE2dhxqLXHv9isyG5bI+YP3oRFQjucxnTyvfnyP03/SctNKQh1kbYdUNYVy8a4/zATfqeJrMzaJ+pJDBIfUK1hkVlSSgcwVDASXh72JyZj8UTq9xGbZBSv4xdkSddKTPbEuxr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740483757; c=relaxed/simple;
	bh=rBYmFaRSCC/eEUTAXpCbWSOV4bebxGM++sIyDqC8+ik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=odeAIg1jEAc9Sl2a11aMdRqI0eu6B6G0IJDCTvrdqYBt+Jzh102MDM+ho9DSqJy5nPMgBhvtp+vGIcJEgl9j1ZUcHtik8hVgAad7MK4A6GjJTK4GH+sm0UKfn+ELJhuNMwhygTINgYOMOnkinBko+cfTv8Ldoq4NtwlVD/vyLGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=N2sTQIro; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SWtdLLME; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="N2sTQIro";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SWtdLLME"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id EB7DF1140141;
	Tue, 25 Feb 2025 06:42:34 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 25 Feb 2025 06:42:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1740483754; x=1740570154; bh=4nOx4Zg7mY
	tjcJajpPzPkA1BofSt8HKD4BPfwiGy+IQ=; b=N2sTQIroYUkjv/wxF/TVt6kvYn
	FYmZzkYM6DX311hfH0xhMFRJRWbHU0n1swVmwvz/NX0YjmvEArsi38c2uMahCaNb
	3QQcdL370lQK1xVSsxrEeSCGGB2ObBBwriY1aTFilLobmQALPHG/llma5FfRBvnJ
	/UlAh+Sxq3whyT/dGfuizC3UwynuPIrqQ+o74MXHxZB0TdOj8iCI9PMQXNg1fk1y
	HaZehtu/gQitSBxd/WNpSVU+FpZ9NpIsulWBMi1fN2V6J17wDhU1DZvZi7atlyJd
	Anl4vC9NHZCGEK801hC0jPSctVN0knI+aI5S+rR2HtEcnHr0ZcNKTKIywHJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740483754; x=1740570154; bh=4nOx4Zg7mYtjcJajpPzPkA1BofSt8HKD4BP
	fwiGy+IQ=; b=SWtdLLME4awxTcNkUBVXHlXdmscNURbD29gM6ixKHEW8fwODtpH
	yOtQveZv3phTVQS7pw8ylK9xEwYwjp+D6TTaW4gY0YwcDMsCtpRtSvI+uDv/Vl4o
	Z+/qpdGH30E/GjgAt5neAnQ0kXM2GRDJGfuw4Cog7wmqRtuUmJX7p90qiKGNQpWg
	uhfs+hl9TsvB3jxf8HnrsGfyDMx8+iIst1ksE3JNDov7q29hwMvkg51/9z4hMaEP
	G5fSp1UHgqfFaCoXMIFLmXN/OTQKIDj520RbLyuM7cY8d4KHgG85V2DiqvwCEBVu
	NcxRBXnhp39kz8Bshvm7UEO/9TYssTy0GMQ==
X-ME-Sender: <xms:qqy9Z8rx4-MNAOeLGD3fqbTzz1X7pRUu0DqdWfI70nZISU19T9K1zg>
    <xme:qqy9ZyqLdy090zQntEZozW1hWxUVRuV9NSZCnrBGt6QmA4GpEMrqyECYqEQdjoi-g
    mzF20FOOI7Mmk5Abw>
X-ME-Received: <xmr:qqy9ZxNVBnHWeE_riDMhgRuuMr441mqdqmnEnzuLZX8GtoaEWotZvfKYjdzAY3zYAhZEOF-Xysc09RxzlMgYzYoxiAtpPCQisPP1Br0l0BlL9Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekudeiudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepveekkeffhf
    eitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgvseht
    thgrhihlohhrrhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:qqy9Zz63iPxwMIAsAF_Ms9w9v_Cqenmxf4zerKhnbCPU1d_xhmfUoA>
    <xmx:qqy9Z759Q0hF0IMPo9mEC8WxVa5bhhVcjjiKMByZttwfxXCON1spLw>
    <xmx:qqy9Zzjaw5dBWgXdPB0f6sPYI3M0t0_H893gj-jiJkAU2oYpEb5NPg>
    <xmx:qqy9Z17Lr8Lt80qKWdwN0NWxOhBk2qTny2HKAHJe1uEF1MWW6i7KHA>
    <xmx:qqy9Z9lOiGy0kz7yTWfNF9GGcUPF6P7UGi-JvwCY-0ymE-P0dAUtQloN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Feb 2025 06:42:33 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a879fdbc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 25 Feb 2025 11:42:32 +0000 (UTC)
Date: Tue, 25 Feb 2025 12:42:31 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 04/10] unpack_loose_header(): fix infinite loop on broken
 zlib input
Message-ID: <Z72sp639o8rxG1Qf@pks.im>
References: <20250225062518.GA1293854@coredump.intra.peff.net>
 <20250225062958.GD1293961@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225062958.GD1293961@coredump.intra.peff.net>

On Tue, Feb 25, 2025 at 01:29:58AM -0500, Jeff King wrote:
> diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
> index 398865d6eb..0b0d915773 100755
> --- a/t/t1006-cat-file.sh
> +++ b/t/t1006-cat-file.sh
> @@ -903,6 +903,25 @@ test_expect_success 'cat-file -t and -s on corrupt loose object' '
>  	)
>  '
>  
> +test_expect_success 'truncated object with --allow-unknown-type' - <<\EOT
> +	objtype='a really long type name that exceeds the 32-byte limit' &&
> +	blob=$(git hash-object -w --literally -t "$objtype" /dev/null) &&
> +	objpath=.git/objects/$(test_oid_to_path "$blob") &&
> +
> +	# We want to truncate the object far enough in that we don't hit the
> +	# end while inflating the first 32 bytes (since we want to have to dig
> +	# for the trailing NUL of the header). But we don't want to go too far,
> +	# since our header isn't very big. And of course we are counting
> +	# deflated zlib bytes in the on-disk file, so it's a bit of a guess.
> +	# Empirically 50 seems to work.
> +	mv "$objpath" obj.bak &&
> +	test_when_finished 'mv obj.bak "$objpath"' &&

The order should probably be reversed here, as we nowadays tend to first
queue the cleanup before doing the actual work. Not that it really
matters in this case.

Patrick
