Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338AE3A1A5D
	for <git@vger.kernel.org>; Thu, 22 Jan 2026 22:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769119327; cv=none; b=ZmkAFjL5UQ42iH9m5RbLrv9gCKEq3Cya9jE22Cx/jjq46duA/z4usD2v3AQjL+R1hU2vhf1s0fGErSBgk3X3WAHRZAsWNiVzhocdzJ0j8Kf+QgXgEh8ndy92XYJMaYs82o67uK9DEJGDMWDbG4MjRnyRdtSX4qglheiuGiUdXK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769119327; c=relaxed/simple;
	bh=63RWm9QMVYDMaqerG/30/tWSVvRU38fD2iyrxvULRtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AlsfpJwIe7z7amJrl0Sihq+0rLTpz/dmvPXCmDlUVJELDp6lffCs/vDedoq7EVHci/6lW5CY0LVYF9QB+ulMLdHP29PYZAmyp7Tur0w4HjpcZBQsN/GfAlNcZK/xKjUtNd7jL68qLn6ixrGg9ZKfIsZ4dnBhQihbH2XYz0Kc95c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=WjUxwJDn; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="WjUxwJDn"
Received: (qmail 131105 invoked by uid 109); 22 Jan 2026 22:01:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=63RWm9QMVYDMaqerG/30/tWSVvRU38fD2iyrxvULRtY=; b=WjUxwJDnnoDWmOt4jqWEP5azan8r3+0SFzxRsVm5GceUY5y+pqN9i7ejx6dy640D4nccSfAT1ZvpVwZJeWEZnCApJzqLKKTnx816nXstDydzBgINR6P9CIPNCqw8Cm6iGVQCDZSOKLGXVCbyaETB0hUuc4/sDosa+etgsV/keEM76uajEUnEmqX2IvFrb8JP638YmzEq2gEDRiS+CbdewVHf77HgroknXrZVkd7691R4QBd1Oq0Tjvg8DIij+BEu4v+xLz42dv0rWBRcaSNf8Yp5fn2FntMLR44Zt4M2akB3TpPYqafwoS0AY1uUpPQhWdLiakLGmAJOHsAEy0OQ/Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 22 Jan 2026 22:01:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 239712 invoked by uid 111); 22 Jan 2026 22:01:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 22 Jan 2026 17:01:57 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 22 Jan 2026 17:01:54 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v27 2/2] status: add status.compareBranches config for
 multiple branch comparisons
Message-ID: <20260122220154.GA2107958@coredump.intra.peff.net>
References: <pull.2138.v26.git.git.1768766353.gitgitgadget@gmail.com>
 <pull.2138.v27.git.git.1769096240.gitgitgadget@gmail.com>
 <0993420fc1185ec4a907a8c3bb52ca965e720c54.1769096240.git.gitgitgadget@gmail.com>
 <xmqq5x8tmlj7.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq5x8tmlj7.fsf@gitster.g>

On Thu, Jan 22, 2026 at 12:37:16PM -0800, Junio C Hamano wrote:

> > +static char *resolve_compare_branch(struct branch *branch, const char *name)
> > +{
> > +	struct strbuf buf = STRBUF_INIT;
> > +	const char *resolved = NULL;
> > +	char *ret;
> > +
> > +	if (!branch || !name)
> > +		return NULL;
> > +
> > +	if (!strcasecmp(name, "@{upstream}") || !strcasecmp(name, "@{u}"))
> > +		resolved = branch_get_upstream(branch, NULL);
> > +	else if (!strcasecmp(name, "@{push}"))
> > +		resolved = branch_get_push(branch, NULL);
> 
> OK.  Usually @{upstream} without anything before the at-sign means
> the upstream of the current branch, but we need to force pretend
> that branch were the current branch, so we'd need to special case
> like this, which looks reasonable.

Yeah, it is unfortunate to have to special-case these names, even though
the resolving functions already know about them. If we are looking at
branch "foo" we could rewrite them as "foo@{upstream}", etc, but that
also requires special-casing (though maybe slightly less, if we just
accept the @ sign?).

I can think of two alternatives, though.

One is that repo_interpret_branch_name() could accept a field in its
options struct to set the default branch (rather than "HEAD"). Something
like this (totally untested):

diff --git a/object-name.c b/object-name.c
index 8b862c124e..925a487d84 100644
--- a/object-name.c
+++ b/object-name.c
@@ -1732,7 +1732,7 @@ static int interpret_branch_mark(struct repository *r,
 		branch = branch_get(name_str);
 		free(name_str);
 	} else
-		branch = branch_get(NULL);
+		branch = branch_get(options->default_branch);
 
 	value = get_data(branch, &err);
 	if (!value) {
diff --git a/object-name.h b/object-name.h
index cda4934cd5..962f99b0f6 100644
--- a/object-name.h
+++ b/object-name.h
@@ -119,6 +119,12 @@ struct interpret_branch_name_options {
 	 * of die()-ing.
 	 */
 	unsigned nonfatal_dangling_mark : 1;
+
+	/*
+	 * Pass this to branch_get() when interpreting @-marks without a
+	 * branch, rather than using HEAD.
+	 */
+	const char *default_branch;
 };
 int repo_interpret_branch_name(struct repository *r,
 			       const char *str, int len,

Most callers would continue to pass NULL in the usual way, but the
resolution here would pass in the current branch name.


The second is a bit more complicated, but is even more flexible. Part of
the point of this status.compareBranches approach is that you can add
regular refnames to the list. But would a user want to use a name that
is derived from the comparison branch, rather than just a static name?
That is, to compare branch "foo" against "origin/foo"? Usually that is
exactly the kind of refspec-application that @{upstream} and @{push} are
computing (after taking into account various config). But if you have a
third source of refs, would you want to be able to compare to
"origin/%s", where %s is the shortened branch name?

In which case these values could become "%s@{upstream}" and "%s@{push}",
and they could just be fed straight to the branch-interpret machinery.

> > +	strbuf_addf(&buf, "refs/remotes/%s", name);
> > +	resolved = refs_resolve_ref_unsafe(
> > +		get_main_ref_store(the_repository),
> > +		buf.buf,
> > +		RESOLVE_REF_READING,
> > +		NULL, NULL);
> > +	if (resolved) {
> > +		ret = xstrdup(resolved);
> > +		strbuf_release(&buf);
> > +		return ret;
> > +	}
> 
> It would be handy to be able to say "origin/master" (or even just
> "origin", which is interpreted as "origin/HEAD" via the DWIM
> machinery) and prepending of "refs/remotes/" above does help such
> DWIMmery, but I wonder if it is too limiting?  Would there be
> situations where you would want to compare with something outside
> refs/remotes/ hierarchy?
> 
> For example, writing "v2.52.0" there to see how far we came since
> the last release would become impossible if we always force prepend
> "refs/remotes/".  I wonder if we can reuse already existing DWIMmery
> that uses refs.c::ref_rev_parse_rules[], which should allow such use
> case, while still allowing you to write "origin/master"?

Yeah, I think tags or even local branches would be plausible candidates.
But at any rate, I'd expect these to be resolved in the "usual" way that
we do elsewhere. If we switch to using repo_dwim_ref() or something that
interprets @-marks, then that matches nicely with the suggestions I gave
above.

-Peff
