Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08F0286D69
	for <git@vger.kernel.org>; Thu, 28 Aug 2025 20:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756414285; cv=none; b=p4Uy7l/1axltjtL97xja7F3oNXH2oFzUhuUvJUhKNIiMq38U0l8IRav8myk1v7ilVY7NPZIv4xlzjVc1HV7nE6v0/Lv4fYkTCE09UVa8AKvKujUSLzVhXg2MxtIznNYU4HfMPYQqu4utQtOIOOMVTS4RRdzvqG2xcuVNb2QdsVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756414285; c=relaxed/simple;
	bh=xdRiFXD4x76kNe0F8A7gRtVKAmgFNLdFWx+p8ynaJ8A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=K4hVNnbAtzwl85BODEm7h9X6/1XIJ2r6TpXumchmyRYXZg8R3jxep4hgs0ZGXZhBfWwK86px1oGgBwWRU+gv1maKDrdQxaddHmhkZ3x2XJ7vzpXdVLk/pp4Gn1qJDO6TA0MjQ+4PMgZtpMynOGn9q+047OdpASIIWQbF8kZd6gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ovagmw/b; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C8X/8ZXL; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ovagmw/b";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C8X/8ZXL"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id B394B1D000B1;
	Thu, 28 Aug 2025 16:51:20 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 28 Aug 2025 16:51:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1756414280; x=1756500680; bh=oD1sKYJiGv
	RUscx+gzgKc07NMFo7+hNg5bCs2nPqUPg=; b=Ovagmw/buS/+TzZlGyp+K61CmZ
	JZOM7VvpL+4Gy+8GCvoz/BPVsbnwuLsyGDDUzUyB4+EZbTyJiSI8PTAubjXzhisz
	CcNXcBxL2YsfTuIjAjjiRui0F4x1wBB9MQ8XlMuTtKsz/xy3lYt1r7tH2XDRw429
	l0k2PcMJMY1glSOeIPDsfU7iSobe4bD8hek8+h6MR30ViGgiejViAChXE3+axliV
	AOpnSYQLwE+FS5r39z5c4kDPzjBhTBkCRlcntSymjiKSgNe3z63KWOXBxLGNa9Yg
	41JXtt2SJZjFFLVkOkcflSaSpO7K0bKoZs/4dvJ3YKn8cM3KGqUtOox9uXxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756414280; x=1756500680; bh=oD1sKYJiGvRUscx+gzgKc07NMFo7+hNg5bC
	s2nPqUPg=; b=C8X/8ZXLxUOJIAjlTndROacwqeKNrXmLrlewMfbZLAeOBeTe4PT
	ztIF3F+Uh8P1lyHxC2FdHrF5m5wzCZdj0SiWzPagsOgGfVkzWw7jXCUO4v9gaEw/
	6TyDVxjmT1EoTZAM5Bl9Gd3Ifq88g9bh42JVbkwy91qYPI8Sp2KNsSPD160P0smx
	qIERImlKu5gPGk6/eAD/RMAk1+kYwUsMLnSIuo0Y/qUnPd2uMuEAPX9k5J8XR25O
	zRZ+R3lKu9CpUmftCGQhQE0cMYSSOhnqHJykjp41TO3WcnY0jeKtGuaogBQqjD2l
	Vcx1/ysAn+gT2Kv17XIUDLGwuqDn36Quq3w==
X-ME-Sender: <xms:SMGwaPOZNcpcPbI1YjkXKdpLV6eL77XeSNWYh--mwg8oheOsmF4dyw>
    <xme:SMGwaFdxOYreJr8LPP9eNXyZz_2XEBxb_hkndYJ-BM80ai6n_LeRvh4j3wfuVCOGR
    704br5ju-MKfc1LTg>
X-ME-Received: <xmr:SMGwaEuWHurJPxWpv6EoMETsmJKtGC8tmJGmrtmaZepQL5Ih2zLqqqYkmq2MWKXDPqYPMFH0b9cRroGAy5IhO8-cV-QS9a7Hfz3EnHY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddukedvtddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepshhtohhlvggvsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:SMGwaOkcR_aPSRLOk681L2it6No8ixUl1fUa7nJu72A1ccoAl9nhLw>
    <xmx:SMGwaOz-CHnyex02TCk1zyn3u0YcHTi8tLMGMN8v77HGRuXBoxbnpQ>
    <xmx:SMGwaIPapZ0wHDV7GEy9j2gqkT-fLITFxZkwM4O8RN3WLpTXlixp2Q>
    <xmx:SMGwaCr9JCRbgwOFkL7dV-AvpeK8_dP-hovU9SEEG522cKoMF8Ym7A>
    <xmx:SMGwaAjzCilbC_87Z-ZNAh4rL4qCeaPTXJ9tHKGMz2NJgzFlZqK-6tmH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Aug 2025 16:51:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  me@ttaylorr.com,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 3/5] midx-write: use cleanup when incremental midx fails
In-Reply-To: <a5bee036019a044273f93434f9e382a4cfa6533c.1756402795.git.gitgitgadget@gmail.com>
	(Derrick Stolee via GitGitGadget's message of "Thu, 28 Aug 2025
	17:39:53 +0000")
References: <pull.1965.git.1756402795.gitgitgadget@gmail.com>
	<a5bee036019a044273f93434f9e382a4cfa6533c.1756402795.git.gitgitgadget@gmail.com>
Date: Thu, 28 Aug 2025 13:51:18 -0700
Message-ID: <xmqqwm6ntbjt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <stolee@gmail.com>
>
> The incremental mode of writing a multi-pack-index has a few extra
> conditions that could lead to failure, but these are currently
> short-ciruiting with 'return -1' instead of setting the method's
> 'result' variable and going to the cleanup tag.
>
> Replace these returns with gotos to avoid memory issues when exiting
> early due to error conditions.
>
> Unfortunately, these error conditions are difficult to reproduce with
> test cases, which is perhaps one reason why the memory loss was not
> caught by existing test cases in memory tracking modes.
>
> Signed-off-by: Derrick Stolee <stolee@gmail.com>
> ---
>  midx-write.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)

Good thinking, but may I suggest us to go one more step to adopt
even better convention if we were to do this?

Pessimistically initialize the "result" to -1 and let many "goto
cleanup" just jump there.  And have "result = 0" just before the
cleanup label where the success code path joins the final cleanup
part of the function.

This is often the right way to make the flow easier to see, because
often the success code path is straight forward, and these error
conditions are what employ the "goto cleanup" from many places.  By
starting pessimistic, and declaring the success at the very end of
the straight-forward success case code path, all other flows to the
clean-up labels do not have to set the "ah I failed" flag.  It would
eliminate the need for patches like the previous step if the
original were following that pattern.

> diff --git a/midx-write.c b/midx-write.c
> index 85b2d471ef..f2d9a990e6 100644
> --- a/midx-write.c
> +++ b/midx-write.c
> @@ -1321,13 +1321,15 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
>  		incr = mks_tempfile_m(midx_name.buf, 0444);
>  		if (!incr) {
>  			error(_("unable to create temporary MIDX layer"));
> -			return -1;
> +			result = -1;
> +			goto cleanup;
>  		}
>  
>  		if (adjust_shared_perm(r, get_tempfile_path(incr))) {
>  			error(_("unable to adjust shared permissions for '%s'"),
>  			      get_tempfile_path(incr));
> -			return -1;
> +			result = -1;
> +			goto cleanup;
>  		}
>  
>  		f = hashfd(r->hash_algo, get_tempfile_fd(incr),
> @@ -1427,18 +1429,22 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
>  
>  		if (!chainf) {
>  			error_errno(_("unable to open multi-pack-index chain file"));
> -			return -1;
> +			result = -1;
> +			goto cleanup;
>  		}
>  
> -		if (link_midx_to_chain(ctx.base_midx) < 0)
> -			return -1;
> +		if (link_midx_to_chain(ctx.base_midx) < 0) {
> +			result = -1;
> +			goto cleanup;
> +		}
>  
>  		get_split_midx_filename_ext(r->hash_algo, &final_midx_name,
>  					    object_dir, midx_hash, MIDX_EXT_MIDX);
>  
>  		if (rename_tempfile(&incr, final_midx_name.buf) < 0) {
>  			error_errno(_("unable to rename new multi-pack-index layer"));
> -			return -1;
> +			result = -1;
> +			goto cleanup;
>  		}
>  
>  		strbuf_release(&final_midx_name);
