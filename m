Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5367118B0F
	for <git@vger.kernel.org>; Mon, 17 Aug 2026 05:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786945153; cv=none; b=iGl5uSkfNUx4EqXETNUQ3+5bImvPMysctnFdbF4l1kNQQ4Va0HuUvo6x385Za/sQSLCwLbwsFcnWWls0VLwfBY2Xas7YGz9agqqF88oX7Vce0SL1IVB+Pwd+qvrmUuzXWpp2onWH/gkA6jQ/khXeEToPVAg2nWxsmxZYxf2I6XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786945153; c=relaxed/simple;
	bh=U9AOXzTaBB9f3Ohzf+1ku/eTuXbLcE+obYvYDq8Rxyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bv57QutXXTbx4gYCwHzeQt2dvdM7gcuR08dnXLblb5Qi8qxG4szlY5BSPBB844aYmqkQwHR833xPP3TCO4ojHzj6zWS9gF6/GB0Y8agfV/feHtIUhaOsbcaxwvJzsPG9QS9lV2ezubsxpmlCi93zHk0G1Zj+siG5eja/x+CtYCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=h5hll0RP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gsFoivuj; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="h5hll0RP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gsFoivuj"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 632671D00137;
	Mon, 17 Aug 2026 01:39:11 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Mon, 17 Aug 2026 01:39:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1786945151; x=1787031551; bh=MBR3pE5VWS
	P0SpWYpW+ZNU22KrzXVnDYKBhC6WW4h+A=; b=h5hll0RPQPMwgqtpF/BknyFGf5
	ZsWR1sRuQYqpB/sDXlJWRnUaSTx3mzjsEd0RAJTsw1GbA0rstoNDbXE7MqSXcJiu
	sl+Z8xdZoiQOzc9abtPSN8Mzdyr8qxEpLVeewusV5911Kgo7feWqOGwQUr4qufWU
	Kbd9josmybBC9N5MVQwQcXo+xgVZndHqqJps5mIO63mKZYKiEOwnMfC4KEKFjJme
	nOJ8CCcioTOAh93oJ0YN0hPn21HyQSlKqP2FehQgE2FH1830gE9+bAJPbquAhJNS
	/KDE3098dDFQeSZbybJL6ci6OVDUmPfe2MpL1rRIhuaKFn5gOIf1b5izQU/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786945151; x=1787031551; bh=MBR3pE5VWSP0SpWYpW+ZNU22KrzXVnDYKBh
	C6WW4h+A=; b=gsFoivujJNTURwgNVgJpXPN6uOR0wAbabA3aYzOhl4YJ50oQ7aO
	ZELlxG5Dsv2eML3isTQb1dWyqyfzlLomRu4JbU1GWNDy0J2cb5Gg/7cm33pZCejs
	cArLqukhyP68Ysun2fPf2glFwgfbUiHxaQ4dSYpVDscl7XPdEFAZVg4QkZnzSsPW
	RpgorPWPwm3MIeOJPlna1tsDFxH1MHQNyxEoVWEn9qGTf+8VS6SSa8hBvFnpHDAJ
	qfI84hmOwJvBaxskaE5bEQxTa+XKC+yc3puBbclTxUFAAKoJs4Wl4cn1IE1EKFvk
	z5yWvLxWAgQ97IX2huYC0pswx5PiLqblaLA==
X-ME-Sender: <xms:f56CaqM-qwyhEjo0izlXkAgHkhMlUhtYC10UaN8wnMgljs7m-Lal7A>
    <xme:f56CagYVRgm9JkOpx7hSAzPlR-2uPM5LYn_Mk89rlPHxxRwPb9WaJg3NTSi10GcmA
    K7ebqa3kbqX_uYBxlUKJirHZXhbs0WQkmHMc0iO_5k7UCFQZVOEIVI>
X-ME-Received: <xmr:f56CaupfwLMV558-ZEUW_rKCB8_tYjyyVVkA3BAKh-ql2O8_LcC_LgptSbliRNf442Yx0zGp0f4DrWeiNvY1vaCxO62qC2av35-eN76tAQ>
X-ME-Proxy-Cause: dmFkZTFOImVcbUGHdsJ6x/mNXOVHR9aV0ZIVTuUz5eL0QWvq5d6DOU1g+rTifeQr9DNBXr
    Z9eQRPaFUEY5m6Wx15eGkGYruzlqUqkVT6kKggRWuBtJSJ8GydgXN5WjZcvA0tntaRddgo
    mfCf93X49IPZFZ1qQPLwcy7/qVUPjQsmQyTi88bCULxNLWQL4mtfk/nMZI79OB5dJyJSYx
    aC0t//g3tMjS8o2N5nNtzNDegMmBYO91ZNnGCHj7z4DbXAkuXWZfHn/cVpTbOUMXULNzrC
    ye6Kdryz5g5yXCKap+H/nyg7RbUjTc7WGU8l2xSusrIuxVjOR/+gQkB+aiQmn+zWduV3IO
    Hoxvh/8+tSjeKCXaug6NIGJ92hhC6pz8ij94WwJeTMvLKD12o7liUh/jgLXeVrlhRufzoW
    EemzUHbg7lglPCdJC82I5jt1n7txc6bHGxn/D6Rwmmzb5W6+Hcku3FRU0uB1jk5V3iF7/v
    wQwWQyvf30/p0cu7KcFP2z4ph4LqRQqqg24jTt78RwAmjX0tUlFMfSodQ3m+IyXE2hqOxz
    ePeLvJdTPy7M3rpBe7eO9SmY7Cl5JIJ0Rq56BQX3muhBd1GNeNgYUW03MdV5SjrbdoIIrR
    7kAEx8/lP/pZNjrWNaLoJXq7V8AuJrSMsIH0S6OrxE0B7dvHOxgUtanK23bQ
X-ME-Proxy: <xmx:f56CakaWl58JiSrDCcJQkbUlipZqaUvtTTxl7UDnC7c1c0SaUTK_zg>
    <xmx:f56CamRbd8vv4si67ddZGyHwzhCCXqUmttc7d4VE_XZJ6B22wlRlEA>
    <xmx:f56Car5Cr-BhjIoOfmLnBl15h_0AKrbHvoDwk7Gvi-dbPCm3cobHFg>
    <xmx:f56CarwokdnQYbHsSawrdRKMBOHp4EW0TcQ3AVEJk0bD5bW2S6GvPQ>
    <xmx:f56CakHFT5ZVWLKXcmQjqKGw7UiljfTEgcfuTn3bo9h8pCKvPOIyzDS4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Aug 2026 01:39:10 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7ed76c45 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 17 Aug 2026 05:39:09 +0000 (UTC)
Date: Mon, 17 Aug 2026 07:39:05 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 1/4] odb: decouple source path comparisons from
 `the_repository`
Message-ID: <aoKeeQMps50rjhWi@pks.im>
References: <20260812-pks-odb-eagerly-prepare-alternates-v2-0-522b9a5bc1ea@pks.im>
 <20260812-pks-odb-eagerly-prepare-alternates-v2-1-522b9a5bc1ea@pks.im>
 <20260814171724.GB2563235@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814171724.GB2563235@coredump.intra.peff.net>

On Fri, Aug 14, 2026 at 01:17:24PM -0400, Jeff King wrote:
> On Wed, Aug 12, 2026 at 11:13:57AM +0200, Patrick Steinhardt wrote:
> 
> > When registering alternates we deduplicate object database sources by
> > their path so that the same source won't be added twice. Ever since
> > cf2dc1c238 (speed up alt_odb_usable() with many alternates, 2021-07-07)
> > this duplicate check is backed by a map keyed by the source's path,
> > using `fspathhash()` and `fspatheq()` as hash and equality functions,
> > respectively.
> > 
> > These functions are problematic in this context for two reasons:
> > 
> >   - They implicitly depend on `the_repository` instead of the
> >     repository that owns the object database.
> 
> I'm not even sure that using core.ignorecase here is strictly correct.
> It is a property of the containing repository, and the filesystem in
> which it's stored. But there is no guarantee that the alternate
> directories are in the same repository, or even the same filesystem!
> 
> So it is really just a best guess proxy for "this system tends to use or
> not use case insensitive filesystems[1]". It can be wrong in both
> directions (failing to suppress duplicates, and suppressing them when
> they are not actually duplicates).
> 
> I wonder how bad it would be if we just always did case-sensitive
> comparisons and made it the caller's responsibility to spell things
> consistently.  I guess some names ultimately come from things like
> "--reference" command-line arguments, so that would depend on user
> spelling. But having duplicates at all is kind of unlikely (you can't
> get it from one --reference clone, but rather a complex tree of
> interwoven repos with shared roots).
> 
> How bad is a duplicate alternate? It's a minor performance issue, I'd
> think. We would add its packs to the list (though hardly ever look
> through them, as the "first" copy would satisfy most requests, and the
> unused second copies end up at the back of the MRU list). You'd only pay
> the extra lookup cost for an object which we fail to find entirely,
> which is rare-ish (mostly speculative lookups for fetches).

A performance regression is definitely the most likely change in
behaviour we might see because of this. One other part I am a bit
worried about is housekeeping, but I think we should be fine there as we
only consider the primary source as special.

I also had the feeling that case insensitivity is quite a bit lacking,
too. What we're really after is whether two directories are actually the
exact same path. And whether the path is case-insensitive is only one
part of that equation, so it's an imperfect metric by itself already.

Ideally, we should probably use realpath(3p) to at least also resolve
symlinks. Unfortunately, it's not guaranteed that this function also
knows to canonicalize casing.

> And it would fix the unlikely-but-possible opposite case of suppressing
> a non-duplicate. If you have a repo on a case-insensitive filesystem
> with two alternates on a case-sensitive system that differ only in case,
> we erroneously suppress one of them, and commands may fail to find
> objects we should have. Of course that's super unlikely, which is why
> nobody has run into it before.
> 
> So I kind of wonder if we could just do away with considering case
> insensitivity here at all. We'd err on the side of correctness in the
> ambiguous cases, and this code complexity can just go away.

You will of course be able to craft edge cases where that would be a
significant regression. But if your alternates file looks like this you
may be holding it wrong:

    /path/to/alternate
    /PATH/TO/ALTERNATE
    /pAtH/tO/aLtErNaTe
    /PaTh/To/AlTeRnAtE

> Alternatively, I think we could probably make the check more thorough in
> a similar way. Always consider a pair of case-insensitive matches as
> possible duplicates, and then for each possible duplicate use stat() to
> check their st_dev and st_ino values. That keeps things cheap for normal
> cases, and we pay only the stat() before de-duping. It's correct and
> doesn't rely on the repo, though it is a bit more somewhat complicated
> code.

Hm. Weren't there filesystems where `st_ino` and `st_dev` aren't set at
all? I think that's the case on Windows, which is unfortunately also the
one where we see case insensitive filesystems by default. So that makes
it way less effective, as it only works on systems where we typically
aren't case-insensitive in the first place (except macOS maybe).

So if we want to go down this path I'm inclined to just unconditionally
use case sensitive matching and not introduce any secondary machinery.

Patrick
