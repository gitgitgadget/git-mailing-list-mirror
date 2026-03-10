Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD81397E8E
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 12:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773144551; cv=none; b=FJy5kwxVQSFqPII32bH3Y43KTpuqYBlHCcoFG/1hAWImNM8T4uLs7uStnDWBEgZlWLc9a+sYT7Dq5PN8ehxOaVWXxxtmB1QRXVNc9+7EzzAgsSbXdoCX/DZPecNfpxxc925rffMx1I9wDBBAlUwPR66g8kbNXTWJfJ/e3u/23xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773144551; c=relaxed/simple;
	bh=3qCAhB8HHaPIt2jlTzvyLqhq5KeqNeAqJCgiNkxOhMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bHRv0KHzogn1R+3hDDzYhQ9imjDKmhZ42dLzAxuHzS7JkTAfD5V0XM4xz+tYpFY9mi9kux6LFmIaH4/KvxjsoIllCXLFkS0V1hP4RZ1PjqzLPU4SVgzrUUsA6jJlbtTm5W14VJRj+6wkL2WAnWW9QQg3omkonjiDcEzWCH1IZUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=R6vMN1nK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HCcgm7MK; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="R6vMN1nK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HCcgm7MK"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 11A6FEC0C49;
	Tue, 10 Mar 2026 08:09:09 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 10 Mar 2026 08:09:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1773144549; x=1773230949; bh=r+ncWgpp8W
	INHBFcEdAyuxEr7KB7at++CpRXbEZ7KNc=; b=R6vMN1nKAAcWo2gbbIGAOi7+1k
	kcliu/C3o1GqYI/7JDtozUUlsuks1jEP0Ffff6O/MN4eCEhJ/No4b43hMUT1Wa2e
	zg6OwMXpCVQlPM/eA/Y6voCa4hlJhAupNdENbdaG96VJIkr093m01JjWYZiQ3Fpz
	/Ss5NVphq0ZPhdaUAerUQs8BilQ7AgTUN3QrhbQORUVg1wjPo9CSsmF7ah2o9d41
	/9OuoumqTqdqKcPTRhhf14aRFAUka/rasNnrlteyHP9MLX8eKGMiiOK1XZ2ZfinC
	Mbs3IT3KXkyYLVjRuOfIgbk76Eh49xehr4PYkFr5bfpYKIazYYK0LvEg6Qaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773144549; x=1773230949; bh=r+ncWgpp8WINHBFcEdAyuxEr7KB7at++CpR
	XbEZ7KNc=; b=HCcgm7MKYm2eNnaJhmUazqx2nucowRRlgIm92TM5CIYViNbe0gQ
	5AOpw2cFBNlYnFF6BRZb7d2RhenVYQ6T25GTLy72lkPTqrfEbV7c7bvzA3ZVkBgB
	J3iMwAJ6N90tryOSTCGjc+mgS0l68x7725WvKQtlBncwZbxE0quNcVYCADr4UQD4
	0xyOi3yzYZ+qbmIDb5GseU45WTCe6qegUEdOhFVSahPW89uR1pnhotCtaHkuazeO
	qSmokl64sIw4KQKWTkNGrIXSlLfUvcx/1DJSLH/TN2cWPteRiiiMXYQPn4X73GjO
	6WKiLISSSv+g3RBYFfJJYxDZuaM9cRnHr8A==
X-ME-Sender: <xms:5AmwadeBG8-oK6v86B3yMMLxCmtjV0VA1s1H28CLLAHmRVmsS9N3Qg>
    <xme:5AmwaSMzwGzxb9UA1pROjqYvm7wF_d77CPZjEUhsiwr7c8n7uhsMzHNmyXBJwz5uQ
    jH_OYNpvpO_joc6RxSPQU0Z0UTXufCth5oXKyxST-DhXkQ2NMg88A>
X-ME-Received: <xmr:5AmwabhF9ef0vZ-O2ItxEH1Rn1_3AyCkqpWUBTIPVYkHvqDNsOgFfOd-3GL_37PFQbWxd1-6Rv_HYPXsEpdzHe7ENfbaVDndJQUZ2ec->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkedtleekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepmhhsmhhilhgvhiesghhithhlrggsrdgtohhmpdhr
    tghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvght
X-ME-Proxy: <xmx:5AmwaV0N0s7Q57Yrrd3yhrSQqMFi5ZN-5Rl5ClDNZ90Ql_hNUTC3fg>
    <xmx:5AmwaVh0bmyuKOiQG84S8gCNe-mZ6DNk-mWms2NUYFkLPWLEBzJ3Yw>
    <xmx:5AmwaVfnREc--t39C0GzTX71VIPSaHFUn9nrPihWfCUh-_psHnxu_A>
    <xmx:5AmwaYm9TX5Ffw684rVXuVhUkNbyGxiiWmSjAuk76A03h03t8FHkzQ>
    <xmx:5Qmwaa4YOqQyCyZNfywCznHJOxlUk_V0dE9aXfJtHM_BogTrMmM1Qxdp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Mar 2026 08:09:07 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 86ee7e85 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 10 Mar 2026 12:09:06 +0000 (UTC)
Date: Tue, 10 Mar 2026 13:08:58 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Matt Smiley <msmiley@gitlab.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 02/10] upload-pack: adapt keepalives based on buffering
Message-ID: <abAJ2iMVa9rwGgr5@pks.im>
References: <20260303-pks-upload-pack-write-contention-v2-0-7321830f08fe@pks.im>
 <20260303-pks-upload-pack-write-contention-v2-2-7321830f08fe@pks.im>
 <20260305005611.GB4943@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305005611.GB4943@coredump.intra.peff.net>

On Wed, Mar 04, 2026 at 07:56:11PM -0500, Jeff King wrote:
> On Tue, Mar 03, 2026 at 04:00:17PM +0100, Patrick Steinhardt wrote:
> 
> > The most important edge case here happens in `relay_pack_data()`. When
> > we haven't seen the initial "PACK" signature from git-pack-objects(1)
> > yet we buffer incoming data. So in the worst case, if each of the bytes
> > of that signature arrive shortly before the configured keepalive
> > timeout, then we may not send out any data for a time period that is
> > (almost) four times as long as the configured timeout.
> 
> Thanks for laying out this case. I think this is all-but-impossible in
> practice, as anybody writing "PACK" is going to do so all at once. Even
> 4 separate write() calls would be fine, as long as it does not pause in
> between!
> 
> I think there's another one, too. If we are getting packfile_uris, and
> pack-objects writes half a line, we will pause waiting for the complete
> line to show up. This also seems quite unlikely in practice.

It could happen in case the data was written by the pack-objects hook.
But I fully agree that this is a rather unlikely scenario.

> > This edge case is rather unlikely to matter in practice. But in a
> > subsequent commit we're going to adapt our buffering mechanism to become
> > more aggressive, which makes it more likely that we don't send any data
> > for an extended amount of time.
> > 
> > Adapt the logic so that instead of using a fixed timeout on every call
> > to poll(3p), we instead figure out how much time has passed since the
> > last-sent data.
> 
> OK. That should not be too bad to do, though...
> 
> > @@ -365,10 +373,14 @@ static void create_pack_file(struct upload_pack_data *pack_data,
> >  	 */
> >  
> >  	while (1) {
> > +		uint64_t now_ms = getnanotime() / 1000000;
> 
> ...now we are talking about wall-clock time since the epoch. What
> happens if time goes backwards due to a clock reset?
> 
> Then now_ms may be less than last_sent_ms, and then here:
> 
> > +		} else {
> > +			/*
> > +			 * The polling timeout needs to be adjusted based on
> > +			 * the time we have sent our last package. The longer
> > +			 * it's been in the past, the shorter the timeout
> > +			 * becomes until we eventually don't block at all.
> > +			 */
> > +			polltimeout_ms = 1000 * pack_data->keepalive - (now_ms - last_sent_ms);
> > +			if (polltimeout_ms < 0)
> > +				polltimeout_ms = 0;
> > +		}
> 
> ...we end up with a value higher than the keepalive, and we wait too
> long. That's probably an OK outcome for such an exceptional condition.
> The worst case if you set your clock back is that we fail to send
> keepalives until the next actual data chunk arrives.

Right. It's rather unlikely to happen, and in addition to that we use a
monotonic clock in `getnanotime()` on systems with `CLOCK_MONOTONIC` and
on Windows. Which probably covers almost all platforms out there.

Patrick
