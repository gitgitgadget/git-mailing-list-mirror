Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60212F46
	for <git@vger.kernel.org>; Wed,  5 Feb 2025 05:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738733773; cv=none; b=VmmhYzzoBshFr2hRZ3CRBxg9N6UuqfS1fVD1D5mbMUUyRuOYJgAoc9DZGa+1n+9UONx1/rOeGDlbtjCFCTrYyKHILGSLg3YdiD3t0DfKuRpQ4Jj6TlvFlHBpaBoEIiL1zpxqjZcGju9TEaZQRwi+suFIC8jcQtahWRCbTeE7UoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738733773; c=relaxed/simple;
	bh=4fOo5H6Ce6CPTvAuR7KiSHY9RIuhNIRbrGGGtfbXDSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZczQQlaXTyt4+n+fwT+Ild03qJW32C4LxlRVXBII50XbYw3wVNT64BLRGKQ0GEjPZ9mXw5R+TuwUc25KxN5pmhcY4jCrRmXa4si7Urz6EqkIyQIzj4jJuMxiefFDk1RUv4xmWD+cB3YoHk+6krtQHCJIxM76h3zdUGvU7ouI64k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aHyoBGzc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sLtLjlFH; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aHyoBGzc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sLtLjlFH"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 95302114010A;
	Wed,  5 Feb 2025 00:36:09 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 05 Feb 2025 00:36:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1738733769; x=1738820169; bh=bJJfhwttau
	S53zTPd/93DPUTJXwtWootKacRCarVvXc=; b=aHyoBGzcMdIbJ+Jjmnb5savDtt
	/wKlH3PMw7lGU61Nn4USTxTKz5caTGnhn8Ew7g9PNPmbqNU19kUW7vc+gusq/sXh
	g6kfmU3GAlK4pau6oRESkZUTbjTOtMoUjftqB4fOphvjwHT5Bj5/zYro/p2FxtEC
	b5oJuGbln9f3gQMeWDji1xi3MARbLIVAREbyt9U8HWa2aT/XibrHSAQl5vc+VJeJ
	TIK7MLDz3zAUI0L2361V8qtRbNZ2gaiD5TxICsg81Y4xI3O7lVzeamKAUA4riBTj
	JN4YTRr4ScwBsyEmaKhVdwbwcoN/UPiNq8jQvOCXQ7kL53HL3WMFabD0VAtA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738733769; x=1738820169; bh=bJJfhwttauS53zTPd/93DPUTJXwtWootKac
	RCarVvXc=; b=sLtLjlFHpiyC7Fuiy2obBa2U9muQvLsf8PImhTsFsv7tAl3KRhW
	+EuD0g04sA0jHlEIrgWfCPhQ5M5iu8IMxoguQs/62L+Vf8OZfZaGVjaDp+LZjeJu
	5P+iaOkzI30sE2fOVAn9tDoc14uTlMA1C80WAd1kp+95z7TL7jh8niHVGmtSBvQT
	mgn+OmdFwtaBKsf53WPfJihMri/+zaphmdzu9SDtixWulWEmJcAajkZEPv0I7Sry
	7uYUDeBu+OZXx6tZAWWaogP3oM317JnW1qWdkArmsGkoxe5/PjojYurJ2tuLyfvG
	jRIkAKX4+/7RwaT/P1cZLP49n73Up+hEfeA==
X-ME-Sender: <xms:yfiiZ5mI1MkiHJDSSNK8CgIOGgDD9gwh7219X167nhFPVCBz3VEV0w>
    <xme:yfiiZ027OcVS3sD-MMC1QhfBNSpD72OPMWmlXy7i8MRjUu-3gCcrhZ5VyJEsaNeml
    0H7HwggBvQp78Jpzg>
X-ME-Received: <xmr:yfiiZ_pFOECqUlpe58T9Ci80jq7hZ_kjix3bP42eazry0Pipl4DjvL05YbpRuKvJCWDvJ1XWbZLp5wP3KiwrcT9TTHmugvBqVttMfIwLzJPEdA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdeiudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepjeevudeggf
    ffffeigeethffgieekveeffeehvedvgeeiteegueejleeihfeitdeunecuffhomhgrihhn
    pehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:yfiiZ5nTL3pqkf6Casci85arKZfqA5QrCOp1WsHLC7YlgJFl1toF1g>
    <xmx:yfiiZ31SyPl2Cd3WXOpqHZ7aV3S4cG85SvF_yuZvvkf_0hEG97bhnA>
    <xmx:yfiiZ4sJikYGib5Nwx3eOp9E1Sa0bSD2Dp5xUIEer-0QrC3QTEoRCQ>
    <xmx:yfiiZ7WDGtav-ze1umlTSpJY7GkDSp4Jh3pZVCvFZYnXFf6OFEH6EQ>
    <xmx:yfiiZ4z1d28mAQiHrlsE6ZZWJFjZU4B_bZcUURm3nMLqU26t6C2cpLII>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Feb 2025 00:36:08 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5f30fde1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 5 Feb 2025 05:36:05 +0000 (UTC)
Date: Wed, 5 Feb 2025 06:36:04 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] builtin/repack: fix `--keep-unreachable` when there
 are no packs
Message-ID: <Z6L4xDMqc6aXEA8A@pks.im>
References: <20250203-b4-pks-repack-unreachable-objects-wo-packfiles-v1-0-7c4d69c5072c@pks.im>
 <20250204-b4-pks-repack-unreachable-objects-wo-packfiles-v2-1-1eae23366711@pks.im>
 <20250204152236.GB620055@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204152236.GB620055@coredump.intra.peff.net>

On Tue, Feb 04, 2025 at 10:22:36AM -0500, Jeff King wrote:
> On Tue, Feb 04, 2025 at 08:00:41AM +0100, Patrick Steinhardt wrote:
> 
> > this small patch series fixes `git repack -ad --keep-unreachable` when
> > there aren't any preexisting packfiles.
> > 
> > Changes in v2:
> >   - Merge tests into t7701.
> >   - Link to v1: https://lore.kernel.org/r/20250203-b4-pks-repack-unreachable-objects-wo-packfiles-v1-0-7c4d69c5072c@pks.im
> 
> This looks good to me.
> 
> One interesting thing I did notice:
> 
> > +test_expect_success 'repack -k packs unreachable loose objects without existing packfiles' '
> > +	test_when_finished "rm -rf repo" &&
> > +	git init repo &&
> > +	(
> > +		cd repo &&
> > +
> > +		oid=$(echo would-be-deleted-loose | git hash-object -w --stdin) &&
> > +		objpath=.git/objects/$(echo $sha1 | sed "s,..,&/,") &&
> > +		test_path_is_file $objpath &&
> > +
> > +		git repack -ad --keep-unreachable &&
> > +		test_path_is_missing $objpath &&
> > +		git cat-file -p $oid
> > +	)
> > +'
> 
> In the test in v1, we had reachable commits to pack. And here we don't.
> So before your patch, the behavior in the v1 test was that we'd create a
> new pack, but it wouldn't pick up the loose object. But the behavior of
> this test is that we say "Nothing new to pack".
> 
> I originally thought that output meant that we were not running
> pack-objects at all. But looking at builtin/repack.c, we do run it, and
> it simply chooses not to make a pack (which makes sense; how would
> repack even realize if there was stuff to pack, since pack-objects is
> what does the traversal).
> 
> So the two outcomes are both the result of the same bug. In both cases
> we do not correctly pack the loose objects, so whether we make a pack is
> just a question of whether there was other reachable stuff to pack. And
> since your patch is fixing the bug at its root, both outcomes are fixed.
> 
> And when I suggested in my response to v1 that "Nothing new to pack" in
> an empty repo was a separate bug, I was just wrong. ;) There is nothing
> else to fix after your patch.
> 
> Thanks for finding and fixing.

Thanks for your thorough review!

Patrick
