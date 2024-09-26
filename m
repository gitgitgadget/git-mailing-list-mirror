Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4166F136347
	for <git@vger.kernel.org>; Thu, 26 Sep 2024 14:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727360675; cv=none; b=q3+gBIYyS8WW9SaJsoG7xNXVWaJil0aXBxfMo298CwW9Avz73LrXLEXTrPg1XKJsdm5yN1JtT+tf8mEK64nvqFcqX+MpAp+W4Ybk5gzpOmYfOkLnEPhswmqmcjgl6tdgNzWl6/JbuNkpln53KsjERCRLmetRmDn/JwusDYOczuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727360675; c=relaxed/simple;
	bh=4HpDR+xhrmqGOnAZL8z9etLdSNhZoFSvOAs9xluVVcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oFZBxMnSRpRTLqxJ3LBlUiDQtPYTlM2aF6iHzGxS3f6y5KXOZAdFI4rPP5uxdF7qdXZJjA6kxWXfcbC4cYsU7x9FE4yZzY9Tuw3I/puRrhemAFYcNL/g4lbHLgSNc4YLtXENr4YhbJZOVcyx90VK26bR7Rz3+LVWN1bKnkgmhpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BXMIHn6l; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gGLa9jvI; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BXMIHn6l";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gGLa9jvI"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3A2171140152;
	Thu, 26 Sep 2024 10:24:32 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 26 Sep 2024 10:24:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727360672; x=1727447072; bh=Pb/YL+brkt
	EXvZ9bPO9dOex1J7K4bVxXB2ah5mJRKBg=; b=BXMIHn6l1vm3ijLTR3j7oExFsm
	74lq7QJBNGWCyJqlyhv/ls+PcoIr9fFAJn1wSx2cMyzoNvwb4ZvN7fDuIfhwFJZe
	xFJ/CFRoJ+a3ARjNIhRZSbkiUZpAcKJBNJ74SK2ecpIV4P357ztMJ+/xxUS89Llt
	9FRwH2VL98umzWmm62MMs0DhE0/NVjEJDwGt3uP1tqOINCbTnJtJ0wX5D3+kvxMg
	Zv69v89WkIIjfCrudtgODPcqCRcJcbMenOeoKfpMI/WdmjYJ8mfd0st0c1z7ST5N
	ouGTqBrW0IlV9dtnX7GyimOnsHpcYKknhIc/qlPz4M48+WrkPuUNJKukhHEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727360672; x=1727447072; bh=Pb/YL+brktEXvZ9bPO9dOex1J7K4
	bVxXB2ah5mJRKBg=; b=gGLa9jvI4GmTOG+ebhMtsvwWAMvCnWlGoxRd9zFANcpD
	/WnI4EROEQhE6ZptiQxuo7OfwQJknielzVxhLNXDQ/Xhdav+aia9mM43Ji1xSdDA
	9COM9/YIo9NjLh9Gd+aYNoFnQ0M/TGbaofDRUa2dgKUVlqPtXUTlfE/9L+VOOlbI
	dxPgs7pVIioxoIQ8ATP8d8razjz1yRBIPNk4frAqCR2uSyvMcJRj/nh+00GXSgvZ
	WD95bokegx7j4GKzute+Eu5uT1Z/yEhps5A0XOmMz/MPXdu4rwBgvSuU7aL1A2Ut
	DQJulZySsH38IcxmrMe+7DUzA0/0P5Ra/5w44QgyCA==
X-ME-Sender: <xms:oG71ZiPemiHuZW_MrCgxW9y8Ky48vXwI2nMYdGmOS0WYjYWEi96r8Q>
    <xme:oG71Zg8jvtxElfILpiO_-5XMaElg_aXe628cDE9WStHKSO_BbJd1T_IZLbHwn6Xzb
    qR99nGMCA-WxCiZng>
X-ME-Received: <xmr:oG71ZpS_qBvEX-kmBI67DuB67jsrRoDgDQhmjtNPUXDg7m9repPUeNHa-RGZirDj3VaJw1W2zc8EB-7dPwg6zPNe9O6ZUP0J6X6Qruqa78PCYQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtjedgjeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehjohhhnhgtrghikeeisehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:oG71Ziv2S5ygFbT4wzbcDmMIqJoOL4ib_A5RHYeglS775RZvPPnavw>
    <xmx:oG71Zqc2akEf-hz50E0NUUnXbrKGyRmIpgwVLaxciEj4PjoNev4d2A>
    <xmx:oG71Zm3rLfwqoW6Rk9wl4VIiVWhTVQTSkYXWzvX9KtfCxcrNoIw_QQ>
    <xmx:oG71Zu-8KqIXmnRSUfzTLUtwCr9WyCejL3zs7iUmQ_ZizwbJ1HxGKA>
    <xmx:oG71Zq5xjaZvdPfa4qHhRYJT57mdBZfsYmyFNLHwymr_n2C04mPjMYkn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Sep 2024 10:24:31 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4a25d594 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 26 Sep 2024 14:23:52 +0000 (UTC)
Date: Thu, 26 Sep 2024 16:24:24 +0200
From: Patrick Steinhardt <ps@pks.im>
To: John Cai via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 1/4] git: pass in repo for RUN_SETUP_GENTLY
Message-ID: <ZvVumLAFu1LGzXWP@pks.im>
References: <pull.1788.git.git.1727185364.gitgitgadget@gmail.com>
 <eceb2d835be7168081d6eeffbce57bba89b5f423.1727185364.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eceb2d835be7168081d6eeffbce57bba89b5f423.1727185364.git.gitgitgadget@gmail.com>

On Tue, Sep 24, 2024 at 01:42:41PM +0000, John Cai via GitGitGadget wrote:
> From: John Cai <johncai86@gmail.com>
> 
> commands that have RUN_SETUP_GENTLY potentially need a repository.
> Modify the logic in run_builtin() to pass the repository to the builtin
> if a builtin has the RUN_SETUP_GENTLY property.
> 
> Signed-off-by: John Cai <johncai86@gmail.com>
> ---
>  git.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/git.c b/git.c
> index 2fbea24ec92..e31b52dcc50 100644
> --- a/git.c
> +++ b/git.c
> @@ -480,7 +480,10 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv, struct
>  	trace2_cmd_name(p->cmd);
>  
>  	validate_cache_entries(repo->index);
> -	status = p->fn(argc, argv, prefix, (p->option & RUN_SETUP)? repo : NULL);
> +	status = p->fn(argc,
> +		       argv,
> +		       prefix,
> +		       ((p->option & RUN_SETUP) || (p->option & RUN_SETUP_GENTLY))? repo : NULL);
>  	validate_cache_entries(repo->index);

Should we really pass `repo` unconditionally when `RUN_SETUP_GENTLY` was
requested? I'd think that we should rather pass `NULL` if we didn't find
a repository in that case. So this condition should likely be made
conditional, shouldn't it?

There's also a missing space between the closing brace and the ternary
questionmark.

Patrick
