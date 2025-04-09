Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0AB26FD86
	for <git@vger.kernel.org>; Wed,  9 Apr 2025 17:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744220579; cv=none; b=ugn/jj++btc/nZjadxJqWwKuVOfZYEHIZD/R3gRoIOVeGimsHi18AByLNjnNJSGUvABTITe9hlyL444Zsdoh0wfE/H1TZnUb4X9lnhulP1vbjFlEHmL6vmnwFlqsCQEIVEsn0dARMLiI+KQG9Zvu8jBscA2eX70S9dpBaZpobTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744220579; c=relaxed/simple;
	bh=FwbH4EXYRW0HifSSxdJ/F66x/iAxZsM2H+R9Wzy5cdA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=M9wojYFwRERZ8i4pMM2VeUy71FFqLRuD7gqXmLDS/gfFwwqIjgNbRmYF2BPbNEXbV2UA8A/lt37wW1AKWjaIcIKrK//igI2ILf8SVuiu7zCmbyelxnPPlAhZ2lyNytwXFKibprR3KlO6VSsTR9xY5pxNlqHTHA4gvYlNWuHV5WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=r77kVo5X; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WWLr48yr; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="r77kVo5X";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WWLr48yr"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 71B461140136;
	Wed,  9 Apr 2025 13:42:55 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Wed, 09 Apr 2025 13:42:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744220575; x=1744306975; bh=wwGRRF/ZvW
	R+3H3VZMioGUmt3usAAtrMGXlktN/+e1E=; b=r77kVo5XPDhDAPutj8y71H+QZ9
	DgFFvL8umnnsMQNNy2ODQvzA2raRVc8sET4/N+McRi6OsI+hfUpDYAkFQwWiXyVR
	3Hb+sNRQtLZDkIhxKhxONlKKNLxWqrFbk0qgalorZuNqdbqWmnhDja/wVv87xr9n
	sHLxXe9PrNxRQ4ojHL0MJExv/rzDaPcnEuPJcAscWMgCwqUz+luTHRqcCj2tKtpR
	84eH+YeGehKpdVQxMGP3EuJ1rhO8E4iTzcgzVOAB/szEvRPPUknHqKrQL59XEroa
	8uSSLtJBOXsHlYKpIAQal3dR4b9msL/lTOY14SgBNv41yswOLbZuSvo9Dt7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744220575; x=1744306975; bh=wwGRRF/ZvWR+3H3VZMioGUmt3usAAtrMGXl
	ktN/+e1E=; b=WWLr48yru/AaNJBhgUJKNlWnXpPv4/eHktJ8fEfjSIsjwDcYXut
	ifNypotqOQw9qy1fhCOsc4LAzgaSxmR6mgzDmSZ4QuSeTJZwJQVNsLFMUby5kcTq
	/7YTT0yT8mgg//oGPJrOTU2lcbgrhpwE4eZb6Bx7qbLsNEh4D3KZQ1+MfzDu0MVh
	ifNjBycLF3JY+a3w6YIQAPxUtU/6gM9mO0K43eu7Hx+TxgnQkx1aX5WANihYJ6Aq
	NDN7gN/grecF7N97n6ayVopCROELJRd06nGVAIeBCYbIdEQA+8YS6IlylS7BPFm1
	o1XfAnhllfG+KdewDrQr/3fu/BgSlFPO4yw==
X-ME-Sender: <xms:nrH2Z_0cXWDtVekRVAvKZNYHdJVno5lAMdOQiNEQD4I9FHCwY2dVHw>
    <xme:nrH2Z-HB4hb0tfGDWqYLaJIdqlGgpxnTrPAQdjZ5a7xH42R3CKc4gsA15aiJlxmFq
    IURqXGSWXMNSTA1xA>
X-ME-Received: <xmr:nrH2Z_4KiUkFkVjJroz8tGslkcoNYPFxlsyJ5AxQyXYuKK97rg8sjowISxB7r0_X0Kuar9i3zqkGSoOETsq9v3NeYaxndr6JoyvH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdeiieefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepthhmiiesphhosg
    hogidrtghomhdprhgtphhtthhopehlihhsthhsodhgihhtsegrkhhshhgrhidrihhspdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpsh
    esphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:nrH2Z01ORRrHmIF1zeXipxucubtoxDg_eP-b3Njeywyu7JGP9ff7uQ>
    <xmx:nrH2ZyFJG6VFFtslH3delVmOSmYjPp6uLTYtDrLPRz0tnKgDdkjxlw>
    <xmx:nrH2Z19lpFk35kt2AtsNiJi90jaSQV2SAM5Wf67sAPd6e6KczIXw6g>
    <xmx:nrH2Z_kURCaaoG-L-tWC16IroabqCcOQX3zLU2hx7PW45WCB9RLyEw>
    <xmx:n7H2Z0OTRyWjyLdQWOLJruGFI_mld_GJJv9D7oF1HDV3VfhDeprQSHBR>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Apr 2025 13:42:54 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Todd Zullinger <tmz@pobox.com>
Cc: Akshay Hegde <lists+git@akshay.is>,  git@vger.kernel.org,  Patrick
 Steinhardt <ps@pks.im>
Subject: Re: [PATCH] meson: install shell completion scripts
In-Reply-To: <Z_SJSKrUdiWzg4pw@teonanacatl.net> (Todd Zullinger's message of
	"Mon, 7 Apr 2025 22:26:16 -0400")
References: <20250407-b4-pks-meson-install-completions-v1-1-8a7eb8b9284b@pks.im>
	<Z_RnJEyvtGh_0kFo@akshay.is> <Z_SJSKrUdiWzg4pw@teonanacatl.net>
Date: Wed, 09 Apr 2025 10:42:52 -0700
Message-ID: <xmqq4iyxs02r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Todd Zullinger <tmz@pobox.com> writes:

>> Most people won't run into this since if you have this installed in the
>> standard locations, it should just work, and the zsh script does have
>> logic to look for additional paths it may be under. I just wanted to
>> mention it for info.
>
> I wonder whether it is proper to install the completion
> scripts relative to git's $datadir by default.
>
> I think the default ought to use the pkg-config call to get
> the completionsdir variable, as the zsh completion script
> suggests.  I am presuming that's something meson can do
> rather trivially, just as it would do to find the compile
> options for git's various build dependencies?
>
> I don't know if that becomes too messy to be worthwhile when
> determining whether git is being installed by a normal user
> in $HOME or by a privileged user in a system-wide prefix
> like /usr.

Yes, exactly.  We left it out of what Makefile does for that exact
reason.  Distros will do what is best for their environment, and I
do not think, unlike pkg-config used to figure out distro specific
locations when doing a system-wide install, there is a location that
will make everybody happy in the context of per-user installation.

If we were to install these completion script from make or meson, I
suspect that we'd eventually need a separate make variable or meson
configuration item (whose default value can come from $datadir
unless there is a better setting that already exists in our system)
that is only used to specify the location completion script.

Thanks.
