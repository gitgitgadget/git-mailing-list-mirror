Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2255341C7F
	for <git@vger.kernel.org>; Tue, 11 Feb 2025 17:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739296107; cv=none; b=bR1cqb8GHPQqo46Ih3tMOgVDeU8KZpsrXu3lEBvYaGg2UVhmltIqfoGGZbZYg/l7d1SU75AHpWK6quPzo1FZ5AYWGZjIlmdUeFJT2NjpripRSP4D4/9jfD9alVflzRZG5ECCCszFOSjr913ddJNhUNOwt/PfgRHYJlSQIE6n90o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739296107; c=relaxed/simple;
	bh=zTK4z+elecUU+xKpsvEy0Lg8wih7NMhzcsUUtZ2Lems=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pQOfu4lhlJX3PgNDNP6+LyL+9r/lL0gWL248WYSOA7HmF9WgDq2PJKju6pI8suCikcZcCw+ycxkxsoxil5hllxIqc0SktYixt8mqAzLlG1954eINPXaAXWtY0sgQldkZdDzAH/OIiFVJP+z5a360nZQZy/W0ltUKUWu3LCYDvUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hb/3wgVm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BK3u3o8i; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hb/3wgVm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BK3u3o8i"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 24FF31380A18;
	Tue, 11 Feb 2025 12:48:24 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Tue, 11 Feb 2025 12:48:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1739296104; x=1739382504; bh=BLStt2H6Lv
	OWYnTc8ho5PKKZR3oza885eAoN5yJdEXo=; b=hb/3wgVmHVTDSr5cHaZcn/Cgx9
	a5SnR7N8iQXbb3l8itjlWnrzn6pcaRfzdybI6cdG3Puxd8Wc7g45oJlIonev6T1y
	CeIdct08cndaeZBWSJDctw1rXwbnUIxQSuncJ+5iGbQmNKwRuTCUYQaiZVIh3fWh
	nhfR8t2CFkFV5jCc+6SWSZ1VPr8UqZjQc4ey5js+s7PiR3Ky3esuWtOCWTe6NUfv
	+k6ytFDigU4zhM1gibX/cFSviZ0KFmrORsPJ3HbdCCfosPQrxy29+9vnm1JQQUg8
	x2SeJONh2+jthfTYqicE/m7kX6RRyXvrOFHG5VEhvlHrdUmvVYK+WnLpS5nA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739296104; x=1739382504; bh=BLStt2H6LvOWYnTc8ho5PKKZR3oza885eAo
	N5yJdEXo=; b=BK3u3o8izWEh2H93pNKKLr2nZH7uw86ACEonHQdKKYvB+Uz809U
	ywuElmZQRm/dy3NJzv30gMHtfIUHNJN7Ij1fPZCFUhCh5iOd3+mKpH55rVwX++ah
	qADVY187/yvztBHfADSZFjKu+KcIuaSowGPaAoK+wJ0c1zvFtopsZqeayNhE8QmJ
	7v/rfd1wEFQEmF9YXDfyxBXmEkv3OIp1jD4HH6LwSYjw/eSqK234ES9Fv/t4blot
	3H/RaH6HHcaCw5VX4fpqonO4SF6uPjvtkvsU/Snt+3W8wuOcbQpchDF/po1y/jvf
	2yrMlV3k2mc+VJlHj7iwTouiWCj2foH1JPQ==
X-ME-Sender: <xms:Z42rZzXOu0nnQRxT_mH6SuVMJXS41URaWJt4JNsDbPNnkwMb__0FXw>
    <xme:Z42rZ7mGDHdOKQ8-GjxOqOO2UEsne99w0PKcZeaXruPUZ1iw-XYShc5hx23lPVh5x
    bDhOxzAk93wMN4Gaw>
X-ME-Received: <xmr:Z42rZ_bqS4nK17SLJRjCLrEkIU7dCGXc4NbiNn0x6P9tMO7IVlW4DvUElNW79jtQjMEcE1vU7VOHrBqR6eLONPa7TykG8XrjEhyF75M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegudeigecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeettddtveffueeiieelffeftdeigfefkeev
    teevveeutdelhfdtudfgledtjeeludenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhs
    thgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhsse
    hpkhhsrdhimhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Z42rZ-V6F94lnxtqj3o-C00jwPrcM2ycle0S-nY94leM_RBXtkd0qA>
    <xmx:Z42rZ9nVyMXfgNXzOt4Exftp_0LXu8H-rxQy2pfpuO12yp85waKPdg>
    <xmx:Z42rZ7eflnn1yxaMjikdMv1MO5nbMrUOFJvaCbxlzNRRhGOaGRg0eA>
    <xmx:Z42rZ3H88XkdQ4CJheBF4sd5O9rfMJoc-rZrNkAP2du7L4_I510z2g>
    <xmx:aI2rZwsHCIpngU5CwejnoHXeTJEhbVrSiDsACkRd8JUN4Bdf3BBGbPl0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Feb 2025 12:48:23 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  jltobler@gmail.com
Subject: Re: [PATCH v2] builtin/refs: add '--skip-reflog' flag to bypass
 reflog migration
In-Reply-To: <20250211-477-refs-migrate-add-a-flag-to-ignore-reflogs-during-migration-v2-1-991a2ec9a796@gmail.com>
	(Karthik Nayak's message of "Tue, 11 Feb 2025 12:42:18 +0100")
References: <20250207-477-refs-migrate-add-a-flag-to-ignore-reflogs-during-migration-v1-1-7d40f3b4e30b@gmail.com>
	<20250211-477-refs-migrate-add-a-flag-to-ignore-reflogs-during-migration-v2-1-991a2ec9a796@gmail.com>
Date: Tue, 11 Feb 2025 09:48:22 -0800
Message-ID: <xmqqcyfoz82h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> The 'git-refs(1)' migrate subcommand, which transfers repositories
> between reference backends, currently migrates reflogs by default as of
> 246cebe320 (refs: add support for migrating reflogs, 2024-12-16).
>
> While this behavior is desirable for most client-side repositories,
> server-side repositories are not expected to contain reflogs. However,
> due to historical reasons, some may still have them. This could be
> caused, for example, by bugs, misconfiguration, or an administrator
> enabling reflogs on the server for debugging purposes.
>
> To address this, introduce the --skip-reflog flag, allowing users to
> bypass reflog migration. This ensures that the repository ends up in the
> expected state after migration.
>
> Helped-by: Patrick Steinhardt <ps@pks.im>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
> Changes in v2:
> - Fix typo in commit mesasge and clarify the intent.
> - Modify the test to use `test_line_count` and `test_must_be_empty`.
> - Link to v1: https://lore.kernel.org/r/20250207-477-refs-migrate-add-a-flag-to-ignore-reflogs-during-migration-v1-1-7d40f3b4e30b@gmail.com
> ---
> Range-diff versus v1:
>
> 1:  ce14d3d07e ! 1:  6b83089348 builtin/refs: add '--skip-reflog' flag to bypass reflog migration
>     @@ Commit message
>      
>          The 'git-refs(1)' migrate subcommand, which transfers repositories
>          between reference backends, currently migrates reflogs by default as of
> ...
>      +		'
>       	done
>       done
> ---
>  builtin/refs.c          |  3 +++
>  refs.c                  |  8 +++++---
>  refs.h                  |  5 ++++-
>  t/t1460-refs-migrate.sh | 19 +++++++++++++++++--
>  4 files changed, 29 insertions(+), 6 deletions(-)

This is tangent that is totally unrelated to the theme of this
patch, but I find that the placement of range-diff makes it very
hard to follow.

After skimming the proposed log message, the next thing I would want
to see is the list of paths that are modified, before deciding I
want to review the patch now.  Once I decide to read it _now_, the
changes from the previous iteration and range-diff becomes relevant.

Is it just me who decides in what order to review the patches and
then reviews them in that order?

Anyway.

> diff --git a/builtin/refs.c b/builtin/refs.c
> index a29f19583474518ee0942ea53c39cbdf9661c5e2..30be0254c14dd3d07693d70c25dddc9990756e9c 100644
> --- a/builtin/refs.c
> +++ b/builtin/refs.c
> @@ -30,6 +30,9 @@ static int cmd_refs_migrate(int argc, const char **argv, const char *prefix,
>  		OPT_BIT(0, "dry-run", &flags,
>  			N_("perform a non-destructive dry-run"),
>  			REPO_MIGRATE_REF_STORAGE_FORMAT_DRYRUN),
> +		OPT_BIT(0, "skip-reflog", &flags,
> +			N_("skip migrating reflogs"),
> +			REPO_MIGRATE_REF_STORAGE_FORMAT_SKIP_REFLOG),
>  		OPT_END(),
>  	};
>  	struct strbuf errbuf = STRBUF_INIT;

OK.

> diff --git a/refs.c b/refs.c
> index f4094a326a9f88f979654b668cc9c3d27d83cb5d..5e8f5c06fa68d16c93ee11edd9742995eea994b6 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -3035,9 +3035,11 @@ int repo_migrate_ref_storage_format(struct repository *repo,
>  	if (ret < 0)
>  		goto done;
>  
> -	ret = refs_for_each_reflog(old_refs, migrate_one_reflog, &data);
> -	if (ret < 0)
> -		goto done;
> +	if (!(flags & REPO_MIGRATE_REF_STORAGE_FORMAT_SKIP_REFLOG)) {
> +		ret = refs_for_each_reflog(old_refs, migrate_one_reflog, &data);
> +		if (ret < 0)
> +			goto done;
> +	}
>  
>  	ret = ref_transaction_commit(transaction, errbuf);
>  	if (ret < 0)
> diff --git a/refs.h b/refs.h
> index a0cdd99250e8286b55808b697b0a94afac5d8319..ccee8fc6705e6e93a1c6234e7395180f8dfd815b 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -1157,8 +1157,11 @@ int is_pseudo_ref(const char *refname);
>   *   - REPO_MIGRATE_REF_STORAGE_FORMAT_DRYRUN: perform a dry-run migration
>   *     without touching the main repository. The result will be written into a
>   *     temporary ref storage directory.
> + *
> + *   - REPO_MIGRATE_REF_STORAGE_FORMAT_SKIP_REFLOG: skip migration of reflogs.
>   */
> -#define REPO_MIGRATE_REF_STORAGE_FORMAT_DRYRUN (1 << 0)
> +#define REPO_MIGRATE_REF_STORAGE_FORMAT_DRYRUN      (1 << 0)
> +#define REPO_MIGRATE_REF_STORAGE_FORMAT_SKIP_REFLOG (1 << 1)

These are quite a mouthful, but they are only used between the refs
subsystem and "git refs" command, so being overly verbose and
specific is a good thing.

>  /*
>   * Migrate the ref storage format used by the repository to the
> diff --git a/t/t1460-refs-migrate.sh b/t/t1460-refs-migrate.sh
> index a6d9b35a46eb59350aa0d59d982a2fbfaecf1448..28c0024a4c8cb8282bf586840265edba442f5056 100755
> --- a/t/t1460-refs-migrate.sh
> +++ b/t/t1460-refs-migrate.sh
> @@ -9,14 +9,16 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>  
>  # Migrate the provided repository from one format to the other and
>  # verify that the references and logs are migrated over correctly.
> -# Usage: test_migration <repo> <format> <skip_reflog_verify>
> +# Usage: test_migration <repo> <format> <skip_reflog_verify> <...options>
>  #   <repo> is the relative path to the repo to be migrated.
>  #   <format> is the ref format to be migrated to.
>  #   <skip_reflog_verify> (true or false) whether to skip reflog verification.
> +#   <...options> are other options be passed directly to 'git refs migrate'.

Yuck.  I've never seen preceding three-dots.  Makes readers wonder
how this thing behaves differently from the usual <options...>.

Doubly yuck is ...


>  test_migration () {
>  	repo=$1 &&
>  	format=$2 &&
>  	skip_reflog_verify=${3:-false} &&
> +	shift $(( $# >= 3 ? 3 : 2 )) &&

... this thing.  The above usage declares that <skip_reflog_verify>,
just like <repo> and <format>, are required so I do not see why we
need to be conditional here.  If you want to make it optional,
writing it this way instead ...

	repo=$1 &&
        format=$2 &&
	shift 2 &&

        skip_reflog_verify=false &&
	if test $# -gt 1
	then
		skip_reflog_verify=$1
		shift
	fi

... would make it easier to extend when you ever want to add the
next optional positional parameter.

>  	git -C "$repo" for-each-ref --include-root-refs \
>  		--format='%(refname) %(objectname) %(symref)' >expect &&
>  	if ! $skip_reflog_verify
> @@ -25,7 +27,7 @@ test_migration () {
>  	   git -C "$repo" reflog list >expect_log_list
>  	fi &&
>  
> -	git -C "$repo" refs migrate --ref-format="$2" &&
> +	git -C "$repo" refs migrate --ref-format="$format" $@ &&

It is a good change to use the named variable we captured upfront,
but did you mean to leave $@ unquoted?

Unless you want to use "$@" to invoke the magic "pass each parameter
separately, even if it has $IFS whitespace in it" semantics,
choosing between $* (when you want to split a parameter into many
when it has $IFS whitespaces) and "$*" (when you want everything in
one string) is preferred.

>  	git -C "$repo" for-each-ref --include-root-refs \
>  		--format='%(refname) %(objectname) %(symref)' >actual &&
> @@ -241,6 +243,19 @@ do
>  				test_cmp expect.reflog actual.reflog
>  			)
>  		'
> +
> +		test_expect_success "$from_format -> $to_format: skip reflog with --skip-reflog" '
> +			test_when_finished "rm -rf repo" &&
> +			git init --ref-format=$from_format repo &&
> +			test_commit -C repo initial &&
> +			# we see that the repository contains reflogs.
> +			git -C repo reflog --all >reflogs &&
> +			test_line_count = 2 reflogs &&
> +			test_migration repo "$to_format" true --skip-reflog &&
> +			# there should be no reflogs post migration.
> +			git -C repo reflog --all >reflogs &&
> +			test_must_be_empty reflogs
> +		'
>  	done
>  done
>  
>
> ---
>
> base-commit: bc204b742735ae06f65bb20291c95985c9633b7f
> change-id: 20250207-477-refs-migrate-add-a-flag-to-ignore-reflogs-during-migration-8066f6df50ac
>
> Thanks
> - Karthik
