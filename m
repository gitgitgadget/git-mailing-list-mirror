Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BBC3FE359
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 21:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788989983; cv=none; b=Pi20Y/U9W+ETLpDTrKOjq2pxJCucdh0a2WRzwDHSyXACXsPW+QvnHVoBorYpFWRgPsT9h0c7hXP4DTWn9D3EjFin2UtRyGD51Zz4eAZOwUiHBycWlIj00/Ac98rL8O8pfdCT5/6XGFymuk6jdaqNcmCCtO8b/KIV2suicMX/+9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788989983; c=relaxed/simple;
	bh=YAPmRhj4aolfFzOoE+bjAVRV9DPm5Dpl2f27jS+yxW0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=O9vpC86rxhUERGFTFfVuj15hBteVBR45SdT+cyb1+YWs8Kx4zKPhfypHQeFFlM734OaDQiUbp5nKQuA8GU1l+iYoX+umBdVq0othZofcLFjok5yHBsykcHdNyMrYRLrro6x1T/u4mjqZcfLAglT4gApwPQvNYJ9i5I8NUSYXX7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ASaUL+fl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fXRE8IvW; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ASaUL+fl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fXRE8IvW"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id A3EF5EC030A;
	Wed,  9 Sep 2026 17:39:31 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Wed, 09 Sep 2026 17:39:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788989971; x=1789076371; bh=WeCAevBK36
	tlaafgJ+zXgg3DquPmRCfZjiOSOyl1SMs=; b=ASaUL+flAhsCldo6z8RywSzLZz
	9lyu1iXM/ww+61HMHorTVSrdIrtYKHdXgV2pXFXVcPuCS1zX73yzyfXalQ/cSVop
	dq+BhK33PcZxQ1j1mRNh5kmc2shjF3z2aqoX7c9On5R57hLeTVFzqZntpXModS7W
	VZkuHLx5gYO7OnYKtLb40M/iGOdnl2LRY+ztXiWE71XiIEQPL2mW044wgmni+kVi
	HnMuKf6JTmoBa5hCTrn0jNZOGtgrFeX/sSi2940xDFmYY4mvQ6TjUlmrUGDrREl0
	IVmxGUfUKtyEkpqWPOgdAonbxoqp9yZrXmCOJs7WEIyYJOwncqzezwUDn5ng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788989971; x=1789076371; bh=WeCAevBK36tlaafgJ+zXgg3DquPmRCfZjiO
	SOyl1SMs=; b=fXRE8IvWyrqW+27HtkvqPP+vyem+N3f/sk6hyjbB0R4jS716emw
	2aSgL4gknHhFwGiL+Mxm7Rjt8BSCrBkoiKWnZWQ63r3rrD1BcasGHadMkHrlpvEa
	y8Vp0lpH5j8KXp0aJULepEmLUWiA0kzcd7s2kT92wYI3ubOGGLmnhvNFCBingaYq
	9wxrMZGQNOCDGL7ZEg0N9H7yjEo4zJRPuc7BiElA4Cu22BxRhL2NCo4UHAEzKEcB
	wqLWaqucOrClTsrzvcWxPP1PvihW3r6x+X+YdaKCNHnGB/StpncluscEDKSL6mcD
	dfXNxs/j/wqtVRjrlKtZbSWh+cujrNS3nBw==
X-ME-Sender: <xms:E9KhaoDA906jJREqu1Xg19lM-oXYJABPHnNWe0k8xsfajGrYbPii4Q>
    <xme:E9Khapnx2DotgylRSM4012TxKAlp6C9YH8TGBtZOkh7-WoaD-fUaOGmPl0al8-mDA
    Gp34TO8LFw9EZ_JL8sRh_n8hew_OYox7hj-H4rrepmIuNG1SjRNClcD>
X-ME-Received: <xmr:E9KhahwSB_IA9WE_mUJ4c3cdAj0E5WmrDU3obnwfjfhbiTrYGG6tcVYsmumweYjMENB2JLm1f0Wji_Vs1z6WjI47LXQqegM_ORs9>
X-ME-Proxy-Cause: dmFkZTFFwtdnPqSxV8GPLeQ0sRuur16Hn+AzdDLWM5U7GE1Oa0//mbiggqsKgiNZ51T8Ve
    QCVaNeArTW8Eb6oLOpkqa06gC4iU7AyviUA631Dsy990rXmm16FQDEx85xxmQmIZwP1oJy
    kl66Uh+rZVNu79tkk+j8sxHtWzoAp7Yforx4H5iqMPGgpaIYgLP0wLXm1VhsnUT0jlhNPy
    D9N3JPPZxjevc3Jn/hreRjiXCNr8bdyFB2qw12/zV+/qhxi8N37tD75AWiuzhZbvvmFvuN
    0HLS7DGHDg3XHOmwPQ2G9LFhqF0s/5hDYAkw+ZYsrEYtTjgDIQS53OM3y9MrbEOrRrV9ji
    IGW7CjSbzJg4eR0E22xiTGhaQeNIsDaCNlwAtCNCB/pS7v/2CFWt90BqaweoMQLv1Q8GIt
    2gEUwsWlZFBDYaKxESyIfj661GpYZTEdYSCbtOmWxv/Wu/AdpXZPDBBKqn5XMBtwiGD8OW
    PnsDjLxLi3KOgc2kWL+IVC/YXAT6Ka26RwBCtKIgjGCH0BNkOdrUcJIatDJm13nVvJMVHL
    Rysty5O6oPZnqMALJ44ekZ4/0s8hXBvGZjW36K99CHtjX6WO+F01RacthK/MTPF47nhkoE
    NoUCywq+cCmQJIc4Ya5NtUvVkTow7fzqrurXqhmUwR4h1x9llmxAaExHHcDQ
X-ME-Proxy: <xmx:E9KharT7ANaz5s4tb1bpDEKBJQ-hIAfvXJJUsYNv6kktPH5TUah6hA>
    <xmx:E9Khah9yvUoD3ScUBM-rntCu4mlPIiKkRYodwakqHhi1dElKeUtwBw>
    <xmx:E9Khahtvff7jN_ZnoBqNS_InI9odR3S4dJVIirHm4pO4IfprtdO7jg>
    <xmx:E9KhahPh4WZETQf8ry_VlN8SnGDxTfJNB-K77rXeJwYXKZI7QjrRRg>
    <xmx:E9KhasEfimzx0W3YB2PaPz6ujrxCiSJwEYjZQFTjHHPw3pFF7_k0w4kV>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Sep 2026 17:39:31 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  "brian m . carlson"
 <sandals@crustytoothpaste.net>,  Patrick Steinhardt <ps@pks.im>,  Karthik
 Nayak <karthik.188@gmail.com>,  Jeff King <peff@peff.net>,  Elijah Newren
 <newren@gmail.com>
Subject: Re: [PATCH v3 4/5] promisor-remote: prevent infinite recursion when
 lazy fetching
In-Reply-To: <CAP8UFD0WUQX4ts_US2Ehdp7hBmEs1_ztjJiGJMYA2ek4awduMg@mail.gmail.com>
	(Christian Couder's message of "Wed, 9 Sep 2026 12:00:51 +0200")
References: <20260813154748.2378747-1-christian.couder@gmail.com>
	<20260908164129.560396-1-christian.couder@gmail.com>
	<20260908164129.560396-5-christian.couder@gmail.com>
	<xmqqqzj3wr24.fsf@gitster.g>
	<CAP8UFD0WUQX4ts_US2Ehdp7hBmEs1_ztjJiGJMYA2ek4awduMg@mail.gmail.com>
Date: Wed, 09 Sep 2026 14:39:29 -0700
Message-ID: <xmqqa4pqp0j2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

> I agree that using a plain "int" seems like the most straightforward,
> but we don't have git_env_int() while we have git_env_ulong().
>
> So would you be fine with something like:
>
>     int depth = (int)git_env_ulong(LAZY_FETCH_DEPTH_ENVIRONMENT, 0);
>
> which is similar to the following in builtin/pack-objects.c:
>
>     name_hash_version = (int)git_env_ulong("GIT_TEST_NAME_HASH_VERSION", 1);
>
> ? Or do you think it's time to introduce git_env_int() in a preparatory patch?

There are 13 existing callers, among which one that you found
explicitly casts to int, but many others make assignments with
implicit cast (e.g., members of bloom_settings used in
commit-graph.c are of type uint32_t), and config.c reads
GIT_TEST_INDEX_THREADS into an "int val" with implicit cast.
progress.c:get_defalut_delay() does the same.

So I would say that it is up to you to pile on existing technical
debt by mimicking config.c:repo_config_get_index_threads() and
progress.c:get_default_delay(), or audit all callers of
git_env_ulong() and migrate appropriate ones among them to use
git_env_int().  From my cursory survey, I suspect that not many
callers of git_get_ulong() would survive.

Thanks.


