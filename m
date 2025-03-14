Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C581A202C3D
	for <git@vger.kernel.org>; Fri, 14 Mar 2025 18:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741978783; cv=none; b=Kh+12N5fYSpq8xXON5Dtq32cmGky7O6aSJQ5JAG0VM/62CyQ0e1sZVziSgG+ZQxYM33fyC3aLidxlwgDUTV3xdw+4CkzgzgrpmxMav4qMLKEfHdFOqXpcN/fJMV1JrS71D1uhZGFW6MyeYRA2EgSTwWxht3yzAfkmMWjj+4opVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741978783; c=relaxed/simple;
	bh=vRKYnSvM6uo0MRW6qC8cg9L+QC0sGHRHSB0+u6hh9WM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uYcrX459iG4LnwVLmGCUafxqASRtrLAVeNZuRm3qyPWK24xz+0ticErSp29Y4Nyi9rBZ/pc7jy3KMwpunxAeGsgQNLDWkWz8vz5Z183B9clNIg6SAX8GbKiEIvwjQlfpD+avFE5r/aRIP/VAijaE5u6Gl8ILOm6Ditc73HG5kMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QqxtTkGF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZdTQhZy9; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QqxtTkGF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZdTQhZy9"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9ECC22540198;
	Fri, 14 Mar 2025 14:59:39 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Fri, 14 Mar 2025 14:59:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741978779; x=1742065179; bh=rPBv0gPnqG
	CBR1aYQg7LlBpLs7LksSRf/WkP8jqERkE=; b=QqxtTkGF4bNrR7o9yuxoViFdu8
	4R1Rc+z/A/gOZ8W91IQkVewtIyt4ORqYmX7wyvqHezeGEquvsDzseaA5s0bjYSjD
	DH6w0ojeHNW0TziFZOxF6xhuigjvdQyHiOqD9d7rits+OTh8xdrxvZ/SmlJ0APg+
	zneybQFCyeH6scAZss6icjVO5qhDVWahrbo8/kkMyP36x7hlifH/zVM2DYO7ykBr
	xFoh+8tWmuNYPcISQdR93uwROzQ9L1h79gClRYF80iwEeiqZOFZt60f8Jq4PnIRF
	QfA3IV7ZRqtdT3tN3/12M7WBsiACqwOqD0nqG1fdH+BZ+ThqLD36fUjmsTpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741978779; x=1742065179; bh=rPBv0gPnqGCBR1aYQg7LlBpLs7LksSRf/Wk
	P8jqERkE=; b=ZdTQhZy93h/noAlPhzCKje/FrGBCXPtA3O63CL3p3Nhu8WFfSIG
	B5+GvLtEdv2iR9jg+Np2qqN4u522KD1CoDcVXRzv2nl5roYU38Tn64NygfHY4Ffh
	jnIWMlCiNuqUi6ma2XTUi85X2uMU7QMpMLdcVamAhO57ixvK3l8jrREzHxglYhhv
	Ye0L2bn+Uj6D8nN1R+9YnSiLbYza7vaJO979ZmjBaSUGBbu7cA1dnd2KVBcETVfw
	XD141wiwKpe1XKM3hX27N+9KtbKUNevcvlRah0M5jZhF0CIuSsSQajMoVaMAUAg6
	mp9Xcp7c2JZq+war8fpiv0bmRo35/7iA/hA==
X-ME-Sender: <xms:mnzUZ9GnipET31aHgvQaDOy_r8S2gzHcDFHYJJA7MNqGMXTM39w2BA>
    <xme:mnzUZyVWccWKvzTo1cGmLBgFP9p_BIiR4abyiFqucmR6h7sDHFQhexsi-mPJrPLjG
    xHYmUJmol-xWcqUSg>
X-ME-Received: <xmr:mnzUZ_JDI1w-3o7O7qYnW7SAFJElmk5AZ_pzizTONWBJEwQCItH1IUcZyYk_-StgZ88QRVanFASxkI9-IUOE6dTp28rmee0_V-tsSL4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufeduieduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtofdttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepieekueefhfetvdfftdegfeekhfffgefg
    feeivddugeffgfffffevvedvieelffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepuddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegthhhrihhsth
    hirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprh
    gtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdr
    tghomhdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpd
    hrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthho
    pehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprh
    gtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvth
X-ME-Proxy: <xmx:mnzUZzHGCq4Fa72I5jVbpVgGXg0lLjRuh594N4NLlgHjE38niY71uw>
    <xmx:mnzUZzUtFjgSuHDi3KRHogJ14LVPF7Q0kRgkhFx6JgliceE1X_O36A>
    <xmx:mnzUZ-N50fH7q4aGRN3S2R2iQnQ_mcTU-oN4smOC2PKguoHGnU59qw>
    <xmx:mnzUZy1plNNHUi77y-BlNz53kis-fAekKOIqOwPc5g9njoFw5-F6MA>
    <xmx:m3zUZ8sOkRBPCnOURxA225TdVFOf5UZWdHFVx--goEJIYXjJfM3GySdj>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Mar 2025 14:59:38 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Patrick Steinhardt
 <ps@pks.im>,  Taylor Blau <me@ttaylorr.com>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Karthik Nayak <karthik.188@gmail.com>,
  Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,  "brian m .
 carlson" <sandals@crustytoothpaste.net>,  "Randall S . Becker"
 <rsbecker@nexbridge.com>,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v5 1/3] promisor-remote: fix segfault when remote URL is
 missing
In-Reply-To: <20250314141203.2548803-2-christian.couder@gmail.com> (Christian
	Couder's message of "Fri, 14 Mar 2025 15:12:01 +0100")
References: <20250313103859.817127-1-christian.couder@gmail.com>
	<20250314141203.2548803-1-christian.couder@gmail.com>
	<20250314141203.2548803-2-christian.couder@gmail.com>
Date: Fri, 14 Mar 2025 11:59:36 -0700
Message-ID: <xmqqecyzfnfr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

> While at it, let's also use git_config_get_string_tmp() instead of
> git_config_get_string() to simplify memory management.
> ...
> -		strvec_push(names, r->name);
> -		strvec_push(urls, git_config_get_string(url_key, &url) ? NULL : url);
> +		/* Only add remotes with a non empty URL */
> +		if (!git_config_get_string_tmp(url_key, &url) && *url) {
> +			strvec_push(names, r->name);
> +			strvec_push(urls, url);
> +		}
>  
> -		free(url);

Nice.

> +test_expect_success "clone with 'KnownName' and missing URL in the config" '
> +	git -C server config promisor.advertise true &&
> +
> +	# Clone from server to create a client
> +	# Lazy fetching by the client from the LOP will fail because of the
> +	# missing URL in the client config, so the server will have to lazy
> +	# fetch from the LOP.
> +	GIT_NO_LAZY_FETCH=0 git clone -c remote.lop.promisor=true \
> +		-c promisor.acceptfromserver=KnownName \
> +		--no-local --filter="blob:limit=5k" server client &&
> +	test_when_finished "rm -rf client" &&

These are the other way around.  When 'clone' fails, test_when_finished
is not run, so nobody arranges the new directory 'client' to be removed.
"git clone" does try to remove in such a case, but we are protecting
against a failing "clone", so swapping them around, i.e. arrange to
remove it and then try to create it, would make more sense.

> +test_expect_success "clone with 'KnownUrl' and url not configured on the server" '
> +	git -C server config promisor.advertise true &&
> +
> +	git -C server config unset remote.lop.url &&
> +	test_when_finished "git -C server config set remote.lop.url \"file://$(pwd)/lop\"" &&

Probably the same principle applies here, but the case where "git
config" fails, it is likely that the file is not touched at all, or
it gets so corrupt beyond salvaging with another "config set", so it
matters much less than the previous one.

> +	# Clone from server to create a client
> +	# It should fail because the client will reject the LOP as URLs are
> +	# different, and the server cannot lazy fetch as the LOP URL is
> +	# missing, so the remote name will be used instead which will fail.
> +	test_must_fail env GIT_NO_LAZY_FETCH=0 git clone -c remote.lop.promisor=true \
> +		-c remote.lop.fetch="+refs/heads/*:refs/remotes/lop/*" \
> +		-c remote.lop.url="file://$(pwd)/lop" \
> +		-c promisor.acceptfromserver=KnownUrl \
> +		--no-local --filter="blob:limit=5k" server client &&
> +
> +	# Check that the largest object is still missing on the server
> +	check_missing_objects server 1 "$oid"
> +'
> +
> +test_expect_success "clone with 'KnownUrl' and empty url, so not advertised" '
> +	git -C server config promisor.advertise true &&
> +
> +	git -C server config set remote.lop.url "" &&
> +	test_when_finished "git -C server config set remote.lop.url \"file://$(pwd)/lop\"" &&
> +
> +	# Clone from server to create a client
> +	# It should fail because the client will reject the LOP as an empty URL is
> +	# not advertised, and the server cannot lazy fetch as the LOP URL is empty,
> +	# so the remote name will be used instead which will fail.
> +	test_must_fail env GIT_NO_LAZY_FETCH=0 git clone -c remote.lop.promisor=true \
> +		-c remote.lop.fetch="+refs/heads/*:refs/remotes/lop/*" \
> +		-c remote.lop.url="file://$(pwd)/lop" \
> +		-c promisor.acceptfromserver=KnownUrl \
> +		--no-local --filter="blob:limit=5k" server client &&
> +
> +	# Check that the largest object is still missing on the server
> +	check_missing_objects server 1 "$oid"
> +'

The test clone is identical to the previous one except for the
four-line comment in the middle.  The set-up on the other side is
different (the server has remote.lop.url set in the previous one to
empty, and unset in this one, which should amount to the same
thing).  Makes sense.

>  test_expect_success "clone with promisor.advertise set to 'true' but don't delete the client" '
>  	git -C server config promisor.advertise true &&
