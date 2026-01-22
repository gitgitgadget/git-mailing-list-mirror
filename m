Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF4F340286
	for <git@vger.kernel.org>; Thu, 22 Jan 2026 19:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769108881; cv=none; b=d2jpeAD3tC/QEAZV0WM0M/wP6H3mYHNTU9eGdVBxbrfCaZYlHsr/NdOEgxHZJamytmaEV5hy0iYAtygi7+LY5l/PaBnQ+h4YjXWekpOPEHyjoDAe6vzmZujwOd4LyG6f4AEYtfmQ7aQ1+AbQFhl8t4/HvfAhdBDfN7oguirLsnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769108881; c=relaxed/simple;
	bh=6/zHSOnIH0PhJboHSTWTbzNJ5LBrAtFnZALbd86D6+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lC5M5XZPWglZ0iVvRehfM6OSv6c0f4IWAZc0LNPxMti4NNDYkYiBAXgkuzHml3ExPkeuyqFbL2SbQ9r3m4RSxNN8/WnQumAusvV2OSvZ5unLRB2ZxU825bpM9vlm7d+5gwJePNprwD/wkZ80sQAD5rO0EbqgcpYp3Te9ZcAKlQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=J4u56b6K; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="J4u56b6K"
Received: (qmail 130371 invoked by uid 109); 22 Jan 2026 19:07:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=6/zHSOnIH0PhJboHSTWTbzNJ5LBrAtFnZALbd86D6+0=; b=J4u56b6KgI4tsIfb/AGl4TK4KrYe/HmWjOEitzOXCY2miAKJMYs7q1KRJEEe2lCNwUiwBukaIQGIH99NdRaNDWux2QDkImmw4iQR6uzC1VraL8NsWmDhyVRA8H+3x0hPX7xdxb+86eEfju04xrafBcwPXQFIadFCFJ24MCK8U3W/H5ijji/S6GiZNGKV+eLGUnSziMVJGEr8x0wp5PBL+i6Sew4J7B3qcSv9awF8dG2UY4eI10Knrr17YB/ZNVAzU84W7rzRsSEjj3iH2tmC45VP3mO6/UgKsESTUAmCVNJYsHjrCWEqlJc9TzYropjWIgymF/l5wqEg6VczCwLV9w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 22 Jan 2026 19:07:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 236116 invoked by uid 111); 22 Jan 2026 19:07:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 22 Jan 2026 14:07:54 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 22 Jan 2026 14:07:51 -0500
From: Jeff King <peff@peff.net>
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v27 2/2] status: add status.compareBranches config for
 multiple branch comparisons
Message-ID: <20260122190751.GA2098026@coredump.intra.peff.net>
References: <pull.2138.v26.git.git.1768766353.gitgitgadget@gmail.com>
 <pull.2138.v27.git.git.1769096240.gitgitgadget@gmail.com>
 <0993420fc1185ec4a907a8c3bb52ca965e720c54.1769096240.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0993420fc1185ec4a907a8c3bb52ca965e720c54.1769096240.git.gitgitgadget@gmail.com>

On Thu, Jan 22, 2026 at 03:37:20PM +0000, Harald Nordgren via GitGitGadget wrote:

> +		if (string_list_has_string(&processed_refs, full_ref)) {
> +			free(full_ref);
> +			continue;
> +		}
> +		string_list_insert(&processed_refs, full_ref);

Using a string list like this is quadratic. It probably doesn't matter
too much here since we wouldn't expect the list of configured branches
to be very long, though. But a strset is probably the better tool, like
the diff below (note that its "add" can be used as a single operation to
insert and check).

I don't know if it's worth re-rolling for this or not. I doubt anybody
would hit it in practice, but I'd be more concerned about people
auditing for accidentally-quadratic uses of string_list and stumbling
upon it.

-Peff

diff --git a/remote.c b/remote.c
index e256cc9b81..1071a23567 100644
--- a/remote.c
+++ b/remote.c
@@ -2339,7 +2339,7 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 {
 	char *compare_branches = NULL;
 	struct string_list branches = STRING_LIST_INIT_DUP;
-	struct string_list processed_refs = STRING_LIST_INIT_DUP;
+	struct strset processed_refs = STRSET_INIT;
 	int reported = 0;
 	size_t i;
 	const char *upstream_ref;
@@ -2370,11 +2370,10 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 		if (!full_ref)
 			continue;
 
-		if (string_list_has_string(&processed_refs, full_ref)) {
+		if (!strset_add(&processed_refs, full_ref)) {
 			free(full_ref);
 			continue;
 		}
-		string_list_insert(&processed_refs, full_ref);
 
 		short_ref = refs_shorten_unambiguous_ref(
 			get_main_ref_store(the_repository), full_ref, 0);
@@ -2421,7 +2420,7 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 	}
 
 	string_list_clear(&branches, 0);
-	string_list_clear(&processed_refs, 0);
+	strset_clear(&processed_refs);
 	free(compare_branches);
 	return reported;
 }
