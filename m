Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0E244E67A
	for <git@vger.kernel.org>; Fri, 24 Jul 2026 18:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784918507; cv=none; b=btmJFEP2f0iSy6tNsM/rUAISFvfnFKOAGGswODNdbTndUMzSJsl+F+aWGsOxTyEJku1Y949eoQ+X4f4KdNGLCfVXZFmiI4Qvjq6XMZ11Iuj6LXd8ALrtCk16nZBswGy/4KTB0dAYD41bmZ24z1d7CE0hqSgIJlJSrXYRGhrlWsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784918507; c=relaxed/simple;
	bh=huwPfmMA3zYF8cZSmd0p9wzZao32pC2Ivg9r40kvCq4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZMzt37BEIgQ68/wjXYVhLf9OYipqcFcUq/7Fq76ibJeD+N9MEFGgFHKdkXu1gv2zMA802yHaifi0zW1PWhNH6q520DpNTR/M+kiGYl49XB3nhlX8Nl7fJOXg6a2pI9x65wAj6p1EgfoWCS+8R7ro07LpiiirfywlPkEffTCXKG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dMk7uIV3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HyDqdSqA; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dMk7uIV3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HyDqdSqA"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 528AF1D00374;
	Fri, 24 Jul 2026 14:41:44 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Fri, 24 Jul 2026 14:41:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784918504; x=1785004904; bh=pg7RaIh5Zk
	3W+8zr8sAyvndFd/3fdK+mw8cnGGTaFOc=; b=dMk7uIV3WbUWrJKCOkK+PmrXHF
	fRDTEKODy4K6VjIhOldm6PzBEleFbPYHU3l6/mf7JNL+lUPfqeOQTgMwUHjzO1mo
	zrvx/LWc7RQ1DdNe+kJlzgZp8lC8sLX+BqC+tC/6n003Ttus8UBBpoFtj0vEVWnS
	VuZ72lzDr9Vh9nli71KZReDkItJ6TA+ADX1brTjOu/AHCiILN/VHpYpIWuqTmj+y
	MnP6TrLDvMqWgT8Kd2Zy0EvtuidXfefzA3piZa18Y0rtOz1uneZ4bX3m85H4jSfF
	UdPAAhRYlb9B8LNZkH/H49wqqQanwe2A1uYcBMLJ+84knKColAv09F3eEMfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784918504; x=1785004904; bh=pg7RaIh5Zk3W+8zr8sAyvndFd/3fdK+mw8c
	nGGTaFOc=; b=HyDqdSqABhYS5evtZA9W5suM+UkCICJDBQY6JNoIWswJ4uJzEkV
	jJsO+UaVzC+heqrrUJqH1tDajFF9ec2DTd8QMxXHDw8DpjkqEvjTg63Y/9YG3kFJ
	luqp6eX3my5aQaA8gkLbtZppbua2pX7KeK7pXa4nU2E2bwUlMTjgM2ZM31we1ANb
	+k1BusmBwfDh7/a5df+0U8ckpl9zDegubiRBaeww7IQ6LoZBBdBRwV8skQA7jgQT
	EMpSWkoTVprseqeKbsDq+qRKYCSrAF8X2QDWMlw+Y3h8mZpkVca/PP/oXNKmn7VI
	H+NFhtQiunL3Vv+h/WSe7qx6KTl2Icw4/Bw==
X-ME-Sender: <xms:6LFjapP6Ktt5RAUmKmPtXWoi0LZgwq39_EN7bkJbC-zU1U9fvqu4gg>
    <xme:6LFjaja6whlgFbEaCO3NsNVfJQbwOW0VU5djVOYkABahxjSJ9DZgeHieqcfNokNlt
    wOJFCHD_kS8npMBquNbDaK0p-7QYznXiv9NvKXcwbVrSHIHWZSjkEA>
X-ME-Received: <xmr:6LFjalrVe53pbH6v1bSrqVuirHJMP6acpAJvPHrhZtel6tBhMlJbzPhwZ6icQGk2kRrEMRcYetgVOTMkuv9Dah63VvjpwVWT2A>
X-ME-Proxy-Cause: dmFkZTEwCqf634vlj58tG049WISWBQbyS1oi3wwicBWMoEP7c48rDllUQvnUoNdzuzYKlj
    shc4MipP/M0xcDB0fpqKhP95RD753YwySGVkhw1bCjTOEKUDNEaXgdrRVm/vsqINicgPa+
    09cAzeioeO6Uwv2jQBq17B8AXNK0dApd0T9cfYLfonmhHiPOhtJt1CNAs7Uh0y4l7PqrU2
    i4vyRYRW+lzi73Gvs4+FgZdCkOtl6X848Rs9/le33bWNrXPBi915V8Ro3gCkCSW4L33XzQ
    dbugl6t21UMBl0Uzoboz3vnjiMFFa7ng7AbTY29IxiClCgQI6UHUYggcuPFCW9HtBYLPYr
    4cqqoQG42Z+oT++zB8pa45tWh37blm4IX8lfOHt3pK5zeI0MqXKzuKkeFPlgBMyIBijNgP
    SUDwMK0ZiOJvOhH/BBAskVn6GTGezKZjCNgwiRx+19i65bvXKTHXcdrCmlZA4fSTVAIv3p
    9gBjp6LLUEutp4iKhIAlrV7BV3SB2b8GM3W3URt4wNdWGDImdcEFvjkn8FbfLAUaPWSmvl
    J1SKyhhXH0Q7upM2Ovwuddu5baPC124TcusseFJk8r2xmvwS8rmyaoFYsbE6Dqsj/QTQSv
    6orQDUUBt/oDCrd/Dda0XoeUjRYeWflfU3CbcKJUzzgY7Xb2cGo+o332rL6w
X-ME-Proxy: <xmx:6LFjavY2K_Po698IWI3WAiaSRpwtnvIUubgkAHrrGi6g99cGSbXKmA>
    <xmx:6LFjalTm8MVyo2YzsLL8Po6VxjO9-tsm4ee4RT1atagqHSMKu9vlZg>
    <xmx:6LFjau4Kg-4f9kTJXnzVgAIQpEKQcG7DEyX-vihuPt4KbhPb15oCHQ>
    <xmx:6LFjaiyF2C6e-QCrKWyTahGz801e-ovVmfFUvlvANsgmDpE7l06JVg>
    <xmx:6LFjajh75dV_bF_IE8J_5-5pdxWMK8PIx1JRX0vM3Jvf1uPkiQG8m7uF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Jul 2026 14:41:43 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/5] setup: detangle loading of loose object maps
In-Reply-To: <20260724-pks-odb-create-on-disk-v1-2-3b3d265d979b@pks.im>
	(Patrick Steinhardt's message of "Fri, 24 Jul 2026 05:48:41 +0200")
References: <20260724-pks-odb-create-on-disk-v1-0-3b3d265d979b@pks.im>
	<20260724-pks-odb-create-on-disk-v1-2-3b3d265d979b@pks.im>
Date: Fri, 24 Jul 2026 11:41:41 -0700
Message-ID: <xmqqh5lo6xi2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> When a repository is configured to use a compatibility hash function
> then we load the loose object map when we initialize the repository.
> This object map provides the mappings between the canonical object hash
> and the compatibility object hash.
>
> Loading the object map happens in `repo_set_compat_hash_algo()`, which
> calls `repo_read_loose_object_map()` in case the compatibility object
> hash is non-zero. This setup sequence has two major downsides:
>
>   - We assume that the primary object database is the "files" object
>     database so that we can extract its "loose" backend. This stops
>     working with pluggable object databases.

I am not sure if I understand this sentence, especially "we can
extract its loose backend" part.  Do you mean 'extract the object
map from the loose backend'?  Or something else?

>   - We require the object database to already have been initialized when
>     configuring the object database. This means that we must intermix
>     configuration of the repository and initialization of its
>     sub-structures in a weird way.
>
> Refactor the logic so that we instead load the loose object map via the
> "loose" backend, which fixes both of the above issues.

It does make sense to have loose_object_map_load() that is very much
specific to the loose object odb source to odb_source_loose_new().
That way set_compat_hash_algo() does not have to assume that files
backend is used as the object store.

> @@ -112,14 +115,10 @@ int repo_read_loose_object_map(struct repository *repo)
>  {
>  	struct odb_source *source;
>  
> -	if (!should_use_loose_object_map(repo))
> -		return 0;
> -
>  	odb_prepare_alternates(repo->objects);
> -
>  	for (source = repo->objects->sources; source; source = source->next) {
>  		struct odb_source_files *files = odb_source_files_downcast(source);
> -		if (load_one_loose_object_map(files->loose) < 0)
> +		if (loose_object_map_load(files->loose) < 0)
>  			return -1;

If this particular source in the list of sources is not backed by
the files backend, would downcast signal the fact (e.g., by
returning NULL) so that we can skip the next call instead?

Or would the next step in refactoring be to define "load object map"
method that is generic to odb_source so that this part does not have
to do any of these and instead simply do

	for (source = ...) {
		if (odb_source_object_map_load(source))
                	return -1;
        }

or something?

