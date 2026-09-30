Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A5B3624BF
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 17:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790788635; cv=none; b=ENKPt4zV+v2dv0AAFb7YTg6ZSF27AiV5M7V6kfUuhzwC+OkbpJs0GruWm4JXsR28QvwrG/ow4mmeOyKo7WSvzNSjZstLHWrwVhA8eJw8ZpsvIKjf43+8iM4+pDNUd5O2DlqUCKrIxNfeTAZ8+S2OPKG1wsOi+mWw2mMwAiYgSq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790788635; c=relaxed/simple;
	bh=QPEeec/J4JdXqOFzshEqTQKXFcAMzdTH+5+7kWTA7Ck=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AkqZ9JfYIqRQTyBPphE6zTkkHiz0HBkHMuY6ugzpjvztz/AFlSfDOHiNP+0rT6RKotEGot5YlERfcOEfJZpACuUyzalkpJA29DYctqmgTLXzIjXP9rdnapCCCJZ8QUJ4pC35kLUnqUA0XiBpXLEgmoQi69/bykTwo7g/60eN+HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=P9cg/mbY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=w48Nb2Hc; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="P9cg/mbY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="w48Nb2Hc"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 40FD414001A4;
	Wed, 30 Sep 2026 13:17:13 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 30 Sep 2026 13:17:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790788633; x=1790875033; bh=VKKl+XGh2a
	3fndbSnRtEIwRhYvN6uFCdxt4oz0vptb4=; b=P9cg/mbYKK8nbAf8TeghL6a6Sm
	n8ifRJNwlrFa4wilsCDZzGykCR6jOWFNiYvs5jiPzWvCL1n7lPnQpfd5B79Rsf7N
	lIqcyf4QI/wgonqHU+OA80ZC+QBRBZRccrZiIBvt8vVrkQvwxPt+LlFGxELdARjq
	2+J5Ig5TaGvy2mvdWthuaRiRkt5b2QKXyLp1GbQ93QLZOHC2Lw5+8U14NSgLqGAw
	6a6ifT0HNAX3hPfTtmLH5b4IhOeMYRBV2pF4F4l0fYZpoOvrsWo15soCfqeH9vfT
	7orBVFq1Re9mojRmB0//sTDnMjhSEjnEcCw+0eUazVruIE1PadepMt/kUZpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790788633; x=1790875033; bh=VKKl+XGh2a3fndbSnRtEIwRhYvN6uFCdxt4
	oz0vptb4=; b=w48Nb2Hcn0hnPfd664edeVIPllVDh7CHKHKswoJIlRI57JNUZBZ
	c8aZcVBw37Y86u/SmsyYNJJj5nBLFZoB8duoBaGu3JETsm6WVj6bV/xnkmShbyOI
	Zqw0NosnsrEPWVlujeSulvywQYAxYhyxsJlcW+0CLr6BmiZlgrFfVMruDiGTkz1R
	RDYlG1x/BdTwKphvRxOsA7zR54PZZZSD5rTu7essB3xrbVAf3SYOdENk92eLLBTN
	rCsvnEoeGWl5/9Plm9+Wi+T2tOrVR/t+ugvP1ZevPPgtBIr0EFxwx6ErKr4lBHaO
	mb7STbwYPCCoPryDSCikAdbUpvv0naBbiqg==
X-ME-Sender: <xms:GUS9arieAdR6xZRA8-c1zEkSKEh3E4YIAauQomDXBaOzR5QFKmkimg>
    <xme:GUS9avCkGP7gkMBRRCukKGDAL6X-KBzbgVgOmq7PY8zYn9zBgm1tfy0lSErXMwcxC
    QP9c3m3zTERGcWthJUPEDx-qvUEasnzj2yFzeJrlXelqaEQnbED336d>
X-ME-Received: <xmr:GUS9agHo1-9LCS7WSZExPYuHki9l18z5W_dk3HH-iTUrEKZCZabbdZYEAmQjX6-TqlMIW-k7WgXmii004Sk9s2aru7cev3pFi2EZ>
X-ME-Proxy-Cause: dmFkZTEtyt1q0pUTFsgxvLjpfUCDhzjAUnraoN8c51PWDd02Hy/XI2uM8j5sjnApGiVm+v
    Ex3K6ih1WL8hkf1ryihrwMBdkLPgPA1y72KDZWP/p9Ob7KpPjiisBFBQum4dcV6pkB6ueT
    58Yy85S/38d4MYBci1nrcJsye+oPr7f3ISoFQ+357kOi/ISGsq0psthH7J7RDAzIvpYevs
    GlMN0AliToBqHCq+THVC8nIdpaflHKzKp4rodEQJ50F+KA1UDbAugKXJNpnSlTVl/oXl3B
    2hKJUSxeaQY/XRZXxyv5o3LkuB0J93YTYgG6R7fhU7I6Ljnfqm1HbFpse+mM5SIJLoFNWG
    NURZOzDi6a5UJY/G+woEoAQmV790xPFq3B55lass+9jFu9LDaRMc6aKJT5UQMLJoxhEk+7
    zGtFtuMsUiMVTOOV1X8yxHWy2Epi5o1iolehfAOzCz7erbssHQieNfWHfpTkSqwRmq72Eu
    P8mUMIS1gQkF/noh2gTzW3hp2SPUCHEfQgGEsjlQqspYSjw/GoLecFXgGMQJZDAU1QccjE
    JyOBKoI1H6h2ZbKjVytQXpSlFykHXcJ8rVELWMozqWbCRL4htO1DrSKwnAxeZDrFqYrrik
    24+jyTtHRQmacr2NSo/jBQ1iFKdDXban4bJgS1YAiChWT/Dahh0ggqojbEzg
X-ME-Proxy: <xmx:GUS9anK8arEg_uAvrFC9zZMtVE207mQvk6nEF0uvD8Kf7tTb6a_Jkw>
    <xmx:GUS9akneGbLlNCY9BinZXh2EAbFPv_NcWLvVNcGfn831s9F0qf6bMg>
    <xmx:GUS9avSIm5oFUBwsmpOERJ_gpx092YHYoSF6jKK7Wo7CPkqpV-O-Jw>
    <xmx:GUS9amKbH_LKjItKNhWwi-gV3gELPKNYm63LpcbrxvzO2PN0XoqIeQ>
    <xmx:GUS9arwsJeZAXQUSg8JnkkSq-BZiMFegALMgRcWHeohSxsWg6QsdXaI6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Sep 2026 13:17:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: git@vger.kernel.org,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH RFC 5/5] backfill: report total size of missing blobs in
 --dry-run
In-Reply-To: <20260930-backfill-dryrun-v1-5-1128f247ee01@gmail.com> (Pablo
	Sabater's message of "Wed, 30 Sep 2026 01:21:50 +0100")
References: <20260930-backfill-dryrun-v1-0-1128f247ee01@gmail.com>
	<20260930-backfill-dryrun-v1-5-1128f247ee01@gmail.com>
Date: Wed, 30 Sep 2026 10:17:11 -0700
Message-ID: <xmqqqziabqw8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pablo Sabater <pabloosabaterr@gmail.com> writes:

> +
> +	if (!ctx->object_info_enabled)
> +		goto cleanup;
> +
> +	if (!ctx->object_info_transport) {
> +		struct promisor_remote *promise =
> +			repo_promisor_remote_find(ctx->repo, NULL);
> +		struct remote *remote = NULL;
> +
> +		if (!promise || !(remote = remote_get(promise->name)))
> +			die(_("--dry-run requires a promisor remote"));
> +
> +		ctx->object_info_transport = transport_get(remote, NULL);
> +
> +		if (!ctx->object_info_transport->smart_options)
> +			die(_("failed to get object info: smart options required"));
> +	}
> +
> +	results->wants_size = 1;
> +	status = transport_fetch_object_info(ctx->object_info_transport,
> +					     &ctx->current_batch,
> +					     results);
> +
> +	if (status == FETCH_OBJECT_INFO_NOT_ENABLED ||
> +	    !results->sizes) {
> +		ctx->object_info_enabled = 0;

Yuck.

Because we cannot tell if they allow you to look at the information,
this cannot be helped, but it means anybody that looks at this
ctx->object_info_enabled member to decide what to do must be careful.

Is it guaranteed that results.sizes[] have been populated as long as
status is not FETCH_OBJECT_INFO_NOT_ENABLED?  Can there be other
errors that makes result.sizes[] unusable?  If that is the case,
then it would be cleaner to have a dedicated ctx->sizes_valid member
rather than relying on ctx->object_info_enabled member to carry this
information ...

> +		goto cleanup;
> +	}
> +
> +	for (size_t i = 0; i < results->nr; i++)
> +		ctx->total_batch_size += results->sizes[i];
> +
> +cleanup:
> +	free_fetch_object_info_results(&ctx->object_info_results);
>  	oid_array_clear(&ctx->current_batch);
>  }
>  
> @@ -157,12 +201,25 @@ static int do_backfill(struct backfill_context *ctx)
>  
>  	dry_run_batch(ctx);
>  
> -	printf(Q_("After backfill, %" PRIuMAX " blob would be fetched.\n",
> -		  "After backfill, %" PRIuMAX " blobs would be fetched.\n",
> -		  (unsigned long)ctx->total_batch_nr),
> -	       (uintmax_t)ctx->total_batch_nr);
> +	if (ctx->object_info_enabled && ctx->total_batch_nr) {

... and use it here.  Within the design presented in this series, we
know we have asked the other end at this point, and the above
function may have turned ctx->object_info member off if the
information is not there, so this may be safe.  But as I said, I am
not sure what happens when fetch-object-info returned other kind of
errors.

