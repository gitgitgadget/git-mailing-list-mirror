Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C155C36606C
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 16:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772812896; cv=none; b=qZlYhJ1CmHklpNEEuG+oaUrwESReWlEFd3KkGXwQs9MEsdygAM/ksBNSXAo/zUgJyWQB7JP1GPD8bh/jja0faD6fMiXpaZp5s3+D00oy+FW9egXK6f0rPUXDv/19i0NKG3K4MRgrkgPz5R+hsmZsYSekM9QTdVPm2NeER96LNY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772812896; c=relaxed/simple;
	bh=hi42o+jqsXsR6URVSoFG+sfhVhX5bi29y1ykLE7siU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U9yVUjfUqXQrDFRr7FOrjgL6gAkkdb9D3JqO9anjOdJDtIRVLdEBuC3CKQoFKfhT1Aa6qHfvdH2rBuD2L6z8BUqeWHayZtL89tbxfigxboZBqbwVQLKU837det9zkt+Zn4JGX9tym+vq1UqxAWD+aJ92QlQlbiOnIBjdaWVroSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=D/q2n7Tr; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="D/q2n7Tr"
Received: (qmail 10612 invoked by uid 106); 6 Mar 2026 16:01:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=hi42o+jqsXsR6URVSoFG+sfhVhX5bi29y1ykLE7siU8=; b=D/q2n7TrItSMVC/l5zt0Epk93uhl/nxPn2L9kaOYX0NMaC5MvutpmE9zKsvRNeXTewrNKgUMwyLoyBG5L/uQYRqeL0gFTvA5s9GWgQaPQKLTQ3IrBiqXxnoGjQGxSWraTctEikcp04uwteSADA0njwYrs2jEbgt8lnrnjxKqQUeAeG1mO9FzQpzznvhEJAW6Yy04OSFknSt3OCnwqiXH0XjEyv7AY622i8Hvt6wlT7RCDYJhfFk1d+IUeSXCpIy2J43FSdX1CslB0s3m3VqOSCWwQMia4AZh0+NaRH6nGS0qB/+rqoGPqgeUeou87KSun6DAyEVjOx3MXeWZJ4c+dw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 06 Mar 2026 16:01:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 405229 invoked by uid 111); 6 Mar 2026 16:01:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 06 Mar 2026 11:01:33 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 6 Mar 2026 11:01:31 -0500
From: Jeff King <peff@peff.net>
To: Ivan Ivanov <qmastery16@gmail.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
Subject: Re: Test "t0300-credentials" is failing on Arch/Artix: asks to enter
 the Username/Password in an infinite loop
Message-ID: <20260306160131.GA3577004@coredump.intra.peff.net>
References: <CAAaskFBp+A9pOhd8O6owd6k0cDj66ipXrqH2Hj_c7j3d=HM10Q@mail.gmail.com>
 <CAAaskFANnrqTAjQOHhAgzES9=S+y7w9u-LMWbRbi8FayVdvzFw@mail.gmail.com>
 <aaosmo1Iluc5KeZw@fruit.crustytoothpaste.net>
 <CAAaskFC=tpuS-saP9t5Kp0+i6qTHe29x-dGkanyAzz-xaq_HDA@mail.gmail.com>
 <aao1DF3lXfHTMH30@fruit.crustytoothpaste.net>
 <CAAaskFC0WETe7NaEfznW-h53Huee2sLLAQYWBA3moLpeULhtcA@mail.gmail.com>
 <20260306043821.GA3465674@coredump.intra.peff.net>
 <CAAaskFD7wmtqppatb5T5GMTviieR0Ttk9y4+c3khuF3bZBfE=g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAAaskFD7wmtqppatb5T5GMTviieR0Ttk9y4+c3khuF3bZBfE=g@mail.gmail.com>

On Fri, Mar 06, 2026 at 05:14:45PM +0300, Ivan Ivanov wrote:

> Friends, thank you so much for your kind help! Indeed: it turned out
> that if /dev/shm is mounted with noexec then "--root=/dev/shm" is
> failing. If you would like to ensure that the git tests are succeeding
> regardless of what are the mount flags on some system or what some
> distro's packagers are doing (more portability), maybe it is possible
> to modify the git test system - to make it so that "askpass" always
> gets launched from a native original directory, instead of being
> copied to some "root" place where it could fail?

it would be possible to do that, but introduce a lot of complexity.
Right now test scripts are given a single temporary scratch directory
with a repo to do whatever they want with. If we gave each one _two_
directories, one for putting executable things and one for repo
operations, then the latter could be on a noexec filesystem.

But why do we want to support pointing --root to a noexec filesystem in
the first place? I think this falls into "if it hurts, don't do it".

-Peff
