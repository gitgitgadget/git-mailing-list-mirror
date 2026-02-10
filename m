Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41312226D18
	for <git@vger.kernel.org>; Tue, 10 Feb 2026 23:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770765448; cv=none; b=lT3032PJUZ84enkIkgBIi1oil1bcsrO3QpZgcN7FIY8At8BkkfmtrvLjmTiipU3euHf4yuHQ/yphIryVpjD9WTvD/+0Dj+/4ES4LBqZfFqIyIBS4Eq8cMjYrRuBJN0MG+Uw6REnXSsWU/6zLSL3Q9UK4kkMfkNhJ4E9yHbi/nWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770765448; c=relaxed/simple;
	bh=7RPIpq8jlqW3uR8X3AdJDJPKltespDkrdPwttpFI9xU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ia/TlfEeWHwg8RisvcjdKIR3ItmceXQ+LBZe/NNrGLxptVgoOszvTNTYbJbEw7eq5mM4J2zEhjAS+POt+tU5Azl0L+GYi6s6GETs8vmCvtTlBz99eDV3KYa7EB4FbzJD4rqVFrUKvYNJP8g0VcWluG/99ZM7Nir24b3y5kyZ3rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LsoXzCp9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OEocTDgs; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LsoXzCp9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OEocTDgs"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 488D87A0095;
	Tue, 10 Feb 2026 18:17:25 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 10 Feb 2026 18:17:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770765445; x=1770851845; bh=kpHKygwhU9
	vq3fXsdeuNmnhU8OeQbIfbFhWvWRiGe/E=; b=LsoXzCp9KKeQ/8ZFZBwCboZXlJ
	zuyuCFRwTRbPgKVwYUjiAheRkgNIFQBUiOwt1nOCOyEzMJXB6US1ZZ1aU3rLYEsb
	uXktA/Vzl3k30iJY/wy2VeYJIvwyZXZLxKUysijLg3vbbpbfGeIYV4tQ8Z11Ufnl
	4Y++jiNBd/lLj2xsJHFAvTk5qs5VbcclM/S558YCM2y/ai/NoU2zD2xkMCAcxUpy
	DkVWu+v4vI6lT9uZpiXS8aHgLZW3TdGT6rnDNhLO1HZnsIehwGeNtCCnPzqlkVSk
	IWEfkWNxzajSIoEswD3dTGeLdkWDjDNr0Y3H3Ah3GQZTULQ48szEKn5Hm2eg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770765445; x=1770851845; bh=kpHKygwhU9vq3fXsdeuNmnhU8OeQbIfbFhW
	vWRiGe/E=; b=OEocTDgs3jU9Xj37gOuqDZa6/9rVnRWSXMJBV8iOm51DU1/U6jr
	O9ZD/yy+ZfJ8jKaVm1/gdnwWP+if5GjnRJww5NGJ6ClP9jGKPIqjCHRDw9RGNKE+
	yhv4OP1fKrIkutKfl3+APe6p/uaCjm7IRq3S+DlRqp1dbKx2BkGrk06yBJYsjHok
	sKixgYmXL/LEirWbZdQ7bwdvdtqKewWMGxjRavvBEwAiSsaU8MdvHo7u6GRmvxn+
	AaGm65J6N0G/JFXV8HLifp6CFILvKpZPw2WPByMtRBnfvv1UFETLVsc5wy5VSl3g
	u8KPyNEi7yOhojhWHRKJzeUpcMIzj9Ougiw==
X-ME-Sender: <xms:hLyLaRQVXfolqtZS4g2uD7GlTAX453bUdut4b8Enby69j_ELO85e0Q>
    <xme:hLyLaecyc_gf4dhZD8VLRieOGm_tCl7mOkt8SFk4NxT9TjfuiZHeWGa-lGwT9Ltqo
    OFp2OM_rOBQFPnMASI7rM1VJNnCoAfzSiXWxJwMRm5b9QiyG2NCmg>
X-ME-Received: <xmr:hLyLaQqRf9BVqWqFxhufxu6XIuR6eqd_tfoXDNaj4cvDxJyCEEj6d9d4vgohK6w2VJg2RVHPmF2JsQyEAlZsjveGHNHW2Xn5zg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtddtleejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhonhgrthgrnhesjhhonhhtvghsrdhprghgvgdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgv
    fhhfsehpvghffhdrnhgvthdprhgtphhtthhopegsvghnkhhnohgslhgvsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgv
    rdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:hLyLaf8sxaeVPs9h4mZlS3GeHCXxctO3mn4OendQzs2rsnHAqPg0gw>
    <xmx:hLyLaccR65g8_2WuWSM7JaGB-Ue-rUnMz68E8DudrFEu50Gl2_IQVw>
    <xmx:hLyLaZJ6s9IRbAo-UHmVj5YJb0rifq1MOVycsWha1AlhAM0YLKAIzQ>
    <xmx:hLyLacjSKp8a0VLcBDvj5X9PkIdm93gv7mTukNoHNvaZlfAupnhQOA>
    <xmx:hbyLacNEPCFq7etaqAcBW4E1q_cvoJxFVxp0Gy87dEXx3WRNBszDlqQc>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Feb 2026 18:17:24 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jonatan Holmgren <jonatan@jontes.page>
Cc: git@vger.kernel.org,  peff@peff.net,  "D . Ben Knoble"
 <benknoble@gmail.com>,  "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 1/3] help: use list_aliases() for alias listing
In-Reply-To: <20260210222745.78575-2-jonatan@jontes.page> (Jonatan Holmgren's
	message of "Tue, 10 Feb 2026 23:27:43 +0100")
References: <3124b359-2929-4f3f-9ac6-793277fe422b@jontes.page>
	<20260210222745.78575-1-jonatan@jontes.page>
	<20260210222745.78575-2-jonatan@jontes.page>
Date: Tue, 10 Feb 2026 15:17:23 -0800
Message-ID: <xmqqv7g4w5mk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jonatan Holmgren <jonatan@jontes.page> writes:

>  	if (data->alias) {
>  		if (!strcasecmp(p, data->alias)) {
> +			if (!value)
> +				return config_error_nonbool(key);
>  			FREE_AND_NULL(data->v);
>  			return git_config_string(&data->v,
>  						 key, value);
>  		}

Hmph, git_config_string() would trigger config_error_nonbool()
anyway if your feed value==NULL, so this change looks a noop.

>  	} else if (data->list) {
> -		string_list_append(data->list, p);
> +		struct string_list_item *item;
> +
> +		item = string_list_append(data->list, p);
> +		if (value)
> +			item->util = xstrdup(value);
> +		/* if !value, item->util remains NULL but item is still added */

This side is silent.  We hold onto the value, when available, and
otherwise we just remember the fact that there is a (misconfigured)
alias by keeping the NULL in the .util member.  Presumably it is now
the responsibility of the caller to deal with these entries with
NULL in their .util member?

>  	}
>  
>  	return 0;
> diff --git a/help.c b/help.c
> index fefd811f7a..0bdb7ca10f 100644
> --- a/help.c
> +++ b/help.c
> @@ -20,6 +20,7 @@
>  #include "prompt.h"
>  #include "fsmonitor-ipc.h"
>  #include "repository.h"
> +#include "alias.h"
>  
>  #ifndef NO_CURL
>  #include "git-curl-compat.h" /* For LIBCURL_VERSION only */
> @@ -468,20 +469,6 @@ void list_developer_interfaces_help(void)
>  	putchar('\n');
>  }
>  
> -static int get_alias(const char *var, const char *value,
> -		     const struct config_context *ctx UNUSED, void *data)
> -{
> -	struct string_list *list = data;
> -
> -	if (skip_prefix(var, "alias.", &var)) {
> -		if (!value)
> -			return config_error_nonbool(var);
> -		string_list_append(list, var)->util = xstrdup(value);
> -	}
> -
> -	return 0;
> -}

We used to use this callback when listing aliases, which (1) added
an alias with proper value to the list, and (2) reported a
misconfigured variable without adding it to the list.  So the net
effect was that the user got diagnosis necessary to fix their
configuration file, while the caller did not have to worry about
getting a broken entry appended to the list.

>  static void list_all_cmds_help_external_commands(void)
>  {
>  	struct string_list others = STRING_LIST_INIT_DUP;
> @@ -501,7 +488,7 @@ static void list_all_cmds_help_aliases(int longest)
>  	struct cmdname_help *aliases;
>  	int i;
>  
> -	repo_config(the_repository, get_alias, &alias_list);
> +	list_aliases(&alias_list);

We call exactly the same alias.c:list_aliases(), which does not feed
data->alias at all, so we will take the "else if (data->list)"
codepath there.  Now we have these broken entries in the returned
list.  Because the shared callback did not give any diagnosis message,
it is on up to us to do so, right?

Perhaps in the code that begins in the post-context of this hunk, here...

	for (i = 0; i < alias_list.nr; i++) {
		if (alias_list.items[i].util)
			continue;
		give error equivanent to config_error_nonbool();
		release resources held by alias_list.items[i];
		shift alias_list.items[i+1..alias_list.nr] by one;
		i-- to compensate for the shift of the array;
	}

or something?

Have you considered doing the config_error_nonbool(key) on the
data->list side of the if/else inside alias.c:config_alias_cb(),
just like help.c:get_alias() callback used to do?

I haven't stared at this code as long as you have, so it is very
possible I am missing the reason why that code path wants to be
silent, though.  But if we can do so, then this caller does not have
to worry about having to handle broken entries at all.

Thanks.

>  	string_list_sort(&alias_list);
>  
>  	for (i = 0; i < alias_list.nr; i++) {

