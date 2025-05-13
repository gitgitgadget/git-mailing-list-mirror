Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE1A46B8
	for <git@vger.kernel.org>; Tue, 13 May 2025 16:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747155086; cv=none; b=ldE3EBsGqE7cy04QErMC0o/KqYOp5Vg38oGlIyCSdX++t9x5+EaS22QyRR0HM88ttipVBVvGOMpkTivLxzHXqbwpn2Gcx+J/CD7dEs/4bBdb6oo+9040w495fZjx143Qg5WGD+94yoH1HTQkDkVVCEI+g33M0726iMVNj2cR5MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747155086; c=relaxed/simple;
	bh=3XI4l5ddRSGPYkBwRhHdOrRXmX48oiiyXZg5fLgyxME=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fWBfxQG03kLQed4g4vSMyqm24WXgrBSkFtcdVxpRtmBVo7FW7caXXspYzoicTEwnYiHyggoZ4zC+PTbdzCXl6PI0a263Pom4sCL+fq+zPZ+P2AYgc8jNSRcBjq7OC82uRUVu6pnfq+X+CTouwKtdIHscp7x57mDwW2jFqi/qlIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Doq8AHP6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uZVz63M8; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Doq8AHP6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uZVz63M8"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 86C7B25400C9;
	Tue, 13 May 2025 12:51:22 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Tue, 13 May 2025 12:51:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747155082; x=1747241482; bh=F/2S2EYPtC
	1fvX9exwXfUdvLD4pHo6/wKUfvyH8NXqQ=; b=Doq8AHP6RgW5YlLTNTcIObV2fd
	KZgj72/VpIhK/Hd+5AC/o1pG7PsAU4j+IrcJHjJc1iGpAizbo+zymAC9481kxumT
	rrhwWLPBsA7mCs6yFwPY+laCZBihj7etU8Ro89ttBFTqv/2kMLZgYvj8E7Hdkfkg
	1wlA3jHc00ZorkBBoL7o2e8nNnOiQsURP2SjlBSwpBua8qncPDoTwgLKx71b4MIW
	Mi0rMI+awTc3qiaeeBgoQpoXjxSQf9yZ+cO8MyKOZCKjdcCfxwQTUKVuF7LYXC10
	pTLrBMQWDAF/RtVuFl+fgT/7UjtwbiLrJbYbXBoJ6ro6JQkkkkrcHSpH97AA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747155082; x=1747241482; bh=F/2S2EYPtC1fvX9exwXfUdvLD4pHo6/wKUf
	vyH8NXqQ=; b=uZVz63M8nKlhlzK3Fo9BwqQwj79WmYk2FKmpJcVuv8OKM0PGil+
	eHB8P0hGtkbWo8VZHp3HXFDrFkgS3KGBlx3qZ2r5/QUj4Sd3GYF9/08RahroWNi/
	FM3Xwg3OvUXT8nj4VkSyk2lNvayLL0hVC9WF3ud4Ho47Ep2mKIGShk08ALxDpt+y
	TWT7qcZcerw2woLkUuqVCAw4Zs6vEuhaxitRCJXfgU0mCyEm5wY0Sq7h6qzC+jMq
	YCnJN8pqzPJvuW/YtSlO4tT8XKfjGQsmjrRiOw/64gL3QuTPkF9XnraSpF/Ba47g
	K7y2fF/l3u8FnQ8JIKxsPjpHTtaasKgCOJw==
X-ME-Sender: <xms:ingjaOXQszPDP59rRwy1qqzysu17C8Urin0jJ4GqTry9oofgoWoeAQ>
    <xme:ingjaKnLTwJrrMSOZEQk-eQxsRs4iHvuDLRQJKRfGPSWiSw0vDNnr92_yhciigm_A
    jXb51gGT4qVsFhb6w>
X-ME-Received: <xmr:ingjaCblH_KMMvY21H5u0E61b9c28XpGKLLbeBCfr6tPx7wD64DZ5PbSVp63rLRQj4esmvPP3aZPi4sZGDRREFwImOmv2mEsR4zETeI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdegieefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhhvghjihgrlh
    huohesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehpsh
    esphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:ingjaFUhYDeMFsvMl028ICsmHVwI2sCcZSW-nCY1IqB7KCstLzGIqw>
    <xmx:ingjaIlTgJ5kUZHYX2xpSP3o8RsWQkX_sm5wej3a8ZcNGDgOgTy66w>
    <xmx:ingjaKdD4xj6eNqW3lxza7UNAwloUwC01L5MnyeT5p4ARg_mj1TEbQ>
    <xmx:ingjaKFpHWrX6-vnapVsQu-ehSF5a2vQdUzieS0bwvPYFd1eXhFjJg>
    <xmx:ingjaLSJNhSuKcVjgMD2J0PWAzcgke0B3datr_l0VBq7UTFyxdQ6dlJh>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 May 2025 12:51:21 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Patrick Steinhardt
 <ps@pks.im>
Subject: Re: [PATCH v4 3/3] packed-backend: mmap large "packed-refs" file
 during fsck
In-Reply-To: <aCMoD-c_oHlu0c5c@ArchLinux> (shejialuo@gmail.com's message of
	"Tue, 13 May 2025 19:07:59 +0800")
References: <aCMnrwkoJ2WyqGZT@ArchLinux> <aCMoD-c_oHlu0c5c@ArchLinux>
Date: Tue, 13 May 2025 09:51:20 -0700
Message-ID: <xmqqcycch2t3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

shejialuo <shejialuo@gmail.com> writes:

> During fsck, we use "strbuf_read" to read the content of "packed-refs"
> without using mmap mechanism. This is a bad practice which would consume
> more memory than using mmap mechanism. Besides, as all code paths in
> "packed-backend.c" use this way, we should make "fsck" align with the
> current codebase.
>
> As we have introduced the helper function "allocate_snapshot_buffer", we
> could simple use this function to use mmap mechanism.

"could simple" -> "can simply".

> Suggested-by: Jeff King <peff@peff.net>
> Suggested-by: Patrick Steinhardt <ps@pks.im>
> Signed-off-by: shejialuo <shejialuo@gmail.com>
> ---
>  refs/packed-backend.c | 19 +++++++------------
>  1 file changed, 7 insertions(+), 12 deletions(-)

Nice loss of line count ;-)

> -	if (!st.st_size) {
> +	if (!allocate_snapshot_buffer(&snapshot, fd, &st)) {

It is a bit funny to see that a helper function that works at a much
higher conceptual level treat an empty file so specially (namely,
should it be different from a header-only packed-refs file?).  If I
were doing this refactoring in 2 & 3, I would probalby have made the
helper return "void", and have callers who do care about st.st_size
check that themselves.

But I'll let it pass.

> @@ -2121,21 +2121,16 @@ static int packed_fsck(struct ref_store *ref_store,
>  		goto cleanup;
>  	}
>  
> -	if (strbuf_read(&packed_ref_content, fd, 0) < 0) {
> -		ret = error_errno(_("unable to read '%s'"), refs->path);
> -		goto cleanup;
> -	}
> -
> -	ret = packed_fsck_ref_content(o, ref_store, &sorted, packed_ref_content.buf,
> -				      packed_ref_content.buf + packed_ref_content.len);
> +	ret = packed_fsck_ref_content(o, ref_store, &sorted, snapshot.start,
> +				      snapshot.eof);
>  	if (!ret && sorted)
> -		ret = packed_fsck_ref_sorted(o, ref_store, packed_ref_content.buf,
> -					     packed_ref_content.buf + packed_ref_content.len);
> +		ret = packed_fsck_ref_sorted(o, ref_store, snapshot.start,
> +					     snapshot.eof);
>  
>  cleanup:
>  	if (fd >= 0)
>  		close(fd);
> -	strbuf_release(&packed_ref_content);
> +	clear_snapshot_buffer(&snapshot);
>  	return ret;
>  }
