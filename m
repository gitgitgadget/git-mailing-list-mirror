Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BBC376488
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 14:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770388436; cv=none; b=RSXNnAdB5f8eOtRKrPonqk8w1OHtFeCtEwd7RuzVjuVDBagQOglJGNBRJ9HPoVPPSbSMtlDKuMEkO6cwrhFfkuHTmFnf5O2qv8btSEOvP4kGJY4PSvMKdpDR/Hb6fqZv8F5Gnhh6e1eBPLyynha7bPQsB3C4U9M2S2BIEXdNdtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770388436; c=relaxed/simple;
	bh=psuGVaufOAQq5QLp5FF7/VrC/VqvO/lTxiXJKDidOyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BCo02jbDbec3XBTWF7DW3BuB196h0NDrvjfANKOXXraCn3+3pOxYIIr7SCq+KLQL6FQ1aBAxjwffFt3hSPapS8x8zF2t2MN9Y4hLWu9wv2es4/k1tHoGiS78JIjveKpKdwzjAUY+965oq+5ySYCzxBzeJX32C4N0tZ4HRAwd1CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aaufvmkd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JGh+sNf+; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aaufvmkd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JGh+sNf+"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3713D7A019D;
	Fri,  6 Feb 2026 09:33:56 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 06 Feb 2026 09:33:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1770388436; x=1770474836; bh=YrZSpKg1aq
	56gJXxLk+b+1sx+ZgOWlz0SQoX9C6vKSQ=; b=aaufvmkdPND6+mZ0lzOKm+UhsO
	MTr5Z/WGsSYGPjDR2koMtgyDju5WwhmVI+X3UZk5OoAN95rLerR+21PPo+sTf5rg
	EK/98lnuE4eqmOU36eed8kbODqyNyGp5J1rw53M4GDdupUzCHx14k6atBA/GbbZO
	k5wHJD24GdMH0w2vAIubx6ojFur0seQ68y1I2VGblN+twYRZJoR7hSxU/uAlYClB
	NV0PIbNVJdhtVi2xZ2TRg+5TyA+Qsg34FP009XbZf1Ub85LDWglN7Nrm+pBI0xm3
	ayzwgxGdRH8shRvQC8TI386OwFaNSSguuV0yp3ex48IWTh90Q6T+oJGR6cqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770388436; x=1770474836; bh=YrZSpKg1aq56gJXxLk+b+1sx+ZgOWlz0SQo
	X9C6vKSQ=; b=JGh+sNf+7PIulP7jLLjuxDL0l1WzqSgcMZWD/TNSosEXQMbSS6k
	Ab3fbVwE/SIjVzlKDHh03nQXOlr9UCo6H0CzPXldXjYpFKcMbFNefw2PTAfCcL0n
	mz06FuE6lxL47X1S//0IXckLGQlAkgoNUZpf7v2aJoWYfc0xFmWn2XKiUFZzJIUC
	PAz7SGcQIvd80bZ+HKZCJuwBJDcpqre/eBU3MxS14TMztEKOSPaDFc/musPX4c4G
	3sLX9TT+Qcx2y06Nc0kwfvAPcAhuZws2/utTbdcba9kQio6Db/TscBi7LNZV2i6J
	Rcm/ZTw/dtsXOu6oK/WexQYfr64IcrJIsow==
X-ME-Sender: <xms:0_uFacruNH6_CrySwP1mT327i447mVmap8WuDStYeWG2NHbVNz9j2Q>
    <xme:0_uFaZroefwVoJOnNkhbSF7tAzXc3mAzS3V6ZG04QTxUe4Y6R51aQQHj88BUmojo-
    DCaiU9kFGlYsnwO6a5FshWl6ZGuYyMnwgsdsOpSdCXjlvGJaaXZog>
X-ME-Received: <xmr:0_uFaWNzxG5xjQCprjdXBLOfvgSTFwguBQZIYwYJzuLDsgi886SRSxbO7-NM7Ixb7hgKB0Jpc3i5nrKVkJqQAv4_OXY04__dd_BKClk8qEA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeekgedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epfedutdduhfdtleffieekvdfgheegvdevgedtudefvddvffdtteduvdehfedufedtnecu
    ffhomhgrihhnpehmshhgihgurdhlihhnkhenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeg
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphht
    thhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtphhtthhopehkrghrthhhihhkrd
    dukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:0_uFaSwhtLvByMyeeIfmBBSp892ejHIGiEGup0ulbvYRADx6Ea-92g>
    <xmx:1PuFaXvdUCtyImrqeGaNGTY6N5RegtserzTpe9LLbpvzyNJ13cbFEQ>
    <xmx:1PuFaT4dZT6MJq2BnuglC3RdAkqRT8Vrrku-cJID5gk9sXHJeUk3Uw>
    <xmx:1PuFaeQ6ZqqeWWDCjE8jsL0YHU7c0JtXIJJkjSgiz_EAcUQRFeNcmQ>
    <xmx:1PuFaXP6Liql3UD8stcyxmtxITD8yYKq_kgccwXqJ5dC3idcS6hiAXFV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Feb 2026 09:33:55 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 69d1411c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Feb 2026 14:33:54 +0000 (UTC)
Date: Fri, 6 Feb 2026 15:33:51 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com,
	=?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Subject: Re: [PATCH v4 0/4] refs: allow setting the reference directory
Message-ID: <aYX7z_nUc4xJC8Qs@pks.im>
References: <20251119-kn-alternate-ref-dir-v1-0-4cf4a94c8bed@gmail.com>
 <20260202-kn-alternate-ref-dir-v4-0-3b30430411e3@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202-kn-alternate-ref-dir-v4-0-3b30430411e3@gmail.com>

On Mon, Feb 02, 2026 at 01:26:29PM +0100, Karthik Nayak wrote:
> Changes in v4:
> - Mostly re-wrote the code to also support worktree. Now, the existing
>   backends will store worktree references in 'ref_dir/worktrees/wt_id'
>   and add corresponding stubs in 'git_dir/worktrees/wt_id'.
> - We also support relative paths in the reference directories. These
>   relative paths are resolved relative to the GIT_DIR.
> - Link to v3: https://patch.msgid.link/20251201-kn-alternate-ref-dir-v3-0-c11b946bc2fa@gmail.com

I've got some of comments, but almost all of them are just nits. I quite
like the way this is shaping up.

Thanks!

Patrick
