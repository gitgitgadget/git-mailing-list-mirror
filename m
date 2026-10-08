Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47BD37E5DF
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 20:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791492947; cv=none; b=YPc7AqHLQOUscfvWjR13hLP/05ixVaQ9FQyO1MODQYjEB+ByTz2Y5PgS7TPnUgNiyNpa/xkuwXYUd7mhrtgOx/baaO8OrJ+WQ/MYc7nImrfzP8dDZ7xdIaA+jGjehVoKro0ot7jVi3QvvQ22fxZ23nxymXiMUKYiedM8bGZFmQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791492947; c=relaxed/simple;
	bh=L2KRDrIqFTO0+YhzrT7C1L2jj8j0drAtOpH/QUsD5t0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=J5JMarl2rIRBU+XvWsrjGVONXSeVHmCIDZeiWPn2pGUAKQCe2tQzYFfacNMaTrC1sECgkb4cl3bGrVHCf70L7giJ6oEKXqsr9eWr5GvySHJDwqW+WqTeh+HT6HRnq2A3EcleWgbJrdCYKjquY1pAETMvI0A5uK3tfLyXUXDOL1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=B0oPYDl9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fn8PE16u; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="B0oPYDl9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fn8PE16u"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 1D96A1D0004F
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 16:55:45 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 08 Oct 2026 16:55:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791492944; x=1791579344; bh=MgblgFaU0f
	23v6HLlfO9G5IxW+ZqhzIy9CX/IP3ePB4=; b=B0oPYDl92a9t7vQbzoaeR679sR
	tD2WD1zJVjHa1k7ADUbCr37bDvS9ZmPD0Aw8m/QFzu2+nH+sS0QQPeY6ruQtLgVU
	q4lpnGlFlENpsbNkzTAtnFhSwYS5kERRz5wdSLswTLVILiv15G0Kpyhta7CFijJU
	U5hPp5UntnPfkYelw8M2+PyMLV5Ex1ygDVn9zZ8ghS+bMZll2ABq4hr7l/svI9Um
	pcCbMjd/+TIzkjU4noj8XFSUpveo+SLu3/JfZjz37AzSCIh8yDGUAXJmYntMNAPa
	fEBvxIttue1c2sWr70Vv5uUVaxL5zcj4KRC3DBww95yRhY1ZGWsZyjoJtsEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791492944; x=1791579344; bh=MgblgFaU0f23v6HLlfO9G5IxW+ZqhzIy9CX
	/IP3ePB4=; b=fn8PE16uIvvuRB6/M18yy8l3DmSWJxsq8zE4LgM/4Gd2/QVqjnI
	8E310RSqSyZJ+8hvZrPzZ2AtnWBCXEaHlJoLCXRTakAQQToUaDFfUm1wI1SJKptg
	lw9bCin6xVJ+X3tyFb5F3vGBsW16Xz8f+Y/I1ncK5b9kWBob3s7O17glTzS2bcDW
	JP+W2pXnCEpw4E1pu3yFec6kmjHu8CmIKaq0p+5b04CiJY6Zfk4x8jyIkofmrPqU
	uWKd0cL60A6XhaBKesw6CzLYdx1f6UIbU79uFMlJTn55nuAVLTxnW1TKA/DW+b8N
	LtvBcIw7AvAggLNW2zE8fF8GvnDIUQhYehg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791492944; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:P6zsztut5D8Yfv3xB/8NgCUqhPWiw9DIWHag4HQQvyWk9Y4
	+VnhBovFqmPnqwKRJG9KsvSExXgME+eVQL/mX3MTIdIujhUlEYUcsOzMpEI+pAeF
	hicaIdZMfMys73TP1QJNmZNdeOMzXFroYo/+WPKMmFouM1O6CuXB1XR4+StNfYom
	QLVdq+CC2gKM9iwNowVx+JSDEqYt8LbI2ljXuew8h+hgcmYLvwHaUwM6fBQwS3ji
	kyZMH5ahCFiKH/gAQS2gnAIilEMmr1uFgxM6S0Ee1MNomLvIj9KQ9INDZg1eFnKs
	7g8cUjg5/8vqmwiNxcj5bJq+2TvZats4Wk+Payg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:dRDoRO63cIRyDpw5uBqtREV9nsJd7q3wAy9EqqKeBe4=:L2KRDrIqFTO0+YhzrT7C1L2jj8j0drAtOpH/QUsD5t0=;
X-ME-Sender: <xms:UAPIanvLOw0dlpscaIuG2Uvdpt5mvEX9OvtFsHKhXU--yMsrfyBnJA>
    <xme:UAPIavUL17X37QSmbM___TJ3wUJgyTUNOHvPTL98p11-7kZRyQoWa58Dy6P5yz3Rr
    b8kAhEnVGZOxV23GFW9BF62QDeylzWU8ca23q1CTp8AAOE1J49zwhs>
X-ME-Received: <xmr:UAPIajHIPMCWFib_dr1ufZXL_1Eo3zQ_zSZk-toPDRYsHF_2oQyNZkOP70TUbnHyLHra0f6F0szj5vI0ywM5crvydbv76l9KvUk5>
X-ME-Proxy-Cause: dmFkZTGct7K+PzrweevIEFW2P+g3aIKOoyQsG1ocf8/OWY3wPVl2CyVhBzzKbozXTwyx5w
    P0d6Q2rx+MNcpEwXl0/47q58C5yuMvSvnvh2hMQuJiYBcMvqrWmjtK8qjy5oUuphxenR1Q
    fHhbv8ICZC4Xi/RATUSSFHNmUaAYGzkekYY7AptDBsQCnpEjYNgiP8Yr4nBLHBq2q0yvBY
    JsgwcXOxxVykLDfAMpTG8oV6cIzhtLaxHLyID2z9+uzsroScJ1RGCfM7cc4tq02tHI2Ecm
    99KPi7hN7h9X3tmeGTvAwbBInbuPA99bNbm9PtfysHAfpE9tZpLVqe1Oa40Z7FEOoKqZjX
    Ef+a7Z/vqe/etFpuBJ+E+PJIELTZ7zO82tAyR9y8GL4AerdHxchob1KMFuL4l1CTujn9i+
    tlZZCi6XrYXKFwnwXOhO62Zfb9SiCrY/92btiQSnvTwicE8AgmZLS0MIwUWWc5kuugFqX/
    qAYEeuveOIWNE85Wml/4Fc779s/nu8nmPreQT76/4ZMORhP3gSzrOVZxX0vTtvs3NQusua
    TAlG2vFDykqsQePo3APqm2kBQA/m5yXx0o8zgwsiXxx5/INidfW45DfwNftIPvT++nZIpv
    su9B2eHbsnKPgZLQWEcDfwCtvcEAzRhZlU08NB/2gkTpgFviqfWUQkPll1kA
X-ME-Proxy: <xmx:UAPIah1tigbea05U4otIh--f6BmVO8XLR9SjvW3xgO7uNASpHtQ3_A>
    <xmx:UAPIalNAyhi2DCSn6x1bZU5hm76m1SVa47aPFrkseHOR4OXGrBOliw>
    <xmx:UAPIag5PaI6AZ-VAzKYZ9zKeAVXxzx8PQR3bt1puq6ZmDGnW1slprg>
    <xmx:UAPIav2EkbR8_sx88-Yo7EhDkl1EtyC6istyXddNsV2ULKK1YGOJ1Q>
    <xmx:UAPIamYr6WuHaxtHLfAUszqYVcGw1_YUkqnxo7gCcQyDVEVYeLyHUFQy>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Oct 2026 16:55:44 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Eric Sunshine <sunshine@sunshineco.com>,  Yoichi
 NAKAYAMA <yoichi.nakayama@gmail.com>
Subject: Re: [PATCH 1/2] worktree repair: refactor and reduce .git file reads
In-Reply-To: <dc7ebb427bedc7318ebbf84c05ecd02063408353.1789269613.git.gitgitgadget@gmail.com>
	(Yoichi NAKAYAMA via GitGitGadget's message of "Sun, 13 Sep 2026
	03:20:12 +0000")
References: <pull.2225.git.1789269613.gitgitgadget@gmail.com>
	<dc7ebb427bedc7318ebbf84c05ecd02063408353.1789269613.git.gitgitgadget@gmail.com>
Date: Thu, 08 Oct 2026 13:55:42 -0700
Message-ID: <xmqqh5ivyks1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +static const char *get_worktree_id(const char *dotgit_contents)
> +{
> +	const char *slash = find_last_dir_sep(dotgit_contents);
> +	if (!slash)
> +		return "";
> +	return slash + 1;
> +}

This returns a pointer into dotgit_contents; it is the last
component of a pathname, similar to what basename(3) gives us.

> @@ -798,30 +806,20 @@ static int is_main_worktree_path(struct repository *repo, const char *path)

The unified diff is a bit hard to follow, so let's see if we can
compare preimage and postimage more easily.

>  static ssize_t infer_backlink(struct repository *repo,
> -			      const char *gitfile,
>  			      struct strbuf *inferred)
>  {
> -	struct strbuf actual = STRBUF_INIT;
>  	const char *id;
>  
> -	if (strbuf_read_file(&actual, gitfile, 0) < 0)
> -		goto error;
> -	if (!starts_with(actual.buf, "gitdir:"))
> -		goto error;
> -	if (!(id = find_last_dir_sep(actual.buf)))
> -		goto error;
> -	strbuf_trim(&actual);
> -	id++; /* advance past '/' to point at <id> */
>  	if (!*id)
>  		goto error;
>  	repo_common_path_replace(repo, inferred, "worktrees/%s", id);
>  	if (!is_directory(inferred->buf))
>  		goto error;
>  
> -	strbuf_release(&actual);
>  	return inferred->len;
>  error:
> -	strbuf_release(&actual);
>  	strbuf_reset(inferred); /* clear invalid path */
>  	return -1;

We used to receive the filename of ".git", read it and made sure we
have "gitdir:" prefix, and find the last component, but then trimmed
the actual buffer.  Which means a few things.

 - If the contents of the gitfile were "gitdir:foo/bar/baz \n", our
   id pointer found the slash after "foo/bar", trimmed the buffer to
   have "gitdir:foo/bar/baz", and then incremented id, which now
   points at "baz".

 - If the contents of the gitfile were "gitdir: foo/bar/   \n", then
   after triming, the buffer would have "gitdir: foo/bar/" and id
   would be pointing at the NUL at the end, which would have lead us
   to error.

Now let's look at the new code.

> @@ -798,30 +806,20 @@ static int is_main_worktree_path(struct repository *repo, const char *path)
>   * Returns -1 on failure and strbuf.len on success.
>   */
>  static ssize_t infer_backlink(struct repository *repo,
> +			      const char *dotgit_contents,
>  			      struct strbuf *inferred)
>  {
>  	const char *id;
>  
> +	id = get_worktree_id(dotgit_contents);
>  	if (!*id)
>  		goto error;
>  	repo_common_path_replace(repo, inferred, "worktrees/%s", id);
>  	if (!is_directory(inferred->buf))
>  		goto error;
>  
>  	return inferred->len;
>  error:
>  	strbuf_reset(inferred); /* clear invalid path */
>  	return -1;

The caller is expected to give us the contents of gitfile read by
setup.c:read_gitfile_raw(), which reads the file in full, validates
that the file begins with "gitdir: " (notice the trailing space),
removes arbitrary run of CR or LF from the end, and then returns
the string after skipping "gitdir: " prefix (8 bytes).

In the normal case, read_gitfile_raw() would see "gitdir: foo/bar/baz\n" 
in the file and returns "foo/bar/baz" to our caller.  In fishy cases
we examined for the preimage above:

 - If the contents of the gitfile were "gitdir:foo/bar/baz \n", our
   caller would have received an error from read_gitfile_raw() and
   wouldn't have called us.

 - If the contents of the gitfile were "gitdir: foo/bar/   \n", our
   caller would have given us "foo/bar/   ".

get_worktree_id() will give us "baz" in the normal case, and "   "
in the last case.  We fail to error out in the latter with "*id"
check, but is_directory() check will catch us, as the inferred
directory is "worktrees/   " in that bad case.

So there are certain differences in error cases, but they behave the
same in the most basic cases.


Now, this is the caller in the preimage (i.e., what we used to do).

> @@ -856,51 +855,49 @@ void repair_worktree_at_path(struct repository *repo,
>  		goto done;
>  	}
>  
> -	infer_backlink(repo, dotgit.buf, &inferred_backlink);
> -	strbuf_realpath_forgiving(&inferred_backlink, inferred_backlink.buf, 0);
> -	dotgit_contents = xstrdup_or_null(read_gitfile_gently(dotgit.buf, &err));

We used to have infer_backlink() read the .git file to compute "worktree/$id",
then again called read_gitfile_gently() to read it again.

> -	if (dotgit_contents) {
> -		strbuf_addstr(&backlink, dotgit_contents);

This is the happy path.  We successfully read from .git and use it.

> -	} else if (err == READ_GITFILE_ERR_NOT_A_FILE ||
> -			err == READ_GITFILE_ERR_IS_A_DIR) {
>  		fn(1, dotgit.buf, _("unable to locate repository; .git is not a file"), cb_data);
>  		goto done;

This is inherited badness, but overly long lines like this one needs
to be fixed.

> -	} else if (err == READ_GITFILE_ERR_NOT_A_REPO) {

The _gently() did read something, but that does not point at a git
directory.

> -		if (inferred_backlink.len) {
> -			/*
> -			 * Worktree's .git file does not point at a repository
> -			 * but we found a .git/worktrees/<id> in this
> -			 * repository with the same <id> as recorded in the
> -			 * worktree's .git file so make the worktree point at
> -			 * the discovered .git/worktrees/<id>.
> -			 */
> -			strbuf_swap(&backlink, &inferred_backlink);

If we had the "worktree/$id" thing, we use it.

> -		} else {
> -			fn(1, dotgit.buf, _("unable to locate repository; .git file does not reference a repository"), cb_data);
> -			goto done;
> -		}
> -	} else {
>  		fn(1, dotgit.buf, _("unable to locate repository; .git file broken"), cb_data);
>  		goto done;
>  	}

These lines to show error messages should also be folded to avoid
overly long lines.

So, what does the updated code in the postimage do?

> @@ -856,51 +855,49 @@ void repair_worktree_at_path(struct repository *repo,
>  		goto done;
>  	}
>  
> +	err = read_gitfile_raw(&contents, dotgit.buf);

We use read_gitfile_raw() just once.

> +	if (err == READ_GITFILE_ERR_NOT_A_FILE ||
> +	    err == READ_GITFILE_ERR_IS_A_DIR) {
>  		fn(1, dotgit.buf, _("unable to locate repository; .git is not a file"), cb_data);
>  		goto done;
> +	} else if (err) {
>  		fn(1, dotgit.buf, _("unable to locate repository; .git file broken"), cb_data);
>  		goto done;
>  	}

The original code handled the happy case that read_gitfile_gently()
successfully returned first.  Underlying read_gitfile_raw() would
not have given any of these errors when read_gitfile_gently()
succeeded, so handling the error cases first would not affect the
behaviour of the code in these cases.  Again, these overlong lines
are annoying.

Now the simplest error cases are behind us.  How would we do in the
happy case?

> +	dotgit_contents = contents.buf;
> +	infer_backlink(repo, dotgit_contents, &inferred_backlink);
> +	strbuf_realpath_forgiving(&inferred_backlink, inferred_backlink.buf, 0);

We reuse what we already read with read_gitfile_raw(), which
prepared "worktrees/$id", and do the same realpath_forgiving()
the original used to do a bit earlier.

> +	if (is_absolute_path(dotgit_contents)) {
> +		strbuf_addstr(&backlink, dotgit_contents);

I am not sure which part of the original this logic corresponds to.
If the result from read_gitfile_raw() is an absolute path, even if
it later turns out not to be is_git_directory(), the inferred backlink
is not given a chance to act as a fallback.  The original made a
call to read_gitfile_gently() which checked is_git_directory() to
give us an error, and that is how it allowed inferred backlink to
substitute for a bad contents stored in .git file.  Now we do not
allow that fallback if .git file has an absolute path?

Ah, outside the context of this patch, before we barf for "unable to
locate repository" when we complain backlink.buf is not naming a git
directory, there is the fallback logic, and in order to reach there,
we have "if (!is_git_directory(backlink.buf) && !inferred_backlink.len)"
there.  OK, so this may be doing the same thing as the original, but
it is rather hard to follow and convince readers that this is a
no-op conversion.

> +	} else {
> +		strbuf_addbuf(&backlink, &dotgit);
> +		strbuf_strip_suffix(&backlink, ".git");
> +		strbuf_addstr(&backlink, dotgit_contents);
> +		strbuf_realpath_forgiving(&backlink, backlink.buf, 0);

This converts dotgit_contents relative to the computed backlink,
which needs to be done here because read_gitfile_gently() used to do
that for us, which we no longer use.

> +	}
> +
> +	if (!is_git_directory(backlink.buf) && !inferred_backlink.len) {
> +		fn(1, dotgit.buf, _("unable to locate repository; .git file does not reference a repository"), cb_data);
> +		goto done;
> +	}

I'll stop here.
