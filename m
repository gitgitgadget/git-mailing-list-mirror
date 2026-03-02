Received: from newcloud.peff.net (unknown [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450DC31716B
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 18:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772476121; cv=none; b=Jr+iWS65sLcJ1Ydv/6sCcY9LXQQ6mr8Sw4wWNfF5jqLuc21auWsychjjOqEshPRc9CldtJuH2BHNc5nSRByL2GdOW9vqaz0h9V5i3DQsRZzJCwqInBtsluMYMJ3eDL19HsoIcPRuSnuPLSsRhFVHaf218lgg2EIy4McxPcLUaxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772476121; c=relaxed/simple;
	bh=IE5ntA6C/KwGqtwtqNWrZ2tD3mFUVv9HlJmxfQbXuYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sPxxQVrbOi4xIJmXptUnkv2XQKvGgodUs9gL8X3lq+7Pi6KJFXyKyaeQTmiDKrn5fQbLl8Lfsm35/x9K4QQVCzmMu1Rz26uf086Y+2XC0KBnVvaMa751j8a2qiKHcnBc329Zy++SyxzufzKPbGLzKY8JRdQeSKXL69k4EL9XrR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=aDPQwyTR; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="aDPQwyTR"
Received: (qmail 29959 invoked by uid 106); 2 Mar 2026 18:28:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=IE5ntA6C/KwGqtwtqNWrZ2tD3mFUVv9HlJmxfQbXuYU=; b=aDPQwyTRYY4vUDYXfVYwRZjpoOajDFuuFHBxpoMxurteVtJSYdpJ4Y43FVL/IeAn7KboBnt9MmAkZZoqgxbhwJ2aqKvnidCwDxxe0SpvcyWU3K0K1giMs2qxg5VieAgkVuhKPA+GyV1aO8EvBGh3blM1flCY9FjfaYpDZq+2box02vmlU3gbbnVRSGkkuZY0a/3GxwQZxoSVYT7l2uwj+cZ9pdvMFUlb5kLnsoBZP/xFAJiu7/eMW/gwJHLdC2qsVYyqjM0NqGDCyWSxITasELnrF1i0C26jvkCUC2c3Bc25fZuxp5UQx5KVZbxr760AWLH2FjA2jk7KOVQ2cRzZ/A==
Received: from Unknown (HELO peff.net) (10.0.2.2)
 by newcloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 02 Mar 2026 18:28:39 +0000
Authentication-Results: newcloud.peff.net; auth=none
Received: (qmail 334283 invoked by uid 111); 2 Mar 2026 18:28:40 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 02 Mar 2026 13:28:40 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 2 Mar 2026 13:28:38 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Alan Braithwaite via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, christian.couder@gmail.com,
	jonathantanmy@google.com, me@ttaylorr.com, gitster@pobox.com,
	Alan Braithwaite <alan@braithwaite.dev>
Subject: Re: [PATCH] fetch, clone: add fetch.blobSizeLimit config
Message-ID: <20260302182838.GI28275@coredump.intra.peff.net>
References: <pull.2058.git.1772383499900.gitgitgadget@gmail.com>
 <aaV6PLJCrpb2mQnq@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aaV6PLJCrpb2mQnq@pks.im>

On Mon, Mar 02, 2026 at 12:53:32PM +0100, Patrick Steinhardt wrote:

> On Sun, Mar 01, 2026 at 04:44:59PM +0000, Alan Braithwaite via GitGitGadget wrote:
> > From: Alan Braithwaite <alan@braithwaite.dev>
> > 
> > External tools like git-lfs and git-fat use the filter clean/smudge
> > mechanism to manage large binary objects, but this requires pointer
> > files, a separate storage backend, and careful coordination. Git's
> > partial clone infrastructure provides a more native approach: large
> > blobs can be excluded at the protocol level during fetch and lazily
> > retrieved on demand. However, enabling this requires passing
> > `--filter=blob:limit=<size>` on every clone, which is not
> > discoverable and cannot be set as a global default.
> 
> I'm not sure that we should make blob size limiting the default. The
> problem with specifying a limit is that this is comparatively expensive
> to compute on the server side: we have to look up each blob so that we
> can determine its size. Unfortunately, such requests cannot (currently)
> be optimized via for example bitmaps, or any other cache that we have.

We actually can do blob:limit filters with bitmaps. See 84243da129
(pack-bitmap: implement BLOB_LIMIT filtering, 2020-02-14). It's more
expensive than blob:none, but not much. Once we have the list of blobs
we can get their sizes directly from the packfile. It's stuff like
path-limiting that is truly expensive, because it requires a traversal.

All that said, I'd be wary of turning on partial clones like this by
default. I feel like there are still a lot of performance gotchas
lurking (and possibly some correctness ones, too).

-Peff
