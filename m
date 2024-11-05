Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAD41C75FA
	for <git@vger.kernel.org>; Tue,  5 Nov 2024 06:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730789130; cv=none; b=LjxTt/6v9T7oJSNrFHegPC3aHJv/gQMutKOGSEEn/I9pI2gpm5iLw6CUn739YOF0jmRvAmUWZwPtMpD4eJzCm2kfF/hlbzWsDATMyKCFFwQhwF6y9UQsaZZUUK5DrTOd2lC6Au/8+Njnn9npCUyn8jPBFoT/JdgSAuvjDsbpuHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730789130; c=relaxed/simple;
	bh=gJ2k9+yiZDgb81e855LWkwtHrLzGbzy0VHaCk0QGxtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rw2ItT8p0feXnY95sdAVcW3oxCy9sWUHkQf5BGRLWSLgEjs2pZ0YvePGkngBPrJth/9qkkd9VTduPvLLz0YV3YDK8zl+Wnd++xPf8wy6W9x7mXt+XVUHS2oms/mVTkZNn7wAxfOaCdJcl52Qy6tKqyJ1iGMxLox5elwHVKoXxC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BYli59RL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mKLkb1E4; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BYli59RL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mKLkb1E4"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7314525401B7;
	Tue,  5 Nov 2024 01:45:27 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 05 Nov 2024 01:45:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1730789127; x=1730875527; bh=Emu34NkfOA
	kR8k/5l3NiQS26/Am1E7XIebMK8F0EZBk=; b=BYli59RLPLUe+YA+QwTiQ4wGph
	hYNFQMNAx345SbWwT8IHkVfH5rG2EHeeWBwmTTdUsgb89jvf1l89vXVaDOCuky5Z
	7G7Jy3fJBabhs16C0a0g0TiW7N3EAGk1xlBUZ6o2h8cgLSO5EDM2CcbVl06WlDVt
	a9CYmAprYDTqnqZzXHGkMfaIbL6xGi2bxTfk+n8wPH7i1Q49971CrKVMaStyd1Ef
	mZx6hNufg53AOE2rabFe+Ck+Vlwy/OTrPgjPNHAwlpfecDYw3CKL+WNVlhvHBa9J
	lHfP0OR7m6LZpm7Abl8gQnhwfwi3zckzlC5p5/HCvhlqDZnT38k9hnaEXNXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730789127; x=1730875527; bh=Emu34NkfOAkR8k/5l3NiQS26/Am1E7XIebM
	K8F0EZBk=; b=mKLkb1E4jTDIx8oEoz3HvlGz5J93eN8BkTeaYzVPU4075HgtWQb
	7LGeuYOjRKEd/EflEmF4lO0bxvGlcyBA/aHSMk5bLEjJK90UNMoBnhBd+Fl2Fcnv
	SmrOC5sQ0LD883E+DdCQccQAxoeH6HAfQ9irKzunG4ZYjG/6zOU+ULptbImuE144
	/UYEelUGeGHpXqrawsti7k9/Pci4J1j7k/HGa7Y5xTxJnOQBACGeWyK+oooHyKvA
	DRJPrz4bY9eiQZveaLA8t8xDgQNHl3Q9ca7ZsFJx6iNrxHN6Sg1aGk7by7nmCZ01
	7SwbAuNs/am63O9SxpQk9YhuwrKbS1KDu3g==
X-ME-Sender: <xms:B78pZ0qA1O_n21eHi9dOGpDQeNt6jj77fHaoCAExlbOGxg567uc_sQ>
    <xme:B78pZ6o368CZ4jmbx8jAkY2AADwCZ94nHxR4T1u0tiR5CTmP-EZksTGz9yqv5QPLf
    4XCb5y7mqutCzIb0A>
X-ME-Received: <xmr:B78pZ5PHQSxUpQFZSA7XQsi_asgOYbfbZdXufBQ5xvHAbo4cQdP0Y4uQWRdDF8h7_uhMhEe74sS2rtZqOZHPmw2DRbSuJ_VBcl1bSkDq_9ErAA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeljedguddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithhgihht
    ghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhhuhgshhgrmhdrkhgrnh
    houghirgdutdesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhg
X-ME-Proxy: <xmx:B78pZ753t6u_yHdf0hOWEg6JMXVnApjngfuWbTJ16zCzIf2JF95Y6A>
    <xmx:B78pZz50HlZYO_X9V5MjBDbw_d0d0GEDD1I3vZgm5PCxpzQuY7-u5w>
    <xmx:B78pZ7jOdXWduWn0DBOfmmh5U2J4bbXIB6jXVMT8PFleXNEzrMomnw>
    <xmx:B78pZ97lH2-Gjlzw7pOJWbx7CWUhJ2InqNBJxawZjs4_d1_h4SiWWg>
    <xmx:B78pZ5S8j6oJ7e-rG7H7-RkRe2pvqK8ApCdSqYesNlASvxfVY2Y8-6er>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Nov 2024 01:45:26 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0e9a6add (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 5 Nov 2024 06:45:03 +0000 (UTC)
Date: Tue, 5 Nov 2024 07:45:17 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Shubham Kanodia via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, "Junio C Hamano [ ]" <gitster@pobox.com>,
	"Derrick Stolee [ ]" <stolee@gmail.com>,
	Shubham Kanodia <shubham.kanodia10@gmail.com>
Subject: Re: [PATCH v4] remote: allow specifying refs to prefetch
Message-ID: <Zym--GVNJt_lsQEz@pks.im>
References: <pull.1782.v3.git.1726741439445.gitgitgadget@gmail.com>
 <pull.1782.v4.git.1728073292874.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.1782.v4.git.1728073292874.gitgitgadget@gmail.com>

On Fri, Oct 04, 2024 at 08:21:32PM +0000, Shubham Kanodia via GitGitGadget wrote:

I'm coming rather late to the party and simply want to review this so
that the thread gets revived. So my context may be lacking, please
forgive me if I am reopening things that were already discussed.

> diff --git a/Documentation/config/remote.txt b/Documentation/config/remote.txt
> index 8efc53e836d..186f439ed7b 100644
> --- a/Documentation/config/remote.txt
> +++ b/Documentation/config/remote.txt
> @@ -33,6 +33,13 @@ remote.<name>.fetch::
>  	The default set of "refspec" for linkgit:git-fetch[1]. See
>  	linkgit:git-fetch[1].
>  
> +remote.<name>.prefetchref::
> +	Specify the refs to be prefetched when fetching from this
> +	remote. The value is a space-separated list of ref patterns
> +	(e.g., "refs/heads/main !refs/heads/develop*"). This can be
> +	used to optimize fetch operations by specifying exactly which
> +	refs should be prefetched.

I'm a bit surprised that we use a space-separated list here instead of
accepting a multi-valued config like we do for "remote.<name>.fetch".
Shouldn't we use the format here to make things more consistent?

>  remote.<name>.push::
>  	The default set of "refspec" for linkgit:git-push[1]. See
>  	linkgit:git-push[1].
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index b2b5aee5bf2..74603cfabe0 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -485,6 +485,32 @@ static void filter_prefetch_refspec(struct refspec *rs)
>  	}
>  }
>  
> +static int pattern_matches_ref(const char *pattern, const char *refname)
> +{
> +	if (strchr(pattern, '*'))
> +		return match_refspec_name_with_pattern(pattern, refname, NULL, NULL) != 0;
> +	return strcmp(pattern, refname) == 0;
> +}
> +
> +static int matches_prefetch_refs(const char *refname, const struct string_list *prefetch_refs)
> +{
> +	int has_positive = 0, matched_positive = 0, matched_negative = 0;
> +
> +	for (int i = 0; i < prefetch_refs->nr; i++) {
> +		const char *pattern = prefetch_refs->items[i].string;
> +		int is_negative = (*pattern == '!');
> +		if (is_negative) pattern++;
> +		else has_positive = 1;
> +
> +		if (pattern_matches_ref(pattern, refname)) {
> +			if (is_negative) matched_negative = 1;
> +			else matched_positive = 1;
> +		}
> +	}
> +
> +	return has_positive ? (matched_positive && !matched_negative) : !matched_negative;
> +}

This is essentially open-coding a bunch of logic around how we parse
refspecs. I'd propose to instead use the APIs we already have in this
area, namely those in "refspec.h".

>  static struct ref *get_ref_map(struct remote *remote,
>  			       const struct ref *remote_refs,
>  			       struct refspec *rs,
> @@ -501,7 +527,11 @@ static struct ref *get_ref_map(struct remote *remote,
>  	struct hashmap existing_refs;
>  	int existing_refs_populated = 0;
>  
> +	struct ref *prefetch_filtered_ref_map = NULL, **ref_map_tail = &prefetch_filtered_ref_map;
> +	struct ref *next;
> +

We don't typically have empty lines between variable declarations.

>  	filter_prefetch_refspec(rs);
> +
>  	if (remote)
>  		filter_prefetch_refspec(&remote->fetch);
>  
> @@ -610,6 +640,29 @@ static struct ref *get_ref_map(struct remote *remote,
>  	else
>  		ref_map = apply_negative_refspecs(ref_map, &remote->fetch);
>  
> +	/**
> +	 * Filter out advertised refs that we don't want to fetch during
> +	 * prefetch if a prefetchref config is set
> +	 */

Our comments typically start with `/*`, not `/**`.

> +	if (prefetch && remote->prefetch_refs.nr) {
> +		prefetch_filtered_ref_map = NULL;
> +		ref_map_tail = &prefetch_filtered_ref_map;

As far as I can see, both of these variables have already been
initialized beforehand.

> +		for (rm = ref_map; rm; rm = next) {
> +			next = rm->next;
> +			rm->next = NULL;
> +
> +			if (matches_prefetch_refs(rm->name, &remote->prefetch_refs)) {
> +				*ref_map_tail = rm;
> +				ref_map_tail = &rm->next;
> +			} else {
> +				free_one_ref(rm);
> +			}
> +		}
> +		ref_map = prefetch_filtered_ref_map;
> +	}
> +
>  	ref_map = ref_remove_duplicates(ref_map);
>  
>  	for (rm = ref_map; rm; rm = rm->next) {
> diff --git a/remote.c b/remote.c
> index 8f3dee13186..6752c73370f 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -141,6 +141,7 @@ static struct remote *make_remote(struct remote_state *remote_state,
>  	ret->prune = -1;  /* unspecified */
>  	ret->prune_tags = -1;  /* unspecified */
>  	ret->name = xstrndup(name, len);
> +	string_list_init_dup(&ret->prefetch_refs);
>  	refspec_init(&ret->push, REFSPEC_PUSH);
>  	refspec_init(&ret->fetch, REFSPEC_FETCH);
>  
> @@ -166,6 +167,7 @@ static void remote_clear(struct remote *remote)
>  	free((char *)remote->uploadpack);
>  	FREE_AND_NULL(remote->http_proxy);
>  	FREE_AND_NULL(remote->http_proxy_authmethod);
> +	string_list_clear(&remote->prefetch_refs, 0);
>  }
>  
>  static void add_merge(struct branch *branch, const char *name)
> @@ -456,6 +458,12 @@ static int handle_config(const char *key, const char *value,
>  		remote->prune = git_config_bool(key, value);
>  	else if (!strcmp(subkey, "prunetags"))
>  		remote->prune_tags = git_config_bool(key, value);
> +	else if (!strcmp(subkey, "prefetchref")) {
> +		if (!value)
> +			return config_error_nonbool(key);
> +		string_list_split(&remote->prefetch_refs, value, ' ', -1);
> +		return 0;
> +	}
>  	else if (!strcmp(subkey, "url")) {
>  		if (!value)
>  			return config_error_nonbool(key);
> @@ -868,7 +876,7 @@ struct strvec *push_url_of_remote(struct remote *remote)
>  	return remote->pushurl.nr ? &remote->pushurl : &remote->url;
>  }
>  
> -static int match_name_with_pattern(const char *key, const char *name,
> +int match_refspec_name_with_pattern(const char *key, const char *name,
>  				   const char *value, char **result)
>  {
>  	const char *kstar = strchr(key, '*');

Is this rename really necessary? It is not mentioned in the commit
message, so this is surprising to me. If it really was necessary it
should be split out into a separate commit that also explains why you
think that this is a good idea.

> diff --git a/remote.h b/remote.h
> index b901b56746d..9ffef206f23 100644
> --- a/remote.h
> +++ b/remote.h
> @@ -5,6 +5,7 @@
>  #include "hashmap.h"
>  #include "refspec.h"
>  #include "strvec.h"
> +#include "string-list.h"
>  
>  struct option;
>  struct transport_ls_refs_options;
> @@ -77,6 +78,8 @@ struct remote {
>  
>  	struct refspec fetch;
>  
> +	struct string_list prefetch_refs;
> +
>  	/*
>  	 * The setting for whether to fetch tags (as a separate rule from the
>  	 * configured refspecs);
> @@ -207,6 +210,9 @@ int count_refspec_match(const char *, struct ref *refs, struct ref **matched_ref
>  
>  int check_ref_type(const struct ref *ref, int flags);
>  
> +int match_refspec_name_with_pattern(const char *key, const char *name,
> +					const char *value, char **result);

I think instead of exposing this function we should rather expose
`refspec_match()`, which is at a higher level and knows to handle the
cases for us where the refspec is a pattern and when it's not.

Patrick
