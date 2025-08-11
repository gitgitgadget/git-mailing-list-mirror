Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425B71A01C6
	for <git@vger.kernel.org>; Mon, 11 Aug 2025 08:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754900674; cv=none; b=l6YqcCo0zgmv7VtKIgMD028bwjHJDOwbJwvY+umulSAmQkUSWACcXFtl8xyut60ZwKCypelp/QFTgsv2xLQ2y0s29E/NocRu9uOicIc4d02MNX2YZvmWMDMBFYZkLYtvSCSwYdzLdDLneGoyAXHQO1nWqT89nT6OutvDsKK6uZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754900674; c=relaxed/simple;
	bh=+HLxKgLv1KN96oAY1ZuH9eaMdYSAGLxnoqU4TDXZiNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GivyZJE8I52m4IY4Vc/vFpySW+HJkkBHPBRfEI3/J1xP690JGeIYrieRI94WKvIIpSa6ET6zdtdfiPexPg3ERSjBuY/ArKMdMGDb9NoGnQnlizPZdGaXNywz1DWgb4cKrPehJd3meVdWMqygRMTMxZDrEPt4he+FDuZ0A29+lW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NlYVg/9I; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Vff8hswM; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NlYVg/9I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Vff8hswM"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 4B048EC0091;
	Mon, 11 Aug 2025 04:24:31 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Mon, 11 Aug 2025 04:24:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1754900671; x=1754987071; bh=lG9s6tcxkT
	7SKPm9mEgZrglQHnH+xtMf1/DAY2AiFSM=; b=NlYVg/9I1Q8IIy/uMbw2zhNKlp
	/PmhNNmza0ETNyEByfCJQ5DIj11bd2rHH6s1bKFNm/M/5ChnLwmYm0FLVzvMDci/
	WmX54VzyAVSEqhFMs5PqLjGM0MAQsKK9/xFiiKN1tIjD3sazTS3ljreJS0wuH+Qt
	iLxu2nLULVHUc8tiXZMwvOAg9+sE9AzuFNzRo0HeZaoPWKIhrKfspUlujG2C8bk5
	S+zqMTCblprtmvXuuS/Wkt29PhUOUPoAvPUsL5Jtos8bgPWg17+nPFpGCn+gHQgG
	o1/TrFugpkMjcPZZfFQ82OSih1YIRojj/Nr7ntS18xa7DHRjZ8ljyNB5P2rg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754900671; x=1754987071; bh=lG9s6tcxkT7SKPm9mEgZrglQHnH+xtMf1/D
	AY2AiFSM=; b=Vff8hswMn1yJfetfY1lqN/g7jvZxeVA45DHinV9BJ3vV00I2Xl4
	sB2Ik4zD6OShlHqtHUuwiZv5IMwom/38AOungXnsUxp0aY84LViSqYQVaM438Rha
	3CQCcEFe39Ga/dY3p4eRNjDoyOwsU1SqetCWj/3d6XwM3UI6sYv9/JPfa0DSW9T1
	XEJENSlzCQl74uBadzKlEh6gzfi8TpC/UvsQgS1prCIsSarev/fVC+5OOyqHRrfA
	p09t2Mw4v1xV4iQ0007QXaaTioDkd4Ae0o6JxJ13ewKBdpfwVJ7cxXpCOs7G9pyG
	vSnH4ekOKPS/EMdNlM2lgZn495yujLoscZw==
X-ME-Sender: <xms:v6iZaFbF7KH9gzuK8hKy-cNXJJQ3fEPC2qHUPtW149Zq4P_0hpKKWg>
    <xme:v6iZaH7cdc02bx71q5zH4RUAGO-Ni8uyFm4DMagVPYzq16W1YHtOnFQLWAsRRERAu
    a76gNkoQ4UZoEWpgw>
X-ME-Received: <xmr:v6iZaOY_EW03-k2hox3B4DrUc4mTmdccNnEqWMU3mP-sJXg3khtcp5wBOwYCrQ5l5eT0aws2p747zo0qkUijQzChMn-BgLvviV-h6FHN9i4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeduleeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtrodttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epjedttdegffekudejjeegudehgfehtdfgtdeiudelueelgfeuteehledugeeuueevnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehsthholhgvvgesgh
    hmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehoshifrg
    hlugdrsghuugguvghnhhgrghgvnhesghhmgidruggv
X-ME-Proxy: <xmx:v6iZaOiV3oBczzgIZDsd2CU28iH1nQgqx_RvvBFzxiWDroudu2M_Bg>
    <xmx:v6iZaH-dUD9gaYgfDCHmukbsT8nqKNH3jElEAoGzTUsZTw3OckRh_A>
    <xmx:v6iZaBpxIAxsbAoKp5mbaz-c21KuhhnRe_lGmXbqkyp0LYVNyEyt2w>
    <xmx:v6iZaHXF1hYuOFbMCpr1GBRmfHLutPZT90p2ptZJY-D_fs0f8t20zA>
    <xmx:v6iZaFXbKjqrTvRzaFBMVnypjSSMKce-5FSVtti_Z7IxRuwyfQ6nvRv_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Aug 2025 04:24:30 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b1c8cd89 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 11 Aug 2025 08:24:28 +0000 (UTC)
Date: Mon, 11 Aug 2025 10:24:25 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
	Derrick Stolee <stolee@gmail.com>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Subject: Re: [PATCH v3 03/10] commit-graph: fix type for some write options
Message-ID: <aJmouVRjPrBlLvrT@pks.im>
References: <20250807-b4-pks-commit-graph-wo-the-repository-v3-0-82edef830a1e@pks.im>
 <20250807-b4-pks-commit-graph-wo-the-repository-v3-3-82edef830a1e@pks.im>
 <xmqqv7mykb65.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqv7mykb65.fsf@gitster.g>

On Thu, Aug 07, 2025 at 03:40:50PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > The options "max-commits" and "size-multiple" are both supposed to be
> > positive integers and are documented as such, but we use a signed
> > integer field to store them. This causes sign comparison warnings in
> > `split_graph_merge_strategy()` because we end up comparing the option
> > values with the observed number of commits.
> >
> > Fix the issue by converting the fields to be unsigned and convert the
> > options to use `OPT_UNSIGNED()` accordingly. This macro has only been
> > introduced recently, which might explain why the option values were
> > signed in the first place.
> 
> These are platform natural "int" from their inception at c2bc6e6a
> (commit-graph: create options for split files, 2019-06-18), which
> way predates the recent push to appease -Wsign-compare, so yes, it
> does explain it.  But because the developer who wrote it in the
> first place is around and with us, why not ask them instead of
> speculating?
> 
> As the max_commits member is comparable to 4-byte network byte order
> integer that is .num_commits in the file, using platform natural
> "int" or int32_t is not correct, because you may not be able to tell
> the command to hold 3 billion objects before splitting, even though
> the underlying file format does support such settings.  It has to be
> uint32_t or wider (but if it is wider, you'd need to be prepared to
> correctly compare max_commits with num_commits, and take an overly
> large max as "unlimited", or something).  And unsigned usually is at
> least that wide, so the change may be justified.  I do not see a
> reason why we want to avoid using uint32_t, though.

Using `uint32_t` might cause regressions on some platforms. If for
example a signed integer was 64 bits on certain platforms and we
restrict it to `uint32_t` then we'd now refuse to take any values
between `2^32` and `2^63`, even though those are valid values that we
accepted beforehand. So if somebody was using any such value to say
"make this essentially unlimited" then we'd now die.

But by using `unsigned` we avoid this pitfall, as we only extend the
range of accepted valid values.

> As to size_multiple, it appears to me that the number is really
> designed to be a small integer (for which even 100 is probably way
> too many), so I do not see any reason to insist it to be unsigned.
> Even "short" _ought_ to do fine.  And if our macros and compiler
> settings do not support it well and DEVELOPER=YesPlease build
> complain, that is what we need to fix.  Papering over the problem by
> using unnecessarily wide type, or by using signedness that happens
> to squelch the misguided compiler warnings, is skirting around it.

Yeah, it is. At one point I was pondering whether we should extend our
parse-options interface to allow restricting to arbitrary values like
100. I even implemented all of this, but ultimately discarded it because
it wasn't easy to decide where we can retroactively harden accepted
values without causing regressions.

While large values for options may frequently be unreasonable, it
wouldn't be the first time that I see users doing unreasonable things
intentfully. And sometimes the outcome is even something sensible.

Patrick
