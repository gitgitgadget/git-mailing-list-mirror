Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A6F1581F0
	for <git@vger.kernel.org>; Mon,  6 Jan 2025 07:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736150220; cv=none; b=JIsiOxXKi614u1xdparOAzC6zHJSlIVLJxhlQzKWBKJKa2gEN0X1Z9LlL1NFmCbkHkpgBAzUUG9LVuyRXIG5IsHjI8AcERRc8Jh0f0wmg8Wu+xUZ9/BoZMr4WBG9Xx6d5OVLRV8F5VYTe6CaYvPbH7JOVw5dYQwL/YwvV1nRkwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736150220; c=relaxed/simple;
	bh=aLbF/j8689UeIFi4vXl96MvdlSw10LFboh4z2G/xjyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T9fQCg4Gm395PD8UvL6wn1jblHWP4vPFzo1Wlcyg+ondYF2gcrT/U7RX9VhXCf+SVNFZIy0N/mSqv2DzBksR9w9Q/htfTD4ftCITORyHw7zFrGyfALBqCHuHNxrxZHa873aAuuejOnjzU2qjre4RVrsWYfYJ9vVZONkSXJRrvWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=tbIPB/Tq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WUrNoMRy; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tbIPB/Tq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WUrNoMRy"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 27AAC114010A;
	Mon,  6 Jan 2025 02:56:58 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 06 Jan 2025 02:56:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1736150218; x=1736236618; bh=Hk9yz5l4fk
	t4Xr8duzs77e2rULLQbFhBK+CULxvlI+o=; b=tbIPB/TqnPaY11mbCynNnaF5BN
	u5dGi2Z952w7rqk1hUYKAR35KbW79ayWYrYQ4E5nlIP20VhuptQZdxZCSjtKCElN
	RCZ1JoRF1JT31wvVXSwue35ACh42hM7yimj5MOqR16rx7lChkOM+AKiPfgeNhveZ
	ILn/HibWufM1NUVjw8s6vnCiDQlv+f6vNeNJrGSKcHbkK9IiBVTAPnkOP0132DCw
	mxK5QsjIWNNrx20cmd0tSQGmHxt8MfaiEbE3spPbqYfuQiGielX1heMwHNFHjA0i
	gvhHiruR5FXgLjHvY9+HHtqER/Ek6xSpAzjWSdvln9lHMMdYrlLkBVmtzhWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736150218; x=1736236618; bh=Hk9yz5l4fkt4Xr8duzs77e2rULLQbFhBK+C
	ULxvlI+o=; b=WUrNoMRyPIx9x7F49vjZqoDKFPCtxtpfjyGDO3Ns+mvveXZG2SE
	cQTycN/t/nPq5vy0C0TmEkC03N8j4lxyomedotcpCTDpTtWsVTTSInQoa0VZ14b3
	vIMOxjMeXKuUYDChTAmsgAWL61n9rHbIZ+8s3PGHyUwD2s8k0CF4Mh8RrwSSu/1z
	c0pCXwZExpCZh/tSSIuSE/pfBk2Y8UTZ9fj5g0z+S2Vrhh1fe0gbrK5RRjWRcPnL
	TiCCbqAByPr4aAosV6E0vJEbVN34rjn2Wgje6V9V4eDO6ZtIQQ9Hw7JW1nQZIK/z
	VVjKtWDZotY8EGze93l/zUpltmjQScnkjEw==
X-ME-Sender: <xms:yYx7Zx6FjtUQBdU2WZ7asJacBJZ-IwWPPsioJT9HqTg3ZGnKvvBCHA>
    <xme:yYx7Z-695fw0OS7wnJlqaANwzThstgufmrWyJjO22Pz624Jd1ADhQ5LCtj5ZjLscd
    eGgwweLOs14gGSL-w>
X-ME-Received: <xmr:yYx7Z4cKPon6210tZbbOMgEO6cLGlXgIzutlPzB07IkUxaiJOo_aI8w1uwOLWw_ArGf13Wg0gb5t1oZ_D7Qna44eZqxmlrT1bq-BEZH0SBCzeQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefledguddugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepveekkeffhf
    eitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhf
    sehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:yYx7Z6IxNzgpb0CKDqH_k6Jp8Zmqjq54hIW6K1pDL0X8fdmBdO3j5Q>
    <xmx:yox7Z1Jys_-zJuwE7J1Sp9ooxDaL17VDX3SDushRTZZrrXFV5dBkNQ>
    <xmx:yox7Zzz1mxj2IHCtteRN-MS3KUkCDbNsY6dVpDyRrSxa89wl6y68vg>
    <xmx:yox7ZxLkqCbuwtefqxosOmd1kqSqSO3nAISiI6XwskPtjwYrJ9YIuw>
    <xmx:yox7Z11Gv6SjeIb-wxl_LvNUnSOQhkyBL0f81XvXH2PUY56gmJGTNAI8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jan 2025 02:56:57 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id da839d64 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 6 Jan 2025 07:56:54 +0000 (UTC)
Date: Mon, 6 Jan 2025 08:56:53 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 6/6] test-lib: ignore leaks in the sanitizer's thread code
Message-ID: <Z3uMxScZGjBBTFUU@pks.im>
References: <20250101201226.GA3304465@coredump.intra.peff.net>
 <20250101202124.GF3305462@coredump.intra.peff.net>
 <Z3fSnK21nRBrjyfM@pks.im>
 <20250103202645.GD3212696@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250103202645.GD3212696@coredump.intra.peff.net>

On Fri, Jan 03, 2025 at 03:26:45PM -0500, Jeff King wrote:
> On Fri, Jan 03, 2025 at 01:05:48PM +0100, Patrick Steinhardt wrote:
> 
> > > diff --git a/t/test-lib.sh b/t/test-lib.sh
> > > index c9487d0805..d1f62adbf8 100644
> > > --- a/t/test-lib.sh
> > > +++ b/t/test-lib.sh
> > > @@ -1177,7 +1177,8 @@ check_test_results_san_file_empty_ () {
> > >  	! find "$TEST_RESULTS_SAN_DIR" \
> > >  		-type f \
> > >  		-name "$TEST_RESULTS_SAN_FILE_PFX.*" 2>/dev/null |
> > > -	xargs grep -q ^DEDUP_TOKEN
> > > +	xargs grep ^DEDUP_TOKEN |
> > > +	grep -qv sanitizer::GetThreadStackTopAndBottom
> > >  }
> > 
> > It would be nice to provide some more context here in the form of a
> > comment so that one doesn't have to blame the commit.
> 
> We can add that on top, but I'm not sure what it should say. Do you want
> something along the lines of "add false positives to ignore here..." or
> are an explanation of why we are ignoring this particular false
> positive?

The latter, ideally also with a reference to the upstream issue you have
created. That makes it way easier to discover why this line exists and
may prompt people to remove the line eventually if they discover that
the issue has been fixed for a while.

It doesn't have to be a full paragraph, but a sentence or to go a long
way sometimes. For more context people can still blame the commit
message.

Patrick
