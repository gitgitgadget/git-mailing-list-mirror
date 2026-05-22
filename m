Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E670A357CF3
	for <git@vger.kernel.org>; Fri, 22 May 2026 05:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779427769; cv=none; b=IH5ox2uVXiUz1QMZX6t0ajA/vbFHKAsYFFlkahvpeArR7o+F1Sob+sTIAQ2GJG9mIPXV9bpBNX7k/DCN+1nEqsEMi9YUom/DTiMeAe+QeZ3GUDVdWm35GC2EYYLXx+MsmYZNb14KaNidbfpIl4zZFRpmA1kqFnAtsI0DVVOr45Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779427769; c=relaxed/simple;
	bh=bC2MyaNsNyNZfK5ay9SebXPYLRFswLSAVQC7yivYQQM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=n/JJi2ppNilS9a6ZPtZb3IYIbOYvjf0BDOBN9h2OCRt3Ot1enS9v2xdiBJwGw7BYtxTOpx59FqVOyZ+LEqsFc4WU5wtCd6IWWIgWJ9bsOQIoBGFKBOy5QRNqztgyDrjBbUflST4PvTpJdco7HLft16UA2mrPRTBkIpioUDBMHSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PW35BZZa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VwktLKcG; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PW35BZZa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VwktLKcG"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 350661D000E0;
	Fri, 22 May 2026 01:29:27 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Fri, 22 May 2026 01:29:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1779427767; x=1779514167; bh=S8wUuo65tC
	JTKPNsp6PJo5Gz0JoK4gYCYtiCJ2AAcM8=; b=PW35BZZazKPaJoOSKcAbLgNi36
	QqabHNGAfzZplF1TXFZilxWQwbLaksZG/NQUdO/GsU0NPS5v7tbrn5ehqTICVch1
	vuGGoh/4GHK4mMj90g/mYtCidiKFOMC/0h6phdUvW9LQW1il859hEOBIHiEmgGaH
	llYzkYNycsLYRnrbYFpcaFaakXt0okK+424C9nIQ4dRpDtOQWrvSRxA2rAksa0+n
	7HIgMqk1CtpVnXtlacrW1SKBCuci6BT+EYP77akjD372Y5wwzM6VAPys3HPxOJNw
	O5DK7VCjxfNGVFXBOFhJyZ+IR8iopJcGl21UJ7T1Lrnil4mEhVj6UlEB9arw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779427767; x=1779514167; bh=S8wUuo65tCJTKPNsp6PJo5Gz0JoK4gYCYti
	CJ2AAcM8=; b=VwktLKcG0BCiXnCoaxsnhy3OiXse9cu9LVCYYjIzULv4cAssPAC
	g+JE6Dbk1WRJTQAz/wAb98QvLh5asZUxuk+07pygMf8xU5NdR2iDmdHzhEdJ9Jzf
	CGN+vf2El9Ew0jf16F2MPYyV7fWKErQa2NwTrO7MFOB+p9rOrudktGmvrdKenbMY
	TkkzJISNN6eNcE9doZ/dm6+rpstHy/DZIMOxljeknMCy7mv41YMjnUvHWJFQd4IC
	JpUkhjtNWhxZ8n1VGHiPITjYMyDXeUMqj7mQTc7b9+kKhTmcoq70EWp+jSlxjnwo
	H1lMWHwhBdpXlwaq/vhzhJNAfGrwVp6UgEA==
X-ME-Sender: <xms:tukPasbQYDoftSySBBrbsj2Ko4tfqYE-DbUIspKVbrkTREf_d5KSbw>
    <xme:tukPauaIgWTWnSqFYAAlY7ilNBawl1X3P2EW371bOJvUzKb7sNdn45h1KwPvV836X
    nNSBjcAZ9qjK2HWqx2y2osrEToO-VQHpQsinQIu3w9-SNwlcfukEQ>
X-ME-Received: <xmr:tukPar_7F0KVfa4XLOGD6PIzmynm0zYO6WNgJeE0QC5Z8NCO46ckpc26iKHBaeXIHwOHjo2dYgYCksuvfkXAcZYDRhPzpzZrOw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeelgeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehmmhhonhhtrghlsghosehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomh
X-ME-Proxy: <xmx:t-kPaljYlz_AgvLc81O4_R5TeQ_FguGFWTZiHwNDiEIEOTMD04pdHw>
    <xmx:t-kPajdjZ-7RKkJ4ztcvY-Z2t3Aa7gt7L1THejRig1DFPadaZR5hMw>
    <xmx:t-kPakr2ctz9hEfU6HH2uWriI8jt8dnmZ1_7myIBOg-XHM2IJSPxSg>
    <xmx:t-kPagBtXOaBZkqxfTBOcEdBV27uLqkjbPsPsRBZhwa2GUUEESJzQg>
    <xmx:t-kParemBLtJ3xZ1HblDOcTEVfI5erKZAWrUXd_dM9JNXxLvFrapw_-_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 May 2026 01:29:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Michael Montalbo <mmontalbo@gmail.com>
Subject: Re: [PATCH 1/5] xdiff: support external hunks via xpparam_t
In-Reply-To: <8c0ea0bc0742651e634db7a3002e8cbe1240acf9.1779415884.git.gitgitgadget@gmail.com>
	(Michael Montalbo via GitGitGadget's message of "Fri, 22 May 2026
	02:11:20 +0000")
References: <pull.2120.git.1779415884.gitgitgadget@gmail.com>
	<8c0ea0bc0742651e634db7a3002e8cbe1240acf9.1779415884.git.gitgitgadget@gmail.com>
Date: Fri, 22 May 2026 14:29:25 +0900
Message-ID: <xmqq33zkui4q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +/*
> + * Populate the changed[] arrays from externally supplied hunks,
> + * bypassing the diff algorithm.  Validates that hunks are in order,
> + * non-overlapping, and within bounds.
> + *
> + * Returns 0 on success, -1 on validation failure.
> + */
> +static int xdl_populate_hunks_from_external(xdfenv_t *xe,
> +					    const struct xdl_hunk *hunks,
> +					    size_t nr_hunks)
> +{
> +	size_t i;
> +	long j, prev_old_end = 0, prev_new_end = 0;
> +	long total_old = 0, total_new = 0;
> +
> +	/*
> +	 * Clear changed[] arrays.  xdl_prepare_env() may have dirtied
> +	 * them via xdl_cleanup_records().  The allocation is nrec + 2
> +	 * elements; changed points one past the start (see xprepare.c).
> +	 */
> +	memset(xe->xdf1.changed - 1, 0,
> +	       (xe->xdf1.nrec + 2) * sizeof(bool));
> +	memset(xe->xdf2.changed - 1, 0,
> +	       (xe->xdf2.nrec + 2) * sizeof(bool));

This, especially the starting offset of -1, looks horrible.  The
internal layout of xdfenv_t might happen to match the way the above
code expects, which is how xdl_prepare_ctx() may have give you, but
it somehow feels brittle.  I guess the assumption that changed[]
does not point at the beginning of the allocated area (e.g., it is a
no-no to free(xe->xdf1.changed) or realloc() it) is so pervasive that
it cannot be helped.  Sigh.

>  int xdl_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
>  	     xdemitconf_t const *xecfg, xdemitcb_t *ecb) {
>  	xdchange_t *xscr;
>  	xdfenv_t xe;
>  	emit_func_t ef = xecfg->hunk_func ? xdl_call_hunk_func : xdl_emit_diff;
>  
> -	if (xdl_do_diff(mf1, mf2, xpp, &xe) < 0) {
> -
> -		return -1;
> +	if (xpp->external_hunks) {
> +		if (xdl_prepare_env(mf1, mf2, xpp, &xe) < 0)
> +			return -1;
> +		if (xdl_populate_hunks_from_external(&xe,
> +						     xpp->external_hunks,
> +						     xpp->external_hunks_nr) < 0) {
> +			/*
> +			 * Invalid external hunks; fall back to the
> +			 * builtin diff algorithm.  Re-runs
> +			 * xdl_prepare_env() via xdl_do_diff().
> +			 */
> +			xdl_free_env(&xe);
> +			if (xdl_do_diff(mf1, mf2, xpp, &xe) < 0)
> +				return -1;

If the external tool keeps sending bogus hunks, silently falling
back to what we would have done if there weren't any external stuff
may be necessary to pleasantly keep using Git, but two and a half
short comments here.

 (1) "What we would have done" is exactly the same as what appears
     in the corresponding "else" block.  Can we make sure that we do
     not have to keep updating both copies in the future with some
     code rearrangement?

 (2) The writer of the external tool may want to see some trace of
     warning under certain flags when a failure of the tool forces
     the receiving end to fallback.

 (3) If the tool throws too many broken replies, perhaps we want to
     disable it automatically?

> +		}
> +	} else {
> +		if (xdl_do_diff(mf1, mf2, xpp, &xe) < 0)
> +			return -1;
>  	}
> +
>  	if (xdl_change_compact(&xe.xdf1, &xe.xdf2, xpp->flags) < 0 ||
>  	    xdl_change_compact(&xe.xdf2, &xe.xdf1, xpp->flags) < 0 ||
>  	    xdl_build_script(&xe, &xscr) < 0) {
