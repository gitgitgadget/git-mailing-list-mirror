Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5F94EC66B
	for <git@vger.kernel.org>; Fri,  4 Sep 2026 15:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788535300; cv=none; b=FuAt0bJbpWbTDEDCUGXNK7gJuJRZbydJJfv8kg8Sk3Xj1hzcx8cmJ7n2F9Ir6u0OB8sG6E1qmgS2VBRFeI44/VWjdeJw3vB/tF6xKkRk2KWAwgA33x8miBZSc6URLLqYMppisjwmpbyXGd0Hb0lCHV3upk1MgJrp03GMgbY8SAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788535300; c=relaxed/simple;
	bh=w0jhSgSsfItP67OLOsPG/PQPl35mbs2R/5xmPZRoio4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=df6D+ow9aWoB2bEZhyHxUgzbo1UC80wURqb3KeH1fwTBkmxGdjzvVD9khAFRr7nrlJrIzU9xlt/qgox6+y8PcCksCpnjiAKGnNpZKnWoLACrtFz9eNaD+Ry65BOFaZFXS+NdLr2yIrWlLQTvt+zOqz2PUkIBTp5xamwnC0l3OKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XEdmcrzd; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XEdmcrzd"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-484374f54d0so703507f8f.3
        for <git@vger.kernel.org>; Fri, 04 Sep 2026 08:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788535297; x=1789140097; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=H9LzLjHQ3DPz8erV2bJ4Ha3/wUueirZRgfBC38vOpxQ=;
        b=XEdmcrzd5/5NERnZEMljGngoRoWQ0wHgWue9kMVwQd3hzV92Q68prkz6tcwZ1cNinl
         dfnXYfpdMqJG/NsknQYeWTHzu4YMs7n86hD93WaboSCznsKZFNK3sqXUy08pXHkSEpMA
         R1jeo2wgDVgZ13RNnqVZJBZ2VauFecpBN5aFw5v+ztkMkU0OrSZNjy7vyd+ZhFZq70Np
         Dn+JDkjOv8FYg5y+tW7CsS41hX83h7kKTFnemGAgwCQfbMllCgYoIKL5lw1XYB8et5Nz
         jY9lY5tN9nXFqE136Ezj416WaYoXL4KfBcbJJvQkbX4RTVaqNpGHlcu0TGwN/u/PR+Xs
         msuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788535297; x=1789140097;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H9LzLjHQ3DPz8erV2bJ4Ha3/wUueirZRgfBC38vOpxQ=;
        b=fAOEr8RjBO8xrqVaw8an1/RzK4AyfjnTdl3dyyB9lInBYybibotWUebHH1Hjwl4CZ3
         rHLCwEIOUIneE7nYUaMFY1OlE+RwjEd78EuLZ2/9e7su0Ivhnf1J9r+JaAsVRC37rZ8W
         YgQsa5nBptuv70sKroAQ9bsPi3Rd6ce7UCydLncrykfZ94dFkMPA7/XbP0sdTcCg31j3
         fqGBDORGlA6WEXOungfm4OIdh1qyzH9S59sqNtUSzdiPv6xDnteSvwOCReye0t4gqOgL
         5jvP8DepWO9u0OmexMizD2yFERAEoxDYeDv0J/sWgxePXVGQ3w/PNYvX5Yu9MY5QvItQ
         TetA==
X-Forwarded-Encrypted: i=1; AKwUvBzTYJC61YECxH1QWPb6r8EYBcksWxj0cLNSr+pjvIvLi+m1yzmgcq9VHu+HNEwytXAD2ss=@vger.kernel.org
X-Gm-Message-State: AFuF++mgRrqx7ABFsaZ7x2C2rgau+OmAIs4P0W652/pnczbTBjvm/GEy
	RpaUl03yCUiPVC9RrbOfDMprVbxXzb1zxxgUntIwmdyJGsFVuYOrwTYn
X-Gm-Gg: AYBFou2aKLWUA1n06fB2/1QUTguynQnT8+ZateoD8PGcx1jYIcRKs2zpjTh1EYpahti
	Kla1lf8zuk3/O3X9Ripe5Z3xOyos+FOtnoVSTtajPioLHkchOvXR7kB0UZjHj84cfiUpjrXmbkp
	/SZnsNqTZUY1Udy5W8fvx/x6GL+NOOhHP4LkLXWptd0dxhKgmCdO3Oa0K+416PEyX8G3PgpEs7Z
	aSFIX6iNxWn2iC741cMMk1F+/eRl8rqGyav6/69YecWNxEpRid3SM4GHS68L+F+JpB0xE2xEq/7
	s1GZ8sEgoOOr6FTaRcPA/7qTCM/jS2tK2rUBvfVrHuUWyKpKO3tJtXFUGJlRT6p8b5+kOOFJt0t
	TDUBGxjSnNGkG28d0fK0viY3y/XXOuJLu4zARft80Wfaa1QQ6nbHjwLJt4uxbdtLqyfiARfllWY
	HcLomDDczRjtfwjA8dEg/sD07zP/7zVkm0guAJRbzFbgi9dsD/J383k/sSHd9jBmhWHItmBN8QA
	ax50qEkdeoNYmz2mZrEImIaWJFnoa5Sto6+5gzbrsA=
X-Received: by 2002:a05:6000:2999:10b0:482:ea08:8c97 with SMTP id ffacd0b85a97d-48587046b35mr11143697f8f.2.1788535296560;
        Fri, 04 Sep 2026 08:21:36 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48588135600sm5927251f8f.2.2026.09.04.08.21.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 08:21:35 -0700 (PDT)
Message-ID: <5e613735-60e2-429d-a5bb-1a4f03578604@gmail.com>
Date: Fri, 4 Sep 2026 16:21:34 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] rerere: keep a background gc from killing a rebase
To: Thomas Bachem via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Phillip Wood
 <phillip.wood@dunelm.org.uk>, Junio C Hamano <gitster@pobox.com>,
 Thomas Bachem <mail@thomasbachem.com>
References: <pull.2214.git.1788337897490.gitgitgadget@gmail.com>
 <pull.2214.v2.git.1788507876543.gitgitgadget@gmail.com>
Content-Language: en-US
In-Reply-To: <pull.2214.v2.git.1788507876543.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Thomas

On 04/09/2026 08:44, Thomas Bachem via GitGitGadget wrote:
> From: Thomas Bachem <mail@thomasbachem.com>
> 
> Since 2.54 unscheduled maintenance uses the "geometric" strategy, so
> the "git maintenance run --auto --detach" behind every "git commit"
> runs "git rerere gc" in the background whenever rr-cache has an entry.

With Patricks patches that's no-longer true I think. I think a better 
motivation, as the cache is per-repository, rather than per-worktree, is 
concurrent writers running in different worktrees. That makes the 
timeout much more sensible as we expect writing a conflict resolution to 
be much faster than gc.

Overall, this commit message is rather long and it would be helpful if 
you could distill it to remove unnecessary and unrelated details.

> 
>   Documentation/config/rerere.adoc | 10 ++++
>   Documentation/git-rerere.adoc    |  4 +-
>   builtin/am.c                     |  2 +-
>   builtin/rebase.c                 |  6 +-
>   builtin/rerere.c                 |  7 ++-
>   rerere.c                         | 42 ++++++++++----
>   rerere.h                         |  8 ++-
>   t/t4200-rerere.sh                | 96 ++++++++++++++++++++++++++++++++
>   t/t7900-maintenance.sh           |  8 +++
>   9 files changed, 163 insertions(+), 20 deletions(-)
> 
> diff --git a/Documentation/config/rerere.adoc b/Documentation/config/rerere.adoc
> index 3a78b5ebb1..b67323fc46 100644
> --- a/Documentation/config/rerere.adoc
> +++ b/Documentation/config/rerere.adoc
> @@ -10,3 +10,13 @@ rerere.enabled::
>   	enabled if there is an `rr-cache` directory under the
>   	`$GIT_DIR`, e.g. if "rerere" was previously used in the
>   	repository.
> +
> +rerere.lockTimeout::
> +	The length of time, in milliseconds, to retry when trying to
> +	take the rerere lock while another process holds it, typically
> +	a background `git rerere gc`.  When the time is up, the command
> +	warns and goes on without rerere.  Value 0 means not to retry
> +	at all; -1 means to try indefinitely.  Default is 1000 (i.e.,
> +	retry for 1 second).  `git rerere gc` does not retry, and
> +	`git rerere`, `git rerere forget` and `git rerere clear` fail
> +	instead of going on.

Why do those commands fail rather than wait?

> @@ -908,12 +911,31 @@ int setup_rerere(struct repository *r, struct string_list *merge_rr, int flags)
>   
>   	if (flags & (RERERE_AUTOUPDATE|RERERE_NOAUTOUPDATE))
>   		rerere_autoupdate = !!(flags & RERERE_AUTOUPDATE);
> -	if (flags & RERERE_READONLY)
> +	if (flags & RERERE_READONLY) {
>   		fd = 0;
> -	else
> -		fd = hold_lock_file_for_update(&write_lock,
> -					       git_path_merge_rr(r),
> -					       LOCK_DIE_ON_ERROR);
> +	} else {
> +		int lock_flags = 0;
> +		long timeout_ms = rerere_lock_timeout_ms;
> +
> +		if (flags & RERERE_LOCK_OR_DIE)
> +			lock_flags = LOCK_DIE_ON_ERROR;
> +		if (flags & RERERE_NOWAIT)
> +			timeout_ms = 0;

It might be worth adding a check above here that BUG()s out if the 
caller passes an incompatible set of flags.

> +		/*
> +		 * A background "rerere gc" holds the lock for as long as it
> +		 * takes to prune rr-cache, so wait it out rather than fail
> +		 * at once.  The gc itself has nothing to lose from a skipped
> +		 * run and never waits.
> +		 */
> +		fd = hold_lock_file_for_update_timeout(&write_lock,
> +						       git_path_merge_rr(r),
> +						       lock_flags, timeout_ms);
> +		if (fd < 0) {
> +			warning_errno(_("skipping rerere, unable to create '%s.lock'"),
> +				      git_path_merge_rr(r));

A background job that the user did not explicitly start printing to the 
terminal is rather confusing as it is likely to get mixed in with the 
output of whatever is running in the foreground.

Thanks

Phillip

> +			return -1;
> +		}
> +	}
>   	read_rr(r, merge_rr);
>   	return fd;
>   }
> @@ -1124,7 +1146,7 @@ fail_exit:
>   	return -1;
>   }
>   
> -int rerere_forget(struct repository *r, struct pathspec *pathspec)
> +int rerere_forget(struct repository *r, struct pathspec *pathspec, int flags)
>   {
>   	int i, fd, ret;
>   	struct string_list conflict = STRING_LIST_INIT_DUP;
> @@ -1133,7 +1155,7 @@ int rerere_forget(struct repository *r, struct pathspec *pathspec)
>   	if (repo_read_index(r) < 0)
>   		return error(_("index file corrupt"));
>   
> -	fd = setup_rerere(r, &merge_rr, RERERE_NOAUTOUPDATE);
> +	fd = setup_rerere(r, &merge_rr, RERERE_NOAUTOUPDATE | flags);
>   	if (fd < 0)
>   		return 0;
>   
> @@ -1237,7 +1259,7 @@ void rerere_gc(struct repository *r, struct string_list *rr)
>   	timestamp_t cutoff_resolve = now - 60 * 86400;
>   	struct strbuf buf = STRBUF_INIT;
>   
> -	if (setup_rerere(r, rr, 0) < 0)
> +	if (setup_rerere(r, rr, RERERE_NOWAIT) < 0)
>   		return;
>   
>   	repo_config_get_expiry_in_days(the_repository, "gc.rerereresolved",
> @@ -1289,11 +1311,11 @@ void rerere_gc(struct repository *r, struct string_list *rr)
>    *
>    * NEEDSWORK: shouldn't we be calling this from "reset --hard"?
>    */
> -void rerere_clear(struct repository *r, struct string_list *merge_rr)
> +void rerere_clear(struct repository *r, struct string_list *merge_rr, int flags)
>   {
>   	int i;
>   
> -	if (setup_rerere(r, merge_rr, 0) < 0)
> +	if (setup_rerere(r, merge_rr, flags) < 0)
>   		return;
>   
>   	for (i = 0; i < merge_rr->nr; i++) {
> diff --git a/rerere.h b/rerere.h
> index d4b5f7c932..3a9f58acd9 100644
> --- a/rerere.h
> +++ b/rerere.h
> @@ -10,6 +10,10 @@ struct repository;
>   #define RERERE_AUTOUPDATE   01
>   #define RERERE_NOAUTOUPDATE 02
>   #define RERERE_READONLY     04
> +/* Do not wait for the lock when another process holds it */
> +#define RERERE_NOWAIT       010
> +/* Die on a lock that cannot be taken instead of going on without rerere */
> +#define RERERE_LOCK_OR_DIE  020
>   
>   /*
>    * Marks paths that have been hand-resolved and added to the
> @@ -34,9 +38,9 @@ int repo_rerere(struct repository *, int);
>    */
>   const char *rerere_path(struct strbuf *buf, const struct rerere_id *,
>   			const char *file);
> -int rerere_forget(struct repository *, struct pathspec *);
> +int rerere_forget(struct repository *, struct pathspec *, int);
>   int rerere_remaining(struct repository *, struct string_list *);
> -void rerere_clear(struct repository *, struct string_list *);
> +void rerere_clear(struct repository *, struct string_list *, int);
>   void rerere_gc(struct repository *, struct string_list *);
>   
>   #define OPT_RERERE_AUTOUPDATE(v) OPT_UYN(0, "rerere-autoupdate", (v), \
> diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
> index 1717f407c8..243b3ebed3 100755
> --- a/t/t4200-rerere.sh
> +++ b/t/t4200-rerere.sh
> @@ -242,6 +242,102 @@ test_expect_success 'old records rest in peace' '
>   	test_path_is_missing $rr2/preimage
>   '
>   
> +test_expect_success 'gc does nothing while MERGE_RR is locked' '
> +	mkdir -p $rr2 &&
> +	echo Hello >$rr2/preimage &&
> +	test-tool chmtime =$just_over_15_days_ago $rr2/preimage &&
> +
> +	test_when_finished "rm -f .git/MERGE_RR.lock" &&
> +	>.git/MERGE_RR.lock &&
> +	git rerere gc 2>err &&
> +	test_grep "MERGE_RR.lock" err &&
> +	test_path_is_file $rr2/preimage &&
> +
> +	rm .git/MERGE_RR.lock &&
> +	git rerere gc &&
> +	test_path_is_missing $rr2/preimage
> +'
> +
> +test_expect_success 'a held lock is waited out within rerere.lockTimeout' '
> +	git reset --hard &&
> +	rm -rf $rr &&
> +	test_when_finished "rm -f .git/MERGE_RR.lock" &&
> +	>.git/MERGE_RR.lock &&
> +	{
> +		( sleep 1 && rm -f .git/MERGE_RR.lock ) &
> +	} &&
> +	test_must_fail git -c rerere.lockTimeout=5000 merge first 2>err &&
> +	wait &&
> +	test_grep ! "MERGE_RR" err &&
> +	test_grep "^=======\$" $rr/preimage
> +'
> +
> +test_expect_success 'merge goes on without rerere once rerere.lockTimeout is up' '
> +	git reset --hard &&
> +	rm -rf $rr &&
> +	test_when_finished "rm -f .git/MERGE_RR.lock" &&
> +	>.git/MERGE_RR.lock &&
> +	test_must_fail git -c rerere.lockTimeout=0 merge first 2>err &&
> +	test_grep "skipping rerere" err &&
> +	test_grep "^=======\$" a1 &&
> +	test_path_is_missing $rr/preimage
> +'
> +
> +test_expect_success 'commit goes on without rerere once rerere.lockTimeout is up' '
> +	git reset --hard &&
> +	rm -rf $rr &&
> +	git checkout -b lock-held-commit third &&
> +	test_when_finished "git checkout third && git branch -D lock-held-commit" &&
> +	test_must_fail git merge first &&
> +	test_path_is_file $rr/preimage &&
> +	test_when_finished "rm -f .git/MERGE_RR.lock" &&
> +	>.git/MERGE_RR.lock &&
> +	echo resolved >a1 &&
> +	git add a1 &&
> +	git -c rerere.lockTimeout=0 commit -qm resolved 2>err &&
> +	test_grep "skipping rerere" err &&
> +	test_path_is_missing $rr/postimage
> +'
> +
> +test_expect_success 'rerere, forget and clear fail on a lock they cannot take' '
> +	test_when_finished "rm -f .git/MERGE_RR.lock" &&
> +	>.git/MERGE_RR.lock &&
> +	test_must_fail git -c rerere.lockTimeout=0 rerere 2>err &&
> +	test_grep "Unable to create" err &&
> +	test_must_fail git -c rerere.lockTimeout=0 rerere forget a1 2>err &&
> +	test_grep "Unable to create" err &&
> +	test_must_fail git -c rerere.lockTimeout=0 rerere clear 2>err &&
> +	test_grep "Unable to create" err
> +'
> +
> +test_expect_success 'rebase goes on without rerere once rerere.lockTimeout is up' '
> +	git reset --hard &&
> +	rm -rf $rr &&
> +	git checkout -b lock-held third &&
> +	test_when_finished "git checkout third && git branch -D lock-held" &&
> +	test_when_finished "rm -f .git/MERGE_RR.lock" &&
> +	>.git/MERGE_RR.lock &&
> +	test_must_fail git -c rerere.lockTimeout=0 rebase first 2>err &&
> +	test_grep "skipping rerere" err &&
> +	test_path_is_file .git/rebase-merge/stopped-sha &&
> +	echo resolved >a1 &&
> +	git add a1 &&
> +	git -c rerere.lockTimeout=0 rebase --continue &&
> +	test_path_is_missing .git/rebase-merge &&
> +	test_path_is_missing $rr/preimage
> +'
> +
> +test_expect_success 'rebase --abort goes on without rerere on a held lock' '
> +	git checkout -b lock-held-abort third &&
> +	test_when_finished "git checkout third && git branch -D lock-held-abort" &&
> +	test_must_fail git rebase first &&
> +	test_when_finished "rm -f .git/MERGE_RR.lock" &&
> +	>.git/MERGE_RR.lock &&
> +	git -c rerere.lockTimeout=0 rebase --abort 2>err &&
> +	test_grep "skipping rerere" err &&
> +	test_path_is_missing .git/rebase-merge
> +'
> +
>   rerere_gc_custom_expiry_test () {
>   	five_days="$1" right_now="$2"
>   	test_expect_success "rerere gc with custom expiry ($five_days, $right_now)" '
> diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> index d7f82e1bec..a55ca2e829 100755
> --- a/t/t7900-maintenance.sh
> +++ b/t/t7900-maintenance.sh
> @@ -885,6 +885,14 @@ test_expect_success 'rerere-gc task with --auto honors maintenance.rerere-gc.aut
>   	test_expect_rerere_gc ! git -c maintenance.rerere-gc.auto=0 maintenance run --auto --task=rerere-gc
>   '
>   
> +test_expect_success 'rerere-gc task succeeds while MERGE_RR is locked' '
> +	test_when_finished "rm -rf .git/rr-cache .git/MERGE_RR.lock" &&
> +	mkdir .git/rr-cache &&
> +	: >.git/rr-cache/entry &&
> +	>.git/MERGE_RR.lock &&
> +	test_expect_rerere_gc git maintenance run --task=rerere-gc
> +'
> +
>   test_expect_success '--auto and --schedule incompatible' '
>   	test_must_fail git maintenance run --auto --schedule=daily 2>err &&
>   	test_grep "cannot be used together" err
> 
> base-commit: e9019fcafe0040228b8631c30f97ae1adb61bcdc

