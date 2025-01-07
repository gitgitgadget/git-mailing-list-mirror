Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1354E1F03D3
	for <git@vger.kernel.org>; Tue,  7 Jan 2025 12:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736254107; cv=none; b=P5KLpRcEl1YmAFX9KkFG/VxS2cmLlwSEZWcFK9Nr2iNUSPHv/wZH/hj15fIH0gMBKFJ3n0iJpPc6Kcqavg0PKQ14k8m/bi7wHkobKty6K1SE+dIVl419+fMfflN/U9g9j+8L8FYenW+1THbs+zy4/mRurAcDU23P0wXiVLp6pI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736254107; c=relaxed/simple;
	bh=HICBpHz9+T7++QxtwCAbBADJhha3BIbyMb3/HhXHuwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CLKXvggRjyF4u+W0PV/lws9+1YYCGNYCdUdv87sUpZr/nxeQVa1gOXf+3Znk+6ZOPPfJ7gNIiGSQGpkCOerJPHAFcp1oAHQ8vFggzFRv+SX1LoFGnNTmTiPjfRdXnsw3vc/YtOhqUcrF1l/I2VEH71F0dxRYYlY8i0cn5y3qRaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=F+f3M/+1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eeIoxmcu; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="F+f3M/+1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eeIoxmcu"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 3E63B13800CB;
	Tue,  7 Jan 2025 07:48:23 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Tue, 07 Jan 2025 07:48:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1736254103; x=1736340503; bh=s40IGXNszK
	bvyRitrOI7ysGuwWT6X8IzRaonvClGCe8=; b=F+f3M/+19vhQ6Ebv94GGRP7M2N
	CE2eTMdBdjtX3AghmG/WGiYP6u6TfJLv8qAmFf9IWsWDjWGMdn33Zj9mt5O96IOR
	VIGKDXpqLOBkWCAvLUOLFNo+/wz7iDqGnqQsvbu95DlD78Iph4QOmcYt9kWlQxrk
	Zl4evmpimqU2+cygWCj2UgR4B16Ltnx5C4aS24zyuZauOcmIsm/dBYZyaxM+xzLK
	Dek1VAa31HxufeiiRUhpSG/1nfm4g8bmyJcyzb5YSWehHT9sfXRNzUK9FLcDf1m5
	Z3CJ6w7wBYF06AtKzI4H6lr25OqMEvtUXKVx9SqPUq0houcUtQMj7Bs278zA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736254103; x=1736340503; bh=s40IGXNszKbvyRitrOI7ysGuwWT6X8IzRao
	nvClGCe8=; b=eeIoxmcucpFirey/U1DcZpGV35j+0t6YCTbvJmU/vwX2l8gPzaT
	3TSeqObOnwtZf3nBt1Ap8WYvPB1EH9eziHfR7m1PfyMa2s95JdJMnwUy/h6jZdQI
	2eBN7ukVtT7OSiOPRw5k8oOC6jFC+7A8Yc+fauhzuZvJl3zGwcEYMs+yQq7LfXAB
	za2yzkGsQRZiNebsxun89pz4VSKmp950N24AtTzBKQbuU7R1s+hhCDx7ENxiEfX6
	nq08kMsgi3FpryvuhSA+nDRoTiQCWNSSgqyC8I0QFu4zS3GeOEGsQUvfJG232myK
	rPtnk3mnMzXJ9apc0XGjz25B6Hg2bpBI7zA==
X-ME-Sender: <xms:lyJ9Z0GQCuMs-qK0V8Bz5lTjEE9hpFnCKLhyh2sl4y1UiG1JB9vanw>
    <xme:lyJ9Z9Xt-8qrGFo5Rm2-zuHL9WG9voYLiFTItwPl70YShIhBgKnCMaKeeg5KjewtR
    OqR1t9RoUefF1F3TA>
X-ME-Received: <xmr:lyJ9Z-L5rbLCdFa7uSIFI_52v7K8mDX7-ixxVbhgQ7RVy321WV5N0set43sQ-SwFmf_K9_83WZDkajyie1VeGt15fuaxv0pccDLYoqnoqLAARQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegvddggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:lyJ9Z2Hdz_9fxSCju8OBQGCe_GC5-o6uLgjAkmytg-8UPfAAXW2ojw>
    <xmx:lyJ9Z6UsFhxNgjNXAyuvKGgt-6NGARUM6FG1VyleUrW8vDljp0KXiQ>
    <xmx:lyJ9Z5Pcj6B0VepblX4h4VTUbBuRiDDTnU9LG70Hd-TjgIZ6MUwU5w>
    <xmx:lyJ9Zx2OjuGwAZztHdwhlYu8_9wKnCCpESv2Z8A-Zq9ubWUWji_oNA>
    <xmx:lyJ9Z5QhciBai0lJ8JSdRMuBoZfpCPzqHk6Fuh4fNWvEAiFGlevz9gVc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jan 2025 07:48:22 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c861c114 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 7 Jan 2025 12:48:20 +0000 (UTC)
Date: Tue, 7 Jan 2025 13:48:19 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>
Subject: Re: [PATCH v2 0/5] remote: announce removal of "branches/" and
 "remotes/"
Message-ID: <Z30ik6NlYVMnNMpB@pks.im>
References: <20241211-pks-remote-branches-deprecation-v1-0-1431e2369135@pks.im>
 <20250106-pks-remote-branches-deprecation-v2-0-2ce87c053536@pks.im>
 <xmqqbjwk0x0e.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqbjwk0x0e.fsf@gitster.g>

On Mon, Jan 06, 2025 at 07:42:25AM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > back when Git was in its infancy, remotes were configured via separate
> > files in "branches/" (back in 2005). This mechanism was replaced later
> > that year with the "remotes/" directory. These mechanism have evenutally
> > been replaced by config-based remotes,...
> 
> Just a historical note, as I am not sure how much of it still
> matters.  In all of the above "replaced" is an incorrect verb to
> use.  "A more-powerful-but-different mechanism to do the same and
> more was introduced later" is a fair statement, though.
> 
> Specifically the ".git/branches/name" mechanism was never removed as
> it had one distinct advantage over all other mechanisms for users
> who have to juggle tons of remotes that change either their URLs or
> branch names or both not so infrequently.  Instead of having to edit
> files in .git/remotes/*, being able to say
> 
> 	$ ls .git/branches/*partialname*
> 	$ echo "$URL#$branch" >.git/branches/foo
> 	$ rm .git/brnaches/foo
> 
> was powerful.  Offhand I do not know if "git remote" command
> improved the usability aspect of newer mechanisms good enough
> to allow us to start using the verb "replace" here.

I would claim the fact that nobody nowadays knows about either of the
old mechanisms is a good indicator that git-remote(1) has indeed
completely replaced them. I'm happy to slightly reword it though, even
if it doesn't ultimately end up in any of the commits anyway :)

Patrick
