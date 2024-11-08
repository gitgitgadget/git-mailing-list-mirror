Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0182193060
	for <git@vger.kernel.org>; Fri,  8 Nov 2024 03:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731037329; cv=none; b=rONnhNBX9yCvJGq+SWR4/hmjzPRqOZJuC6FYjZ0RM0jbPoEYUDF4Wka5C6Dj6/wnbZ73r60bLOhjOZMZWMKIY7rLu1zp9okjwG9/jtORrrJ6kiThxf9yuUxEoFdKj539HZQOAeRVghKT6ZjhhC+HbgOsFjlEmngirxm6OaeE7/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731037329; c=relaxed/simple;
	bh=dsh9/3nsa6deb9nab0lKzzdcyWYZnH35THazZu7C1U0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NTXHhBYqCiuEdlfKj8vhxBWIeVxZBVJTYOJ6bn3m+xJbdnZGjUE0/j4aw6MjaWdvGsbqT7wnQH1x+ouzJ57T/Uq6jUbixlPOlA9KMze3PH5hF15Ad3dsnSuHrHpL5kDMozXW+YmHY/NpDRbx2u4mzdoKTXOHmnVyrqSpplXEIqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=O4E82n1o; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D+4edT6v; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="O4E82n1o";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D+4edT6v"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 25CAD138013C;
	Thu,  7 Nov 2024 22:42:07 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 07 Nov 2024 22:42:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1731037327; x=1731123727; bh=2+Nt3PN08l
	X+6IJIOTZ78sTpUP09FcUid8sKOV5v1iI=; b=O4E82n1oHDEws8X3cYjtP12mgS
	EYmc1h0F5f2Xc2Glg2lVqwRL5ChRP2HqUx7aP9Z6ww8GdJlMYebZMnY7WDd1W2+0
	p2CTmYHBQ2o/JowSaPctxpSO5Jn7Ka92pbb5sKpzAoezWJFwY+MCsdJLzx10NHZ0
	MT15/vzHBNV+KDHQicN8vtrEtUX7+0Xqbzaos6XGmhYQRE7zWLF5iuId+4FS1z+K
	XwgnntG7JLCvztdmLYfe9oBjrAPe1dlIA3d9icfhJxL7FKcNP+kB896c4rG96Q1A
	rbs1Nb6s5jt9g1D39FVziL+SLhIHwifdALSPweZHTz22zTlZHocuqGK+U0UQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731037327; x=1731123727; bh=2+Nt3PN08lX+6IJIOTZ78sTpUP09FcUid8s
	KOV5v1iI=; b=D+4edT6vCh6Kmxh8kKuBGb0AOR1vpsLR+Ye7UtY08zF6332i3wI
	mHwDv4rp4wdskyvMorW3TFmDclgHsOydln3YmQmZN9DYh77SJB+UTPdTx2BXESah
	Mz5yVe4p1CFINRbucJd1BrGM2kH2aSQ1uqTRS8GDds+Z2wquSVMBN0deZ4IG913/
	6LN7wcmTriKm9DrR8lfPwFr9Wr0fjUvHPLOkzPqDlnBbMFLXVtNH5C9IHwBRfelB
	gbR/mI3JFn92TXzx1wfYBpMgXHbEhDmiwO/qVIwSCliVsCvMw1SQ6Yrp/zaikFS7
	uoYeJced3UTvISdr3Kotl1JY/JYVJnOmKVw==
X-ME-Sender: <xms:jogtZwD9xQv4wfntN4JMILMBfqi74BCdpGqAra7fv8KDAktqDFCKlg>
    <xme:jogtZyjVkGiF25Dmo3zXk_44yXcTfB3pxzS_sPr0hDKqG80njcR_p1_pC7a0PWyKS
    6lIjSWovi7fj10axg>
X-ME-Received: <xmr:jogtZzkKbc2dMSpAGojRhppd5k2yhLX_P7i9U3fYYprKthrA1koL-V9W0Qwz-bJ2Dv9mPhRLRJYIlgp0xYcJJk-Dk3LjPeExNwVi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtdehgdeiudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrdduke
    eksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepph
    gvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:jogtZ2z8C46cVyyV2rgmjwPknYFiA-YOoyorp_Mtmr5N_E3z9AhrEQ>
    <xmx:jogtZ1RGt9dTumiiWRRmC-kIRh7ZUJeI2YrEJ-WPYQQbuLtUsNbzBA>
    <xmx:jogtZxYGj7B3FRbIgAVYI4uT7senzqiBknX9VM0ThuYZwZPCZBam2A>
    <xmx:jogtZ-TsQs96RDMeoY8B2AJL1Atk1Dsvk8MR8_6kmwz7vnsdocDcYg>
    <xmx:j4gtZ-KBmr6BIxnyaPd_d-u92P-6j1UkXcaEkGPOCqIpuj4vIcJIY1a9>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Nov 2024 22:42:06 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  me@ttaylorr.com,  peff@peff.net
Subject: Re: [PATCH v6 8/9] config: make `packed_git_(limit|window_size)`
 non-global variables
In-Reply-To: <3a8e3b88df28ed65cc8fbce3d51dd1cc19581e7e.1730976185.git.karthik.188@gmail.com>
	(Karthik Nayak's message of "Thu, 7 Nov 2024 15:10:35 +0100")
References: <cover.1730976185.git.karthik.188@gmail.com>
	<3a8e3b88df28ed65cc8fbce3d51dd1cc19581e7e.1730976185.git.karthik.188@gmail.com>
Date: Fri, 08 Nov 2024 12:42:05 +0900
Message-ID: <xmqqbjyqpf1u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> The variables `packed_git_window_size` and `packed_git_limit` are global
> config variables used in the `packfile.c` file. Since it is only used in
> this file, let's change it from being a global config variable to a
> local variable for the subsystem.
>
> We do this by introducing a new local `packfile_config` struct in
> `packfile.c` and also adding the required function to parse the said
> config. We then use this within `packfile.c` to obtain the variables.

This patch has no string "packfile_config" in it, other than the one
in the above string.  A stale description?

>  		if (!win) {
> -			size_t window_align = packed_git_window_size / 2;
> +			size_t window_align;
>  			off_t len;
> +			struct repo_settings *settings;
> +
> +			/* lazy load the settings incase it hasn't been setup */

"incase" -> "in case"?

> +			prepare_repo_settings(p->repo);
> +			settings = &p->repo->settings;

This change is curious.  How can p->repo be uninitialized?  p is a
packed-git list created in some repository, surely it should already
be initialized, no?


> +
> +			window_align = settings->packed_git_window_size / 2;
>  			if (p->pack_fd == -1 && open_packed_git(p))
>  				die("packfile %s cannot be accessed", p->pack_name);
> @@ -661,11 +667,12 @@ unsigned char *use_pack(struct packed_git *p,
>  			CALLOC_ARRAY(win, 1);
>  			win->offset = (offset / window_align) * window_align;
>  			len = p->pack_size - win->offset;
> -			if (len > packed_git_window_size)
> -				len = packed_git_window_size;
> +			if (len > settings->packed_git_window_size)
> +				len = settings->packed_git_window_size;
>  			win->len = (size_t)len;
>  			pack_mapped += win->len;
> -			while (packed_git_limit < pack_mapped
> +
> +			while (settings->packed_git_limit < pack_mapped
>  				&& unuse_one_window(p))
>  				; /* nothing */
>  			win->base = xmmap_gently(NULL, win->len,

Other than that, the changes to the above block that uses the local
variable "settings" looks good.

Thanks.
