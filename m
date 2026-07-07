Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B5B3E0754
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 20:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783456211; cv=none; b=pdUyt73el4p/AIpVIy1rkRDNvd5P2RolLHbQrKz70j0JIC8Y2XaGGARWchvVgZsR6SzW85DvHir8trLV6ANA/I7E4v439fJ787CbJ2JQa3LACgjxnZeLt9PypnV4C3Nt0KvN6qKt2kd4HDtCw3JSmyc7k+okkBLTOO+JzWghHtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783456211; c=relaxed/simple;
	bh=N4xT+l4tdHg8QAH+TZgDb0Gvd9nPpuCVXOSq3o9cUZY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OBANYxMhs6mUxhRLr0ErZRKQ+BD3C0iAwCx2cQcX8b28d/iJD7kNwWStnovUpmiV1ztxl4p0GljH3NBePF5ltARmn4JYTyNEq62upUiTGKjsxNTHMJh62yuIL5RHOZ9KMz9TZ3+nAlipBwUU22YsDpc06qVQ6dKnxipr+W6tJ9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=OU5q6t20; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PTbK38Vf; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="OU5q6t20";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PTbK38Vf"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 096B21400151;
	Tue,  7 Jul 2026 16:30:09 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 07 Jul 2026 16:30:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783456208; x=1783542608; bh=bfr+OQmE9S
	Zh4sw/5qwTM/smZsDtmdUxDD9voZM2PWo=; b=OU5q6t20IPWOY35u1NATCCPk5m
	IqN7LL50Wz4mw8d6RnS2lSoIXH4hNLV5BfdQWLvXPMqNb1qPq781Tr/UditJVkcV
	zisjztFYi3LskfgHzPo8tBI4mtyM8c0uxxbkUHoOhKyVqI5ghNSVmLb2o2yDqQOj
	RBCDVOF+8VcxFGufgYSmf5Pk2oUb85M6dxjBp8Z+q3NqVHZjPedCfmz+hVmqaS3a
	m5GvPOF1EOJ4iXrWe4j2W4A67bgBJSmhBV9Hf0SbYoLrktRhrbTs9nFu9GZ7FA+0
	k4iTuUOd291oaFjieUOGJQyLqJAWyGn61AeNJO/akqWQJFdKRtNrV4WiEIEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783456208; x=1783542608; bh=bfr+OQmE9SZh4sw/5qwTM/smZsDtmdUxDD9
	voZM2PWo=; b=PTbK38VfZIrqbw/tYw74/S5xmr4I2ycLyzs41ii0PrdPFOnr43o
	5jf+1mE6+DnSMX2kCq++EPdMf09GCloORpp+7Owz3p7Tp5yI/szCEV+FhyPPXCkb
	Pca28z/PWGyrek/fdXGpzWEUFB0xVL9gN5xuNLs8kezuC102t+RYNesLyzxPDQld
	LRheIZ97Uu9A3PrQ1jpHQvtiH3RS2GHWwi/rsdi9rGkL1xmZG4P2kKb9XaaWeCgC
	KIGhPy/9OmQRtn8BpKEs3RpGgrFgVkz4nCNqsRKewW5b6cOIH/n8qdU+d3+/RfZj
	Xr2Qgx53XfqBE2jIAH44hrRJ1xmyeSpl35w==
X-ME-Sender: <xms:0GFNag2Ps4qtf_eq9fEhuautixUNZTYxbhWIOF6QtHAsJNHkZw1Jdw>
    <xme:0GFNaiiOxzitgpZZYaT8InhHHnS7HXO89y9S-ug7LZHKzkKxeUt3Z__oerZoSYPln
    SjSAIXPXAcV0Wsc1oGY3Fjnlg_48yp1laZmBz3K6hPlBp2DeO-GTQ>
X-ME-Received: <xmr:0GFNamR_DWjHzoUMN9dLsMwdqpNteT_L0OB9WyIborfHSdp-V5xHkuGPVId25OMW5ZUUerktw0wosWQomSI190qFqV6ZOZKuMIZLYdY>
X-ME-Proxy-Cause: dmFkZTGgSylfT1WTWsNwykLtmw2/c+lIrKP/3qAotXtg9e/uaLt5BmBmLjD+KvVnHgXUhO
    KqBV+qRxDWNIJHi8Dj0+eUGm+IxAyvn/1jsaKdAFiHTZ5dQVPUYIOQZLEH2gHSa5fhZU3s
    rYjoH8WE2ulsQ+7aHdvPccMDNkIJXlg97raYD+rVPdBaUFTb3oVu/d5fDq0dzV0tQJIS/U
    rDAwPi3r19ouzJfXqp1pSrklqwdtGPWl21N7AASFGiRz5lzu48iddVGVs3D6ir36coY7dK
    tEymLpST63SRIDvz561s3Akze29t6RiLWsjS41tbrn7UdwflS2YOXZID8TvxM1Q5224RW5
    F284ZdiDpll6EF3kBihbLj1g+T7UDJRA4uDHncoBn9kM94sAS2myeUdp4bsdJDvHuh9HG0
    Zcyf568ZTf1RV/5c7BhjFGLQ44rB5bCPLNX4ahcgv6xpFUTATvEEC+uPv78Cwj/3d9DZgq
    MGNms4X65d9EjRbHPfO+y6seqT1AovEpOJjuzGcg7dPmoIbWkqaDNN75h7OPDrOxE8kzGh
    XBOxttqT5l3HNZicrR7QyCLEccd4IhTYEdwmv+TgA53h89cenXbLaYw6ihCRldPXZoNJbm
    bfmGpReoupd7BDbJ1GrQ+UZXNjdWy6bonDJqpXMtd1iQBBkFguYJ2PxS/lEQ
X-ME-Proxy: <xmx:0GFNajiZLX_59oKDlaDSdUUaOuxGFCLg2G_O6L8Hc2Q0zYKZi9gGvQ>
    <xmx:0GFNam4IFFjEjzOz_EWp6UTemiXcgIcDCpgGOHOwJFqpQ2ZM96EQOQ>
    <xmx:0GFNagDsE7S0XvQ5BIXqGdemwtju798eq6yj1D8QR8H9AZDQV7cZoA>
    <xmx:0GFNataFVpC-nnbPK1dYtuNbdevJLWqope4aE_2DcjugZefVW4aNPw>
    <xmx:0GFNaiow7QIPOYJSkJyJBdLype4fowvBR9d_6-FiTVxNgec0l_KxhvBy>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jul 2026 16:30:08 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 03/11] builtin/gc: extract object database optimizations
 into separate function
In-Reply-To: <20260707-b4-pks-odb-optimize-v1-3-aae607667be4@pks.im> (Patrick
	Steinhardt's message of "Tue, 07 Jul 2026 17:32:35 +0200")
References: <20260707-b4-pks-odb-optimize-v1-0-aae607667be4@pks.im>
	<20260707-b4-pks-odb-optimize-v1-3-aae607667be4@pks.im>
Date: Tue, 07 Jul 2026 13:30:05 -0700
Message-ID: <xmqq7bn61r1u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Extract the object database optimization logic from `cmd_gc()` into a
> new `maintenance_task_odb()` helper function. This is a pure refactoring
> with no intended functional change.
>
> Note that the message that notifies the user about too many loose
> objects is moved into the new function, as well. It is inherently an
> implementation detail of how the "files" source works, and as a
> consequence we'll move it around in a later commit, as well. This
> reordering means that the warning may now be printed at a different
> point in time, but it's not expected that this will have any practical
> implications.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/gc.c | 79 +++++++++++++++++++++++++++++++++++++-----------------------
>  1 file changed, 49 insertions(+), 30 deletions(-)
>
> diff --git a/builtin/gc.c b/builtin/gc.c
> index 8f568003ee..2ff98fa727 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -839,6 +839,53 @@ static int gc_foreground_tasks(struct maintenance_run_opts *opts,
>  	return 0;
>  }
>  
> +static int maintenance_task_odb(struct maintenance_run_opts *opts,
> +				struct gc_config *cfg,
> +				struct strvec *repack_args)
> +{
> +	struct child_process repack_cmd = CHILD_PROCESS_INIT;
> +	int ret;
> +
> +	if (the_repository->repository_format_precious_objects)
> +		return 0;
> +
> +	repack_cmd.git_cmd = 1;
> +	repack_cmd.odb_to_close = the_repository->objects;
> +	strvec_pushv(&repack_cmd.args, repack_args->v);
> +	if (run_command(&repack_cmd)) {
> +		ret = error(FAILED_RUN, repack_args->v[0]);
> +		goto out;
> +	}
> +
> +	if (cfg->prune_expire) {
> +		struct child_process prune_cmd = CHILD_PROCESS_INIT;
> +
> +		strvec_pushl(&prune_cmd.args, "prune", "--expire", NULL);
> +		/* run `git prune` even if using cruft packs */
> +		strvec_push(&prune_cmd.args, cfg->prune_expire);
> +		if (opts->quiet)
> +			strvec_push(&prune_cmd.args, "--no-progress");
> +		if (repo_has_promisor_remote(the_repository))
> +			strvec_push(&prune_cmd.args,
> +				    "--exclude-promisor-objects");
> +		prune_cmd.git_cmd = 1;
> +
> +		if (run_command(&prune_cmd)) {
> +			ret = error(FAILED_RUN, prune_cmd.args.v[0]);
> +			goto out;
> +		}
> +	}
> +
> +	if (opts->auto_flag && too_many_loose_objects(cfg->gc_auto_threshold))
> +		warning(_("There are too many unreachable loose objects; "
> +			"run 'git prune' to remove them."));
> +
> +	ret = 0;
> +
> +out:
> +	return ret;
> +}
> +
>  int cmd_gc(int argc,
>  	   const char **argv,
>  	   const char *prefix,
> @@ -1018,32 +1065,8 @@ int cmd_gc(int argc,
>  	if (maintenance_task_rerere_gc(&opts, &cfg))
>  		die(FAILED_RUN, "rerere");
>  
> -	if (!the_repository->repository_format_precious_objects) {
> -		struct child_process repack_cmd = CHILD_PROCESS_INIT;
> -
> -		repack_cmd.git_cmd = 1;
> -		repack_cmd.odb_to_close = the_repository->objects;
> -		strvec_pushv(&repack_cmd.args, repack_args.v);
> -		if (run_command(&repack_cmd))
> -			die(FAILED_RUN, repack_args.v[0]);
> -
> -		if (cfg.prune_expire) {
> -			struct child_process prune_cmd = CHILD_PROCESS_INIT;
> -
> -			strvec_pushl(&prune_cmd.args, "prune", "--expire", NULL);
> -			/* run `git prune` even if using cruft packs */
> -			strvec_push(&prune_cmd.args, cfg.prune_expire);
> -			if (opts.quiet)
> -				strvec_push(&prune_cmd.args, "--no-progress");
> -			if (repo_has_promisor_remote(the_repository))
> -				strvec_push(&prune_cmd.args,
> -					    "--exclude-promisor-objects");
> -			prune_cmd.git_cmd = 1;
> -
> -			if (run_command(&prune_cmd))
> -				die(FAILED_RUN, prune_cmd.args.v[0]);
> -		}
> -	}
> +	if (maintenance_task_odb(&opts, &cfg, &repack_args))
> +		die(NULL);

Instead of giving the "fatal:" message here from this function, the
new code lets the helper function issue an "error:", so we do not
want to say an extra "fatal:" from die(), so this die(NULL) may be a
good thing to do.
