Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907A5181B87
	for <git@vger.kernel.org>; Thu, 22 Aug 2024 12:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724331237; cv=none; b=KE5A9igM4jW6T7w9uXTuM/ulUGS125fJfx24Luyp9uOHCedrY7FBKYsnLrd68HnbPN2km4Z1j/8ONYm4WF5m8rhWkbGnOhxcWF5kCRzvyhMCh27TMeilR6wSlFfeKnJVMJBExvNOfiRhwk9bkl0Wtr7Us3ZBlEGccmLZfOwtmzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724331237; c=relaxed/simple;
	bh=rUfZUPI1pWKypmdOPnmmgReDzS7iyflEonoeS6OgsoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uR+NSk7bPpQb7WyRe/ivEHSOledUkYgWSQ2FuZU/+D3qiUXVY6krApYbc6K+GroE4Df3isq71pzMBRp/klkUncVN113vXg1fqVN3aVhPFRiGnjICYL1K2EV/aI2qF0MyVioJiQ7sIduYmcTfZgANYO1hrftM6c7mXoDHS9sKOhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ip6CMa7k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ret82fbx; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ip6CMa7k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ret82fbx"
Received: from phl-compute-07.internal (phl-compute-07.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 463E01151B24;
	Thu, 22 Aug 2024 08:53:54 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Thu, 22 Aug 2024 08:53:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724331234; x=1724417634; bh=xJJQa093L6
	Hqpv7urvpQPONAmrDt6FiVx/8gltOIo+Q=; b=Ip6CMa7kIIyqWhbKxYcx5ugpou
	QUHqYQ3IHYqj1Z3CppcLTKLiaDfF1hUwbnfRJ7HAP4U8PnpKmdbsToCGBHAfg41D
	zJTiN5OEe+ZHv3XxDljcauAOeKM+bkZ7iqCez8kSx2FLAuWh28T0cgZfrTH93eEH
	Ot02KT6g3zQhVE8zxcnKUx5USN8x/ScXgrow8DRtm9SVNZDMXvxydbfVhylbFkL4
	kncaTHDzbxE8RVpB6cW2MPjg+Pg2sGUplT7s06tfbRFZpkhMmZglUMi9o9T3du7q
	dTTNG6t9kFT23YTT1OsVE0uyFoogvEYohG5CaY8pG8NQD8XeLexSrh6kxcbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724331234; x=1724417634; bh=xJJQa093L6Hqpv7urvpQPONAmrDt
	6FiVx/8gltOIo+Q=; b=Ret82fbxcFLXik9LknF+0oxyXQAj9LexeNOLIW9zUd5k
	sHiG7BDsyKiAkvvOr5YNtRPJgYwEUVVIy+Zn2p3JdRmYjDt6wQPPjN9Izyx+0rqy
	nthUWB2GqD83v77MKK4U+br5ZCt8svm76cC76YJMzraXYmLH9f7wJFpNyoR+RnhI
	bxuizUa9xfT/PcJp+5PRHkPOmqL1WPWf3JR3y8+fTSAcrSnA2LTVvg4EBcyZ7ZSS
	MMrV09dI+K2p/U6j4wlZB2TR57Vhrq6M63/y7kx14MWNY56psGswDuasDp0AGZAW
	vl6bcSumNPQRWcZfHovj9yWWE7AyoKMTfdxe0Eu4fQ==
X-ME-Sender: <xms:4jTHZhwZ8SrJdsJgd6rFcIn3VMdL7rRE7ydQVlVIQhQ-q6oeQZaGhA>
    <xme:4jTHZhT1_Jrtc7mALADRYn_K73f_6MkR2Yd8PIFPR6ejMz8rHpahKfyoeIr2TLQRf
    h4xtwbFRzkmISyfCg>
X-ME-Received: <xmr:4jTHZrWptH9ZFqIQZZxVS_H8XZcjbqMpoifJEBnob0iDRKH0CeDznnqe_rPMjSCEon-K8SleI12K2AkAvzDe_BzJ34BySzVrPK3_n9jDbsMZrjo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvtddgheeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhes
    phgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:4jTHZjhMJF67nquImteIkyaH7-hRHuxtPl8nexrCij6NfJKul4-aQg>
    <xmx:4jTHZjCI0sFqC7mQQv4m0m0LgY0D7BZwVkHNMuGAc39UkiYj8MzcSQ>
    <xmx:4jTHZsK4JVrQKGyCOn929StanhHPyOQt3IvCDfdiC7tH2nNfL2EAvw>
    <xmx:4jTHZiCIg0cTgtfUDutaa5-oAs0bN0iPeTXf2lzvfzOWSt3aLRMQ9w>
    <xmx:4jTHZmNrdPqHstpblI7yEWXCVjQPm7irc5U4FFS39bwgB_UqlAVvwZ9R>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Aug 2024 08:53:53 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f1a99212 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 22 Aug 2024 12:53:16 +0000 (UTC)
Date: Thu, 22 Aug 2024 14:53:48 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 00/10] reftable: fix reload with active iterators
Message-ID: <Zsc03CSJ3Ece5L6s@tanuki>
References: <cover.1724080006.git.ps@pks.im>
 <20240822124100.GA1070988@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822124100.GA1070988@coredump.intra.peff.net>

On Thu, Aug 22, 2024 at 08:41:00AM -0400, Jeff King wrote:
> On Mon, Aug 19, 2024 at 05:39:38PM +0200, Patrick Steinhardt wrote:
> 
> > This patch series fixes that issue by starting to refcount the readers.
> > Each iterator will bump the refcount, thus avoiding the problem. While
> > at it, I also found a second issue where we segfault when reloading a
> > table fails while reusing one of the table readers. In this scenario, we
> > would end up releasing the reader of the stack itself, even though it
> > would still be used by it.
> 
> I gave a fairly cursory look over this, as I'm not all that familiar
> with the reftable code. But everything looked pretty sensible to me.

Thanks for your review, appreciated!

> I wondered how we might test this. It looks like you checked the
> --stress output (which I confirmed seems fixed for me), along with a
> synthetic test directly calling various reftable functions. Both seem
> good to me.
> 
> I had hoped to be able to have a non-racy external test, where running
> actual Git commands showed the segfault in a deterministic way. But I
> couldn't come up with one. One trick we've used for "pausing" a reading
> process is to run "cat-file --batch" from a fifo. You can ask it to do
> some ref lookups, then while it waits for more input, update the
> reftable, and then ask it to do more.
> 
> But I don't think that's sufficient here, as the race happens while we
> are actually iterating. You'd really need some for_each_ref() callback
> that blocks in some externally controllable way. Possibly you could do
> something clever with partial-clone lazy fetches (where you stall the
> fetch and then do ref updates in the middle), but that is getting pretty
> convoluted.
> 
> So I think the tests you included seem like a good place to stop.

Yeah. I think demonstrating the issues on the API level is okayish. It
would of course have been nice to also do it via our shell scripts, but
as you say, it feels rather fragile.

> I did have a little trouble applying this for testing. I wanted to do it
> on 'next', which has the maintenance changes to cause the race. But
> merging it there ended up with a lot of conflicts with other reftable
> topics (especially the tests). I was able to resolve them all, but you
> might be able to make Junio's life easier by coordinating the topics a
> bit.

I can certainly do that. I know that there are conflicts both with the
patch series dropping the generic tables and with the patch series that
move the reftable unit tests into our own codebase. I did address the
former by basing it on top of that series, but didn't yet address the
latter.

I'm okay with waiting a bit until most of the conflicting topics land. I
guess most of them should be close to landing anyway. Alternatively, I
can also pull all of them in as dependencies.

Patrick
