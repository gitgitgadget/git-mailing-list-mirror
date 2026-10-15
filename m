Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462F549E122
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 06:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792047341; cv=none; b=NzVky7uhhFF0vyDaitQOPPSXT2YIKnxCTLhVG2OuaTowVu338+TuSsOhoDzoZY8HYiNNG6eoSPck+cyDTka8JISljf9p0mFPkqo4S1sbcmcwn16Fe4AYOb5DfUpgv1agfFFlG8nfuj+2CIM3/oO+ub+yvb+U/eEwn0roAo3/gHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792047341; c=relaxed/simple;
	bh=n1419sWS6F8KfykQKnaf+hzJwhIL4LqBz2d6/rPtUAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TNsjfdRqv4SFLAUHxyr9E4YYK1rzoYkeEvxQHI2dzW/BngAZbcOt3zohhMzjT+dPCLUhcw8Gck6na5JUNmiCty5n0p8EB3cOcV6g3TgEiAnAhT92IVne/eeHdkPYhir7zwO5QH3XxFbh6zTVsED1uCU8OizGveDfr4OInBDGrlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nv2jmgJy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LlCTzwj6; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nv2jmgJy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LlCTzwj6"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 2B9631D000D4
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 02:55:33 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 15 Oct 2026 02:55:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1792047333; x=1792133733; bh=b5ZNxlsiaY
	sGSoBtmA5Xb9bCVJG3ypmX3DqNRK03mIg=; b=nv2jmgJy8Qai90/iuCkBJiOTKV
	CKLamYE4OcRsDgXbYuN/NCMnt7uKtEyoL3Uw0jdupzRHdvZGMLF+OtI5xTQhcsWW
	doFMT7OYsumQiKxBgXFpVTuPZTmSv31SBRwRGuoBVZVwMhiy+xKbZyTv/YPxKOEh
	ScOO9uVEAK7RPj3anQpyon0wa7auZtjbU3dEr788U8HA/HIPQivM+dsaUMm6eri+
	bisKOHfpIsl3U8fSZTpZ8YcM6FXnek8SMRYNcTMBKgcBa1xMKZ4Z10DL5xoFnS85
	CKcxe5tnOHSrkUI2ByyBIw3iOUY78oxHpX0R7u7ctL5mf7Uabxx5cnroJIDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792047333; x=1792133733; bh=b5ZNxlsiaYsGSoBtmA5Xb9bCVJG3ypmX3Dq
	NRK03mIg=; b=LlCTzwj6qHfIqpMfoOR7sqeQ0Gss6nD7eBpz0NWQvklqoQ5MsA4
	pOQ8RndjhLyoA4fglJ6FW9K7hQ3YbXXl0UuQLRpijQMFcylFzsgUXUYjfVhd1TOe
	z7ytM7/5Rpq+SB6aOp3jG/q5A4nfqF+9SahXixh+GveoIo77fwgdZpmBEKnl4okM
	ECljx+/jCSqXMwpS+Low+FY+xQL0OmbiETaA6gBaDPjBpz/7x3vjvYO5CiPFWgtZ
	Sm9EMbgBYb1crpJzsFbldYT+BKtk8rZFGx6K6eDf6nPnTfMmLQ4LzAg9v4YPPKxc
	9QP41H85fn3TTWKJZvJ2yydaH65Vk/RkPwA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792047333; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:JCGY+frT67sLtSRtgaRVcaJRztFBYt6vJfni8T3sFCR89Vi
	qSakFxqq3LVXMj7smX1flySVvNtgzl+Duh4p/mMwO+Ki3W0ynE7p8K2XWk3xHJCo
	MWqILwuVvd6iXOcZjDxZzsq7dGbxdCz3uZcS54g0xr2E4rcsVbnYXA/OcX7Veew4
	HPCXUlFqxRHjX+ZHTMc2bq7/iyaeOKPo9Z6NffIkNBBSkn6Ai+q0xStgmWuGkzQT
	a3iKTKYz0VT6tPGzMqzw2l0EbEz8bvb0lT3T3cHvmtCtUa0qJ2xA02qnzdfnkYlO
	B9fFf+UZ+HE96CN3rv7yOvyNFXru6m7l+BApS6A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:nsIEPfUwwEaSmIB1rbkpp8ChHUCuAeMwD7nrHZODjok=:n1419sWS6F8KfykQKnaf+hzJwhIL4LqBz2d6/rPtUAY=;
X-ME-Sender: <xms:5HjQaudxS4T8ndR9n_jSSFn5dbWOIP5ZWmsEYzqMnP55ZY1tbyjZog>
    <xme:5HjQavoAOyFglyzuogjKOiKXxIMsWdlZKG6cj0B8zd5yIxL66ZyXuJJCOLeg-i2Y2
    xBHvNZEliV0N96tWNAVHAiYR2kp9xYSfq4Aplp0KrX7tvuyNiPnYQ>
X-ME-Received: <xmr:5HjQas4O9g-YwQC6e2XItwQLaUrPFM2DUONFCBPO7UepHkpsqTqVuyUDlQXQ8KulGyRl5HQ>
X-ME-Proxy-Cause: dmFkZTGCaI+9vszqq7PsXJlDqnjG2KgY6aHgBkg9+/r8Wip7UnB70qswzRu9NL6bdamAkr
    UKC2T2ACjmHXbDsrpfdQsotbw5kKNACBHBKELLHSeLkiXjvRErtOkzezkpdnzW9jxgfODL
    4KZARb+uQSSBCxiKE9pOQ7Z7Tisauq44+0r57nu/CXl4HnMIeY5vKDqnN27WT4+epbACK1
    AL9YT3mcXVrUxULNtyansdtLUOX26O3qwdnwd9NAb01gYCZhX4UQyD3TGTPF87ohXwqzpl
    hbfb8jgZIJHrAIxSiH3Rf4aYZHXRzf9CwoZUSGp3lM6A+5tRiyd5vjb1mbna6R/+Go1BLG
    kzjeW0lWYP1OLhPOk8amHUvhwe88mN6R5K2I2xgSyq6vwwd2NzXy8B7Mq/Ph148ZVUWuHj
    ktGTlLAix3CXofss+7MyhJV66Mc86Zzaw4KmX07qgRQz+V/K9sNnYdUfuA3i/H6zuEWVPm
    0MQVXaXubO05acRiA4nFRzv4Q7KAGzrggEw9JaxMKIlaFvmY98sExnEPBNbMZ/F6kZUp80
    hhBdCGouueGeVQ9q6hLHHManP8d581Ki92QOZ+KBe5qyeox3RqYbmlxcLh4+xF2eCf3V6F
    ITtG7zzgiZeeXNxbpGrCkRHpXbPIPoCOdr4/Ucwvwb0OxSBFZtaHCsC7Ms7Q
X-ME-Proxy: <xmx:5HjQalrlww8QuBLWgqwMomgKc5QJI19jtHqyNupihZDdGyKuNYDaVw>
    <xmx:5HjQauj-0Jvg0RL_rHB78lLXqfDyFZJ9eaJ_Fud4pLzl7QDl2dpiHg>
    <xmx:5HjQavJ5clXZx5mfGPG3fA_B8hgE7VsB69rpDUxd9fKnEOHvGEy0WA>
    <xmx:5HjQauBhOPBkrpiAXGwEQ-1w5ddMuh52QAqBuAaPqsEhIQrErDemiA>
    <xmx:5XjQao6ccyvXtMCx4AC2I3RdwC9Fkk7fbzeQqtjFVZfZCkiyhnxvkrDz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Oct 2026 02:55:32 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fa25c598 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 15 Oct 2026 06:55:29 +0000 (UTC)
Date: Thu, 15 Oct 2026 08:55:20 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Kristofer Karlsson <krka@spotify.com>
Subject: Re: [PATCH v3 1/4] Documentation: describe connectivity checking
Message-ID: <atB42M2GJ3NitXdj@pks.im>
References: <pull.2211.git.1789379276.gitgitgadget@gmail.com>
 <pull.2211.v3.git.1791806877.gitgitgadget@gmail.com>
 <19ea8cb534f0aaabdf21f358364ad32295b6bfc8.1791806877.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19ea8cb534f0aaabdf21f358364ad32295b6bfc8.1791806877.git.gitgitgadget@gmail.com>

On Mon, Oct 12, 2026 at 12:07:54PM +0000, Kristofer Karlsson via GitGitGadget wrote:
> From: Kristofer Karlsson <krka@spotify.com>
> 
> Add Documentation/technical/connectivity-check.adoc describing
> the connectivity invariant and the full connectivity check.
> 
> Signed-off-by: Kristofer Karlsson <krka@spotify.com>
> ---
>  .../technical/connectivity-check.adoc         | 110 ++++++++++++++++++
>  1 file changed, 110 insertions(+)
>  create mode 100644 Documentation/technical/connectivity-check.adoc

Shouldn't both the Makefile (`TECH_DOCS`) and Meson (`articles`) be
adapted to build this?

> diff --git a/Documentation/technical/connectivity-check.adoc b/Documentation/technical/connectivity-check.adoc
> new file mode 100644
> index 0000000000..abef02debd
> --- /dev/null
> +++ b/Documentation/technical/connectivity-check.adoc
[snip]
> +Full connectivity check
> +-----------------------
> +
> +The full connectivity check runs a `rev-list` subprocess, feeding
> +the new reference tips via stdin.  A normal invocation is roughly:
> +
> +    git rev-list --objects --stdin --not --all --quiet
> +        --alternate-refs [--exclude-promisor-objects]
> +
> +When promisor remotes are configured, a fast path based on
> +promisor packfiles is attempted first.  If it falls back to
> +the `rev-list` check, `--exclude-promisor-objects` is added so
> +that the traversal does not trigger on-demand fetches.

Would it make sense to document that fast path here, too?

> +Consider the following graph after a fetch, where all reference
> +tips point directly to commits.  For simplicity, only local
> +references appear on the already-connected side; alternate refs
> +play the same role.  N3 is a merge commit:
> +
> +            /-------------L2
> +           /
> +    C1---B1---C2---B2-----L1
> +          \         \
> +           N1        N3---T2
> +            \       /
> +             N2-----------T1
> +
> +    L1, L2:         local refs
> +    T1, T2:         incoming tips (new refs)
> +    N1, N2, N3:     incoming commits (N3 is a merge)
> +    B1, B2:         boundary commits (already connected)
> +    C1, C2:         already connected (but not boundary)
> +
> +The incoming set is the commits reachable from the incoming
> +tips but not from the already-connected side.  Boundary commits
> +are the already-connected commits at the edge of that set.  Here
> +B1 is an ancestor of B2, which happens when incoming branches
> +fork at different depths in the existing history.
> +
> +The `--not --all` arguments establish the trust boundary: the
> +incoming set is the commits reachable from the new tips but not
> +from any existing reference.
> +
> +The traversal then walks the trees of the boundary commits and
> +marks those objects uninteresting.  Trees of incoming commits
> +are verified against these marks, stopping at objects already

Nit: "verified against these marks" reads a tiny bit awkward. How about
"Trees of incoming commits are then walked, stopping at objects already
marked as uninteresting".

> +covered.  The cost of marking boundary trees uninteresting
> +dominates when the boundary commits have large trees, even when
> +the incoming changes are small.

Overall I think this part is a lot better now, thanks.

Patrick
