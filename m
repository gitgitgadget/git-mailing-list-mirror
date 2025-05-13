Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD112AD25
	for <git@vger.kernel.org>; Tue, 13 May 2025 21:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747172679; cv=none; b=TWzJwI0TutL0KqmpXWaW0w3URwFplGEfUcOJj2bRMfyMfKgeu7hQIFXk+/xZDpBgOtaqVTHQmtaRCWDNkwygZheJEtUAfr+QdH1yrnuMNeTgGvaa4kkcwALvMFc7MWnAhJQA3CFyasaUEoqviM6/fWGxMtJQe3xoJ30PtTTRSLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747172679; c=relaxed/simple;
	bh=XfR6EPtCz+6Jf82Q3pOIOvH5TyjdSoeL1pcHTL9yAfs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nRfi1TT0Es2MAluXAIkanAzTJ96Kq/92RRj/SxqLfJisA8BiLSN91Q+5ZxbkQrflPHXVO2DTbhuOCn5w+mqrSw5tFuTObBqXUsMG1D0o3im0FSSI500thTqfztIQUCMGMBgcUOLi9bxTIo/828WQ8tiBEw2n/5L7SjcDa+h5KpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RueEvSfE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vvgYup+l; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RueEvSfE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vvgYup+l"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CD9181140112;
	Tue, 13 May 2025 17:44:35 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Tue, 13 May 2025 17:44:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747172675; x=1747259075; bh=Z4F9wk98pu
	/NCQDkRGX0sPOpppQuAc0A1pg3leZrDcc=; b=RueEvSfEln7IW2lVXHadAtf0UI
	PsT4LkNgXj2gvlG0gdoDrCMJefZiuoyCb8QWxRCqeSufY/ysBLYwvelAUNQ+yP/F
	ip5mkttNBoR1ZQsK+G1+adkmbW6jCZwkLW9ZH78vxr5P1ZgZQQD8PwVeMvZfKPeM
	DLbScPWJftJ+10eZb0eiKcZCdqFN2xE4e08ytlR/3Hfhme+0woZhOIc3HSIvlYpW
	4FH9rlaQ2ognlLljTEC2pX1sje/XHR90PYB72Bgrg3FyOyVdEV7hF7YRzwNPjSwH
	AyzJ0ChkVpgwDnN86SgnmxJpGJwk29b4LKgmvz3p8y5HcIVBtV19N/GX1UKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747172675; x=1747259075; bh=Z4F9wk98pu/NCQDkRGX0sPOpppQuAc0A1pg
	3leZrDcc=; b=vvgYup+l1mZCSuXCthKYyGz1ElnkidrKqdriAOQnhMNVrkjn+Ko
	mv9OIspYQ6IST+17R1be3/87t9zLQXiOGvH4NS4Jx6nvyywwYHCdcowpBQku1xzW
	makQXcSQQJiCdXqFL0V2QL1eCMD5xjDi9yv8Hf9QfapAaYwZsMMau5vMxTQYcKMU
	gFl1vSW3/2eIzV1G09uJBrGc+tD1dIcVV4n4tXpyhPHw6ZznCJbr4GDXjnVp3GmN
	YxlV6eVRwRKs2kd0ma9f0icIkPQ5riFiBI2eS+DNxiOCDd2t2mHo80vC2JjR21B1
	jrjDE5B627xf5h/YAJUxnR9LAKwvjQia2Qw==
X-ME-Sender: <xms:Q70jaLNVCIx4rXKN9Gv2mIxAeZrLpTEqTeBxbrmIZl-gV4vpdjS_pA>
    <xme:Q70jaF9rhZ8o7FJGYunkZLuMyLr1vVrf6WlA7VVtyQKXCPIlLEYejYIiZAItLrulN
    p3eFrFtzarKI15C7A>
X-ME-Received: <xmr:Q70jaKRpOh-CgpsvZDFYlcp8xl8sxw-1FBZGFwtohdQuFsMiaTFCpa1Z5f0DLboUiNxRPhcppPNk9WKzm7zeuTl4OtoiTzo_mbdaEdk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdehvddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhgrhigrthhhvg
    gvrhhthhhkuhhlkhgrrhhnihdvtddtheesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomh
X-ME-Proxy: <xmx:Q70jaPu-26a_k2qRdiREXmWPcdyI_A-SGcJR8UoWH8_pMeihP3sTEA>
    <xmx:Q70jaDeXzW7--vdPpMf8KSm-MY2x63xQkicrcWqBsbFKMEa79C23cw>
    <xmx:Q70jaL1o_3zeqHCUrjvC6QAon4dqktPig_KSYRzdTSAt6G8JZM8QvA>
    <xmx:Q70jaP_3spcyWhxR0kZdUZZxOnEXB_ib1NazzE8VVCO7pQ8j9v0Fyg>
    <xmx:Q70jaGK_eOl0KGEmJsbNjSbBMKyTNtwkBhvh5uFi4-89BXcXo7vYg_F7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 May 2025 17:44:35 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] submodule: prevent overwriting .gitmodules entry on
 path reuse
In-Reply-To: <20250513033403.91365-1-jayatheerthkulkarni2005@gmail.com>
	(K. Jayatheerth's message of "Tue, 13 May 2025 09:04:03 +0530")
References: <CA+rGoLdzT01jLigX=Z+_tw715O0BibgVA+Sj+65Qwee7i5gLfg@mail.gmail.com>
	<20250513033403.91365-1-jayatheerthkulkarni2005@gmail.com>
Date: Tue, 13 May 2025 14:44:33 -0700
Message-ID: <xmqq7c2kgp8e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

K Jayatheerth <jayatheerthkulkarni2005@gmail.com> writes:

> When a submodule is added at a path that previously hosted another submodule
> (e.g., 'child'), Git reuses the submodule name derived from the path and
> updates the corresponding entry in .gitmodules. This can silently overwrite
> existing configuration if the old submodule was only moved (e.g., to
> 'child_old') without renaming the submodule.

OK.

> This patch improves the `module_add()` logic by checking whether the
> submodule name already exists in the config but maps to a different path.

We frown upon a patch that says "This patch does X"; just give an
order to the codebase to "be like so".  I.e. "Improve the module-add
by doing X..." is how we phrase a proposed change.

> In such a case, Git now errors out unless `--force` is specified, thus
> preventing accidental overwrites. To proceed safely, the user can provide
> a new name via `--name` or use `--force`.

The above explains what happens in module_add() quite well.

What is puzzling about this change is that the new helper function
and changes to configure_added_submodule() is not described at all
in the proposed log message.  How are they relevant and why do we
need them?

> @@ -3443,6 +3452,7 @@ static int module_add(int argc, const char **argv, const char *prefix,
>  	int force = 0, quiet = 0, progress = 0, dissociate = 0;
>  	struct add_data add_data = ADD_DATA_INIT;
>  	const char *ref_storage_format = NULL;
> +	const struct submodule *existing;
>  	char *to_free = NULL;
>  	struct option options[] = {
>  		OPT_STRING('b', "branch", &add_data.branch, N_("branch"),
> @@ -3546,6 +3556,32 @@ static int module_add(int argc, const char **argv, const char *prefix,
>  	if(!add_data.sm_name)
>  		add_data.sm_name = add_data.sm_path;
>  
> +	existing = submodule_from_name(the_repository,
> +					null_oid(the_hash_algo),
> +					add_data.sm_name);
> +
> +	if (existing && strcmp(existing->path, add_data.sm_path)) {

If the name is in use, and the submodule with that name is at a
different path, then we are in trouble, OK.

> +		if (!force)
> +			die(_("submodule name '%s' already used for path '%s'"),
> +			add_data.sm_name, existing->path);
> +
> +		/* --force: build <name><n> until unique */
> +		struct strbuf buf = STRBUF_INIT;

"-Wdeclaration-after-statement"

> +		strbuf_addstr(&buf, add_data.sm_name);
> +
> +		for (int i = 1; ; i++) {
> +			strbuf_setlen(&buf, 0);
> +			strbuf_addf(&buf, "%s%d", add_data.sm_name, i);
> +
> +			if (!submodule_from_name(the_repository,
> +						null_oid(the_hash_algo),
> +						buf.buf))
> +				break;
> +		}
> +
> +		add_data.sm_name = strbuf_detach(&buf, NULL);
> +	}
> +

What is the memory ownership rule for add_data.sm_name?  Earlier we
saw in a pre-context of a hunk that this was assigned from
add_data.sm_path, so in that codepath it is considered a borrowed
piece of memory, but here the member has to be the one that owns the
string detached from the strbuf, which eventually must be freed by
somebody, or it would be a memory leak.
