Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B3B366564
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 12:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772453535; cv=none; b=mW9SXsrfQicT+KDSFj6Eqe8V5Zwp5QxBd2FXW2H4dy0ogWLcTIQVmkCS18AaCPmeh7X1Ngl/NleslqXDLOddcnPZu9gUjOhhTrydX2IEBj332eRPIv0x0iucUctu+tskvIVLBzKRsRql4paKuWQhhDOFdx2PseRJ5l4ChjkOa/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772453535; c=relaxed/simple;
	bh=V5TfQj5PcqOVOg9ZFaBY3ptTe/RVJmTkhnC4fp6P2EA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C3uf7/u5eiZjlVSeauC3V69t85diK9nCUphnIaAxpvwt50LpCQNJB534c10nb+NFLWYvlR3uEVSfv8LPhaw1kgePwoXLpAX/An+c32MhYBDvBCFIjjQhc+iD9VLIQPYx0EB/diYZLZkz0rwwZ/TjCZTdzuh2R3qmdSElyAzzwmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PyIXUCFs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EADvfdRm; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PyIXUCFs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EADvfdRm"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id AD08A1D00224;
	Mon,  2 Mar 2026 07:12:13 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 02 Mar 2026 07:12:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1772453533; x=1772539933; bh=jcN0jg4dya
	h2dwhFZ0th45jBq5HWIK6gWM8Sid97tXw=; b=PyIXUCFsTsHpKNUJxhL8Y3kyUC
	pc2hXdHo61SaiOiEFlZIdLby8Z5QGmXoh/7gvJTnVDwAt781Hjo0O/dnMMz5J82F
	jv7zs1sg+uEwwxf1NQZ3LK2YRVmkrS5DFk1hYeVVvsFXThNR13JHHbZ0QQWc7cd7
	SY85BykV7dyV02IrtkDE759I7F8hlaDyIvfNFVf8k4az3SOI4N7F8zR4M8/x7ril
	OZXy6q/tRBO22mWHLj8h7zPIL/2a5JfK7/+CgcvhppKubku3lhn2uqOy5H7WbIht
	a6y0q0+0TMwJjdEtreCUMW/1/aAR1i+SkM/ZWdYipZXY6LTcbZ8g623mABuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772453533; x=1772539933; bh=jcN0jg4dyah2dwhFZ0th45jBq5HWIK6gWM8
	Sid97tXw=; b=EADvfdRmvOVLwBrjMEUFnl/FqRprQm/A0GuEk2jgtcZiElA86JA
	cepaI9f7ZMQbltosWPAK8GUUn2JFlUyK5Zrc1T5CPEj24yfhjvAw30A5mEQ7sSX0
	Kbp+PvFlurPzYmfcbICM6cekyLUonKed53wZBKStra8Cz5aIxVvhKZOGWFE7i3ol
	uOheBnMA4rvyO6clcOXHgTjg9EeDJqempUTYDNChUAwCWmzbcizEyg/r1ji+Opr2
	Mt3C+vaMZM05jtxWz6Pfjt7ku9h+AxP1KsfLjJ5Z+P/ZHrWDxjKVLXxeGbmQZtZG
	Hrjdz6DGU0gsF/0Y/fshT+D65cVa9njSoDA==
X-ME-Sender: <xms:nX6lafmajq8qUiTsmZwoedLNxaAhusgqvepX-t4d1eyn3GPXcSHhDA>
    <xme:nX6laZuYrMV4-RSXDF5hhjr3qCh3aNY9hGNJowMqtK4L4YPFFlhvmfVRbZoYKMasQ
    pz_iFMCMxPuERXrw99egDvJWAdbf_ARkiDf-ZGmaXr78LVBvdTylGw>
X-ME-Received: <xmr:nX6lad_OjvcxKUvHFnyQAFYNT8V6xktnOgi0I36v20djx8CxbXc6cTj0FCJT2eUFuG2Cr-BSek9ud4Wo-ZbEnw-ViqLGCgb524lIFvy9rA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheejieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epfeefhfefhedugeehgfduudfgleelfedtueehgeekvdefudehvdeiffetgefgfeelnecu
    ffhomhgrihhnpehprggtkhhosghjvggtthhshhhoohhkrdhsohenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggp
    rhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsrghnuggrlh
    hssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehmshhmihhl
    vgihsehgihhtlhgrsgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphht
    thhopehpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:nX6laTOZ31LY4bw3kBJSE6AUHbFCI0VSYzQFwnglyAUb24PYlvlmFA>
    <xmx:nX6labHJ8dYrHe8_ItCr9M0SgDqxSbm_djvLJx0lpyvIejgxaOnRkA>
    <xmx:nX6laRRAUDH_U9uSdo7oVPEgEVdCaBO8Uwvxh13-DuyHZoojLyVPRA>
    <xmx:nX6laYuIZtl1z0bIOSvOyLnCbjH-EJBan4o45jCuqkPHkRqDqt5DPw>
    <xmx:nX6laXj2Xp9hruuufLfGGu1B0TUMbej5nlhaSJRQYAif8N6IIwXJ5S2G>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Mar 2026 07:12:12 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 120daea5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 2 Mar 2026 12:12:10 +0000 (UTC)
Date: Mon, 2 Mar 2026 13:12:07 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Matt Smiley <msmiley@gitlab.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] upload-pack: reduce lock contention when writing
 packfile data
Message-ID: <aaV-l_NyWpkKDDp6@pks.im>
References: <20260227-pks-upload-pack-write-contention-v1-0-7166fe255704@pks.im>
 <20260227-pks-upload-pack-write-contention-v1-2-7166fe255704@pks.im>
 <20260227193758.GA2931515@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227193758.GA2931515@coredump.intra.peff.net>

On Fri, Feb 27, 2026 at 02:37:58PM -0500, Jeff King wrote:
> On Fri, Feb 27, 2026 at 12:23:01PM +0100, Patrick Steinhardt wrote:
> 
> > Extend our use of the buffering infrastructure so that we soak up bytes
> > until the buffer is filled up at least 2/3rds of its capacity. The
> > change is relatively simple to implement as we already know to flush the
> > buffer in `create_pack_file()` after git-pack-objects(1) has finished.
> 
> We are relaying write() calls from pack-objects here, which is writing
> to us in 8kb chunks (due to csum-file.c buffering). So most of our
> writes will be 8k.
> 
> Rather than buffering in upload-pack, would it not be simpler to just
> increase the write size from pack-objects? Then we do not have to worry
> about disrupting upload-pack's keepalive timeouts. And as a bonus, if
> you are worried about the system-wide number of calls, you will likewise
> be reducing the number of read() and write() calls over the pipe between
> pack-objects and upload-pack.

We can do that. But we also have to keep in mind that downstream in the
pipe may be a process that's not even git-pack-objects(1) in the first
place because of "uploadpack.packObjectsHook". So maybe we should have a
look at doing both.

> > Now git-upload-pack(1) already has the infrastructure in place to buffer
> > some of the data it reads from git-pack-objects(1) before actually
> > sending it out. We only use this infrastructure in very limited ways
> > though, so we generally end up matching one read(3p) call with one
> > write(3p) call. Even worse, when the sideband is enabled we end up
> > matching one read with _two_ writes: one for the pkt-line length, and
> > one for the packfile data.
> 
> Using writev() would be an easy-ish fix here, modulo portability
> concerns (though of course it is easy to implement a fallback writev()
> in terms of write()). Doing this:

Right, I was also wondering about whether we might want to use writev(),
but I didn't have the time yet to have a deeper look. I'll have a look
at whether I can integrate your change in a platform-compatible way.

> Out of curiosity, how did you end up measuring? I first tried with
> strace (without "-f") on the upload-pack process, but strace slowed it
> enough that it ended up collecting multiple of pack-object's 8k write()
> calls in a single read() call. ;) The "perf stat" above seemed to work
> OK, though of course it's counting child processes, too.

I used strace for this. I didn't really dig into it too deep as I was
rather busy handling the havoc that this issue caused :)

I'll send a v2 soonish, thanks!

Patrick
