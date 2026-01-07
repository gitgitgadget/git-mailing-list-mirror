Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E5F35975
	for <git@vger.kernel.org>; Wed,  7 Jan 2026 10:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767780331; cv=none; b=aNOz7j4gEzmiVAOEOklIEa3HotzqsQIEdHy314sg7fWwW36vL9b11JrGrmrUMwPQURwhARWizqTyxOP74LpUrV4rQZUuD/LWwBysPMvo08FNmsdacFTsOl6Vx9YmxE5J9KpwlLo2Gn4IPf6+0250sBGeKD0jOqwSMsrojV8PoLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767780331; c=relaxed/simple;
	bh=0Xc7EtgyFb2H34neRNbNwLCdlGp0/C+0OMHuN2uObDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fMgw/iVUv5o8xmZj+eqft+cpEATRSRIM1NRPPu3yJZRk2hT3tvh4QEdkEX3wcgOdurLuF0f4ipznDfqQ4u266JARVcW/oJt76qm2M329tfo8xoXeV/ZOCdsCAIIx0lbPCI0oM5hDWAqWF4ghvbrU/zRf1n4aWH6pQwXuhD7P++4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eooYdZeD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bJFbcyIf; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eooYdZeD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bJFbcyIf"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 5487CEC026B;
	Wed,  7 Jan 2026 05:05:27 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Wed, 07 Jan 2026 05:05:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1767780327; x=1767866727; bh=Jl4Z13bpHV
	CNL2cYEQ4JxHKqoQ34xCUu0neP7f771qo=; b=eooYdZeDw+7NlNptqxALxF1p7M
	X/G9UBqrVddmsRe9raSHdI6V60+4+bykdthM2PPwlx9o38cp2dN6Vh98jjmRMup7
	lYe7SgrF+O1KdrUnh6eQ4tgNmHRbfVccjxzFEMPQEPOQtJWwPlw7Wj4vjB5WsKlZ
	3EOOMy47AWVwL1xe+8nk39wEm4zNIPUrbJDgM/rCX7J2Xjqr6mDnqq1ze5wM4kvO
	9+xLDALHQqqGYURCOko8/NvJayNy0Iop0Dr8JW+hs7bjwUtpdwx3ypo0YKbg+edY
	8gIOGeKokCbC5OXsrbhYzvLi+phQ5W0lbJ76IKGQltBYlVQ8n6X9HHShB6nQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767780327; x=1767866727; bh=Jl4Z13bpHVCNL2cYEQ4JxHKqoQ34xCUu0ne
	P7f771qo=; b=bJFbcyIfCyYrdSsQ23yooKAQjGXpH+LfMACzGTywiPufHZcl8Nb
	Gb5RxGE55wBNi4yM2yFTLx3nHvSph4OzvEofVhp6zfQq0qZQ8AeAErPCdu6VqgqF
	ys3ZShpeBWrJOrgFeohhvT0WjzfseXP9y6cvA/JKqWFXAZn0cHxSfBFPyu9jZ8JV
	5nXb0xA6zbNac2TGK7aRvASAisKzbA7UNr6gnNwtN23zlchYZ1NbevzcTJjq+Mqq
	ZGSwq+fyN/KU8RScjUyyMB2D+Nlg5WeK5wYjTZgwDVZ+MeDMCf/BqXi8Tdp4zS9+
	qgTLyAW5z5FsI9t+S9fD447HJWCV4aw8Q3Q==
X-ME-Sender: <xms:5i9eaeva0y8YbXbGBYTlPc9GJMseWlzY-bonKkD9uphJN_h_U0zN-Q>
    <xme:5i9eaVtcVU1xvRQ48omZo6VFAqbl6oRHh-_l8OMh4gVuQnMXc_ZtRyAT-yeNmaE46
    ALqnD0-zg4dKCOA5uV8FbCiuY5pJ4RQyGUo2IkdWa-BMz5F2KF9>
X-ME-Received: <xmr:5i9eacDweZcmsEZ0LD6ApQcxGr2YLMdxXUWECXCsHzRVYbVfvf0YPobehx0c1Y2eQZNLIybmDrtnX4ua1C7ta9mWvrtlS0gpTpNd2-kMNBI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutddvjeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihloh
    hrrhdrtghomhdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghi
    lhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhhrihhs
    tghoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikhdrud
    ekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:5i9eafNv5wzlNtua16NijzMo5GRh7zRFD11VUW85K9pSUxu2m7_G8A>
    <xmx:5i9eadzQ16JSnUkO5LqByq7j5B_cvC41Gyc8jQCvAldtxsT-gZnFPg>
    <xmx:5i9eaXX1puB0LIgxvoAENgPEnEWx56AMNfVxw9lHec_aTCCgnVCwdQ>
    <xmx:5i9eaXP8U9nEuvCdhkZl2utDDfdHfpHsgGBz1AgwvLA4ze3Ieullxw>
    <xmx:5y9eaceitY6ZGEPSFVdmj3ZV-_JTw5R4epwFm5VWO2tOmy9lOWFuXOWI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Jan 2026 05:05:25 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 10a41c79 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 7 Jan 2026 10:05:23 +0000 (UTC)
Date: Wed, 7 Jan 2026 11:05:16 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 2/9] promisor-remote: allow a client to store fields
Message-ID: <aV4v3JwW0S-c9Dn4@pks.im>
References: <20251223111113.47473-1-christian.couder@gmail.com>
 <20251223111113.47473-3-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251223111113.47473-3-christian.couder@gmail.com>

On Tue, Dec 23, 2025 at 12:11:06PM +0100, Christian Couder wrote:
> A previous commit allowed a server to pass additional fields through
> the "promisor-remote" protocol capability after the "name" and "url"
> fields, specifically the "partialCloneFilter" and "token" fields.
> 
> Another previous commit, c213820c51 (promisor-remote: allow a client
> to check fields, 2025-09-08), has made it possible for a client to
> decide if it accepts a promisor remote advertised by a server based
> on these additional fields.
> 
> Often though, it would be interesting for the client to just store in
> its configuration files these additional fields passed by the server,
> so that it can use them when needed.
> 
> For example if a token is necessary to access a promisor remote, that
> token could be updated frequently only on the server side and then
> passed to all the clients through the "promisor-remote" capability,
> avoiding the need to update it on all the clients manually.
> 
> Storing the token on the client side makes sure that the token is
> available when the client needs to access the promisor remotes for a
> lazy fetch.

I guess another use case is that a client performs a fresh clone and
doesn't know anything about the remote's promisors yet, right? In that
case, the client may want to tell git-clone(1) to accept any of the
remote's advertised promisors, store it and then use that promisor's
filter to perform the actual clone.

> In the same way, if it appears that it's better to use a different
> filter to access a promisor remote, it could be helpful if the client
> could automatically use it.
> 
> To allow this, let's introduce a new "promisor.storeFields"
> configuration variable.
> 
> Like "promisor.checkFields" and "promisor.sendFields", it should
> contain a comma or space separated list of field names. Only the
> "partialCloneFilter" and "token" field names are supported for now.
> 
> When a server advertises a promisor remote, for example "foo", along
> with for example "token=XXXXX" to a client, and on the client side
> "promisor.storeFields" contains "token", then the client will store
> XXXXX for the "remote.foo.token" variable in its configuration file
> and reload its configuration so it can immediately use this new
> configuration variable.
> 
> A message is emitted on stderr to warn users when the config is
> changed.
> 
> Note that even if "promisor.acceptFromServer" is set to "all", a
> promisor remote has to be already configured on the client side for
> some of its config to be changed. In any case no new remote is
> configured and no new URL is stored.

Hm, okay, so that's not yet part of this series. I assume this is going
to be part of a subsequent patch series then?

> diff --git a/promisor-remote.c b/promisor-remote.c
> index 5d8151cedb..8d6d2d7b76 100644
> --- a/promisor-remote.c
> +++ b/promisor-remote.c
> @@ -403,6 +403,14 @@ static struct string_list *fields_checked(void)
>  	return initialize_fields_list(&fields_list, &initialized, "promisor.checkFields");
>  }
>  
> +static struct string_list *fields_stored(void)
> +{
> +	static struct string_list fields_list = STRING_LIST_INIT_NODUP;
> +	static int initialized;
> +
> +	return initialize_fields_list(&fields_list, &initialized, "promisor.storeFields");
> +}

I'm a bit worried about all the function-local state that we're
accumulating in those functions. Wouldn't it be preferable if we instead
had a `struct promisor_remote` that encapsulates the information?

> @@ -692,6 +700,132 @@ static struct promisor_info *parse_one_advertised_remote(const char *remote_info
>  	return info;
>  }
>  
> +static bool store_one_field(struct repository *repo, const char *remote_name,
> +			    const char *field_name, const char *field_key,
> +			    const char *advertised, const char *current)
> +{
> +	if (advertised && (!current || strcmp(current, advertised))) {
> +		char *key = xstrfmt("remote.%s.%s", remote_name, field_key);
> +
> +		fprintf(stderr, _("Storing new %s from server for remote '%s'.\n"
> +				  "    '%s' -> '%s'\n"),
> +			field_name, remote_name,
> +			current ? current : "",
> +			advertised);
> +
> +		repo_config_set_worktree_gently(repo, key, advertised);

Why do we store this information in the current per-worktree config? I'd
expect that this should be stored in the local config.

> +		free(key);
> +
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
> +/* Check that a filter is valid by parsing it */
> +static bool valid_filter(const char *filter, const char *remote_name)
> +{
> +	struct list_objects_filter_options filter_opts = LIST_OBJECTS_FILTER_INIT;
> +	struct strbuf err = STRBUF_INIT;
> +	int res = gently_parse_list_objects_filter(&filter_opts, filter, &err);
> +
> +	if (res)
> +		warning(_("invalid filter '%s' for remote '%s' "
> +			  "will not be stored: %s"),
> +			filter, remote_name, err.buf);
> +
> +	list_objects_filter_release(&filter_opts);
> +	strbuf_release(&err);
> +
> +	return !res;
> +}
> +
> +/* Check that a token doesn't contain any control character */
> +static bool valid_token(const char *token, const char *remote_name)
> +{
> +	const char *c = token;
> +
> +	for (; *c; c++)
> +		if (iscntrl(*c)) {

Makes sense. I was also wondering about whether we want to check for
non-space whitespace characters, like newlines.

> +			warning(_("invalid token '%s' for remote '%s' "
> +				  "will not be stored"),
> +				token, remote_name);
> +			return false;
> +		}
> +
> +	return true;
> +}
> +
> +struct store_info {
> +	struct repository *repo;
> +	struct string_list config_info;
> +	bool store_filter;
> +	bool store_token;
> +};
> +
> +static struct store_info *new_store_info(struct repository *repo)

This should be called `store_info_new()` according to our coding
guidelines.

> +{
> +	struct string_list *fields_to_store = fields_stored();
> +	struct store_info *s = xmalloc(sizeof(*s));
> +
> +	s->repo = repo;
> +
> +	string_list_init_nodup(&s->config_info);
> +	promisor_config_info_list(repo, &s->config_info, fields_to_store);
> +	string_list_sort(&s->config_info);
> +
> +	s->store_filter = !!string_list_lookup(fields_to_store, promisor_field_filter);
> +	s->store_token = !!string_list_lookup(fields_to_store, promisor_field_token);
> +
> +	return s;
> +}
> +
> +static void free_store_info(struct store_info *s)

Likewise, this would be `store_info_free()`.

> diff --git a/t/t5710-promisor-remote-capability.sh b/t/t5710-promisor-remote-capability.sh
> index 023735d6a8..a726af214a 100755
> --- a/t/t5710-promisor-remote-capability.sh
> +++ b/t/t5710-promisor-remote-capability.sh
> @@ -360,6 +360,55 @@ test_expect_success "clone with promisor.checkFields" '
>  	check_missing_objects server 1 "$oid"
>  '
>  
> +test_expect_success "clone with promisor.storeFields=partialCloneFilter" '
> +	git -C server config promisor.advertise true &&
> +	test_when_finished "rm -rf client" &&
> +
> +	git -C server remote add otherLop "https://invalid.invalid"  &&
> +	git -C server config remote.otherLop.token "fooBar" &&
> +	git -C server config remote.otherLop.stuff "baz" &&
> +	git -C server config remote.otherLop.partialCloneFilter "blob:limit=10k" &&
> +	test_when_finished "git -C server remote remove otherLop" &&
> +
> +	git -C server config remote.lop.token "fooXXX" &&
> +	git -C server config remote.lop.partialCloneFilter "blob:limit=8k" &&
> +
> +	test_config -C server promisor.sendFields "partialCloneFilter, token" &&
> +	test_when_finished "rm trace" &&
> +
> +	# Clone from server to create a client
> +	GIT_TRACE_PACKET="$(pwd)/trace" GIT_NO_LAZY_FETCH=0 git clone \
> +		-c remote.lop.promisor=true \
> +		-c remote.lop.fetch="+refs/heads/*:refs/remotes/lop/*" \
> +		-c remote.lop.url="file://$(pwd)/lop" \
> +		-c remote.lop.token="fooYYY" \
> +		-c remote.lop.partialCloneFilter="blob:none" \
> +		-c promisor.acceptfromserver=All \
> +		-c promisor.storeFields=partialcloneFilter \
> +		--no-local --filter="blob:limit=5k" server client 2>err &&

Onet thing that's missing in these tests is to verify that a subsequent
git-fetch(1) updates the configuration.

Patrick
