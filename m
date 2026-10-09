Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998FB499F12
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 09:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791536788; cv=none; b=e0Oo1VkyXTK+9fTu26LNbRol1oNqXYy3mmwCbYlVVdBeGrM4jjWOXaw4EpvRkebJdIN9DyAeMkn5q8VuByrO+GvlqlAW+9fj/flH7DoSvfBUZ+cOlVZpPgFepIYTkhiDSzOsVEEm1HAzecLJJ0GaxUqoYKDabcVOEFasEsxTp+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791536788; c=relaxed/simple;
	bh=89rgpVANcF4Lv1ANBKRIlJvy3O2iLRiriNpTFwr++6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E/XHUkHg5/oz+ym8ch1Y651hpQnNHf/nwATEBN795MAuY5xz6EEEq+KfiSwKU5DxN9awz3pb0vuAdxXxX7f4++lBtwKgoE8W/4mYT371V4BXop8plUVArw5LpGVOLRjvxGqBn7c4SMCWH8Y/OyA0fnOO6O90kDFJNyhgsJyjU/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Psie9Yv/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YtsOKhgM; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Psie9Yv/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YtsOKhgM"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id AE3D7EC00A5
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 05:06:20 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 09 Oct 2026 05:06:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1791536780; x=1791623180; bh=76B0qWzH4J
	daRsgGDaj2kiJDwWVRqf4mTknoAnRSgvs=; b=Psie9Yv/UxnWpo8kopZZ0PU5jq
	cJ/lh2xbO8qXDGyLf3mqAw2v84eW3rEgR+UC4VVsN0l04I4xxA29pf7cysl2iGWH
	3bjhmiAbBhI+MUYUSLQBJNQBf9WZoaMEuOXI5EOL/7o17nzwALELbrn8I0j+YR9B
	tafR2BZ1IQVFDlUKhvy2PLB3RQGQ9zcS3scr7VrfdfiWsGJ6YXZQnwEpBiBL+T/N
	UXjqTzoivuLCziwAsJIZeIc/4yJCyu7PxH2tbCJbRN1fruSTRHj/ID016k7db89q
	Iak7cdElmjEHMv7UOjxuErbVD0Kgvwp83vPbWQSWnitzBwd96lGco1ZUUiAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791536780; x=1791623180; bh=76B0qWzH4JdaRsgGDaj2kiJDwWVRqf4mTkn
	oAnRSgvs=; b=YtsOKhgMs50wXdjwgRXo5OvMpc7J4dbxc5HnS0uyb972TMAa3Po
	mSfXQ+8IF/TlD0DgDfCf+7o2NLJVMFQrO8Wt6UuntfPsD9aOIFd9UMqr4s1eh71o
	97/DbbmCRR3el7pjD64DDnjZQIRGHzx3olz7qCp3JBKiMerpk1fOkk+TBvfTwo98
	ZDl0tJbnxdCCv3h960KsTVkj4TyMF3QFe/3pCIHNfoAQZtzd0fH2jbHZJ3L5jGDV
	ZjIFEnA7YLd5Wn+heIP/a76lokgwRwVxp7grVk8mz2d8nmb3aOpCcSYV7jPqd/UE
	MimgCXEkMBWQF9sGW409JjogeWPjfZWcxlA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791536780; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:ILZ0SpY6hyFMgNQPh4sjBxHifvpG4mAalbKg8TDHsYn01RW
	2XsyDfrQRB9RobJVGdhfFHXO9zJ/GtitcvM/d31Ik8Blx6OYFwl7eIXBVxn5CaeF
	aIeutoik2A6iKeFpi242gmCy+FKCY+/AKXJQlOqNupLk8mmNd43LG+ZLDuGrLh4y
	lhLI7n/Xbh3qV5x+2uOM1LgeTpY1IBC1YZa5qSdg14+elELVDobXbhlKGcC3/oLw
	Rs8DHXW5bY1D+III1E08fQz8GDbCkgH/YS/84ZqDNaoOBCfDkDNr/i60zKmOVNEb
	tcqGqNk10ughxi48mkwRXkw25A3eq7MpkRt0NVA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:71W99ReOQ/4KRorhKbL0RVf6qIPatpqEED1C4BZbLnI=:89rgpVANcF4Lv1ANBKRIlJvy3O2iLRiriNpTFwr++6U=;
X-ME-Sender: <xms:i67IauJG1wmhhPBxAIe2ve7F9_38pD9pFEVVXgnBhDmHn-EiFsI99w>
    <xme:i67IavepndK1MAC7K0TRrXzwyF54luc9mdyVG3wq0OhLgnvbeoACBTyBD7mswWf9j
    rcVP4VuiYFahDn1YGvxyq-Ffqn5e7lOpBWleCFVAlizX95AVkSnlA>
X-ME-Received: <xmr:i67Ial8X_5u2wlUbYAoHahezjft8suMyfq5R846kaxkRg2iTnnmC2re6of4MmTRnE0SHbw>
X-ME-Proxy-Cause: dmFkZTEODag0yYZt6OEhWNLIP65HA1bIJrJm7XoKM4LfzUxzygKgB5Rnx9OTPJuHo83e1m
    7QJZq67yObpC9Bi4UfgmLpV+UBvYSIIJfQpAegy2nIbxuVff3/aMb90X8rYRMgtbTHnSp5
    evlJjGm9VBPNv3hTzdIYLGx1LJuY+7H0C6kOcuRAQzDYcVcn9MxCsDlVf7FHTMqzSM9EVZ
    JreLowsfQUFaD+XjQdjNk8wbwSaoPoYtVI47A9yNchz+kgSwgXjwcj4vXXcvtJ5k8rpSAk
    WszZUmbIeYyMtuemJxu/sP/8ck9my9LU7FkQeE42FCoEKM/7Ums0ht2Wa+BculGceU2zlI
    UH2nX9bTne4R2uFD5Uggc3HVk8qVFa1Z8JCN6Es8GnF4m+6ir+hoEK+ekuwSwEGuHrNkaK
    xOjo30iJDf2Iygm2Yrr1zN9kVOPg5tgVwCrN5WCT2G/s/ZgLY/Xi1wv07Jdp9JdTjzL5Bk
    t7yOvx467EzFGkuIgrGzVvjjenJEx0J8jDpgyFOLcnmeirkvn6HhH9CHUfLsi6tucQKYpw
    R4gL6chYqBZjwSnxrwIl4rsCVgrhcBsrkxxkasYF6MbHXs8bR25Fgn3ittKf4C1s+X5ZJD
    I/L0+AnkeVpAzqRnAJUZ+lnmPWG0YwrS43GFQ6261edLwBfgn9F9q0NdMbcw
X-ME-Proxy: <xmx:i67IakpsYBfuKk0EfZqu9A1PLGiiti7v3hqaRwKKd3eNCMdCeOO4mA>
    <xmx:i67IaiAOmaNf5BLbaT3UYZipVfsunkrEP_4Z8xiv3w_DdF1qae0zTQ>
    <xmx:i67IauzHKe8kTZFThcA80PqbsT0zQCAjSC5s8WZMruZF0izZ49uTkg>
    <xmx:i67Ian0DPD_DGGaqC0psuXlhEtc8p3PAtSLwRQyYT0FpzOm0dfYt9w>
    <xmx:jK7IakFVwGOOmXRoFRUonAsqIFnUhFBQ9N0xfALDlQrarxXTmwyVCuzm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Oct 2026 05:06:18 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f6284177 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 9 Oct 2026 09:06:16 +0000 (UTC)
Date: Fri, 9 Oct 2026 11:06:08 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Thomas Bachem via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Thomas Bachem <mail@thomasbachem.com>
Subject: Re: [PATCH v6 2/3] rerere: add "gc --skip-locked" for auto
 maintenance
Message-ID: <asiugInq7YTj4Qbe@pks.im>
References: <pull.2214.git.1788337897490.gitgitgadget@gmail.com>
 <pull.2214.v6.git.1790939492.gitgitgadget@gmail.com>
 <2ef141410a1508477976f9e57cec05f1a7603264.1790939492.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ef141410a1508477976f9e57cec05f1a7603264.1790939492.git.gitgitgadget@gmail.com>

On Fri, Oct 02, 2026 at 11:11:31AM +0000, Thomas Bachem via GitGitGadget wrote:
> From: Thomas Bachem <mail@thomasbachem.com>
> 
> Since the previous commit, "git rerere gc" waits for MERGE_RR.lock
> like every other command that takes it, and fails only if the wait
> times out. That suits a user who runs it by hand and wants to know
> when nothing was pruned.

Two nits:

  - We already took the lock before the preceding commit, the only
    difference is that we now have a timeout. Your message sounds as if
    the whole lock were new.

  - The user don't necessarily care that nothing was pruned, but they do
    care that pruning has failed.

> But the user did not ask for the gc that auto
> maintenance starts after a commit, and the next commit starts another
> one.

And this reads quite awkward, too. How about:

  Starting with the preceding commit, processes that want to acquire
  the rerere cache's MERGE_RR.lock by default know to wait up to one
  second until that lock has been released. This is a sensible default
  for many commands that happen to write rerere entries, as we would
  otherwise die immediately when the lock is taken by another process.

  But for repository maintenance it's a bit more complicated, as there
  are two cases that we have to care about. When the user explicitly
  asks us to garbage collect rerere entries via `git rerere gc` they
  probably want us to try our best to perform this operation. It's thus
  sensible to wait for the lock and then die if we weren't able to
  acquire it.

  But we also prune rerere entries as part of auto-maintenance, which is
  only executed on a best-effort basis anyway. Delaying the whole
  operation to acquire the lock is somewhat heavy-handed, and neither
  does it make sense to die in case we haven't been able to garbage
  collect rerere entries as that would impede other housekeeping tasks.
  Furthermore, it's totally fine to skip the operation when the rerere
  cache is locked already, as we will retry during the next run anyway.

  But we do not have an easy way to tell `git rerere gc` to skip the
  operation in case the cache is locked already. Add a new
  "--skip-locked" flag to plug that gap and have auto-maintenance pass
  that flag.

> diff --git a/builtin/gc.c b/builtin/gc.c
> index 57a3520263..7ad3987b71 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -385,12 +385,14 @@ out:
>  	return should_prune;
>  }
>  
> -static int maintenance_task_rerere_gc(struct maintenance_run_opts *opts UNUSED,
> +static int maintenance_task_rerere_gc(struct maintenance_run_opts *opts,
>  				      struct gc_config *cfg UNUSED)
>  {
>  	struct child_process rerere_cmd = CHILD_PROCESS_INIT;
>  	rerere_cmd.git_cmd = 1;
>  	strvec_pushl(&rerere_cmd.args, "rerere", "gc", NULL);
> +	if (opts->auto_flag)
> +		strvec_push(&rerere_cmd.args, "--skip-locked");
>  	return run_command(&rerere_cmd);
>  }

Makes sense, as this is what drives both `git gc --auto` and `git
maintenance run --auto`.

> diff --git a/rerere.c b/rerere.c
> index 64fac07c71..43c8eb04db 100644
> --- a/rerere.c
> +++ b/rerere.c
> @@ -887,18 +887,30 @@ int setup_rerere(struct repository *r, struct string_list *merge_rr, int flags)
>  
>  	if (flags & (RERERE_AUTOUPDATE|RERERE_NOAUTOUPDATE))
>  		rerere_autoupdate = !!(flags & RERERE_AUTOUPDATE);
> +	if ((flags & RERERE_READONLY) && (flags & RERERE_NOWAIT))
> +		BUG("RERERE_NOWAIT does not apply with RERERE_READONLY");
>  	if (flags & RERERE_READONLY) {
>  		fd = 0;
>  	} else {
> +		int lock_flags = LOCK_DIE_ON_ERROR;
> +		int timeout_ms = rerere_lock_timeout_ms;
> +
>  		/*
>  		 * Another process may hold the lock for a while, e.g.
>  		 * "git rerere gc" while it prunes rr-cache, so wait for
> -		 * it instead of dying right away.
> +		 * it instead of dying right away.  The gc of an automatic
> +		 * maintenance run does not wait, since skipping one of
> +		 * its runs costs nothing.
>  		 */

This comment is basically a layering violation, as you now assume who
passes `RERERE_NOWAIT`. It's a generic mechanism though, so I'd just
drop that part.

> +		if (flags & RERERE_NOWAIT) {
> +			lock_flags = 0;
> +			timeout_ms = 0;
> +		}
>  		fd = repo_hold_lock_file_for_update_timeout(r, &write_lock,
>  							    git_path_merge_rr(r),
> -							    LOCK_DIE_ON_ERROR,
> -							    rerere_lock_timeout_ms);
> +							    lock_flags, timeout_ms);
> +		if (fd < 0)
> +			return -1;

It's a tiny bit fishy that we return an error in the case where we have
been asked to skip locking and we indeed weren't able to acquire the
lock. To me it doesn't really indicate an error, as it matches the
intent of the caller. But I guess that's debatable.

> diff --git a/rerere.h b/rerere.h
> index feeb0e2c9f..d54c53d0d4 100644
> --- a/rerere.h
> +++ b/rerere.h
> @@ -10,6 +10,8 @@ struct repository;
>  #define RERERE_AUTOUPDATE   01
>  #define RERERE_NOAUTOUPDATE 02
>  #define RERERE_READONLY     04
> +/* Take MERGE_RR.lock only if it is free, and return quietly otherwise */
> +#define RERERE_NOWAIT       010

"free" is a bit unusual for a term for a lock.

> @@ -37,7 +39,7 @@ const char *rerere_path(struct strbuf *buf, const struct rerere_id *,
>  int rerere_forget(struct repository *, struct pathspec *);
>  int rerere_remaining(struct repository *, struct string_list *);
>  void rerere_clear(struct repository *, struct string_list *);
> -void rerere_gc(struct repository *, struct string_list *);
> +void rerere_gc(struct repository *, struct string_list *, int);

Given that these flags are new now, and given that none of the other
flags apply to `rerere_gc`, shouldn't we instead have a separate list of
flags specific to this function?

    enum rerere_gc_flags {
        /* Skip the operation in case the MERGE_RR.lock is already taken. */
        RERERE_GC_NOWAIT = (1 << 0),
    };

    void rerere_gc(struct repository *, struct string_list *,
                   enum rerere_gc_flags flags);

> diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
> index 7bd92235dc..28152bf456 100755
> --- a/t/t4200-rerere.sh
> +++ b/t/t4200-rerere.sh
> @@ -242,6 +242,27 @@ test_expect_success 'old records rest in peace' '
>  	test_path_is_missing $rr2/preimage
>  '
>  
> +test_expect_success 'gc --skip-locked does nothing while MERGE_RR is locked' '
> +	mkdir -p $rr2 &&
> +	echo Hello >$rr2/preimage &&
> +	test-tool chmtime =$just_over_15_days_ago $rr2/preimage &&
> +
> +	test_when_finished "rm -f .git/MERGE_RR.lock" &&
> +	>.git/MERGE_RR.lock &&
> +	git rerere gc --skip-locked 2>err &&
> +	test_must_be_empty err &&
> +	test_path_is_file $rr2/preimage &&
> +
> +	rm .git/MERGE_RR.lock &&
> +	git rerere gc --skip-locked &&
> +	test_path_is_missing $rr2/preimage
> +'
> +
> +test_expect_success '--skip-locked is only accepted by gc' '
> +	test_must_fail git rerere --skip-locked clear 2>err &&
> +	test_grep "option .--skip-locked. requires .gc." err
> +'

You verify that --skip-locked skips when locked, but you don't verify
that it doesn't skip when unlocked.

Patrick
