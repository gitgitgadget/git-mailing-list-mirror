Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E015235DA4A
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 16:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791478756; cv=none; b=dwSoQqFRDPrOgMVwzRMnjnuZACBHIlaZfP7X2H5leQm0vyLUkWoA7LsJRMnTJ27pZC6tT9FlleeflZTOrIrq5PHPq6Zp+ipJAF92F0RBdcL4Q7Crn7ouLtpdJnYbjVeIL9zXL4e/ZTS54Qb1o36a/l0ctUd9F09wzUWB/AZ8/Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791478756; c=relaxed/simple;
	bh=1pjvv5DAFFbM3KOC8zhHQzeTL7dLzmAZZN7NlTjaoMQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=c/aQdRAX2cRU6hc0Tw1Pg3Zu8Q3cm3InUC3e/6W0wwomEei3UUyubFozCVitcnWqxQMX6O3N68sK5v2yRqMT0lVk1+EnA0JM/i28dp+ciI08o5w1LOpjjW0jtJ6CeoyQgmYjsuZ4ZYWK3pJ40gpAgDMsVFuIkPDe3I6lReD0KJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bqNfskFp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NVwQs4AF; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bqNfskFp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NVwQs4AF"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 31FAF7A0105
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 12:59:13 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Thu, 08 Oct 2026 12:59:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791478752; x=1791565152; bh=woJUifI9jz
	1qlMteXh6pC4BEDxTaP2zGcmaoSPDvh2o=; b=bqNfskFp+1sstHk/EBw/mpnEbm
	p0IXUPsAF/hwTusZ7Xi9/yHHwmQ906sN8qchnaBW1VYjvtiqbm8HghQpLtTIhGgb
	oJ0CsZO1LSKk8dqzX8SnYSoxZ1t8HnauT+BywXJNcD44yebNiyJLxLKhtN8sXoSO
	QTnkVdlE0F8jqKcp0iMXb3fAZrz3vMVJ8lRlIL8QancBwprDjEdca9KEn1uMNSaf
	0CxpCJNmIcJ3ZcwKnaRGWY1A/wl0zHbZnvYovwaKC7ZJsaeG8zsynepy8aBFqcMu
	64WGytqkX1+8tN72QWKmJXFTqWJ1WCKBdewpNR3Jeu2UiB5R7MgprBn77Lcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791478752; x=1791565152; bh=woJUifI9jz1qlMteXh6pC4BEDxTaP2zGcma
	oSPDvh2o=; b=NVwQs4AFvdYMKbUQoVvpyNRemm1Gsm8KazhL0BqVav9RFMjNb1H
	M6uYM7RsmRgPFt9ZSWupQNLXVpeV0NXddpBhXE4QD6TklRHjtvPN3QlF/qaylwKF
	PbhWlCvwCPZgZVRCRoDLZQXpBn4G8lei4xSIVMKTo7i4R4R1Qjd3zRFvfB0sVCF+
	GtNMJtNHWeXRtVvip29NIhaQqUaGktNy4uLvBC1rgKpWZnMZZYH5GMu+Fd6JUT1o
	8JKNU2cfAEV6kmB12pzTw44mfXSEQguDkPnSgWEi6z/ul9qb6yDl6f239Jru/2Un
	dXFdA79KBDekFgV6XfEIjp+H4jgtwJRE8cg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791478752; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:DhTmVNCYn3IiPL3/2K/A8xf1+j1HnzmcZk/4Ik87F9M56gU
	ZI3q5hZ8laks++Ql7XUPbVMlImDPo6JaQEZcHJTS530clLI4Cgmj0RDi+uBoNB8Z
	F48refmYwcnDghs9vSdLDnvkW5nGI+k3JWtV3Vnagrv7STxRTre3KKCdxvE31d5g
	Y6yr/ICRsL61Qu7Q4dX6VlTSJr6gjyhQSg7XvY7KBSOFxLEZTelEkjWi51oJ6h5V
	fhuwiYT/p0eV0v0xYQvv+EIdUivtET5PlGWHWKtPKGZZKc8x+5+QIU8xm8jBfMow
	RWvo7+PvJFk8eb4lNRwrXDWc8e8/qKdH3Ho+AhA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:7In2TcFqB3rk8/FtbBF8aafci/IbKcw/tkT9gdu+NSw=:1pjvv5DAFFbM3KOC8zhHQzeTL7dLzmAZZN7NlTjaoMQ=;
X-ME-Sender: <xms:4MvHasLmvhcFWkw3P6zXqvHYxkrRd7pYFOdHKJPuE45J11p8LIPgxg>
    <xme:4MvHav3N440h8GSG4aBa5QbW6GWwOoeElyMpL0v5wf2FSPOVS5ymLgfE2mlI0M0cz
    _rYOHIwmCgDy4RBzSGbfLHG57Gaeq8_WcXoZghrREyu9uqkbn_40Q8>
X-ME-Received: <xmr:4MvHamhdD6msmmgTc7DZaM31TV_yQvF_uY-ZlqfXqRLvuNnVPEpClJC74ThyOF2ZpCJgKqKwm8m_0ymaKkxtg4nykNqdHsh8EJCF>
X-ME-Proxy-Cause: dmFkZTGN1I+cdvhEiIh3V/vKcvCMTWiHmkVrJQtBu7wFkC5X76H9LupPJ7HL/H++IF3YdE
    mSv1lBumQTl4/95DJFWCik1Sxcwq/gtxK4y9hDJusPSu9VwCOdv0njHGfkPkWFjnpHtqq3
    tN8YDDHxE5lFXriTHT5oQL32uYojZ+bMFrohSCJ0dzMhSaBStyjGMrbMR4sCWqkHHjt/OR
    rfOgjMJQJNzYmd6hx41rhToOYWpYx5lzLJY6kcaGK0x4cz0fG6QvbpnfqYdGanPG46Kcj6
    FEImVls5e/k5PyW4++eFie1pFRFIK95YtZ8IaTG027OFN8VOLL6nRNgkpnj1Cs/zlMeAm9
    87JDeupd6WplmJkbl6r9B1hyk32+fI9+Ay1QopcYxmvlh4RqFcWx+3WEZ7fRECIsny/Xyk
    5Sx1BWij0jGhBwiJGyz/4Qd/PkkErHPZ4/VVQhU7HphPg5DLgXpvMXHdOoWGalYFk5gp4F
    QG7GQR49WMFhJkXnKd3HZNsMaPrIL2KNhqajtxO+hZ+lrCAFtwz9Y/N31+xAaohTStMycR
    yuIYoyAldKFTq1BAMKQGYMFJDOUdcNvPgoooM4TXVEeG+D7wK5EUp4R2XmeAZ58CsLzMti
    Rv0xxvtRmQ86+SnhQw1OEPMTPF3wGrHHV21Jq/ts+yn5wxQPuAEW11wUt1Ug
X-ME-Proxy: <xmx:4MvHagWlQ_kUMsMOaoGkg87CEVbitOFMVmvljv_ifafmz0mIwwKomg>
    <xmx:4MvHalWQIcV419-wCFmTfgtiku00hTUlPbCdzK2Ki8thJIXZ01Fbyg>
    <xmx:4MvHagjxgmrWGWwAoJsG2IaCzfKvczwxj43ZIEPetLk0pMofaj811A>
    <xmx:4MvHagZHti_xBaoVLIa-BkjhU_lyKCzflHCBA3e1-TnEyn-uAMmRJw>
    <xmx:4MvHarsQ7k3QoIL7uk1szEVcZzQnTaDq2pSGtAx5yWlV9i1DltN62_nu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Oct 2026 12:59:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>,  "D. Ben
 Knoble" <ben.knoble@gmail.com>,  Harald Nordgren
 <haraldnordgren@gmail.com>
Subject: Re: [PATCH v7 2/4] fetch: infer branches to fetch from a
 refmap-only remote
In-Reply-To: <fd6864daaf47dc3cfbd3cc7dadb5f0bd76d4eb79.1791410164.git.gitgitgadget@gmail.com>
	(Harald Nordgren via GitGitGadget's message of "Wed, 07 Oct 2026
	21:56:02 +0000")
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
	<pull.2412.v7.git.git.1791410164.gitgitgadget@gmail.com>
	<fd6864daaf47dc3cfbd3cc7dadb5f0bd76d4eb79.1791410164.git.gitgitgadget@gmail.com>
Date: Thu, 08 Oct 2026 09:59:10 -0700
Message-ID: <xmqqo6d4163l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Harald Nordgren <haraldnordgren@gmail.com>
>
> Configuring remote.<name>.refmap without remote.<name>.fetch used to
> make a refspec-less "git fetch <name>" fail with "--refmap option is
> only meaningful with command-line refspec(s)", since a refmap only
> says where to put fetched refs, not what to fetch.
>
> Make that case infer what to fetch: the local branches whose
> @{upstream} is already on that remote. This lets a remote be
> configured to fetch only the branches actually in use, without
> listing them by hand in remote.<name>.fetch, and without needing to
> touch the command line every time.

Nicely explained what we want out of this new feature.

>  remote.<name>.refmap::
>  	The default value of the `--refmap` option for linkgit:git-fetch[1].
>  	Used to map remote refs being fetched to remote-tracking refs to
> -	store. See the `--refmap` entry in linkgit:git-fetch[1].
> +	store. If `remote.<name>.fetch` is not set either, a refspec-less
> +	fetch infers what to fetch from local branches built on this
> +	remote, instead of fetching every branch it has. See the
> +	`--refmap` entry in linkgit:git-fetch[1].

OK.

> diff --git a/Documentation/fetch-options.adoc b/Documentation/fetch-options.adoc
> index c2101a7b39..75899d91cc 100644
> --- a/Documentation/fetch-options.adoc
> +++ b/Documentation/fetch-options.adoc
> @@ -245,8 +245,10 @@ endif::git-pull[]
>  	command-line arguments. See section on "Configured Remote-tracking
>  	Branches" for details.
>  +
> -`remote.<name>.refmap` provides the default value for this option, the
> -same way `remote.<name>.fetch` provides the default refspecs to fetch.
> +When a refmap is active (from `--refmap` or `remote.<name>.refmap`) but
> +there is nothing to fetch, neither on the command line nor from
> +`remote.<name>.fetch`, Git infers what to fetch from the local branches
> +whose `@{upstream}` is on that remote.

To say "infers what to fetch" without explicitly saying how the
inference is made is not sufficient in a technical manual.  Even
a reading like "up to three branches that our local branches
have as '@{u}'" is possible, if not very probable.

Perhaps something like this instead:

    ... but nothing to fetch is specified on the command line,
    branches from the remote that are used as '@{upstream}' of
    our local branches are fetched.


[...]

> @@ -1960,15 +1982,30 @@ static int do_fetch(struct transport *transport,
>  		refspec_ref_prefixes(rs, &transport_ls_refs_options.ref_prefixes);
>  	} else {
>  		struct branch *branch = branch_get(NULL);
> -
> -		if (transport->remote->fetch.nr) {
> +		int tracks_this_remote = branch && branch_has_merge_config(branch) &&
> +			!strcmp(branch->remote_name, transport->remote->name);
> +		struct refspec *effective_refmap = refmap.nr ? &refmap :
> +			&transport->remote->refmap;
> +		int inferred_branches = !transport->remote->fetch.nr &&
> +			effective_refmap->nr;
> +
> +		if (inferred_branches) {
> +			struct string_list tracked = STRING_LIST_INIT_DUP;
> +			struct string_list_item *item;
> +
> +			branches_tracking_remote(transport->remote, &tracked);
> +			for_each_string_list_item(item, &tracked)
> +				strvec_push(&transport_ls_refs_options.ref_prefixes,
> +					    item->string);
> +			string_list_clear(&tracked, 0);
> +		} else if (transport->remote->fetch.nr) {
>  			refspec_ref_prefixes(&transport->remote->fetch,
>  					     &transport_ls_refs_options.ref_prefixes);
> -			if (follow_remote_head != FOLLOW_REMOTE_NEVER)
> -				do_set_head = 1;
>  		}
> -		if (branch && branch_has_merge_config(branch) &&
> -		    !strcmp(branch->remote_name, transport->remote->name)) {
> +		if ((transport->remote->fetch.nr || inferred_branches) &&
> +		    follow_remote_head != FOLLOW_REMOTE_NEVER)
> +			do_set_head = 1;
> +		if (tracks_this_remote) {
>  			int i;
>  			for (i = 0; i < branch->merge_nr; i++) {
>  				strvec_push(&transport_ls_refs_options.ref_prefixes,


The unified diff is a bit messy to compare the before-and-after
behaviour, so let's see what the preimage said first.

>  		struct branch *branch = branch_get(NULL);
> -
> -		if (transport->remote->fetch.nr) {
>  			refspec_ref_prefixes(&transport->remote->fetch,
>  					     &transport_ls_refs_options.ref_prefixes);
> -			if (follow_remote_head != FOLLOW_REMOTE_NEVER)
> -				do_set_head = 1;
>  		}
> -		if (branch && branch_has_merge_config(branch) &&
> -		    !strcmp(branch->remote_name, transport->remote->name)) {
>  			int i;
>  			for (i = 0; i < branch->merge_nr; i++) {
>  				strvec_push(&transport_ls_refs_options.ref_prefixes,

So, when !rs->nr (i.e., nothing given on the command line to be fetched)
and there is no fetch refspec, we checked the current branch and if
it has merge config to merge from branches at the remote, we
automatically fetched them.  This is the world order before this
"infer with @{u} and refmap" work, and we should behave the same way
when remote.*.refmap is not set.

Let's see what the postimage says.

>  		struct branch *branch = branch_get(NULL);
> +		int tracks_this_remote = branch && branch_has_merge_config(branch) &&
> +			!strcmp(branch->remote_name, transport->remote->name);

This is the "does the current branch pull branches from the remote
we are working with right now?" condition we saw in the original.

> +		struct refspec *effective_refmap = refmap.nr ? &refmap :
> +			&transport->remote->refmap;

It is a bit annoying that refmap is a file scope static variable but
here we say "The value of the --refmap option from the command line,
or the value remote.*.refmap otherwise".

> +		int inferred_branches = !transport->remote->fetch.nr &&
> +			effective_refmap->nr;

This variable tells the code that it must infer branches, but named
as if it were a list of branches that were inferred.  "When remote.*.fetch
does not exist and we have the refmap to use for inferring".

> +		if (inferred_branches) {
> +			struct string_list tracked = STRING_LIST_INIT_DUP;
> +			struct string_list_item *item;
> +
> +			branches_tracking_remote(transport->remote, &tracked);
> +			for_each_string_list_item(item, &tracked)
> +				strvec_push(&transport_ls_refs_options.ref_prefixes,
> +					    item->string);
> +			string_list_clear(&tracked, 0);
> +		} else if (transport->remote->fetch.nr) {
>  			refspec_ref_prefixes(&transport->remote->fetch,
>  					     &transport_ls_refs_options.ref_prefixes);
>  		}

It would have been much easier to follow if the existing code came
first to make it clear that the new code is an add-on.  After all,
when transport->remote->fetch.nr is true, inferred_branches is never
true.

> +		if ((transport->remote->fetch.nr || inferred_branches) &&
> +		    follow_remote_head != FOLLOW_REMOTE_NEVER)
> +			do_set_head = 1;
> +		if (tracks_this_remote) {
>  			int i;
>  			for (i = 0; i < branch->merge_nr; i++) {
>  				strvec_push(&transport_ls_refs_options.ref_prefixes,

How does tracks_this_remote and inferred_branches interact?  Doesn't
the old code that grabs necessary remote-tracking branches for the
current branch add the same branch from the remote?  Doesn't @{u}
for the current branch added twice on the list of branches to fetch?

> @@ -2009,6 +2046,7 @@ static int do_fetch(struct transport *transport,
>  
>  	ref_map = get_ref_map(transport->remote, remote_refs, rs,
>  			      tags, &autotags);
> +
>  	if (!update_head_ok)
>  		check_not_current_branch(ref_map);

Useless patch noise.

> diff --git a/remote.c b/remote.c
> index 99a086ea5a..c26312beea 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -1884,6 +1884,35 @@ int branch_merge_matches(struct branch *branch,
>  	return refname_match(branch->merge[i]->src, refname);
>  }
>  
> +struct branches_tracking_remote_cb_data {
> +	struct remote *remote;
> +	struct string_list *tracked;
> +};
> +
> +static int add_if_tracking_remote(const struct reference *ref, void *cb_data)
> +{
> +	struct branches_tracking_remote_cb_data *data = cb_data;
> +	struct branch *branch;
> +
> +	branch = branch_get(ref->name);

I know branch_get() is defined here and allows implicit use of
the_repository, but can't we pass "struct repository *" around in
cb_data so that we can use repo_branch_get() here?

> +	if (!branch_has_merge_config(branch) ||
> +	    strcmp(branch->remote_name, data->remote->name))
> +		return 0;
> +
> +	for (int i = 0; i < branch->merge_nr; i++)
> +		string_list_insert(data->tracked, branch->merge[i]->src);
> +
> +	return 0;
> +}

This is more or less identical to the "if current branch integrates
with branches from the remote, then fetch them" code we saw earlier
in the builtin/fetch.c:do_fetch() above.  I notice that its return
value is meaningless, as it always returns 0.

Stepping back a bit, because your new logic would become superset of
what we already have to support the current branch when refmap is
used, would it make sense to restructure the code change to
do_fetch() more like this:

	if (rs->nr) {
		... use command line refspec ...
	} else if (transport->remote->fetch.nr) {
		... use remote.*.fetch refspec ...
	} else if (effective_refmap->nr) {
		... your new logic ...
	} else {
		struct string_list list = STRING_LIST_INIT;
		collect_upstream_from_remote(&list, remote, NULL);
		for_each_string_list_item(item, &list)
			strvec_push(&transport_ls_refs_options.ref_prefixes,
					item->string);
	}
			
where collect_upstream_from_remote() performs the bulk of what
add_if_tracking_remote() does, which means add_if_tracking_remote()
becomes

	static int add_if_tracking_remote(...)
	{
		struct branches_tracking_remote_cb_data *data = cb_data;

		collect_upstream_from_remote(data->tracked, data->remote, ref->name);
	}

This will mean we will have a very small preliminary patch to
introduce collect_upstream_from_remote() function in remote.c and
update the "help current branch by fetching what are merged into it"
code in do_fetch() to use it, which will have the above ontlined
if/else if/ cascade except for your new refmap code.  On top, this
step will insert a single "else if" block to add your new logic to
do_fetch().

Doesn't it make the series (and more importantly, the resulting
code) much easier to understand?

> +void branches_tracking_remote(struct remote *remote, struct string_list *tracked)
> +{
> +	struct branches_tracking_remote_cb_data data = { remote, tracked };
> +
> +	refs_for_each_branch_ref(get_main_ref_store(the_repository),
> +				  add_if_tracking_remote, &data);
> +}

This also hardcodes the_repository, but shouldn't this function take
"struct repository *" pointer (and shove it in data structure to
pass it down)?

By the way, when merged to 'seen', it seems to have some
interactions with other topics and makes t5505 and t5586 fail.  I
didn't have time to dig down to the cause.  Can you perhaps help
finding the cause when I push the integration result out early this
afternoon?

Thanks.


