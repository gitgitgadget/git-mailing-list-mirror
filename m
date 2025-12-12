Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176E73019AF
	for <git@vger.kernel.org>; Fri, 12 Dec 2025 08:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765528569; cv=none; b=FXI3SAnzB8fEVd+1k841ZSNcKlb5NvEUNrkVqrs00X77CRh0svjHJwtR7pks3nOtmHiIqvZSDTXwYjwuM25eHiYL5WJROc+D045EsNNsqRCi8wO720c6/cbQQ9vQvvNPqUpF+7pyaAoCtBOw9EgyZPvKmvOTQFiIlMfeVfd/DJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765528569; c=relaxed/simple;
	bh=qf7++eq7wTccvJDMKhJWjZ84+Pb8ycJFMYgOg3hWwAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fKY6M9ZqgCltqRAMznBPG+7jbzq6XPZdRknARjjDmGgMNKH4RTyFEmsNYoJp89fFoSb1BLcwNc/gHJg0fu4NaF1dDaAV59XGEzDzbKNnSQlphPQ7lWhSlqX294ZxbuH3BwFV7lgXRt249jfRYHJ+kGdgQf/NIOHZbwGafiC5zjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=t77Kxyet; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ey5VfCZ8; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="t77Kxyet";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ey5VfCZ8"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 2CBBF1D001BB;
	Fri, 12 Dec 2025 03:36:06 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 12 Dec 2025 03:36:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1765528566; x=1765614966; bh=rqsu1CGKJz
	/A1IdIxyExxIJNmtjDD/Hx2ZwFk+P2Wd4=; b=t77Kxyet066RZTDhSlQqHjfu2g
	b3wRDpwPon93z9b1gtvT1QftL6u7QdvkZ1kwF3/jSNIpqa5dmvi9W14lEpSVOXks
	D8AFwVrafIt4YwYHEieAsO9Yq+X5lrO22ULksYYhaGC0ZFmVeU1usklHlATcPDeQ
	4Kp9AMRKu3+jtggLGh+D/6owO4FI+VgsbGopIbYj1Sh8hQVydacXwPVQwbxGcV3i
	G4bb+5PaEwM6hEa3zT5SmuoR0vWIodBJen4KpvtdR9tt8cHgW5I9jiz8LxQKKXOu
	xkH+LH2cDbhuFb91aTKhFwTSYkprm6OT7p6NDTLf9kuvFILpkn1rJOdsBJAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765528566; x=1765614966; bh=rqsu1CGKJz/A1IdIxyExxIJNmtjDD/Hx2Zw
	Fk+P2Wd4=; b=ey5VfCZ8MHwJYJoihOyg7cGyqUirewvf4vZVjO4eBpkATyPGM72
	FY/seRCeHIErB5PgjIuZ98BDk1xdgmXMI22/Ofpu0lf7rtzekWo/gXIZiWw8VRFe
	m70bsOugnoMFBpRT2E2z6WJk+YDnfLrtfTRHNl+Dh8YidkS+ka/uOdnnhyFf8d0u
	l4zYlsr347Ft/vYaYKad5yjJBic8WDlV5MRlcvsNMLVzi3Z/veQHTY9+PwytF+Oj
	2hR+676la5MvYGtK2muYUseKl3av9ZW3CwW8biH8zSWK3/CC3MCZqhtbUMM+aIlM
	BRUrtdUyRiCBS461MDYF2cdVpD6T7cJjdxQ==
X-ME-Sender: <xms:9dM7afhY2KM31DSZEq3mv3MnV2iAesC3Vc9Z0mtWFtKuTyZkLzkruQ>
    <xme:9dM7aSBRQBCAFewmhpdFDVZQACeuWdvq6MQAIkv8uAEanUt_weR-zK0eCQfTSbfnr
    -dr52XWoOHgAFB5cnU4w_kuogM1_l-2YwQ3gkbG8xUMO5neIw27jw>
X-ME-Received: <xmr:9dM7actADnLr0_p7ZXdGbYK_1f8TdaYK7z_rwDRqP5BfTj9uP0uLHC8gCpJBiOk2T1L25G29mdZKGJo-a68LxMCiTq_-b_rDH_MszFH2Hso>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjeejvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhe
    fgueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:9dM7aXZBRkv67Iy1A2ABvJXUCqpUjS11_WoTcyewWjJmnEntjpomyQ>
    <xmx:9dM7afVgSMKwjo6AjoRQJFZwFSrFiueAjd10a5MfbTmHAiDfeopn1w>
    <xmx:9dM7ab5RYTVU59xJ5UrEULhx2u7SKkrVNewflSfCAAMnIbWWSdezuA>
    <xmx:9dM7aag0nSQCQw2sfV2tHkupkQ7pUeHCWwaqcbq4oUVnMGG-HPHXew>
    <xmx:9tM7aS5D5SpN3LzqFZMWAPX-uJnmpQ0Ar_Xr3q37OihCXIFoJvfNXm3W>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Dec 2025 03:36:05 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 09550a9e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 12 Dec 2025 08:36:03 +0000 (UTC)
Date: Fri, 12 Dec 2025 09:36:00 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] 3.0: require C99 flexible-array member syntax
Message-ID: <aTvT8A31tQFvCvtL@pks.im>
References: <xmqqbjk5e32q.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqbjk5e32q.fsf@gitster.g>

On Thu, Dec 11, 2025 at 07:16:13PM +0900, Junio C Hamano wrote:
> Before C99 syntax to express that the final member in a struct is an
> array of unknown number of elements, i.e.,
> 
> 	struct {
> 		...
> 		T flexible_array[];
> 	};
> 
> came along, GNU introduced their own extension to declare such a
> member with 0 size, i.e.,
> 
> 		T flexible_array[0];
> 
> and the compilers that did not understand even that were given a way
> to emulate it by wasting one element, i.e.,
> 
> 		T flexible_array[1];
> 
> As we are pushing more and more C99 language features, let's declare
> the historical forms of flexible array member support obsolete and
> require C99 syntax from all compilers that want to compile Git.

Is there any specific reason why this is tied to the 3.0 breaking
changes document? I would have expected that we introduce this change
via a test balloon like we usually do for new C features that we haven't
used before. And we already are using C99 features, so I wouldn't
consider this change to be "more breaking" than any of the other C99
features we have introduced already.

So I wonder whether we should instead convert one of the sites that
currently uses FLEX_ARRAY to use C99 flexible arrays unconditionally. On
the other hand we don't really gain much by doing that, as it is just as
easy to adapt the FLEX_ARRAY definitions to unconditionally use C99
flexible arrays. Both would boil down to a couple lines of changes,
only.

If we see that any platform out there doesn't support this feature we
can still roll back and maybe tie it to Git 3.0.

Thanks!

Patrick
