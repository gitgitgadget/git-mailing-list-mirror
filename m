Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A25F2EA468
	for <git@vger.kernel.org>; Wed,  3 Sep 2025 08:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756886843; cv=none; b=ctK06Cf6o9ab+fckb3wpVkHaR1nd+uL63f0S7FTQrkk7/Fz3R988P0hcNwu4meYx5u1ixX2tPRxHAt6v32xM1fs9+8A/2N0i98C8sDz234lYOyDupaSzsUGTf2XMpUbVCzH1l7VgpCQc3vxLDt45+i8OI6HtMcpI7/FTwrnFhOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756886843; c=relaxed/simple;
	bh=5CWKYCADi8/rwGk/w0O8Z5ETo9HB7xFSvDdq3rIAi5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S8r3aStNOEhV1fjmWRC9IUJhQM9mEef6wDQb302jUDKAMx2TatnBGnRp+5xeFsTZpOskvryAlBOcFrP6ezbig+snUdERkjUjU8JqcbWODG1mz1eGbj45Pw6QXUvwgdnsN5H7/po+evX11anPJrEcefZxy3w9Ik1UYCNmYxkapqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eQTTnOqk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R8n03A5v; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eQTTnOqk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R8n03A5v"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 7B4EBEC037E;
	Wed,  3 Sep 2025 04:07:20 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 03 Sep 2025 04:07:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1756886840; x=1756973240; bh=kzdzTSifAV
	3KESPyi/TIACZwvHS00rcVypqPYRONZZA=; b=eQTTnOqkSVZGCH2fHmGV8B3LkN
	xQxNOGgzzB+t6vjVlyZVc2zmNHl/9RiSwVxplkJ9znntrVjOZXiY+owUl8gPLAiw
	AXte1v87UTvwLgGpAQJiQC5uen+zwetX5+1yT/QPWX8BHzx0EKF2A81WbaD2L1SU
	BW3kM9Q0GDkp6dHNzJTlPsqxXyrCPNCce8hO2beK9F567nHmmilP4Qn7PNW/WU10
	63yetfSquHmjw7BCUY3TlHArUsyzAxbpJOsB8aAwFIm0qWqiwqZdm7VWikmgoWu1
	OU/CfBVX2dqk5+EwxqqyPmxBrBlHNW3znO0Gi/zEF03zUCI6ojaBJ5+MGGYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756886840; x=1756973240; bh=kzdzTSifAV3KESPyi/TIACZwvHS00rcVypq
	PYRONZZA=; b=R8n03A5vlonbYaqsmuIDvSkloCM0J3I7rwteO2NIRRLoM1FNoMf
	r+RUqutpCl9SjEjPROcZ7fJGkj4xU9+3U0gtyVQMfog7q5wKYadqSFA/1T9uizNg
	xYHk00ZO4Sz5t4/iIPbSroJR2Yi3K31Uw1ek3CpPbjZCJYKIMH8rOqn6YO1weRZJ
	RtWMMCFDesMdQe3WZyGWiqPHBxLFxPK0apg7IIcPYuioQ9LP+sY3B7quPKnIpwU7
	50uQyi2rt2HbjPiyOPxv/z2wzuCeO4N4BZ3Il9F1gdDkP3LV/o1pvnFSRy/fM5Pn
	+NcIvvMGnq4QG60r4ofVQ7fjWH9UuAJ3SAw==
X-ME-Sender: <xms:OPe3aHq3bOLuNzTPezhieAVGowAaVEuWMkPJ84nY7C_Hyhl-fi0pMQ>
    <xme:OPe3aMPIg3N_EE-2Ci6rsVZFlVzjGdSce_EELGsq1722u9071IeHD9SlMzb6KNLai
    yR_xdYkkBkI_JWvvg>
X-ME-Received: <xmr:OPe3aAy7X5xE3FJAhqe_zectbyOI_fBsQTYgTulfeAXi7pOy57Bpu0UZiAhO9DksAm3Mz48KwTFKS-FPqHMVma2qEbBWtlyN_TuKb10>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddviedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepve
    ekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    khgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehjlhhtohgslh
    gvrhesghhmrghilhdrtghomhdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:OPe3aNuhIBv_uDVtDOGGHi9dbn_bivSLwFzNwvMrSe0Nsp8MsbfNRA>
    <xmx:OPe3aB76yUyYhJzsq829125IStv53RIuiVWaL2ZqraTx1Yn55aSPtQ>
    <xmx:OPe3aESGSUj8F9QXt51lUDFBqAD1vyjZ4q-7gwWc38El8AZBv4c-DA>
    <xmx:OPe3aIopzK9tmtFYBII0DJgKIdvMsBrlMNUVzjzumLje-DOTMjF0Jw>
    <xmx:OPe3aGfLVkcFppYSe34nOqYS7tuAHW4ag1OZp3Eq3FgHoCeYMYELEXhO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Sep 2025 04:07:19 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a78c2089 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 3 Sep 2025 08:07:16 +0000 (UTC)
Date: Wed, 3 Sep 2025 10:07:13 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, jltobler@gmail.com, shejialuo@gmail.com
Subject: Re: [PATCH v2 2/5] refs/reftable: add fsck check for checking the
 table name
Message-ID: <aLf3MaKHZSQfnBlT@pks.im>
References: <20250902-228-reftable-introduce-consistency-checks-v2-0-4f96b3834779@gmail.com>
 <20250902-228-reftable-introduce-consistency-checks-v2-2-4f96b3834779@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902-228-reftable-introduce-consistency-checks-v2-2-4f96b3834779@gmail.com>

On Tue, Sep 02, 2025 at 09:05:22AM +0200, Karthik Nayak wrote:
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
> While here, remove a unused header `#include "../lockfile.h"` from
> 'refs/reftable-backend.c'.

It's quite a bunch of changes overall that could've been reasonably
split up into multiple commits. E.g. one to introduce the reftable-side
logic, one to start calling it in Git, and one to drop the superfluous
header.

> diff --git a/Makefile b/Makefile
> index e11340c1ae..f2ddcc8d7c 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2733,6 +2733,7 @@ REFTABLE_OBJS += reftable/error.o
>  REFTABLE_OBJS += reftable/block.o
>  REFTABLE_OBJS += reftable/blocksource.o
>  REFTABLE_OBJS += reftable/iter.o
> +REFTABLE_OBJS += reftable/fsck.o

"f" is before "i" in the alphabet I'm accustomed to :) So let's retain
lexicographic ordering here.

> diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
> index 8dae1e1112..c38c6422f8 100644
> --- a/refs/reftable-backend.c
> +++ b/refs/reftable-backend.c
> @@ -2675,11 +2676,55 @@ static int reftable_be_reflog_expire(struct ref_store *ref_store,
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

Is this `_()` marker correct here? There isn't really any reasonable way
for somebody to translate a variable with unknown contents. So shouldn't
it only be the caller of `reftable_fsck_verbose_handler()` that should
mark the string as translatable?

> +static int reftable_fsck_error_handler(struct reftable_fsck_info *info,
> +				       void *cb_data)
> +{
> +	struct fsck_ref_report report = { .path = info->path };
> +	struct fsck_options *o = cb_data;
> +	enum fsck_msg_id msg_id;
> +
> +	switch (info->error) {
> +	case REFTABLE_FSCK_ERROR_TABLE_NAME:
> +		msg_id = FSCK_MSG_BAD_REFTABLE_TABLE_NAME;
> +		break;
> +	default:
> +		BUG("unknown fsck error: %d", info->error);
> +	}
> +
> +	return fsck_report_ref(o, &report, msg_id, "%s", info->msg);
> +}

I think this function will become a bit unwieldy over time. We might
instead want to have an array that maps from reftable-specific to
fsck-specific error code:

    static const fsck_msg_id[] = {
        [REFTABLE_FSCK_ERROR_TABLE_NAME] = FSCK_MSG_BAD_REFTABLE_TABLE_NAME,
    };

So in that case, all we'd have to do is to perform bounds checking in
the above function. And maybe verify that the developer didn't forget to
fill in a new msg ID by checking that the derived message ID is non-zero.

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

This line is duplicate across both backends, right? Maybe it's something
that we can do in the generic logic?

> +	ret |= reftable_fsck_check(refs->main_backend.stack, reftable_fsck_error_handler,
> +				  reftable_fsck_verbose_handler, o);
> +
> +	strmap_for_each_entry(&refs->worktree_backends, &iter, entry) {
> +		struct reftable_backend *b = (struct reftable_backend *)entry->value;
> +		ret |= reftable_fsck_check(b->stack, reftable_fsck_error_handler,
> +					  reftable_fsck_verbose_handler, o);
> +	}
> +
> +	return ret;
>  }
>  
>  struct ref_storage_be refs_be_reftable = {

Looks good.

> diff --git a/reftable/fsck.c b/reftable/fsck.c
> new file mode 100644
> index 0000000000..4282b1413e
> --- /dev/null
> +++ b/reftable/fsck.c
> @@ -0,0 +1,53 @@
> +#include "basics.h"
> +#include "reftable-fsck.h"
> +#include "stack.h"
> +
> +int reftable_fsck_check(struct reftable_stack *stack,
> +			reftable_fsck_report_fn report_fn,
> +			reftable_fsck_verbose_fn verbose_fn,
> +			void *cb_data)
> +{
> +
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
> +		};
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
> +			info.msg = "invalid reftable table name";

This here is where the string should be translated.

> +			err = report_fn(&info, cb_data);
> +			continue;
> +		}

I think sscanf is quite frowned-upon in the Git codebase. Maybe we
should manually parse through the string instead?

Furthermore, I think we should move every single check into a separate
function, similar to how the files backend does it. This ensures that
checks are self-contained and that it's way easier to add new checks
over time.

Another angle: did you verify that reftables written by JGit follow this
format?

> +		if (strcmp(tail, ".ref")) {
> +			info.msg = "invalid reftable table extension";

Same here, this should be translated.

> diff --git a/reftable/reftable-fsck.h b/reftable/reftable-fsck.h
> new file mode 100644
> index 0000000000..4cf0053234
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

Wouldn't it be more natural to give these positive numbers?

> +/* Represents an individual error encountered during the FSCK checks. */
> +struct reftable_fsck_info {
> +	enum reftable_fsck_error error;
> +	const char *msg;
> +	const char *path;
> +};

I wonder whether it should be the reftable library that decides on the
severity of each generated finding.

> +typedef int reftable_fsck_report_fn(struct reftable_fsck_info *info,
> +				    void *cb_data);
> +typedef void reftable_fsck_verbose_fn(const char *msg, void *cb_data);
> +
> +/*
> + * Given a reftable stack, perform FSCK check on the stack.

s/FSCK check/consistency checks/

> + *
> + * If an issue is encountered, the issue is reported to the callee via the
> + * provided 'report_fn'. If the issue is non-recoverable the flow will not
> + * continue. If it is recoverable, the flow will continue and further issues
> + * will be reported as identified.
> + *
> + * The 'verbose_fn' will be invoked to provide verbose information about
> + * the progress and state of the FSCK checks.

Same here.

> diff --git a/t/t0614-reftable-fsck.sh b/t/t0614-reftable-fsck.sh
> new file mode 100755
> index 0000000000..81d30df2d7
> --- /dev/null
> +++ b/t/t0614-reftable-fsck.sh
> @@ -0,0 +1,58 @@
> +#!/bin/sh
> +
> +test_description='Test reftable backend consistency check'
> +
> +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
> +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME

Tests shouldn't define these variables, but should dynamically figure
out what the default branch name is as required, e.g. by using
git-symbolic-ref(1).

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

You can drop the cat(1) invocation and directly say `head -n1 file`.

> +		sed "1s/^/extra/" .git/reftable/tables.list >.git/reftable/tables.list.tmp &&
> +		mv .git/reftable/tables.list.tmp .git/reftable/tables.list &&
> +		mv .git/reftable/${TABLE_NAME} .git/reftable/extra${TABLE_NAME} &&

No need for the curly braces around TABLE_NAME here and further down. It
would be nice to quote these strings though.

> +
> +		test_must_fail git refs verify 2>err &&
> +		cat >expect <<-EOF &&
> +		error: extra${TABLE_NAME}: badReftableTableName: invalid reftable table name
> +		EOF
> +		test_cmp expect err
> +	)
> +'
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

Same here wrt the extra invocation of cat(1).

Patrick
