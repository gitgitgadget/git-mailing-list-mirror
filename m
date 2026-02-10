Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F17032D0EA
	for <git@vger.kernel.org>; Tue, 10 Feb 2026 06:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770705865; cv=none; b=kqL0XNiV4nu9o+cDBPbSkwhGnl4Gsu8qq93o0Oyccy92VUUdxqDv/GnmG38+/pSTzBLN6zamqS+aqclqAmAieQ9MrnWhmG2lonGa5sNlUtvO4KyS0QaxFlGWxkpwljSFEwU2ZALa6zU4HbuQcreSqjwPx+X6MBCoCFhGXamBTxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770705865; c=relaxed/simple;
	bh=zVwKauC8gAjDzNH0zZMZd5HUkoNOtA4MUL1WiHMIDA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rlXQl2cOV0ij5NDK1r9uKrLzt2RUVWefkunlorK+n26b98y5deWPWGujc8PTw+zNGinGSpTgIi3J06NaRHsvHDHBujqV9Dd9oQgEIFQ7o/nPd7/XxLJiHGLwC/HHJrIvXa8YLb0wIe/ANWdrY22frL94WQaZL/yvaC9/P2PlzcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=IY91R8YL; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="IY91R8YL"
Received: (qmail 353403 invoked by uid 109); 10 Feb 2026 06:44:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=zVwKauC8gAjDzNH0zZMZd5HUkoNOtA4MUL1WiHMIDA4=; b=IY91R8YLujxvydniD+BxqQHyglelmbyEbWQYc+2hcYpfycczLTXZH8eUoOp4Wsy/R44BC6XWRj0z0NG3MLs1srFZdVkYCgpXmSNAOEryD35YjXGGcdjYaVaEeBauc7Fqut9wxjFTx83m2GXu4zZRaKjjWNa++HKi2/qI4tFGweO6cZBCUO4vXNJik/7HN2UKTTr+opLYTOAKv2z2hfuADwosX1PKLEqOLn63aIQtWlP3W50CEEQN90H2x2/nQhF31lDMiMkUF1GxIyaQ31NkE/N8EUGCuH0H+ryXFWQhEqj3dK4sTh3X6AeqyqAgv+oA7/r+XHlWaxZfIVKDm8nL6A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 10 Feb 2026 06:44:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 697800 invoked by uid 111); 10 Feb 2026 06:44:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 10 Feb 2026 01:44:23 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 10 Feb 2026 01:44:19 -0500
From: Jeff King <peff@peff.net>
To: phillip.wood@dunelm.org.uk
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Matthias Beyer <mail@beyermatthias.de>,
	Jacob Keller <jacob.keller@gmail.com>, pyokagan@gmail.com,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH 3/3] templates: detect messages that contain a separator
 line
Message-ID: <20260210064419.GA1756549@coredump.intra.peff.net>
References: <20260206090358.GA2761602@coredump.intra.peff.net>
 <cover.1770476279.git.phillip.wood@dunelm.org.uk>
 <83c100a73ec722bf72a15b7b40b0c82bf8829168.1770476279.git.phillip.wood@dunelm.org.uk>
 <xmqqldh4b5y2.fsf@gitster.g>
 <20260209070018.GB585828@coredump.intra.peff.net>
 <b0c456ce-94f6-4155-8cbd-3dd75a9cc52c@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b0c456ce-94f6-4155-8cbd-3dd75a9cc52c@gmail.com>

On Mon, Feb 09, 2026 at 10:42:49AM +0000, Phillip Wood wrote:

> > I do it, too, though not all that often. Once upon a time I had a patch
> > to teach git-commit to auto-convert lines after "---" into a note (which
> > would then be formatted back out via format-patch). But I found for my
> > git.git workflow that just letting the "---" ride along in the commit
> > object was simpler and easier (since I don't care about having pristine
> > commit objects, as their ultimate fate is to be dropped in favor of what
> > is applied upstream).
> 
> I do it too occasionally. I had planned just to use "--no-verify" when I did
> that but maybe we should just drop this patch. We could make it configurable
> as Kristoffer suggested, or, as we have the raw message, we could look for a
> special comment like "# allow ---" but I'm not sure I want to spend much
> more time on this. At least "---" only truncates the message rather than
> applying an unwanted patch.

Just to be clear, I am OK either way, as I do not use the sample
commit-msg hook. ;) Since the sample is mostly for illustrative
purposes, maybe it is fine to potentially over-reach and let people trim
it as they see fit.

-Peff
