Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB523C945A
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 10:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773224681; cv=none; b=M85ldKMDjdWiK7+GBdDGOH/+PY/KvhBeVLenFpL2bMMPGr8Hobpy3AXkfJp45ZXjkKnL8Bp90kRX4JuYzuyWZ4ZA0TQlAzQHDU0RtvMYGMhDQei4hyuQXHt+hwmgJCZ8ypSz20EwQcg6XoI+z0FFjdKvWblZSizXAp59g1BOXTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773224681; c=relaxed/simple;
	bh=xstd7zcVHl3iCFNkJ9QYdIp4iUf2sA63tR/5tB4h/mY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=THU8fSGx7r2n+xlP+VKFVFnSPjzqtvx/l0PKT71gBJCvcUeZdhYSHR8WfJTWwaJpPMJqTZKE+ZRIsavNxRgKsr0/wZ32TbFcLLmXwUBI2LqEhoj0Huu7Mky3BetoeTF8lCOP/BFR2VlXiJ7w6VMg1iGnSYTP8mkCfyJdpX6WTLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WOPK2RQ9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=REP3cKbh; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WOPK2RQ9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="REP3cKbh"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id AB3561D001E1;
	Wed, 11 Mar 2026 06:24:39 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Wed, 11 Mar 2026 06:24:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1773224679; x=1773311079; bh=XMGiqrDS9h
	2i9mcXRr1/q1zQZH26xI2/VG/7HbqDrEM=; b=WOPK2RQ9H2uMX1Cq9a68T5MT8D
	frQ+nxu1I8JNy/y7upyAaeeu+Ss5pyZBlbwf7u/vzSnaIPcZCAtiFk001VF6i2YX
	8lWadnINJNq1cYtKgSI0ILF2EKtNB//8s8LUFvLlLeg//y9o9W4CSmq0mMBLVZKz
	LV9JY70hvOYrILJvIDq+irc9Xto7PSPUvaPVYWNN9jukRlstzvQ4OF63xxxhfYL8
	wdE7UW/ToCJ+BlPi8c9/M/l7plrIuHZd2YxJi5QhZI4LpxGLgGNLubuqfRpxVPVo
	KDMaBJ8qqNMu9rw8Cz1Xrn84uoUJ7K+iehBq75sk6znUt7nYnfBnPDEPbmCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773224679; x=1773311079; bh=XMGiqrDS9h2i9mcXRr1/q1zQZH26xI2/VG/
	7HbqDrEM=; b=REP3cKbhKA+EEXCivEQmSbkbfq2DMtTbdQoLYpwhFfGFBvDnBWL
	MEAYcQD1TyPhqax/ShFz3zEAIh7D3M/uzOeuGMORI7/naLr+ZWtKpctBRbeeqXn4
	6dxqIVMrjLhmlKgrCHYl1McYSkFwZGRRagEC20YpscLdRbV1iuOfP9x9omussJdF
	T3fPJ8Vjcix3/Km0XbGq3ykwzk5WCuznw5Ut7tn3iEtPva4OqgY1O6jxzh4A2Bod
	g5ZQLdEmw+sUzEZf6x6VLncuLgVqvGn05Uq18tsoD4cbw/mdn44gkZ38Ke1Q5I5K
	eMW+8BmGUjOr+0camvcUaFFqudgPJXa8Y9g==
X-ME-Sender: <xms:50KxaaCzSwEHKHccs0PlStGn1e6I0-qOAUWq13-kJ9AiLUjwTFQWYA>
    <xme:50KxabYhSgNwmRaRruZUBUsttH2f-k74d_9Nx80zC4JKZ-iJMffb9DTCV4l0KYBJD
    hkojrRPYvheeuVZodRDedINbWu3AbKbapyBnb1Ca7SdDNstERJPLMk>
X-ME-Received: <xmr:50KxaV5xtItbqxVKCA5GxK1nDecigkXqOlnGf8o2FVfZ_EoyyF62b0f5E32JXqMGEojMsInitv1Kj8YT2K_GDRR2Dv0dD6b6gjvLyD7sgQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeefieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepvghmihhlhihshhgrfhhfvghrsehgohhoghhlvgdrtghomhdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgrnhgurghlshestghr
    uhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomhdprhgtphhtthhopegrughrihgrnhdrrhgrthhiuhestgholhhlrggs
    ohhrrgdrtghomh
X-ME-Proxy: <xmx:50KxaUbj9yW5LDzrC-9ynJgDD23uNtMtBhJNuPj9VtwI_-aP3WAhmQ>
    <xmx:50KxachlWk6XsAoRoGegrv6jf2Jm8CctgBhZCpDrGlPiGYxQlz9iXA>
    <xmx:50Kxad9fS9xRf4VVwduHRZ5W6xTTV1mehkMkUjOon3Tbu1BF8ErDDw>
    <xmx:50KxafpzB54uzqSy4EzkPCWZLlLDUaOl6VAHQvx8CFh4UMmuiQstoA>
    <xmx:50KxaZPPRnuF2qmCe3UeIQv4QBI4U3yFRT5QqO7fHrO6s3aY-F0Pc8oF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Mar 2026 06:24:38 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a8c4d101 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 11 Mar 2026 10:24:37 +0000 (UTC)
Date: Wed, 11 Mar 2026 11:24:34 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 09/10] hook: show config scope in git hook list
Message-ID: <abFC4uLP-JwDoKde@pks.im>
References: <20260309005416.2760030-1-adrian.ratiu@collabora.com>
 <20260309005416.2760030-10-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309005416.2760030-10-adrian.ratiu@collabora.com>

On Mon, Mar 09, 2026 at 02:54:15AM +0200, Adrian Ratiu wrote:
> diff --git a/builtin/hook.c b/builtin/hook.c
> index 8fc647a4de..c806640361 100644
> --- a/builtin/hook.c
> +++ b/builtin/hook.c
> @@ -70,7 +73,14 @@ static int list(int argc, const char **argv, const char *prefix,
>  			printf("%s%c", _("hook from hookdir"), line_terminator);
>  			break;
>  		case HOOK_CONFIGURED:
> -			printf("%s%c", h->u.configured.friendly_name, line_terminator);
> +			if (show_scope)
> +				printf("%s (%s)%c",
> +				       h->u.configured.friendly_name,
> +				       config_scope_name(h->u.configured.scope),
> +				       line_terminator);

Are we sure that this is always unambiguous? Can the friendly name for
example contain a space itself, or is it possible that the scope gets
extended eventually so that parsing becomes ambiguous?

I'm not sure about this myself, but that may indicate that we should
maybe also separate the name and scope with a NUL byte.

> diff --git a/hook.c b/hook.c
> index 4fe50aa38c..2c03baeaac 100644
> --- a/hook.c
> +++ b/hook.c
> @@ -172,7 +172,19 @@ static int hook_config_lookup_all(const char *key, const char *value,
>  
>  			/* Re-insert if necessary to preserve last-seen order. */
>  			unsorted_string_list_remove(hooks, hook_name, 0);
> -			string_list_append(hooks, hook_name);
> +
> +			if (!ctx->kvi)
> +				BUG("hook config callback called without key-value info");
> +
> +			/*
> +			 * Stash the config scope in the util pointer for
> +			 * later retrieval in build_hook_config_map(). This
> +			 * intermediate struct is transient and never leaves
> +			 * that function, so we pack the enum value into the
> +			 * pointer rather than heap-allocating a wrapper.
> +			 */
> +			string_list_append(hooks, hook_name)->util =
> +				(void *)(uintptr_t)ctx->kvi->scope;
>  		}
>  	} else if (!strcmp(subkey, "command")) {
>  		/* Store command overwriting the old value */

Okay. This is a bit ugly, but I guess it should work in practice? The
alternative would be to allocate the scope and store the pointer here.

Patrick
