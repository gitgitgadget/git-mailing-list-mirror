Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0621E260A
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 08:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741766797; cv=none; b=UhoVIqF2neo4IZrYVqh4Br23tfdde4//6ZT/9hpulKXVjLF+ByMHJb/TreQ1GV1QNZ5xt+vIsennPz7tg/Ef10xxRyiVYLGRm+7+5SMp7DnHkpri9F0Q5QITbNDKD3ZWV8VbQIMvSCbYmkBk0mSvhnX0imbFrUKqtLajwko7dmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741766797; c=relaxed/simple;
	bh=OTaNIOX0nSZWIRZu+wzvcf1iDUHKqwEFSsnhrvDQBtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LhDyGah7cVmaFoa+gpTBKDb43S5uZPrbWc9rBN2z0Iu29TcQCJL7eqQbGF1B8g6uO7P9dfyUYwZoChYJrs5nyPSy13UVwY+VOKtZL8S8mG/v7uqR4wRrZyakE9/IsPfNyiYbnRAxUdUoZXsgrVqF0HrzutIvUaWINTO67jT6eco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gD7/S7KZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P/4Voa6X; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gD7/S7KZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P/4Voa6X"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5D88325402A4;
	Wed, 12 Mar 2025 04:06:34 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Wed, 12 Mar 2025 04:06:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1741766794; x=1741853194; bh=clX0xCQ7vs
	9apA6EQQWrO0K5i1N6uWcLW+aJPl0biQk=; b=gD7/S7KZUkyuvideGZamoILXas
	0d+1B14Bjf0FTFjkUHf5TSauNYsuKLxE/Nzj5H2o8fKwKY5qgRvnya8mk2+myn2A
	YA7DgCc7pWAAXQbZ9er3SkwgKyYlnKa/HP6lk/aAEV1dFROTxwINfbEDZIu0uJd6
	dhDGK281zs8Fg0aIcxQbW3fUOo+b+H/I8FV+rnjHcbEyceyIlxBjFZZ3KH77Hxw+
	qQgefK1tqZhpR1S3gKQk+8lqkKm2dKXlRSH17ObouMs6QuuaygsqBY6NsPpyTMBw
	yeS1Z+ytkJvcBfLHstBRjeWtvVhOsKeo5zE6FG3pTDCg1V1ReLdpBvs47xvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741766794; x=1741853194; bh=clX0xCQ7vs9apA6EQQWrO0K5i1N6uWcLW+a
	JPl0biQk=; b=P/4Voa6XSfZ/nxYnuuf+ma0D2VcNByTqgiEIq8XxfnqGNA+dT9Q
	6rO7aE5wPlNTtNzcM4/aBnngaTCj+Ajp8frie1Yx8zDfA628IveP6k4b9g68FbiT
	Rh+qlp7h3Vh2O1fIzz4GKrQjJk2CPf2REwMA6yFMY5EgyFzxcGiYifHSYQwCujsl
	K0kUCAI5v+5D8vJ4yBWE769fJlcqTJq22G6ycUCOGCE65y1dWwvDZ+utQ4Jn4E8g
	gAAQ8GXUPzrm5yi+8VVdE2Wpx0c2dzSkQgcHJKyZQOcmsErFOKvuy6K0fKbbCQ0f
	xgu/LhtdiZVOCfyffZBB1XxdmrFfNcTVXRQ==
X-ME-Sender: <xms:ikDRZ01BUrTxGu-knPOqARmmjg1Fp1btux9XVZz-u9ufK4fdg55d_A>
    <xme:ikDRZ_EXo-6b2W34M7Ys3p9R-3Z0f7Xv77Uad_CIKyGuELVEtIb37Ty0WGmGqHpjI
    0OxX9YNfBW8CyPE9w>
X-ME-Received: <xmr:ikDRZ84PgCqH3aCOhf4hjEU-lCarvL7x0aqOZ3DNFhaxK5EpgHwk0WzZsvqXDz0sJZ4VQGI11FV8bbNp_yvloKbxGhr2fL0-CyKhz4vrrYNFLoY0RA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdegheegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ikDRZ906haFtmzcstiuzmcu48aFSgMEi9PHj5tv5i5PmZHwD28ZGWQ>
    <xmx:ikDRZ3FinJ5CfgDD_LcZBgsoY5Sa-Mh4ALr3OS6nU4WQahCjcxP7Zg>
    <xmx:ikDRZ28MGkhz9wOYS9bm7fNWv3zUkREfuV1-jP25LLVeftt_GAb6og>
    <xmx:ikDRZ8mWNEU8iBQcEijWSKO-5Tg0JoPoqwBzZ1yjOan3rWNVKWxmZA>
    <xmx:ikDRZ_DwxxsaaWIQsKpYSlYv-xQKi3aufUIdjQgg8ZbC4_QMuDMgw_os>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Mar 2025 04:06:33 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c2d9e44a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 12 Mar 2025 08:06:32 +0000 (UTC)
Date: Wed, 12 Mar 2025 09:06:31 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 0/3] Small new merge-ort features, prepping for deletion
 of merge-recursive.[ch]
Message-ID: <Z9FAh5p2h55_4mki@pks.im>
References: <pull.1875.git.1741362522.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.1875.git.1741362522.gitgitgadget@gmail.com>

On Fri, Mar 07, 2025 at 03:48:39PM +0000, Elijah Newren via GitGitGadget wrote:
> I've got 19 patches covering the work needed to prep for and allow us to
> delete merge-recursive.[ch], and remap 'recursive' to 'ort', including some
> clean-up along the way. I've tried to divide it up into five smaller patch
> series.
> 
> These 3 patches are the first of those series, and each of these 3 patches
> provide a small new feature that together will be used to allow us to
> convert some callers over from recursive to ort. If the third patch,
> introducing merge_ort_generic(), doesn't make sense to submit without one of
> its new callers, I can extend this series to 6 patches and include the
> conversion of git-am.sh.

I think extending it to 6 patches would make sense as it's somewhat
unfortunate that this version introduces the function, but has no
callers at all.

Patrick
