Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEFC38C409
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 09:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772530322; cv=none; b=G6GD635pNj8vMS5n8YD2AHraLSltyTuR9gx6Ix5SwL40NwBXIN2UVTiYwpKekmBKxz3voQBp9vvqxQm/mcpYV5ZJlSI8QLNdXBuS8k2PoOZU/M7+xrccpy7c9ICuunl4q+28345Wr22rqXL+bXE+kfMET8lTwJCXaOSznh9NW1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772530322; c=relaxed/simple;
	bh=9f2Uc7veghoFQrnjhyPE2tU23W5uVbix6SGhkmee7Dg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H9nCAtxCFgTSMdP4oTi9rlCtjEk9tgw67HFzkPs2+lSqBfYigmFTjq6gr9eLOXEVhM18Px+HRFyciYAmuYneOWJBA8g0FCmFKAta05mictz2IcrEVzvrrD8CQ+MV3te7m2iwaKFWT6soj8dv+jIQWgcpSL+NHeOhyy4BHj2EnEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GuQFKsch; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rHDsslmf; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GuQFKsch";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rHDsslmf"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 30AC77A00A2;
	Tue,  3 Mar 2026 04:31:58 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 03 Mar 2026 04:31:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1772530317; x=1772616717; bh=lydgF2qwAk
	krL3dHOlSPJqjjSTAfKqlfLbDlddFgcyQ=; b=GuQFKsch3uPWUWmQ3oBo8MPfZk
	elnThjLY0S06XUXxg47mveq92jjw6JA/hJRUSpVGu59hKXOmPuo3ZAkm43cIxKwQ
	T4eb14FtlnUgiLLqseYMu8TL92GWFJ+CkwQRSjRFKPw0BPdLnFx31C+/ONGFnuHk
	FkltsxlhwRf6Ng3TCttiLcoPKYa/Qv+YkRD/jWp9IrrF4zc2T3dW6+aJXxQ64FZ7
	mWEWbpngeBr+Xl7zc3y1ImfLjRZMe4DZNENa3UrrS+EVwO+n4iO2rDQcMNrpCfpg
	fKgIc4t+faoZ0lQyiJivrwXW4sCSy/JIFrs27ZJHiKTxC0KEyyzPbm2SXZLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772530317; x=1772616717; bh=lydgF2qwAkkrL3dHOlSPJqjjSTAfKqlfLbD
	lddFgcyQ=; b=rHDsslmf08ifi4uBnDd1g5ve3OWR9urL4GrhFku0jCHXulcSlHM
	E2kJt3m4Jev9EZZ055f8xe250SLZDWUPmocKxOMUKtdMQe+U3/1B7Qy5pBo6AWeV
	DE2mxGzd+lLW2autRAXlvpM1mcKQAKc08itMr2dtncKn6iWV7IiF5VMoT5TnKLQh
	/KUVscr/okp9GJoHf7iy99Dzj2aS1m+t4Il77Me9l4RyGKVjLrqd9VAkQn7cvirD
	euBP5+qZiL/pP+cl9Zpkbs+N9NFFyWgb1EQGsCmujfJyPCd0Z0iUC3pYc8qmPMFQ
	sGSpB70gmTrHTlrJBPEk8r1VVh9zIekSyUQ==
X-ME-Sender: <xms:jaqmadmQHsAFKdO5yzgtX5jPxdgbvELFirUJI0kFO_yfQOWu4n5CYQ>
    <xme:jaqmafuIXxR-0l4D3f0r_oJzyGx0S0HzNRdVpaua6283DdCYSCnN8czovzT7z-CMJ
    TUJDyUNV8Y9iV21pNMEpBrRk4vMdhXiX4xvCTrs1vNa-nvxnnPfzw>
X-ME-Received: <xmr:jaqmab9nNRapmxxYhkpk7ZoK2Lab6dR405qRgVPIL27k_VpZUgXTor4sO7GENDk43GeDW4miDEbx-Ezbm1gff6kF2kuH1Ly6nwSCZrswiaCo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddviedtvdefucetufdoteggodetrf
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
X-ME-Proxy: <xmx:jaqmaZPwpzt0njTJvFUeI0k3zEXxDpIGGe3216SLByk3uC8sHJnEHQ>
    <xmx:jaqmaZE9P798gdbTu7ZU3hDsCtt4Z_whFi8u_uBznHsz9ThM8P2O1A>
    <xmx:jaqmaXTW5cJ07uFKTHlU9buv_IyvmuTW07gRwnpcsdU2km4sczOU0A>
    <xmx:jaqmaWvPsRtI4I3yweSRswoE58oI9nzQ4qqzbh2wMP7rTbKE7jzrbA>
    <xmx:jaqmaYTNoktRj1Xqo_LCcKf7j56ZYGxZk-FO5cXCO2EK0IEKVM6GvsPX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Mar 2026 04:31:56 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id feb89600 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 3 Mar 2026 09:31:54 +0000 (UTC)
Date: Tue, 3 Mar 2026 10:31:46 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Matt Smiley <msmiley@gitlab.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] upload-pack: reduce lock contention when writing
 packfile data
Message-ID: <aaaqgrmOBj-Ly1Vx@pks.im>
References: <20260227-pks-upload-pack-write-contention-v1-0-7166fe255704@pks.im>
 <20260227-pks-upload-pack-write-contention-v1-2-7166fe255704@pks.im>
 <20260227193758.GA2931515@coredump.intra.peff.net>
 <aaV-l_NyWpkKDDp6@pks.im>
 <20260302182023.GG28275@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302182023.GG28275@coredump.intra.peff.net>

On Mon, Mar 02, 2026 at 01:20:23PM -0500, Jeff King wrote:
> On Mon, Mar 02, 2026 at 01:12:07PM +0100, Patrick Steinhardt wrote:
> 
> > > Rather than buffering in upload-pack, would it not be simpler to just
> > > increase the write size from pack-objects? Then we do not have to worry
> > > about disrupting upload-pack's keepalive timeouts. And as a bonus, if
> > > you are worried about the system-wide number of calls, you will likewise
> > > be reducing the number of read() and write() calls over the pipe between
> > > pack-objects and upload-pack.
> > 
> > We can do that. But we also have to keep in mind that downstream in the
> > pipe may be a process that's not even git-pack-objects(1) in the first
> > place because of "uploadpack.packObjectsHook". So maybe we should have a
> > look at doing both.
> 
> True, though I think that whatever is producing gobs of output from that
> hook should consider using a buffer size close to a pktline. In many
> cases it will be pack-objects itself (just wrapped with some extra
> magic), but I guess you may have some kind of caching layer at GitLab
> (we did at GitHub).
> 
> That is getting specialized enough that I don't feel too bad suggesting
> that authors of those tools should consider buffer sizes.
> 
> As far as doing both, I'm not sure if it's worth it. My two concerns
> are:
> 
>   1. It re-opens the question of whether upload-pack might stall waiting
>      to fill its buffer and fail to produce keepalives correctly.

I've got a patch for that. The problem can even trigger right now as we
already do buffer some of the data, and that may cause the keepalives to
be missed. But this only happens initially in our current
infrastructure, before we see the "PACK" signature, so it's unlikely to
be a problem in practice.

>   2. I wonder if we could get some weird interactions between the two
>      buffer sizes. E.g., if pack-objects sends 50k bytes at a time, but
>      upload-pack wants to wait for 51k. So we read 50k then wait for the
>      next chunk. Either:
> 
>        a. we read 50k again, pull off 13k of it to make a full pktline,
>           and then memcpy around the other 37k to await more data.
> 	  There's a bunch of extra copying as our buffer sizes don't
> 	  line up.
> 
>        b. we read 13k (to fill up the pkt we're trying to send), send
>           that, and then the next read gets a partial read(). So we end
> 	  up issuing more reads, although sometimes pack-objects might
> 	  catch up and fill the pipe buffer, and we'd get a full packet
> 	  in one go. But depending on the timing, I wonder if things
> 	  could get choppy and we'd end up issuing a bunch of extra
> 	  reads (and possibly extra writes on the pack-objects side if
> 	  it's waiting on us to create more space in the pipe).

We would likely hit this issue if we insist on the buffer being
completely filled before sending it out. But that's why I adapted the
logic to say that we send out once we've filled it at least 2/3rds of
the pktline limit. So in your case above we wouldn't face an issue as
we'd already send the first 50kB, as it is smaller than 2/3rds of the
maximum length (~42kB).

That being said, you'll still be able to construct cases where we have
weird edge cases. For example if you consistently send one byte less
than 2/3rds of the capacity.

Patrick
