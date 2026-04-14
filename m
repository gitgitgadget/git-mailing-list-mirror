Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A02537E30D
	for <git@vger.kernel.org>; Tue, 14 Apr 2026 22:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776204871; cv=none; b=P0eLVjkcpgjkoBZ+ia++AoyRCkRzwaRv3z418EY3CW98GsuO7L4CaNLNuWzaU4T7w2oHNm7HLRXv2vkujOHKIVT1h23ReAY5KAPKXjJSuuUC2JF0Ak3+PwVR7322qdLnMln/dShzf83r8gNlqxh8ocf7Qor1Ok7fNTsKiclGde8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776204871; c=relaxed/simple;
	bh=mrr0x2bnSfaIWRl1YV/+Xs+aJPZZzFs8bvUcf3VAsXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JpMg/+5a9zfFlFW40V98cF6LmKZShBAQJs43jVkjTS4wUoZVzy4jbOJhvjClFNuYg89Jj4shRhBdvWTrqVv0np+hMsWZx3tANv2LSoYvKGRrwBY3YcjKfxTq6w0SpfdapZC+P3xoLcOUfnTTStbdJ0Ymu7AKbjoS5Gt5VgnCoLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=BCwmNQo/; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="BCwmNQo/"
Received: (qmail 350745 invoked by uid 106); 14 Apr 2026 22:14:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=mrr0x2bnSfaIWRl1YV/+Xs+aJPZZzFs8bvUcf3VAsXc=; b=BCwmNQo/6u+O+tj4anwK2HHXgIcLDrTrokcCig/ZfIVBtf7i7/5YLNNFndHgdg96xe4GCV3hoGLMbpVRPYa0/UYgETWJWFAEUXYiMsSHJgbZ7TnjnUO4DTFo4fs6mpbDAAEfq/LsIAjrR8bypcfLqkssAKjnB22TawYzx1/FsD8GxE2e7vO2Lji7nZU3VS9sP+JjJYa1i8YOBpmMzs4GrjgcXBXaqucYy4VkuDbhbNRxHqFjTKdQohTqpWRinkppdtRu3Tszce2qF10/YzUS4GRFUCXR3EBKZM1oWDSvLt/M63WeR8wJsGkBY4gQMjTX0zNn2UPea7ZjveuXCTfFoQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 14 Apr 2026 22:14:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 587041 invoked by uid 111); 14 Apr 2026 22:14:29 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 14 Apr 2026 18:14:29 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 14 Apr 2026 18:14:29 -0400
From: Jeff King <peff@peff.net>
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc: git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH 2/2] test-lib-functions: use BUG() in 'test_must_fail'
Message-ID: <20260414221429.GA3475104@coredump.intra.peff.net>
References: <20210221192512.3096291-1-szeder.dev@gmail.com>
 <20210221192512.3096291-2-szeder.dev@gmail.com>
 <YDLXf+OoJabrJTWu@coredump.intra.peff.net>
 <ad6pEbnSKzUOkS2k@szeder.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ad6pEbnSKzUOkS2k@szeder.dev>

On Tue, Apr 14, 2026 at 10:52:33PM +0200, SZEDER Gábor wrote:

> On Sun, Feb 21, 2021 at 04:58:23PM -0500, Jeff King wrote:
> > On Sun, Feb 21, 2021 at 08:25:12PM +0100, SZEDER Gábor wrote:
> > 
> > > In many test helper functions we verify that they were invoked with
> > > sensible parameters, and call BUG() to abort the test script when the
> > > parameters are buggy.  6a67c75948 (test-lib-functions: restrict
> > > test_must_fail usage, 2020-07-07) added such a parameter verification
> > > to 'test_must_fail', but it didn't report the error with BUG(), like
> > > we usually do.
> > 
> > OK. I do not care all that much between BUG() and not-BUG here, since we
> > are unlikely to have a test where test_must_fail returning 0 yields
> > success. I guess the most interesting outcome is that we would notice a
> > bug in a test_expect_failure block.
> 
> If I had managed to send a new version of this patch series in the
> last 5 years :), then this would have caught the issue noted in:
> 
>   https://public-inbox.org/git/ad6hovxCkwMTG11U@szeder.dev/

Looking at that old thread, I do not see any reason you should not
re-send it (with or without the cosmetic fixups I suggested on top).

-Peff
