Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFF017A309
	for <git@vger.kernel.org>; Sun, 14 Dec 2025 19:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765742070; cv=none; b=joJ1/GGf0AiKLdI3on0KxxCr+9mlAQ65pQBStJbaORVreOOQpOsgBuu63RGCUlKEADDbJsS0NMpu7vxP6qRDPCc7GDmm+rfxGiA3DStpmuueKggxnhiBo9rwIVKn2+pd7v7ajci19+CNm7jh9f11LkvnbJW9jhnACZwlGwReKbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765742070; c=relaxed/simple;
	bh=b7ng+NC2J8gD287x+z6imrtBc8crXEzy06hKfxtO19I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ROx2zgXy8rnsCbASnlHjf/fjsbKFpouLyzwstCNROK9TQl3+T6rg6/oA8v3eSPZcoA0ny5P35w/ap+T+YPDJTl2JekH8ejNEe41lM/vhWmSNWq/kTbi1VKIdQVG1KUe4bSZour/h8ZtMDWuQwmk37D9C2bG5VxSSLHWDuSQrksg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=hehDLu1z; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="hehDLu1z"
Received: (qmail 356396 invoked by uid 109); 14 Dec 2025 19:54:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=b7ng+NC2J8gD287x+z6imrtBc8crXEzy06hKfxtO19I=; b=hehDLu1zXAXMApP2Hy8cx3j4kVumDoBpjOPPPcIKrvrDAXf3q99zZBp0oQlUZGLLp/EpL155/EY+ELidj2tI8OnmiYcmr3L1DIQWX3OdAIbSa3ynAJoKkJ7yRp2IoVI3TpvZ4uGtSeaqtKL5GEqLCOM7kGl+7qi9vyBn33D4W6LCyNhu9tjbYhSMfgSACUQhUJ+Biup1Sa5rnsCGxMUOq5ADGkYX/teKcQeK3TU0kZqgjzxPelTq3QE9ji3ayg1tiIb6u5SPE78XCt3pxI5Rs2kxEsrcWQvCw9MzkgxcG7Pxzfn3qspyHn5xrEk1cN/87qqU31zlnl6BnwR6G8uOcw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 14 Dec 2025 19:54:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 474269 invoked by uid 111); 14 Dec 2025 19:54:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 14 Dec 2025 14:54:22 -0500
Authentication-Results: peff.net; auth=none
Date: Sun, 14 Dec 2025 14:54:20 -0500
From: Jeff King <peff@peff.net>
To: jim.cromie@gmail.com
Cc: Jason Baron <jbaron@akamai.com>, git@vger.kernel.org,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	gregkh@linuxfoundation.org, ukaszb@chromium.org,
	louis.chauvet@bootlin.com
Subject: Re: [PATCH v6 00/31] drm/dyndbg: Fix dynamic debug classmap
 regression
Message-ID: <20251214195420.GA791422@coredump.intra.peff.net>
References: <20251118201842.1447666-1-jim.cromie@gmail.com>
 <76038c97-39ca-4672-adc0-4e8fe0e39fc8@akamai.com>
 <CAJfuBxxFWD0rEjm-va+Bjmf-m2nfOD_+ZEqKy22WX6QdugQCUw@mail.gmail.com>
 <5b3d492c-7037-45a5-a001-0064f14d5f81@akamai.com>
 <CAJfuBxzW6TMmdS74ZPfPSe1w6S=oO17WYZc-Jgn_et=-Muw05A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJfuBxzW6TMmdS74ZPfPSe1w6S=oO17WYZc-Jgn_et=-Muw05A@mail.gmail.com>

On Mon, Dec 15, 2025 at 07:24:34AM +1300, jim.cromie@gmail.com wrote:

> for some reason I cannot grasp,
> git am fails to process this mbox.
> 
> It entirely misses 13/31,
> then fails to apply 14, which needs 13

Can you show the exact input you fed to git-am?

Everything applied fine for me using this workflow:

  - grab the thread mbox from
    https://lore.kernel.org/dri-devel/CAJfuBxzW6TMmdS74ZPfPSe1w6S=oO17WYZc-Jgn_et=-Muw05A@mail.gmail.com/t.mbox.gz

  - view that mbox in mutt, tagging all of the 31 messages and then
    copying them into their own mbox 

  - git checkout v6.18 && git am <patches.mbox

-Peff
