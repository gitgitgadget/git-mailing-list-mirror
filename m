Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B957E32D0E2
	for <git@vger.kernel.org>; Thu, 30 Oct 2025 08:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761814736; cv=none; b=GgtSurC7fnq3RQMMfrIqBS4QfQmcuzJj9Hz5WSMZhDdDoav0dPUnMIjFcgq/qZ2EKDNN9U+yDoDA1/LVWB+Acj+WdBBxG1aomtd/98vfH4dbbD0z/pOZ7RGNmcNT5H3yNG9aSop9l6ehmYetU69tuAg+d5PT3eYdFx7vUZBVvIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761814736; c=relaxed/simple;
	bh=VjtBZ+S+DifRNeg1/09YUEPGJXXzr6G1obtjKijrlo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sgxprDPhAnxGRYrZonama7Bf74J5R+s5ql7YFIabbQ421DSc/2zqXpiX5fHEQB3SmWC0BivZfHRV355uVlA9tKQfTEow5TypP3BEUhryhSreNQhBpdc7ynvKI+9Gl3yK2VwofebfMxep6U0lIulEhZZj27do8h3c90lWRd7Awbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=o+hIGgDy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xOPceoVo; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="o+hIGgDy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xOPceoVo"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id C76DCEC0102;
	Thu, 30 Oct 2025 04:58:53 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 30 Oct 2025 04:58:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1761814733; x=1761901133; bh=SUqF5IsmjZ
	aU8HzuuivtS/2/di27obXMZT+O/T8kX3I=; b=o+hIGgDyzI8w1+P7VfTW4ARoey
	V4x0vOsWwabs/luYi+goe9/lo/qcNRUZ13XA/NLn+J9oApSDrbtYT8erUc4BT6xs
	0VuukDdFzPT+hk6JcdYDG0G2WAP+xC7ofxtKqfjF2FtSM2ZaGFKM8v+hZ0lZm/pN
	92efR+PcgzoJ0olP7n4qfL+utAkQhQGq5bZrUkGzkJv19C+Lhxlpt89XEOUUojhB
	NtOZzYOlAFgX6+UCTGHgEtn6VyVtZlie4P0CXgdGQwz7JZ5wkTU1Nhd6kGIEfoIB
	clt1FAHemTwmH0fCcp94xcseTNvvQkIDwf+feWNEsDB7k93WRb+oC1919tWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761814733; x=1761901133; bh=SUqF5IsmjZaU8HzuuivtS/2/di27obXMZT+
	O/T8kX3I=; b=xOPceoVoJ29Q0p3dKN5tSf2eRLcdixrPbYgss6FZRtxew7VlFKu
	zZ1pfB99UB5nMv4Qh4QVN6RjfMvS0h6d0J71ON9X5ZqOVdFTQTW//11Ofjb6vi1z
	r9Z1ULB98z5MBCdi6HTSSbjKQ2uGnzjSWLrOihMbSEdATwL9mY8Xe7PSGCb/ECW7
	WV09t4LZReqSeJgA43VlIxL0z9CQHpaW9/Egr96ck92v0B6RlIkUG0cXTd9r5GoX
	Iq3aF48lWjGonkIUKyqz33bvaw0pinP31EBT9Xcx+n38aV/ixr4onUqyWdBfayU/
	6gCMznFZD9wE+ay7Mwkc1EpqwBXlEcbGmqQ==
X-ME-Sender: <xms:zSgDabZhD4U3d5VRzCLCaoHaBhfWKRsCUEukx0ds4TDd7-ZJM6svGA>
    <xme:zSgDaR0W8BLvkr9_vC36ZgFDgp0lhVhRaQPWGeN6LQADZyxk_dSOY3Qbhn1gT7Hj4
    KDp1-c4Qb_yJul1sD6u6Dy6seOBYUZdn6q4IW0PsY3Jui_5hBLL>
X-ME-Received: <xmr:zSgDabWAUYFbEFIRTgDa06pmX9ERtQq1sXV2ptJegjtvYtZv8FJEpJIuGXS0CNMvRm7ePSOXPx8zwepp-VXt5O1xhrMA6N_7OP_6PQ27fg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieeiudelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehpvg
    hffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:zSgDabXu_M5L1a3A-pXr7-QrUadi2ayVtPfRTwyLEi-ApBWtjWE-Zw>
    <xmx:zSgDaae8Zc_x6ZTGx4rEa-2tcGdCdrpYHqDCETsge96PfGEFGbUN4A>
    <xmx:zSgDaUXeVHzNPQQFLuEbN_dv95lZAMxSlwS51CjBAmNOUQ3OKauk8Q>
    <xmx:zSgDaTerQ1sLHEpSlO4B9tre-8bSe60CJVq23Q9X-a8G0cg84sfc4A>
    <xmx:zSgDaTRIA7BbjX_aJeClKmSJEPkUNUTEFxKVp_3o8gAmxmzMoInKXteD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Oct 2025 04:58:52 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 19abc1e6 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 30 Oct 2025 08:58:52 +0000 (UTC)
Date: Thu, 30 Oct 2025 09:58:49 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 7/8] packfile: always add packfiles to MRU when adding a
 pack
Message-ID: <aQMoyQAAeMD5WPxu@pks.im>
References: <20251028-pks-packfiles-store-drop-list-v1-0-1a3b82030a7a@pks.im>
 <20251028-pks-packfiles-store-drop-list-v1-7-1a3b82030a7a@pks.im>
 <aQKiT9JA+3zF4DHA@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQKiT9JA+3zF4DHA@nand.local>

On Wed, Oct 29, 2025 at 07:25:03PM -0400, Taylor Blau wrote:
> On Tue, Oct 28, 2025 at 12:08:37PM +0100, Patrick Steinhardt wrote:
> > When adding a packfile to it store we add it both to the list and map of
> > packfiles, but we don't append it to the most-recently-used list of
> > packs. We do know to add the packfile to the MRU list as soon as we
> > access any of its objects, but in between we're being inconistent. It
> > doesn't help that there are some subsystems that _do_ add the packfile
> > to the MRU after having added it, which only adds to the confusion.
> >
> > Refactor the code so that we unconditionally add packfiles to the MRU
> > when adding them to a packfile store.
> 
> Reading this, I thought that the MRU cache lazily added packs only upon
> a successful object lookup, but looking more closely,
> packfile_store_prepare_mru() adds all of the known packs to the MRU
> cache eagerly.

Hm, you're right, this description is quite misleading.

Overall it's a mixed bag. We do add packfiles to the MRU initially via
`packfile_store_prepare_mru()` as you mention. But there are direct and
indirect callers of `packfile_store_add_pack()` that don't:

  - "builtin/index-pack.c"
  - "builtin/fast-import.c"
  - "http.c"

In all of these cases we expect that the objects will be read, so there
is no reason to not have them in the MRU as far as I can see.

Will rewrite the commit message, thanks!

Patrick
