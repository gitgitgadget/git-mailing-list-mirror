Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C4C3A5C17
	for <git@vger.kernel.org>; Thu, 22 Jan 2026 22:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769121879; cv=none; b=FxLGNuKzeP3+fmGsYGnd80K0EWnyRs1Gy1w+5UTpv3FUEoT0EEi6kT1un90FJgrl+rGb5HfCicAg+cWdSSsyfpC2HelLtEHOxgDcV8vVEFO2OaBeCkJcHQDiHRhbcxNpyYzjC1w0EoJztaLdDmuRzxK7JLI0XGPLld2Bv9NcD7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769121879; c=relaxed/simple;
	bh=/kwPh+ozdHmZn5X8Hh/Nu9OntxE5ZswLFYuyl2At6eU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RaDOTE7xiAkPJZSqelE4/HG/4+8LYMUPpuEnSo9YP1jaPLbPJwLSCZVvc1R/Wm6XXVuT6Pjw2rO7akGXMU8u7CMTslg5FicYpGsGtUP3qlN5aVPw9dJRFmOENp/35nilJeSvRTM0lPHlRZ1Ifglv1WpemOQ0N4mXUUxl8XOMxbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=hADafojh; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="hADafojh"
Received: (qmail 131271 invoked by uid 109); 22 Jan 2026 22:44:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=/kwPh+ozdHmZn5X8Hh/Nu9OntxE5ZswLFYuyl2At6eU=; b=hADafojhYLcwCmkTBT58tCXMNLCCT+aJW0XodKW21fNPg/3hnYmzprlMH//6uXV1fHGSE398FpGX0/mFRfAOX6z0dJdrC06Goj82SIVX4dygaaMwSKzPMjSTBlQVsHTlVNFa78451o8jQh2FK2h/z0gzk6JX/0jJ2lbcwUPHPwpR8ogwr1KU3ceXP8aA7AqWivU9yDbHpwon8lWmoEq26xvZU48PgsaKm+rjJEClsDZfRDUtvc9mfZ2lzys6nh3dvGvIZ0HhFmvt95f/stAec97q3X1hmfUSZBxf1ll2PIaS1AfisoUC+FGV1D2PSHdW/sXzdtXKueMiE7yamUNzjQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 22 Jan 2026 22:44:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 240209 invoked by uid 111); 22 Jan 2026 22:44:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 22 Jan 2026 17:44:30 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 22 Jan 2026 17:44:27 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v27 2/2] status: add status.compareBranches config for
 multiple branch comparisons
Message-ID: <20260122224427.GB2107958@coredump.intra.peff.net>
References: <pull.2138.v26.git.git.1768766353.gitgitgadget@gmail.com>
 <pull.2138.v27.git.git.1769096240.gitgitgadget@gmail.com>
 <0993420fc1185ec4a907a8c3bb52ca965e720c54.1769096240.git.gitgitgadget@gmail.com>
 <xmqq5x8tmlj7.fsf@gitster.g>
 <20260122220154.GA2107958@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260122220154.GA2107958@coredump.intra.peff.net>

On Thu, Jan 22, 2026 at 05:01:54PM -0500, Jeff King wrote:

> The second is a bit more complicated, but is even more flexible. Part of
> the point of this status.compareBranches approach is that you can add
> regular refnames to the list. But would a user want to use a name that
> is derived from the comparison branch, rather than just a static name?
> That is, to compare branch "foo" against "origin/foo"? Usually that is
> exactly the kind of refspec-application that @{upstream} and @{push} are
> computing (after taking into account various config). But if you have a
> third source of refs, would you want to be able to compare to
> "origin/%s", where %s is the shortened branch name?
> 
> In which case these values could become "%s@{upstream}" and "%s@{push}",
> and they could just be fed straight to the branch-interpret machinery.

So here's a sketch to show what that might look like:

diff --git a/remote.c b/remote.c
index 1071a23567..6f9a28970c 100644
--- a/remote.c
+++ b/remote.c
@@ -2239,34 +2239,30 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
 static char *resolve_compare_branch(struct branch *branch, const char *name)
 {
 	struct strbuf buf = STRBUF_INIT;
-	const char *resolved = NULL;
+	struct object_id oid;
 	char *ret;
 
 	if (!branch || !name)
 		return NULL;
 
-	if (!strcasecmp(name, "@{upstream}") || !strcasecmp(name, "@{u}"))
-		resolved = branch_get_upstream(branch, NULL);
-	else if (!strcasecmp(name, "@{push}"))
-		resolved = branch_get_push(branch, NULL);
-
-	if (resolved)
-		return xstrdup(resolved);
-
-	strbuf_addf(&buf, "refs/remotes/%s", name);
-	resolved = refs_resolve_ref_unsafe(
-		get_main_ref_store(the_repository),
-		buf.buf,
-		RESOLVE_REF_READING,
-		NULL, NULL);
-	if (resolved) {
-		ret = xstrdup(resolved);
-		strbuf_release(&buf);
-		return ret;
+	while (strbuf_expand_step(&buf, &name)) {
+		if (skip_prefix(name, "%", &name))
+			strbuf_addch(&buf, '%');
+		else if (skip_prefix(name, "s", &name))
+			strbuf_addstr(&buf, branch->name);
+		else
+			die("bad compareBranches format: %%%s", name);
 	}
 
+	/*
+	 * This will leave "ret" as NULL if we don't find anything. If there
+	 * are multiple ambiguous matches it will pick the first. Should we
+	 * return an error instead?
+	 */
+	repo_dwim_ref(the_repository, buf.buf, buf.len, &oid, &ret, 1);
+
 	strbuf_release(&buf);
-	return NULL;
+	return ret;
 }
 
 static void format_branch_comparison(struct strbuf *sb,
@@ -2352,7 +2348,7 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 		string_list_split(&branches, compare_branches, " ", -1);
 		string_list_remove_empty_items(&branches, 0);
 	} else {
-		string_list_append(&branches, "@{upstream}");
+		string_list_append(&branches, "%s@{upstream}");
 	}
 
 	upstream_ref = branch_get_upstream(branch, NULL);


I ran into two small complications. The first is that there's an
interesting race "git-checkout -b":

  1. We read branch and remote config via remote.c:read_config(),
     caching it.

  2. Then we write some new config for the branch we just created.

  3. Then we try to report tracking info. This will read the cached
     config from step 1, without regard to the changes in 2.

It works without my patch above because the tracking code currently
operates directly on a "struct branch" (that we just updated), rather
than using the stale config from (1).

We can fix that like this:

diff --git a/branch.c b/branch.c
index 243db7d0fc..cc24e8522d 100644
--- a/branch.c
+++ b/branch.c
@@ -178,6 +178,12 @@ static int install_branch_config_multiple_remotes(int flag, const char *local,
 		string_list_clear(&friendly_ref_names, 0);
 	}
 
+	/*
+	 * We installed new config; flush any internal cache of the on-disk
+	 * config.
+	 */
+	remote_state_clear(the_repository->remote_state);
+
 	return 0;
 
 out_err:
diff --git a/remote.c b/remote.c
index 6f9a28970c..e6056199f0 100644
--- a/remote.c
+++ b/remote.c
@@ -2859,6 +2859,14 @@ void remote_state_clear(struct remote_state *remote_state)
 		free(b);
 	}
 	hashmap_clear(&remote_state->branches_hash);
+
+	/*
+	 * Eek, we just cleared everything out; we should mark ourselves as
+	 * uninitialized so we can be used again. Nobody seems to have noticed
+	 * because we only remote_state_clear() when we are about to discard
+	 * the struct entirely.
+	 */
+	remote_state->initialized = 0;
 }
 
 /*


The second issue concerns the case when an upstream is configured, but
the tracking ref for it is missing. So imagine "foo" is configured with
"refs/remotes/origin/foo" as its upstream, but that branch is gone.

Using branch_get_upstream() will return the name, even if it doesn't
exist. And then the tracking-info code recognizes this and reports it.
But repo_dwim_ref() won't return a missing ref at all, even with
nonfatal_dangling_mark. So I think we'd need to teach it a new option to
do so.


I don't know what all of it means. The "%s" thing was short to
implement, but the real source of the extra complications is using
repo_dwim_ref() to do the resolution. But I think the overall direction
is more consistent with how the rest of Git behaves.

-Peff
