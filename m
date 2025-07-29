Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5C8220F4C
	for <git@vger.kernel.org>; Tue, 29 Jul 2025 16:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753807709; cv=none; b=mxZcm44OcRZILiMnDMaq2XvoK0PGkPoKCzCem2MvT9n6sCj52GSGzbI0bA5AgeTXhoDFXyEHaZ/6V9V9ZuZPSv/pOs+s/+EmCQ4AEYhm483qyM5OBh8EBzZpyr5WOcJCBr4UJZU5ZcC1NGip2fOgkWcBpJP2XgkXABMkN4vwShU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753807709; c=relaxed/simple;
	bh=O3UhavLI2PSm3WQa08mAaP5beSgJEPxeWqXOqnXAdnk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CLca2kZCXzqnXFLHoyLW5gHqhm+U+8lnwl3hQpbVGQVgLZJgLNeAdOvz35LoLQ84eAlOeHkXZCo0jc5gQKT0D1u4lFmrYpvBsus1KYhL1JvD4lo9yE39eYRsZ1DLITbpviJVTKijabSBEyumvuE6sBdCXO+1RfZ3JWdQxgVMh64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mEyjeULS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FolFiOS7; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mEyjeULS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FolFiOS7"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id DA5F51D00B74;
	Tue, 29 Jul 2025 12:48:26 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Tue, 29 Jul 2025 12:48:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1753807706; x=1753894106; bh=yW6QlmW+BU
	txBkbTFHBfidPm3Cq6L4RWVrSkPZGeilI=; b=mEyjeULSM2EkGKKNTuYSmTnyc7
	bS07zzie18Pb0DMBYPsbTlnZD2VikzfQo5cfMlvyfngXnEVFIlqoSKKj+wWsMExg
	K+/Np54rw1zlnewrwKrWLvfcWmrbHb4P8RZK2Bi/OTSmdOx9qCTZvzWq5h2GR4yZ
	fqGVx9zFHC27i+k9dTI0soFjfsFWBviCoPKgYPu6pQww+PcQUAC7tKexb2SRTKqG
	ErH3v18XNKUTrkQwQTz7HmH0liAdZRLTeKw7utdMPlstUzJjoRGG/LmpybTevDk3
	zVJFP3wdCtQp7jKFY9R4ys098fqrA1PfpxbkO1mXvCvwQ4/eN8ZuBUBsxxRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1753807706; x=1753894106; bh=yW6QlmW+BUtxBkbTFHBfidPm3Cq6L4RWVrS
	kPZGeilI=; b=FolFiOS7lO3YDU2KEdxLloHiMWGvNJOqE7i2LzO3QCwluAL2B7a
	r2ov48mO89TIffg1H1DnvHSjFBZK5iPIA+LzJxPlLzXpJvxPRCf4tGfvBSr+z5AH
	tZ5iKbn/59VCC2sy4YmsQ3/F+CtsNvfbJ1KfN8OLGWFq6pHGpp08ZuO2KBm3WEdT
	MrJuFJw+FDf5mNCaqy9j8/3xFl+fvQNWDZ9dmUub7NK9gwNsQ22W3BjpzFhYkbFg
	0EqoT4gP3ny7hWMsCbZYqMEzmLkbFfnfta9rR0QZDGeIak2aSHq9GsjyVYXjdiRG
	5d16zTkt/V8jt+B+n8ZOgx15vBTCsN22+jg==
X-ME-Sender: <xms:WvuIaLBX3oHO_ccYoLhM_zyvhrXh6xgSe9Kc6VxP7XCs6Wq_JQWxXg>
    <xme:WvuIaNAIxifmaIA4c09xzR-d2b2OzvvBaBKMLUBNoeUwZBFUQXsy51Z74SGRnVYn3
    J72khwya1WEHPuJxw>
X-ME-Received: <xmr:WvuIaNDKneC0teYpUDQbrrs5agsl4kp-VjedBmBgDOVOLA1h-mLaCELudbHprsB3wNUU1Bphhn6TxokgMT0_D6JRg3YxMmoOhqKO_t0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelheehjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdfotddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfefiedvudegfffgffffveevvdeileff
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegrhihurdgthhgrnhguvghkrghrsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhope
    hshhihrghmthhhrghkkhgrrhdttddusehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:WvuIaIr3O_TkOxz58U0c1ViADYA2Z-MlEOmkIiNb2N9TFT4NdN98uw>
    <xmx:WvuIaHm7IsFU9s8PkV7K24DyMvrNkTE9qvz97nuwS-mgSBuzneU-Vg>
    <xmx:WvuIaIzQ_Yexz8n6KOsDYRyaqntddKz_JI6nw8n_trTRqpirvZXokA>
    <xmx:WvuIaP_U8JDGX0XZewMhMi6IHfUUKSlkPo7WnXyv5LoEj7qKOJLlSQ>
    <xmx:WvuIaIBJjYecVRNfHCXibBuZm0ZqKhouyVqyThjjUPsOgDcX3h9TaNMz>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Jul 2025 12:48:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ayush Chandekar <ayu.chandekar@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,
  shyamthakkar001@gmail.com
Subject: Re: [GSOC PATCH 1/2] environment: remove the global variable
 'merge_log_config'
In-Reply-To: <c82620a1f54ea6760bff204fd2b5fe5c2df1896c.1753804956.git.ayu.chandekar@gmail.com>
	(Ayush Chandekar's message of "Tue, 29 Jul 2025 21:49:34 +0530")
References: <cover.1753804956.git.ayu.chandekar@gmail.com>
	<c82620a1f54ea6760bff204fd2b5fe5c2df1896c.1753804956.git.ayu.chandekar@gmail.com>
Date: Tue, 29 Jul 2025 09:48:24 -0700
Message-ID: <xmqqfrefosdj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ayush Chandekar <ayu.chandekar@gmail.com> writes:

> The global variable 'merge_log_config', set via the "merge.log" or
> "merge.summary" settings, is only used in 'cmd_fmt_merge_msg()' and
> 'cmd_merge()' to adjust the 'shortlog_len' variable.
>
> Remove 'merge_log_config' and introduce a function
> 'adjust_shortlog_len()' in fmt-merge-msg.c to handle the 'shortlog_len'
> variable.
>
> This change is part of an ongoing effort to eliminate global variables,
> improve modularity and help libify the codebase.

And the downsides of this change are...?

One obvious behaviour change I can see can happen when you have an
invalid value set to merge.summary and run the command with command
line override with the "--log" option.  In the current code, the
config callback barfs when it notices an invalid merge.summary
setting, even though it won't be used because the valid value given
via the "--log" option would override it.  In the updated code,
adjust_shortlog_len() would short-circuit and does not even bother
reading from the configuration, so the user will not be notified of
a broken configuration.

It is not immediately obvious if this particular behaviour change is
a regression or an improvement, but it probably deserves to be noted
somewhere to help future developers what our thinking was.

> @@ -26,14 +26,7 @@ static struct string_list suppress_dest_patterns = STRING_LIST_INIT_DUP;
>  int fmt_merge_msg_config(const char *key, const char *value,
>  			 const struct config_context *ctx, void *cb)
>  {
> -	if (!strcmp(key, "merge.log") || !strcmp(key, "merge.summary")) {
> -		int is_bool;
> -		merge_log_config = git_config_bool_or_int(key, value, ctx->kvi, &is_bool);
> -		if (!is_bool && merge_log_config < 0)
> -			return error("%s: negative length %s", key, value);
> -		if (is_bool && merge_log_config)
> -			merge_log_config = DEFAULT_MERGE_LOG_LEN;
> -	} else if (!strcmp(key, "merge.branchdesc")) {
> +	if (!strcmp(key, "merge.branchdesc")) {
>  		use_branch_desc = git_config_bool(key, value);
>  	} else if (!strcmp(key, "merge.suppressdest")) {
>  		if (!value)
> @@ -645,6 +638,27 @@ static void find_merge_parents(struct merge_parents *result,
>  	result->nr = j;
>  }
>  
> +void adjust_shortlog_len(struct repository *r, int *shortlog_len)
> +{
> +	const char *keys[] = { "merge.log", "merge.summary", NULL};
> +	
> +	if (*shortlog_len >= 0)
> +		return;
> +
> +	for (const char **key = keys; *key; ++key) {
> +		int is_bool, value;
> +		if (!repo_config_get_bool_or_int(r, *key, &is_bool, &value)) {
> +			if (!is_bool && value < 0) {
> +				error("%s: negative length %d", *key, value);
> +				return;
> +			}
> +			*shortlog_len = (is_bool && value) ? DEFAULT_MERGE_LOG_LEN : value;
> +			return;
> +		}
> +	}
> +
> +	*shortlog_len = 0;
> +}
>  
>  int fmt_merge_msg(struct strbuf *in, struct strbuf *out,
>  		  struct fmt_merge_msg_opts *opts)
> diff --git a/fmt-merge-msg.h b/fmt-merge-msg.h
> index 73ca3e4465..f54f00d26f 100644
> --- a/fmt-merge-msg.h
> +++ b/fmt-merge-msg.h
> @@ -2,6 +2,7 @@
>  #define FMT_MERGE_MSG_H
>  
>  #include "strbuf.h"
> +#include "repository.h"
>  
>  #define DEFAULT_MERGE_LOG_LEN 20
>  
> @@ -12,9 +13,9 @@ struct fmt_merge_msg_opts {
>  	const char *into_name;
>  };
>  
> -extern int merge_log_config;
>  int fmt_merge_msg_config(const char *key, const char *value,
>  			 const struct config_context *ctx, void *cb);
> +void adjust_shortlog_len(struct repository *r, int *shortlog_len);
>  int fmt_merge_msg(struct strbuf *in, struct strbuf *out,
>  		  struct fmt_merge_msg_opts *);
