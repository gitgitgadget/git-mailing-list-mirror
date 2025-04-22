Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5092C259B
	for <git@vger.kernel.org>; Tue, 22 Apr 2025 22:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745360750; cv=none; b=YyfAXd0ZRaFwQAgPrEEdobsKu8fxfctZFgUgaSE1d5bkfPtzXVg7oUZxXTEe38xA4guRoChhLTFiJnmQHX0qVA6eOyGYkn1c1sY/kbIO/sE0qPnjpRrj5T+fb/+lVBSZpNGPbFSxGGQz242JHNWJLW6yDwxEV5Bk3N9Q7Q9JLAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745360750; c=relaxed/simple;
	bh=xpplY4xQAbiWlPORX+SLGgG1svPHP7k1yIRtc9e4TpU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RK/iyZU2zqiZyZoI0QVJWUOS2ZgHw7px+GMz+FFzbLf15IBJRNgQ72gwS3yM54h4/AQxfrdZG9xvm7d2uKnr8Ts8NGjgNZuiB6jYlzfcP1PQVW6Qu1iuMJEis8jbBanaiMV5+Db5OgKdlApLt/Rkh/FP6iLIGBSUsIby0Kw/XVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=lK1qlCi1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Hk7TVA8+; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="lK1qlCi1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Hk7TVA8+"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 516FE25401A9;
	Tue, 22 Apr 2025 18:25:47 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Tue, 22 Apr 2025 18:25:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1745360747; x=1745447147; bh=6f7SHTn9AB
	nA3MlXJ8sfo0cPJRH/f+lsjyKLLo/wahg=; b=lK1qlCi1dxOxtRfFS4CwAZecGa
	tnEgf960wAYDkJkS0g7lF9bPftT2VoJJpIkQWLT6aW5elnnCMC1OqTB7f7R6XnvA
	CsOSRdTKtf3HYLNBVP2yR/BhtA9Aw47aFxrAMpeWcgphJieYqjGWdS5Vox6tjxaS
	gMRHl2mx3QxnX0uZWIcXs2m0R/wK+8h5CYu2ZoE/gAxBFKbDNSydoTOLMeZBcisv
	GRV4pJhyRbTbzTLzmd4xgcY2bf9pDfPgQkmJqloHLmNjsgNbJm8fI7gpkFvAjlC3
	6HY3kbH0vGmOmsWmwq7ll3sXTLxKLYVnYuxzlDXWifN5UK6K+sFVf90YYvWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1745360747; x=1745447147; bh=6f7SHTn9ABnA3MlXJ8sfo0cPJRH/f+lsjyK
	LLo/wahg=; b=Hk7TVA8+VrJrWP+RbCNrLEPnodOAk282UuiVG0OMCm6jC9aVcff
	9QfratVyIBOMdk11QXoFiALnedyg6ZCcIAElACqD8QuszrPEW/uPG267gYldYKfZ
	OP4Zok3hfF+UBkS7c4cwvdXhCltfjUI0qjUqx543NtnpgMRwIFm5T1ehLulJFeaH
	2EcnAy9EU18HJdU9SOvcBvd6qoVrRaUnXoLu5hXfUknp0GFrHB+J2ileJUyB2qAy
	w2OWhCNVQ+W2+IhDTyE9/snmAhjlWh54CFWWB6LwUQYHgCbXwxt9nsK9ApczE6iB
	Eu/fZAUB0L9Y/zWe4kozuLv8PBsFUNY3ONQ==
X-ME-Sender: <xms:axcIaNqO1TbDTo5uDWj-naCmZlZcNh7VA7YilkafJbrW1lDs-n-7NQ>
    <xme:axcIaPrKMzwc2Ng4ZVieq6KJNnJUHuLkEiWzAqPNkvtqv-eWShSrTBa_xj97ad09v
    Iw2175364KMX68h_Q>
X-ME-Received: <xmr:axcIaKNgQgyWE0mfF-RNWF8pkFFeFSZvHXTzCCm3wpetFiXAot-ko6C-wKXbZfza2Fm94xZjytPlMbAeQLDqVztI1TXZmbeC4LGM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeegledvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhutggrshhsvg
    hikhhiohhshhhirhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:axcIaI4DPZA74fOC9xMTtiqEhRxJNAmH2NMs84lIsFQt0NUFg6TlYg>
    <xmx:axcIaM7bV-J9eCm_ZhIpQhMJlWgTK1iFVILnn0jfbo4MFv9AlrUGFg>
    <xmx:axcIaAhHshUPFXG3HTzb7lehxh8DzDqh87FqXesNZbKUMVOMYJcnFw>
    <xmx:axcIaO7_tkb2yYjXlHLV7cAr7jR3_Iwr4EvObdS9wj-4tPSX3tw2ZQ>
    <xmx:axcIaCHLHH9wyO3K01r6eUoZykZfnSnBvJGMfXh-CWfAtagV8N6NJDJ2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Apr 2025 18:25:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im
Subject: Re: [GSoC PATCH v2] revision: remove log_reencode field from rev_info
In-Reply-To: <20250422213133.18685-1-lucasseikioshiro@gmail.com> (Lucas Seiki
	Oshiro's message of "Tue, 22 Apr 2025 18:31:34 -0300")
References: <20250422213133.18685-1-lucasseikioshiro@gmail.com>
Date: Tue, 22 Apr 2025 15:25:45 -0700
Message-ID: <xmqqcyd33kba.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lucas Seiki Oshiro <lucasseikioshiro@gmail.com> writes:

> Remove the log_reencode field from struct rev-info, as it is not used.
> This field was introduced in 52883fb, but it hasn't been used since its
> introduction.

"52883fbd (Teach log family --encoding, 2006-12-25)" is how you
would refer to existing commit in the history.  I'll tweak that part
of the proposed log message before applying so there is no need to
resend.

Thanks.


>
> Helped-by: Patrick Steinhardt <ps@pks.im>
> Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
> ---
> Hi!
>
> Since this patch wasn't merged, I'm sending a v2 only applying the nitpick from
> the previous review in the commit message :-)
>
> Thanks!
>
>  revision.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/revision.h b/revision.h
> index 71e984c452..87f8d798c2 100644
> --- a/revision.h
> +++ b/revision.h
> @@ -292,7 +292,6 @@ struct rev_info {
>  	struct string_list *ref_message_ids;
>  	int		add_signoff;
>  	const char	*extra_headers;
> -	const char	*log_reencode;
>  	const char	*subject_prefix;
>  	int		patch_name_max;
>  	int		no_inline;
