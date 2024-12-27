Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8848A80BFF
	for <git@vger.kernel.org>; Fri, 27 Dec 2024 10:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735294557; cv=none; b=a+/paNSfbttv50SFwxqnqP0ebwHKvBp0NTydTVWHUJEMy5IvldvlTWSB978VJyZGyrSeT98nifCuCqwGy+4IwbFu28++6iiSFR+3nSMHZ6txF2PFlvwDrSdsxXsA/Ks0SrgBuvmpl6AdsLsEdqNW8mYAt22gKEkhG6NT84vtSVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735294557; c=relaxed/simple;
	bh=rQPX+5cBS/AdegMoaYPWJb5VhFD1D1a1T9wlv70mk2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nZjywuATbrM/6wjHN7WCNNIDub0/9l6hJEQ99GzDOog4H2H9lSZqM1fhGUOIJTEguoceYYecdGshsvpJ9JPBk4i8I/+qdcgcU23eAgbhyoo1JstbiNC1TWrXDsh0wfL+0/+eNEU5m1v4Bpn0eyJuXx1WRudT07DAymfCAd5OGnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=uWyYttGg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oHGFeqHW; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="uWyYttGg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oHGFeqHW"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 55DC011400B9;
	Fri, 27 Dec 2024 05:15:53 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 27 Dec 2024 05:15:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1735294553; x=1735380953; bh=DXvcui662Q
	w9/gUF4u+wCbeFClqhRM3IhBw5NnofXUM=; b=uWyYttGg5TiCAxbt85Cr2Rssnt
	PivkL96Z2fjWJ0iYkWjnL6hALEH3/BU6RdQqQz1rOCSiC2SpT/bbKuHjrGPxf6DI
	whacGoWzgr0CQ/S9nh3vG5XgdYPbKp9vn0PMyqGsCsmvQNmeTgHXoEIGc08xG6IW
	GoUsmQfqhdjSdfWI9qpUZUkq8qSMjr4dzrb2TuBeqBbxxfkrUAC5thP8jNZ9hwwL
	rNxE6hPA0pYFUOPUxr36nCLf2K3nyTyhXg9xJ1IJMYyXeysP3mTCK125rf1w8k+3
	KWz8ugmJZnQ0Iqh3Zt3GUmVmEksH2Y9PECPGDEwJutpYETtwnOHhdX12y7AQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1735294553; x=1735380953; bh=DXvcui662Qw9/gUF4u+wCbeFClqhRM3IhBw
	5NnofXUM=; b=oHGFeqHW3+9YRSXj+1Kwzk/kKb4ar6qaNiztH+6PwwPC0rnfTjf
	sQ6iM5pjvQ+d4PWXHuDmGMiEh3mTHq/ci+L//mfuwtHo3+kpQWLxDieUOqvBv6Xu
	ZsbUd2lbTGgi9dqwVcQ+r6wj/emCZ8aT3RNARMmm3NJeQA2eepCOMIlpv2Ly+mHj
	tkTjfipsWFGB0izU8HoqxG6k6U2H4IlgfTUR4n1AwQAhn6YEP5tNyisxXnZpNv+y
	0B0u90KUzHbQcY5JanK0y7YT3LFehAIoDafe+VbPgLOND0wY5Ce8jmSem1lEPBJ0
	pzQRWvmOHZj0sQ2xEAWFguN4IKMwEvQiZ5w==
X-ME-Sender: <xms:WX5uZwBwP8Wtr1A7oZ4fuhOqCp-AoIsGq__TUzuL8Fz338sqkAprkg>
    <xme:WX5uZyjMmIJZW3gsCPeVdNaq9pNbfHnaFLjF26FFJw5OEyp16cPq2lnDUZspKVAFW
    aoYBI4DUV5PwtQDnQ>
X-ME-Received: <xmr:WX5uZzk1u76f7-gvssvW9uv8luKmr-ZU1krMIXJl9BiFVK_7Ep_9LiW4yRphx2d8GHMkZEvU7bszPWhktKTbm1JzdbtlLWDjpywIBTO67jrGsg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvtddgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhes
    phgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:WX5uZ2xL9ion_gFi1KjDP4sV2JqcQmUOAirkrNmIW5kVyF0uS4VZbg>
    <xmx:WX5uZ1TpdP7FdKvtxGV2BIaG2sPwT_wiDm7lU0oIFF5C791fKG_9AA>
    <xmx:WX5uZxZtv9Od6PkMIRUTxnQ2IFvP7v6jx-GXoreiuTdOiGIIqk_1-Q>
    <xmx:WX5uZ-THaDvbwAK5lQLjlVl64ccQY5HfHCErjkCNWOUYfCQjT9f1sA>
    <xmx:WX5uZwdN7AtLjW__AFDkQ613Ugrq_JTN1VZOC7kOERZ6XB9jwqfJCnWA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Dec 2024 05:15:52 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9baca953 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 27 Dec 2024 10:13:47 +0000 (UTC)
Date: Fri, 27 Dec 2024 11:15:31 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] prio-queue: use size_t rather than int for size
Message-ID: <Z25-PaOQg7lAeyxx@pks.im>
References: <20241220084949.GA132704@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241220084949.GA132704@coredump.intra.peff.net>

On Fri, Dec 20, 2024 at 03:49:49AM -0500, Jeff King wrote:
[snip]
>   4. The insertion_ctr variable is currently unsigned, but can likewise
>      grow (it is actually worse, because adding and removing an element
>      many times will keep increasing the counter, even though "nr" does
>      not). I've bumped that to size_t here, as well.

I agree that bumping it to `size_t` would be sensible, but it doesn't
look like you actually followed through with that change, as...

> diff --git a/prio-queue.h b/prio-queue.h
> index 4f9a37e6be..36f370625f 100644
> --- a/prio-queue.h
> +++ b/prio-queue.h
> @@ -30,7 +30,7 @@ struct prio_queue {
>  	prio_queue_compare_fn compare;
>  	unsigned insertion_ctr;

... it still says `unsigned` here.

I was surprised by how few callers there are required any changes due to
`.nr` changing. I scanned through the code and found one more instance
where we have to adapt code, in commit-reach.c:queue_has_nonstale(). The
compiler does not generate warnings for this case because the file isn't
-Wsign-compare clean yet.

Anyway, I see that the patch has landed in "master" already. Let me send
a follow-up patch series to fix both issues.

Patrick
