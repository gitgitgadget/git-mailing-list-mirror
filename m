Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92C734F24B
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 07:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773385362; cv=none; b=nnFbaK/EWEvqtYJo9HkHM6kHxxz+gaK2lvnh9vkk5xy/8oXSg+YGERnGLkDkFS1ei/mw+kldKf9KOsOg30FNa82TxrPlQa7THH2nFDjg1Va3K8kjAz/dYGaCI3vydEbKAhTI84UucEBy5P6NxaRb9U2nLUNKToSlvjd75ETcpbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773385362; c=relaxed/simple;
	bh=RZxCBiMLO5CjijRNTXW1KIYGOXc1tih1dmMZ/ftX2aQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AY1sju8U1qqGP4yIt8ZrMLesW4zn22kx8/L3moTQKhVpv6IGMducEHkysqN7q66dhgl1O8TGDlLQ2doUtcMrHxYZsKxmQCF0mtyB+lv9ocoR/MJ4CEdfvbpbKE1kTyQgi5vWOoBgomFjcghUCqVvCWC+jHcWgCvgLDaQFTcat6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mYaXTkxe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tkxXZxpf; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mYaXTkxe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tkxXZxpf"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 01FDB1D0012D;
	Fri, 13 Mar 2026 03:02:39 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 13 Mar 2026 03:02:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773385359;
	 x=1773471759; bh=oMi25/6pm6saIXkjELTeTYidy4xpCf60tyOiSwCj8b0=; b=
	mYaXTkxeF6qN8nD54c0O92gbohui12AP+A12rBVlvRe8GLGOlmdryQH7JfMw9/iB
	/e66M147BPTZFOZABwuJf4gelOcM9PMt1WomRmOvfW2PxzxJLFBOZG/Y785tXIIV
	8NfizGyF9kRLgsaU4JTS6aXgaHDvwQvXdyzTkzsKs1s9vWb5DRxGpuEQhuwNJU7e
	GbLPlS1n/6ePddRC2+Fa/hag7ZY2xk4xnzYpk1iBJcWKzVK0uidON3oMV+Tp7PD6
	bC4FZKzUMJ9mPA/brUx/T597IyjY9KxP/tVpjLZ0gVCkOI9zp9bgGiccS3w50RhP
	fTqnQSdztVHE8KVDYkruGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773385359; x=
	1773471759; bh=oMi25/6pm6saIXkjELTeTYidy4xpCf60tyOiSwCj8b0=; b=t
	kxXZxpfZBKCaXWMlUa/rh7+AoRAcI1R4UJE4rvybm23ZT2MfrG4i62/8iXHgVFlY
	HV7ZkoWByk1Sj/8sMTI+S72neB3p56rI84biHyu/1qRuvcxaku35e0U0SvA40v40
	aZp4KS9ekW2TlBdt3ljRSRfq3RKOCHaGJrkVXDXVn8eYDeNgo4ySyQB/tgin/zL5
	9A5VWg4tMYugmg8fAMF4FR4CkS41PETwYVyMAMlVQ2zF6ldZ2UGkZ60FC+JpG11j
	48B8XecGCjX1vAu3bk0RKoVkGQmTT+KV2p0MWEecPIewYzjtphz/FduZZ+/L3Mia
	IoHZAF8ML9IG3Bo5txNhQ==
X-ME-Sender: <xms:j7azaQO4oqlSvekogmoorfjUFYo2ai379jJec5q3mwPwSx2wSDAFng>
    <xme:j7azaQR7TIxCvBsYvMr1U5ccztBmZFXVD4jjsNcqAq9nilrmj5EWJznwj3Pbvv3Mx
    Ilhz492flYYD4PtqN-hovxBOJN6cRFxT9pOtEF7blD_0dDs8F_D>
X-ME-Received: <xmr:j7azaejHO7nlmu8dDv-VTZQUMNzwH2oB5H5SDmZc6C-YM7MOJsTPvb08mpyE6hbzqDjVd0x-o2EBj9xhA9h3jGr5o8MBZ0er6oW9wvqERQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeeltdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtugfgjgesthekre
    dttddtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepvdefjeeitdetleehieetkeevfedtfedvhe
    ekvdevteffvdevveejjeelgeetvdfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtoheptggrthesmhgrlhhonhdruggvvhdprhgt
    phhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhk
X-ME-Proxy: <xmx:j7azaZ-sHp1J80ao55FbZFpPWpcj0hwGZAUB-gMi4zvhdJYjPOF-Gg>
    <xmx:j7azaVHQwof_KI37fTC2yRlCawNstHOFkgESd-yAufrAmNy1SU3cjA>
    <xmx:j7azacl8lRyzY_bhwyp-vSPnNpb9v0qqXJ5KIKP6j2tyqP7ajuX0PQ>
    <xmx:j7azaZaTUrxE7v9PItP9jJ205PQ5FDhFv_4tv8hmKSM_Z9kN4EiqSA>
    <xmx:j7azafrgN5_tWCwy4UgYuC9i5G43ykmpDiWptw7yDQn7eyKDXK-Og1GI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Mar 2026 03:02:38 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c501d435 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 13 Mar 2026 07:02:36 +0000 (UTC)
Date: Fri, 13 Mar 2026 08:02:33 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Tian Yuchen <cat@malon.dev>
Cc: git@vger.kernel.org, gitster@pobox.com, karthik.188@gmail.com,
	phillip.wood@dunelm.org.uk, jltobler@gmail.com
Subject: Re: [PATCH v1] builtin/mktree: remove USE_THE_REPOSITORY_VARIABLE
Message-ID: <abO2iS-7S0G-3Ftf@pks.im>
References: <20260311181704.958509-1-cat@malon.dev>
 <abJjYNq_sxeH8yLQ@pks.im>
 <af2c4ae3-c273-40ba-bbca-cbbf687b1b91@malon.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <af2c4ae3-c273-40ba-bbca-cbbf687b1b91@malon.dev>

On Fri, Mar 13, 2026 at 12:21:41AM +0800, Tian Yuchen wrote:
> > It's typically fine to just send to the mailing list, so you wouldn't
> > even Cc Junio. Sometimes it's just a matter of capacity, and it's fine
> > to eventually send a ping after a week or two have passed without any
> > feedback.
> 
> Oh, I see. I thought “repeatedly bringing up a patch no one cares about”
> would be considered kinda *impolite*. Now I understand. Thank you.

I mean if you nudge every second day that would certainly be considered
impolite. But nuding after a week or two, and then maybe nudging again
after a month is certainly fine. It just happens that patches fall
through the cracks.

These aren't strict numbers by the way, it's mostly pulled out of thin
air with some (hopefully) common sense applied to it by me.

Patrick
