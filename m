Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B59A1BF33
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 04:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783656066; cv=none; b=n+ehWEbwuJjcCL9bhL4Sg3C2yIXoVTFHh+Q+InjA9CTFK+xwuQlZFSJlUDPv2ZlG/Mfgq+OLuNs4dwsXnto2IWfyoI81IPJaW/sm88NOgZKX/djmvE45d7ok2nXlVBt0c49cG+2vUaqj4NsqQqMfkxrQLndNTK8gJd5rwNcpwb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783656066; c=relaxed/simple;
	bh=O9Kzcwt6fkg9oPZIF1RLannexIx226/DuQi1PzMuEO8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=d6uJor/j0AqIaNZbuGbgN7/2+kiV/JDEOpBLDZi0vYabIYT2Ms7MkRtBR6i/cBGdulN8dz5QqNtfOnaSe4uhP4aDzVhz3OIfvvbzqbawdU0FIZ7JIO5BerhuyT7825uJU4cOD54zfC7zWQJMaWUwoUOKQTuvthfrD27OFHGk9Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Sdvj364T; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lO43kqCK; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Sdvj364T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lO43kqCK"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6B15A7A00B7;
	Fri, 10 Jul 2026 00:01:04 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 10 Jul 2026 00:01:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783656064; x=1783742464; bh=0ge93OW+sf
	9j2z9TvJmzqGEbpwePqPR4hoPIC1E7Wt4=; b=Sdvj364THbFn4BqfU6ofEfHm7V
	p2Pc6wgbRPidkcruYFoalLD7jniua+8FLZR1NRLPSrUmnWacw9dSNa1xRWCS4Zn7
	e+PE7qTZtDiuq8d4QxOe1XS7zhXaD0nVf+yFoKmD+1AsagDnhdZG/eZF52hnsgI+
	XKSsF+5TRbYbTAHSYgSyQ0tGO1vk6D32bS1+l3d8Gi/YwQaD8NvPT5KxyvpyqUwC
	CZYPWRPLo9EEplSYGxI9oWVBxzst9x90pOlbgG3SYTKU2z/kUE/vJ3N3MC1hpo3k
	2gvN/AACTXHBRI/SDW6s850681q5zWkc4sHiz5bnzMQm7XrQ1t8DYw9WtfRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783656064; x=1783742464; bh=0ge93OW+sf9j2z9TvJmzqGEbpwePqPR4hoP
	IC1E7Wt4=; b=lO43kqCK5nnqHnV+2EY9NiBpBcSm5BYsKERtBmPnx3CpIVLY5gv
	tonPNlNNDy0uyveBQiFE49ywZGGiCTBa2l//RYTOnyHyzIlKJh9hV/1xCchP6QL8
	yV2m8ZwT3o5tl7HJufWJJWn6aX9KzeY/guKPtF0N/2irM2dGcE86zkPRspTfPvDM
	MenjcCWnPf8paPp5uJzr9LkWNNKmLHvZ+m9tETRKO8yyb4nloq+70v5Cs8QrSO8c
	jZWnw7ZI1yjUaMVs52uPQo/vlCmS/+9u4LPWO069fu3fZGspuAH0l6yucljGIxYM
	rDWnUCK+VIpkVSUw5tq6CyQi3o7r5Oma33Q==
X-ME-Sender: <xms:gG5Qaj4sxs-fOkKr4vj43545VoVzCwOaxJVEOZfRRPYtRDlxhsN5rQ>
    <xme:gG5Qav5Kd3NHgR2M9rTy6uWKGAeEHXZXOQP7PmMv1RMB2JtdKk4TOhK9Q_DHKIStX
    TxG66-i8rBUm7bZQoc1t_4_nrrBay5UM3tI02MKdwGx05e4pQRSOA>
X-ME-Received: <xmr:gG5QavcvPSv1cH3_Upbqksb5SOcKUBBUTUXcRJlR8jJuFN9rL1HBRRKAxkmcMhEwUC66SCwsv96OUtqGFsaBpi-aj8M8gaSkiC4aDXU>
X-ME-Proxy-Cause: dmFkZTEVBcmIiPnRPyXmGXk9NoJLn9WiMepMs2ClqUJUCytYAL4WWVsTBlCqMDMSyuePFX
    VfQRqF94MVY5RkexoT/iAckAQf17WWhoKg8EN9uT1FELy7BD1AK8ZlVUyEHDm9fd3qeSkK
    RowXa1tB2nXfhXmLjOspI8Tl9jBliUon4Kzhk/bqaQkTuwvZiB2Pp3f9Y5j4MJbYs90NiR
    etxKGT4qwX3GCBwdLh/K/EG1U54dftV5rSE5N2PheA8ir/dQCf11wvlQ2R0KXM9rIA+I4s
    eKWOf18XjkzmIQ9dZRuFm7jk3PLQ6R2pgCoukkL/cpblqEmEVVtLh5U1IRAbAFIeU5mEcj
    IdrGK8XH5VxxxV46Jg4rxVfbc0mjrg+YGFiWTNpUXXXxVz7WXR+mt80Joc9mAwJie8l9v9
    NzKXFMp1osW6XW3yQEBa25fnvQOovAiNJeXAdsbsGmIxjghmmYC/rZLmOgeCKDBX8YY+3R
    aPwPwzwleYqUZPXEduuEjDBdTu/kpzvc5Dz0cjyLbLIiV/uj9sWhhuie4cimDGTApg0CNE
    njjjiqSnhjlk8Wk/wkbDAiKisehjxUlXTBvDETttXq66212Em6s0sR0oChgltEzA7bNHcq
    O+tspU64n9wDDbfLKdH7LG/vNOfLB125Ua7kdz/HRYJHXOrMfKon8kvAy2Dw
X-ME-Proxy: <xmx:gG5QajBk-aQL6jSHEZz3L0jivgx4fax_qFXv19wHiiXOvGTzBpcSAA>
    <xmx:gG5Qai_-s_fIhmZ5AWYGRGIsVJU4v2TTuJidZo3npztQ9yME1VSXNg>
    <xmx:gG5QauLB65GzA03UK8RfpDhz_nzv4naI-LYMtIcFCb5jwrPVOsdHQQ>
    <xmx:gG5Qaris1TGP0nlMTInn_zm1G4I9u4a8BTFnD5YRG7KA3uBGdvEXnA>
    <xmx:gG5Qak0Fs27TA4aC3MB1kJ1OKDDATgOcqUQb8_eB2aeNjWE5NcYt4m3O>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Jul 2026 00:01:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 10/11] bisect: ensure non-NULL `head` before using it
In-Reply-To: <428a3a006bbcb165a96495bbc2c5fc04e5b15db4.1783590159.git.gitgitgadget@gmail.com>
	(Johannes Schindelin via GitGitGadget's message of "Thu, 09 Jul 2026
	09:42:37 +0000")
References: <pull.2174.git.1783590159.gitgitgadget@gmail.com>
	<428a3a006bbcb165a96495bbc2c5fc04e5b15db4.1783590159.git.gitgitgadget@gmail.com>
Date: Thu, 09 Jul 2026 21:01:02 -0700
Message-ID: <xmqqqzlbfq81.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> When `refs_resolve_ref_unsafe()` is called to resolve HEAD, and returns
> NULL (e.g., HEAD does not exist as a proper ref), the code falls back to
> `repo_get_oid("HEAD")` to try to resolve the OID directly. If that
> succeeds, execution continues with `head` still set to NULL.
>
> Later, that variable is passed to `repo_get_oid()` and `starts_with()`,
> both of which would dereference the NULL pointer.
>
> The scenario "`refs_resolve_ref_unsafe()` returns NULL but
> `repo_get_oid()` succeeds" can happen when HEAD is a detached bare OID
> that the ref backend cannot resolve symbolically (a potential edge case
> with the reftable backend) but the OID itself is valid. In this case,
> the bisect-start file does not yet exist (this is a fresh "git bisect
> start"), so the else branch is taken with the NULL `head`.

I agree that setting head to the string "HEAD" is a good solution to
ensure that !starts_with(), !repo_get_oid(), and skip_prefix() are
not called with NULL.

However, I am not sure I understand your "can happen" scenario.

I naively thought that the only case where HEAD does not resolve to
an object correctly is when HEAD is a symbolic ref pointing to an
unborn branch.

Is the bug in your "can happen" scenario something we can
demonstrate?  If so, could you add a test to prevent regressions in
the future?

Thanks.


> Simply assign "HEAD" to `head` as a fallback to address this.
>
> Pointed out by Coverity.
>
> Assisted-by: Claude Opus 4.6
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  builtin/bisect.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/bisect.c b/builtin/bisect.c
> index 6ff600c856..a69771c6d3 100644
> --- a/builtin/bisect.c
> +++ b/builtin/bisect.c
> @@ -811,9 +811,11 @@ static enum bisect_error bisect_start(struct bisect_terms *terms, int argc,
>  	 */
>  	head = refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
>  				       "HEAD", 0, &head_oid, &flags);
> -	if (!head)
> +	if (!head) {
>  		if (repo_get_oid(the_repository, "HEAD", &head_oid))
>  			return error(_("bad HEAD - I need a HEAD"));
> +		head = "HEAD";
> +	}
>  
>  	/*
>  	 * Check if we are bisecting
