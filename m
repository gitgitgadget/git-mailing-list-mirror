Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A3A23BD1B
	for <git@vger.kernel.org>; Sat,  1 Aug 2026 19:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785614075; cv=none; b=Vyf69rjK216ITzPsguGrsWfSEejHK4xoJgjgwKTJgSaHYDFIwtSbboHGZo9Y7OWKSW6OW7aiAms36k78A+uev8DFwoigo7u593lnbegZQExcAwiOUqsUK5NALAauDkFXr5lBnMTucm1UImone6h16ehCxeADMxsBKgUs3ef3RXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785614075; c=relaxed/simple;
	bh=HnfNOmaDS8gYyMIM6BFgnnIuypltyXvZWImlBUM9Hic=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rNXqNWTtFRLCy47PokAWlJqf0859hIgGj1j1szRvjUhnHtmBSmQUORM0uyWBeoCvRW7uZ1x+jIYCutAbMylpJRBNyZwglwZAVTamlurpuKxPT8KSL+B5XT8s8o4VveukQ5mJ6I9hF4Xgop4jI+9AY3rXqUoETughpYFsuT8lZlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kfogu11I; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XJuqaA2B; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kfogu11I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XJuqaA2B"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id ED5C9140019D;
	Sat,  1 Aug 2026 15:54:32 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Sat, 01 Aug 2026 15:54:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1785614072; x=1785700472; bh=kPosGQ24xI
	2M9nTXHkAFRMnjBHELaOFAMuYatbhuZI4=; b=kfogu11IfTVv6+eFUzAKFkgK2L
	742TiiBoB3fw9lYDRy8iIv4d6NNWtdRr8wVVuVgq5E+TrFC48XxasDRRXc2Im9SV
	7T7JY7Au5LM8/r0iUWaZw3P/XiSCSCVJeyuHDObgZy/UPQD47yrEVXF3odVQyHtw
	alztsxramLJxNdJLTlV9M/KJ+AB2n0fvZIGKs4nZb17pbmakEYQZITWmIxBadjob
	2qPwi5Epx73GzHwOF4XBzp0kKoZIydfj74xK/SqrJwzF7SLgAfsYlTnOwMmXGdOM
	OaTLrRmQJJ+Is0yz9etqWMRm4KQ28Jx3zEfEh0uLFp98RJbsc0t3n/0pEP6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785614072; x=1785700472; bh=kPosGQ24xI2M9nTXHkAFRMnjBHELaOFAMuY
	atbhuZI4=; b=XJuqaA2BBWcalu9+Cw3hstliimBzLlP/RT+cnL4cIDWywHUPLIQ
	GBfhMTAOVC7eTkPM7HhCXUCB/M8+pAE36Traaq1T617oi/qEnlG3Anu2jZ9b3uSJ
	vH4AzMaDJOPXSB71zJOyeJuoaX6LfA5NRLeYvirGVE2lgdnvekmAmU0HU7KYA9Qd
	jcbMtJ+FFahIrhzN/I2bV8Af6/GQxHxNfqarhAiUN3WZ+cvDmUgZZDSH1dFzU7DT
	MHrk1q8WC+ripmW/4Pj/9Wx+MlxvNFkJwyextht0ec+7cuHwM//yqr+rDdveLVSi
	/+4KC6gOuoJB4SDZsT1uMywVwHIvlrRiuhw==
X-ME-Sender: <xms:-E5uasbqTRo7WvLpKEcVqNWsL-GejI8LK02z2vXXw6ag8qT2cjMVrQ>
    <xme:-E5uauTAz3Gu9uipIifw1HIfajm3dBT5TCSChlHGUPXLUJH3xLGpMy9Uzl7FS3lBc
    j2qavnjWGBT5jcvsBs2YjjBzZ9fPE3DDOuzS5nqi2m31lgnBzW_dQ>
X-ME-Received: <xmr:-E5uavSLBEpmMXmsNd2dZqWMdK27uNs1x-_udnzqgCPvc_eSlcfRyCa2CeGY3BAq89y5Rouo7NG6p5SvdE7t2yryr2KJstaErQ>
X-ME-Proxy-Cause: dmFkZTEPhuMlm9s+CM049SkxkXe1CznDb5yTHqKScbGXJbXJeor+j3g3OHU4ew5vkXnwIY
    2xzsSNXxkzdWbjO/43rQ9Gy8pJozTVwh+adnPiavOfar/Avfdd5NsknxKsXWElaex+WOSc
    DBsymjf0TehkqmDj2dXviqozbzjKaBOna1/FyIjRQySpnI7u2/2b/z/fdJKqREttwTPjHj
    lHITn5ivZiD29OMfGhDLy+QK/DWu5iACROQj0QeuMzsSRuhpK933j3NqKI05zfLS0rq6OG
    jl4/KvepJx0TIu+18Cb3vn2ntUZg5C0QfDM6/shjIBcAU2+AaU5Bo0nzR5A4huAj7rv5bv
    SGqMKpcd4zPXc5INF9+Al67p6fo7iIDO8PDaeirNB4V5JmLNd80+nYTPcLCnnhFS5UZwKS
    UoqdyREq5lyQI5TRG+lbLntrzR/NS0ECZ8cZI97ZYCa4kLyiUFLzpDDfyS+zwrI/+07778
    7EXepyUko4yCnyP0is2rBSEmqZTgwvPD/oU5PyktVn2pT0kwvWHd6pmQ2njafoPMmy8oWt
    kd8oDyEJsEMFv0Y2CBmDeBjU15NmS5uOTO1Q3bGPyMDE6COLiKyQBAPP5Y85QL9WBtQVTM
    g3U3yjABy9YDtuoCR5qRa/rYmb3zKMhQOxUH4r+S2xmy7M1IC61oABPYpzhQ
X-ME-Proxy: <xmx:-E5uaiT5Pbwu1vyY0cBWTtDgDgLUb8oAeE9ebSoDL5IeV_kgsJ7vgQ>
    <xmx:-E5uak4pf-5oYNjcas9gvUIPvx0F8_T9MtENATqy-PoJPaBxFgd3aA>
    <xmx:-E5uau0DJYdWHgZgHzRKSR_Rzwh53gC1_T2gqvvyi5abBVGz2SIcNg>
    <xmx:-E5uavDh_kYQ6hQKNZyPPF8TUM4X9V8BYFiNuhFYPfE9NA6LPje--g>
    <xmx:-E5uapgkX_KE4R3EVtq9_YFaRBjmDrnpxR9b6bVWSTQOJhqJsprijVI1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 1 Aug 2026 15:54:32 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Sixt <j6t@kdbg.org>,  Harald Nordgren
 <haraldnordgren@gmail.com>
Subject: Re: [PATCH v4 2/2] bisect: add --reset-when-found to leave when done
In-Reply-To: <f5f370df1bab91872e32398386935d71d48a831b.1785577445.git.gitgitgadget@gmail.com>
	(Harald Nordgren via GitGitGadget's message of "Sat, 01 Aug 2026
	09:44:05 +0000")
References: <pull.2335.v3.git.git.1784538619.gitgitgadget@gmail.com>
	<pull.2335.v4.git.git.1785577445.gitgitgadget@gmail.com>
	<f5f370df1bab91872e32398386935d71d48a831b.1785577445.git.gitgitgadget@gmail.com>
Date: Sat, 01 Aug 2026 12:54:31 -0700
Message-ID: <xmqqwlu97h1k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> @@ -1211,6 +1212,7 @@ int bisect_clean_state(void)
>  	unlink_or_warn(git_path_bisect_run());
>  	unlink_or_warn(git_path_bisect_terms());
>  	unlink_or_warn(git_path_bisect_first_parent());
> +	unlink_or_warn(git_path_bisect_reset_when_found());
>  	/*
>  	 * Cleanup BISECT_START last to support the --no-checkout option
>  	 * introduced in the commit 4796e823a.

OK.  If we

> +static int bisect_reset_when_found(struct bisect_terms *terms)
> +{
> +	struct strbuf value = STRBUF_INIT;
> +	enum reset_when_found_mode mode;
> +	char *commit = NULL;
> +	int res;
> +
> +	if (strbuf_read_file(&value, git_path_bisect_reset_when_found(), 0) < 0) {
> +		res = error_errno(_("could not read '%s'"),
> +				  git_path_bisect_reset_when_found());
> +		goto cleanup;
> +	}

We expect that the caller calls this function only when we are doing
"--reset-when-found"; otherwise we would give an error message from
here even though we do not cause any damage otherwise.

We also expect that the callers refrain from calling this function
when bisect_next() that they eventually reach would not want to
immediately reset.

The defer_reset arrangement looks somewhat ugly even though what it
achieves may be a worthy thing to do.  Is the only code path that
passes defer_reset==true down the call chain the bisect_run()
codepath, to give that single caller a chance to close files that
bisect_reset() would remove by calling bisect_clean_state()?

I am wondering if the result of solving it slightly differently may
give us cleaner and easier to follow code, namely, we stop calling
bisect_clean_state() from bisect_reset().  Of course you would need
to find different place to call bisect_clean_state() to compensate,
if we go that route, but how many code paths do we have that depends
on bisect_reset() calling biesct_clean_state()?

Among existing callers of bisect_reset():

 - Does replay have to call reset?  Just like start does, isn't it
   sufficient to call clean_state?

 - cmd_bisect__reset() calls reset and returns, but it can call
   clean fater reset returns, if we need to make reset not to call
   clean.

> +	strbuf_trim(&value);
> +	if (parse_reset_when_found(value.buf, &mode)) {
> +		res = -1;
> +		goto cleanup;
> +	}
> +
> +	if (mode == RESET_WHEN_FOUND_TO_FOUND)
> +		commit = xstrfmt("refs/bisect/%s", terms->term_bad);
> +	res = bisect_reset(commit, 1);
> +
> +cleanup:
> +	free(commit);
> +	strbuf_release(&value);
> +	return res;
> +}

OK, "commit" is NULL unless mode specifies TO_FOUND in which case we
jump to the bad commit we found.  bisect_reset() knows that commit==NULL
means we go back to where we started.  OK.

> @@ -697,6 +760,9 @@ static enum bisect_error bisect_next(struct bisect_terms *terms, const char *pre
>  
>  	if (res == BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND) {
>  		res = bisect_successful(terms);
> +		if (!res && !defer_reset &&
> +		    !is_empty_or_missing_file(git_path_bisect_reset_when_found()))
> +			res = bisect_reset_when_found(terms);
>  		return res ? res : BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND;
>  	} else if (res == BISECT_ONLY_SKIPPED_LEFT) {
>  		res = bisect_skipped_commits(terms);

This is the first ugliness I mentioned earlier.

> @@ -1311,7 +1415,7 @@ static int bisect_run(struct bisect_terms *terms, int argc, const char **argv)
>  		saved_stdout = dup(1);
>  		dup2(temporary_stdout_fd, 1);
>  
> -		res = bisect_state(terms, 1, &new_state);
> +		res = bisect_state(terms, 1, &new_state, true);
>  
>  		fflush(stdout);
>  		dup2(saved_stdout, 1);
> @@ -1327,7 +1431,11 @@ static int bisect_run(struct bisect_terms *terms, int argc, const char **argv)
>  			res = BISECT_OK;
>  		} else if (res == BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND) {
>  			printf(_("bisect found first '%s' commit\n"), terms->term_bad);
> -			res = BISECT_OK;
> +			if (!is_empty_or_missing_file(git_path_bisect_reset_when_found()) &&
> +			    bisect_reset_when_found(terms))
> +				res = BISECT_FAILED;
> +			else
> +				res = BISECT_OK;
>  		} else if (res) {
>  			error(_("bisect run failed: 'git bisect %s'"
>  				" exited with error code %d"), new_state, res);

And these are the second one, that made the first one needed.

Another thing that I find a bit iffy is that earlier we said:

    We expect that the caller calls this function only when we are doing
    "--reset-when-found"; otherwise we would give an error message from
    here even though we do not cause any damage otherwise.

    We also expect that the callers refrain from calling this function
    when bisect_next() that they eventually reach would not want to
    immediately reset.

but the way the callers see if "--reset-when-found" is in effect
looks quite ad-hoc.  Instead of sprinkling "do we have that file in
the filesystem and what does it say?" all over the place, I wonder
if it is simpler to reason about if we do these checks upfront and
store the parsed result in a variable, so that places that say
!is_empty_or_missing_file(...) etc. do not have to?  After all, we
do not keep calling get_terms() in the middle of operation, and
instead use values from "struct bisect_terms" that somebody else
prepared much earlier before terms->term_good and terms->term_bad
are used, right?  Shouldn't it be handled pretty much the same way?

