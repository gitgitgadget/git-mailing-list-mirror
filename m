Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61234331207
	for <git@vger.kernel.org>; Thu, 22 Jan 2026 23:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769123226; cv=none; b=I3l8lobgwqIuSINtAnyVwxLR7VC3tL1BdQr1y1OIgfsTVBbBbc7N+sgtB0VmlW0H4LvYRoZltTQnDyqrIg+3xRPHeKSKQYvv/6uMTBJgdcwgejrTrXHOnndrqliBDpVQ6akNBg+SnGcBgP7DyV7pG6Ee2nBoApttWWFQKUv85fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769123226; c=relaxed/simple;
	bh=HTDAlGFeWIzl53keITb3UmEhroipWdBVtbYRGWwAxOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gcz285HUfaNIzdbqpByxturnonZq15v/sP1rOibV97uH/clM1eg6ajn3zAjZbPdtEXJsInNj84tCxTvOFII+smCO9wq45EBQuG3IygMiHJ5wQ7hIjEX9U0pyXY5hwbAAbi/p75F2XYmRK/2tXq9oTGLRctaxHw5ppOEXc73wmeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=NihJv1+E; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="NihJv1+E"
Received: (qmail 131312 invoked by uid 109); 22 Jan 2026 23:06:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=HTDAlGFeWIzl53keITb3UmEhroipWdBVtbYRGWwAxOg=; b=NihJv1+EgB1dsvpFHig4yht0wv/Pl0PUMbhRiP/rvLnP9i7fOMuhsz0KAfKXDkCurhmwivgQkar9XEP6WbDj0nLdMLhhegWy6fNV5FUuFYKrAVCD+ljlPYnB11JxoT/eJAVVy+Wf90MTz4a5QKJ+A/hOIEclGY0LU/0bdMp3mu/XOttf/xlbw7+B8mVyrS0DOG0/of3bQrtygEuIQUFp/h2hNN5KB4N4djbw1NhNdpO3P86CeS7us6BHrXTx7/W7aL9j+j2aQEsNWdbVrqDzR/MtV4Lyv7XUcme7Pw4RHBksk7jT4HB13SFRiTUiPLYTz3jquC1+8CZhQQmJZVmfBg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 22 Jan 2026 23:06:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 240527 invoked by uid 111); 22 Jan 2026 23:06:59 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 22 Jan 2026 18:06:59 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 22 Jan 2026 18:06:56 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v27 2/2] status: add status.compareBranches config for
 multiple branch comparisons
Message-ID: <20260122230656.GA2125611@coredump.intra.peff.net>
References: <pull.2138.v26.git.git.1768766353.gitgitgadget@gmail.com>
 <pull.2138.v27.git.git.1769096240.gitgitgadget@gmail.com>
 <0993420fc1185ec4a907a8c3bb52ca965e720c54.1769096240.git.gitgitgadget@gmail.com>
 <xmqq5x8tmlj7.fsf@gitster.g>
 <20260122220154.GA2107958@coredump.intra.peff.net>
 <20260122224427.GB2107958@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260122224427.GB2107958@coredump.intra.peff.net>

On Thu, Jan 22, 2026 at 05:44:27PM -0500, Jeff King wrote:

> The second issue concerns the case when an upstream is configured, but
> the tracking ref for it is missing. So imagine "foo" is configured with
> "refs/remotes/origin/foo" as its upstream, but that branch is gone.
> 
> Using branch_get_upstream() will return the name, even if it doesn't
> exist. And then the tracking-info code recognizes this and reports it.
> But repo_dwim_ref() won't return a missing ref at all, even with
> nonfatal_dangling_mark. So I think we'd need to teach it a new option to
> do so.

So I think that nonfatal_dangling_mark could arguably return the name
(but no oid) for this case, like so:

diff --git a/refs.c b/refs.c
index 627b7f8698..2316d0b8a9 100644
--- a/refs.c
+++ b/refs.c
@@ -813,7 +813,13 @@ int repo_dwim_ref(struct repository *r, const char *str, int len,
 	char *last_branch = substitute_branch_name(r, &str, &len,
 						   nonfatal_dangling_mark);
 	int   refs_found  = expand_ref(r, str, len, oid, ref);
-	free(last_branch);
+	if (nonfatal_dangling_mark && !refs_found && last_branch) {
+		oidclr(oid, r->hash_algo);
+		*ref = last_branch;
+		refs_found = 1;
+	} else {
+		free(last_branch);
+	}
 	return refs_found;
 }
 

But this brings up yet another corner case: substitute_branch_name()
will call shorten_unambiguous_ref() on the result when expanding
@-marks. So last_branch here might be "origin/foo" instead of
"refs/remotes/origin/foo". It's usually not a big deal because
expand_ref() will then reverse that shortening.  Which is maybe
wasteful, but not so bad (though if somebody racily creates an ambiguous
ref, it could affect the results).

But if we return last_branch explicitly, then information is lost: we
don't know what the fully-qualified version of "origin/foo" was supposed
to be. And so the tracking-info code gets confused, because it doesn't
realize that "origin/foo" was supposed to be our @{upstream}.

I think probably the interpret_branch_name() code should have an option
to avoid that shortening. So if we do this on top:

diff --git a/object-name.c b/object-name.c
index 8b862c124e..0663946f81 100644
--- a/object-name.c
+++ b/object-name.c
@@ -1747,7 +1747,12 @@ static int interpret_branch_mark(struct repository *r,
 	if (!branch_interpret_allowed(value, options->allowed))
 		return -1;
 
-	set_shortened_ref(r, buf, value);
+	if (options->do_not_shorten) {
+		strbuf_reset(buf);
+		strbuf_addstr(buf, value);
+	} else {
+		set_shortened_ref(r, buf, value);
+	}
 	return len + at;
 }
 
diff --git a/object-name.h b/object-name.h
index cda4934cd5..20393cb213 100644
--- a/object-name.h
+++ b/object-name.h
@@ -119,6 +119,8 @@ struct interpret_branch_name_options {
 	 * of die()-ing.
 	 */
 	unsigned nonfatal_dangling_mark : 1;
+
+	unsigned do_not_shorten : 1;
 };
 int repo_interpret_branch_name(struct repository *r,
 			       const char *str, int len,
diff --git a/refs.c b/refs.c
index 2316d0b8a9..58f945e213 100644
--- a/refs.c
+++ b/refs.c
@@ -746,6 +746,7 @@ static char *substitute_branch_name(struct repository *r,
 {
 	struct strbuf buf = STRBUF_INIT;
 	struct interpret_branch_name_options options = {
+		.do_not_shorten = 1,
 		.nonfatal_dangling_mark = nonfatal_dangling_mark
 	};
 	int ret = repo_interpret_branch_name(r, *string, *len, &buf, &options);

then all of t6040 passes (curiously without me swapping in "%s@{push}"
as appropriate; I guess we are often on the branch of interest anyway,
so it accidentally works with just @{push}).


So I don't love how deep the rabbit-hole has gone here. But at the same
time, it feels like all of these "if we just do this on top" fixes are
actually smoothing some rough edges in the rest of Git. So maybe it's
worth it.

-Peff
