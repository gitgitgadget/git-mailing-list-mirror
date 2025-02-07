Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F1C23C8D9
	for <git@vger.kernel.org>; Fri,  7 Feb 2025 17:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738950490; cv=none; b=if1SGPwx/UF/frwKnY4NsUV41bDHobyUs2MOIovwBRhreS7zVQUYPuQ30rlrECcKg6jPxijrwIrfy5OVqf56nPuuT9fheY87mTYQlRvIh0XRPq/wRu7ZsENgcpyMXh8+wPYLjpR94QQTyklyskrxX/DhrQSrBddQB7bZ1ROAcOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738950490; c=relaxed/simple;
	bh=eAZXTczZOOemsF3J59QUimrCGXGFCjGEc+0Y6D+wWvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PF5vfUYZUII32IGIW98ivKGZ3ZAXaqGQ4Sx+AQLgmPZWT+3f6SxiyTi38xAyQnv9v18tAO9LOvfUXfOul27jOggQ0Fn7dg6ZiRR6xbcglvSKv/e7v/dre1lg88enAEkzQqGMtlsJbob/ENAzvddBTpgGV9ncV482NJWh7uG89iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ynbr4hX5; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ynbr4hX5"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5f6b65c89c4so590188eaf.2
        for <git@vger.kernel.org>; Fri, 07 Feb 2025 09:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738950487; x=1739555287; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vai7Qi/TzAJ2mZW/V+bMEmLyh545tl0+hKRUaxTdgTk=;
        b=Ynbr4hX5vdyAQcvGdBL1lFHsuNBpT0YPQRRMR7b8pA7p3GjhlF2SmqQFXTQ4wUyIwT
         RJ0CFXRilbk/IwJgSyA5SfjhwWdKN0P9ILgHIBuC+38abC81xcrjNhCIcSrFRUsRcRZK
         ohSGn+Dhxo7UY3bziZ7b6jHh3Bi6RX/AiIWbOVtwaRDWWm8XZNXfhWtqvzkcPN6mR+I0
         5FJ+dq3DQ7iEvHtpIqT7f3zGZ/qidJtbNPGOOqGGZfwcuT2IZ3WTkrROuP10911sxxk1
         usCN30Xy7rHof6xjS+1v8EetFiF2OXlg4FHmiabdgrQeEwZTvhdGHrKd9wKGiLs9t8lg
         0B8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738950487; x=1739555287;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vai7Qi/TzAJ2mZW/V+bMEmLyh545tl0+hKRUaxTdgTk=;
        b=ipITfZ6dweKzfDmXmcK6wdhps/4sIjMiESYTww1LrevhX5aP1id6Az6OFNFX8jb9il
         NgHNi4YSRL04ilzv12FjdYuz6bc/P/VziP98Wa7eHSkok6dXnF+Y9wpvpF8mR18XfgQz
         teQaTwLKjyCa2jPLx2euC+kfQ/Oh1HFX5LcH8tQ2tDMY+vlwJr5kBvacDufvJuwE5va/
         PlwZkzpKasOK+cfMcBvNrz4ZDUq7nbZc5LOsp6p5fLF6JPtcTRMQ/OpBWUESKyPmeRzh
         86NTIZb/9KOlAmL+i1Y1VllT1c5ngaqk6x3Q9dafTy1gWCychBcfs5+nvFEgBCcGarQU
         Jang==
X-Gm-Message-State: AOJu0YxohuV53NyxADri/5BFhL72uMGAqREav3bx5RFGGlQW4Mlj+wXE
	soAM0fkbqWf2qKgJCZdl0TRNTdYPDkcueg/8Kkj7S4kCb1UcnRiYeHy3xg==
X-Gm-Gg: ASbGncvqBO4+KlpwDpWJSRxo0KCb2YnUmxqmoC8x3la+BnGY2D0+9AKh0N26X6V3vob
	Vuwo2hEYDVewcuHc70FEL3Nyq+IacOuQ4Xq0nI2JZmeluslMdoJ0jl3jhn+IeXThXSnWCLTR8bK
	NRr4odx6EosIHTJovYK4IwZDEhrT1Mj2PaFO0I9OLZN83U4BzvGcJuO6kjI6euA5HUX6578WOku
	XX/tXxuorFySO2XcISbX2LgRbLmI276Dt5QjZl9a+CxSIcTOyAEZqsQK0y3WeW5RpYqQ+9Sb45a
	k1KQ+pcG
X-Google-Smtp-Source: AGHT+IFTnPL421TmdQsrO2D4LTI6O7Qvf2LqitcDVrQ/9hIdbt78DEQnEOjngERVksziHF6+gU70cQ==
X-Received: by 2002:a4a:ee0f:0:b0:5f2:c3de:f1a8 with SMTP id 006d021491bc7-5fc5e75e782mr2666732eaf.7.1738950487294;
        Fri, 07 Feb 2025 09:48:07 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 006d021491bc7-5fc545bc40esm866341eaf.29.2025.02.07.09.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 09:48:06 -0800 (PST)
Date: Fri, 7 Feb 2025 11:45:07 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] builtin/refs: add '--skip-reflog' flag to bypass reflog
 migration
Message-ID: <llz32al6tgghs73odbryc2324vks2pf3uyawp5dls5wgop7or2@bumahbjibtgz>
References: <20250207-477-refs-migrate-add-a-flag-to-ignore-reflogs-during-migration-v1-1-7d40f3b4e30b@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207-477-refs-migrate-add-a-flag-to-ignore-reflogs-during-migration-v1-1-7d40f3b4e30b@gmail.com>

On 25/02/07 12:57PM, Karthik Nayak wrote:
> The 'git-refs(1)' migrate subcommand, which transfers repositories
> between reference backends, currently migrates reflogs by default as of
> In 246cebe320 (refs: add support for migrating reflogs, 2024-12-16).

s/In 246cebe320/246cebe320/

> While this behavior is desirable for most client-side repositories,
> server-side repositories typically don't use reflogs and the migration
> of these entries is unnecessary overhead.
> 
> Add a '--skip-reflog' flag to the migrate subcommand to make reflog
> migration optional. This is particularly useful for server-side
> migrations where reflogs are not needed, improving migration performance
> in these scenarios.

Just to clarify, does a repository already without reflogs see improved
migration performance with this `--skip-reflog` flag? Or is the improved
performance soley due to repositories with reflogs skipping that part of
the migration?

> 
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
> ---
>  builtin/refs.c          |  3 +++
>  refs.c                  |  8 +++++---
>  refs.h                  |  5 ++++-
>  t/t1460-refs-migrate.sh | 17 +++++++++++++++--
>  4 files changed, 27 insertions(+), 6 deletions(-)
> 
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

When the `REPO_MIGRATE_REF_STORAGE_FORMAT_SKIP_REFLOG` flag is set, we
now skip over all the logs to perform the reflog migration. Makes sense.

-Justin

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
>  
>  /*
>   * Migrate the ref storage format used by the repository to the
> diff --git a/t/t1460-refs-migrate.sh b/t/t1460-refs-migrate.sh
> index a6d9b35a46eb59350aa0d59d982a2fbfaecf1448..9059d4c4121842a9d2e77dc4e54c537eeff8afab 100755
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
>  test_migration () {
>  	repo=$1 &&
>  	format=$2 &&
>  	skip_reflog_verify=${3:-false} &&
> +	shift $(( $# >= 3 ? 3 : 2 )) &&
>  	git -C "$repo" for-each-ref --include-root-refs \
>  		--format='%(refname) %(objectname) %(symref)' >expect &&
>  	if ! $skip_reflog_verify
> @@ -25,7 +27,7 @@ test_migration () {
>  	   git -C "$repo" reflog list >expect_log_list
>  	fi &&
>  
> -	git -C "$repo" refs migrate --ref-format="$2" &&
> +	git -C "$repo" refs migrate --ref-format="$format" $@ &&
>  
>  	git -C "$repo" for-each-ref --include-root-refs \
>  		--format='%(refname) %(objectname) %(symref)' >actual &&
> @@ -241,6 +243,17 @@ do
>  				test_cmp expect.reflog actual.reflog
>  			)
>  		'
> +
> +		test_expect_success "$from_format -> $to_format: skip reflog with --skip-reflog" '
> +			test_when_finished "rm -rf repo" &&
> +			git init --ref-format=$from_format repo &&
> +			test_commit -C repo initial &&
> +			# we see that the repository contains reflogs.
> +			test 2 = $(git -C repo reflog --all | wc -l) &&
> +			test_migration repo "$to_format" true --skip-reflog &&
> +			# there should be no reflogs post migration.
> +			test 0 = $(git -C repo reflog --all | wc -l)
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
> 
> 
