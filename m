Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AD234D934
	for <git@vger.kernel.org>; Tue, 24 Mar 2026 08:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774341486; cv=none; b=gWntybJ2+eGd03kb+eCxpq/R8N7T9XHvQQSBfMouzJAuncNXoHHeplOtA3s8xzpGognJsZQ9rs/kiIkYUVobubv3Wo8AKCMJeXTH6H2WtyNBGxmdA4yaOurg9FmEHzrxCGb5zRay/1QReW0mKgwWBdFhzaUXYs4rHwfYSmB9ISM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774341486; c=relaxed/simple;
	bh=zzbpqhaU7yPQ+RXdWNzUa//BHqxNaNT05dQSj8FFM5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V3iphtaP7l1K/uur4KHLT/P5HJeZSY7hjzjkv/3qr9hTmH1kbRHWOHXrztrRQVUnwTA610O7ALEoAYBE4IhlIQ/laJrvRRU7mkIG8tOX/yWiKRBamxNemnNLxaPpwp/CEFIGqa9lFgTtyiy4ho50GSf/akiUGVD80Wj4SYCIid4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ro5BTO9G; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=v899oAiO; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ro5BTO9G";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="v899oAiO"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 4BF40EC01E1;
	Tue, 24 Mar 2026 04:37:53 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 24 Mar 2026 04:37:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1774341473; x=1774427873; bh=Naba+PGAaG
	+tFj+0n4hXLG4oPCgor5AgvwV/Fywavdg=; b=Ro5BTO9G90VfvyG3MRH9KbEHC+
	jHJAEnGh9qkCAXY1MfZkrr1hBGV3nXcpH0epDnGWIjPnq7udqCwHeIg30KwX1lTt
	b2mZKSaqeIwLUhsCfnXBVeSmg5+6b0GCRYjVjCe4VcSKVZvSqOw9QV1viiqFRtFn
	Z/n56ExQRdGR/IwSmOdpy1+P1TuHh9tL/ltvUUyEWO3F+c7wGG6N9rnAHxNJhPGe
	dFKFk/O6mrzGzM4HZ7U4CJCsouw7dgMfR740IJnuvVWhddPivp+5iUjCKUqnQBB1
	ytAF6BIiuh9bmRhwozvO5/HauPNB2vTGioR12W2Oi+b1RaeAMt4CkOlH+6Xg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774341473; x=1774427873; bh=Naba+PGAaG+tFj+0n4hXLG4oPCgor5AgvwV
	/Fywavdg=; b=v899oAiOHRl0JXVs84SUDI/ceQOX5MlV+LI6d2JwZhfUMj2PCRS
	MgKn/NLp81Z6OLKMp03syDReHyIcyrL/ZYVctiIx/23ZtwDWN3dBCto/gOcvukXB
	Y94LLscxK4/LqToYTDaztOIQ/Q7qMrXCI6NtWwQchTjnqEP+8c8SnJa4yIC8tCge
	cojDUg/aLEQQKJEpVWPWrNwKTLQBLlbeyBTm17BXXtnmWNZ6FuY1Cr2hM13aaYEy
	pinW2btsyiifTiE9Wq24gIxdQSHsS/Mr4Z6cKGbohIGvWOP6u0Ti5Vd8kjf1eSwW
	IzHvYNeUEwaY57XQsheyy8X9UZdymUVquUg==
X-ME-Sender: <xms:YE3Cafv2USg6gTkvYY_xIhHl4ivR3o3yYB5QLyvG8LbbIZNK1WzNmw>
    <xme:YE3CaULsoB9GF4o2sIESiIh4Pv7dtd-Cy9lK-7byO1FcX3z4bjvgpRF2RoyMVsUgH
    MFfPtmmXmqYi9S0sHPjdwiUbdtHByr4ZQ7iofSxc0Lgi6b5x4OEkQ>
X-ME-Received: <xmr:YE3Cack-Y11VV-9DiByrmdPWpyCbZNDwM3yCJuBawN6ZBY2Ou-FgsU9ZJKXDpYpQ5wEL_kQgCYV9ZmHyZQA12DFliOCfxkk4jF80Zj6imkKpaA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdduuddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopegvmh
    hilhihshhhrghffhgvrhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhmpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgv
    rdhnvghtpdhrtghpthhtoheprggurhhirghnrdhrrghtihhusegtohhllhgrsghorhgrrd
    gtohhm
X-ME-Proxy: <xmx:YE3CaVLB4wDjQp66-teYfk9PMM2M2hUN4QuVQq0M0o_Fvb3MKecE-w>
    <xmx:YE3CaR7LtrqhMrmmQsQ1d63rcT_swsq_quhXksO7CdAcUONAVJ_GLQ>
    <xmx:YE3CaZ2OKY3PChIZZXOQgFSB1c9BriYBh8aGlNvkkfNxwgHXIw0Jdg>
    <xmx:YE3CaXc9lx3DDpQ8TgtH8T_PJN-LPvHpIpve9bei-3Dvv6ZwINcBkg>
    <xmx:YU3CaQ4FjF8ALXco109q5-1hZ_svYJYgnHGgXCSmHaPJ-aQuH0Zjyg7T>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Mar 2026 04:37:51 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bd5c0ee3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Mar 2026 08:37:50 +0000 (UTC)
Date: Tue, 24 Mar 2026 09:37:47 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 02/10] hook: fix minor style issues
Message-ID: <acJNW0m2wHfRStqY@pks.im>
References: <20260309005416.2760030-1-adrian.ratiu@collabora.com>
 <20260320115211.177351-1-adrian.ratiu@collabora.com>
 <20260320115211.177351-3-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320115211.177351-3-adrian.ratiu@collabora.com>

On Fri, Mar 20, 2026 at 01:52:03PM +0200, Adrian Ratiu wrote:
> Fix some minor style nits pointed by Patrick, Junio and Eric:

Tiny nit, not worth rerolling over: "pointed out by"

> diff --git a/builtin/hook.c b/builtin/hook.c
> index 83020dfb4f..e641614b84 100644
> --- a/builtin/hook.c
> +++ b/builtin/hook.c
> @@ -5,8 +5,6 @@
>  #include "gettext.h"
>  #include "hook.h"
>  #include "parse-options.h"
> -#include "strvec.h"
> -#include "abspath.h"

Another thing we could address while at it is to sort the headers
(except "builtin.h" of course). Feel free to ignore though.

> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index e34edff406..991d6ca7d5 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -904,7 +904,8 @@ static int feed_receive_hook_cb(int hook_stdin_fd, void *pp_cb UNUSED, void *pp_
>  static void *receive_hook_feed_state_alloc(void *feed_pipe_ctx)
>  {
>  	struct receive_hook_feed_state *init_state = feed_pipe_ctx;
> -	struct receive_hook_feed_state *data = xcalloc(1, sizeof(*data));
> +	struct receive_hook_feed_state *data;
> +	CALLOC_ARRAY(data, 1);

I think it might help the reader to have an empty line between variables
and logic.

> @@ -928,7 +929,11 @@ static int run_receive_hook(struct command *commands,
>  {
>  	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
>  	struct command *iter = commands;
> -	struct receive_hook_feed_state feed_init_state = { 0 };
> +	struct receive_hook_feed_state feed_init_state = {
> +		.cmd = commands,
> +		.skip_broken = skip_broken,
> +		.buf = STRBUF_INIT,
> +	};

Interesting. The buffer here isn't only a style fix, but an actual bug
fix, isn't it?

> diff --git a/hook.c b/hook.c
> index 67cc9a66df..349db729f6 100644
> --- a/hook.c
> +++ b/hook.c
> @@ -227,7 +227,8 @@ static void build_hook_config_map(struct repository *r, struct strmap *cache)
>  	/* Construct the cache from parsed configs. */
>  	strmap_for_each_entry(&cb_data.event_hooks, &iter, e) {
>  		struct string_list *hook_names = e->value;
> -		struct string_list *hooks = xcalloc(1, sizeof(*hooks));
> +		struct string_list *hooks;
> +		CALLOC_ARRAY(hooks, 1);
>  
>  		string_list_init_dup(hooks);
>  

Same nit here: I'd move the empty line to come before `CALLOC_ARRAY()`.

> @@ -311,7 +312,8 @@ static void list_hooks_add_configured(struct repository *r,
>  	for (size_t i = 0; configured_hooks && i < configured_hooks->nr; i++) {
>  		const char *friendly_name = configured_hooks->items[i].string;
>  		const char *command = configured_hooks->items[i].util;
> -		struct hook *hook = xcalloc(1, sizeof(struct hook));
> +		struct hook *hook;
> +		CALLOC_ARRAY(hook, 1);
>  
>  		if (options && options->feed_pipe_cb_data_alloc)
>  			hook->feed_pipe_cb_data =

And here.

None of my nits are really important, so please feel free to address or
ignore them as you like.

Patrick
