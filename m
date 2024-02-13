Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D46260B9D
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 22:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707863606; cv=none; b=ljzE6sTQF5lk3YZt6pz9YJhcyGin+a8NHy0zlvd5eZPqKWm+uJMZTbat42oC7px+hvRkYzmHNUXEw0ByNUlyEl3S2h5FLy8oRMUFRSPEb+Qloheg84UgmfupFPPIGwTrS2/L7UORUbuhHP2E/h2kMa1Ka4Oz7ieZ7d8O8i32U7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707863606; c=relaxed/simple;
	bh=jf9wbPvsNg0fvZq1Vw+5yHWRDMLMV6E30wJstRRwkEs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DO1N1n7GwZnnW6mGQ2mHWrCT881J3cZBgGlVeL3PmfwEYjyVBw/h348SEMIVva+EqX9mGMsGgjTi2sMOSFkNQBAvSsybHNIOeNR7Xc3NLZw5VWyL01abuOb3Y7Tki9dKBV2HEz7iqA/3onGKDV4HbzL3sQcuiDJWvYoS+aDP43g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bKkWVeCA; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bKkWVeCA"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-5c6245bc7caso4088782a12.3
        for <git@vger.kernel.org>; Tue, 13 Feb 2024 14:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707863603; x=1708468403; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=i2y1VXWn15H1SlqsXNi6/kFSefAEL64UN5lYSefY3T0=;
        b=bKkWVeCAcVa6GxMRzARabbJJ9u1VQlVl+PlAFZ0KnZRVIiiWQ27wHwQdWwfPBHDet5
         lNt88zYoz18v26Pzjqeov0k3qjkIsn+RfKXs6sQaOhNbS7n1JEuzBCNQolsxxJVNLhGr
         6M9tF76EQXeHpQ2i6ORFWoR3bSL6G5DaSRqMvKRmbouwaNid7QVmww+KG60LGU5CQhKT
         D250RdTqJnya/D4fnN/oWQCPwntrXMAA+9m3TEzkxCWQBfPCsVMunIoCkwOzPaufa4TJ
         wXSOt27ICjaVHJ5LF0MoHD1z6X5nndbx6bAAhBlrQu3bLWWfRPNBMjQcPx5RcC5Jk/cF
         pqiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707863603; x=1708468403;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i2y1VXWn15H1SlqsXNi6/kFSefAEL64UN5lYSefY3T0=;
        b=YTcr3bgMSmggBtrhpxZVPLsZUTl5m5++h78Bu62hu+BrSzGCEMejscD1PBVXEZd/xu
         meDvZnYvCIW1HAGpDGVGjbDjpTNPKIo3fuSvpPesajelTqnBIWNw9w0l7CPIo5w9B//3
         W+KALTmGsH+8BUB/pw2Y6R7Z1TE8r93YR0nB6WnclJxDdqGP/2K2a84jk1hc7qSTe4tK
         Ko4XG9Wa7YeF+59enB1QndMXkd2B+ONVnqiV+MpxHIhoiRNAx6nmaZFf/AXABRAjs+U0
         EZxUbHlW8yH7WgOg9t8JokR5iw1g+JvoONrizUCACAcG+1mSUB15bCOKIlGpmpSUT1B6
         NbvQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8tqNFMDdwyLYB9AtuX2s0SzPPaKkpB9qunOQONpl7myjNbR5UbNqU8LvRBmJ7iEuMgVhP9eptjTxXsfwkN35xLoHq
X-Gm-Message-State: AOJu0YwtOaZ3Xe8bfdTC3+9pKw8otqUx7ooNJVHedwVjDuU6se5j6YF3
	hseRP04Wjwyqb2G5tIU87IS1AeA9ghT1+K86Z8keAg6bsRIp/xAZ7c800JpbalFhXYqc1U0A5RP
	YXQ==
X-Google-Smtp-Source: AGHT+IFWqDxvNxlS0862h1E1iQPLrjYgFeYLvHUjnsdLB5FUVtVa140OTFhRj6ih1UwG2hJrgxMkluDlS6Y=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a05:6a02:197:b0:5dc:1560:8e8b with SMTP id
 bj23-20020a056a02019700b005dc15608e8bmr1519pgb.4.1707863603215; Tue, 13 Feb
 2024 14:33:23 -0800 (PST)
Date: Tue, 13 Feb 2024 14:33:21 -0800
In-Reply-To: <20240208135055.2705260-5-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240208135055.2705260-1-christian.couder@gmail.com> <20240208135055.2705260-5-christian.couder@gmail.com>
Message-ID: <owlyil2s9eq6.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v2 4/4] rev-list: allow missing tips with --missing=[print|allow*]
From: Linus Arver <linusa@google.com>
To: Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, John Cai <johncai86@gmail.com>, 
	Christian Couder <christian.couder@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"

Christian Couder <christian.couder@gmail.com> writes:

> In 9830926c7d (rev-list: add commit object support in `--missing`
> option, 2023-10-27) we fixed the `--missing` option in `git rev-list`
> so that it works with with missing commits, not just blobs/trees.
>
> Unfortunately, such a command would still fail with a "fatal: bad
> object <oid>" if it is passed a missing commit, blob or tree as an
> argument (before the rev walking even begins).
>
> When such a command is used to find the dependencies of some objects,
> for example the dependencies of quarantined objects (see the
> "QUARANTINE ENVIRONMENT" section in the git-receive-pack(1)
> documentation), it would be better if the command would instead
> consider such missing objects, especially commits, in the same way as
> other missing objects.

Looks good.

> If, for example `--missing=print` is used, it would be nice for some
> use cases if the missing tips passed as arguments were reported in
> the same way as other missing objects instead of the command just
> failing.

Nit: this paragraph sounds a bit redundant but it is giving an explicit
example of `--missing=print` which was not discussed so far, so I think
it's fine as is.

> We could introduce a new option to make it work like this, but most
> users are likely to prefer the command to have this behavior as the
> default one. Introducing a new option would require another dumb loop
> to look for that options early, which isn't nice.

s/options/option

> Also we made `git rev-list` work with missing commits very recently
> and the command is most often passed commits as arguments. So let's
> consider this as a bug fix related to these previous change.

s/previous change/recent changes

> While at it let's add a NEEDSWORK comment to say that we should get
> rid of the existing ugly dumb loops that parse the
> `--exclude-promisor-objects` and `--missing=...` options early.
>
> Helped-by: Linus Arver <linusa@google.com>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  Documentation/rev-list-options.txt |  4 +++
>  builtin/rev-list.c                 | 15 +++++++-
>  revision.c                         | 14 ++++++--
>  t/t6022-rev-list-missing.sh        | 56 ++++++++++++++++++++++++++++++
>  4 files changed, 85 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
> index a583b52c61..bb753b6292 100644
> --- a/Documentation/rev-list-options.txt
> +++ b/Documentation/rev-list-options.txt
> @@ -1019,6 +1019,10 @@ Unexpected missing objects will raise an error.
>  +
>  The form '--missing=print' is like 'allow-any', but will also print a
>  list of the missing objects.  Object IDs are prefixed with a ``?'' character.
> ++
> +If some tips passed to the traversal are missing, they will be
> +considered as missing too, and the traversal will ignore them. In case
> +we cannot get their Object ID though, an error will be raised.

The only other mention of the term "tips" is for the "--alternate-refs"
flag on line 215 which uses "ref tips". Perhaps this is obvious to
veteran Git developers but I do wonder if we need to somehow define it
(however briefly) the first time we mention it (either in the document
as a whole, or just within this newly added paragraph).

Here's an alternate wording

    Ref tips given on the command line are a special case. They are
    first dereferenced to Object IDs (if this is not possible, an error
    will be raised). Then these IDs are checked to see if the objects
    they refer to exist. If so, the traversal happens starting with
    these tips. Otherwise, then such tips will not be used for
    traversal.

    Even though such missing tips won't be included for traversal, for
    purposes of the `--missing` flag they will be treated the same way
    as those objects that did get traversed (and were determined to be
    missing). For example, if `--missing=print` is given then the Object
    IDs of these tips will be printed just like all other missing
    objects encountered during traversal.

But also, I realize that these documentation touch-ups might be better
served by an overall pass over the whole document, so it's fine if we
decide not to take this suggestion at this time.

Aside: unfortunately we don't seem to define the relationship between
ref tips (e.g., "HEAD"), object IDs (40-char hex string), and the actual
objects (the real data that we traverse over). It's probably another
thing that could be fixed up in the docs in the future.

>  --exclude-promisor-objects::
>  	(For internal use only.)  Prefilter object traversal at
> diff --git a/builtin/rev-list.c b/builtin/rev-list.c
> index b3f4783858..ec9556f135 100644
> --- a/builtin/rev-list.c
> +++ b/builtin/rev-list.c
> @@ -545,6 +545,15 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
>  	 *
>  	 * Let "--missing" to conditionally set fetch_if_missing.
>  	 */
> +	/*
> +	 * NEEDSWORK: These dump loops to look for some options early
> +	 * are ugly.

I agree with Junio's suggestion to use more objective language.

> We really need setup_revisions() to have a
> +	 * mechanism to allow and disallow some sets of options for
> +	 * different commands (like rev-list, replay, etc). Such

s/Such/Such a

> +	 * mechanism should do an early parsing of option and be able

s/option/options

> +	 * to manage the `--exclude-promisor-objects` and `--missing=...`
> +	 * options below.
> +	 */
>  	for (i = 1; i < argc; i++) {
>  		const char *arg = argv[i];
>  		if (!strcmp(arg, "--exclude-promisor-objects")) {
> 
> [...]
> 
> @@ -2178,13 +2183,18 @@ static int handle_revision_arg_1(const char *arg_, struct rev_info *revs, int fl
>  	if (revarg_opt & REVARG_COMMITTISH)
>  		get_sha1_flags |= GET_OID_COMMITTISH;
>  
> +	/*
> +	 * Even if revs->do_not_die_on_missing_objects is set, we
> +	 * should error out if we can't even get an oid, ...
> +	 */

Perhaps this wording is more precise?

    If we can't even get an oid, we are forced to error out (regardless
    of revs->do_not_die_on_missing_objects) because a valid traversal
    must start from *some* valid oid. OTOH we ignore the ref tip
    altogether with revs->ignore_missing.

> +	 * ... as
> +	 * `--missing=print` should be able to report missing oids.

I think this comment would be better placed ...

>  	if (get_oid_with_context(revs->repo, arg, get_sha1_flags, &oid, &oc))
>  		return revs->ignore_missing ? 0 : -1;
>  	if (!cant_be_filename)
>  		verify_non_filename(revs->prefix, arg);
>  	object = get_reference(revs, arg, &oid, flags ^ local_flags);

... around here.

>  	if (!object)
> -		return revs->ignore_missing ? 0 : -1;
> +		return (revs->ignore_missing || revs->do_not_die_on_missing_objects) ? 0 : -1;
>  	add_rev_cmdline(revs, object, arg_, REV_CMD_REV, flags ^ local_flags);
>  	add_pending_object_with_path(revs, object, arg, oc.mode, oc.path);
>  	free(oc.path);
> @@ -3830,8 +3840,6 @@ int prepare_revision_walk(struct rev_info *revs)
>  				       FOR_EACH_OBJECT_PROMISOR_ONLY);
>  	}
>  
> -	oidset_init(&revs->missing_commits, 0);
> -
>  	if (!revs->reflog_info)
>  		prepare_to_use_bloom_filter(revs);
>  	if (!revs->unsorted_input)
> diff --git a/t/t6022-rev-list-missing.sh b/t/t6022-rev-list-missing.sh
> index 5f1be7abb5..78387eebb3 100755
> --- a/t/t6022-rev-list-missing.sh
> +++ b/t/t6022-rev-list-missing.sh
> @@ -78,4 +78,60 @@ do
>  	done
>  done
>  
> +for missing_tip in "HEAD~1" "HEAD~1^{tree}" "HEAD:1.t"
> +do
> +	# We want to check that things work when both
> +	#   - all the tips passed are missing (case existing_tip = ""), and
> +	#   - there is one missing tip and one existing tip (case existing_tip = "HEAD")
> +	for existing_tip in "" "HEAD"
> +	do

Though I am biased, these new variable names do make this test that much
easier to read. Thanks.
