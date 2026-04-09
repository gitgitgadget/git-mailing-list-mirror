Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9D23A16A0
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 08:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775722654; cv=none; b=dveASnVdwsobBuHBrWIIuFIE0YEXP9x0RWbwmWdymgEDfcQycYcR/oJzJnZUuu4fI7YxDeDLUzSlLdfKhII3BPYUeoT5If0hjhUn5ijMVr2xp12i2eminmKXzS2QAuuxMzA1EEyVpR5sNanE+rXSXSm4PNgfmKC7IfrqwfGsyVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775722654; c=relaxed/simple;
	bh=LU/dJ5LLf34UeJQb9fc6sO5ZhvSz+EEbP8M5I65avBA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UG0sP0yguk4HTM28ryM7ZD7zKOQNLWYyQm0UeaoJFJkTAcfIxbUnnI9iFHD9JCrNBaPU0NSE6pVXrrAQw2hMjk6N9yuufwRhaTI9VyKRNAwPqi5vlsIYVdtxV6DDiFZBKBUyLSR7wFMYb6ooJzR/HZB9Y9FJLCSwMHYKHvruHQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=vNZTUspM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EyQUzGZZ; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="vNZTUspM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EyQUzGZZ"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6D2821400220;
	Thu,  9 Apr 2026 04:17:32 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 09 Apr 2026 04:17:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1775722652; x=1775809052; bh=7/iu3rnHcp
	UQGwj6vX7CVYDTipGdYqxYJG1WK0PpM40=; b=vNZTUspM/lqmHaNTtVWYyhbKxn
	HQeVJWZtATitGtHzXl2FdKi4Z3Lu6y6qh5ohsFORzb96JB3QmBSTuQx4bLrrP9Ln
	2u0Vf5Y3JCk7u4ES5+3TkqYSNe5Xt39yfTziUHrxArg+82R7GHBAYCWvZ3Sd5VS8
	RQGQT0/BY+9G4Y9WRIwOE1fNShiD3yrlgAOpSGQzmml/DvXCKNTbz3sa5GIJDFpX
	Yk9c3ISPoHjIa+OzWsma+zJ6UqvdzobTrYn+QdwoKihLNI4EfnKEgUJ9Ri7AQbfj
	ByG9uCmxkhTtLXncsTitH6NpVZVMNAQ1v4GY2pFiDWPF6MQgeKASf7huQbWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775722652; x=1775809052; bh=7/iu3rnHcpUQGwj6vX7CVYDTipGdYqxYJG1
	WK0PpM40=; b=EyQUzGZZfDG0OnkU71+C8eBPM1peqLDjHobgFtPAPxffU/N/K/a
	3+GVK5KQYxpDSVdyve7lHnN5dhczFq2n82D86rXSYN46F0qalPwMzkBj3ry6HDLp
	c+lyxFluTm0/a/Q02WhRvL0Z4B+0G7HZ7ikbSVMM6/8VWqcN1B15GYPXeY88+vpd
	ZbE9rqrYhuVjw1yxFmTn4IncQF8nJsCsmSapHSqa1iz2qb50MD9zxfSuGzG+i0Wx
	gVRPdXaqZZVoqvdlkeRlgXyY574OUm2xp8UvX/tKZCH89YaAatWmILqAbJZLeXPA
	/m+SV/9IbCHWgl6QFik5iIYuRE1i8GO1F6Q==
X-ME-Sender: <xms:nGDXaUyjLcGIBQU9O4HwbgCWPCRtHHjoaY_OX-7hMXV5Efa31FM4Xw>
    <xme:nGDXafK1Yc4AMnJvsHfb4y1xOXAbhuvjghme05N_jYQ-SOb4YfBoHNPAEZ_TfMUAb
    2OH4IrraqTSLwo6pQZI7Gx9Ro-r3LN4hn5LidWjSFbJ0KOwlC2->
X-ME-Received: <xmr:nGDXaep2POPF1lIw-h91Wfld9qapGSaAdS8rcJMvHFDgAFtSOiPH0YaW1slxLvMRE_mUKAnWHcWXI2auErMGTQ6UnBaYiByuAO1SsWOQOHk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvheeliecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehttdertddttd
    dvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdr
    ihhmqeenucggtffrrghtthgvrhhnpeehkeeffeeggedvgedvfeefheettddtffejueffle
    fggfehfeelffeljedvfeehieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopehrshgsvggtkhgvrhesnhgvgigsrhhiughgvgdr
    tghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrghnuggrlhhs
    segtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehpvghffhesph
    gvfhhfrdhnvght
X-ME-Proxy: <xmx:nGDXaeIH7iQHBY_VeWg8hYMCNU_P-J_LXUOZUlPpsbhTaevaoqLtbQ>
    <xmx:nGDXaTQk3AlxI4h37T4sV-HgNzgmbZlveU66o69tWUtgad_PtbmNMA>
    <xmx:nGDXadt7LncAan6IMa2wypfu_QSRHv4NbL0jb6xbCdD5Cuizp4C_Lg>
    <xmx:nGDXaUbGLvDwr8LkLjPKa_-NjDyY7WvndL7YVfNr1Gf_5KOdaf57OQ>
    <xmx:nGDXaXT60YDAAWxi1vpIyceguR9KeGd3D6sMjYjBV9XjtnjlWWuRzXc2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Apr 2026 04:17:31 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8425fee2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 9 Apr 2026 08:17:29 +0000 (UTC)
Date: Thu, 9 Apr 2026 10:17:22 +0200
From: Patrick Steinhardt <ps@pks.im>
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	rsbecker@nexbridge.com, git@vger.kernel.org
Subject: Re: Git 2.54.0-rc1, subtests of t5310, t5326, t5327
Message-ID: <addgkjiB80pgKw69@pks.im>
References: <011701dcc767$8c2ab400$a4801c00$@nexbridge.com>
 <013301dcc774$5e9fffb0$1bdfff10$@nexbridge.com>
 <20260408173949.GB2850002@coredump.intra.peff.net>
 <xmqq4illz5g9.fsf@gitster.g>
 <014e01dcc793$8a9bab90$9fd302b0$@nexbridge.com>
 <xmqqqzopxkxa.fsf@gitster.g>
 <016b01dcc79e$87472860$95d57920$@nexbridge.com>
 <xmqqcy09xh53.fsf@gitster.g>
 <20260408223233.GB2873736@coredump.intra.peff.net>
 <adbwyvQ-R2Ag1vox@fruit.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adbwyvQ-R2Ag1vox@fruit.crustytoothpaste.net>

On Thu, Apr 09, 2026 at 12:20:26AM +0000, brian m. carlson wrote:
> On 2026-04-08 at 22:32:33, Jeff King wrote:
> > I think writev() is buying us something when it works (it is hlving the
> > number of writes for sideband packets). And it works when either:
> > 
> >   1. the platform is OK with writing up to 64k in a single writev()
> > 
> >   2. the platform has a limit that is small (like NonStop here), but
> >      writes less than MAX_IO_SIZE work and will save a write() call
> > 
> > If we just care about (1), then the right solution is to declare that
> > writev() isn't fully functional for us on some platforms, and they
> > should build with NO_WRITEV. And we should probably embed that in
> > config.mak.uname.

Yeah, agreed. I think we shouldn't make ourselves a hostage to platforms
that don't have reasonable support for writev(3p), as it does buy us
something on the majority of platforms that actually support it well.

That of course doesn't mean that we shouldn't support such platforms.

> Looking at POSIX, there doesn't seem to be any constraints on the size
> of individual vectors other than that they must total to less than
> SSIZE_MAX.  iovcnt can be limited to 16, but I don't think we're hitting
> that here.  POSIX does say that SSIZE_MAX does not need to exceed 32767,
> which may be what's going on here, although that does seem like an
> unreasonable value for a real system.  Linux, FreeBSD, and NetBSD all
> set SSIZE_MAX to either INT_MAX or LONG_MAX.
> 
> I also think that 64 KiB is more than reasonable in terms of the size
> that people should be able to send.  I'd personally expect to be able to
> send values much larger, at least 512 KiB, and I have code that expects
> even larger (16 MiB).
> 
> So I'd simply say that for systems that have a constraint on the size
> that is "too small", they should just use NO_WRITEV.

I would be happy with this as an intermediate step, as Randall has
confirmed it would fix the issue. It is the least intrusive step and has
the lowest risk.

> However, I don't have a strong opinion on this and if people want to do
> the proposal for option 2, that's fine with me.

I think in the long term this is the most sensible approach though so
that we don't have to special-case platforms. I've crafted the below
alternative to Peff's patch, and I think it's ultimately not too bad.

One question to Randall though: does MAX_IO_SIZE apply to the overall
size of the iovec or to the individual iovec entries? I think it should
be the latter, but I cannot easily verify and couldn't find any docs
around this. So could you please try the patch at the end of this mail
to verify that it works on your system?

In any case, I've tested that my patch also works when defining
MAX_IO_SIZE to 128 bytes on my system, which hopefully demonstrates that
it works as expected:

diff --git a/git-compat-util.h b/git-compat-util.h
index 4b4ea2498f..8e02b5f673 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -690,14 +690,8 @@ static inline uint64_t u64_add(uint64_t a, uint64_t b)
  * to override this, if the definition of SSIZE_MAX given by the platform
  * is broken.
  */
-#ifndef MAX_IO_SIZE
-# define MAX_IO_SIZE_DEFAULT (8*1024*1024)
-# if defined(SSIZE_MAX) && (SSIZE_MAX < MAX_IO_SIZE_DEFAULT)
-#  define MAX_IO_SIZE SSIZE_MAX
-# else
-#  define MAX_IO_SIZE MAX_IO_SIZE_DEFAULT
-# endif
-#endif
+#undef MAX_IO_SIZE
+#define MAX_IO_SIZE 128
 
 #ifdef HAVE_ALLOCA_H
 # include <alloca.h>

I'm happy to go either way, but think that we should definitely aim for
the below patch eventually. Just let me know which way you prefer and
I'm happy to polish up the patch.

Patrick

diff --git a/wrapper.c b/wrapper.c
index be8fa575e6..645dbc5f20 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -323,21 +323,50 @@ ssize_t write_in_full(int fd, const void *buf, size_t count)
 	return total;
 }
 
+ssize_t xwritev(int fd, struct iovec *iov, int iovcnt)
+{
+	ssize_t bytes_written;
+	int i;
+
+	/*
+	 * We need to make sure that no individual iovec entry exceeds
+	 * `MAX_IO_SIZE`. If there's any entry that does exceed this limit
+	 * we'll pass all entries up to it to `writev()`, and then process the
+	 * exceeding entry via a call to `xwrite()`.
+	 */
+	for (i = 0; i < iovcnt; i++)
+		if (iov[i].iov_len > MAX_IO_SIZE)
+			break;
+	if (i < iovcnt) {
+		/*
+		 * The first entry exceeds MAX_IO_SIZE, so we pass it to
+		 * xwrite, which knows to handle his case.
+		 */
+		if (!i)
+			return xwrite(fd, iov->iov_base, iov->iov_len);
+		iovcnt = i;
+	}
+
+	bytes_written = writev(fd, iov, iovcnt);
+	if (!bytes_written) {
+		errno = ENOSPC;
+		return -1;
+	}
+
+	return bytes_written;
+}
+
 ssize_t writev_in_full(int fd, struct iovec *iov, int iovcnt)
 {
 	ssize_t total_written = 0;
 
 	while (iovcnt) {
-		ssize_t bytes_written = writev(fd, iov, iovcnt);
-		if (bytes_written < 0) {
+		ssize_t bytes_written = xwritev(fd, iov, iovcnt);
+		if (bytes_written <= 0) {
 			if (errno == EINTR || errno == EAGAIN)
 				continue;
 			return -1;
 		}
-		if (!bytes_written) {
-			errno = ENOSPC;
-			return -1;
-		}
 
 		total_written += bytes_written;
 
diff --git a/wrapper.h b/wrapper.h
index 27519b32d1..a6287d7f4d 100644
--- a/wrapper.h
+++ b/wrapper.h
@@ -16,6 +16,7 @@ void *xmmap_gently(void *start, size_t length, int prot, int flags, int fd, off_
 int xopen(const char *path, int flags, ...);
 ssize_t xread(int fd, void *buf, size_t len);
 ssize_t xwrite(int fd, const void *buf, size_t len);
+ssize_t xwritev(int fd, struct iovec *iov, int iovcnt);
 ssize_t xpread(int fd, void *buf, size_t len, off_t offset);
 int xdup(int fd);
 FILE *xfopen(const char *path, const char *mode);
