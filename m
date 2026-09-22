Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CC6420469
	for <git@vger.kernel.org>; Tue, 22 Sep 2026 22:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790116334; cv=none; b=uagBmYtXREJdeslGlLTfbSbECuzZdMG0g9+8zFonFJjniGjTsvTl/+jIoIrYuLVUJ1VwLevMO71rlKKMwVXMZUWJ++AMNI2ky0B3hUxYzrAJ99mswTS1tVd88hXnfjVYVZkuI267UtVtCXUcyJU8TTzjzL4iPPzthh32EsuE/+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790116334; c=relaxed/simple;
	bh=rqmIQJfdVOyf6Sh/SZqR/gXxUn+TUvXovPVorXps9yk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DEPcYlRRqunbipsgET39j2UdgQauUtApitIprvLdy9ePwi7DysjBr8VT+obtgJkKGxNCmU2cXV08xsUIKsHo8L9fXgbX58ayPV+2sGU1aJLOBM4y4WJvqi83gP9E+lWybYIEh+WzgNzQsFcwMGBRvuMtgmf3HAByjzjp9HAH6mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ttbh2R7s; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QxitJnlm; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ttbh2R7s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QxitJnlm"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 30BB9EC0279;
	Tue, 22 Sep 2026 18:31:58 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Tue, 22 Sep 2026 18:31:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790116318; x=1790202718; bh=k1hirF5KPE
	gauDQmiVCJ4EGCB5f2q/9fW6g8Ox4XSjU=; b=Ttbh2R7sv/cF8Yf/1dWrjEmGf8
	726lwf1vgR9X56XMaSdv8FRixotWpPxItDGXDtAS5biCnjHSff3/+8uoyYX1b8KZ
	e30Ezeu3gQqn/R5tQNWvUtgtKHs6euwvhELQb2seF9eRTmtOumIjyaeA01L0fP+E
	1zGWhrPHbGy43va0m1b66nx3/esVMElBR7J9AZ2dFw8nMBCrCXRBZY+RNmBB8bqe
	T8WQQgAEj1LN3AvPyYUUOHKMbqtBpq1mTqBhIPpItmmTXX+iPXbYpY1k8Uf2hW3x
	G87TfTFmg6cvd0ZqTo4AUp+75jZpdBPUeUDa/63g3p2assRpE0289wYXcrhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790116318; x=1790202718; bh=k1hirF5KPEgauDQmiVCJ4EGCB5f2q/9fW6g
	8Ox4XSjU=; b=QxitJnlmD7m7rsmTXPEPyQCFI34JFlGjliWfD3OCfWFYY7T9NJL
	iHMowwIVlIXWrlMId5sv3Nj9UUbnsL/h+eqEZgjiTtVAFmoeC6SOYKu0dcbFlLtV
	TJQE25SRUx2XJ7FvLms0RBTKPxasr+QRejewrf6TZbFCip6lPPjZbQ6/uuI0nPHl
	3zXzMswe+NNBE3PlJtvwClAi40jY9dXszrnyfF+ZRf1v0FV740q7Q+ajszuOl0za
	JjRLmvWVIpG+PB3FkXlHeponvBv0LoXr1Ell9ze/tfdH1U2JQoL16lgulS6eFFIK
	bazXdFwljVzz3HheItnI+oWbrVlOYnxqyhg==
X-ME-Sender: <xms:3gGzajnxm3e50PkD3JyQcbYVjjq3HIzeGPZY6ofO6pr2YzuVP4HL1w>
    <xme:3gGzapHveNWdYJgbxaFTV2hjPKLOC0qsngBOBPA2pTtTxpSdjfH57pmTPzuM_lPKT
    WnKmf2cv4Z18fzSbK9a_OEbFyniQOKY7qjbxgK1wwt--6WtqRW8bwA>
X-ME-Received: <xmr:3gGzar4iqg5Evo2SNvU37juXWfAzEmC-DMFPuFcQJl6cqq-3QQxXZieeMq8n3TTKPHERtHkZm79Gw5NVcA9Ao6BfZ6UtU-i4uoNw>
X-ME-Proxy-Cause: dmFkZTFv4srdiR2NFu1RlOGI4CsruzD+flhpzW6OK9cNaIpvOB4s7vuISRQC3QnSbpWKTZ
    itye0YMC/PWxbAcM6VLeel3tsiHROd53HSv4stkNi520vS6pmfCbRHS2QKqkRGyXNybWjX
    8JlbOM5E+rp9DC6JWV1r0XgbnJUBbxkI/z/BHaDbxw72w5uCIsACkBODnR/6H7ItHDVAL3
    qtnTBuKEsjtPtroxVjrwCkqXzKVBBEWuTdnrnJumugWxx/auRvd5L9oXiqXyAybV22jlMh
    jtZxjqvgaRjIJb9LPxT5IHTCLFvZJas7tNU0lk11Kcn83Hq+2EA+p1Jn/ymCItxbb9EZcZ
    TVasHouiH4vpSG4rwCv27JmhFYKjICj339u+D25uBya50qWCD/SDQbRa5xLeJVm7o73MTH
    ive6w1NRvLaOIzpJk0ylh3oildyfEvDf77yoWQDWnNdaSBHhLlR/pjKNZJqL7Nry23+XZ1
    9xdc9eRadNN6QkBPL45jYcngcAe472N45mvbx5SeeMUSGZO9PRWqqC6PMB5drQvNsI9PYX
    nNwxmTsghKVskZrLAWQ/bOtJErXodHA8OAgopu8PAoNmgwLbcEU+YfuwP9SkTOP6uew5O3
    9Hz3KfygqkLD4MJMum44HRZNqx9sI6iKHm8sP3tiM3KS9Aop6IPHn+z+kbGQ
X-ME-Proxy: <xmx:3gGzahntfnOfUF1XDnJyIC-vDqQIf-yg5oPdl3_cXvRrFn5YZJJsPA>
    <xmx:3gGzago-0L7GxLhK5Hc-H7gpQG2ySVcLVgmqdcyMmNBErKwVMNtAiw>
    <xmx:3gGzagvG7IVtHpQYPngvAmN1iZkq13UWgsAcXMo_KulBErRiIvdLvw>
    <xmx:3gGzalGQvE_zU8bx8S8l3yw4K5FjksMJIYh0eesuxHzGrCMyWsztHw>
    <xmx:3gGzapKX3KXPVm8Vdebjxs7Wb5ZIVGcFFb-1ElI841pV-w54GOBMLoP8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Sep 2026 18:31:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Qin ShiCheng via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Taylor Blau
 <ttaylorr@openai.com>,  Justin Tobler <jltobler@gmail.com>,  qeesung
 <qeesung@live.com>
Subject: Re: [PATCH v2 2/5] pack-objects: reset kept-pack cache for cruft walk
In-Reply-To: <77aec8941f5d17654f58956c7c643b47dd5a8d93.1789700615.git.gitgitgadget@gmail.com>
	(Qin ShiCheng via GitGitGadget's message of "Fri, 18 Sep 2026 03:03:32
	+0000")
References: <pull.2219.git.1789385483.gitgitgadget@gmail.com>
	<pull.2219.v2.git.1789700615.gitgitgadget@gmail.com>
	<77aec8941f5d17654f58956c7c643b47dd5a8d93.1789700615.git.gitgitgadget@gmail.com>
Date: Tue, 22 Sep 2026 15:31:56 -0700
Message-ID: <xmqqjyocdijn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Qin ShiCheng via GitGitGadget" <gitgitgadget@gmail.com> writes:

> @@ -4301,10 +4302,17 @@ static void enumerate_and_traverse_cruft_objects(struct string_list *fresh_packs
>  	/*
>  	 * Re-mark only the fresh packs as kept so that objects in
>  	 * unknown packs do not halt the reachability traversal early.
> +	 * The kept-pack cache was built while those packs were still
> +	 * marked, so drop it too.
>  	 */
>  	repo_for_each_pack(the_repository, p)
>  		p->pack_keep_in_core = 0;
>  	mark_pack_kept_in_core(fresh_packs, 1);
> +	for (source = the_repository->objects->sources; source;
> +	     source = source->next) {
> +		struct odb_source_files *files = odb_source_files_downcast(source);
> +		packfile_store_invalidate_kept_pack_cache(files->packed);
> +	}

This question is primarily meant for folks who are pushing different
ODB backends, but I am not sure this is safe in the long term.

When downcasting finds that 'source' is not from the files backend,
we immediately hit BUG().  Is checking the type of 'source' first
and calling packfile_store_invalidate_kept_pack_cache() only when
it is from the files backend a sensible workaround?  That sounds
like a blatant layering violation.

One of the recent design decisions, unrelated to this, was to make
the concept of "alternate object store" an implementation detail of
the files backend, if I recall correctly.  Do we need a similar
rearchitecting of the code here, pushing details like packfile
management down to the files backend layer, before we can properly
fix this?

Of course, until an ODB backend other than files materializes, all
of the above is merely academic and the proposed change might be
sufficient.  However, relying on an unchecked downcast feels like
laying mines for our future selves.
