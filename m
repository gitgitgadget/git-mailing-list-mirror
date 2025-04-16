Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD76200B8A
	for <git@vger.kernel.org>; Wed, 16 Apr 2025 15:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744816091; cv=none; b=TYaVciQgbL0/tEiEDXh66j6F3NJouye66CWPuODvHGiE2Z4uwMWsK/4TVA3wpZUros7DpSdwp43miwW/YGZOh4fxDATts2lSerqvwGdft0CemiNSHvhFewGo870VmoABO66V4OHSwwWbSUXUjLXIIjhKcXyJgkfPF5k7yKhh0bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744816091; c=relaxed/simple;
	bh=u2jsDw2vi+9+bjlTFQX/DqB9vPJGAgjA8oOTe5T9VAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cUnp6HkR3HFzpqzc82bwFFN65vEfEICLZutlfDVel11WfkjoDaVjJqFKxEsir+ZdvvbeMW5KboxnA4JAw8E4+pvc7q3TBXqYuC1IKDbQOBsv7TIEAT6uJh0O2pPguIhLTYko90LvrsYfg/Sg7D34hFsVfWRKMUfL2Xe8adWx1uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HbzDg/Gu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RHSeXJDv; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HbzDg/Gu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RHSeXJDv"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 14D5B1140248;
	Wed, 16 Apr 2025 11:08:08 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 16 Apr 2025 11:08:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1744816087; x=1744902487; bh=eSOwpw4XWs
	svLd2rrSXVq2KxqTvvMZ80QUfFhi5fo/s=; b=HbzDg/Gu/4YHt/xUo1QoNmbP8m
	9aQtt82gW3BIwdhm0OWjqCtM8/iNVrCNRXdrEJEQo8maBl9xdAR9RZx1LCer17he
	x/XfmnS6vWXiDO6yzDRit0LZ8cUR1l6E0vaowhmqRR14YZxZI0R941fYS0nwTG54
	Am51/XvTEeZZcB5OzaMVs9dThydvI0CXtRVMgfvNtbYAclKi4ZN5zNtDB2jhnLL6
	0B4Rg0GTgi6BoVaiPNfT/6VXXohHtxOTCb57sBAnZ0VV9tKNJ6v9bKGlup84J2Bb
	S9T8biHmmPgDWVT0vSwIr3Z72TMFQKq7/QWo93nUY+CocgGmy+GissbzT8HQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744816087; x=1744902487; bh=eSOwpw4XWssvLd2rrSXVq2KxqTvvMZ80QUf
	Fhi5fo/s=; b=RHSeXJDvNyZPQntZrTQpquX3gtFSuWfCrIuxjEBxo+YtWjNayXI
	qnEfQgXPmPYTlI1s4K6/XgVYWBrNEKUv0dxZGAABzzHY4koXv6Hm5ciKy+hfcE1v
	nGeqQUPx7isJib1c49ZhNL+iQ94gaPe+WIJqB7Ps8quqczkZ47SANzDgjLhLtmtn
	5ugJ2+oY9juWnq+A4LZaITPeuxK9g4BwhK/KF2nSy0Hm3YIi/yMEVlB6/FHoCmYP
	z09+PFxQT8G4jmyIIqxKTu9968jE/2YPjtq7UgnaR9El4VxyHeaVaMMaVrl8dzCI
	cJ94uMs0Vhu7NKtZYd0VKu/AOCN8n97ScCw==
X-ME-Sender: <xms:18f_Z769HWyq4BYlYX1LohelLeNXhAH93g_PLvqRHXnSBACLVzYtyw>
    <xme:18f_Zw6aQLjuyqVzvti5hrO184y3bTU1G1IDtGmOfY8FeLvjx_hSkLm_Wrr4Rxg0S
    FRyrjpr6ACCZZKVZw>
X-ME-Received: <xmr:18f_ZyeEMp4BjFUnAlxyD4gPNQ1bsvrrM28udD2y6X0ourLKkD_V_D7kxx4f67o-WqRvED7yUmN0kGPK4TK9nKmVVy3eDQdfVkvDx6vZo61bSQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdeiieelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinh
    esghhmgidruggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:18f_Z8K6FKkIY1weYNy5znDtnl-HmS2tiTcI9ZMMHsxqjECiA3WKAA>
    <xmx:18f_Z_KUuUAkgAuuZJYECDxyYu7wTdxNZ9xFbRSo__WW4OoSBlxYIw>
    <xmx:18f_Z1xz1PYzpo-Rr41wAAtdn32ZrtDI-kZ0A7HdSfUETfooR9ZahA>
    <xmx:18f_Z7JXh4v4iKwzbR1AcitiXyU-RYr8xOOKczijX4iGL5u1JiWe1Q>
    <xmx:18f_Zxa5In-kG5FsPaeQsuTR3Hb6yrNVhFQ9gc0FIxl1rwF9-TFwoxqK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Apr 2025 11:08:06 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9cb04cc4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 16 Apr 2025 15:08:04 +0000 (UTC)
Date: Wed, 16 Apr 2025 17:07:59 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/4] request-pull: stop depending on Perl
Message-ID: <Z__Hz3D6d-4v_z7r@pks.im>
References: <20250415-b4-pks-drop-perl-v1-0-c6addf175858@pks.im>
 <20250415-b4-pks-drop-perl-v1-2-c6addf175858@pks.im>
 <xmqqtt6pmmd6.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqtt6pmmd6.fsf@gitster.g>

On Tue, Apr 15, 2025 at 09:16:05AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/git-request-pull.sh b/git-request-pull.sh
> > index 775ba8ea11a..59276fe265b 100755
> > --- a/git-request-pull.sh
> > +++ b/git-request-pull.sh
> > @@ -78,41 +78,47 @@ fi
> >  merge_base=$(git merge-base $baserev $headrev) ||
> >  die "fatal: No commits in common between $base and $head"
> >  
> > -# $head is the refname from the command line.
> > -# Find a ref with the same name as $head that exists at the remote
> > +find_matching_ref () {
> > +	while read sha1 ref
> > +	do
> > +		case "$ref" in
> > +		*"^{}")
> > +			ref="${ref%"^{}"}"
> > +			deref=true
> 
> This got a bit tighter (the original allowed ls-remote output to be
> later extended to throw "^something-else" at the end of line), which
> I do not know is something we need to worry about.  I think retaining
> the original semantics is easy in this case, e.g.,
> 
> 		*"^"?*)
> 			ref="${ref%"^*"}"

This should probably read `ref="${ref%"^"*}"`, with the `*` outside of
the quotes.

> or something, if we wanted to.  As this is meant to be faithful
> rewrite to lose Perl, not a bugfix to correct overly loose pattern
> matching in the original, I think we want to in this case.

Fair enough. It should've been at least mentioned in the commit message,
but let's instead just retain the current behaviour as suggested.

Patrick
