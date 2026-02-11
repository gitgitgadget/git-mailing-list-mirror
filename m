Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EDC4414
	for <git@vger.kernel.org>; Wed, 11 Feb 2026 22:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770848950; cv=none; b=kkMBZxBAeYrpygFVqiqm/z+1wiXKB7J0l08pch+IAwEZyO45gY3GJPAGoTv8lrUXo/gWbQFbRj2yWDGHGeDhIEfmVyIt6bhmzR4bSR4OgX25Lm+qF5q9O+9iHy4mcS/rRoBUy/M3hnjjezSbnsY2xvnJtlExXCiu3XysuKHLHOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770848950; c=relaxed/simple;
	bh=ihRtGtSpPUqLbsLRS0s9xEh1Oa9pWubI6aA58iwgSuU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rLTkZ8QAU4Ucc5ShKerUoZCbByK8kL4hqEWwZt2bka9aoVwVzq4m+xbVLc4t+eCIhxQmAXNfO2v0fLcznSNKilUJuQl5WhshvITHvUwbuQRqEjN4aOogAJCVx/fJzxAW/rVuFC0OQaAAr6s6RGp6Y6NeWDIUesCAnWQqJIlKrvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=BM3K5oUi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gEVqpytF; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="BM3K5oUi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gEVqpytF"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C5B867A00DE;
	Wed, 11 Feb 2026 17:29:08 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 11 Feb 2026 17:29:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770848948; x=1770935348; bh=dqIdkncEmK
	wqLBA7Lci8jyrs9zY6w+dgTMESdrTs2GY=; b=BM3K5oUiOyd6SNTzuAk/6fCams
	h905zzxhay8v4n5u9Xai/cMwKIx9iProU09WsNcCSDPlpWcZK6Zxis7J5ifI+l9X
	8sD3S6KZ7tCDCzjfnEOS68Eo9ViYUaZKEepK2CkC+KV3PlPfXsrDyq+oqeIRDwzS
	MdD4dFmyYCvw5yHVjWGnBz6ZIbbm0yqOZzaQtWxTtIeDvKjkFo7YpLqQaimKTS/6
	OvSB7d5FZUor2rdUuCtXSZc2FFDHXV09iEmZ5zW615Vhvtz2948I+pKnnByFBZk1
	5gDLZ3DAKolq5yIegB4JANowwWly9xDGPpFqP/PatwXI39K67k0Ib3RZskvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770848948; x=1770935348; bh=dqIdkncEmKwqLBA7Lci8jyrs9zY6w+dgTME
	SdrTs2GY=; b=gEVqpytFHXzbekQlQwrLPkqVLX9Oac5B2/Ls8wMoc+julpMxS5q
	vWbIhqibJ3VMpFX5OgbekPRvx4fOzu9GMVZCUkaoDRsls/cnUI4d05rUB4om5Lwz
	MEFdc1rsfl8/LwwpH83uFiG8laWDXTapsr/Sd+Y9yjc0lx24BybF+UrKm0i8L6ne
	pzR4pKkrcJ854//YF2/t9RZibByt1eLeHDKHsdb9y8ny2IWOi2sfzwf3VHZubbBd
	JRsQ1i0IIP612EsIA332xav5mUoTMnNOBXWlal/gXjXbwENSeBlXey74K2zHwVvE
	F/Ix7u+xmEeUQq1QNCR0xD7iylvI7nazdTQ==
X-ME-Sender: <xms:tAKNaax8_IJeCWoXiCY9vUIkzBiDm0RdyHVQgiJ2qFtW7oSxTB1t1Q>
    <xme:tAKNaZ_ehKuNso3O9yd4gIjaKX1qSZUfZdBiotq78HS7hF6FL0XFatZgv1klWiyzV
    0y_8xB1FefKGP9A8Kwza2opsmwH9lLxSoVyBHrOyT3Wk7f5ALAt>
X-ME-Received: <xmr:tAKNaWL-7My2vOP9HnctSAKxXDO-Kao-86QON-dfVsl4mav3PDCgsZOuedvq0BSjf0ZZvPy_2uciWe3eWZThldEU-e-GQOFSgQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdefjeehucetufdoteggodetrf
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
X-ME-Proxy: <xmx:tAKNaXfLuY_vEm_gUs2vQELCBiq-vYCUr3lY0R9VAjgHeDe4M_nizA>
    <xmx:tAKNad9aEkkglGZyfpTQafywVfPdv6DiFju0Lkz5ngxIsn33P8wwlw>
    <xmx:tAKNacopOVFtRspR4Ug-kpeeqYgtg1cKePKBa_VxeSh3YtntKfQpWQ>
    <xmx:tAKNaaC9IrEWQXpTAS-izqBS6BUfZgY7EkU-GNP2o_EOpeWP3sp39Q>
    <xmx:tAKNaVuLkajCkkgot756fWpO5VBA_X-ELPlnmG7GXIjMqimVDoqgTz_s>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Feb 2026 17:29:08 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jonatan Holmgren <jonatan@jontes.page>
Cc: git@vger.kernel.org,  peff@peff.net,  "D . Ben Knoble"
 <benknoble@gmail.com>,  "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v4 1/3] help: use list_aliases() for alias listing
In-Reply-To: <20260211211810.278806-2-jonatan@jontes.page> (Jonatan Holmgren's
	message of "Wed, 11 Feb 2026 22:18:08 +0100")
References: <3124b359-2929-4f3f-9ac6-793277fe422b@jontes.page>
	<20260211211810.278806-1-jonatan@jontes.page>
	<20260211211810.278806-2-jonatan@jontes.page>
Date: Wed, 11 Feb 2026 14:29:07 -0800
Message-ID: <xmqqldgyrk24.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jonatan Holmgren <jonatan@jontes.page> writes:

> help.c has its own get_alias() config callback that duplicates the
> parsing logic in alias.c. Consolidate by teaching list_aliases() to
> also store the alias values (via the string_list util field), then
> use it in list_all_cmds_help_aliases() instead of the private
> callback.
>
> This preserves the existing error checking for value-less alias
> definitions by checking in alias.c rather than help.c.
>
> No functional change intended.
>
> Signed-off-by: Jonatan Holmgren <jonatan@jontes.page>
> ---
>  alias.c          |  8 +++++++-
>  help.c           | 17 ++---------------
>  t/t0014-alias.sh | 10 ++++++++++
>  3 files changed, 19 insertions(+), 16 deletions(-)

Looks good.  There is a small functional change not on the
help.c:get_alias() side (i.e., "git help --all") but on the
alias.c:list_aliases() side.  "git --list-cmds=alias", used by
command line completion, used to include such a broken alias, but it
no longer does (and gets an error).

I think it is fine to call it a bugfix ;-)


> diff --git a/alias.c b/alias.c
> index 1a1a141a0a..271acb9bf1 100644
> --- a/alias.c
> +++ b/alias.c
> @@ -29,7 +29,13 @@ static int config_alias_cb(const char *key, const char *value,
>  						 key, value);
>  		}
>  	} else if (data->list) {
> -		string_list_append(data->list, p);
> +		struct string_list_item *item;
> +
> +		if (!value)
> +			return config_error_nonbool(key);
> +
> +		item = string_list_append(data->list, p);
> +		item->util = xstrdup(value);
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
> -
>  static void list_all_cmds_help_external_commands(void)
>  {
>  	struct string_list others = STRING_LIST_INIT_DUP;
> @@ -501,7 +488,7 @@ static void list_all_cmds_help_aliases(int longest)
>  	struct cmdname_help *aliases;
>  	int i;
>  
> -	repo_config(the_repository, get_alias, &alias_list);
> +	list_aliases(&alias_list);
>  	string_list_sort(&alias_list);
>  
>  	for (i = 0; i < alias_list.nr; i++) {
> diff --git a/t/t0014-alias.sh b/t/t0014-alias.sh
> index 07a53e7366..a13d2be8ca 100755
> --- a/t/t0014-alias.sh
> +++ b/t/t0014-alias.sh
> @@ -112,4 +112,14 @@ test_expect_success 'cannot alias-shadow a sample of regular builtins' '
>  	done
>  '
>  
> +test_expect_success 'alias without value reports error' '
> +	test_when_finished "git config --unset alias.noval" &&
> +	cat >>.git/config <<-\EOF &&
> +	[alias]
> +		noval
> +	EOF
> +	test_must_fail git noval 2>error &&
> +	test_grep "alias.noval" error
> +'
> +
>  test_done
