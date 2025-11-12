Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5882DCC03
	for <git@vger.kernel.org>; Wed, 12 Nov 2025 06:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762930643; cv=none; b=aklwAkRTzzjljsxfKXwxUkLnZHhuRoaR4TjUo3akAw2yjzpX3erUnp1X0I1jUL4Du/dySTo7o2OZ5kR4J/C6AMxb2Se9R1T4aK1GMynAEs5dctueffwR7kXkfGN604qNd1Y7ILd960yX9I20mBI71hi0yTLI+qQ2dD4zA6PAwm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762930643; c=relaxed/simple;
	bh=XYF66bOZ7/M+oP3wuSx2TgNSjmZbx/u5kt0KCT6/Zlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c9cmd6tHf848TFVMvNzwjz2helJHVTf+6gp3yGR/EQMuD6Mub972yAaTkp3vJjYJh9TTyCsotfFYtMYAtCSsECH9ETbqJ3B7ed7eNs2T/2q3MvkZJsUFvvBlgZyj27SboiWF0K8o8tBnUc0YyRMp0/S+qlvDDJLVoe3YQKKF2Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JK+WiJnC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Vnz1o+A5; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JK+WiJnC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Vnz1o+A5"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 455317A01FB;
	Wed, 12 Nov 2025 01:57:20 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 12 Nov 2025 01:57:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1762930640; x=1763017040; bh=ehfktf9NB3
	rjzQKtRZJXcTHSGzGT0NIp/XFAXIq+i/0=; b=JK+WiJnCxPKCKZIXb2aAPXw/cv
	+4yCod3rWis8RN6CkJLOLiECwsX8i1+HbmkNZQCdM0wTgOLhtXhYMEKdrgZAuAYW
	MuivvF8LJfRhEqNU+WEmgs0+gnclIug3Kslk2GhqHUCzmE/aUpU9jNP20gozaZzr
	DHnLgYIhhS9okm+tdWpdzXakGV3Y85HtaX/QOoNyqql2G0Pzw4VBfEFrxQ1MqoHl
	/GLVuu3gbFu7SMgV8SxllMt3TkLqPadp5XaANUPRkOIm4vXQMLE2xy+DQ/SG1ZGf
	a0YKc9+V1lyflticskun4HOt/YO5Og2vs9c16bQAHfkz4Lg+rlb2BlXE7WJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762930640; x=1763017040; bh=ehfktf9NB3rjzQKtRZJXcTHSGzGT0NIp/XF
	AXIq+i/0=; b=Vnz1o+A5EXlEY88hJ82E5wnH+VxuKphZsJrtLS4jwibZ9B9SEcU
	3Ku9dSg5+6zSqK0Y+N0zp8ki2z5we5k0mJ6RJ6SGp7yqOFHB9gna6F9ub6FupsXk
	fFUbOFHD2mLyYDQ5CNzMAXGsXzyNUAoESv2bwabVcJfY8hcVUNcoS3dBiCFjheKi
	UJvv4n1Hza9W4+AD3GtIdIcPdENyMF6fUlJ0eAdYiBlllPdn19lu/w4Ys+5RK42T
	Tv+L0X27fAjOEhfy9uZThO5aBowT9fxG4YuB3o5Ip+nMUE5GKO/Na/q+iBYvcNDt
	fGmS2fnfNlQOSnpU0x2GZSTVawbXgOwe21Q==
X-ME-Sender: <xms:zy8Uabo0Y9qUDNB6nsvrxDL55G3H_Xm7Gf3XYQa9FJyw8JLKqQ9sQw>
    <xme:zy8UadGG5ra5V36yA2B1-Lbz1ZmajRVUH3g4l03qnjeLDk1u4zrCPmeGwIebPT1Vj
    RBw2-jXW5Qt5m9P5T5u776kBRvSChgDeWWuCdTw1TMiUH8o4y1TrA>
X-ME-Received: <xmr:zy8UaVk1cbhhqFvVfkUZE4KcysTeZpAeLIJol_yrDRN6LWLcqFYvmJ9TUkJd3BfEeufH0pGVHpY02HWUzzBtyZPqW7MMBCTzxG1IboGtDCs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdefgedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepsggvnhhsthgrvhesmhhighhgohdrihhopdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:zy8UaYkw-IIfR7gvggtdDHV3vKgoreGy0jyFvionJ3RTfs8X3YKhsw>
    <xmx:zy8Uaes79bV5PoPZRWyDHbOIpuLALj1fiX03OreMXLfOHXpnOISziQ>
    <xmx:zy8UaTkmdd769_1cWrlame9qt-nKI_1HXAMh3_Uq1jvuiBbq_6V8Yg>
    <xmx:zy8UaRuGlxAzgsfjDinHH7jUsK5PiqsAHUOZhq-gOZeVhNnkZBPNlw>
    <xmx:0C8UaRxQFeryhkSWyoOGCAKzi22wZPtI0rFYPH0L9rHWwJfPfoLtwNQM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Nov 2025 01:57:19 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bcc0e679 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 12 Nov 2025 06:57:17 +0000 (UTC)
Date: Wed, 12 Nov 2025 07:57:14 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Ben Stav <benstav@miggo.io>
Subject: Re: [PATCH] attr: avoid recursion when expanding attribute macros
Message-ID: <aRQvyvMq61syGT7_@pks.im>
References: <20251111223647.GA4055973@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111223647.GA4055973@coredump.intra.peff.net>

On Tue, Nov 11, 2025 at 05:36:47PM -0500, Jeff King wrote:
> Given a set of attribute macros like:
> 
>    [attr]a1 a2
>    [attr]a2 a3
>    ...
>    [attr]a300000 -text
>    file a1
> 
> expanding the attributes for "file" requires expanding "a1" to "a2",
> "a2" to "a3", and so on until hitting a non-macro expansion ("-text", in
> this case). We implement this via recursion: fill_one() calls
> macroexpand_one(), which then recurses back to fill_one(). As a result,
> very deep macro chains like the one above can run out of stack space and
> cause us to segfault.
> 
> The required stack space is fairly small; I needed on the order of
> 200,000 entries to get a segfault on Linux. So it's unlikely anybody
> would hit this accidentally, leaving only malicious inputs. There you
> can easily construct a repo which will segfault on clone (we look at
> attributes during the checkout step, but you'd see the same trying to do
> other operations, like diff in a bare repo). It's mostly harmless, since
> anybody constructing such a repo is only preventing victims from cloning
> their evil garbage, but it could be a nuisance for hosting sites.
> 
> One option to prevent this is to limit the depth of recursion we'll
> allow. This is conceptually easy to implement, but it raises other
> questions: what should the limit be, and do we need a configuration knob
> for it?

That's fair, and as you demonstrate it's easy enough to turn recursion
into iteration. But it doesn't really solve the main problem: given
malicious input we'd now still crash eventually, even though we
ourselves control how exactly we crash. The main difference is that with
iteration it'll both:

  - take longer for us to crash

  - require way more memory along the way

So the evil garbage would continue to be a nuisance for users who want
to clone such a repository, but now it's going to be more of a nuisance
for hosting sites given that it could lead to out-of-memory situations.

I guess the reasoning here is that for this to become a real problem the
".gitattributes" file would need to be excessively huge. We're probably
talking about many millions or even billions of attributes before this
could cause an OOM situation. And such a file would be large enough to
bust the typical limits that the likes of GitHub and GitLab have in
place, so Git hosters already protect themselves against this crafted
input, even if only indirectly so.

The other angle is of course the wasted compute that an adversary can
cause. But I don't really mind that too much: there's enough benign
operations that require a bunch of compute, so I don't really see a
reason why one would need to craft a "compute waster" with malicious
input.

So personally I would've probably leaned into the direction of enforcing
a hard limit. I don't see a reason why anybody would need more than a
couple of recursions, it culls both compute and memory growth, and it
allows us to have a proper error message in case the limit is busted.
Furthermore, we can demonstrate right now that it wasn't possible to
have unlimited recursion anyway, which makes it easier to put a new
limit into place.

But following my above reasoning I think it's okay to turn this into
iteration, as well, though, but I'd like to hear whether my train of
thought matches yours.

Thanks!

Patrick
