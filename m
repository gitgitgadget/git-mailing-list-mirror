Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2223224B06
	for <git@vger.kernel.org>; Wed, 30 Apr 2025 22:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746051708; cv=none; b=ptDtrxFlSpIFBvYiJQuhpMESI7CSvfodCKgrkhqgWYRYJNtV4W9m83NDRJc5eenlGVFLX9qXCoqBxN3p3MsK8VsaleIimRfRtzujwpXAGPHQl+gvzA/1Zvoz53OjoQ8FzhlCaEDNWzctuZtC1NXY9xRj3sd+8ZTYG/wwp2XzhTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746051708; c=relaxed/simple;
	bh=D+JJ7xQ8COUxdIEwQdvBH6xgP8LGi8uVsBc6W2fsj7Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=H46W+vwEgU09oyHZAKxh3mOxAC+RV54ttAbiwFQja+A2zgfNbyHWrYqhCOyfn+HLFOKvORSdCF8jqMsd/nwSkovyclrW5NmxA7uuSQ7lfK7SZSyVkXPaFCSWh80wL5DUnV8O//dXiK88gcy4fwu3ZaZF1qlQpz3t6Bw1iKJoh98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CRNzN/ix; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ql3VfWk6; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CRNzN/ix";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ql3VfWk6"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id B6305114017A;
	Wed, 30 Apr 2025 18:21:44 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 30 Apr 2025 18:21:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746051704; x=1746138104; bh=WbmlxSueMz
	S8y3HnU/ebkkl31uZLNY/yJG+D8aIjs44=; b=CRNzN/ixiR+ojNANkJcCKEZlya
	JvXxK1r93CJxzS+sHYsBtTCCuHsHrMXBE68rbOHBz9yBETFODMf7Nz0ULDcjFj4u
	pp2Zt5yHOPEi/v8mFQBHNBB/TaBPI6KzJKMnUXVCbGdUaW9jd8IUzueI09eomqTl
	zCGvWS0H1oWilcALPU0e94l8dTJBdIDKj/PIgwqfacUe/hkpIUiFybpUOajdnVPj
	HmyCk9RwllQoMIW2/KylPBz+LpFW5wDHYH1buMDbW/PL2W125CcobWCnYw8/nYvG
	G9/lDsZb93tlM9/n6iV51ZCxO1Bo39qc1nwU8lzE8yUhrf3EGub5jFskOfrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746051704; x=1746138104; bh=WbmlxSueMzS8y3HnU/ebkkl31uZLNY/yJG+
	D8aIjs44=; b=Ql3VfWk602PVOIYonEO21qBTM7H1ZI19pmVon7tgHBhrwc7DOOX
	LK6fp6x4BcW95XSmfSDtIsj/2Kun2vZzarIkhxUbx20LqkQ8V9VxGtGh+XOOFxni
	qhV8Gser7tRV6LVJWx0/uMRTNiYDr6xdaeZ4mZr99NrUC4F82Dgb5Sj4FPzDiv44
	SRoRT++LeCXulEyzVs3d0M7novqp4cc2ZMKCPE/645H+6w6h5Y2zIypRpL1zxD+G
	QFDAeZsb4irqKfx+yl6EDNalEtkWQARnKNED6Dt5LdM38Lskuuz9FtgY3xijFItP
	aH33dI+FyA8xPvp44isrNaOR5oItmPlCR8g==
X-ME-Sender: <xms:eKISaHbPiXdz05PU5IkxNWx-4RWgoOh6utwRVfAQJJUHv_D7OCUcIw>
    <xme:eKISaGZ1z5KCTGeP-1G0Vti7l7uvMMcyF--3Zmsardn4YordExUKikyBXkTDSjxCk
    hjtj-LBqs9cE38i8w>
X-ME-Received: <xmr:eKISaJ_4NovGMqVO4wICh09mdYqBA6b5ixjyeNM_g1p9UuqyI_8IxLlLN3wb6me_sCn3e09gPHFn1BM7WaohJU2AjhA7T0J5k8QP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieejkeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    oheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtohepjhhohhgrnh
    hnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomh
X-ME-Proxy: <xmx:eKISaNohPgMaE2b6ETozXoGD9BjEBLt3nyNrIklQYx-tEQXKTslSeQ>
    <xmx:eKISaCoKGrG6cp5NEG-CtUOHpltqhwCtrjQvFC3lOxZZi-1hiS3KrQ>
    <xmx:eKISaDSs1hh3kkiNKbo-0sTS4UExybtY7S9G1ZSAkP6XK4a7JzlHbg>
    <xmx:eKISaKqbq7xiQ5fP2miDXW1t6nAjZS4m8z-eP63GyRWk0R4fVm7pHw>
    <xmx:eKISaLqs-hIDU9DPWqfil5ZUVOMNWCUad_x5pw09WWnUzDoK5t0z3J6h>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Apr 2025 18:21:43 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>,
  Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] builtin/mv: bail out when trying to move child and
 its parent
In-Reply-To: <20250430-pks-mv-parent-child-conflict-v1-1-11a87c55ffb9@pks.im>
	(Patrick Steinhardt's message of "Wed, 30 Apr 2025 14:44:57 +0200")
References: <20250430-pks-mv-parent-child-conflict-v1-0-11a87c55ffb9@pks.im>
	<20250430-pks-mv-parent-child-conflict-v1-1-11a87c55ffb9@pks.im>
Date: Wed, 30 Apr 2025 15:21:42 -0700
Message-ID: <xmqqmsbxz3wp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> @@ -368,8 +398,7 @@ int cmd_mv(int argc,
>  				strvec_push(&sources, path);
>  				strvec_push(&destinations, prefixed_path);
>  
> -				memset(modes + argc + j, 0, sizeof(enum update_mode));
> -				modes[argc + j] |= ce_skip_worktree(ce) ? SPARSE : INDEX;
> +				modes[argc + j] = MOVE_VIA_PARENT_DIR | (ce_skip_worktree(ce) ? SPARSE : INDEX);
>  				submodule_gitfiles[argc + j] = NULL;

OK, this is the part we both missed during the earlier round.

> +			if (hashmap_get_entry(&moved_dirs, &needle, ent, NULL))
> +				die(_("cannot move both '%s' and its parent directory '%s'"),
> +				    sources.v[i], pathbuf.buf);

OK.

> -test_expect_failure 'nonsense mv triggers assertion failure and partially updated index' '
> +test_expect_success 'moving file and its parent directory at the same time fails' '

The new title is much more descriptive.

> -	test_must_fail git mv a/a.txt a b &&
> -	git status --porcelain >actual &&
> -	grep "^A[ ]*a/a.txt$" actual
> +	cat >expect <<-EOF &&
> +	fatal: cannot move both ${SQ}a/a.txt${SQ} and its parent directory ${SQ}a${SQ}
> +	EOF
> +	test_must_fail git mv a/a.txt a b 2>err &&
> +	test_cmp expect err
> +'

Shouldn't we make sure that after failing "git mv" the paths and the
index entries stay as expected?

> +test_expect_success 'moving nested directory and its parent directory at the same time fails' '
> +	test_when_finished git reset --hard HEAD &&
> +	git reset --hard HEAD &&
> +	mkdir -p a/b/c &&
> +	>a/b/c/file.txt &&
> +	git add a &&
> +	mkdir target &&
> +	cat >expect <<-EOF &&
> +	fatal: cannot move both ${SQ}a/b/c${SQ} and its parent directory ${SQ}a${SQ}
> +	EOF
> +	test_must_fail git mv a/b/c a target 2>err &&
> +	test_cmp expect err
>  '

Ditto.

By the way I think "git mv a a/b" in the same scenario already
notices a problematic request, so it probably won't hit this
codepath but we shoudl already be covered.

Thanks.
