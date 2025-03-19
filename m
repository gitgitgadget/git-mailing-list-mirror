Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8F1A29
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 13:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742391415; cv=none; b=uQm54ciQwzu5g3NEuWZ7cCPcSljfxkhDP53vW47G4MZ+sXuRMJ0vSOqn9m/EsLyAQbtEGWOibd5KjCzhmAnBRrZFoKZxzleLX3vK/Lw6i0BAW4EL3/vVRJCjiD1uc5OkskcAmDuMzhrVC8u8wkI+5xoXCDpQBcsk66f3Fbfc+t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742391415; c=relaxed/simple;
	bh=c2y4ZuCOTkLB6L0DqMJRt75xsJe+5PXKzQW04d/U8IM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UUATj3pWj46SJkC38B6RrW31oejuXqobfJzlDmQVwDe/HiE8iPKzQ4ItHJhiCxVyw4Cg0nK4M8Ds8UiGgN2PYoXVJgwnDn/Vtc42/t6KJtIBaACxGeRcVSS7PR5oXhjZNl+zLoLJ8PM8ArtIJ2/4jC9mzNimVAsg9enSCrHv1AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XhJnpEkp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NxTClN2w; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XhJnpEkp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NxTClN2w"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3DA7F25401EA;
	Wed, 19 Mar 2025 09:36:52 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 19 Mar 2025 09:36:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1742391412; x=1742477812; bh=UG2NBFb56W
	+QLFYS/hQk3MxuGHubxdgWqVkFxj6TRd8=; b=XhJnpEkpEkxdP6Rf+4nHU461Mk
	eDYk6VlVla6o0iU6TApNSX0/wUJ7YUMwuXds86T3mPfBkkbw45k17JvFmVWN4reh
	APS1ro7vbli0R3DmNzR0i/x8cwKx602TpbacFC1d5SB3B9ivGZT3V0hLfC0ze40n
	u61h5W4MIVurtm/j5AOdEnYstzjIE4d0bjRZ+RiwaC0GDkEvaDVtB+z0/cDthe/Z
	rH+/DTBNKJIyg9wTnnANoa1I4OXI6C2JMzwOoWwDbHCbcYzkcoxJLDvMSynOIGCF
	dIiDdzBirEBgikbwktsSeEyHg7RsNV+T339T6UmWy1JOcLBACfB9oOh3TQeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742391412; x=1742477812; bh=UG2NBFb56W+QLFYS/hQk3MxuGHubxdgWqVk
	Fxj6TRd8=; b=NxTClN2w9RQRRecK06BpIRONSN3B4FqZ+OMaG+71+ZwMARrUjPk
	vjtH8KvW+9jlezLIhSXlhfEDmHahImzRckUJW4eF1LdEFx2wd+uIqxeZGGRRgzeq
	PsxnGgXD0XTc8of3A38HSDlkCfGpURyCHXjKRh5V9uYl790p0IGOY7894xmEfjpU
	uemHW4rHZbu2lDTN/E0Ypy3Pvic/p4EEKnvrZTaRaiBS4zNWEgA7m72cuevjbO0L
	wgJoPZnrDuTva4MHDHlKNoS9YURU9WNkj/6WrdIa4BNjc6FQkKrV2vxbQCoIg7jt
	evHeEIlhwz2lLqzefyVvPH1Kt8Vk6mbzjxw==
X-ME-Sender: <xms:c8jaZ9GEM5SoJIxIX4C4cZyJ7WngzOdHixu-Ue2cihsfyOBeB0ocgA>
    <xme:c8jaZyVv5VnXNQy4MTBiIazQzWtEQAUoFLUnJvZ-oD5lRRHmhC1yRC516f0IUbNlF
    Vt8j8S7iiYbgbpNQA>
X-ME-Received: <xmr:c8jaZ_LoB-yPMRMIgq3ohpP7F2ZAINLDnmXANREMKlXnzjJQdtR76USzvNA1SFEGkDTz72_u1lDibWHV1i3g9zQ_jwWekTeYoLyHxEC4a5G0FwtITA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeehgeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopehgihhtseguihhnfihoohguihgvrdhorhhgpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrrghmshgrhiesrhgrmhhsrg
    ihjhhonhgvshdrphhluhhsrdgtohhm
X-ME-Proxy: <xmx:c8jaZzEHo3oE9q8TrxgrQZCP2GK6QAuiJpFnMyYYjM9HMKNlwrPtog>
    <xmx:c8jaZzXaTwunndi9PGJEOUHtbKgzs3MhcfXdaDoYwmFUz62tLShjcQ>
    <xmx:c8jaZ-Mizi6FIX7BC5renIynC1IzeYVyY-IlaX8CVwJf5SdZjcgrAw>
    <xmx:c8jaZy1e_pbUW-aob2_7WLWn6Y2jBg4zS4ElO_-PGoLxsrn2YelLkQ>
    <xmx:dMjaZ5yluld5RNT8mdtahXgJmNNWlYLlOEb1-5eBdeAgAM3ITCSB9jj2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Mar 2025 09:36:50 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e5573dd8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 19 Mar 2025 13:36:48 +0000 (UTC)
Date: Wed, 19 Mar 2025 14:36:48 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	Adam Dinwoodie <git@dinwoodie.org>
Subject: Re: [PATCH 01/12] meson.build: remove -DCURL_DISABLE_TYPECHECK
Message-ID: <Z9rIcPprrsKtJkmV@pks.im>
References: <d230e5a7-1b3d-4cf9-b30e-69471d1fbe9a@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d230e5a7-1b3d-4cf9-b30e-69471d1fbe9a@ramsayjones.plus.com>

On Sat, Mar 15, 2025 at 02:46:23AM +0000, Ramsay Jones wrote:
> 
> Commit 9371322a60 ("sparse: suppress some \"using sizeof on a function\"
> warnings", 2013-10-06) used target-specific variable assignments to add
> -DCURL_DISABLE_TYPECHECK to SPARSE_FLAGS for each of the files affected
> by the "typecheck-gcc.h" warnings. (http-push.c, http.c, http-walker.c
> and remote-curl.c).
> 
> These warnings are only issued by sparse, and not by gcc, so we do not
> want to disable the 'type checking' for non-sparse targets. The meson
> build does not provide any sparse targets, so there is no need to use
> the CURL_DISABLE_TYPECHECK preprocessor flag with the c compiler.
> 
> In order to re-enable the curl 'type checking' in the meson build, remove
> the assignment of -DCURL_DISABLE_TYPECHECK to libgit_c_args.
> 
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>

Makes sense indeed.

Patrick
