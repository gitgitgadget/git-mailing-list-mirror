Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E146E200CB
	for <git@vger.kernel.org>; Tue,  4 Feb 2025 02:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738636542; cv=none; b=kaaO1Bj5bH7dOPi8FpuuSuW5A79pMi8zc5Ks1mgEZzeN1hDgq52V4sdfq25uvq+OcIpe8/37kLOOhg+c6xCA7kA4R+3aGuNmvVj301LRO9IXYbsF2Q/PvQHm5JFLs5Cmcz+1wikznTPom6wtO+Y/3NZuBvPhVpvQ7KZRjA2+XGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738636542; c=relaxed/simple;
	bh=Xo65SjVrQitdy16AbfJ+WGcUQrFMRLa9yBnxZsf1+jk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=USBYeyBaKYV6RWuKFCYmotTZdjM/LbEpnAhq7SJEke9BEQ7QVsaNL0DdBUv092dnSH+qF2glTPsSe0f6tFaTst7/LDb0onB/u4+yIlMfP/jJRa2sXSmwUkSSa8Z9LMB8zIYKhfSZNytZBgcsVacRslpj5alPhhBol37l/7tSuEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=LKRzJzgy; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="LKRzJzgy"
Received: (qmail 21796 invoked by uid 109); 4 Feb 2025 02:35:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Xo65SjVrQitdy16AbfJ+WGcUQrFMRLa9yBnxZsf1+jk=; b=LKRzJzgyzvJ8/i4+t481WEAw1FOXx7fQLA4gAbMMjS4MpRQ4lWT5A/BLeLOsQ564gHSql+dQ64apFgJxZWBOcMA4m4R7mbrhoTQYPiRwmWOy092+RNa3MJTr4u+JwVvrZylkRvU4moPwbFb/uZWCeQtTnIYTSGwuMgEX42qoqoT2Q66ahJhhsbMGpXsgMEWXdcHUX7MnQKLi/ZPqHa/rj/jkxIvC013jPWu+faiOLDRWV1CujVptvNnQs9ejSvYZ1r6yja1dk09XNYzQLwM7n65J3llyGG1NF6wQsbWvjRJpStCL7GV1YQls1ErQVfgjLVh21ObOe3LIQUIncG01zw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 04 Feb 2025 02:35:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30056 invoked by uid 111); 4 Feb 2025 02:35:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 03 Feb 2025 21:35:42 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 3 Feb 2025 21:35:38 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH 1/2] t7700: add tests for `--keep-unreachable`
Message-ID: <20250204023538.GB23954@coredump.intra.peff.net>
References: <20250203-b4-pks-repack-unreachable-objects-wo-packfiles-v1-0-7c4d69c5072c@pks.im>
 <20250203-b4-pks-repack-unreachable-objects-wo-packfiles-v1-1-7c4d69c5072c@pks.im>
 <20250203183224.GA4183065@coredump.intra.peff.net>
 <xmqqcyfyzit1.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqcyfyzit1.fsf@gitster.g>

On Mon, Feb 03, 2025 at 03:53:46PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Mon, Feb 03, 2025 at 02:06:54PM +0100, Patrick Steinhardt wrote:
> >
> >> We don't have any tests for `git repack --keep-unreachable`. Add three
> >> tests that exercise its behaviour with different packed states for the
> >> unreachable object.
> >
> > There are a few in t7701. It's spelled "-k" there, so a grep for
> > "--keep-unreachable" would not find them.
> 
> Ahh, good eyes.  Thanks.

I got to cheat a little as the original author of the flag. ;)

-Peff
