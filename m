Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6C12E22A0
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 17:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755625544; cv=none; b=XBmBVxY2sQSKyz30c4XVoMI2ChKplKCMULdQs1hdKzVx2eQavBPoDpoaKiuqpuaQE5gJNt+GVaOYbiRORAO8ChjGpfi8CwWZfsCYxflvMGKF07nI4+IvlCjcDZqUO9ovQxX7OyVSYH1D1JzQW2vb6TMdySmuINdq1vCSzFBWDZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755625544; c=relaxed/simple;
	bh=/NzKwlCTL7vJS7fzy9fwO3eDBT0GA6QBuGxhTHreE64=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ppI2JNxT2gb1/nOA9mwl0+8S3/wJwU2Y0++IMrfnkHFWUUYLE8QLoAbV1ccuffGcPpFAbykA6++fMXfj80LWK3X8rsaEv8O0oaJI8xC9c6YG5pKytXMxJ+yoYaRWx/k5u/mdm6RN3EgQuPg1k5PVhL9BCxyRibF2zVb6LUE/usU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=buenzli.dev; spf=pass smtp.mailfrom=buenzli.dev; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=buenzli.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buenzli.dev
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4c5xnZ6D7Lz9ssk;
	Tue, 19 Aug 2025 19:45:38 +0200 (CEST)
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of remo@buenzli.dev designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=remo@buenzli.dev
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 Aug 2025 19:45:34 +0200
Message-Id: <DC6LB8FINRXH.1TMZPB1XKPQWQ@buenzli.dev>
Cc: "Martin von Zweigbergk" <martinvonz@google.com>, "Patrick Steinhardt"
 <ps@pks.im>, "Andy Koppe" <andy.koppe@gmail.com>
Subject: Re: [PATCH v2 1/2] pretty: add X-Change-ID to mail formats
From: "Remo Senekowitsch" <remo@buenzli.dev>
To: "Drew DeVault" <drew@ddevault.org>, <git@vger.kernel.org>
References: <20250703113505.11889-1-drew@ddevault.org>
In-Reply-To: <20250703113505.11889-1-drew@ddevault.org>
X-Rspamd-Queue-Id: 4c5xnZ6D7Lz9ssk

On Thu Jul 3, 2025 at 1:29 PM CEST, Drew DeVault wrote:
> Introduce the X-Change-ID header to emails prepared by git (i.e. via
> format-patch, send-email). This allows tools which work with those
> emails (e.g. patchwork, sourcehut) to meaningfully integrate with tools
> that assign change IDs to commits.
>
> With some follow-up work, this is also the first step towards ensuring
> that those change IDs are preserved through from git-send-email to
> git-am as a change moves through its review lifecycle.

Hi Drew,

Do you intend to keep working on this by any chance? I'm writing a code
review tool that relies on Jujutsu's change-id header for its "killer
feature". It will also support different code review platforms as
backends, including GitHub, mailing lists and more. As long as mailing
lists do not preserve the change-id header though, users of them will
fundamentally have a degraded experience.

That is to say, your efforts here are much appreciated. :-)

Best,
Remo
