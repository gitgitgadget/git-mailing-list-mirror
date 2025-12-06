Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A241423BF9F
	for <git@vger.kernel.org>; Sat,  6 Dec 2025 02:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764987085; cv=none; b=rUvoDiu3TwMJSGultFpGmthp2dawCWWKycO+cOqAs2eJqbxJhGNotMuI7jUNFkg+C+jG8rbxR4xEPFyJPmPSTCwX9NCyMG+PQiz+cFbfJz7/xnZaB6l01gzv8ROzxlcVKbVB9cp3Wr1MGUAjhDbdbXRvkp4B+tNioPXnw66xQgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764987085; c=relaxed/simple;
	bh=VHNjAiy3RfqEztKwlXqcOc7MRWS1OGdvaGOY0euczjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nh0ofiz4jWTMt5EKJkHw+YkNlvzPyRqYYso3pV8sQmYyqqpvTDHuTCkBW5RsgpeBY6T+J59mPqiG2+WE5wGmxHsb7Clq98eOXJhwT6FzwXFVtG036qHayNXYOhCjkwTAsdps0qBJ2U4gjvlJc8QiBI2myT0WRN/7wbFHi5EQdLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=eb/ARJ2M; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="eb/ARJ2M"
Received: (qmail 274380 invoked by uid 109); 6 Dec 2025 02:11:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=VHNjAiy3RfqEztKwlXqcOc7MRWS1OGdvaGOY0euczjo=; b=eb/ARJ2MgS8xZgxD92XldJlRXpbnQgEOj8ZJO/41EHWAAUxWEmr6e7EXwxB/EoptiP1x2LwS3wXvXWOHNH1de4JvnO+PoBBq0+oFMgDJFte5pEE+nCz+DG/3cS6u9M8GySj113Cc57l5sJbKHLX68WnmcrRg08qCYZsgMCrUitE5YUDdCyvrYoCnyKLaI8U5lZcW8HmCp0osj3i93y5RwQLnQ+hTs9ztVPVJuI7oOeUCMguVi/cqTIQ/pnlJG2WZN6CKz59TipVbPSP27ZdmK1F3il/jDc+2piuyhIZ/KMvSHfAThLlGWNtNIfLMKY4NifD/qEdYAn7e96VRD1sA6A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 06 Dec 2025 02:11:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 345690 invoked by uid 111); 6 Dec 2025 02:11:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 05 Dec 2025 21:11:25 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 5 Dec 2025 21:11:22 -0500
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH 2/4] compat: use git_mkdtemp()
Message-ID: <20251206021122.GC1714099@coredump.intra.peff.net>
References: <784f495a-4b1a-4acf-96cd-599243ef9e27@web.de>
 <4c70b527-9c40-4396-8c8c-95177c5d92f0@web.de>
 <20251203161154.GA44940@coredump.intra.peff.net>
 <aebd0ffe-7914-4731-8f79-830bd3b5a147@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aebd0ffe-7914-4731-8f79-830bd3b5a147@web.de>

On Fri, Dec 05, 2025 at 01:11:40PM +0100, René Scharfe wrote:

> > This one is a conditionally-compiled wrapper for NO_MKDTEMP. But since
> > we always have git_mkdtemp() available (as of your first patch), can't
> > we just point at it directly with the macro?
> 
> A worthwhile cleanup if we stop at this point, but complicated by
> targeting three build systems, the CMake build being broken on macOS and
> me only knowing how to fake NO_MKDEMP for make, leaving half the build
> space untestable for me.
> [...]
> At the very least this cleanup should be done in a separated patch, as
> it's harder than it looks.

OK, I am convinced that it is not entirely trivial and can go in a
separate patch. :) Mostly I was surprised that you would not have
followed through on an obvious cleanup opportunity.  It just turned out
harder than I expected.

> Right.  Dropping this dependency and then deep cleaning the compat code
> is attractive and mostly sidesteps the build system complications.
> That's for a later series.

Yup. Sounds reasonable.

> Ultimately you'd prefer banning mkdtemp(3) instead of automatically
> redirecting to git_mkdtemp(), though, no?

I'm OK either way. Whatever we end up doing for mkstemp(), I think we
should match here.

I do like being explicit that we are using our own wrapper and not the
system function. But I wonder if it might make complications in
third-party code like clar, which calls mkdtemp(). If we don't have a
compat macro we'll have to patch the sources that we import into
t/unit-tests/clar.

So maybe that is an argument that we should leave the "#define mkdtemp"
in place.

-Peff
