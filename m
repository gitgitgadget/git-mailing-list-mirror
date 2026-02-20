Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182DF189F30
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 12:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771591576; cv=none; b=Q5/LiOaY4CE6ZO2qCm6K8hjw9Ximl6bMy0XVG4bX5ameU7n3CeKtvXI4+tnRi+S5Gn0CquiazR50xzC030IJe7MCCKQOxv8sZuca9nN+XTxhVVfLbLcbj0U9S2pjvigiviCg7qs1QlWLNAPV6hssFHGpZKVpF9WWoJH7xwYw7vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771591576; c=relaxed/simple;
	bh=koUdjjQDd57rC+EuMXEohQNuSszuJZX3crh8W3q+NTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lyeuON2ZAg51Yh/4dnRySs2RFjBIEL+i6sh7YL+EttXQnxqAVbOCKTtau05lm+1mnB6LHtngcbTSwkuKJtScCHtkxC75fOlPW7aKxsMUgGDYrdtEKfjqNXJEdSlbqq0XTVoP0u/sn0lCivp50zTxy9nxnb17rgNsyANRQiIja9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=O/ayu8MJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Zose4IwB; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="O/ayu8MJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Zose4IwB"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id E920C1D001E1;
	Fri, 20 Feb 2026 07:46:13 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 20 Feb 2026 07:46:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1771591573; x=1771677973; bh=NtDoYA166w
	WvFB23jjoK8ed9jHnoveVkz+bzAeWYl6c=; b=O/ayu8MJHLecRSp3Cg7/zaNqys
	5Z20W3/MfJN0uVSlma040/7BH+cHCxHw6BcQzTxqgNFzvKMBpn7rdp0ELVvFVbfG
	wdIgt3fnHAm1NImeAlEN9KAVH9ikVtyi+hSZyu5s4By08oTzVvsZGw+wrrZv3zBB
	KT8j61MshP3wnY/Lboo/bfWrZoPgOxopwcvYa1WsmGYre/y7tD9FGi6cg2xHCXO8
	Vs9TSFBe9A979Ct5GaFxIJWGLUqfVxlQqG4S2AuXnQkSkUc7xJMALAx8+4l+5R+T
	e9/nVB67fAFa4iVpxSYfbixy+3YNoNFK/WwNjstXkfOqPuuqhRTQmxDt1CUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771591573; x=1771677973; bh=NtDoYA166wWvFB23jjoK8ed9jHnoveVkz+b
	zAeWYl6c=; b=Zose4IwBCCtXCRFHWjoNCWKTRG+paoK2vEl5ELjWZAV0MEPVC5e
	zTc0GQsh97RfKP8Xal6KdjGszJssvwbuJtujHf7reRL1N75MxLc/tigbs/3ShlVR
	gdIXGmwpeySgs0totSyBWzT+iucI3tvFVI8x8m7KHL0ji3dJkGMlM7p5zpJvaWEK
	XZFjANZZEV0WMRJT8xjhJ+JHb/2whY/xJ3P0YaTd9yZ+u9jnPuSeWEDWRi+J/XbK
	uYV16Y7U37k8+EyZxTYepwyRti2cxu8Ne8U/89YNbDRk+mMkWFjQ8jKP47bo2mQK
	kxIvLLAR60jxdrR65NRFFQ216rkohXATMIw==
X-ME-Sender: <xms:lVeYaaVGZ-U3sME8AIrYbix97fqbiH0JVLNf_7kuaUqKksDMhmIjWQ>
    <xme:lVeYaY1WW6sLbUIbB7wPDn_jCpsbb-Ark5BT-7kGbEH8phuJ7_EWPOuVD11UWGYHY
    v2kzRnG-uTMqb9j_1Tc1KmQITgUaZplSvDC3CA4eeQ470Dukdme4w>
X-ME-Received: <xmr:lVeYaQpk5gC1Q_Mm33r0RE6UlLUHxdYxcDVjAN46aEkoGGYanfM00x69fAcETFSsl96wcWcxFPGDFcgpHcQSKu9yhAMbTiG-i9HFOd5KQOTl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdekgeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtrodttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epjedttdegffekudejjeegudehgfehtdfgtdeiudelueelgfeuteehledugeeuueevnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgr
    shhtmhgrihhlrdgtohhmpdhrtghpthhtohepshhtvggrughmohhnsehgohhoghhlvgdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepvghmihhlhihshhgrfhhfvghrsehgohhoghhlvgdrtghomhdprhgtphhtthhopegrug
    hrihgrnhdrrhgrthhiuhestgholhhlrggsohhrrgdrtghomh
X-ME-Proxy: <xmx:lVeYaXUC4dMZ34QXiIkbrAQI8qpY1k5ddDUKZSsrFwb2yNUOBmOW0g>
    <xmx:lVeYaTb-k2CkNY-sUWfG_fYiAxxhRUu4_NbBtYJDNmVZ2JUsSnmItg>
    <xmx:lVeYaccgfZVINrdQWHN_lLVJKEF4cbads-kJ-ddXofCWvf1om5F3hA>
    <xmx:lVeYaV0aCE-Q2QplRF5WFlOnglxGxmZEtBW6x1YV4EfvuKNZTqZC9Q>
    <xmx:lVeYaRoXWnbtjpgRg9dfBdhWWsxWe5jpUGP7htlj1zEk-vRnrXIaqqhA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Feb 2026 07:46:12 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8364365c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Feb 2026 12:46:11 +0000 (UTC)
Date: Fri, 20 Feb 2026 13:46:08 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Josh Steadmon <steadmon@google.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v2 2/8] hook: run a list of hooks to prepare for
 multihook support
Message-ID: <aZhXkDtNvcNpXgpJ@pks.im>
References: <20260204165126.1548805-1-adrian.ratiu@collabora.com>
 <20260218222352.55393-1-adrian.ratiu@collabora.com>
 <20260218222352.55393-3-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260218222352.55393-3-adrian.ratiu@collabora.com>

On Thu, Feb 19, 2026 at 12:23:46AM +0200, Adrian Ratiu wrote:
> diff --git a/hook.c b/hook.c
> index 83ff658866..c008a7232d 100644
> --- a/hook.c
> +++ b/hook.c
> @@ -47,9 +47,97 @@ const char *find_hook(struct repository *r, const char *name)
>  	return path.buf;
>  }
>  
> +static void hook_clear(struct hook *h, cb_data_free_fn cb_data_free)

Nit: this should be called `hook_free()` as it also frees the struct
itself.

> +{
> +	if (!h)
> +		return;
> +
> +	if (h->kind == HOOK_TRADITIONAL)
> +		free((void *)h->u.traditional.path);
> +
> +	if (cb_data_free)
> +		cb_data_free(h->feed_pipe_cb_data);
> +
> +	free(h);
> +}
> +
> +static void hook_list_clear(struct string_list *hooks, cb_data_free_fn cb_data_free)
> +{
> +	struct string_list_item *item;
> +
> +	for_each_string_list_item(item, hooks)
> +		hook_clear(item->util, cb_data_free);
> +
> +	string_list_clear(hooks, 0);

We have `string_list_clear_func()` to perform a deep free for you.

> +}
> +
> +/* Helper to detect and add default "traditional" hooks from the hookdir. */
> +static void list_hooks_add_default(struct repository *r, const char *hookname,
> +				   struct string_list *hook_list,
> +				   struct run_hooks_opt *options)
> +{
> +	const char *hook_path = find_hook(r, hookname);
> +	struct hook *h;
> +
> +	if (!hook_path)
> +		return;
> +
> +	h = xcalloc(1, sizeof(struct hook));

Better: CALLOC_ARRAY(h, 1);

> +	/*
> +	 * If the hook is to run in a specific dir, a relative path can
> +	 * become invalid in that dir, so convert to an absolute path.
> +	 */
> +	if (options && options->dir)
> +		hook_path = absolute_path(hook_path);
> +
> +	/* Setup per-hook internal state cb data */
> +	if (options && options->feed_pipe_cb_data_alloc)
> +		h->feed_pipe_cb_data = options->feed_pipe_cb_data_alloc(options->feed_pipe_ctx);
> +
> +	h->kind = HOOK_TRADITIONAL;
> +	h->u.traditional.path = xstrdup(hook_path);
> +
> +	string_list_append(hook_list, hook_path)->util = h;
> +}
> +
> +/*
> + * Provides a list of hook commands to run for the 'hookname' event.
> + *
> + * This function consolidates hooks from two sources:
> + * 1. The config-based hooks (not yet implemented).
> + * 2. The "traditional" hook found in the repository hooks directory
> + *    (e.g., .git/hooks/pre-commit).
> + *
> + * The list is ordered by execution priority.
> + *
> + * The caller is responsible for freeing the memory of the returned list
> + * using string_list_clear() and free().
> + */
> +static struct string_list *list_hooks(struct repository *r, const char *hookname,
> +			       struct run_hooks_opt *options)
> +{
> +	struct string_list *hook_head;
> +
> +	if (!hookname)
> +		BUG("null hookname was provided to hook_list()!");
> +
> +	hook_head = xmalloc(sizeof(struct string_list));

CALLOC_ARRAY(hook_head, 1);

> @@ -85,21 +176,20 @@ static int pick_next_hook(struct child_process *cp,
>  	cp->trace2_hook_name = hook_cb->hook_name;
>  	cp->dir = hook_cb->options->dir;
>  
> -	strvec_push(&cp->args, hook_path);
> +	/* Add hook exec paths or commands */
> +	if (h->kind == HOOK_TRADITIONAL)
> +		strvec_push(&cp->args, h->u.traditional.path);

Should we be defensive here and have an `else BUG()`?

> diff --git a/hook.h b/hook.h
> index a6bdc6f90f..3256d2dddb 100644
> --- a/hook.h
> +++ b/hook.h
> @@ -2,9 +2,41 @@
>  #define HOOK_H
>  #include "strvec.h"
>  #include "run-command.h"
> +#include "string-list.h"
>  
>  struct repository;
>  
> +/**
> + * Represents a hook command to be run.
> + * Hooks can be:
> + * 1. "traditional" (found in the hooks directory)
> + * 2. "configured" (defined in Git's configuration, not yet implemented).
> + * The 'kind' field determines which part of the union 'u' is valid.
> + */
> +struct hook {
> +	enum {
> +		HOOK_TRADITIONAL,
> +	} kind;
> +	union {
> +		struct {
> +			const char *path;
> +		} traditional;
> +	} u;
> +
> +	/**
> +	 * Opaque data pointer used to keep internal state across callback calls.
> +	 *
> +	 * It can be accessed directly via the third hook callback arg:
> +	 * struct ... *state = pp_task_cb;
> +	 *
> +	 * The caller is responsible for managing the memory for this data by
> +	 * providing alloc/free callbacks to `run_hooks_opt`.
> +	 *
> +	 * Only useful when using `run_hooks_opt.feed_pipe`, otherwise ignore it.
> +	 */
> +	void *feed_pipe_cb_data;
> +};

Makes sense to wrap all of this in a specific data structure.

Patrick
