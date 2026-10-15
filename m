Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A69471D1E
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 19:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792092021; cv=none; b=OY485kURuByeY4NvKgctwbt9wUTosp2fYm58KGKcvfsATWxmRdeNhIE6jboqa5fXy/83EMOfCTDxymxe5XKMvD/zoHV4cHx7ePGipvoVUYN6R7R2KOO3saxJQTW8kuGG9C3SyHK83lY3snJrxZSZxV3sGlgXpX67waP0YW5Qg0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792092021; c=relaxed/simple;
	bh=QRm/ppZrD+L6pvDs00kTCCrM3yyT9PUl23m2psxgk5w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ozzc5G1MUW61kEEevd70K4O/mqUgOlxJkpIPwH815qI9divVa2CicVS9fqSqWd+kN5dlXqDilHuqIg9xGyllgClHLo3nGpVV57vlvZWWADbfm4U1LJJx6mGvyaitXeJOu1wqGtQs3QaMkI1BMv4chReIKgGMx+RhpvIC+p5mxos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fO1LSbs0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ErqXOGng; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fO1LSbs0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ErqXOGng"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E86DD7A00C9
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 15:20:18 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Thu, 15 Oct 2026 15:20:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792092018; x=1792178418; bh=myeOHxkT0q
	2+Ma4h7ztEYeUv2qVeMFAQC+bQbD4oEUI=; b=fO1LSbs01xYnjR/FOLrKq25V62
	vm4U2IOqfdgGIjyR95lCbZcFdMVg/BPE5sFLsJcN0R6lD6aPxZkRM+0L5NgYGUvt
	axip3E/Y0dIt6OYQnNObFgEypj5/omu9v0mdzfxH3+8E/X8gLYn78vjg/7CEu8OA
	1VUPCfKjPPUjLBQh4WcRCRE/yPw7x/VIP1Y19n2kg2TLLPmJu5fFio91BZgsK6Tn
	iRJoz+p4U4zeP0CsxgEea1qrEHDmvCfkL6loXFpGL8umlvCpn3GzMlCJQ3if2NjD
	5Q1nCVGg/rFOoO4ux7CARBUXCIYEGb+TadOkRkuQmQRJvfTRplr1H6lc0rdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792092018; x=1792178418; bh=myeOHxkT0q2+Ma4h7ztEYeUv2qVeMFAQC+b
	QbD4oEUI=; b=ErqXOGngGmGjr3ClBzZTyrmpsI8N7IrDnmK3/rXTqnOupRmWQ+a
	RxNdgjhWiKcSbCHEj7JK3Pk0/4dHyaUlYfTAhA5/pbRSLQKv9H4lwX5U1Gs1iRLH
	yOTHk7skM4l39au8QbCC1A/yUcQsNfw4KT/cHVwqtfauISAxP+XXtWSuhRQYuvP2
	24ptihDqKY6OWX/rtv3r9/dPLbabU7FWQRfDo8CsxDL2k2s+abUm8eBc4aqj/6hq
	2C/g4Xb+K2/tD7bLlDJc3KneS9WuDMSE2qDYrZS+EvnMOgqjMowXSe14tpN+Nb/3
	HlWiWaqtZam44zFTN+R2YX995fHF6e+GUfA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792092018; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:Itp1zpOBcBYpwU5f9+m/FEPPA6/CH7iMW1r3YPsSS3Q4v42
	ObzGvVfPWTjpr0fUPBv0inW/MO41u0wECV7YiBU0e616kWQlxHcqnhFjOY1YIs4M
	oncZIwfdNxcRLl9v8m+Ng+OYh694nbQmBEHnVxaQm6/bBh6dTILZa7qFkqw8zvsm
	CkUpXPmXo28Ir9VlR0Y4JhHqVn2wfmGg7tKVa+mNcKEGHxXXmzdjHr88fVMLg42v
	ZKXeMFZdUf182V4DMJrnyOKmO9v0GVS6wHdkQi1a8Ege7ViUrVluhb97G3DwMtfr
	7VgxxWjy6cX7h0bt8DR23vAkS3AIZSkktod0B9g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:RPEi8rF5+0BcSD0BV1gnBvTA18lgDics6Y6dG3squHo=:QRm/ppZrD+L6pvDs00kTCCrM3yyT9PUl23m2psxgk5w=;
X-ME-Sender: <xms:cifRahHE7hyDeZUwi2zgNJ4517sstWPSA7iYUhGOOfwiLjL7Y7ltGw>
    <xme:cifRaonFSlLb2yy6Flku-iCFwlqsuBbTnG1ST_TgnIdtsOgFb2TJmarReaULH761K
    yYW7uG4JQRoPnwj5YXlQRuEh-qMk6N06HCp5cLKlCn9CrLcvZ45Si0>
X-ME-Received: <xmr:cifRalYN3wpJJoe7cIv3H5vP_XU6J1lHaA5gY2u_u08gHBFpdICOIQt78W_CrOIlD7CoosgElwCdSaOdwjIN5Vr2pAAgbmlS0TK6>
X-ME-Proxy-Cause: dmFkZTEhBiyvTvA6T8yM1WuYE77qmrEwvAL7H17f9ZxeocTXzhxFZ3NkOgK6OogALJDUmP
    +XA5bJmmhHiS82zHNbPud8dSAuF7//KqX6MUp5ipBvBbtqU+GC6YnDCP05O9BTm2gd6kNx
    9xFSzMYirvnmWFrC0q4nBPmS5ug9AX2wtoN38MR49Of2KmTzKv+5rrTBmH44MqWghoeQUW
    ElZ4/AOvtmQUJPkH1FJGHc3rp2tR4pPPR6qZ//GMzFx89tDryB6nk+Ti5P1P/5Ht4jE7qS
    Y3USSbNK9me2X22CXpGPd+CcbwTATy7qlACMWXf9zq8mjgeYB2icPI87nvDilmArPQtXPK
    /uvD/A1a4kHBwM/P5naBGzvZLaua5Pfw+nREiNYXZm1ZQlWVieN9HlaeZ/uOSsuovIlUj+
    WWibReZgGKjaYgmS+ffnCNNx430KDTwRNSKsgH9gnjFuHn3aHLCm9fAkayizebJqyed2PS
    4wIMmztxGhK+TSwU6NR+VPN2RBFvJlxHmRDHzz07PjyWl9/eP6LqBHto/mOzy7Au3PcMNr
    SSvUY6u9AidyHk9C/2+uO0r7q/jP+nRVAN4Ix1ozmJF3ZIgXTgqPfiqGpoMtzqvc+gBrLw
    ul0q67LqVPBomGU/SZLl/vz1KsR68lf34helQmTDJUvhjc8tM64GtN7qqizA
X-ME-Proxy: <xmx:cifRatFf63Tj10gCwiFHRzIFTSZyhGcgs4SeLPdPjWpxMGYbG7gnVA>
    <xmx:cifRamJmrhrAYpE2XK232ExecvQqJcG-IpPo8QjVpasfd-XNMmuYMQ>
    <xmx:cifRaoMD47wVzCSrQlQhVPJJzn51NbukYENbmRb08mOOB0iQY4hF-g>
    <xmx:cifRammMbqzc3c-TKt-J3-iUcqQSVk9TckSO8nwA0-A16T5fZ3X1jg>
    <xmx:cifRahEp4sgWJxsUSm3DyzjUDDyXu9sWBUZFrTiLghdvuClugAmlZgVW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Oct 2026 15:20:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,
  usmanakinyemi202@gmail.com,  siddharthasthana31@gmail.com,
  kaartic.sivaraam@gmail.com
Subject: Re: [Outreachy PATCH] merge: stop using the_repository
In-Reply-To: <20261015142532.48175-1-okhuomonajayi54@gmail.com> (Okhuomon
	Ajayi's message of "Thu, 15 Oct 2026 15:25:32 +0100")
References: <20261015142532.48175-1-okhuomonajayi54@gmail.com>
Date: Thu, 15 Oct 2026 12:20:16 -0700
Message-ID: <xmqqo6cun53j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Okhuomon Ajayi <okhuomonajayi54@gmail.com> writes:

> try_merge_command() and checkout_fast_forward() already receive a
> repository, so use it instead of relying on global variables.
>
> Add a repository parameter to merge_argument() and pass it
> from try_merge_command(). Use the repository in
> checkout_fast_forward() when parsing trees.
>
> Remove the now-unnecessary USE_THE_REPOSITORY_VARIABLE
> definition.
>
> Signed-off-by: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
> ---
>  merge.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)

    To: gitster@pobox.com
    Cc: git@vger.kernel.org, christian.couder@gmail.com, usmanakinyemi202@gmail.com,
     siddharthasthana31@gmail.com, kaartic.sivaraam@gmail.com, Okhuomon Ajayi
     <okhuomonajayi54@gmail.com> 

Please do not put me on "To:" alone unless the patch has been fully
reviewed and reviewered acked it.  Placing reviewers on Cc: line (or
To: line) as "area experts" asking for review is fine, and if the
patch is in the area where I happen to be an area expert, my address
may appear there together with other reviewers, but the default
"To:" address on this list for a brand new patch should be the list
address itself.

> diff --git a/merge.c b/merge.c
> index 0f5e823e63..85dad63a94 100644
> --- a/merge.c
> +++ b/merge.c
> @@ -1,5 +1,3 @@
> -#define USE_THE_REPOSITORY_VARIABLE
> -
>  #include "git-compat-util.h"
>  #include "gettext.h"
>  #include "hash.h"
> @@ -14,9 +12,9 @@
>  #include "tree-walk.h"
>  #include "unpack-trees.h"
>  
> -static const char *merge_argument(struct commit *commit)
> +static const char *merge_argument(struct repository *r, struct commit *commit)
>  {
> -	return oid_to_hex(commit ? &commit->object.oid : the_hash_algo->empty_tree);
> +	return oid_to_hex(commit ? &commit->object.oid : r->hash_algo->empty_tree);
>  }
>  
>  int try_merge_command(struct repository *r,
> @@ -32,11 +30,11 @@ int try_merge_command(struct repository *r,
>  	for (size_t i = 0; i < xopts_nr; i++)
>  		strvec_pushf(&cmd.args, "--%s", xopts[i]);
>  	for (j = common; j; j = j->next)
> -		strvec_push(&cmd.args, merge_argument(j->item));
> +		strvec_push(&cmd.args, merge_argument(r, j->item));
>  	strvec_push(&cmd.args, "--");
>  	strvec_push(&cmd.args, head_arg);
>  	for (j = remotes; j; j = j->next)
> -		strvec_push(&cmd.args, merge_argument(j->item));
> +		strvec_push(&cmd.args, merge_argument(r, j->item));
>  
>  	cmd.git_cmd = 1;
>  	ret = run_command(&cmd);
> @@ -68,18 +66,18 @@ int checkout_fast_forward(struct repository *r,
>  	memset(&trees, 0, sizeof(trees));
>  	memset(&t, 0, sizeof(t));
>  
> -	trees[nr_trees] = repo_parse_tree_indirect(the_repository, head);
> +	trees[nr_trees] = repo_parse_tree_indirect(r, head);
>  	if (!trees[nr_trees++]) {
>  		rollback_lock_file(&lock_file);
>  		return -1;
>  	}
> -	trees[nr_trees] = repo_parse_tree_indirect(the_repository, remote);
> +	trees[nr_trees] = repo_parse_tree_indirect(r, remote);
>  	if (!trees[nr_trees++]) {
>  		rollback_lock_file(&lock_file);
>  		return -1;
>  	}
>  	for (i = 0; i < nr_trees; i++) {
> -		if (repo_parse_tree(the_repository, trees[i]) < 0) {
> +		if (repo_parse_tree(r, trees[i]) < 0) {
>  			rollback_lock_file(&lock_file);
>  			return -1;
>  		}
