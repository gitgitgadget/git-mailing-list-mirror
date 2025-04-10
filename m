Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDFC1EBA03
	for <git@vger.kernel.org>; Thu, 10 Apr 2025 22:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744324947; cv=none; b=A2yo8q+nxZHMKISWn8SiGC8ENVg2AceSxnXkG1I8SXV1ajWQ2Amse2q3B1MuGJtmJcvIDjJ+G+nfBuxIh2gXQGpL6k/iKBv+2CEnKY1nYH+AfK7/v6y28FkuYfFoBL/jgNOAuOL6Gjn8Jok0lxjdTuDj4hmiE6Vbypx2F3POxZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744324947; c=relaxed/simple;
	bh=G8GAqYJMe5hbJntR75Wvoi6ABPExxytsDqcv8ALhXgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lua4HWZDkZGO3xqJsYdRb2a9msA5q981KyJNVq6RcD5sJhnF5cRLAGl8USuu8NiHgm+qg+f3ZLGdKBn6gLh84qeOwk42Gws/7My/jTe/LdeqR0gNOHW6FYej1oUpjXe8iu2+cBFLaZgiejZ4U7/uhXcl/pY4WRAN/jSQGwnGiMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=eb9EZ1ZD; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="eb9EZ1ZD"
Received: (qmail 30488 invoked by uid 109); 10 Apr 2025 22:42:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=G8GAqYJMe5hbJntR75Wvoi6ABPExxytsDqcv8ALhXgs=; b=eb9EZ1ZD1d+rO8a13+qBhmL3hZHxLnsODPILPREPznWN0jnizF+mD9t2RGLmO9EMuA8wqm/VzxAa039wP16JVygFjLh3oN6+9U3p4m0W3MuzPBsV6TT7GkqjfQeW3w5A7NT6igFovevVumELyv9R331PCRZxHtugIDUPlXoi+PHUF4O12A0x5XLcxC/5BgMqSJtcaSlaqTeK+e1nIzuC3+pQMo6ofYNa7Qp26XAmvo0AA4cr3jV7duUITF0kcYMUp5WiZ2LAYwxmFInr76bvLQEa+kEAV5rEx1CjY9At6s/Ob/j+O8D5GAn4vnKNz0RWNFJ1l5ZqPOaWk4Wn81EVyA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 10 Apr 2025 22:42:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18093 invoked by uid 111); 10 Apr 2025 22:42:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 10 Apr 2025 18:42:23 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 10 Apr 2025 18:42:23 -0400
From: Jeff King <peff@peff.net>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Nikolaus Rath <nikolaus@quadrature.ai>, git@vger.kernel.org
Subject: Re: 'safe.directory' setting ignored for some operations?
Message-ID: <20250410224223.GA3191424@coredump.intra.peff.net>
References: <CAPzgaL2Q4v0LMSek=osugTDCDww9D-Tg+tDsFhFvRSVXFR8g6Q@mail.gmail.com>
 <CAPzgaL1NH_GofMko6f2Auz4e1TjTJNH0w4-ph8np04QRfT_R7A@mail.gmail.com>
 <20250410213542.GA3168175@coredump.intra.peff.net>
 <Z_hCjfoRUIDZoBfP@tapette.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z_hCjfoRUIDZoBfP@tapette.crustytoothpaste.net>

On Thu, Apr 10, 2025 at 10:13:33PM +0000, brian m. carlson wrote:

> On 2025-04-10 at 21:35:42, Jeff King wrote:
> > So I think things are working as intended. You can get around it with
> > either of these:
> > 
> >   - set the config in your user ~/.gitconfig, which will be read by the
> >     child upload-pack command
> > 
> >   - tell clone to pass the config to upload-pack, like:
> > 
> >      git clone -u 'git -c safe.directory="*" upload-pack' ...
> 
> I think you can also use `git clone --no-local` in a more recent version
> and the normal clone-from-untrusted-repository semantics will kick in
> and things will work.

Yeah, that's true in v2.48.0 and later. (I tried it after writing the
earlier email and was a little puzzled that it works with --no-local but
not otherwise, but it sounds like that's known).

-Peff
