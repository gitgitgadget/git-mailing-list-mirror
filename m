Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD69292B50
	for <git@vger.kernel.org>; Wed,  6 Aug 2025 15:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754494709; cv=none; b=oXQpV5sRwgi6zgz0cgO5waC1X1jzIItrhMo4ezPnOKcLV6pt1yiuT2NIl5KCVhj+m/xkNU1HkYdjSdRIm1vctyKEqrIOoACNYxzQYGdPL3h9h7UyH78eOFPixQi7m5GhVhgeGgioemM5M4ciOsQc87CVHFhOlE4cmWrzC/zk0dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754494709; c=relaxed/simple;
	bh=QVn/olfx21y/lxgGxuKDF6W4RyRDm43oOwoVu+EiFBg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=q/ua2/SMXIX+77Buk3OJ0cbRmcBnUO3epAObbiwUflDSI1GfX7Ld5fmlZnQebRnJCgL6WaO1OSffVgGmeBhAhC5Y2nC1fsKk5HAJ3vHFERGQlogklbaoQ6PgOYxdl3aFNOVkpOjwyerDwFCBOxkDNqU+XwVYo9Y3Pe8iBSWZgRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Y/XmJqZ4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jjnIuR5c; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Y/XmJqZ4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jjnIuR5c"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 90EBA7A011F;
	Wed,  6 Aug 2025 11:38:26 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 06 Aug 2025 11:38:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754494706; x=1754581106; bh=BAcKsQl2wm
	zd07xUSi7JPnpFkr3bAsBFPY3eqXVvfUE=; b=Y/XmJqZ4xtyHHOjinzHICZobZe
	zai2KK80nbhFfYLSBZOpS8xyCzg3GmThunhgMxHP/Q94Yzn0L7fo6mZYZiswmXAt
	61UJFMmzAflgTTCj7Xm9IFC9ATJtmwbQAy632F8qtUuPmEeWk8EXoU86+TluX7m4
	XtptrtejKETWIF0vVhx4esrO+wnTMgQ+3EvJw1D3ji28pkeU72MncQEdidMF6ACe
	4nLpZT+5P9WP7J4skIXNFYZ9pDj4fhX5HZvJd775o/uUorvyTWCB6TsD0LRYQvnA
	YQcNt0+tdFckjYciivrEDh7PDFvjge2mE0ipz+Q7ODDfFk9TjUME5tmN1ehw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754494706; x=1754581106; bh=BAcKsQl2wmzd07xUSi7JPnpFkr3bAsBFPY3
	eqXVvfUE=; b=jjnIuR5cW2b7WwCkjjYkvCk0+uFifU06X3qKWmOrr2VJ8F5vGyF
	fLsZ7VH44MbkGNO5GK7CBSeShXhmGpQbZbNP1eQMYWicmloabGkOvwz/rysqGNnb
	wVY0kUoE1I8yPvAa33xrQzjI4bvwUZrmewfqH2xnuvK/xeoL3dMrXbjnMPro6wbH
	Pv5+54bo2WJU8qsGbW364IBGatpaYnpWL/jomV3w0QFirFVxU/1cdqsqvTN1BhJA
	SZuLzgX4SWmgyq0S0RjuXe2vf7SeKd/NJb6dxRDNaIIZAacQS2zgGsIjE7/mxbzP
	p78IHNlFS4ic537BWN6MS5HV93firUl0BQg==
X-ME-Sender: <xms:8XaTaKdrlTAF7i_0c5QexyAWqCedfIA849T6xGaHnh4XrsoXXd-7fA>
    <xme:8XaTaOztNGzdO4RHrjBjDvqw7hZnVTNXTivtrQpOvH4fT-SxeZDglEW3CRpGAbGNY
    K_k4rmmT6hRNbooag>
X-ME-Received: <xmr:8XaTaIFj-3ZI_MMYoRQiFZbIE8ImVBm7_R3Ftwj1Gj7QgFoPVTA8X5gMladnuZYOX5RiFV8Bx355MlSCIB7M8idKmQC5UArbwuHUzw0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudekgeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeeivddugeffgfffffevvedvieel
    ffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtoh
    epjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:8XaTaKx5nMqKLJDxoZOXyHAi-9wtWKdEaszPpYSMesUDKHHyH2Ffsg>
    <xmx:8XaTaBukFntzIIpKiQH2kyH7cLMmICkbvpv5v0pP3ucpb0reWvIXAw>
    <xmx:8XaTaP004_rmzUKHDjjoUs-quHBxWyhC7yvHVYtOfuJJYIfxSZfydw>
    <xmx:8XaTaE_EwU489t0zHi0SPa90gIkLndUK1EnVQCs66Ad5jm1QWRWWGg>
    <xmx:8naTaFY62xaVF7cP4GisuA-ROZKbMHekwfqse5fMjxivrOgDjpu11tLT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Aug 2025 11:38:25 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
  git@vger.kernel.org
Subject: Re: [PATCH v7 0/3] Introduce git-last-modified(1) command
In-Reply-To: <87qzxou0an.fsf@iotcl.com> (Toon Claes's message of "Wed, 06 Aug
	2025 14:01:04 +0200")
References: <20250730175510.987383-1-toon@iotcl.com>
	<xmqqjz3h20cs.fsf@gitster.g> <87tt2lu2rx.fsf@iotcl.com>
	<1929210.tdWV9SEqCh@cayenne> <xmqqwm7hxx0a.fsf@gitster.g>
	<87qzxou0an.fsf@iotcl.com>
Date: Wed, 06 Aug 2025 08:38:24 -0700
Message-ID: <xmqqectowjdb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

> Looks good to me. Do you want me to reroll, or will you `--autosquash`
> yourself? 

I can do the latter, unless there are other reasons that make it
necessary to update the patches.  We'll see.

Thanks.
