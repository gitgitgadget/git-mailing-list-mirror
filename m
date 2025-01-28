Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE17A59
	for <git@vger.kernel.org>; Tue, 28 Jan 2025 08:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738053348; cv=none; b=SRwjjzghzCjmZOyTkd6/YooQYYDzMUszX8FMTw/jxmToApGo5+hnz1MYIxyz8QF8ppllrJ9E1IgB6N2OBY8NyS5+2vlVLo3vXBrxUcClFoczgO6h07lzLE5Wj4OshXT0lH8Z+yktcb4uPXiW3/fmDcXhkVs6XkNv83TND9x9U8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738053348; c=relaxed/simple;
	bh=Vdkap8NDGzOXQIJUIAm0Y5rlibi3ZLAsWIBpg9hiI88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qUlrdLLPeLxseBWMV8DJj2Z2nPF7PiuH/CUshz/xjQ8wfay/CBIECIfYNObxwLdoz3qkDED+vWS8hYE0BT+VE/xICuc8ZYy2tzfDir5WqHkvZsytFJKhfy7QxraGYykEE/JVq4Re6AUdrymeqeM2iQQS8iT9hDldEccfLaud160=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NM8ci3ga; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=1AtiC+x3; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NM8ci3ga";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="1AtiC+x3"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8574C2540216;
	Tue, 28 Jan 2025 03:35:46 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 28 Jan 2025 03:35:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1738053346; x=1738139746; bh=R0tzdUKTN/
	5qRkNMZdf/rjQqgUy9OTO99ANjjg8cvrE=; b=NM8ci3ga+GC+jcgvuf1r3E7X/m
	YDVL59JakN1hJyNegeHWnvc7EcVKKsBd/MneTnzlG3pTa35mL4bK1YV0km7RAGdU
	khoWx3qTWl7qUAJ2IKWlxWXKDgyl5bEHHbDoeC9gezhKEnjoitHCvCIymG6W1/CJ
	2M8/h6sTS+gC1uL/5SdemL6cUSq4fJkA7yJaFdRfMRRWfloZZE5MSEHSTMWZaGk1
	IgyOA8rAqN8aTPWBz9w5rh9UCRryDcxw7uC2I8nxxOwaPkam7SjAiSV3NNBQp8DJ
	RPuQ8vgRXwE+QECGRajxZ6Iz5/bdpuzTjcjEJmRP4kcmoVc2a4qH0OSgsAUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738053346; x=1738139746; bh=R0tzdUKTN/5qRkNMZdf/rjQqgUy9OTO99AN
	jjg8cvrE=; b=1AtiC+x3R7eV5ZFvTzh5bY2wuvViNrAf6HYzy+nq/0oMgcbk37s
	jxvIAJ+78scRtUxlbQu2XIsBn3MYm7ufRADfw6o3eTWYnqxLpqLPT7U03UqdbcJR
	0o2OkNPyjSBtbB3QBLKseaj7jIAit8MXCdwLbHIHxRhItZDp/SkdK3g2mth7/w3+
	oJFNddKa7r77VdlfIjQUvnJYJQfv67kO0rbIdTngeVXirWALFX3qoD65VRj8eT0G
	6jIXe8rGuSjmgHNusV5oTQL02k5q/TPLvuD0/Mps+OJ2QIoktMVGz7kQ9V+T2SOy
	7dWJFdM/OeUs/UuZxrgjiH9VNs71btj3Gkg==
X-ME-Sender: <xms:4paYZ9wqBaPX_wx3bfUcooHGdOOLAiIHE6L4mS2QZUrGakGpi8d5Og>
    <xme:4paYZ9QDe6CS7r01cQG-aZnJFBWHblCeyrvx-2WE9doioxDxjIkYmqI8g5eTO2j3W
    P_xpVf37XTDDShDrA>
X-ME-Received: <xmr:4paYZ3VxoTCtAbETLJQzP-yptQi7KYG6XiWoRroRKkQJxLK6vHSh-i4j0E3sI_GSr9F7dZZj_nEoqbL6BVkPkjGzwnuEANLXu5tls4QWEVg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgudehieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhi
    hlohhrrhdrtghomh
X-ME-Proxy: <xmx:4paYZ_jYaxM0halAAtTsBX7IiW-1YnpHu2PNYpfZTH9OqrbKc6Ntsw>
    <xmx:4paYZ_D1vXpUYLkb28lBvvVPma9kNU12nQq4YstHNFb9Z2ai2Uq7Fw>
    <xmx:4paYZ4Lz_UfTESNcQCxZEQAGNrNS2v-rjVzirtJRC9LOQorPv1PExw>
    <xmx:4paYZ-ALXXo8wF74Hy7v13QPSVpxn_ItsjK18wk4HJy1q-fZ19IWQg>
    <xmx:4paYZ682sLwVEcrL7c7fecQflxVBf6yJUpPh1fLszJqNrZ1j7Xg9O_go>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Jan 2025 03:35:45 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5d9090f8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 28 Jan 2025 08:35:43 +0000 (UTC)
Date: Tue, 28 Jan 2025 09:35:42 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v3 06/10] compat/zlib: provide stubs for
 `deflateSetHeader()`
Message-ID: <Z5iW3utsn6j3lbRh@pks.im>
References: <20250116-b4-pks-compat-drop-uncompress2-v3-0-f2af1f5c4a06@pks.im>
 <20250116-b4-pks-compat-drop-uncompress2-v3-6-f2af1f5c4a06@pks.im>
 <n64enlt3wcjftyz74evkdh53romwvmnwwd4qdpfaw6jedktcvh@fdy2zmdgmqm2>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <n64enlt3wcjftyz74evkdh53romwvmnwwd4qdpfaw6jedktcvh@fdy2zmdgmqm2>

On Sun, Jan 26, 2025 at 06:56:40PM -0600, Justin Tobler wrote:
> On 25/01/16 10:17AM, Patrick Steinhardt wrote:
> > diff --git a/compat/zlib-compat.h b/compat/zlib-compat.h
> > index 96a08811a9..2690bfce41 100644
> > --- a/compat/zlib-compat.h
> > +++ b/compat/zlib-compat.h
> > @@ -7,4 +7,17 @@
> >  # define deflateBound(c,s)  ((s) + (((s) + 7) >> 3) + (((s) + 63) >> 6) + 11)
> >  #endif
> >  
> > +#if ZLIB_VERNUM < 0x1221
> > +struct gz_header_s {
> > +	int os;
> > +};
> > +
> > +static int deflateSetHeader(z_streamp strm, struct gz_header_s *head)
> > +{
> > +	(void)(strm);
> > +	(void)(head);
> > +	return Z_OK;
> > +}
> > +#endif
> > +
> >  #endif /* COMPAT_ZLIB_H */
> 
> In zlib versions under 1.2.2.1, `gz_header_s` and `deflateSetHeader()`
> are not defined. It looks like we are defining them here, but so they
> behave as a no-op where used. If I'm understanding this correctly, it
> might be nice to have a comment explaining the no-op component.

It's non-obvious why skipping the logic would be fine, so explicitly
documenting makes sense indeed.

Patrick
