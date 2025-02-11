Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC2A263F3F
	for <git@vger.kernel.org>; Tue, 11 Feb 2025 21:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739309984; cv=none; b=pOj52PMNiNEInfYyjaAww5fMthtV4KKw5SO8JoLzlVR3Z4v7iqq5+rMf8RfyRFS2cbSFbwvCCpWR404pHtfIgEcUHp84rddgT+Y7W9qleXoiCOZw5SQa7qswXXdVagsTyxZZzAV5Si7nCIW4otsuF9TDpUJwE++JaeW2KZEVS8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739309984; c=relaxed/simple;
	bh=WJwFGrs+/tVjVGUhHC6/mr8Lx7Yu5MziK1CpWWVHNYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CDJXhPnq5kCCe/4SveLf39WEvm/Ir4es259x9DiFfDlaKb5+eqkAi4k/cCVDIitiHZKbzeQsbaR3dgOTpIF6zzOs54YN/zrn6H40TR9OAANIbld1uiADk1PI2rvXREUiGboe5awWWGdK1A6EakO+2Q8H7saPqyp/pFexrUL2w1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=HeHOKxLZ; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="HeHOKxLZ"
Received: (qmail 20684 invoked by uid 109); 11 Feb 2025 21:39:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=WJwFGrs+/tVjVGUhHC6/mr8Lx7Yu5MziK1CpWWVHNYQ=; b=HeHOKxLZ1p+Wgld5LwgMN/X5Z27z5vkM+Ry++tyng9UE0T0gYk16SVUGOa22liQ6PJXDbrjj228szZiS2bNRxnDof30TtanrBvIIIjNbV7ABYQOqfGQpVB8ccyjG3SWTzULVLAP3/iSWe/6tO6manZDjqsmLsqdWZAGHpA7w9gYkHuhWL4zS2MxuTNImmGufBEc+nJH4VoiNZSw1s0iFc3OPR7rY55ZoZh2tqZnpRTBsivn7iSHuKBFtfiH9sVSRIVrzJ5jRfblR+udXeg52bxJjkYQlB/irg3q/gi98gSlThLIqKEez72JGjcdDuFPcCHIRtkQLigSbJXg3gKdPXA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 11 Feb 2025 21:39:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13088 invoked by uid 111); 11 Feb 2025 21:39:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 11 Feb 2025 16:39:42 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 11 Feb 2025 16:39:40 -0500
From: Jeff King <peff@peff.net>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: "Maloney, Bryan" <bryanhm@amazon.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"Perry, Daniel" <dtperry@amazon.com>,
	"Das, Satabdi" <dsatabdi@amazon.com>,
	"Damojipurapu, Deepika" <deedam@amazon.com>
Subject: Re: [Bug] Git ReadOnly Temp Packfile Causes "Bad file descriptor"
 And -13 Access Error With NFSv4
Message-ID: <20250211213940.GB3113114@coredump.intra.peff.net>
References: <18589D54-5E7F-434D-A890-B39102ECB293@amazon.com>
 <17DE42DF-D2A3-4E25-9198-5AF3CA516E35@amazon.com>
 <Z6p-eIxzrFepC3py@tapette.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z6p-eIxzrFepC3py@tapette.crustytoothpaste.net>

On Mon, Feb 10, 2025 at 10:32:24PM +0000, brian m. carlson wrote:

> > This is an issue for active/passive HA file servers. Since NFSv4 evaluates file permissions at the time of opening a file, this FD will always get an access denied error if a failover occurs during git clone.
> 
> I'm not sure there's even a good way to solve this problem on the Git
> side, since I suspect that if we opened the file as 0644 and then
> immediately did an fchmod to 0444, if you'd still fail here if the file
> is reopened.  Is that correct?

We could probably create and write the tempfile as 0644, and then switch
it to 0444 before renaming it into place. We already do something
similar with adjust_shared_perm(), I think.

I don't know if it's worth doing it that way or not. It should just work
even on systems that are happy with the current code, so I think the
only downside would be a few extra lines of code and an extra chmod()
syscall.

-Peff
