Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BF73E3157
	for <git@vger.kernel.org>; Fri,  8 May 2026 13:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778246277; cv=none; b=qltU+x80V1deGkgx5YGtRtIVYPjFejMV6RBut3YHPzc7kHIpBjoYasUXlr3tm7mKpKVf/Lt814jgCvAXIMK4gQfz+GZio8Ph6JQD93KNkNKYHnoYLWRWE1uBib/rVqYWatb/+NagdlCjBydpGnVIedkbrDpKuDwEtL9ihCxdZcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778246277; c=relaxed/simple;
	bh=laKhQfBJe4yq9+4GapDLdwqZ6nQoOipOSuu8u1p9JII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=punYHaxxQIVA/0FmgE0IuQNQyWiBBt0jacf+Dr9FEk+RdFXb6Wh6AVOLkQXYN8+71bntRKLIfQQ84d/S5wO1wZ0pYfUZLRrMN+0CkmvLypG7qwgi9QL3G1u1SYz2obuO8eAzoVBwM8YSEImuYwiXrhsXFIrmYRqWoaJDn5kADOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GrfprLdU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JeGUpT9y; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GrfprLdU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JeGUpT9y"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 8DEEBEC025F;
	Fri,  8 May 2026 09:17:51 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 08 May 2026 09:17:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1778246271; x=1778332671; bh=xbxGCpJ7K4
	sLn/5dxm9mnDn134pvQavAPq+maSJP2Rc=; b=GrfprLdUD88+yMBLTNMIFflWbl
	s4cYnxhKv6EZPuZ+57ru66GEYRCRgvszYtowvkrBnfz9QqefXsouPttMCM98khGs
	iw2pdJiupJEAWjMIyKd4JMUCJK9BeXzJCDG9S+SuPQnd9CbQaLdCp+Jq3tKWV/wM
	+TPovfC9TG9QwkIpUfeJbA5hdUMlHd8wLoPQpeDC+9jSgij8cWre/h/v+hhOwBrg
	em2oRxTKqm3oZtVkFtUwJwHxZANXYxlBZqexeRyYUc4Y7ZZegKjuBoH7t+Pf7VoW
	MPR9NkIjQ6Z0p6ZsWiz2YNYRQbmSIx+RYcqTTtzqHqLP5pUYTinG6T/+hzhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778246271; x=1778332671; bh=xbxGCpJ7K4sLn/5dxm9mnDn134pvQavAPq+
	maSJP2Rc=; b=JeGUpT9yOQ6ykbXgLJiNEjGz3/+2oshfaMbM2T9TN/n8omlnsxu
	glBS6zUkMinFHiCQX3z9JeR+OJj64gAMM7o0SjbWThHduE3LHnssjImqJZx4yAlZ
	MO+Dz5yDVDtysvYJiVd53yyfW64VgC5w0BOxbntAPs984S27291WK6aSdGbKFHKM
	/enzGHGWe4mhOyGD1L9IGMQqO9w67gRPQSzSm1bvtI2IUFKYdxP5DefWWMSJoI0s
	tqVEawUcMEPX1nHKKL3FU5dEnC8AB7bTzgQTkE8qD86trfQ6qXrEisHxLk+XDifW
	mbMMyjKbqwcQZCq8UDQZBz6R2kxkMh63Rmw==
X-ME-Sender: <xms:f-L9aVEIytzaSqI20RZfWUv6jDzehRtDcU38CaPOmvKlXER7H_L-Kg>
    <xme:f-L9aRxI_B_kg7KVYZGahgBv3YDyEQVLWnvZYXLRV2m3plFjULmn0hHRqEG3C5has
    Z7_IzxqjryIN-uojRmZm54FxW_Y2nBnAHXRZAImSpiwI40p2gPekA>
X-ME-Received: <xmr:f-L9aUjkgT0TjLMm4wg4ZIP63soJfYwnOUyUrGyLzKrBJpFIzgxT4kxzszm-vBBZ3PcGjj8ai9qToW6oTVOecdpNkuE4aUaDvCvxiqaL>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduuddtgeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epgeejieelffdvudfgleeuveevkeffjeelhedttdeuleetvdffvdefledtleekveegnecu
    ffhomhgrihhnpehgihhthhhusgdrtghomhdpkhgvrhhnvghlrdhorhhgnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdp
    nhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhith
    hgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvg
    hlihhnsehgmhigrdguvg
X-ME-Proxy: <xmx:f-L9aUxmka7_L1eNI5V5kT83F_gXDtZpyMi1fTAhBgT_Gmr4zSV_Sg>
    <xmx:f-L9afJRQpbzLvGP9pWl5G45CB4HxDco3m2RzuFM0v8o1yNFLs91gQ>
    <xmx:f-L9aTTRhQFtCkcRkKfQAJLIwi4OojusLFlhhQFpLIuJZu0c833rlw>
    <xmx:f-L9afrUsUEv2pR9vmEFjO2mz1ZvfM2uF9aXqTcsoA2E95Tf4aMgGA>
    <xmx:f-L9afRUbt4uCA8PK6QlqstSg6NALXlry8Om3bPZaOHfEqvbRmmrSQMD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 May 2026 09:17:50 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c9ab5606 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 8 May 2026 13:17:47 +0000 (UTC)
Date: Fri, 8 May 2026 15:17:44 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 0/6] mingw: stop using nedmalloc
Message-ID: <af3ieN6WRsQSZ5rj@pks.im>
References: <pull.2104.v2.git.1778169613.gitgitgadget@gmail.com>
 <pull.2104.v3.git.1778244661.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.2104.v3.git.1778244661.gitgitgadget@gmail.com>

On Fri, May 08, 2026 at 12:50:55PM +0000, Johannes Schindelin via GitGitGadget wrote:
> Git for Windows' SDK wants to update GCC to v16. Since it is used in the CI
> builds also of the git/git repository, it is crucial that GCC can compile
> even the latter all right, but currently it does not, see
> https://github.com/git-for-windows/git-sdk-64/actions/runs/25244795074.
> 
> Git for Windows switched away from nedmalloc to mimalloc a long time ago,
> but recent benchmarks across Windows, macOS, and Linux (see
> https://github.com/git-for-windows/git/pull/6231) show no measurable benefit
> from mimalloc over the platforms' default allocators, so rather than
> upstreaming the mimalloc support, I will drop it from Git for Windows
> entirely.
> 
> This series therefore disables nedmalloc for MINGW builds and removes the
> vendored-in nedmalloc from Git's source code; my earlier sketch in
> https://lore.kernel.org/git/00fd3145-b3d2-ddab-466d-d06fd27298ec@gmx.de/ had
> the opposite ordering only because it assumed mimalloc would land first.
> Since that's not going to happen, it's best to move forward with this, so
> that the CI builds can switch to using GCC 16 (and the current Git for
> Windows SDK) on Windows.
> 
> The patches that remove the vendored sources have a slightly unusual shape:
> the Git mailing list rejects messages over 100kB and
> compat/nedmalloc/malloc.c.h alone is ~196kB of source, so the deletion of
> that file is split at section boundaries into three commits, each
> comfortably under the cap. The intention (as documented by the last three
> commit messages) is for them to be squashed by the Git maintainer before
> merging.
> 
> Changes since v2:
> 
>  * Reworded the last 4 patches as recommended by Junio, in preparation for
>    squashing them on his end.

Heh, fun.

> Changes since v1:
> 
>  * Also remove nedmalloc from the CMake and Meson configurations in the
>    first patch.
>  * Add follow-up patches that drop the nedmalloc build-system plumbing and
>    source files.

I think removing nedmalloc makes sense, and am happy with the state of
this series. Thanks!

Patrick
