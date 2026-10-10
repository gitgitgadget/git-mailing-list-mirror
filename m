Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F85126FD97
	for <git@vger.kernel.org>; Sat, 10 Oct 2026 00:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791591850; cv=none; b=kq3AMDYSa56rfMQnfSJQDijcZdCk97B7P9qzh0eF/qzazjraE+94Vev12J1LyBBK5K5N0hWpGPrGBRc0wKwi/K6dwHZgDoPfpSBv24UeOsSO763lGPvowyG9KRNYfCwyn1TqdiaERysnbrxrkfYhOsCTh3EWeZ0K+Udqv4uh4DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791591850; c=relaxed/simple;
	bh=gjSb9pFqiLwJqcyy2gee4JtyO+vlJeDrRs7SAiwiwz8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k4FVNMBP68IvC44n2txx4NSfJdNprUzI45zmFt+h/rmze/EZjYdmoyG6VXJD2G+JrXq8va+WKms/uhC5L6xVRdKrTzPavj69fMTzOcAWPZMjcr2QP3BL8LLkHJ2QmnhZJbW/G6LHl9p3S2VkHXAcCZjaPjdde2OI7auFx+ZvED4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Svf0lHIt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WDpQlC/4; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Svf0lHIt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WDpQlC/4"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 4509E1D000E2
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 20:24:08 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Fri, 09 Oct 2026 20:24:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791591847; x=1791678247; bh=CfLKqO4kbL
	BGGNFq7X/Yk5geyxvZqU52Drx9KVR1vMg=; b=Svf0lHItC7sgoHBNd5TtCSGzmx
	N7rqyK3h8xtZZDp8M0eqO3Ww9fIwwKOWt4z1IJM8t7le+dDGuqKiItLO6LVlhoDK
	X8NY/sYTocL2QYDWpVkUlVO23UgAVGcpAfuQS2p1Ng1cjNZ+BkNV+Mz6gWtuo+4a
	yTHH1Layw9P0l7vEiaHfJbRYxDFHBGxsl4HYtV3ODKazd8pFqr2nH+q5VSC9nC72
	EOhcckhURJJbAgJWe/Vejbs3J3I0mfJoTXITCi2CjMXvvIrj8rjT3desINucp4K/
	e9jL/f/cDfkmOevsvlMaDDNqHhsWU974AOl4fKz1l03+v0Ht55YtnTLi004Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791591847; x=1791678247; bh=CfLKqO4kbLBGGNFq7X/Yk5geyxvZqU52Drx
	9KVR1vMg=; b=WDpQlC/4gekpDBlEitX4zFCFr8Fo8/CqOOVRL/+YzN1vCf3459w
	aHjxUBvNYTLsBP5QbrqvKPHrkpziB8pzazFbLEADodEv+mksNtU/1viX9rrFjdGP
	9QLGgrk+5EnAn1uT569d7EItI3OB4ELIMRtloc3zOBwWM1y1Y/MJyyNCvuQti5+1
	DVUIbRAIh6lue83MEngs3u4o92wTOtgw4sPFrRbtEF0vmc0TmDX7/smShKwRFdWU
	YBe9pfqQCO25J1XnbfvlUcEnUTCS/gjHVaTLk65ZpaxuURbC6YDjAiAmcw68UldZ
	GdxOJ5HGySNBAIHoeX1nsfpMRuh5LpekuQg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791591847; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:AML7ftkRFcCl8TnqEDEdrvFIo7gz/8iypAffRgsiO9RsrAB
	hWjBFvnROGsby50xBpMlWDFFhMkbE3HpLtU2T8aorjOpl4Zp4dF1ILs18k5nPm0v
	etbVsmv9q05gsGCDjAUUDLCcfrlskRq/kVjC4NSs5dJetTkP868wBvJCWs4fz2jU
	dcHklLe5tHUvkl0Bv1SGrnIl+e5ixlYj1FwGIrxjFXxagNJy5VVfhErka8CeJ/c+
	Jz5eIAvQn5rNuwTU+cKphBCUprXQfKa2klo8MrGTq/ny8yDlJTvf7gBLUnirMFcO
	13IWmJPouzGujQYzPD6BG8hTsPngHMml7DtbvWw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:uBGmRmXF8MDuU2IjPYz+0aSp5O62YH/175dv1freSkM=:gjSb9pFqiLwJqcyy2gee4JtyO+vlJeDrRs7SAiwiwz8=;
X-ME-Sender: <xms:p4XJamwB2fwtoUraaFTRlUJDDpj4vDJJ8oFUKAVpn80ImMEgQRa0Zg>
    <xme:p4XJapKJabIkvOguWN3Glg5vbkc7P8aHyuiSF1Motm5u7MYMhp5HzUX8nIc4y6cDj
    Y333ZIUdjr46nmWrXr57hy6z7hgJz-wZr4nPEl_iBXxBIKGSLI>
X-ME-Received: <xmr:p4XJagpSM9rs0XWCNs-jcEZY-Uf7PtErZk4k2EQuYw6mmDAiOL9EACDRZEPhVuY_MnzjSahncMFkYiBWPxNMsfp-44uDGipbFOtM>
X-ME-Proxy-Cause: dmFkZTG1DI/0vpKyzYsXyOPKIhwX9T6qPPtq8TxBV4tA0qcXOL+eceKGuvANWzHdua/xFP
    wOzo1fzv9j+Y3qz3uqJJ2eH5KwcixTsD40AWm8mPqXnPkEmx0IbiSP3aR9SDEQMB233JUo
    UL1fktVMk47MeGYqNw+KiZJ3CTC48XX48o5Cf5bPY2+57yj2yYLEDuQBFT3+BvnYTazQmO
    BZWvpjW3IPFsxS7uVpCWrDokxLwv+YOOOJ1fR+9WIXn0n3FJzrlYENaAmCpameCVgHSXc/
    zb/lAGwbeI515gewZVjqtkBDQ6V81aDpB5V9Me7TwYOFzUSIZ96Ct0SJ0LsRmnFDd/ivUY
    5i8tpGhTUCNSRqFx+Mgyg0QO9q9gMgTxr9gkq/NkCUGzVqC5ys4MZqxepZxsNk/b30/fZx
    1MLzxZieJk5cX8oV1An8Aq3+sg+tU5z0KfTD06JkAvuGFYpajweLVR9wVf4mY99Tzv7uGl
    qGnBxO7iezDeqRjfQvVUMDKS9Vj3oM7PR23/0I7nmrZZdaGFPolGlclqXJV3lyTcLhyCp/
    v6qNfTHRqSpQlVy2M6qW8RQ1gfgmURz/aUExsQiTR2bHlc0fDkIFMY3UDuYzUtragGZjvz
    k8PNYL0wT4V4Qq2Ll2SvnZTjAVKV9zX0Bl8enbkb7ZiAr+sYAZiDQONqEPKQ
X-ME-Proxy: <xmx:p4XJaoIUaNbFcD3aJNVKnmL7gERLsdc-weLIRueJRCO_sPdv_vsQWQ>
    <xmx:p4XJalREq6UBoSW-NRHecG76F2CpueIslFCUWR_1pmXHZBLA-5-vTQ>
    <xmx:p4XJanvpu0JxtGqzIKswLBpQm4sCVPGftM9Pg2xWgcxChwCg3yy54g>
    <xmx:p4XJamYzZHvco5wKu_j7yL9onbRDQLOKZuD_j547ds-oc2wPSg3Bsg>
    <xmx:p4XJap8IPJZzKSIScYR6YxiKdSMCqu7_5CTRRrQ9yn207vLvv9umGYFM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Oct 2026 20:24:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  Johannes Sixt
 <j6t@kdbg.org>
Subject: Re: [PATCH v3 2/2] merge: remember conflict labels
In-Reply-To: <182edb2e8874986206a38a0af005e4df9ef9dd8f.1791537203.git.phillip.wood@dunelm.org.uk>
	(Phillip Wood's message of "Fri, 9 Oct 2026 10:13:25 +0100")
References: <cover.1790761727.git.phillip.wood@dunelm.org.uk>
	<cover.1791537203.git.phillip.wood@dunelm.org.uk>
	<182edb2e8874986206a38a0af005e4df9ef9dd8f.1791537203.git.phillip.wood@dunelm.org.uk>
Date: Fri, 09 Oct 2026 17:24:06 -0700
Message-ID: <xmqq1p9yjtcp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> @@ -347,10 +349,19 @@ static int checkout_merged(int pos, const struct checkout *state,
>  
>  	repo_config_get_bool(the_repository, "merge.renormalize", &renormalize);
>  	ll_opts.renormalize = renormalize;
> +	if (read_merge_labels(the_repository, &base_label, &ours_label,
> +			      &theirs_label)) {
> +		base_label = xstrdup("base");
> +		ours_label = xstrdup("ours");
> +		theirs_label = xstrdup("theirs");
> +	}
>  	ll_opts.conflict_style = conflict_style;
> -	merge_status = ll_merge(&result_buf, path, &ancestor, "base",
> -				&ours, "ours", &theirs, "theirs",
> +	merge_status = ll_merge(&result_buf, path, &ancestor, base_label,
> +				&ours, ours_label, &theirs, theirs_label,
>  				state->istate, &ll_opts);
> +	free(base_label);
> +	free(ours_label);
> +	free(theirs_label);
>  	free(ancestor.ptr);
>  	free(ours.ptr);
>  	free(theirs.ptr);


This function is called once for each conflicted path, which means
we would read the "merge.renormalize" configuration variable and the
MERGE_LABELS file, both of which will stay constant during a single
conflicted "checkout -m".  The issue is shared with the original,
but looking up the same configuration variable repeatedly would be
helped with in-core configset cache.  Compared to that, the overhead
added by this patch is to open the same unchanging file, read & parse,
allocate and deallocate.

Perhaps we want to have another preliminary [PATCH 1.5/2] before
this step to allow setting these "per invocation constants" once to
be reused?  Then step [PATCH 2/2] can read labels in the prepare
phace just once, use it from the data structure in
checkout_merged(), and free them in release phase when we are done.


 builtin/checkout.c | 37 +++++++++++++++++++++++++++++++------
 1 file changed, 31 insertions(+), 6 deletions(-)

diff --git i/builtin/checkout.c w/builtin/checkout.c
index c0f0d2c700..a02cbacf1d 100644
--- i/builtin/checkout.c
+++ w/builtin/checkout.c
@@ -310,9 +310,27 @@ static int checkout_stage(int stage, const struct cache_entry *ce, int pos,
 		return error(_("path '%s' does not have their version"), ce->name);
 }
 
+struct checkout_merged_data {
+	int conflict_style;
+	int renormalize;
+	/* we will add more later */
+};
+
+static void checkout_merged_release(struct checkout_merged_data *data)
+{
+	; /* nothing to free (yet) */
+}
+
+static void checkout_merged_prepare(struct checkout_merged_data *data)
+{
+	int renormalize = 0;
+	repo_config_get_bool(the_repository, "merge.renormalize", &renormalize);
+	data->renormalize = renormalize;
+}
+
 static int checkout_merged(int pos, const struct checkout *state,
 			   int *nr_checkouts, struct mem_pool *ce_mem_pool,
-			   int conflict_style)
+			   struct checkout_merged_data *data)
 {
 	struct cache_entry *ce = the_repository->index->cache[pos];
 	const char *path = ce->name;
@@ -324,7 +342,6 @@ static int checkout_merged(int pos, const struct checkout *state,
 	struct object_id threeway[3];
 	unsigned mode = 0;
 	struct ll_merge_options ll_opts = LL_MERGE_OPTIONS_INIT;
-	int renormalize = 0;
 
 	memset(threeway, 0, sizeof(threeway));
 	while (pos < the_repository->index->cache_nr) {
@@ -345,9 +362,8 @@ static int checkout_merged(int pos, const struct checkout *state,
 	read_mmblob(&ours, the_repository->objects, &threeway[1]);
 	read_mmblob(&theirs, the_repository->objects, &threeway[2]);
 
-	repo_config_get_bool(the_repository, "merge.renormalize", &renormalize);
-	ll_opts.renormalize = renormalize;
-	ll_opts.conflict_style = conflict_style;
+	ll_opts.renormalize = data->renormalize;
+	ll_opts.conflict_style = data->conflict_style;
 	merge_status = ll_merge(&result_buf, path, &ancestor, "base",
 				&ours, "ours", &theirs, "theirs",
 				state->istate, &ll_opts);
@@ -446,6 +462,7 @@ static int checkout_worktree(const struct checkout_opts *opts,
 	int pos;
 	int pc_workers, pc_threshold;
 	struct mem_pool ce_mem_pool;
+	struct checkout_merged_data checkout_merged_data = {0};
 
 	state.force = 1;
 	state.refresh_cache = 1;
@@ -462,6 +479,10 @@ static int checkout_worktree(const struct checkout_opts *opts,
 	if (pc_workers > 1)
 		init_parallel_checkout();
 
+	if (opts->merge) {
+		checkout_merged_prepare(&checkout_merged_data);
+		checkout_merged_data.conflict_style = opts->conflict_style;
+	}
 	for (pos = 0; pos < the_repository->index->cache_nr; pos++) {
 		struct cache_entry *ce = the_repository->index->cache[pos];
 		if (ce->ce_flags & CE_MATCHED) {
@@ -479,10 +500,14 @@ static int checkout_worktree(const struct checkout_opts *opts,
 				errs |= checkout_merged(pos, &state,
 							&nr_unmerged,
 							&ce_mem_pool,
-							opts->conflict_style);
+							&checkout_merged_data);
 			pos = skip_same_name(ce, pos) - 1;
 		}
 	}
+
+	if (opts->merge)
+		checkout_merged_release(&checkout_merged_data);
+
 	if (pc_workers > 1)
 		errs |= run_parallel_checkout(&state, pc_workers, pc_threshold,
 					      NULL, NULL);
