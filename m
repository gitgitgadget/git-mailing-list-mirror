Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B491531E11D
	for <git@vger.kernel.org>; Fri, 17 Oct 2025 10:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760698445; cv=none; b=O7sv7h72bk68Xpo9xkLEziMxDJlsMYk82jJKYUdBc+1sbCEmAx4MTEIVFngPsOWp+GgrVwCauX9JQHjUebaglm7kp/zxb5g8Fx+m07vS6lrFBAlp8zpds6I1oEE58nd7lCwGmyBu6jsKKBsJqJMqDAGLul0+DBQIR8i3yzp5oIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760698445; c=relaxed/simple;
	bh=HU23Bdz4k56pCXXhUPk+w43Gyjmcyke2l6aGOBXF0cE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KG5D5okw6P7rxrIXSpgE8Tjk3754TUoxnrVh3e/BoaNleq4GpikHizIsDI/ktfQRd/4kQn70BTCrvi2kTKHqT3aZHdtxADJtlU5F1BqZMVYCuV0YwPVQYJJCPLiDkZo2E7vWYX26Ag8yKo+dxVQuKlLUGvZk7REnIr/qAwApwtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ENqq+2tb; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ENqq+2tb"
Received: (qmail 253828 invoked by uid 109); 17 Oct 2025 10:54:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=HU23Bdz4k56pCXXhUPk+w43Gyjmcyke2l6aGOBXF0cE=; b=ENqq+2tb9bz02+WvBwWutka3xCnxwXXg9QZk57V5PvxK+B77QwANPB580PSawTJB4SbMFtfqU37Yg9iJGePlF1evMWlf0oBh1IImzswuiOh8m6NWhvMklDH9MdFz6RFBb78W+ZNp7LwB3omoHsnTz7bJ48qIFAXlQBbQstcRKJQ/koDalvxcmlnZoWGWCYMxipmF28P7xzDCBQBRgc4vEZnam8AkUQ+H9gM5+YCYITiYe0/m0BjRNhtv57RpFqxo3qQZ85a3wBp4vest11U3FkX+6aNzEADbYSWCDNeUtU/ZC+Lpnk6dwQZ1S/IIfNZ1Qnq08T6dn6lWvRucS3KNLA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 17 Oct 2025 10:54:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 395349 invoked by uid 111); 17 Oct 2025 10:54:01 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 17 Oct 2025 06:54:01 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 17 Oct 2025 06:54:00 -0400
From: Jeff King <peff@peff.net>
To: Lauri Tirkkonen <lauri@hacktheplanet.fi>
Cc: Collin Funk <collin.funk1@gmail.com>, Xi Ruoyao <xry111@xry111.site>,
	git@vger.kernel.org
Subject: Re: t7528-signed-commit-ssh.sh fails due to ssh-agent fails to start
 with ENAMETOOLONG
Message-ID: <20251017105400.GB1015973@coredump.intra.peff.net>
References: <4e2952e512afc780b621d2c153b3e6e4eb7ed89a.camel@xry111.site>
 <87o6q6nux7.fsf@gmail.com>
 <20251017070912.GA4068463@coredump.intra.peff.net>
 <aPIR8fB4w5Jkeiq2@mail.hacktheplanet.fi>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aPIR8fB4w5Jkeiq2@mail.hacktheplanet.fi>

On Fri, Oct 17, 2025 at 06:52:49PM +0900, Lauri Tirkkonen wrote:

> > If I unset SSH_AUTH_SOCK in my environment, then the test consistently
> > fails. But I'm somewhat amazed that nobody has complained about this
> > before. Surely somebody somewhere (especially CI!) is running t7528
> > without SSH_AUTH_SOCK set in the environment. Which makes wonder if I'm
> > missing something.
> 
> I believe the issue surfaced only now because prior to OpenSSH 10.1,
> ssh-agent would put its socket in /tmp by default, not under $HOME. See
> https://www.openssh.com/txt/release-10.1

Ah, of course. That explains it perfectly, thanks. So we're going to get
lots more reports as people upgrade. :)

> We saw this failure in CI on Alpine Linux and worked around by adding -T
> to the ssh-agent invocation in this test, but I suppose that won't work
> for earlier releases of OpenSSH.

Yeah. We could either do something like "ssh-agent -T || ssh-agent", or
we could go with "ssh-agent -a" (which has been around since 2002, but
does raise the potential relative-path issue).

-Peff
