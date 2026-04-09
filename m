Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C1C34CFCF
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 16:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775752967; cv=none; b=ntv/4lVbXH2avVhqtEqs3T8L+5ObwRDIp0fpKAGsYJ3HyWGFsmIa9vrTDLyDZaaN/wvACPA0AzFZ3+aSIIRaLooFWfiN3zc3nfRI/YBVAhRLQGK3qJwizMdVItL9QHW2aa37T7TAzxj7ySYcvNtnITUktcZOJRzQgqFUWcEv0zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775752967; c=relaxed/simple;
	bh=oH94DfMB8CkoQUf1tcfUgxmrdZMnbzKuWYDONWH68Ds=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gCUulcp5+sPB73isoyUjClhgdabfhKKa4QS4hXI8V7jxTx7+TOOBvcaZQ6/7B2gYvjUi8c50omamTlmaXkWXFE1Jr/VSRjLQZ4B3sQWntGdGPFnx5+bV+ZYwUM/c2ridt520n5ZZvGMI8ANmdqeVnkCeGDd2b7+CInDpVfn/8xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=q6F/+g2B; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Hfj3udpP; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="q6F/+g2B";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Hfj3udpP"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 14C48EC01CF;
	Thu,  9 Apr 2026 12:42:45 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Thu, 09 Apr 2026 12:42:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775752965; x=1775839365; bh=SBEWmzlK2Q
	PhmFcCVOw2qNAFQfP4IjfQmN//V49cRXA=; b=q6F/+g2BSrb8IBI+CHYBfhao7F
	YX59oMfvqKnfhVkANamM1GieySIrSyAscKV4HPycQXzf6xjCtJV3kIL5htIBod14
	Hoh/4AdgEXCrf2y/2K2WJlDfmnE4d8T27SWyy1N1cEc43Ucty1+z4zfff5y5Wjjq
	L0y0Tb3qOWVEP++acshxOGohNyUPTiz2lx4nRZbEQAaoDSPZVbcyFHAS5F/3sZ8s
	Ch2Vw211bqrRRnNOwKepO3McwplxIawolYl3/phkHBhgvjC/CnwVF8aaTxmkpJUI
	UaVwJLPQmmT5t/x+jus/QLUIz9mxSLMJftlzKvRRCnmh0TSoctH54v35aWEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775752965; x=1775839365; bh=SBEWmzlK2QPhmFcCVOw2qNAFQfP4IjfQmN/
	/V49cRXA=; b=Hfj3udpP4F7R2aBWiPej51kPTDPGIL0MLHkPC26ldPGSAE+PgS3
	iUAXB2IxTvrK1OY0yWUDgqVrYMMKxK3F0QgYEpIb+/80SV5n21rv2oE0n9uU7SJD
	/gZBIPIoVETItKz8q9xLwf29UBXk+6s3ZoRo2PM0VZiHuwzjtaqcrhikzg86ahsg
	zk2GxYEQ2NQ95PPpQ/BXXZNm34bJStEtMvm0xgeR1+4S1Et/hCx7CLE+imfgbHIc
	pc8njFer4+wJaq7H+yCk3lFmOqeh60gAuWH7gdq9f4TwrnViT8o+vO0CrlwROycr
	uHuv3sCXorpKHpw50D7tV5Rpv2J31KtEh0w==
X-ME-Sender: <xms:BNfXaZOU2kLAIL37CAlEtZAaalsndebqboH0nUSOfHv71VQzUgoYUg>
    <xme:BNfXacrCwNjnkpO-70-2mQiEYf511qBweML-ewulfAhwjP4Zo0PhwERglTfnjLe0D
    wVDNe1HlWoAz8G_SmvKUVozGJWvdPqj-kIyguzzCu8ruizfz7XyTA>
X-ME-Received: <xmr:BNfXaWdAAX-fwF_eemGqvsDfDCJ87jKDiqfepvt50JteKCFWyWx6amL7iMxYzHa1iZp89iga5x_Tx_uESL8CPPJsAN0RiioziQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvjedttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeetgffgvedvheehuedthfeljeevteefleelkeetueefgfekjedvgeefheehvdeg
    udenucffohhmrghinhepohhpvghnghhrohhuphdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgt
    ohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepshgrnhgurg
    hlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtoheprhgrnhgu
    rghllhdrsggvtghkvghrsehnvgigsghrihgughgvrdgtrgdprhgtphhtthhopehphhhilh
    hlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:BNfXaaRVpjbBskBs_JuMmfIhaF9_CV_61J9AAKkCHLYCWX-wo598Mg>
    <xmx:BNfXaXYqzlTU5wYdcrLQBLORB811hNy4kF8FXZKsGmiZq_HI4zULMA>
    <xmx:BNfXaVcTH10jvmLjgIxbD7v9UiezuE4CaJSObenFvcGV4anOdNl6bA>
    <xmx:BNfXaQIkXGtqy0ZleLb1ynZrl8an4By8hX4xbqXTO-cyxFGW2qHA9w>
    <xmx:BdfXacXtG-cZWIbDbGOJ2wo_TDTI1W9LyGKm7FeJgSRoOHSYfazSH4GQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Apr 2026 12:42:43 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  "brian m. carlson"
 <sandals@crustytoothpaste.net>,  "Randall S. Becker"
 <randall.becker@nexbridge.ca>,  Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] wrapper: properly handle MAX_IO_SIZE in `write_in_full()`
In-Reply-To: <20260409-b4-pks-writev-max-io-size-v1-1-81730e8f35df@pks.im>
	(Patrick Steinhardt's message of "Thu, 09 Apr 2026 14:47:59 +0200")
References: <20260409-b4-pks-writev-max-io-size-v1-1-81730e8f35df@pks.im>
Date: Thu, 09 Apr 2026 09:42:42 -0700
Message-ID: <xmqqika0ultp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Some systems like NonStop set a comparatively small `MAX_IO_SIZE`, which
> limits the maximum number of bytes we're allowed to write in a single
> call. We already handle this limit properly in `xwrite()`, but we have
> recently introduced wrappers for writev(3p) where we don't. This will
> cause the syscall to return EINVAL in case somebody passes an iovec
> entry to writev(3p) that is larger than `MAX_IO_SIZE`.
>
> Introduce a new function `xwritev()` that is similar to `xwrite()` in
> that it handles such platform-specific nuances. The logic is rather
> simple: we simply coalesce all iovecs that don't exceed `MAX_IO_SIZE`
> and pass those to writev(3p). If the first iovec already exceeds the
> limit, we'll instead pass it to `xwrite()`, which handles the limit for
> us.

OK, so the idea is just like xwrite(), whose original purpose was to
hide the details of having to restart write() system call, pretends
a short write on IO limited platforms, xwritev() pretends that the
underlying writev() gave a short write, instead of a failure with
EINVAL when ssize_t is unusually small.  That mirrors an established
pattern that is proven to work with write_in_full() code path, which
is a good thing.

By the way, I see that EINTR and EWOULDBLOCK are handled somewhat
differently from how xwrite() handles it.  As the original change
that introduced use of writev() were to replace write_in_full() that
eventually called into xwrite(), shouldn't we be closer to what
xwrite() used to do?

> this fixes the issue reported by Randall in [1].
>
> I mostly wanted to get this patch out there so that we can discuss a
> proposed fix, but as said in the thread I'm also happy to revise course
> and instead set NO_WRITEV on NonStop for now. I think we'll want to
> eventually land a fix like the one proposed here though, and at that
> point the workaround would not be required anymore.

It is too late to make this kind of "let's wrap writev()" effort
before the final, and Git 2.54 should ship without any such change.
If your platform does not have a writev() that works with write size
up to half of maximum of size_t (or at least 64kB), use NO_WRITEV to
build your Git.

But let's discuss to prepare for an update post release.

It would be nice to see minority platforms including NonStop test
and notice problems that appear only on their system much earlier in
the cycle next time.  A report at -rc0, while better than not seeing
any, is a bit too late.

> diff --git a/wrapper.c b/wrapper.c
> index be8fa575e6..d989c78b4b 100644
> --- a/wrapper.c
> +++ b/wrapper.c
> @@ -323,21 +323,60 @@ ssize_t write_in_full(int fd, const void *buf, size_t count)
>  	return total;
>  }
>  
> +ssize_t xwritev(int fd, struct iovec *iov, int iovcnt)
> +{
> +	ssize_t bytes_written;
> +	size_t total_length;
> +	int i;
> +
> +	/*
> +	 * We need to make sure that writev(3p) call does not write more than
> +	 * `MAX_IO_SIZE` many bytes. If we do exceed that limit, we only pass
> +	 * those iovecs to writev(3p) that sum up to less than the limit.
> +	 *
> +	 * If on the other hand the first iovec entry already exceeds this
> +	 * limit we'll instead use xwrite() to write it, which knows to handle
> +	 * `MAX_IO_SIZE` for us.
> +	 */
> +	for (i = 0, total_length = 0; i < iovcnt; i++) {
> +		if (unsigned_add_overflows(total_length, iov[i].iov_len))
> +			break;

We add .iov_len up in this first loop, because we do not want to
bust writev(3p)'s limit.

	EINVAL The sum of the iov_len values in the iov array would
              overflow an ssize_t.

cf. https://pubs.opengroup.org/onlinepubs/9799919799/functions/writev.html

As the width of ssize_t in bits can be a lot smaller than size_t,
the above "unsigned_add_overflows() triggers way too late for the
check to matter, no?

> +		total_length += iov[i].iov_len;

Then we have total_length computed.

> +		if (total_length > MAX_IO_SIZE)
> +			break;

And it is capped to MAX_IO_SIZE, which is set way lower than
SSIZE_MAX even on mainstream platforms (8MB, IIRC).  This does not
matter only because we are currently using writev() only for
sideband communication and its payload is limited to 64kB, but if a
caller gave us a list of buffers whose total size ranges in a few
hundred megabytes (e.g., packfiles to clone a small project like
git.git itself), on a not-so-I/O-limited platform, do we still want
to chomp the original request into multiple writev(3p) system calls?

I personally think it is an OK thing to do, simply because we also
chomp a large xwrite() request into chunks and make multiple
write(2) system calls, but we should explain the reason behind "We
need to make sure" in the beginning of the above comment well--the
current text has no explanation on the reason.


> +	}
> +
> +	if (i < iovcnt) {
> +		/*
> +		 * The first entry exceeds MAX_IO_SIZE, so we pass it to
> +		 * xwrite, which knows to handle this case.
> +		 */
> +		if (!i)
> +			return xwrite(fd, iov->iov_base, iov->iov_len);

Ben has a similar comment, but it would be easier to see the
correspondence if you rephrase the comment perhaps like

		/*
                 * If the first buffer is larger than MAX_IO_SIZE,
                 * let xwrite() deal with it.
                 */

xwrite() can return a short write, but the caller is counting how
many bytes among what it passed to xwritev() are consumed by each
call to this function, so the next call we may be seeing may have
iov->iov_base pointing into the buffer we threw at xwrite() with
reduced iov->iov_len, and that is expected and everything will even
out.  Quite nice.

> +		iovcnt = i;

And if our iov[0].iov_len is smaller than MAX_IO_SIZE, then i would
be at least 1 here and shows the index in iov[] array that busts the
limit.  IOW, we know iov[0]..iov[i-1] (inclusive) can be written
without busting MAX_IO_SIZE in one go.  So se reduce iovcnt down to
that number here, in preparation for the next call.

> +	}

By the way, if the total of iov[] is reaonably small, then the
initial loop runs to the end of it, the above if() statement will be
skipped, and iovcnt is not reduced.

Either way, we now pass the initial part (which may be the entirety)
of iov[] up to iovcnt to writev().

> +	bytes_written = writev(fd, iov, iovcnt);
> +	if (!bytes_written) {
> +		errno = ENOSPC;
> +		return -1;
> +	}
> +
> +	return bytes_written;
> +}

OK.  So except for "is unsigned_add_overflows() doing what we want?"
question, I think the above is reasonable.

If we used "let's make sure sum of iov[].iov_len does not overflow
an ssize_t" at the beginning of the loop, it does change the
contract between the callers and this function, as they can no
longer get EINVAL due to such overflow (instead this function will
chomp the request into smaller pieces, just like MAX_IO_SIZE is used
here).  And I think that is a reasonable semantics.

>  ssize_t writev_in_full(int fd, struct iovec *iov, int iovcnt)
>  {
>  	ssize_t total_written = 0;
>  
>  	while (iovcnt) {
> -		ssize_t bytes_written = writev(fd, iov, iovcnt);
> -		if (bytes_written < 0) {
> +		ssize_t bytes_written = xwritev(fd, iov, iovcnt);
> +		if (bytes_written <= 0) {
>  			if (errno == EINTR || errno == EAGAIN)
>  				continue;

I am not sure if this is how we want to handle EINTR, given
especially that xwritev() may have called xwrite() under the hood in
some case but not in others.  If we are doing anything to these
signals, I think it should be done where we call underlying writev(),
and we should be close to whatever is done in xwrite() where it
calls write().

>  			return -1;
>  		}
> -		if (!bytes_written) {
> -			errno = ENOSPC;
> -			return -1;
> -		}

On the other hand, I think moving this into xwritev() is a mistake.
We shoudl try to be as close to what these functions are replacing
(i.e. write_in_full and xwrite combo) in the code paths that are
rewritten to use them.
