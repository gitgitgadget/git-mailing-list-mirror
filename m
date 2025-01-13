Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99D81C5D74
	for <git@vger.kernel.org>; Mon, 13 Jan 2025 15:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736782828; cv=none; b=p0IjAQdOZ3Ly4eEV5txHv3R9WIT09m6GL374iU7UOjP2fqd3gdiT7p3I3QqXCNkHR20qZC/VPBfzx18xA9k/TmqMroj37H8A/F4kiSx0YTwe2wD1t1v8eR1kcOVgokmKInGS0J7QslWrut2QT5bvOn7s223ByHeJ6gD7ZVnhue8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736782828; c=relaxed/simple;
	bh=kXhJJoFXnkjOa8cySw2gVEiZUe2xmps81d1A+vBvSo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ESmFURPZULI+8zSrewCMZAXleR5horIM+bvAaIGtGDlhlYt+drbgQ7jiN/cn/fRXo3Lvmiu5pdZQu/J28PyJJXoMTQ8qN6tUAo/4uG2RAW1fvgq4Rf+pVDRsm72sMj3bPuOAM1hcHYOO0GYVfVls2h1REuOXO1x3sc2qI+ycpLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LwnEWTyf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xV4YXg4g; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LwnEWTyf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xV4YXg4g"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id C35B61380833;
	Mon, 13 Jan 2025 10:40:25 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 13 Jan 2025 10:40:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1736782825; x=1736869225; bh=6pvZsRxy3m
	OjLCU2rQKVSmHmEeuZPMzlCsqXVvLsH1Q=; b=LwnEWTyfVDYw1bboVmsZlTq+1D
	VIs2tVm9C5oN7TYtf2iS+I8P0gSxqsX7bG3+3LcuULOI09NyW30NNIaETLJrKobK
	k20ovrQ1iJ5MEcGpecBJe+Knre/Hn0CpsV1sfxBd3no1kLV0fujRVue/dFpTxmEW
	qzjARNW0JJExVFbHAJfmL7PirzLeqgry+SQRwwEK02omovhhRGWPPVq/a5dncA4F
	K6fWr37m4UzWiRNXtHjut5q3u5Agi1wgzwEtszyxLTOe2V+SAiNf59ZLxFFJOSkx
	4ZnfLx/sUSsNAcdNnbi/ERb69OLBIbLMKEFnW1au/T0aaavRGuLM1zcyYjTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736782825; x=1736869225; bh=6pvZsRxy3mOjLCU2rQKVSmHmEeuZPMzlCsq
	XVvLsH1Q=; b=xV4YXg4gBLLcHSaP/qda3pnUBW6FS/lu6uPHBcynuj4/6JOEqFl
	R8HV/JWzC1V3IAZiY4zExp2qkWDuv9qgh/8dEkQZxWuTgj7NplTZrm0XWBUTPz6Y
	WFHSALxuvly0Ux4VwvHP4GJmYISmL7RLPlzMoWJJ/yUp0V+kOMtbivF+6d/nbYlE
	PI6xJeAquJrCZ4aQUcSn1VNssUSgGpuFwBg2GLQDOUvGDA8VbgVjkau7xCSKq/nN
	XrdGvFwE3xBFkG3QqjloI7E8W7q8eE4Rp6tcm5nwRT90FTImTSlFXxGrNQsd1nxQ
	YY+SmSED80dCc9BpNyo5bBwA9oUkV/aa9oA==
X-ME-Sender: <xms:6TOFZ7i3MHP3YMqM-NaNwVBp2OzuFJNonpeuCOsDe_1b_NtLkhghTA>
    <xme:6TOFZ4ClYwZkhqZQ50KSmq2GCTaGoEqkmE4zW1xCrXox7YSoyZHBBoK2Z43po4UzL
    hNDwAJR3-ZtWs3qzQ>
X-ME-Received: <xmr:6TOFZ7HPfsh9aPspVy-2UtciQrxH7HFXzQiwJkw-KBlkASVCcxPU5yt7Obmo8QJYgf9lZb3yOuLDLfwy6FNQiyzDJ-lYnFzKepUJbHIhD90wOCwI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehgedgjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhope
    ifihhnkhesshgrvhhilhhlvgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:6TOFZ4TgpoaNYtj7hQDQggAkupG4uu7B0ppcUAtnLi22cES5Ge_qgA>
    <xmx:6TOFZ4z0t_CXzocARc2tbP4r2uZeihCXUj-i7ST3yl8jmgd-W9zS0w>
    <xmx:6TOFZ-6D_x0BKqCrZJIwSJXiP41UPgkVAXhAVzK2FfDpiS-CaeREFQ>
    <xmx:6TOFZ9yRWMwnGPmfTY9UmEE9sZ82c5cZId0LKBfNPrcOF6VKIHqcHQ>
    <xmx:6TOFZysAwGcL8EL9xMs0bkIYX9_AWblCeM9fgttHG1160Bx5AjygeTxu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jan 2025 10:40:24 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d1c01c83 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 Jan 2025 15:40:24 +0000 (UTC)
Date: Mon, 13 Jan 2025 16:40:23 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Wink Saville <wink@saville.com>
Subject: Re: [PATCH 05/14] diff: add a comment about
 combine_diff_path.parent.path
Message-ID: <Z4Uz56BZG19rOnRA@pks.im>
References: <20250109082723.GA2748497@coredump.intra.peff.net>
 <20250109084248.GE2748836@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250109084248.GE2748836@coredump.intra.peff.net>

On Thu, Jan 09, 2025 at 03:42:48AM -0500, Jeff King wrote:
> We only fill in the per-parent "path" field when it differs from what's
> in combine_diff_path.path (and even then only when the option is
> appropriate). Let's document that.
> 
> Suggested-by: Wink Saville <wink@saville.com>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  diff.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/diff.h b/diff.h
> index f5f6ea00fb..60e7db4ad6 100644
> --- a/diff.h
> +++ b/diff.h
> @@ -480,6 +480,12 @@ struct combine_diff_path {
>  		char status;
>  		unsigned int mode;
>  		struct object_id oid;
> +		/*
> +		 * This per-parent path is filled only when doing a combined
> +		 * diff with revs.combined_all_paths set, and only if the path
> +		 * differs from the post-image (e.g., a rename or copy).
> +		 * Otherwise it is left NULL.
> +		 */
>  		char *path;
>  	} parent[FLEX_ARRAY];
>  };

I feel like this change would've neatly fit into the preceding commit,
but don't mind it much either way.

Patrick
