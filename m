Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2A05674E
	for <git@vger.kernel.org>; Thu, 22 Aug 2024 08:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724314803; cv=none; b=Grj6SEpsLuwjM0rg2tipCSUwgEZIQhKRoKQkdGAJhMrGW71Te5Y1UlWJW18qaXycKCgIAJcA/62yDZHKe4Mv9mqHHPRc9qE61XE54dD12iaJryKwCLX6r8dQeNmFoJXNvD1PQGFwYPDowmRreivoafXAsBxgyvuJ24XKMuvlGC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724314803; c=relaxed/simple;
	bh=+ijFG/xg3iKdh/pRRH6FEr6DS+JLiMFI/8GHoBecmTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X/ReCG6XZo60QSEU9CuayvWyQ++brgnbqm4YXU6lgrMwgY+cOWIIlEvyFI5P4PyTqYqs40zn78gtg+aGKbwZDX/D6GTUiONwTCLm96uX2wcjj5DUiAoxtqON8qmmkHdJzcfcoDNuF7Ksru1XKvw1kZdSoJZ2zxzrnJ3Wt1QKzZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=c5GNh64k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DMz9BSKM; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="c5GNh64k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DMz9BSKM"
Received: from phl-compute-07.internal (phl-compute-07.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id DF8C513900A2;
	Thu, 22 Aug 2024 04:20:00 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Thu, 22 Aug 2024 04:20:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724314800; x=1724401200; bh=n3O5+GQWCN
	dfQvNA8RPK4+8YObCgwzY9iWd1Dlf6Aq0=; b=c5GNh64k3ChCmQHQ6QlAdaH8Nh
	VwxH3KnXruluW0M77O2YnfAPJFadFNo9Wdb/HIXLFzfUHKASPx6Ys2o9bcwNZEui
	+nu17etAOpFIaPJi6Be6Au33klqaviSwJtNNXv4sV9rR4V047Y60TSQpwVsCo210
	DUM14jHYUZrX/fQhHAfOzk6BZxNqTN0XShpJw/F+ETEBFCNtW/jkVJnbnJS4QiuN
	9Nlupx1S027Lt7Xsbu7BuhqQtCZELBEYTD0hDvAipwQHtjK60n3hlMsRo6WmOZyM
	0REAjoMy2ZFG/TmhSAstWmRZ4GC9Zi8L2KPC1E4MfC7wXKitlDGe7M0ey3aA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724314800; x=1724401200; bh=n3O5+GQWCNdfQvNA8RPK4+8YObCg
	wzY9iWd1Dlf6Aq0=; b=DMz9BSKMYD05Z8hW+pzNHi08bwvfXwDPinObpTFr4QWl
	vGu5p1H5QtrqQIFF3bgRTRlB7wXcQJScAbXnMDoQa0Ekkf3xOde6v7MP7THK8RN3
	PXYFSehLgGBCcCUV4IpM8So18mbWm1XyC4XTSxdmNZd6QYjXTVtFqMOFoYH5pbPI
	raeWmCsFS6DAbd2FpIrGP0V65XKrRDh1POnF5ygg2pTup8wgVbthfmEZ4PRRNMV2
	hWoercT8WwE73BwceuxKYIjwpLJU0H+QSFRXZ6C0PontyV7P0N7rbksC/PzaHZkL
	uSrk+JmL6BwrZC/MYbpwBRbRLoZpkUVZfOO+KpdG6A==
X-ME-Sender: <xms:sPTGZhwr_UZKvY1VDUE5mTH2_pg57C6VNKq3kuoeMva-NEYUnwIrLw>
    <xme:sPTGZhSfTPyDJDma80ccsjEKeq1Fd98X6uEvsptittLSCS5GEQ7T54joHVGgOXuBZ
    oPWuO_hF46Q1VVHnw>
X-ME-Received: <xmr:sPTGZrULXDluZetwyNL_xriCgvQZAYtqJ2WaahCzPVF41zrI2Luv_hO266Q0lT_CYyrcUMyjxs0GMYFKvmYhOaTA4pn3IZJ0MmIYt1tZzYp0CPM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvtddgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:sPTGZjgGdSQ85amWkADg0bfRoh5zqcdLjXtDhiNmvxC8mgtoQvPWlg>
    <xmx:sPTGZjC6TTHlMFlOYDPSAkGxqgqjvqYbCtJnD1Xa1U5yKI1OBVtcQQ>
    <xmx:sPTGZsIChphuLvvElvFtC_Di0gNu_60FrYs6D2HedW2Ev-2fSPMQwA>
    <xmx:sPTGZiAK_5CmHyeylUecQl_wmM52f4VB_U7NKNH_XS0w5HTMr8atlQ>
    <xmx:sPTGZmPdYxcXSOvYHYjezCyNvzmxBz5M5IWJO4Uq2ZsOldN122w6X1kQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Aug 2024 04:20:00 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0264b0ef (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 22 Aug 2024 08:19:25 +0000 (UTC)
Date: Thu, 22 Aug 2024 10:19:58 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 13/20] sideband: fix leaks when configuring sideband
 colors
Message-ID: <Zsb0rn6cghJB6V--@tanuki>
References: <cover.1724159575.git.ps@pks.im>
 <5d09959b6426e53a68e1bce547f9507bdf21bcde.1724159575.git.ps@pks.im>
 <xmqqv7zu3g6c.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqv7zu3g6c.fsf@gitster.g>

On Tue, Aug 20, 2024 at 04:52:59PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > We read a bunch of configs in `use_sideband_colors()` to configure the
> > colors that Git should use. We never free the strings read from the
> > config though, causing memory leaks. Fix those.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  sideband.c                          | 8 +++++---
> >  t/t5409-colorize-remote-messages.sh | 1 +
> >  2 files changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/sideband.c b/sideband.c
> > index 5d8907151fe..deb6ec0a8b7 100644
> > --- a/sideband.c
> > +++ b/sideband.c
> > @@ -30,7 +30,7 @@ static int use_sideband_colors(void)
> >  
> >  	const char *key = "color.remote";
> >  	struct strbuf sb = STRBUF_INIT;
> > -	char *value;
> > +	char *value = NULL;
> 
> Hmph, this is a bit unfortunate.  If there is no configuration
> variable, on the first call to this function, we come to the end of
> if/else cascade and we need to free.
> 
> Another possibility to convey the intention better may be to assign
> NULL to value after the "we already know the value, so return early"
> took place.

There is an even better option: just use `git_config_get_string_tmp()`.
Then we don't have to worry about freeing the strings at all.

Patrick
