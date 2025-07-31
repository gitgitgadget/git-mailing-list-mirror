Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C522441B8
	for <git@vger.kernel.org>; Thu, 31 Jul 2025 16:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753977839; cv=none; b=uhyQs6VNVK3vWwVGOVMs+rCVO5qAMB2sAvXestVJzvEYurUOKF+M5bfJwV+l6vVNidgYC781HT3goatNaG4QwUrnJnMQxMzwgDmqGH0Kq7v+Rtn0pVz4T+TA6lYAGzhcKI83KTc0kMsT9dzxSKBb0tccjdnnU1reB/UUEptuAK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753977839; c=relaxed/simple;
	bh=zEu56PZhHfODHBPyIcj7TC3hrPiwPAP/rN55gKSYDjM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Zku/B6q1bG20KkVpRTEzKGLH+1BymaUgy+Xcyv93y4bnRdqRKSYjnd48D+X1OHx9J9pxGXW8QHH594OqyJQiaILZUiWcxREM5R73SE0pgj2RXBiHcKi6bTbVASzNHBN4HGMPJRFNSSvXUUGO4GvB4bIpZQkDeBLg1D24ebUxomI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jZZkeetP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Pe3q8lHs; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jZZkeetP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Pe3q8lHs"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 1DCB91D02353;
	Thu, 31 Jul 2025 12:03:56 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Thu, 31 Jul 2025 12:03:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1753977835; x=1754064235; bh=OlO4wHFa7+
	mNvnsXAlc4wgWV1s8N+KoywaykPKDrOy8=; b=jZZkeetPa1G/9wmmpfHW1oyXHJ
	aoeyVJyvoSeFJE7vr48MCS0/zaokjunlezxtxGQzN8MonrDHAeloNYINCnpwm30B
	miNUw8a1KgglE2bfh4uuKH2aQPVy7f7kIddbLgCVx/Mt5E1BPAcsfAE24S+9/omW
	YJNidpo486kw7B4le3Rsv0l/g+zLV0Hp/aI4akyoUINz4UEjB3YOjUs12/RUuxbR
	T9nsX0xOO2IdbiDLtAL28NVwzgYN6MxahYfqV/NF4RMxPkoI90YZ6HLtYF/IOkre
	PSWgrrryP8on6aaDBBC6yexI12Wk3lSFY3aglMML4lBDilGBzyT2neI3pNuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1753977835; x=1754064235; bh=OlO4wHFa7+mNvnsXAlc4wgWV1s8N+Koyway
	kPKDrOy8=; b=Pe3q8lHs4TtvLWWzU2qj2tffYfC9zMYeJIhzQVK3+2PnNHxWnJ7
	S5YUUWCUlX9agX0SrqNvUAEuOkcgeQ3s9VN552ZQNNpuW57X5MPhGIGicRHzC+PN
	zNRVRjmRzN4GtXIFunUDn7JMhYOCinJXUC2T09qi4RDcSqqP00Rl8ESplCCysZPl
	w84vKrSghJreRmfA/CCb2X2ap1+RSJovKN+7i/As9BXUH/D06On5XPMoD45HzrDi
	6emqZgSBiwAhW0VkoNvfmPIsXx0+4UiJR10YDRO7ODJ4lG+DAvW/rCP8m3WJ6EWQ
	JeH4tugoLoLADBME2bbcRc7VehnPYCIWhnQ==
X-ME-Sender: <xms:65OLaILavoAm-KBhW6rj-46Neji38DU66djY2-o-DbFvE7MGfZ8RvQ>
    <xme:65OLaFCqifwqwdkexQaGJE5JwU9_PDxOGWBGecUxLjuwTl8j-SqsC6SNcKIiwEAm8
    3MMYqLCp7mQfO_Erg>
X-ME-Received: <xmr:65OLaIcZ7qS2Vg3bQjr5SAzfT9e6b_LaN98s2-_pHlkFcNvQAUHQIOJlfsHvSH8wkuoyhb645KgO4V4TZpBZZswGsk2H6kz8r9MDvDE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdduvdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtg
    homhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhnrdgrvh
    hilhgrsehfrhgvvgdrfhhrpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghm
    ihhlhidrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:65OLaE1YREAXkbGZ-lVAFoJNt8MWOeUMoIIfm7oFkk2Pwq2ZAA_t4w>
    <xmx:65OLaPh8DAOdtqE32n7CtG8NQ_XhG7OWjP7sJtyduoehtEHOsn4MHg>
    <xmx:65OLaNkBP5JlO7qMjvxnewwciGGWxwSQgKVcGu9KsWFsc20UYMNDfA>
    <xmx:65OLaFamVDrfgeZGtYeD4zMCbYc7j7idMZC8zK1JI30m1BZSNhuSNg>
    <xmx:65OLaBysb7RluG4ZUZ_Rz06paotsQVHxujREy9BWf5h0RweWTrO6er4W>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 31 Jul 2025 12:03:55 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Taylor Blau
 <me@ttaylorr.com>,  Karthik Nayak <karthik.188@gmail.com>,  Justin Tobler
 <jltobler@gmail.com>,  Jean-Noel Avila <jn.avila@free.fr>,  Christian
 Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v7 3/5] promisor-remote: refactor how we parse
 advertised fields
In-Reply-To: <20250731072401.3817074-4-christian.couder@gmail.com> (Christian
	Couder's message of "Thu, 31 Jul 2025 09:23:55 +0200")
References: <20250721141056.2283349-1-christian.couder@gmail.com>
	<20250731072401.3817074-1-christian.couder@gmail.com>
	<20250731072401.3817074-4-christian.couder@gmail.com>
Date: Thu, 31 Jul 2025 09:03:54 -0700
Message-ID: <xmqqh5yss5xx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

> +static struct promisor_info *parse_one_advertised_remote(struct strbuf *remote_info)
> +{
> +	struct promisor_info *info = xcalloc(1, sizeof(*info));
> +	struct string_list elem_list = STRING_LIST_INIT_NODUP;
> +	struct string_list_item *item;
> +
> +	string_list_split_in_place(&elem_list, remote_info->buf, ",", -1);

This munges a strbuf pointed by a structure that was supplied by the
caller as a parameter to this function.  Most notably, all commas in
remote_info->buf are replaced with NULs.

A quick read of the sole caller of this function reveals that the
caller passes one element of an array of strbuf it obtained by
calling strbuf_split_str() for the only purpose of calling this
function, and the caller never looks at the .buf member itself, so I
think this munging with _in_place() would not hurt the caller.

> +	for_each_string_list_item(item, &elem_list) {
> +		char *elem = item->string;
> +		char *value;
> +		char *p = strchr(elem, '=');
> +
> +		if (!p) {
> +			warning(_("invalid element '%s' from remote info"), elem);
> +			continue;
> +		}

We find the first '=' and ...

> +		*p = '\0';

... replace it with NUL; the item->string here is now split into elem & value.

> +		value = url_percent_decode(p + 1);

And the value gets decoded.

> +		if (!strcmp(elem, "name"))
> +			info->name = value;
> +		else if (!strcmp(elem, "url"))
> +			info->url = value;
> +		else
> +			free(value);
> +	}
> +
> +	string_list_clear(&elem_list, 0);

And we are done with the string list that holds the pieces of remote
info split out.

> +	if (!info->name || !info->url) {
> +		warning(_("server advertised a promisor remote without a name or URL: %s"),
> +			remote_info->buf);

But this use of remote_info->buf will no longer give us much useful
information.  It might say something like "name", and the warning
would not let us see what the rest of the remote_info->buf used to
have before _in_place splitting.

I think initializing elem_list with INIT_DUP and using string_list_split()
without _in_place should be sufficient to fix this.

> @@ -604,32 +651,19 @@ static void filter_promisor_remote(struct repository *repo,
>  	remotes = strbuf_split_str(info, ';', 0);

If we splitted this into a string list, then each item in it
will not have the terminating ';' at its end, therefore ...

>  	for (size_t i = 0; remotes[i]; i++) {
> -		struct strbuf **elems;
> -		const char *remote_name = NULL;
> -		const char *remote_url = NULL;
> -		char *decoded_name = NULL;
> -		char *decoded_url = NULL;
> +		struct promisor_info *advertised;
>  
>  		strbuf_strip_suffix(remotes[i], ";");

... this strip_suffix() will become unnecessary.

> +		advertised = parse_one_advertised_remote(remotes[i]);

Such a change would require this call to be made with const char *
not struct strbuf * as a parameter, but the callee we just saw above
uses its parameter (i.e. remote_info) only to look at the .buf member,
and does not take any advantage of it being a strbuf (like it can be
trimmed or its length is known without running strlen(.buf) on it),
so that should be an easy conversion.

> +		if (!advertised)
> +			continue;
>  
> +		if (should_accept_remote(accept, advertised, &config_info))
> +			strvec_push(accepted, advertised->name);
>  
> -		strbuf_list_free(elems);
> -		free(decoded_name);
> -		free(decoded_url);
> +		promisor_info_free(advertised);
>  	}
>  
>  	promisor_info_list_clear(&config_info);

Overall looking very promising.  Thanks for working on the topic.
