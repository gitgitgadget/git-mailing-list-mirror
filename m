Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0181158874
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 07:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758697225; cv=none; b=cYFguzLTgGN/IrrZ/q26cnwiLTRlc3T45aQ1sK7pdus5DggE/KGeCsKUSi8wMIK2bA/9bAnAjcx6+W1PmcNYRcu9N8WzLJ/F3rZMSegbMCLjKAVe8ow6Xy8fUU/G8nAPMG0QipLCT/QSpLeyZBNQWhxZ5EoSJxA4IeoSQGpM4Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758697225; c=relaxed/simple;
	bh=2kSO5W/o17jB4lryhHNaOItO9v8P2Yop3im7Zt8Ic8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SEB31OJzOWO6AlGp5FZWL9Ch6Y4MEh+/PLVSol0Ynqm7wcsSnTJaXtnnd1GK0acehxaAaXWaetLys6fnRsbSoo6SPwWYlzul+CJi1iPQTIZHNm2Y7MTap4UGDQlWUe/wJm+p/YLxblXcf6Gkq69HxqIGiVbm3+oGrBtoGmVcXLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GmLzU3YU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aFIY3TdU; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GmLzU3YU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aFIY3TdU"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0BDEB14000F8;
	Wed, 24 Sep 2025 03:00:22 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Wed, 24 Sep 2025 03:00:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758697222;
	 x=1758783622; bh=3DLD7BKT0y9jGURcrBwzMD+JKR+Qo2kuba8Y/mEUoqg=; b=
	GmLzU3YUVnXLX0rHx3ivXr6ezWDVfDEBSuc0oGCt4oKh0pw82P8wnawN3snU1oc2
	s5QdoeIHXxEL3tWB9/mRaFW6Qjkf96xn1nPPVC93V/f7pTxAMqkZNObEMJYuqAwP
	HWh2z9TXpyZGxCNQnRwxs2w/OrvChJj0K0Jx+yEtilTCAys3ZFARyws1bwRggM6Q
	pW8VjNZ9Z6QOjzayZ8BDf+83JHU6GTUQSpvJkIu4K5k6LPUP9baz/Jc/+PoCq2ga
	lElz9kYMDOTJBdG4g/BBpCverqr5PVgYt4JT3WxOlMGRNekbrNjro04GQaDL2tAj
	tdV0zHtmSX8vhfC4MVxNew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758697222; x=
	1758783622; bh=3DLD7BKT0y9jGURcrBwzMD+JKR+Qo2kuba8Y/mEUoqg=; b=a
	FIY3TdU0ejZDBtjZhIceE5Cyf90leHRVvhdjB07fk7Kz467N3iEDhLbnCaSR+vUE
	3pjnWMwa84M4ZxqhQ0AArXg+LQwKW6DE+8cuOi8YnGzmbKE6mbEJb3Ux9xnZzUcq
	xBcLxlIfs3zVvu4m91F6M63v2rE4nHLy43TBJPisvSTPay7ddWhkmSD04nTPzeZR
	QOjFWh1a0fLD5uTS4prnKjV3P7WTMyJBeUecauzmCfbLlD+Bhurg6fpmc1noWYhY
	RzK5LyISLSV74aYDztk0XNNtgXExFL2Yyv9zJsQoGpCcHDlUbcP8KpumoZ1aDmyv
	sHf/i6KHqnUG9xZ4T76UQ==
X-ME-Sender: <xms:BZfTaNvAoo_drAhvQZPLrxEHfU1mOVg0KLe6A-OyDKI5mUuNIUXPrg>
    <xme:BZfTaNefo3g9eYFFYiVWKlOT7Zp1_uzal0KEE4k1-uOFCglWebifFDIlTV1h-T3HU
    mX-ahH9o4GpJISl_lp8ssGn_D2k26uVloX663OmtVB_ALMk8C4mUg>
X-ME-Received: <xmr:BZfTaFxGZJn8pfrHmfY46a-z69oifXTpk56LHtYhCMH0rDWWcuPpQ6UyQIYxnL887Xa3jcQdojATYhwIB1pscTPH4m4tLvB0gcyxdmM7qw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeivdelhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epieetjeffhfeigeeuveefheejffegjeeftdeiieeljefhveeuvdfhvdegffeifeegnecu
    ffhomhgrihhnpehtrhhuvgdrphhsnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
    dprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehs
    iigvuggvrhdruggvvhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:BZfTaDGr2OTYtcUSCwN3JQlhoWYU4ojr0VqHbfsrPvA_0_1dSkgryQ>
    <xmx:BZfTaJwffBbqILhFj1-D2TdO5eiHRmBFR_o2eGKBQMI35vFb-6bsmw>
    <xmx:BZfTaEvrpdF60yc6cu2zryzsb6hoO4O-WiW9MmBJZEiKT4gGB7ezDA>
    <xmx:BZfTaG2kGdBs03az1Ivo7Q1bCCe3Yqdi5XFqEuf1VkSCIbD2z3wWkw>
    <xmx:BZfTaJR34Im3CeKhWv62kYnFWEuURMfkBOxHQJVsYeI_IUfbzShzM6VN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Sep 2025 03:00:20 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 51146da2 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 24 Sep 2025 07:00:19 +0000 (UTC)
Date: Wed, 24 Sep 2025 09:00:15 +0200
From: Patrick Steinhardt <ps@pks.im>
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: What's cooking in git.git (Sep 2025, #09; Mon, 22)
Message-ID: <aNOW_-uTmllVB9kS@pks.im>
References: <xmqqldm6qehe.fsf@gitster.g>
 <aNOTMtVC0ArCSTRS@szeder.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aNOTMtVC0ArCSTRS@szeder.dev>

On Wed, Sep 24, 2025 at 08:44:02AM +0200, SZEDER Gábor wrote:
> > * jt/odb-transaction (2025-09-16) 7 commits
> >  - odb: add transaction interface
> >  - object-file: update naming from bulk-checkin
> >  - object-file: relocate ODB transaction code
> >  - bulk-checkin: drop flush_odb_transaction()
> >  - builtin/update-index: end ODB transaction when --verbose is specified
> >  - bulk-checkin: remove ODB transaction nesting
> >  - Merge branch 'jt/de-global-bulk-checkin' into jt/odb-transaction
> > 
> >  Continue the work to build on the bulk-checkin infrastructure to
> >  create many objects at once in a transaction and abstract it into
> >  the generic object layer.
> > 
> >  Will merge to 'next'.
> >  source: <20250916182938.2193476-1-jltobler@gmail.com>
> 
> The merge of this topic into 'jch' modifies 'object-file.c' by
> replacing a call to reprepare_packed_git() with odb_reprepare(), but
> at that point the latter function doesn't exists yet, as it will only
> be introduced in 'ps/packfile-store', which is merged later.
> 
> Interestingly, when I tried to recreate the same merge I got a
> conflict only in 'odb.h', but not in 'object-file.c'.

True.

> > * ps/packfile-store (2025-09-15) 16 commits
> >  - packfile: refactor `get_packed_git_mru()` to work on packfile store
> >  - packfile: refactor `get_all_packs()` to work on packfile store
> >  - packfile: refactor `get_packed_git()` to work on packfile store
> >  - packfile: move `get_multi_pack_index()` into "midx.c"
> >  - packfile: introduce function to load and add packfiles
> >  - packfile: refactor `install_packed_git()` to work on packfile store
> >  - packfile: split up responsibilities of `reprepare_packed_git()`
> >  - packfile: refactor `prepare_packed_git()` to work on packfile store
> >  - packfile: reorder functions to avoid function declaration
> >  - odb: move kept cache into `struct packfile_store`
> >  - odb: move MRU list of packfiles into `struct packfile_store`
> >  - odb: move packfile map into `struct packfile_store`
> >  - odb: move initialization bit into `struct packfile_store`
> >  - odb: move list of packfiles into `struct packfile_store`
> >  - packfile: introduce a new `struct packfile_store`
> >  - Merge branch 'ps/object-store-midx-dedup-info' into ps/packfile-store
> > 
> >  Code clean-up around the in-core list of all the pack files and
> >  object database(s).
> > 
> >  Expecting a reroll.
> >  cf. <aMe_Zu1osrfDnSYL@pks.im>
> >  source: <20250915-b4-pks-packfiles-store-v5-0-d6340350934f@pks.im>

In any case, I've sent that reroll yesterday via [1]. There's only been
a couple of minor adjustments based on Justin's feedback, so maybe he
can do another review and then we call it a win and merge both series
down together?

Thanks!

Patrick

[1]: <20250923-b4-pks-packfiles-store-v6-0-b48f2a882759@pks.im>
