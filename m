Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8EB40099B
	for <git@vger.kernel.org>; Mon, 10 Aug 2026 15:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786374704; cv=none; b=NSihGfA7MwAtaKZ8ANNHfLVHHEKrBBc9JbKWo+MI6rGDBfhTJOzKQlL41jwJEeFRhoBQEuasQsHYcu3a3OnnLkpKsg9v/oHzyEzttxggDAaeD38QdddggSQ8C2A2EIh3D78LEF8IfzaLNbju/Z2NPGnTUBIM06R9EnHjjue2e7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786374704; c=relaxed/simple;
	bh=o7tnV3mQV7k2kKoEsLo2WNjwCRO09kvlXR2tW3Ns/RU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lneb0Hely4zoxrRCfbrE7K35zTcq6ohRqFqJk2FkCPP859J5g/6ObJSzCjyDbuIxGX77S3g1w569Yvz88QQ/+hcpQNAsR1HwdzgamOEcooYWWMMLBe0XoajeaEy64CEtWHEAocymBYrUHdcQ87pee/UIWCh95znM2jmcXbfiqz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=I01gfm5j; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iF+Pw02h; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="I01gfm5j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iF+Pw02h"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 22FA3EC00D8;
	Mon, 10 Aug 2026 11:11:42 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 10 Aug 2026 11:11:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1786374702; x=1786461102; bh=UcLr0+qJy1
	Y33q/MTHNTVUR3JjyPRgIcnuuo3nbyeFU=; b=I01gfm5jn2PMwDJhh+0Swe+n62
	Nv0OmzD4ZWpUCd7dDLMjsuWjYGYdaP8vrDrbnCeh6Grh5RG89YAZWBVc8ur5film
	sPySJ/bqHLjM22bJAhPJHgSYj55Vbx8yHk4H/dbh0nEZIIjUki9THtvwyPPzaMvP
	4G5HH998Q3it+DjNaarBssHJ90ITBbOIKCscA/AqbzCvaIMC4qLJW1tw99pn/8fR
	s3srhvoKs7CbHT4B5aOCEpQBaS2qlD62OQ/1rCx8AlPTTz2ix+ECvJh0bYAJUe/j
	5uB7XxHAmCm5/TpN2EGNYN9VYpVfnyyy8PsCSnX+q/6Zwmd7A+4TsXW8JvsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786374702; x=1786461102; bh=UcLr0+qJy1Y33q/MTHNTVUR3JjyPRgIcnuu
	o3nbyeFU=; b=iF+Pw02hh3nOkiOZybKQnwBc+x92chdqHrPU5gCo8ROByMPQN6s
	oT7ONC69Kmtc0V6B7CMuYE8Y588eieGhwWAQLsneBHwYgfg8yYVCNE+ZazrIevRp
	cwd/gmsl/Zzakz/Qh3R3oY0RDr24p4rifCXpwk4Dx2fbC9xx/u0p7+T/xDy1CS5z
	LVk6z0iRjrcADizcAIeEGPrwtcbz2NeF46zGq3uMiz4WLFOOgtz0LwS/VgFXnrQ9
	le1kdMzR31BqqTvY0F8uPxuR881UXyVV0F/nlSrs08qlyD/RCfJlhHLABlhnJh35
	iWt9J6t9MtEMlTq6Mu1B6TheB6thjibJXMA==
X-ME-Sender: <xms:Lup5ar52VSlMli8n5z066utAwoMrd7TyE3QtXmPJd1PzzIi1-eF3zg>
    <xme:Lup5anwpZ7gBvfgGYu2o9hV3zEiLgjq9NeQ9YZxfJH6vZFSPQ5Fx5qgWltSvyOEve
    GScGy1pvkN9sv8MVhq1Bz577OHHk_X6gWemedGDPluIE3BaScQXvQ>
X-ME-Received: <xmr:Lup5aqyklJwtjwGTcVIoJBCCB5nYsKKBh_MnjXVrPvqVg7h4ruvjW_OqFr76BKn2k8A3bJhdthaynuuSBD2SF-AgHrY_D4zA3AUxdeBBag>
X-ME-Proxy-Cause: dmFkZTF1a3zckMq1WKaQQdgDCw9yoF8QAVtIuAS/YnrW/pOakYxCvR5O3CexVUJT9zfWXl
    pqnIeemOIy5eS1KFixSjuXwj1XCu7jf9aKo3uiY/VPXxAhXHMpcYs5WU7u3allbmbL9PSK
    3iOtLQSXmO6Ib1PT2Ygvcf4S/v9YBWVVM08hbq75YlBllDLIVGRzPZOEFP75rjr60kx/20
    QUM5DtQwwC6ceANrV122eN10seH7iQEvyr5SK6W9w+WhS1+F22H0zfRxC9hekF3HtZ406U
    Nb+vCRB/EfLNwVrsP+YpTClbXb7UsblI/+uEtAwGImchvjNDgcVyAQQxl2Y0wR2ZjjzuZk
    XEJ+iOwYl7J0NJWEk2rFSHj+hY3aYscsSWpNNNHnPeWhx1s8MpCngLtv48AexvNMtL4EVf
    GVdDQCLsW+UsWBPqYuPQ0LhjJsywJenlddbHcUr0vDpJv0B0C8mqpTosFS3/SFc123CWP/
    TuD+KM1CLHVvK9wvKigAIfYV2S7vdYqPDtW2edEHHXHIkH1KOefOkVCcSFJOzrZEQzahZW
    r4rpvGz27u9Cu31G+gb71P0Gm7PqJ8A7lsQyXKHiT45s/Tv1GJTouY1+UGv7GhWoA/itvw
    9HukURlLWhPXO4Jh5MCvsHTSnQPApL4mf8exhunNgQ2lebNzFUyM2IRlhpQQ
X-ME-Proxy: <xmx:Lup5anzPbbOuBCEclXuACyugpyfO83shUiTgPeR053_UGyeIH3g8lA>
    <xmx:Lup5asZ8kBGDEEdmkGV-vde3BvT6Rc0DPKG--nzXwUGIbMv1RQ5vxg>
    <xmx:Lup5agVeIwkNr-xoKOjhkl82N1xOtDpRAia8LJNrpJRPjofErWfHvA>
    <xmx:Lup5aijOXAMhrijQ0kJC-Vo9MUm9IXTSoUqgWAxAnT4qAF0HhiocFg>
    <xmx:Lup5agQQcZEk1CCnSkvGl9Olnpiw8ohfDxaVAEkRTVZR60mCSZQbjyPu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Aug 2026 11:11:40 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f231f0c0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 10 Aug 2026 15:11:40 +0000 (UTC)
Date: Mon, 10 Aug 2026 17:11:37 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <ttaylorr@openai.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Ted Nyman <tnyman@openai.com>
Subject: Re: [PATCH 2/2] maintenance: trigger --auto for promisor rollups
Message-ID: <annqKRGoh4-S91VE@pks.im>
References: <cover.1785902237.git.ttaylorr@openai.com>
 <dc2fffc37cead551f8036c9ecab5e52a4cbee37b.1785902237.git.ttaylorr@openai.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc2fffc37cead551f8036c9ecab5e52a4cbee37b.1785902237.git.ttaylorr@openai.com>

On Tue, Aug 04, 2026 at 08:57:46PM -0700, Taylor Blau wrote:
> Commit 9bc151850c (builtin/maintenance: introduce "geometric-repack"
> task, 2025-10-24) added an auto condition for the geometric-repack
> task. It runs the task when ordinary packs need to be combined or when
> the number of loose objects crosses the configured threshold.
> 
> Later on in commit dcc9c7ef47 (builtin/repack: handle promisor packs
> with geometric repacking, 2026-01-05), the geometric repack machinery
> started handling promisor packs separately, but did not correspondingly
> update the auto condition.
> 
> As a result, a repository can have promisor packs ready to combine
> while its non-promisor packs and loose object count require no work. In
> that case, `--auto` skips the task even though a geometric repack
> would combine at least two promisor packs.
> 
> Check `geometry.promisor_split` alongside `geometry.split`.

Yeah, this is a more obviously correct thing to do compared to the
preceding patch.

> diff --git a/builtin/gc.c b/builtin/gc.c
> index ed75c12c43..e9572940dc 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -1649,7 +1649,7 @@ static int geometric_repack_auto_condition(struct gc_config *cfg UNUSED)
>  	 * When we'd merge at least two packs with one another we always
>  	 * perform the repack.
>  	 */
> -	if (geometry.split) {
> +	if (geometry.split || geometry.promisor_split) {
>  		ret = 1;
>  		goto out;
>  	}

This looks obviously correct.

> diff --git a/t/t5331-pack-objects-stdin.sh b/t/t5331-pack-objects-stdin.sh
> index c74b5861af..2a983e28ac 100755
> --- a/t/t5331-pack-objects-stdin.sh
> +++ b/t/t5331-pack-objects-stdin.sh
> @@ -368,7 +368,8 @@ test_expect_success '--stdin-packs does not perform backfill fetch' '
>  	git -C remote config set --local uploadpack.allowfilter 1 &&
>  	git -C remote config set --local uploadpack.allowanysha1inwant 1 &&
>  
> -	git clone --filter=tree:0 "file://$(pwd)/remote" client &&
> +	git -c maintenance.auto=false clone --filter=tree:0 \
> +		"file://$(pwd)/remote" client &&
>  	(
>  		cd client &&
>  		ls .git/objects/pack/*.promisor | sed "s|.*/||; s/\.promisor$/.pack/" >packs &&

Curious that git-clone(1) already spawns maintenance, but with "tree:0"
we may end up fetching multiple promisor packs from the remote as we
discover more trees to backfill. So this makes sense.

> diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> index ba5b359e77..fb5f2d8902 100755
> --- a/t/t7900-maintenance.sh
> +++ b/t/t7900-maintenance.sh
> @@ -759,6 +759,29 @@ test_expect_success 'geometric repacking with --auto' '
>  	)
>  '
>  
> +test_expect_success 'geometric repacking with --auto handles promisor packs' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		git config set maintenance.auto false &&
> +		git remote add promisor garbage &&
> +		git config set remote.promisor.promisor true &&
> +
> +		for n in $(test_seq 6)
> +		do
> +			test_commit $n || return 1
> +		done &&
> +
> +		pack_promisor 1 >/dev/null &&
> +		pack_promisor 1..2 >/dev/null &&
> +		pack_promisor 2..6 >/dev/null &&
> +		git prune-packed &&
> +
> +		test_geometric_repack_needed true auto=9000

The auto-value here doesn't matter at all, as we shouldn't have any
loose objects in the first place and really only want to trigger
maintenance because of the promisors. Makes sense.

Thanks!

Patrick
