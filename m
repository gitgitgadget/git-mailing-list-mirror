Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5846E2BD5A8
	for <git@vger.kernel.org>; Tue, 26 Aug 2025 16:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756225315; cv=none; b=R3hIqNt1zEFQQ+sAB+O+L1HHpWakbUXFQYMxtVPzk4SAfDvd1e1Iyv/jUcaJr3oJOlAAW3iNjwWSaYYd5q7k4vEsqHn03fwPHp81/TZnBi0/8Og0z4cWLtlpZ6ksuEvBatOs4sPHSU9LWf2DUJGFwmzUnQ5GHEldctvBo8BuCUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756225315; c=relaxed/simple;
	bh=4sIJNhsQmDZCmsHADGvG3RZMhWG4tf2uEvn8P+bRGgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nYM+zFjoGqHzrnGUMTuIjMQwuhJ6F7/SDAqtlZmR7PzvkBGxleOCEnCaJYZ4BCNHVqPI4loOon6MB9CQ8zrI/C2llsf//VVy41+OhgerYoNNPiNrJONZRhf1wCDjhUV5wn7BbcRUCnw1PxvknKaRRYwVC9qER+AEXebFnYJ2WAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H5cI9dGm; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H5cI9dGm"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-325393d0dd8so2889258a91.0
        for <git@vger.kernel.org>; Tue, 26 Aug 2025 09:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756225312; x=1756830112; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=shtnDgiIMPvxXe6GGtyUtv0o2n5+nD2Zb7Z9pxXhcS0=;
        b=H5cI9dGm2bBbG73tGBx5G8N47YuBfZjALZHey4OrPxX2xfVFKDgyjXLv1vqcppzC0K
         Wkm5hgdsKJ19QTylTt3SlZzTLvXSrDspgWkR8z7Gw9XdWtU3yNLazXojSreHENko/4VZ
         LrdCB3Wju4drUupKwjdYhX5vL7vcjbFzy3+034x5sx90IFKGEQRDy4H+IEsdW6ggXeD5
         bZI0kyeh5SpAe/Avb1dcW49eYKp9J7/n4iDNDxa4ycpf0I81EJ+gJPLKU3sPwb+qa2Bd
         Kmd81bSX6FnLGzKIG0099/OXuKwzPXm6hFVz2HQQttwlpd/6KClDLCzLi8LYzA3R8/tw
         pfrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756225312; x=1756830112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=shtnDgiIMPvxXe6GGtyUtv0o2n5+nD2Zb7Z9pxXhcS0=;
        b=alZ82ayNlk11jVgogXycOtuFYd42PBjUunc9ThSfUxtCpDR9gE7bH9VUg6WHl49fRh
         cmNZRKaab5/H7U94qes0YnByd27GaHpIsMP8IB1vnNY6EWWnuyVXFamdRo8kJdDX7EHn
         5LhBLFlDzLX8WR4I9W3/+71JI9kZIS3Bxock7XvvZmmqU+lqJl5ShIX4wznTBqaZCULQ
         nbyEgYVuxY2c59Kv32cfg/duAUPo13rL78x8ZWSUN05Z3xZqbbPPYoNA/7XQxdQJJYNT
         6+lVbd79cBFNOmopNHaLdXsHXrNLSUiOwXQc6Jf9jgZVmsHvKTUb8tbhlsG/UTa2HWoi
         bVXA==
X-Gm-Message-State: AOJu0YzhKWR1X0ncpHktqSwqHH+Zd4pHlRLvpobopgRX/iZgea3Uddzs
	VqKElqDJkj3ZX9oXHqPXFv4v+OgFBAlG/9MeCMssNmS3PPSglNzPPjh8WCplKw==
X-Gm-Gg: ASbGnctQROkVufifH2B1+viRmX8DtQ6mEvZbxbIbotYoclzHBleXILUV+yo3yUGNGkG
	Otf45xdF8/bkSAAtkTS0xtlJ3OMs/fvxNC64SlqJ8Y5JyD3x0X+4fHaLuukklbeCL78OaWhupOg
	TGDT9TLJmX0PReEpEAa9akSFeclz3MLVzp7LGhIpaBOErzc3dHQAsdTZ7V5Jgu20Z+BXrWShVL+
	OA3r7ZvAG4T3//+fbuB883nz6EOHCyFI8ZdSrhzr+2Wr3OrOSiAr6wxyY0xmXThAfuJ4OfS/cVL
	5paTL0lM+/Xn6u3kZd/XXJkNDk4vWB+h4Voebs8w+2n9KMQK9uOYvkMzGNqtDgtUwbRrzykEa08
	SicBdO44BUuK0bC6jRAYNnQZtHukcGla94uJX5FU=
X-Google-Smtp-Source: AGHT+IHFa8tMe4X279JlNFG4zeJ2mmpIxGUgg9GuUmIZRbFBq6v/0giHh7Lk+cKMiOMSYyRxn7wuGg==
X-Received: by 2002:a17:90a:d60d:b0:31e:3d06:739c with SMTP id 98e67ed59e1d1-32517d1988fmr20378112a91.31.1756225312286;
        Tue, 26 Aug 2025 09:21:52 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b49dc2b82ecsm6797551a12.12.2025.08.26.09.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 09:21:51 -0700 (PDT)
Date: Wed, 27 Aug 2025 00:21:49 +0800
From: shejialuo <shejialuo@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/5] refs/reftable: add fsck check for checking the table
 name
Message-ID: <aK3fHRMFiRBYNiJE@ArchLinux>
References: <20250819-228-reftable-introduce-consistency-checks-v1-0-8b8f6879fa9e@gmail.com>
 <20250819-228-reftable-introduce-consistency-checks-v1-2-8b8f6879fa9e@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819-228-reftable-introduce-consistency-checks-v1-2-8b8f6879fa9e@gmail.com>

On Tue, Aug 19, 2025 at 02:21:01PM +0200, Karthik Nayak wrote:
> The `git refs verify` command is used to run fsck checks on the
> reference backends. This command is also invoked when users run 'git
> fsck'. While the files-backend has some fsck checks added, the reftable
> backend lacks such checks. Let's add the required infrastructure and a
> check to test for the table names in the 'tables.list' of reftables.
> 
> For the infrastructure, since the reftable library is treated as an
> independent library we should ensure that the library code works
> independently without knowledge about Git's internals. To do this,
> add both 'reftable/fsck.c' and 'reftable/reftable-fsck.h'. Which

A design question here, we name the "fsck.c" for the source code but for
the header, we use "reftable-fsck.h", it is a little strange. Why not
just "fsck.h" instead of "reftable-fsck.h".

> provide an entry point 'reftable_fsck_check' for running fsck checks
> over a provided reftable stack. The callee provides the function with
> callbacks to handle issue and information reporting.
> 
> Add glue code in 'refs/reftable-backend.c' which calls the reftable
> library to perform the fsck checks. Here we also map the reftable errors
> to Git' fsck errors.
> 
> Introduce a check to validate table names for a given reftable stack.
> Also add 'badReftableTableName' as a corresponding error within Git. Add
> a test to check for this behavior.
> 
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  Documentation/fsck-msgids.adoc |  3 +++
>  Makefile                       |  1 +
>  fsck.h                         |  1 +
>  meson.build                    |  1 +
>  refs/reftable-backend.c        | 61 +++++++++++++++++++++++++++++++++++++-----
>  reftable/fsck.c                | 50 ++++++++++++++++++++++++++++++++++
>  reftable/reftable-fsck.h       | 38 ++++++++++++++++++++++++++
>  t/meson.build                  |  3 ++-
>  t/t0614-reftable-fsck.sh       | 35 ++++++++++++++++++++++++
>  9 files changed, 186 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/fsck-msgids.adoc b/Documentation/fsck-msgids.adoc
> index 1c912615f9..784ddc0df5 100644
> --- a/Documentation/fsck-msgids.adoc
> +++ b/Documentation/fsck-msgids.adoc
> @@ -38,6 +38,9 @@
>  `badReferentName`::
>  	(ERROR) The referent name of a symref is invalid.
>  
> +`badReftableTableName`::
> +	(ERROR) A reftable table has an invalid name.
> +

When reading this, I feel a little strange. `Reftable` already indicates
it is a table. Should we simply say like the following:

    A reftable has an invalid table name

>  `badTagName`::
>  	(INFO) A tag has an invalid format.
>  
> diff --git a/Makefile b/Makefile
> index e11340c1ae..f2ddcc8d7c 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2733,6 +2733,7 @@ REFTABLE_OBJS += reftable/error.o
>  REFTABLE_OBJS += reftable/block.o
>  REFTABLE_OBJS += reftable/blocksource.o
>  REFTABLE_OBJS += reftable/iter.o
> +REFTABLE_OBJS += reftable/fsck.o
>  REFTABLE_OBJS += reftable/merged.o
>  REFTABLE_OBJS += reftable/pq.o
>  REFTABLE_OBJS += reftable/record.o
> diff --git a/fsck.h b/fsck.h
> index 559ad57807..5901f944a1 100644
> --- a/fsck.h
> +++ b/fsck.h
> @@ -34,6 +34,7 @@ enum fsck_msg_type {
>  	FUNC(BAD_PACKED_REF_HEADER, ERROR)                         \
>  	FUNC(BAD_PARENT_SHA1, ERROR)                               \
>  	FUNC(BAD_REFERENT_NAME, ERROR)                             \
> +	FUNC(BAD_REFTABLE_TABLE_NAME, ERROR)                       \
>  	FUNC(BAD_REF_CONTENT, ERROR)                               \
>  	FUNC(BAD_REF_FILETYPE, ERROR)                              \
>  	FUNC(BAD_REF_NAME, ERROR)                                  \
> diff --git a/meson.build b/meson.build
> index 5dd299b496..82879fbfaa 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -452,6 +452,7 @@ libgit_sources = [
>    'reftable/error.c',
>    'reftable/block.c',
>    'reftable/blocksource.c',
> +  'reftable/fsck.c',
>    'reftable/iter.c',
>    'reftable/merged.c',
>    'reftable/pq.c',
> diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
> index 8dae1e1112..ccd12052f2 100644
> --- a/refs/reftable-backend.c
> +++ b/refs/reftable-backend.c
> @@ -6,20 +6,21 @@
>  #include "../config.h"
>  #include "../dir.h"
>  #include "../environment.h"
> +#include "../fsck.h"
>  #include "../gettext.h"
>  #include "../hash.h"
>  #include "../hex.h"
>  #include "../iterator.h"
>  #include "../ident.h"
> -#include "../lockfile.h"

Here, we delete this header file. Is the reason that we don't need this
header file anymore?

>  #include "../object.h"
>  #include "../path.h"
>  #include "../refs.h"
>  #include "../reftable/reftable-basics.h"
> -#include "../reftable/reftable-stack.h"
> -#include "../reftable/reftable-record.h"
>  #include "../reftable/reftable-error.h"
> +#include "../reftable/reftable-fsck.h"
>  #include "../reftable/reftable-iterator.h"
> +#include "../reftable/reftable-record.h"
> +#include "../reftable/reftable-stack.h"
>  #include "../repo-settings.h"
>  #include "../setup.h"
>  #include "../strmap.h"
> @@ -2675,11 +2676,59 @@ static int reftable_be_reflog_expire(struct ref_store *ref_store,
>  	return ret;
>  }
>  
> -static int reftable_be_fsck(struct ref_store *ref_store UNUSED,
> -			    struct fsck_options *o UNUSED,
> +static void reftable_fsck_verbose_handler(const char *msg, void *cb_data)
> +{
> +	struct fsck_options *o = cb_data;
> +
> +	if (o->verbose)
> +		fprintf_ln(stderr, "%s", _(msg));
> +}
> +
> +static int reftable_fsck_error_handler(struct reftable_fsck_info info,

A design question: why do we need to pass the value "info" instead of
pointer?

> +				       void *cb_data)
> +{
> +	struct fsck_options *o = cb_data;
> +	struct fsck_ref_report report = { .path = info.path };

Let's make it reverse-christmas-tree ordering.

> +	enum fsck_msg_id msg_id;
> +
> +	switch (info.error) {
> +	case REFTABLE_FSCK_ERROR_TABLE_NAME:
> +		msg_id = FSCK_MSG_BAD_REFTABLE_TABLE_NAME;
> +		break;
> +	default:
> +		BUG("unknown fsck error: %d", info.error);
> +	}
> +
> +	return fsck_report_ref(o, &report, msg_id, "%s", info.msg);
> +}
> +
> +static int reftable_be_fsck(struct ref_store *ref_store, struct fsck_options *o,
>  			    struct worktree *wt UNUSED)
>  {
> -	return 0;
> +	struct reftable_ref_store *refs;
> +	struct strmap_entry *entry;
> +	struct hashmap_iter iter;
> +	int ret = 0;
> +
> +	refs = reftable_be_downcast(ref_store, REF_STORE_READ, "fsck");
> +
> +	if (o->verbose)
> +		fprintf_ln(stderr, _("Checking references consistency"));
> +
> +	ret = reftable_fsck_check(refs->main_backend.stack, reftable_fsck_error_handler,
> +				  reftable_fsck_verbose_handler, o);
> +	if (!ret)
> +		return ret;
> +

From my understanding, if we find that there is any trouble in the main
worktree reftable backend, we would just abort the check. Should we
continue to check the linked worktrees?

> +	strmap_for_each_entry(&refs->worktree_backends, &iter, entry) {
> +		struct reftable_backend *b = (struct reftable_backend *)entry->value;
> +		ret = reftable_fsck_check(b->stack, reftable_fsck_error_handler,
> +					  reftable_fsck_verbose_handler, o);
> +		if (!ret)
> +			return ret;
> +	}
> +
> +	return ret;
>  }
>  
>  struct ref_storage_be refs_be_reftable = {
> diff --git a/reftable/fsck.c b/reftable/fsck.c
> new file mode 100644
> index 0000000000..22ec3c26e9
> --- /dev/null
> +++ b/reftable/fsck.c
> @@ -0,0 +1,50 @@
> +#include "basics.h"
> +#include "reftable-fsck.h"
> +#include "stack.h"
> +
> +int reftable_fsck_check(struct reftable_stack *stack,
> +			reftable_fsck_report_fn report_fn,
> +			reftable_fsck_verbose_fn verbose_fn,
> +			void *cb_data)
> +{
> +	char **names = NULL;
> +	uint64_t min, max;
> +	int err = 0;
> +
> +	if (stack == NULL)
> +		goto out;
> +
> +	err = read_lines(stack->list_file, &names);
> +	if (err < 0)
> +		goto out;
> +
> +	verbose_fn("Checking reftable table names", cb_data);
> +
> +	for (size_t i = 0; names[i]; i++) {
> +		struct reftable_fsck_info info = {
> +			.error = REFTABLE_FSCK_ERROR_TABLE_NAME,
> +			.path = names[i],
> +			.msg = "invalid reftable name"
> +		};

Should we define this data structure outside of the loop? It's
unnecessary here as we could change ".path" and ".msg" dynamically in
the loop.

> +		uint32_t rnd;
> +		/*
> +		 * We want to match the tail '.ref'. One extra byte to ensure
> +		 * that there is no unexpected extra character and one byte for
> +		 * the null terminator added by sscanf.
> +		 */
> +		char tail[6];
> +
> +		if (sscanf(names[i], "0x%012" PRIx64 "-0x%012" PRIx64 "-%08x%5s",
> +			   &min, &max, &rnd, tail) != 4) {
> +			err = report_fn(info, cb_data);

I think we could just pass pointer to avoid unnecessary copy operations.
Besides that, I think here we report two different kinds of problem. But
we would give report the user always the same message `invalid reftable
name`. This is too vague.

I think we'd better set different messages for different problems.

> +		}
> +
> +		if (strcmp(tail, ".ref")) {
> +			err = report_fn(info, cb_data);
> +		}
> +	}
> +
> +out:
> +	free_names(names);
> +	return err;
> +}
> diff --git a/reftable/reftable-fsck.h b/reftable/reftable-fsck.h
> new file mode 100644
> index 0000000000..087430d979
> --- /dev/null
> +++ b/reftable/reftable-fsck.h
> @@ -0,0 +1,38 @@
> +#ifndef REFTABLE_FSCK_H
> +#define REFTABLE_FSCK_H
> +
> +#include "reftable-stack.h"
> +
> +enum reftable_fsck_error {
> +	/* Invalid table name */
> +	REFTABLE_FSCK_ERROR_TABLE_NAME = -1,
> +};
> +
> +/* Represents an individual error encounctered during the FSCK checks. */
> +struct reftable_fsck_info {
> +	enum reftable_fsck_error error;
> +	const char *msg;
> +	const char *path;
> +};
> +
> +typedef int reftable_fsck_report_fn(struct reftable_fsck_info info,
> +				    void *cb_data);

As I have explained above, we should use `struct reftable_fsck_info
*info` instead of `struct reftable_fsck_info info`.

> +typedef void reftable_fsck_verbose_fn(const char *msg, void *cb_data);
> +
> +/*
> + * Given a reftable stack, perform FSCK check on the stack.
> + *
> + * If an issue is encountered, the issue is reported to the callee via the
> + * provided 'report_fn'. If the issue is non-recoverable the flow will not
> + * conitnue. If it is recoverable, the flow will continue and further issues
> + * will be reported as identified.
> + *
> + * The 'verbose_fn' will be invoked to provide verbose information about
> + * the progress and state of the FSCK checks.
> + */
> +int reftable_fsck_check(struct reftable_stack *stack,
> +			reftable_fsck_report_fn report_fn,
> +			reftable_fsck_verbose_fn verbose_fn,
> +			void *cb_data);
> +
> +#endif /* REFTABLE_FSCK_H */
> diff --git a/t/meson.build b/t/meson.build
> index bbeba1a8d5..a8eb44eb30 100644
> --- a/t/meson.build
> +++ b/t/meson.build
> @@ -145,6 +145,7 @@ integration_tests = [
>    't0611-reftable-httpd.sh',
>    't0612-reftable-jgit-compatibility.sh',
>    't0613-reftable-write-options.sh',
> +  't0614-reftable-fsck.sh',
>    't1000-read-tree-m-3way.sh',
>    't1001-read-tree-m-2way.sh',
>    't1002-read-tree-m-u-2way.sh',
> @@ -1214,4 +1215,4 @@ if perl.found() and time.found()
>        timeout: 0,
>      )
>    endforeach
> -endif
> \ No newline at end of file
> +endif
> diff --git a/t/t0614-reftable-fsck.sh b/t/t0614-reftable-fsck.sh
> new file mode 100755
> index 0000000000..0d11871b1c
> --- /dev/null
> +++ b/t/t0614-reftable-fsck.sh
> @@ -0,0 +1,35 @@
> +#!/bin/sh
> +
> +test_description='Test reftable backend consistency check'
> +
> +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
> +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> +GIT_TEST_DEFAULT_REF_FORMAT=reftable
> +export GIT_TEST_DEFAULT_REF_FORMAT
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'table name should be checked' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		git commit --allow-empty -m initial &&
> +
> +		git refs verify 2>err &&
> +		test_must_be_empty err &&
> +
> +		TABLE_NAME=$(cat .git/reftable/tables.list | head -n1) &&
> +		sed "1s/$/extra/" .git/reftable/tables.list >.git/reftable/tables.list.tmp &&
> +		mv .git/reftable/tables.list.tmp .git/reftable/tables.list &&
> +		mv .git/reftable/${TABLE_NAME} .git/reftable/${TABLE_NAME}extra &&
> +
> +		test_must_fail git refs verify 2>err &&
> +		cat >expect <<-EOF &&
> +		error: ${TABLE_NAME}extra: badReftableTableName: invalid reftable name
> +		EOF
> +		test_cmp expect err
> +	)
> +'

We would check two kinds of errors, should we add two tests instead of
only this one.

> +
> +test_done
> 
> -- 
> 2.50.1
> 

Thanks,
Jialuo
