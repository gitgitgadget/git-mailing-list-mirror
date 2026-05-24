Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA853264F2
	for <git@vger.kernel.org>; Sun, 24 May 2026 23:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779663933; cv=none; b=nSKBSrt+TuYwWRAqAEwN9uOkpmsIhyL3no8AtxLquuvep9QY850rPk+qMixOHHsX1kqsy7O/V+LCzamwaqdk8oCo4ktifiIkFbS42jHAT5CV1VIwPlavJ0pmueSUUDTFupwjtBvnK98MSGWbXUQDRQvIRISyhSprr95WhZbadus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779663933; c=relaxed/simple;
	bh=+ngw3Vr0aA0XUg1u7dhk+WeZNGS14GgTxc+u50IRheg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PlBVy63vr6TNyNtaiO+Mzxgc7iPa91CHoTD5Syt8fouZBQoCKBCNeVtasiY9dn8T5U2LbMq+CrZpiSsBQFxeNfYolA9/qHFAwh+7dnbbX/ggPfcYCFyeWveEzkQRz8OSgS2TCmsUC1YUWA1tYQNlhZFvVgXfEaPjeR/pkhzUxfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=asGS1UUD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sJxESPmw; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="asGS1UUD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sJxESPmw"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 9311FEC01DF;
	Sun, 24 May 2026 19:05:31 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Sun, 24 May 2026 19:05:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1779663931; x=1779750331; bh=cE7hDKo9OU
	VyyHoXyeH5is1fL7JZJ93A7yuRUvoS0Go=; b=asGS1UUDvuKceaSQcc3DSX9aY+
	VOatr+OweZJ6Q27Km9CisydTDeE8oO5mhB+2n2ueqv10gvc/1V+3a7rVzNjVS7uj
	rK8x5tkyaaqryjmFwJPBjh9Znn1sy7qBxYeb783HcADmsx6WGjxuWopjNPu59se6
	T+nBryHLQfc4kBRTDZHucGHgZ2ZpOH3gdxmNKiBF1g8439GUm6Qm/OwNSpJLxHYb
	5kEU8j4DPykvhimEJfEhE2uojZPLjeDCkBcMnAWDz6KJtt8cU7hDq+en6MLh42uZ
	FANXf53iJWxScTYE0WGToTKB4q866Ti5FxhCulzdAQNeQ2NURs99IIXtHL0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779663931; x=1779750331; bh=cE7hDKo9OUVyyHoXyeH5is1fL7JZJ93A7yu
	RUvoS0Go=; b=sJxESPmwJHuqh2ge4yR4AxtmR8W3iod8Q81Fmyc+p7wsgB5Buab
	8AkPNDViYgxeirDnW2k3M0VGohxnS8uk69UyrPpCfR9nPS694nWZMOCOqg5Vr/6E
	L8Qw2qwAYI+txR/vGXlPoftqA/CBq90VMJVRfrE7PcKwoYXUOQQrgUeMPeheHbfS
	WJxYFIYWJ14x21fPkaqSwU4g89W0ro2RRNZX+wf6hOl9FmFj1xYTc6lLOfN65xog
	NS7vyLip5wyEddDDm+g7JY1OnzsZO8pYbyS4EKl4J1LjJOkHEtZ0w8dgIMCC2CXS
	JfbjhKF4PtT7+XQu8FyfWY/6UNkHtjpFULQ==
X-ME-Sender: <xms:O4QTai1Z7tX5HPkGS1oN3CRyLlUCqDeNggUf4Xuy2s9j85ifqo4pug>
    <xme:O4QTasEmRdlu0fReTozMkdU_wW1CEpOmtsP9hetFdX28WRO66HlycXczfp30JEJNw
    JOq_moLD_zVCZUseMYnFwrcd2kGm2OZxjy88oqqUxEyxKpkn3RZyw>
X-ME-Received: <xmr:O4QTav7zGClVj-PNvlMTWyFMZN1oo7-q93PpUMZS_VaJJeJmyavmgl2NPJIAEkxtZfEJzF1yI8UWehKbGZ-L5HQacm26iZbq_ZeK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduheejvddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhm
X-ME-Proxy: <xmx:O4QTaislHvbi3hhZgsKdMjOP44b-kPZ7mG80cnNEYo5OgTV1XoPl-A>
    <xmx:O4QTag6rHxsWkuqUexIofW2XLAxZYCGo16xrz0cUakr5qHgp64Nerw>
    <xmx:O4QTatW2qCOujYaVC9itahDDNQfZbePcVOWSlQW1pYzZdi6yaqHCDw>
    <xmx:O4QTai9KYI1SOaXK_0EVT1K62dLW-nJMaK_LkmILng6m9SvKm8N-tw>
    <xmx:O4QTarbDN9KGWGpa6SEa95POfKSdGQkaz7_TbQV1QzpihViV7_BmFdk0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 May 2026 19:05:31 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 2/2] restore: avoid sparse index expansion
In-Reply-To: <47542cbd42eb13b63d0d852fb2f5bf967952b318.1779644412.git.gitgitgadget@gmail.com>
	(Derrick Stolee via GitGitGadget's message of "Sun, 24 May 2026
	17:40:12 +0000")
References: <pull.2121.git.1779644412.gitgitgadget@gmail.com>
	<47542cbd42eb13b63d0d852fb2f5bf967952b318.1779644412.git.gitgitgadget@gmail.com>
Date: Mon, 25 May 2026 08:05:30 +0900
Message-ID: <xmqqtsrwh0hx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <stolee@gmail.com>
>
> Teach update_some() to handle sparse directory entries at the tree
> level rather than expanding the entire sparse index. When iterating a
> source tree during checkout/restore operations:
>
>  - If a directory matches a sparse directory entry with the same OID,
>    skip it entirely (no change needed).
>
>  - If the OID differs and we are in non-overlay mode (e.g., restore
>    --staged), update the sparse directory entry's OID in place. This
>    is semantically correct because non-overlay mode removes paths not
>    in the source tree anyway.
>
>  - In overlay mode (e.g., checkout <tree> -- .), fall through to
>    recursive descent so individual file entries are preserved
>    correctly.
>
> Also switch from index_name_pos() to index_name_pos_sparse() for
> individual file lookups to avoid triggering ensure_full_index() when
> the file is already individually tracked in the index.
>
> Update the test expectation in t1092 to assert that 'restore --staged'
> no longer expands the sparse index.
>
> Signed-off-by: Derrick Stolee <stolee@gmail.com>
> ---
>  builtin/checkout.c                       | 57 +++++++++++++++++++++---
>  t/t1092-sparse-checkout-compatibility.sh |  8 ++--
>  2 files changed, 55 insertions(+), 10 deletions(-)
>
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 1345e8574a..67f03dea10 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -31,6 +31,7 @@
>  #include "revision.h"
>  #include "sequencer.h"
>  #include "setup.h"
> +#include "sparse-index.h"
>  #include "strvec.h"
>  #include "submodule.h"
>  #include "symlinks.h"
> @@ -142,14 +143,56 @@ static int post_checkout_hook(struct commit *old_commit, struct commit *new_comm
>  }
>  
>  static int update_some(const struct object_id *oid, struct strbuf *base,
> -		       const char *pathname, unsigned mode, void *context UNUSED)
> +		       const char *pathname, unsigned mode, void *context)
>  {
>  	int len;
>  	struct cache_entry *ce;
>  	int pos;
> +	int overlay_mode = context ? *((int *)context) : 1;
>  
> -	if (S_ISDIR(mode))
> +	if (S_ISDIR(mode)) {
> +		/*
> +		 * If this directory exists as a sparse directory entry in
> +		 * the index, we can handle it at the tree level without
> +		 * descending into individual files.
> +		 */
> +		if (the_repository->index->sparse_index) {

I wonder if this deep nesting is a sign that the newly added code
from here to ...

> +			struct strbuf dirpath = STRBUF_INIT;
> +
> +			strbuf_addbuf(&dirpath, base);
> +			strbuf_addstr(&dirpath, pathname);
> +			strbuf_addch(&dirpath, '/');
> +
> +			pos = index_name_pos_sparse(the_repository->index,
> +						    dirpath.buf, dirpath.len);
> +			if (pos >= 0) {
> +				struct cache_entry *old =
> +					the_repository->index->cache[pos];
> +				if (S_ISSPARSEDIR(old->ce_mode)) {
> +					if (oideq(oid, &old->oid)) {
> +						strbuf_release(&dirpath);
> +						return 0;
> +					}
> +					if (!overlay_mode) {
> +						/*
> +						 * In non-overlay mode (e.g.,
> +						 * restore --staged), we can
> +						 * replace the sparse dir OID
> +						 * directly since files not in
> +						 * the source tree should be
> +						 * removed anyway.
> +						 */
> +						oidcpy(&old->oid, oid);
> +						old->ce_flags |= CE_UPDATE;
> +						strbuf_release(&dirpath);
> +						return 0;
> +					}
> +				}
> +			}
> +			strbuf_release(&dirpath);
> +		}

... here may become easier to understand if it is made into a small
helper function with a descriptive name.

>  		return READ_TREE_RECURSIVE;
> +	}
>  
>  	len = base->len + strlen(pathname);
>  	ce = make_empty_cache_entry(the_repository->index, len);
> @@ -165,7 +208,7 @@ static int update_some(const struct object_id *oid, struct strbuf *base,
>  	 * entry in place. Whether it is UPTODATE or not, checkout_entry will
>  	 * do the right thing.
>  	 */
> -	pos = index_name_pos(the_repository->index, ce->name, ce->ce_namelen);
> +	pos = index_name_pos_sparse(the_repository->index, ce->name, ce->ce_namelen);
>  	if (pos >= 0) {
>  		struct cache_entry *old = the_repository->index->cache[pos];
>  		if (ce->ce_mode == old->ce_mode &&
> @@ -182,10 +225,11 @@ static int update_some(const struct object_id *oid, struct strbuf *base,
>  	return 0;
>  }
>  
> -static int read_tree_some(struct tree *tree, const struct pathspec *pathspec)
> +static int read_tree_some(struct tree *tree, const struct pathspec *pathspec,
> +			  int overlay_mode)
>  {
>  	read_tree(the_repository, tree,
> -		  pathspec, update_some, NULL);
> +		  pathspec, update_some, &overlay_mode);
>  
>  	/* update the index with the given tree's info
>  	 * for all args, expanding wildcards, and exit
> @@ -580,7 +624,8 @@ static int checkout_paths(const struct checkout_opts *opts,
>  		return error(_("index file corrupt"));
>  
>  	if (opts->source_tree)
> -		read_tree_some(opts->source_tree, &opts->pathspec);
> +		read_tree_some(opts->source_tree, &opts->pathspec,
> +			       opts->overlay_mode);
>  	if (opts->merge)
>  		unmerge_index(the_repository->index, &opts->pathspec, CE_MATCHED);
>  
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index d69434e7ab..8186da5c88 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -2608,19 +2608,19 @@ test_expect_success 'restore --staged with wildcards' '
>  	test_all_match git diff --cached
>  '
>  
> -test_expect_success 'sparse-index is expanded: restore --staged' '
> +test_expect_success 'sparse-index is not expanded: restore --staged' '
>  	init_repos &&
>  
>  	git -C sparse-index checkout -b restore-staged-exp base &&
>  	git -C sparse-index reset --soft update-folder1 &&
> -	ensure_expanded restore --staged .
> +	ensure_not_expanded restore --staged .
>  '
>  
> -test_expect_success 'sparse-index is expanded: restore --source --staged' '
> +test_expect_success 'sparse-index is not expanded: restore --source --staged' '
>  	init_repos &&
>  
>  	git -C sparse-index checkout -b restore-source-staged base &&
> -	ensure_expanded restore --source update-folder1 --staged .
> +	ensure_not_expanded restore --source update-folder1 --staged .
>  '

Very nice.
