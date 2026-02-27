Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAA235B62C
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 18:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772216096; cv=none; b=pYUNSvahm8UC3NeylmBFZCJDflhXjtyxeUQrFNk8YaKEO2o7o/a1axkw1alOZPJwTWHCinwbIdI4DdxCc8x7VlVm8LbqWhi6ha8JELMzeRitdibhpweZcDVD17lfEc/nFtZfezXp3+46Bk/77YAbX6gHs6d7EUOEyehu3pyUGqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772216096; c=relaxed/simple;
	bh=JWRL3Z7OMlab2jOk4jVI5GyDQe0/cLtfDA0kK1XAn6w=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z/+dV3XuLKvlVxjAZRDNTqsnCpv56B0jr7ZOZtAo3qMyf55PihabW2qjNkkCwsIbM/A4ZBNc/lqkvufKPFwaLq//mYiJVCquyoeSz7txgsGp4EsepeSRvjiKD91F6q/bBs+s2FFJGNlfUJD3JGE1OHOn4bI2vIfi1cxFHn3OCjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=krvzlc/O; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RlbLdCYg; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="krvzlc/O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RlbLdCYg"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 4E2641D0004B;
	Fri, 27 Feb 2026 13:14:53 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 27 Feb 2026 13:14:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772216093; x=1772302493; bh=WPV7+gznaJ
	+Auvy+ubfQGL8w/tr4RRFp4tv9uFJLxug=; b=krvzlc/OkF0KC8lbpOcSYCWPH/
	rBSK6F9KGMGSYu9XWcO/TdXlhc8E7P/h+upZNyFxe55iGYOPRGAaldtYIKrbXCJE
	SK3Iij/zfMf5Y2rnGUbhGIRvxfPpoqZ6UW5L91k8/ul3VMvasvmL5c/h+M+UjaFy
	gZVPlbOUpT2H37ereGYaOI6mPzm8qGIP2GME0sy1bwGdsxiLuPBpLKAlmC9X6mAF
	JfK4dPh98aHH2U2VycyH0l1PxF2gngIuwlvuUm23pTMSrNrGR3VTc0VCGbxRZc12
	ewk1R+SWQcmQzmMotuYAM0yTzeL/bxu1T/CJxPGPX8R5Spb4eVdrsZR8XP9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1772216093; x=1772302493; bh=WPV7+gznaJ+Auvy+ubfQGL8w/tr4RRFp4tv
	9uFJLxug=; b=RlbLdCYgvGWVDRGlgQ2FdoyBt6XMZrvglGsXHhFWIZ3gMov5hwq
	GecrwowcW+4/JWTVttRvj1B4nrri1Ri9zEwKCPd5sR+W3BRwglCjBhEXvyU40Aez
	WAPVqe/u8sMmN8WUukdDV4UEvPFHl8ykglKtv5SbM0Mujw1xVItH+gMoHl9onjZU
	EtffCqYAqwG2D9JVHdIEO582cEDeBxDEz4KzQti1VuJHe2minoL1OHl/S4Kb5mzz
	DwBa2KR8yylry44DBvwxLBje/WXImF3Lu7gfbXy07awo+JiCcYEWIJadhH9lf3AW
	ftv1Gb/MMIPov7OZc7t9DOmczSoOGFP3htg==
X-ME-Sender: <xms:HN-haTkWG8CV88A_DqsT7EFq7PtNRt_oDJK2UDFlQ6zHIblyPOhBdA>
    <xme:HN-haeSj3b145flxAtmUYaBxXI_j0e-72FJmbD6PiRwNPSmWEyR2WsNAqb6whQ1wW
    s7aFMoReWHnGSypgz6EJYjPvpD2fT5p6XwEAVIhMn9Jdkdh7Q72XQ>
X-ME-Received: <xmr:HN-haXCoS_sFCAiJ3E2RwQPQTANJ54j5eBdlB9XKk3HpDv3i5Qgzc_snCdspK3sTD-jmAZZuEra8HVXqR36iIatZWV3vNH_25DOz7m2o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeelieelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    ehkeeffeeggedvgedvfeefheettddtffejuefflefggfehfeelffeljedvfeehieenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtth
    hopehmshhmihhlvgihsehgihhtlhgrsgdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:HN-haVTblUgg8iGkZVhHpu3k3hMtqBTIZZo3HdfUim-8cxn1n1Ev0w>
    <xmx:HN-haVpWrf4X4Z_C4skhh0-yN3nzA_1UC9I09ZqbW988HBQ8YCGNhw>
    <xmx:HN-haXwh7Nwun0rr5-9P2yv9J2vq02fb_htPquVMVyDHjG5PAkcHaw>
    <xmx:HN-haaKzwgrydf7D_PnF8FmDfKmw3jIpYp9e6zy62NQcml4KLdDNhA>
    <xmx:Hd-haUeCdSFpEpzxe1BHH4h7y_7UMivUsfXvskQ-mEc_H3hTlDv5vOPN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Feb 2026 13:14:52 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1d4d1a72 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 27 Feb 2026 18:14:50 +0000 (UTC)
Date: Fri, 27 Feb 2026 19:14:47 +0100
From: Patrick Steinhardt <ps@pks.im>
To: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org,
	Matt Smiley <msmiley@gitlab.com>
Subject: Re: [PATCH 2/2] upload-pack: reduce lock contention when writing
 packfile data
Message-ID: <aaHfF-CbuEiVJmlS@pks.im>
References: <20260227-pks-upload-pack-write-contention-v1-0-7166fe255704@pks.im>
 <20260227-pks-upload-pack-write-contention-v1-2-7166fe255704@pks.im>
 <aaGWRWcxEtLD1OlK@fruit.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaGWRWcxEtLD1OlK@fruit.crustytoothpaste.net>

On Fri, Feb 27, 2026 at 01:04:05PM +0000, brian m. carlson wrote:
> On 2026-02-27 at 11:23:01, Patrick Steinhardt wrote:
> > diff --git a/upload-pack.c b/upload-pack.c
> > index c2643c0295..f8ba245616 100644
> > --- a/upload-pack.c
> > +++ b/upload-pack.c
> > @@ -270,6 +270,13 @@ static int relay_pack_data(int pack_objects_out, struct output_state *os,
> >  		}
> >  	}
> >  
> > +	/*
> > +	 * Make sure that we buffer some data before sending it to the client.
> > +	 * This significantly reduces the number of write(3p) syscalls.
> > +	 */
> > +	if (readsz && os->used < (LARGE_PACKET_DATA_MAX * 2 / 3))
> > +		return readsz;
> > +
> >  	if (os->used > 1) {
> >  		send_client_data(1, os->buffer, os->used - 1, use_sideband);
> >  		os->buffer[0] = os->buffer[os->used - 1];
> 
> This seems mostly reasonable and well-explained.  The one question I
> have is this: how does this work when packfile generation is actually
> very slow (or when the connection is slow) and we need to send data
> every so often to keep the connection alive?
> 
> I just want to make sure we're not breaking the keepalive sideband case
> when that's necessary, but of course I have no objections to improving
> performance and reducing overhead.

Right. `relay_pack_data()` is handling the logic to soak up data from
git-pack-objects(1). The outer loop is in `create_pack_file()`, and
there we already have a timeout configured. If data is produced too
slow, then we'd eventually land in there and send the keepalive packet.

I guess there is an interesting edge case here: if git-pack-objects(1)
creates bytes fast enough to not hit the 1 second timeout, but slow
enough to basically never fill the buffer, then we could potentially run
into a timeout eventually.

I'm not sure whether this is likely to happen, and whether it's
something we want to address. Maybe we should extend the logic so that
we also send the keepalive pkt-line in case we have only been buffering
data for the last 1 second?

Basically, we'd reset a timestamp every time data was sent. If we see
that we received data without writing it out, and if the current
time is one second beyond the last time we reset, then we might want to
send out the keepalive.

Patrick
