Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B010358378
	for <git@vger.kernel.org>; Sat, 25 Jul 2026 10:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784973775; cv=none; b=ctJ1jWysYCcqtKQywijn2Rv/E26IyR+wzZObTJOmSvi0s6RrWxHN0zavSTbSQ+eFsvIOF9rb5Ew4x9RQMo1tkKhCfmT2DIfXrLs69fXVRSzjA//8bWWBZ99fQtCEZn/yKl94GRyvnLexQbcDBuA45+eJ92OPNc8BGocqDH3iEGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784973775; c=relaxed/simple;
	bh=L5U4I7q5u3mKKvEbmA5/XXgUg/w08XuU2s4X1VyA8m0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=htIkdgt92cDb/10Jtxk4Pb6Z0+iLHqKvuNojeecF8AlFpIFLs/G82++g//4jrbEUiZCuOh5oAvhqNNkzQUoT04l8OJ8jiq7kRdiEWy8EsHfzT34En6muSkidRZWCQNjYR+eiI8QAbhkw4pKtLy/HAjQyW4ET89r0QfA+ScYzAkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=VQAsL+7I; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="VQAsL+7I"
Received: (qmail 45815 invoked by uid 106); 25 Jul 2026 10:02:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=L5U4I7q5u3mKKvEbmA5/XXgUg/w08XuU2s4X1VyA8m0=; b=VQAsL+7IrDE4epJflwTcfZR0nXd5tSFEtbfvLhjioZPK9Bv73R9fO7GsPI9rQNtBUC/7FOYV/9GDRuhD3OsXpWmKFGLptxXl5p8mjKSWsCAG1nnoYkQj0gGG1koF6T3uCNJqris6U9PtmgO8/Z0DxrJxc++30e/btTw3ajzrnOryHUcZyST2EOoxb7gMkZc7ogIkmtBEpzuvYVmeCchqkWEHahr14CXOFnczz8JWD48E4w1BZsRZ2CZTeWLFSKDVzWAXWLp7R96nh5nrVyFwFnnMBv6P1rm6uq3Ce2fqsHyhjWv56+pK34J9o7ZJe4tauAaWPNLxj6t96V0rn2By/Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 25 Jul 2026 10:02:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 45615 invoked by uid 111); 25 Jul 2026 10:02:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 25 Jul 2026 06:02:56 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 25 Jul 2026 06:02:51 -0400
From: Jeff King <peff@peff.net>
To: Ted Nyman <tnyman@openai.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	me@ttaylorr.com, ps@pks.im, karthik.188@gmail.com,
	sandals@crustytoothpaste.net, avarab@gmail.com
Subject: Re: [PATCH v3 0/3] packfile URIs: support concurrent downloads
Message-ID: <20260725100251.GA1933232@coredump.intra.peff.net>
References: <cover.1783982021.git.tnyman@openai.com>
 <cover.1784676106.git.tnyman@openai.com>
 <xmqqldb19evx.fsf@gitster.g>
 <20260725090910.GA1438796@coredump.intra.peff.net>
 <20260725092154.GA1925154@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260725092154.GA1925154@coredump.intra.peff.net>

On Sat, Jul 25, 2026 at 05:21:54AM -0400, Jeff King wrote:

> On Sat, Jul 25, 2026 at 05:09:11AM -0400, Jeff King wrote:
> 
> > So from the perspective of the server process, everything is fine, but
> > curl complains that it didn't get all of the bytes. Weird. The strace
> > shows both writing the first 1MB as expected. It's like the connection
> > gets hung up for some reason, but I can't tell why or by whom.
> 
> Hmph. I tried stracing on the client side, and we indeed see an EOF
> on the socket:
> 
>   recvfrom(12, "", 16384, 0, NULL, NULL) = 0
> 
> I'm really puzzled why that is the case, though, as the server side did
> not close() or exit.

So I'm still puzzled by all of this, but I think it's mostly a red
herring with respect to the actual "test -s" race.

The server tells us when it has written the first 1MB to the client, and
then we check that "test -s" is showing something in the on-disk
tempfile we're downloading.  But there's no guarantee that just because
the server called write() that client has yet received the data, let
alone written it to disk.

I can't think of a synchronization point we could use here. We're
waiting on curl to have passed the bytes to fwrite() and for it to have
actually synced to disk. We either have to poll or modify http.c to
write "yes, we got some bytes!" to a fifo. Both are pretty gross.

I wonder if we could just drop that "test -s" entirely. We'd _usually_
see some bytes written before the second request starts. But it's OK if
we don't. It just means the test is working in the reverse order (the
second request may write its bytes first, and then the first one is the
one "overwriting" it). I.e., the two are symmetric from our perspective.

-Peff
