Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457334534A8
	for <git@vger.kernel.org>; Wed,  3 Jun 2026 23:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780530711; cv=none; b=RJCrHjjZynGDF3vc0VoHeILVEoEDaN7ZVaPCE5evcSSMIZMBl61hmmtMIgptVIIyh/4DzMPSp6Yd/RoRK+L2DY/KwfCGl+hY4gWgYdG8pA92wnhUYyJwdPsY2Qtzlzl1+S805hTu0k5E0xoHm1ZJR4ZwxsFRi+XwLO4C4M1rZHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780530711; c=relaxed/simple;
	bh=hTrun6kAERIux+WVr9BsPOVuE5pgwYTNB4zX1WntaKY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ckAnhIfSwxuTKkZZx0KX5Y5E8Kf8jo0PW85cj0wUksi15QKR6/QTx1Up16ayNQ38eaaagPy0Tm1dZjQ7/eMQhIWZrLgSgM0sBFTGgWNUl405RLS36HIEQUoo9w4hgwJDZ2lfYHdDIQASkqm3NDh5ZnNrWXgxYraCGHSQklBYrTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=APxbt0I1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Qe+J4Nug; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="APxbt0I1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Qe+J4Nug"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3504B1400081;
	Wed,  3 Jun 2026 19:51:49 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Wed, 03 Jun 2026 19:51:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1780530709; x=1780617109; bh=bRchz19ubF
	z0PnXLVnCtfWk+kSZi8xO9I2dNVQYT9p0=; b=APxbt0I1YRjGv9YZuSZxhl6moZ
	TnBFFlcCX0pVHnpLLyhsidLGkrP968vDvNC8OX2o0A+rPI5OsgzpHnQr79Onx/fl
	1XSR+iCucOKqzfebJZmPaRhew8AtlIDmJwJBl7GSr69UfFUXCGAFIvixrmvWGiMw
	Ma7kavpbxYVPC5/S+syXf96sHc+QRI/NQFHm9LKO1ktSyX3qwuwOVkpkPKJyJFOa
	3iQQx6eK6EKtuEF+5RPjM+j9lbMTJ6+M88URUeTrt/2qTd9bgo624a7mmUnFnha7
	QwN3hLvk5unJQQqn093L0W0J89jC54Fx5F4zYIMRX2YPgBXmv8GGcEUrzaPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780530709; x=1780617109; bh=bRchz19ubFz0PnXLVnCtfWk+kSZi8xO9I2d
	NVQYT9p0=; b=Qe+J4NugjIAO8jdIt81P3JrlVH8YZKLqFwKeLkXSgFWRCQKW0j8
	48eF4gxnCrXQyP4osigZ95uwovc22sDeWbA+8wA5JZ9zuOeMsvZUaW/DuYjwavC4
	qji+lEjfeqNRkLzBIwxLHepywnsPSgXXh6ScJs2QyqZANjDXPBPoLQgHDck+kiMH
	AaDOls72z24XUzxB/pe35zlDoelsURXOPdohwdp0WeA2nL+uygiwGqrOlFRf2PY0
	ib+faQKi/K4QXiS00wDlr5CcElP0ezSgrGQVCqevyskytKnIOnQ947ODwmnxkU1S
	4CO7tdIhkpumY0dEL1edh5iel17sZzkVFMA==
X-ME-Sender: <xms:Fb4gagz2yL1EezVYjY1h_LX4hupXhx8BaF7LkykIrajr6WjGETeXsQ>
    <xme:Fb4garRL3vluvhh_RVh-NwCm6yXDqsa6MMcWNqjPp-h5X_aPGyr9z5dXhgys4OPv4
    BQa7Rgjkm7-RyasqyTEgoxHRG_2jMeP74gjm4wJ-bWC7OtmAUWX>
X-ME-Received: <xmr:Fb4ganUBhGtsJRkRoANycTUQJuushQaKdsMsShvWXWFUbFLB-OmrQaTlCfZm-RzllwNhIOSSKSCSTPyhwJyHnRZKdoY_D4Qk5sgv>
X-ME-Proxy-Cause: dmFkZTEENh5I+wCfdrA//SwVbV6qKyyPCHQ0OxK4fBCyUAMtOLkAB/SNE+UgJfhqncA7L4
    UxO/4XnKD9fm1hQvnBwjNZ0h8kgb+h3vtROW5jNRKTwC+SXWgNh8tQqfQWrgbTGzYM/7FZ
    E+DLgzn9VeA18kCLZUQriBty5ps9ZAZwon/GFhmGfh8d277ATotKPtkAtzMQLawNZb17N6
    Wm00E9VU6euyQA6jzaxf4Bt9AvIOxCUZ1/DcS6v+NZmw44V25FK2FeqAbYD9a0Nje4EVcv
    7db2HF8f0woCn42p70Gz3pkQWfnQ1yhl5a+P2sKGFwYyTADxyGm4N/B1FSoeJsVdLmBXTN
    B9H1Xs6Vg3+cnB8Bhq/sQG8Z5VgzVY8NcNHIaGnDDYTGXO/OwydjE03v/rwPRGbQIgu4BU
    Fm5sOfv6+eN5+Vtz6r3kPHvZ0akvHAapKx1G9qwKVX6KFbdG71KX5A32mcICi6nnh3dacY
    yTL4Yeu7OaN+ZPQWy5XPro5rNFixfbWzOvfXz3VouG21vF8dlOK+OyKQN9hffDBwuxyPa7
    QDN/dfasUPcL1uxfs/hR6uFXz8QwGEM5UHyjQkUiD/g/sPZ+fWPVp+0tryFcLCcZKvwBKl
    0b/qWrBxnBZVWL3aV5MTebSfAWJIxNxpnN2qE4QLq/077l95oC0ByY3bKoWA
X-ME-Proxy: <xmx:Fb4gatbKfwciW7OTdNrBluQoHWNMM4zFcbeLJT6Hr3njfHLAEdnugw>
    <xmx:Fb4gat3WLkCn9wXAx9cppXc10XwsHoocvrfsV-WRLqaLtgcqZCKuyQ>
    <xmx:Fb4gavhXTnH6irVNJyXJz8NZSWpVWv8u2mHR3oyu4b73G19GD_hVUw>
    <xmx:Fb4gahZY71Hz5l5TKCyYWTi8_cBDy6OzKuk-yan55-tC-8-5VgQidA>
    <xmx:Fb4gau2rFh4NVRHx-g69ZylQQzls26UK7lvGi8F4n2xls_aBTrc9YGdD>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jun 2026 19:51:48 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Pablo Sabater <pabloosabaterr@gmail.com>
Subject: Re: [PATCH v2 5/9] reset: introduce ability to skip reference updates
In-Reply-To: <20260603-b4-pks-history-drop-v2-5-742cb5b5176d@pks.im> (Patrick
	Steinhardt's message of "Wed, 03 Jun 2026 18:14:04 +0200")
References: <20260603-b4-pks-history-drop-v2-0-742cb5b5176d@pks.im>
	<20260603-b4-pks-history-drop-v2-5-742cb5b5176d@pks.im>
Date: Thu, 04 Jun 2026 08:51:47 +0900
Message-ID: <xmqqqzmnqj1o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> @@ -112,6 +113,9 @@ int reset_head(struct repository *r, const struct reset_head_opts *opts)
>  	if (opts->branch_msg && !opts->branch)
>  		BUG("branch reflog message given without a branch");
>  
> +	if (skip_ref_updates && (opts->branch || refs_only))
> +		BUG("asked to perform ref updates and skip them at the same time");

;-)  That's certainly a careful safety valve.

Would we also want to catch skip_ref_updates && update_orig_head
being both set as a bogus request?

>  	if (!refs_only && !dry_run && repo_hold_locked_index(r, &lock, LOCK_REPORT_ON_ERROR) < 0) {
>  		ret = -1;
>  		goto leave_reset_head;
> @@ -196,7 +200,8 @@ int reset_head(struct repository *r, const struct reset_head_opts *opts)
>  		goto leave_reset_head;
>  	}
>  
> -	if (oid != &head_oid || update_orig_head || switch_to_branch)
> +	if (!skip_ref_updates &&
> +	    (oid != &head_oid || update_orig_head || switch_to_branch))
>  		ret = update_refs(r, opts, oid, head);
>  
>  leave_reset_head:
> diff --git a/reset.h b/reset.h
> index 9f696382c1..cb0700ffa7 100644
> --- a/reset.h
> +++ b/reset.h
> @@ -27,6 +27,9 @@ enum reset_head_flags {
>  	 * any user-visible state.
>  	 */
>  	RESET_HEAD_DRY_RUN = (1 << 5),
> +
> +	/* Skip updating any references, only update the worktree and index. */
> +	RESET_HEAD_SKIP_REF_UPDATES = (1 << 6),
>  };
>  
>  struct reset_head_opts {
