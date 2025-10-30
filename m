Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD77D33508C
	for <git@vger.kernel.org>; Thu, 30 Oct 2025 08:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761814746; cv=none; b=IkEYgZ7tUgGbQ8UKc/lZw3aCXrfOQ1QV4eTSBePL7EWvPZv2bC0ChLnFYK8m8GXBcJc1lVFARzmZB8nSPuGHwjYnighzLwb7SSU3djOYo8BWbTeDwvkODuW9CYufp1KB5BtcF46VhGtDJeU5fmQIFRZVkKdSAxef/k/CM6S6Gfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761814746; c=relaxed/simple;
	bh=wRoTcM617Ia1IMjcentRuhjwFZlxXa0U9khAkLNKdz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cVYufZB5BnQcc07Bfr3q/IXafjAuOt5aKjPYTxsifOAHQXdSn5YtM91+lrgVKAk/OyZ+zxigr+eW8tnQy9k4IHBUi7/V4AYLvl3w21QYc7hfkDhymyhx6g1neQUdDOFJfX+4HU1uVjrheGqGQww8E2nyLqB8qXh9lVUjC6uOPkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=k4bts5aV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vTEYWnwf; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="k4bts5aV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vTEYWnwf"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CDB69140015E;
	Thu, 30 Oct 2025 04:59:02 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 30 Oct 2025 04:59:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1761814742; x=1761901142; bh=co/zB0CTL4
	jn6EVKjki3miZmaTDXvG0UF2ltTn0tq/c=; b=k4bts5aVe8GEt9cQ+TI2N0hbMr
	tq0AnbUiW6B6DsxxvXCLD7WZ0JasMbmCk8/WxxS01cZwFCBAMCy+pnA4pbF1XLh2
	5Sxqf3lHJp71tiUx/c37hUecGyS9wx61KPweN5f/dGRAsVkYVAZYrLtgFPhax5c0
	NFWj8o7H/jUJhFT+BG0mZW32dQ3eIDvz3d8hv2v3QVtmncgLh1D7ymNKpnaP7hpL
	vctGWhm4kDNB9Fh53NH6y2q5lnyJWHgEiE1u6Aul7GSKyqRqSvLf6LLzKGRa7k8U
	FWEkqVpmeT/WK36dF/EawIywlsFkG/YtvfJhU2VeraGVhNkND0EN8GbZKsFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761814742; x=1761901142; bh=co/zB0CTL4jn6EVKjki3miZmaTDXvG0UF2l
	tTn0tq/c=; b=vTEYWnwfTOJy3QnjWXpkAjEiDyiPTcRHqZrTo9Jv4KUVAFi8Bo5
	DHDMululwqM9Pt3Z04nHjmXXyYfwu7J7jVmgN8jvwT3DqHsfd8ayPkmKkaGGVgzU
	abAeTQ0maAtGcbA+rW2tRH+9idCYOLDzE41wjFjCXHtqh/C4WSpca3G54KakKr2p
	8qM7r9Djb0fsKYTRQFk2xVXFycUXdOJZaQgwOuY3mqf8oNuHJpRTRcYew75P2hW3
	dWfMD2O0vbYwtljomL0Ft8vvdi580G+ZzL8TiNZIC0T54MiGdIDKVuJ8teWI/Xn7
	SU6DpR3kdyxnXyzbDuAJY5Ljl6/ovmDMaew==
X-ME-Sender: <xms:1igDaXCr193Vvhb0LdAPkEfahwSDNYg7z8TB6w_47P3DqMteyZCO9g>
    <xme:1igDaU-W7BXKqY28Hx2t7_lngbhTV0K6O2GAwwTebIUooqMzj_8_b_4MGHUWt9X_c
    VChK_VKBnLrxGcf_M6fyYrVNiYnQOFBBScLvbiGmo7vZpb0S_4shQ>
X-ME-Received: <xmr:1igDaf8BGSyp69XyvVvNDA6cCTKpSh1f0IYXyao28EfC4sESrbNNErhbYKRuu6rQJ6hmhIrX6hKcJECNoPFz9jqFNl2qn74I81f8Yj9VZQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieeiudelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedunecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehpvg
    hffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:1igDaTd3TyBDw7Xbs1Pk7beknuWiFSuVCMEG5Kr4UVcDy26PmZDwbQ>
    <xmx:1igDaQGoBip3BwcXDiHWM9aAUMNLrY5PHnMGjK9GMsqpOO9eWvm5xA>
    <xmx:1igDaZfvQ6kC6i2UxjMEDSzoJZHDUBpVmO3IOsGWCCE7gTOWgM5XuA>
    <xmx:1igDaSG3NVqhZkf4yQfLnqaDN5x3pLqx8Nx8HkI807O1UB0nDkJhTQ>
    <xmx:1igDaYb7aElJzUgLIP3eQiyiE_aqQZyJGzoUrWAXyR9dQmf6BACYU0wg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Oct 2025 04:59:01 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4b66b5b8 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 30 Oct 2025 08:59:01 +0000 (UTC)
Date: Thu, 30 Oct 2025 09:58:57 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 5/8] builtin/pack-objects: simplify logic to find kept or
 nonlocal objects
Message-ID: <aQMo0QJUPWqkbRNC@pks.im>
References: <20251028-pks-packfiles-store-drop-list-v1-0-1a3b82030a7a@pks.im>
 <20251028-pks-packfiles-store-drop-list-v1-5-1a3b82030a7a@pks.im>
 <aQKfnd2gWS2T9GaD@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQKfnd2gWS2T9GaD@nand.local>

On Wed, Oct 29, 2025 at 07:13:33PM -0400, Taylor Blau wrote:
> On Tue, Oct 28, 2025 at 12:08:35PM +0100, Patrick Steinhardt wrote:
> > @@ -4388,27 +4388,27 @@ static void add_unreachable_loose_objects(struct rev_info *revs)
> > -	while (p) {
> > -		if ((!p->pack_local || p->pack_keep ||
> > -				p->pack_keep_in_core) &&
> > -			find_pack_entry_one(oid, p)) {
> > +	repo_for_each_pack(the_repository, p) {
> > +		if ((!p->pack_local || p->pack_keep || p->pack_keep_in_core) &&
> > +		    find_pack_entry_one(oid, p)) {
> >  			last_found = p;
> >  			return 1;
> >  		}
> > -		if (p == last_found)
> > -			p = packfile_store_get_packs(packs);
> > -		else
> > -			p = p->next;
> > -		if (p == last_found)
> > -			p = p->next;
> > +
> > +		/*
> > +		 * We have already checked `last_found`, so there is no need to
> > +		 * re-check here.
> > +		 */
> > +		if (p == last_found && last_found != (void *)1)
> > +			continue;
> 
> Can 'p' ever be (void *)1 here? I would imagine not since this is coming
> from repo_for_each_pack(), so I think it would suffice to limit this
> conditional to just "if (p == last_found)".

Oh, you're right of course, will adapt.

Furthermore, do we even need the `(void *)1` thingy? I think it should
be perfectly fine to instead use a `NULL` pointer here. A valid pack
obviously cannot be a `NULL` pointer, so the sentinel feels kind of
pointless to me.

> Otherwise looks good. I think you could make use of the kept_cache here
> at least for the local-but-kept packs, but what you wrote is definitely
> an improvement in readability.

Makes sense. I'll leave this out of this series though as a #leftoverbit
for a future patch series :)

Thanks!

Patrick
