Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C7C2111
	for <git@vger.kernel.org>; Sat, 28 Dec 2024 19:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735415029; cv=none; b=Va984UhXDBkvOOxOovsUNHTUYe7Kgzp8fecU4xm1Z967IZkgDtv37EPvpvERVEGSLcBQrCCWHF+Qh0QSEvZs5dpaSYuN9yCK5xx2jOE/gvBE5GErU0Q7QxnnxqhwXJPRqz1oldCB+FaqwltERbl8Qerb9UEo3CvCLBvNvhPnNIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735415029; c=relaxed/simple;
	bh=PJOx3cj2FHhUY4wrjEsKpQKZlrUNjUJMjYMI55B+ACk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CJEgr9jYDrqj7L8WsSD/gNjwjdXBpN73HT1rOOssAaq+uH24PrY3P6jD5R765AjzV/M75EW9j8EpvvbmiIpC1ILQKloCKwdkP+tM79voLkeJ3JJXgtUhkIKr+zydNiCegikfEuiTDZWMhKzk8ls/nVORDuCO7TsQTJcM6lnCE2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Xk69OHho; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Xk69OHho"
Received: (qmail 24834 invoked by uid 109); 28 Dec 2024 19:43:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=PJOx3cj2FHhUY4wrjEsKpQKZlrUNjUJMjYMI55B+ACk=; b=Xk69OHhoNK4AHsO7RKrQYkP986OAVUa836e8o+vIhd3Nr8ixI1j9zvTu5Y9Mz1qHfykzP/UoNtdSgeXXfY76QHIhImSG44QcJH2BxKvC2xFM1TLcGfM7qD/n3YMkmY1nTlpfdtZBdaeURQSlaRCCc7g2uueibHbfyvtEDicwgvLBZiwonzBgUGEdIMY6ifKlmTtn2rjqlemhk0P+HpaP+e8f96Ks8kIO+SxVqiPaX63fDxUGblP2cSzeBF2S745EHsYbmLwaGoN7Y27omlgtAeVbup3qllPTrBYP0DCx3ygyDrqe+sSssnfJcQOfzCrd0Pu14RkEk0fGQn52MOxcow==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 28 Dec 2024 19:43:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30281 invoked by uid 111); 28 Dec 2024 19:43:45 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 28 Dec 2024 14:43:45 -0500
Authentication-Results: peff.net; auth=none
Date: Sat, 28 Dec 2024 14:43:45 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>
Subject: Re: [PATCH v2 4/5] Makefile: respect build info declared in
 "config.mak"
Message-ID: <20241228194345.GA1535629@coredump.intra.peff.net>
References: <20241220-b4-pks-git-version-via-environment-v2-0-f1457a5e8c38@pks.im>
 <20241220-b4-pks-git-version-via-environment-v2-4-f1457a5e8c38@pks.im>
 <20241220155433.GC152570@coredump.intra.peff.net>
 <Z2WfirfrpYYFgYdw@pks.im>
 <20241220175136.GA203033@coredump.intra.peff.net>
 <Z2WxIRcV0LOvx6OX@pks.im>
 <20241220182427.GA213015@coredump.intra.peff.net>
 <Z2W56ux3mLnfJ43Q@pks.im>
 <Z2XAiDC4pJ9OjTpC@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z2XAiDC4pJ9OjTpC@pks.im>

On Fri, Dec 20, 2024 at 08:07:52PM +0100, Patrick Steinhardt wrote:

> > > +# Never include it on the first read-through, only after make has tried to
> > > +# refresh includes. We do not want the old values to pollute our new run of the
> > > +# rule above.
> > > +ifdef MAKE_RESTARTS
> > >  -include GIT-VERSION-FILE
> > > +endif
> [...]
> Okay, I did find an issue where it does not work:
> 
>     $ git clean -dfx
>     $ make GIT-USER-AGENT
>     $ cat GIT-USER-AGENT
>     git/
>     $ cat GIT-VERSION-FILE
>     cat: GIT-VERSION-FILE: No such file or directory
> 
> It does not generate the version file at all anymore when it's not an
> explicit dependency. While I could of course add the missing dependency
> I don't know whether there are any other implicit dependencies that
> would be broken, as well. My gut feeling says "probably".

Doh, of course. We really want to say "do include this and consider it a
dependency, but don't read it yet". But I don't think there's a way to
tell make to do that.

I looked over your alternative approach with the OVERRIDE variable. I
can't think of any downsides, aside from the general head-spinning
complexity. ;) So that seems like a good approach for now (and I see
it's already in master. Yay).

-Peff
