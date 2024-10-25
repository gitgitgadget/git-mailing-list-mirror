Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D1213049E
	for <git@vger.kernel.org>; Fri, 25 Oct 2024 06:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729837490; cv=none; b=OL9/Cs1o0QYZHa1RYB7TDbQbGiMTWtij3oi2yeNfpyeqq9d5A6OaW/aoYYtDIRguPDpVPzQFVavhbwl13HnQb/4+t8Hs/gbxlptVAi3AzXUz8d9ji3zAxF+3U9SWRgeVVLZh5dXIlAys4d/TInhaBVY46BcBlEOb4VfPcxnnw44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729837490; c=relaxed/simple;
	bh=Ja26NbBNm57jXD3e0kAAkD2aq0HgqxJkFbnhoVOMcY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mwb+yG+7FvPD64ThSA2+3+GPwU89FBkr05BFbhgNT7uROWQCGX5PXkZFHXprckDeBK6KG2auKwlExrfZGcLKUNo8hlSKOgAi5TObdrD0pzQXyMFN2inDK4H0QNV1ZsXZTLmNEMbFUJRCwGvuQa15IzT7wk4w6JXrAlfI2sBQC4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=eF3UMvPW; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="eF3UMvPW"
Received: (qmail 32695 invoked by uid 109); 25 Oct 2024 06:24:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Ja26NbBNm57jXD3e0kAAkD2aq0HgqxJkFbnhoVOMcY0=; b=eF3UMvPWouAb8iDxR0jWdlcdMRfCvN/Kz+zjg0qfgk6c4v4OEiOnpmqnoaXnYS4lKO4u4RH/wI0OyAdUioz8C1dhbbumqqocJuluUujjmAx7NkDzi/26MbEb6vne9eB7Gth9aFUrw/JGeF+Q9zUqSp+XTBEASODGh2hYSen74tbQHPgRwZdJeKNlUd8F2l1hv5LYWwNcfXNJ62ZLdMUzjhjaXihJtz4lxnj0XenR8zeRH7mIGX1JOqlooBqS5gV9os5HukV8j55UGa+m+uKQy6JBUIa88LSVDMzVgACNsXWfny2V50j6bAE9TLCrbNWmGahSYB9EjJexHzmPtOeJ7w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 25 Oct 2024 06:24:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12509 invoked by uid 111); 25 Oct 2024 06:24:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 25 Oct 2024 02:24:39 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 25 Oct 2024 02:24:38 -0400
From: Jeff King <peff@peff.net>
To: Bence Ferdinandy <bence@ferdinandy.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	git@vger.kernel.org
Subject: Re: [RFC PATCH] object-name: add @{upstreamhead} shorthand
Message-ID: <20241025062438.GA2107756@coredump.intra.peff.net>
References: <20241020202507.2596990-1-bence@ferdinandy.com>
 <1c056d39-950c-4965-89d6-85f0c2c1bccd@app.fastmail.com>
 <D50YLOBHJTLS.367TMAOLKL019@ferdinandy.com>
 <20241021191441.GD1219228@coredump.intra.peff.net>
 <D51R90BTHJMY.1C1XY5P4CHTWG@ferdinandy.com>
 <20241023215618.GA821188@coredump.intra.peff.net>
 <D549EIKDKGDS.2AETZLT4RTB44@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <D549EIKDKGDS.2AETZLT4RTB44@ferdinandy.com>

On Thu, Oct 24, 2024 at 08:48:29PM +0200, Bence Ferdinandy wrote:

> > So I think rather than "branch --show-current-remote", we'd want
> > some option to make "branch --list" show only the currently checked out
> > branch, and then you could apply --format to it to get whatever
> > information you wanted. Something like:
> >
> >   git branch --list --is-head --format='%(upstream:remotename)'
> 
> Thanks for running through this in such detail! This would be more widely
> useful for sure. 
> 
> I'd probably call the flag something like "--current", "--current-only" rather
> than "--is-head" though. "--is-head" sounds as if it would filter --list but
> not necessarily end up with a single entry.

Yeah, I think --current would be fine.

-Peff
