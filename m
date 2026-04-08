Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11A8322A
	for <git@vger.kernel.org>; Wed,  8 Apr 2026 22:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775687556; cv=none; b=EaMW1DyReX2Os/7LSzIqgE7+vs3ifHhgIG+yKYKhiRJgLofYgwViLMNzsqjaVotg/sKj7KCST/BwGb17HvGkcNbMtrUgLKbWZ+YBg0LXfteBnnqCBBJuCmootTZ/eriMN8x2MeQOMf/xrR5SzqfkKrzqPxzuf7HoZoId5LVxWFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775687556; c=relaxed/simple;
	bh=VFC5IW29wsi9xCVT151LhCGzZu4CB1skLqrq8L1VGpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D4GEkL1HrJAwCVQBNuTbIR/KrcIzosSVJdxwZZ7Xic6f10f9gFEssHIgGeiuiDUiY7VpuXd5BiOuamTwJLW49ERly7fga7BTXvNwTmm299mVw8DYMVI9Gp+nG5gBxYarRbnxRz22UyAe7WOtujnC2mVyWDaDLNxWMUB6zXODLR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=R/btN3w9; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="R/btN3w9"
Received: (qmail 286529 invoked by uid 106); 8 Apr 2026 22:32:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=VFC5IW29wsi9xCVT151LhCGzZu4CB1skLqrq8L1VGpA=; b=R/btN3w9Z1dV+L/xIfwgojm1owQdkfBJQWVWtCKMnJ9HAaRHGWOtPKaT1pQVZDfi2bBpDT4ejYdnoD7LLeYHtKbMdMAaQdOWX5C3ThA2SWCwHsi0UpTbZAu+aicKjR3OIdMmc6gBJ4lB8bgPTSzunhuOMroZyXexEXkxaA1ZQXhmsZ+7yLRHYuxN0Rp5m4PNSllFXP4T+huGxgiUMuQJnfVZ82JpeLAhlBQCeczTbI9LIJ1exmi5UrzBZxViO76ObKI0HxBITeK9qLUAvlWkZn5pWON43mrHp+3gza+W0et7d3ozIziEOwFHrGgJ5GCqHDqCdXSPKRa9Min3eW07qQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 08 Apr 2026 22:32:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 469833 invoked by uid 111); 8 Apr 2026 22:32:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 08 Apr 2026 18:32:33 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 8 Apr 2026 18:32:33 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: rsbecker@nexbridge.com, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: Git 2.54.0-rc1, subtests of t5310, t5326, t5327
Message-ID: <20260408223233.GB2873736@coredump.intra.peff.net>
References: <00f401dcc6e6$7183c0f0$548b42d0$@nexbridge.com>
 <20260408041716.GA1324339@coredump.intra.peff.net>
 <011701dcc767$8c2ab400$a4801c00$@nexbridge.com>
 <013301dcc774$5e9fffb0$1bdfff10$@nexbridge.com>
 <20260408173949.GB2850002@coredump.intra.peff.net>
 <xmqq4illz5g9.fsf@gitster.g>
 <014e01dcc793$8a9bab90$9fd302b0$@nexbridge.com>
 <xmqqqzopxkxa.fsf@gitster.g>
 <016b01dcc79e$87472860$95d57920$@nexbridge.com>
 <xmqqcy09xh53.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqcy09xh53.fsf@gitster.g>

On Wed, Apr 08, 2026 at 02:43:20PM -0700, Junio C Hamano wrote:

> > Yes, NO_WRITEV=Nope does compile and execute. I am including it
> > in our CI/CD job for now. Can we plan on a fix for this?
> 
> What I have heard so far indicate that the code that uses writev()
> would need to loop over to prepare for short writes, but your
> writev() that fails for "the OSS I/O size limit" (whatever it is)
> does not sound like something we want to change the callers to chomp
> the writev() calls into smaller chunks for.  Such a platform is far
> better off using the compat/writev for the code path we recently
> started using writev() in.

Yeah, we definitely do not want callers to worry about this. I think it
would be possible to have xwritev() handle this, but it gets ugly. If we
are worried about an individual iovec being larger than MAX_IO_SIZE,
then we may need to rewrite the iovec array to break it apart. And if we
are worried about the sum of the pieces being larger than MAX_IO_SIZE,
then we end up with multiple writev() calls anyway.

At which point the least-painful thing is probably just calling write()
on each segment anyway, which is exactly what the compat wrapper does.

> To be quite honest, I am not sure if it is even worth using writev()
> if we need a loop that protects against shrot writes, so unless I am
> grossly mistaken (e.g., perhaps there is some guarantee that there
> won't be any short writes for writev() that sends data smaller than
> 64k that I missed in the docs), the best course of action might be
> to revert the change to use writev() and use the two write(2)s as
> before, *if* we actually observe that the current code is broken by
> short writes.

I think writev() is buying us something when it works (it is halving the
number of writes for sideband packets). And it works when either:

  1. the platform is OK with writing up to 64k in a single writev()

  2. the platform has a limit that is small (like NonStop here), but
     writes less than MAX_IO_SIZE work and will save a write() call

If we just care about (1), then the right solution is to declare that
writev() isn't fully functional for us on some platforms, and they
should build with NO_WRITEV. And we should probably embed that in
config.mak.uname.

If we want to care about (2), then we could make the decision at
runtime, something like:

diff --git a/compat/writev.c b/compat/writev.c
index 3a94870a2f..cf2fbb39c9 100644
--- a/compat/writev.c
+++ b/compat/writev.c
@@ -1,7 +1,7 @@
 #include "../git-compat-util.h"
 #include "../wrapper.h"
 
-ssize_t git_writev(int fd, const struct iovec *iov, int iovcnt)
+ssize_t git_writev_with_write(int fd, const struct iovec *iov, int iovcnt)
 {
 	size_t total_written = 0;
 	size_t sum = 0;
@@ -42,3 +42,17 @@ ssize_t git_writev(int fd, const struct iovec *iov, int iovcnt)
 out:
 	return (ssize_t) total_written;
 }
+
+ssize_t git_writev(int fd, const struct iovec *iov, int iovcnt)
+{
+	size_t total = 0;
+	for (int i = 0; i < iovcnt; i++)
+		total += iov[i].iov_len;
+	if (total > MAX_IO_SIZE) {
+		/* too big; bail to wrapper which will limit individual writes */
+		return git_writev_with_write(fd, iov, iovcnt);
+	}
+
+	/* otherwise, use the real system writev */
+	return writev(fd, iov, iovcnt);
+}

I'm not sure that complexity is worth it, though. If your write-limit is
less than 64k you are already doing lots of extra write() calls, and
trying to squeeze out a tiny bit of performance by omitting a few of
them is not worth the trouble.

Though it does make things Just Work on such platforms without having to
set another build-time knob.

I do wonder what it all means for systems with MAX_IO_SIZE that is more
reasonable. Right now we are using writev() only for sideband packets.
But one of the stated reasons for using it there (instead of tweaking
the packet buffer so that there's room for the header in it) is that
people wanted to be able to start using writev() elsewhere. If we start
feeding unbounded data to it (say, a blob buffer), then we're going to
be violating MAX_IO_SIZE for those calls. So there may be more of this
headache down the road.

-Peff
