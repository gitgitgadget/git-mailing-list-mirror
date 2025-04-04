Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF0B1ACEDA
	for <git@vger.kernel.org>; Fri,  4 Apr 2025 10:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743761119; cv=none; b=fxFIhqz/Bl+fq6xc9o6NSWT/92xRoxIZMbn9C+l7fm59BG9MwrfXPOnUShuv1PhW1+zCKBTPKp/6ADQi1ztdn4Y120hRTyZ4VAtY83e89XXhZRIEP5+xNawEurRnwsSa0gRdllTbM76BTjOUA1b4tWyZi5xrEePRp0huDbHdeSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743761119; c=relaxed/simple;
	bh=NxTtNk8y7UAz8ujKNAF2LZQMBZ0gGamYaU5Z7dZZn9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P+FTpFy1Hm25nKb802WwJAAsij4slXEjDpFgiYg6d/1927hgCA7JiVv21y3d5HpfNE/SClm2EpPY5pqGZFWQtToOffng4DeBJgyprBrpReHu1gCLkB9XpNm+j5NWuptn2+1SZbAzW1jKffl5ZqnvBXc+7AnKGnf9TANWCj+2q38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UaRZMMTK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rkVgnIyL; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UaRZMMTK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rkVgnIyL"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 84160114013F;
	Fri,  4 Apr 2025 06:05:16 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Fri, 04 Apr 2025 06:05:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743761116;
	 x=1743847516; bh=wZ3mjyAsLLs0r/da4v6J3pP6VxIXf/xNmB1nGFi9fcg=; b=
	UaRZMMTKQIVLKP4QFmyM8aeviGt9KcgZ8T9uRyGV0wcRU9KX04jo7NQQaimS8EhE
	0A/X9MfuvR9pRcEJOTLZKK6QDdJWMyIZTKG/rBmKHfZxmARMquLm0UCP1QEwIkm9
	z39RSf1Edd5mg+HTsVumnuOT22IPlNHsZZ3cSDh16VUXaprc6dPhWgrTpQSIYgxj
	7CqJGZZn+vyY4Ayyh84WFzPFqtNuAW3nhhEvd9U0FwotPSO9fOCDcDVf9lPLr/ER
	Nep8VP8nzduzF4NQQ4Z1tWFhjxgmUQ68Ijx7ZSwFf/RUNz+v53YXWrVAYnjZp4OK
	vosc5fqCq4qHAgxGOqUuDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743761116; x=
	1743847516; bh=wZ3mjyAsLLs0r/da4v6J3pP6VxIXf/xNmB1nGFi9fcg=; b=r
	kVgnIyLh/7KQ8l9SwHelb0B2uCR0LvR5iXlsHnOGzWynU5prOR2BgVH7HSMGM0Ka
	pbxM3VOu80MSJg0f+sWTvM40SGKQInBrg4bo922n6ZRdp5gS5eFBvor+KinynidC
	syCmYkx4hMcYEwH56+b+LNb9aQx0P64EmhV772OtelX47pmEvF/QWDMJX/pB1gi4
	JLNw47nM9QmVNZpQqkMsjLkQaL0/SvfSI6hNmdqzeCjvEsIcmJYHQlQSyRPJkiS0
	c7BUhSzan1T/r3mkxOyDhgIwwX08xi60hfly7sFSWwQPJhakjONwjX6zal37N+N1
	FfH9alre0bfiscaLA1tyw==
X-ME-Sender: <xms:3K7vZxw0Jd8iy0khK1D7iYpuFN-E1oH7G94xwd6wGIyf2fuOR4sVEw>
    <xme:3K7vZxR0bgmlCL1PxYkZf_587HEP04IQZ2Pa5HMvGueoRHmh0xedOIrIKVkeCfnIn
    jtQbcgKtoJ-AXo4Zw>
X-ME-Received: <xmr:3K7vZ7W8IZJOIRI9pZpcJNrlko9y_s2TI1A3UVL1fI1fjx6bfGyXR9kGdAd3sy5XCPUabzwZJnNicwOlUDliPn2oCyT2ZEjxsodwkKbpYMCJWB0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduleduudehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddt
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedv
    veetffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeekpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgv
    rdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtth
    hopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthhtohepnhgv
    fihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrg
    hilhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:3K7vZzhjp7m15Pf_rsXSSwlEdrRud0PJ7PWqYU3qgZk-rl0pIHJsSA>
    <xmx:3K7vZzBTTbNl-yEhCUsl5OSvTMQc0vQrT6MkZQCoQ_N9bv4Q2UTF4Q>
    <xmx:3K7vZ8In0KHxzK6Y5qPF4xnh7cs-wJG6els76_BHpXczXstrpz6XFw>
    <xmx:3K7vZyDLzj7ClQi1q9He13L8_wxu00P546efZ1rHQ1ZqtAtxHW-tug>
    <xmx:3K7vZ5HmPu3ZwvB1DW9b52M-sKkqfNcYVwUkQunle99CWUhXF6URcZ6p>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Apr 2025 06:05:14 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ac6a0318 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 4 Apr 2025 10:05:13 +0000 (UTC)
Date: Fri, 4 Apr 2025 12:05:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	shejialuo <shejialuo@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v6 14/16] refs/iterator: implement seeking for packed-ref
 iterators
Message-ID: <Z--u2DlaPij_j7zX@pks.im>
References: <20250312-pks-update-ref-optimization-v6-0-f778e0414f55@pks.im>
 <20250312-pks-update-ref-optimization-v6-14-f778e0414f55@pks.im>
 <CABPp-BFBqC_t5QSexRQpYsqXBa11WK+OqGt167E=K=xod=buQw@mail.gmail.com>
 <Z--tomMthXftrdYA@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z--tomMthXftrdYA@pks.im>

On Fri, Apr 04, 2025 at 12:00:07PM +0200, Patrick Steinhardt wrote:
> On Thu, Apr 03, 2025 at 12:56:39PM -0700, Elijah Newren wrote:
> > On Wed, Mar 12, 2025 at 11:42 PM Patrick Steinhardt <ps@pks.im> wrote:
> > >
> > 
> > > @@ -951,12 +954,41 @@ static int packed_ref_iterator_advance(struct ref_iterator *ref_iterator)
> > >                                             &iter->oid, iter->flags))
> > >                         continue;
> > >
> > > +               while (prefix && *prefix) {
> > > +                       if (*refname < *prefix)
> > > +                               BUG("packed-refs backend yielded reference preceding its prefix");
> > 
> > I just triggered this bug upon a "git pull" in an internal repository:
> > 
> > $ git pull
> > remote: Enumerating objects: 161255, done.
> > remote: Counting objects: 100% (55884/55884), done.
> > remote: Compressing objects: 100% (5518/5518), done.
> > remote: Total 161255 (delta 54253), reused 50509 (delta 50364),
> > pack-reused 105371 (from 4)
> > Receiving objects: 100% (161255/161255), 309.90 MiB | 16.87 MiB/s, done.
> > Resolving deltas: 100% (118048/118048), completed with 13416 local objects.
> > From github.com:github/github
> >    97ab7ae3f3745..8fb2f9fa180ed  master
> >                     -> origin/master
> > [...snip many screenfuls of updates to origin remotes...]
> > BUG: refs/packed-backend.c:984: packed-refs backend yielded reference
> > preceding its prefix
> > error: fetch died of signal 6
> > 
> > I made a backup of the repo with rsync.
> 
> Thanks, I can indeed reproduce the issue rather easily:
> 
> 	test_expect_success 'list refs with unicode characters' '
> 		test_when_finished "rm -rf repo" &&
> 		git init repo &&
> 		(
> 			cd repo &&
> 			test_commit A &&
> 			git update-ref refs/heads/ HEAD &&
> 			git pack-refs --all &&
> 			git for-each-ref refs/heads/z
> 		)
> 	'
> 
> I'll investigate.
> 
> Patrick

Okay, below patch should fix the issue. The problem is that the sorting
we use for refnames is done via `cmp_packed_refname()`, which does the
same cast. And because the uppermost bit is set for the emoji character
this causes us to compare diferently in `packed_ref_iterator_advance()`
and thus causes the bug.

Could you please test whether this works for you? Once confirmed I'll
send a proper patch.

Thanks!

Patrick

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index b4289a7d9ce..7e31904bd41 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -980,9 +980,9 @@ static int packed_ref_iterator_advance(struct ref_iterator *ref_iterator)
 			continue;
 
 		while (prefix && *prefix) {
-			if (*refname < *prefix)
+			if ((unsigned char)*refname < (unsigned char)*prefix)
 				BUG("packed-refs backend yielded reference preceding its prefix");
-			else if (*refname > *prefix)
+			else if ((unsigned char)*refname > (unsigned char)*prefix)
 				return ITER_DONE;
 			prefix++;
 			refname++;
