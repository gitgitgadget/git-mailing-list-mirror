Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28E31FBCAA
	for <git@vger.kernel.org>; Tue, 14 Jan 2025 19:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736883275; cv=none; b=tRLNydgF5fQ6Du5ugUSWr/icQ7zfmi8ixUvpgbOAi1+PNcxTmPgczEboxb41n55Nq7ZLuVi79zbcNFW1mUXSvjpBjnyS4J9viFlsOybVW4vd2MYdI0/PP75JuD7r/R+6GWA/Ok19R1xuTizJLZ77ZocWNtc0UjdX5NFE77s6nDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736883275; c=relaxed/simple;
	bh=mwCcenjG1X0j1ftUqJnUzcMJeAYUUdtHGWW/jOhtvY4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=f6ft/xGwMWeu08Erf0TahMl+5nFheq24ErfRLBTbGvGn2P2E6/6ZgmNzx0S9Sw/lFh+fcCa3T2qTxZKc/fBMPwxEbjrT6Y0V0o7+PulzMPCiwWJx3sNKbtdUIDqZcmyoBa5LoWI7UxCN3s4KNFQ7vIbg5vI3wJtkDANSSvE/Fvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=H6AMbB8g; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m1moqde9; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="H6AMbB8g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m1moqde9"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E917E1140219;
	Tue, 14 Jan 2025 14:34:32 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Tue, 14 Jan 2025 14:34:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736883272; x=1736969672; bh=1QX+b9mSK5
	GIz/r0hHmrb23mO6XkuL1glDFds4ohnqs=; b=H6AMbB8g58mG4mwPjV44cX/qJI
	zNTtU9PlBe2jtOe29OLtPwZc8qmmR5oiHg1mNs5KjmUTzb/CfW8ONm21NgQZmOcj
	cfWCWtqoFywJomvsd4RjA3vRFxc4EP1Y8xiV/NQ2lZeOwpdmHy0GrtCwbZcuDgGk
	v1r7ngJmX2O+o/R9cbMXebcZUwrk8gUtqvN7R/myqWB174OPfxJIfrSHKu9zFikM
	67r7/pz6pAkYmmlnRDu5wy705xFMkAq5RBqRM1tJvj8HzH2qPv7i6oGiVbrMEt69
	uBrF8o6PURn6ctBVDOvX4Yo6cxOpbwo17eJhR8wQaEvE9xtEzyzDX4slMAkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736883272; x=1736969672; bh=1QX+b9mSK5GIz/r0hHmrb23mO6XkuL1glDF
	ds4ohnqs=; b=m1moqde9B/PfPwfkDxsrYNzyoQ5hiEUBc7PlWOwZWA70eguCOsB
	7H/DGIY5rjMVcYagY+m/EMymgjO0CpvpSYXKV8v0eTvXc+sUyCwY3CPjB6psdFC4
	AldThuiCIJR0i5Wn6w8n5pOl75/VhjN/P6vFPZAptsiDCYXEEKNcv93HBvnWnVbu
	nUnj2oMLV0ZA6sgzv21mkklqrv+j8U/1sn1zDbdyvlf78/eHVEJfQNsiCq0b51AF
	QUYVbzUBjyQr5NYypMxbAghQkrVgn5zT6WZLM2t6WlvqLsThZhTG3D4yyc04+yJH
	FTE+vGfotwEovT3N2AJD8fUATH7S7WjOgjA==
X-ME-Sender: <xms:SLyGZ2UojGfBL0eJum8lPgxSvK-9UqGbI-D4e3nJK5fkEMElyRcDAA>
    <xme:SLyGZykNCh7OJaJEsqVNYsW5g983AGHLHencc6sq8b1jl5OZxOJnwZOI_5X-pL9DB
    1lf9UUQUzFegDuJwQ>
X-ME-Received: <xmr:SLyGZ6bIRnnbst0QinrjYKoUkPAVI5QB5Mlku18CqEpQiXQ20ypk0L6m8N1LcUzW0stVIfLYxg46peTUVTfBoox95OnLRL_3kITf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehiedguddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeettddtveffueeiieelffeftdeigfefkeev
    teevveeutdelhfdtudfgledtjeeludenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhs
    thgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:SLyGZ9X-U22xN-lzcWD-stlaQeCw2L8mh2ZR-Fe740bX_4dYpSLYyA>
    <xmx:SLyGZwmjVuJyHKMSwRxhgQCzKwMW27sFusREZcTJU4o3yohC3uJkqA>
    <xmx:SLyGZycdkNBB4wjRvOyfT6N-v6iEi63A9Aes_ipbCxAdRGM6BlWWEA>
    <xmx:SLyGZyEFH2zM5LG_ZYTaMm2g2QEH6sVpfkc5RQx8YkdWxmwna4JAQw>
    <xmx:SLyGZxC35cUhxZ8ErmrOVSICGx0-H6WZuEWv-3P-GNICB7ZBNXZEZDOQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Jan 2025 14:34:32 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 00/10] compat/zlib: allow use of zlib-ng as backend
In-Reply-To: <20250114-b4-pks-compat-drop-uncompress2-v2-0-614a2158e34e@pks.im>
	(Patrick Steinhardt's message of "Tue, 14 Jan 2025 12:57:41 +0100")
References: <20250110-b4-pks-compat-drop-uncompress2-v1-0-965d0022a74d@pks.im>
	<20250114-b4-pks-compat-drop-uncompress2-v2-0-614a2158e34e@pks.im>
Date: Tue, 14 Jan 2025 11:34:31 -0800
Message-ID: <xmqqjzax2nqw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Changes in v2:
>   - Wire up zlib-ng in our Makefile.
>   - Exercise zlib-ng via CI by adapting our "linux-musl" job to use
>     Meson and installing zlib-ng.
>   - Link to v1: https://lore.kernel.org/r/20250110-b4-pks-compat-drop-uncompress2-v1-0-965d0022a74d@pks.im
>
> The series is built on top of fbe8d3079d (Git 2.48, 2025-01-10) with
> ps/meson-weak-sha1-build at 6a0ee54f9a (meson: provide a summary of
> configured backends, 2024-12-30) merged into it.

I think you are now also textually depending on the fuzzer thing due
to touching meson_options.txt and ci/run-build-and-tests.sh with a
later step.

>  -:  ---------- >  9:  7ae8f413d4 ci: switch linux-musl to use Meson
>  -:  ---------- > 10:  2dd1b49e4f ci: make "linux-musl" job use zlib-ng

I will see what other things I can find.

Thanks.
