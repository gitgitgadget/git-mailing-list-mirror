Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDC7208A7
	for <git@vger.kernel.org>; Mon,  3 Feb 2025 15:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738594933; cv=none; b=dUZuhVoXA7HwmC9RwzWAU58D4VMNv16tUIBz4YM40ULDHvCT5rxRGHJK7NKinxrHnTahfs+cGkjb8EwRV/4bro3acYSR5CznBqdWHJlA+3fsM5Y4MYZt9niOfob1Hy0qy/fVFpxGpbi4e2ScDRLv/SdPg3B3FO3OMNEzCj7GO9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738594933; c=relaxed/simple;
	bh=Rz0GMjSzyt11VgQEus+OAzDGlUE0/hgTkU4LfVA7Lmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SmI8gLdGGwjKiLrudh8lrOdxfi3cUDtboLkggreRdZD9eubnwg9Q+0UNWp3Ls40XT+6QbyJtkewY/KHghmvZz4nOwa4Tg8TDJAjVPx7EWq0sTKJJDJ+mUgTOQZKoMRteVep4bjpHDV6/61CsFhbSvPuzt3RrKURPnHbCoPMmSFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JWz0rSIL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dnGqbIV6; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JWz0rSIL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dnGqbIV6"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 24E8A114015A;
	Mon,  3 Feb 2025 10:02:10 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 03 Feb 2025 10:02:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1738594930; x=1738681330; bh=nOA1HnSsc/
	0dcKc381eRmphea2AvB4Kg8qw9JYRzlVo=; b=JWz0rSILsE09u8OV0NLtMugmVi
	oAQI+RcdjvUHsO2WNjxhQc6AOfuIGgRv+18mZOQ0OKD1JD69m8WUZsdLr4GU/Iao
	MHyFKnDBnewG2w+uGdyY+VQwurR4UrZtLe1/6S0dViLqekL9eF91TYXDNOGsOiFn
	yW/mDtdqYEEWR0jN9XPHIrjijy3heQ+C1Mqcy3a1w6hKhNiAotgx5Y28oQmbKfyY
	hjAvSMB++ILbwnaSYM7iffGB+BCt8e+qqqxXpQctga/ToSVwLYz0LBs3gXESLFIR
	k2t7pQZo4ujekrEM5E8a+jKVo3EUEnDCGZqbiP74AcmMusdgZYy8lvSCvE6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738594930; x=1738681330; bh=nOA1HnSsc/0dcKc381eRmphea2AvB4Kg8qw
	9JYRzlVo=; b=dnGqbIV64bRZZHcI5zAf52AAkd5XngH8xP4M5pNW4TpwLAvDgEp
	O2V+NADm5QQbMpzFN2p7xABiDlnWsQecMn5b9AaS/pc7LFfMyKQcdWbHF7AiAgiD
	vLt3sryku2zgbF4H6FzwbSu0g8wDwPLCgYusWDHkMgFXZapoBJ1IBh4vZ9Ev1UMy
	QIIe5cr+6+nViHPXk8TKcoylJOqem7itMbi92EwXVYe7EYzQVW3CdcTvUUfjQcmE
	zjcKwNrDfVuxWBM5Xeu3FnmJZGK8PGSAzNCaMRkXUEgj6bu0A512jUzZZxm0CLzQ
	qF+4j/+l76Wmyk1Lm/PPDp3R0SuP3QLiLkg==
X-ME-Sender: <xms:cdqgZ-0xrl9HdiHgYYP1Bm-g9iLCek_FnmCO946wWInu5GMfxp-kAQ>
    <xme:cdqgZxFMeBLCegECx02aOkH2JUkcEZq1aTSL794cl82keB5ZrWKNAg9HnTV90SotH
    w2TFiQT-Wlggt8rrQ>
X-ME-Received: <xmr:cdqgZ24BnMYppz3bpsoESxLkozSi3h8FyhoGWTVd9ZBTWjXXXJEDIqVjT5gsldeB-EOMAk56jR37fbOekmfo1n_Rhi7w9SqXjjWhWYVhfviTuA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujeeludcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepveekkeffhf
    eitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhm
X-ME-Proxy: <xmx:cdqgZ_3bALQXJPhh8O6bQZsN3miB2RbSEKhkdsPa0QUfP8rW0o00Mw>
    <xmx:cdqgZxG9gtleu4JohPamJEkftPWGQ92cnBqTNMKB_sZdhYOaVIk22w>
    <xmx:cdqgZ49iGp05AhcwmO1dUNFbTJsLGxn4aIdMlleScLzrrpRcxVH0sA>
    <xmx:cdqgZ2kCOulvbzt5w5v7z0pj0wqbyO2EYpceoY3dBybg6EqVWsP_6Q>
    <xmx:ctqgZ2T7h9x4EpnB5PAJHhu7dbCKrToUQAlJLkkuRVPLJ-D0EeiPB4lH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Feb 2025 10:02:09 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c5cf227e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Feb 2025 15:02:06 +0000 (UTC)
Date: Mon, 3 Feb 2025 16:02:05 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/3] setup: fix reinit of repos with incompatible
 GIT_DEFAULT_REF_FORMAT
Message-ID: <Z6DabWZqB5QJed3F@pks.im>
References: <20250130-b4-pks-reinit-default-ref-format-v1-0-d2769ca01207@pks.im>
 <20250130-b4-pks-reinit-default-ref-format-v1-2-d2769ca01207@pks.im>
 <xmqqv7tu623n.fsf@gitster.g>
 <Z6BUOs7k1rzGOGTN@pks.im>
 <xmqqikpryvnm.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqikpryvnm.fsf@gitster.g>

On Mon, Feb 03, 2025 at 06:01:33AM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > So from my point of view we should treat the environment variables the
> > same as we treat "init.defaultRefFormat" and "init.defaultObjectFormat".
> > Those indicate defaults, but do not cause us to change the format of
> > existing repostiories.
> 
> Hmph, as somebody who often does things like
> 
>     $ GIT_EDITOR=: git do-something
>     $ GIT_AUTHOR_NAME=foo GIT_AUTHOR_EMAIL=bar@baz git commit -a
> 
> I do not necessarily see the environment variables as replacement
> for configured defaults.  They are, at least to me, more like a
> single-shot override of the configured defaults, so if we were to
> complain and error out command line options (we do do so, don't we?),
> I would expect the environment variable that gives a single-shot
> setting to be treated the same way.

Especially the second one is a good example though that works mostly as
I propose: GIT_AUTHOR_NAME will impact _new_ commits, but not _existing_
ones when you for example `--amend` the commit. So this is somewhat
equivalent to how both GIT_DEFAULT_REF_FORMAT and GIT_DEFAULT_HASH work
with git-init(1), isn't it?

Patrick
