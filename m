Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4AC259CBD
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 18:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775155076; cv=none; b=knNeACe+Ua6DC68Po4JXVdCsGQy7teLKHPiSmjWpiQjb6t1kw7fSM9wb/rqAbP7cI7SWSyhTtc+fCQFRp4rWoDTS27WjhG4UWkAzlv02dp/Vcor2Y4y3xb3COCfZDhWKq5dKPtr3VElYLiPMKh77k/WBAUCKy8ztkJLt+swJZAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775155076; c=relaxed/simple;
	bh=5OCHcWcjby4nmjNNok54h9a+l1pce/gCNN1DaeaPHoA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pOhyS882f/UBZWCLMy/uXDKohVohkavSb7MGN2JHlTVKTpTmXzGdS1Lr/3AtTYSTUM53HXiAtpwbkqxWCJAGHol8mowc2fGvmPjGk5uSOM6dzEuLdcSbhBY9hMXcF/W77NBLiM9Y7MQy0dl6L/kBjAkvBs2bQOl0xCMinZov4PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HSLCMnJp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZkrAeSlW; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HSLCMnJp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZkrAeSlW"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9171114001C5;
	Thu,  2 Apr 2026 14:37:53 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Thu, 02 Apr 2026 14:37:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775155073; x=1775241473; bh=QTU633xg8y
	4VVb8NGAZTzzL8AqlI+nCAto6zWrtqQKs=; b=HSLCMnJpMuCDKuxUy6+utniBJN
	L0S5qDTn0fZwGj11tKGIeIPM48KHpKSS8mgIx/a+CoIC9USEHdzKTJyFRlKNot0t
	LLx5Y6MKm3BThHMFCjQ3YCJNBTjy/me7VMexM8Xl1M41nJgIHzb46dL8IMQvgjH4
	1hUXqRfyec2hq2ShcGyXHbXJSx5oDMZnxEfNzQ2cubxOdDkB6SWn54dhXhpmFusB
	qVjDftc4MWjfq3KPHrz8yedy7Oj6PWSznqvI1dLOPDvzGdU6vR1Qdlw2Ar/l+cmF
	HTWW++NQTEPG6HgVmxj4Epp6APBD1Jn1jJbjYliAVn+0kveGrEx3iAS6AQZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775155073; x=1775241473; bh=QTU633xg8y4VVb8NGAZTzzL8AqlI+nCAto6
	zWrtqQKs=; b=ZkrAeSlWRyvnRSUuGQNU89VFiqVuRbY5Dy47fb/b2X7PrNC/H4N
	c/rkzDPDuQYYQTowl6YENm8yrOAk/lkJbyYmlJ+4c5temzKsSaV5vhqh6O2yTsud
	3C8+baecijtYvcC5LpRZlW5db1ptrv6LWUASMMqcn9+ZuevH5LrctIwVd7ySTGqN
	zF8imNaS7tsXXVl9Z0ouzMpO6iJcUKf4TJ0lLt5KyjkQxnQAalOSV5QjmZajlwvi
	Vl5fBG1kmmTYIcpChqDQbaEHZFh7diz17STBC1ZW09YK3C/COE2ZIh4Ts/CTUahD
	FZYNYHrEEY6PrQRFKPTEU6WWQQDMW/jSg6w==
X-ME-Sender: <xms:gbfOaUpJCROAPYX79opMj3hS5zbWZwBFg-hBtLQrQ0SI8BUcJNxcFg>
    <xme:gbfOac600i3ESpdUZZD8zk4ig07c7wWHJZOWbWOp-cnKroqkaqIi8LElD2yBdx5U2
    whgThmDCTbEzkJmH48B1ijUQC0PwxC6167MUz4vqtuXClXINGzxTbE>
X-ME-Received: <xmr:gbfOabfrUw5D-ioJjuP57UdHRxCi6a0kNw_2YDPNMaQWfkVy464XcYN24cOgd2TihE-Ofd89Yer04LXYBOvtDyOTtr1-2cpENA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeijeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepveellefhgfdugfetgfeuteegvdffvefgveetgfetheegkefhfeeuveeigffhgeeu
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpghhithhhuhgsrdgtohhmnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhes
    phhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpd
    hrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpsh
    esphhkshdrihhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvfi
    hrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomh
X-ME-Proxy: <xmx:gbfOaR415Qx1d_aqnRAl4h_egUitJZZtt6mSo0ceB244XWlezjwu4Q>
    <xmx:gbfOaStmra4GWq1oo0wHx0aR6cxTX6lxFePFPtv4iNY1MIYdVq6pcg>
    <xmx:gbfOaRiCkPWgQckpV-6n_N4kck6NDNEo3zuG1xblWGmZrBh5r_GxtQ>
    <xmx:gbfOadpPY5U--IskLhIg9GpeinR_sxN66pNMMrGwXY50QTE2fXZTZg>
    <xmx:gbfOaRheCGNKBt4Ml-6FBiTIKF_GwewEt3Koeg7wA9GYxMz8O7EA8HqZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Apr 2026 14:37:52 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Taylor Blau
 <me@ttaylorr.com>,  Karthik Nayak <karthik.188@gmail.com>,  Elijah Newren
 <newren@gmail.com>
Subject: Re: [PATCH 00/10] Prepare for advertised remotes auto-configure via
 URL allowlist
In-Reply-To: <20260402070613.85934-1-christian.couder@gmail.com> (Christian
	Couder's message of "Thu, 2 Apr 2026 09:06:03 +0200")
References: <20260402070613.85934-1-christian.couder@gmail.com>
Date: Thu, 02 Apr 2026 11:37:51 -0700
Message-ID: <xmqq5x69qkcg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

> Recently, I sent a 16 patch long series that makes it possible for
> promisor remotes advertised through the "promisor-remote" protocol
> capability to be auto-configured on the client side via a URL
> allowlist configured using a new `promisor.acceptFromServerUrl`
> configuration variable:
>
> https://lore.kernel.org/git/20260323080520.887550-1-christian.couder@gmail.com/
>
> I got the suggestion to split the 16 patches series into two smaller
> series, starting with a preparatory series. So here is this
> preparatory series. It's a mix of mostly small fixes, refactorings and
> cleanups.
>
> High level description of the patches
> =====================================
>
>  - Patches 1-4/10 are fixes:
>
>    - Patch 1/10 is the most significant. The others are relatively
>      small.
>      
>    - Patch 4/10 is the only new in this series (while all the others
>      were in the previous series). It prepares for Patch 5/10.
>
>  - Patches 5-10/10 are refactorings and cleanups:
>
>    - Patches 5-7/10 are relatively small independents cleanups or
>      refactorings.
>
>    - Patches 8-9/10 are related refactorings simplifying the data
>      structures used in filter_promisor_remote() and
>      promisor_remote_reply().
>
>    - Patch 10/10 is cleaning up the 'file://' URIs with absolute paths
>      in the test script.
>
> CI tests
> ========
>
> They all pass, see:
>
> https://github.com/chriscool/git/actions/runs/23848484597
>
> Range-diff
> ==========
>
> Sorry, no range-diff as I don't think it would be quite useful because
> the number and order of commits has changed a lot.

When comparing against 16-patch series from the previous round, 6 of
the old patches will have no corresponding patch in this round,
which is expected.  But for the remaining 10 commits, the command
seems to do a decent job matching up the corresponding patches from
the previous round.  It is especially pleasing to see that the first
one from each round are matched up and showing that its tests are
moderately extended.

 1:  292252ce36 !  1:  d904d5f94d promisor-remote: try accepted remotes before others in get_direct()
    @@ Commit message
         Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
    + ## Documentation/gitprotocol-v2.adoc ##
    +@@ Documentation/gitprotocol-v2.adoc: advertised, it can reply with "promisor-remote=<pr-names>" where
    + where `pr-name` is the urlencoded name of a promisor remote the server
    + advertised and the client accepts.
    + 
    ++The promisor remotes that the client accepted will be tried before the
    ++other configured promisor remotes when the client attempts to fetch
    ++missing objects.
    ++
    + Note that, everywhere in this document, the ';' and ',' characters
    + MUST be encoded if they appear in `pr-name` or `field-value`.
    + 
    +
      ## promisor-remote.c ##
     @@ promisor-remote.c: static int remove_fetched_oids(struct repository *repo,
      	return remaining_nr;
    @@ promisor-remote.c: static int remove_fetched_oids(struct repository *repo,
     +	struct promisor_remote *r = repo->promisor_remote_config->promisors;
     +
     +	for (; r; r = r->next) {
    -+		if (accepted_only && !r->accepted)
    -+			continue;
    -+		if (!accepted_only && r->accepted)
    ++		if (accepted_only != r->accepted)
     +			continue;
     +		if (fetch_objects(repo, r->name, *remaining_oids, *remaining_nr) < 0) {
     +			if (*remaining_nr == 1)
    @@ promisor-remote.c: void promisor_remote_get_direct(struct repository *repo,
      
      	for (i = 0; i < remaining_nr; i++) {
      		if (is_promisor_object(repo, &remaining_oids[i]))
    +
    + ## t/t5710-promisor-remote-capability.sh ##
    +@@ t/t5710-promisor-remote-capability.sh: test_expect_success "init + fetch with promisor.advertise set to 'true'" '
    + 	check_missing_objects server 1 "$oid"
    + '
    + 
    ++test_expect_success "clone with two promisors but only one advertised" '
    ++	git -C server config promisor.advertise true &&
    ++	test_when_finished "rm -rf client unused_lop" &&
    ++
    ++	# Create a promisor that will be configured but not be used
    ++	git init --bare unused_lop &&
    ++
    ++	# Clone from server to create a client
    ++	GIT_TRACE="$(pwd)/trace" GIT_NO_LAZY_FETCH=0 git clone \
    ++		-c remote.unused_lop.promisor=true \
    ++		-c remote.unused_lop.fetch="+refs/heads/*:refs/remotes/unused_lop/*" \
    ++		-c remote.unused_lop.url="file://$(pwd)/unused_lop" \
    ++		-c remote.lop.promisor=true \
    ++		-c remote.lop.fetch="+refs/heads/*:refs/remotes/lop/*" \
    ++		-c remote.lop.url="file://$(pwd)/lop" \
    ++		-c promisor.acceptfromserver=All \
    ++		--no-local --filter="blob:limit=5k" server client &&
    ++
    ++	# Check that "unused_lop" appears before "lop" in the config
    ++	printf "remote.%s.promisor true\n" "unused_lop" "lop" "origin" >expect &&
    ++	git -C client config get --all --show-names --regexp "^remote\..*\.promisor$" >actual &&
    ++	test_cmp expect actual &&
    ++
    ++	# Check that "lop" was tried
    ++	test_grep " fetch lop " trace &&
    ++	# Check that "unused_lop" was not contacted
    ++	# This means "lop", the accepted promisor, was tried first
    ++	test_grep ! " fetch unused_lop " trace &&
    ++
    ++	# Check that the largest object is still missing on the server
    ++	check_missing_objects server 1 "$oid"
    ++'
    ++
    ++test_expect_success "init + fetch two promisors but only one advertised" '
    ++	git -C server config promisor.advertise true &&
    ++	test_when_finished "rm -rf client unused_lop" &&
    ++
    ++	# Create a promisor that will be configured but not be used
    ++	git init --bare unused_lop &&
    ++
    ++	mkdir client &&
    ++	git -C client init &&
    ++	git -C client config remote.unused_lop.promisor true &&
    ++	git -C client config remote.unused_lop.fetch "+refs/heads/*:refs/remotes/unused_lop/*" &&
    ++	git -C client config remote.unused_lop.url "file://$(pwd)/unused_lop" &&
    ++	git -C client config remote.lop.promisor true &&
    ++	git -C client config remote.lop.fetch "+refs/heads/*:refs/remotes/lop/*" &&
    ++	git -C client config remote.lop.url "file://$(pwd)/lop" &&
    ++	git -C client config remote.server.url "file://$(pwd)/server" &&
    ++	git -C client config remote.server.fetch "+refs/heads/*:refs/remotes/server/*" &&
    ++	git -C client config promisor.acceptfromserver All &&
    ++
    ++	# Check that "unused_lop" appears before "lop" in the config
    ++	printf "remote.%s.promisor true\n" "unused_lop" "lop" >expect &&
    ++	git -C client config get --all --show-names --regexp "^remote\..*\.promisor$" >actual &&
    ++	test_cmp expect actual &&
    ++
    ++	GIT_TRACE="$(pwd)/trace" GIT_NO_LAZY_FETCH=0 git -C client fetch --filter="blob:limit=5k" server &&
    ++
    ++	# Check that "lop" was tried
    ++	test_grep " fetch lop " trace &&
    ++	# Check that "unused_lop" was not contacted
    ++	# This means "lop", the accepted promisor, was tried first
    ++	test_grep ! " fetch unused_lop " trace &&
    ++
    ++	# Check that the largest object is still missing on the server
    ++	check_missing_objects server 1 "$oid"
    ++'
    ++
    + test_expect_success "clone with promisor.acceptfromserver set to 'KnownName'" '
    + 	git -C server config promisor.advertise true &&
    + 	test_when_finished "rm -rf client" &&
 2:  8cea12d525 <  -:  ---------- urlmatch: change 'allow_globs' arg to bool
 3:  30e3618f1b <  -:  ---------- urlmatch: add url_is_valid_pattern() helper
10:  0ccf10712d !  2:  54174b6db5 promisor-remote: pass config entry to all_fields_match() directly
    @@ Metadata
      ## Commit message ##
         promisor-remote: pass config entry to all_fields_match() directly
     
    -    The `in_list == 0` path of all_fields_match() re-looks up the
    -    remote in config_info by advertised->name, even though every
    +    The `in_list == 0` path of all_fields_match() looks up the remote in
    +    `config_info` by `advertised->name` repeatedly, even though every
         caller in should_accept_remote() has already performed this
    -    lookup and holds the result in 'p'.
    +    lookup and holds the result in `p`.
     
         To avoid this useless work, let's replace the `int in_list`
         parameter with a `struct promisor_info *config_entry` pointer:
    @@ Commit message
            avoiding the redundant string_list_lookup() call.
     
         This removes the hidden dependency on `advertised->name` inside
    -    all_fields_match(), which would be wrong in the following commits when
    -    auto-configured remotes will be implemented as the local config name
    -    may differ from the server's advertised name.
    +    all_fields_match(), which would be wrong if in the future
    +    auto-configured remotes are implemented, as the local config name may
    +    differ from the server's advertised name.
    +
    +    While at it, let's also add a comment before all_fields_match() and
    +    match_field_against_config() to help understand how things work and
    +    help avoid similar issues.
     
         Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      ## promisor-remote.c ##
    +@@ promisor-remote.c: enum accept_promisor {
    + 	ACCEPT_ALL
    + };
    + 
    ++/*
    ++ * Check if a specific field and its advertised value match the local
    ++ * configuration of a given promisor remote.
    ++ *
    ++ * Returns 1 if they match, 0 otherwise.
    ++ */
    + static int match_field_against_config(const char *field, const char *value,
    + 				      struct promisor_info *config_info)
    + {
     @@ promisor-remote.c: static int match_field_against_config(const char *field, const char *value,
      	return 0;
      }
    @@ promisor-remote.c: static int should_accept_remote(enum accept_promisor accept,
     -		return all_fields_match(advertised, config_info, 0);
     +		return all_fields_match(advertised, config_info, p);
      
    - 	warning(_("known remote named '%s' but with URL '%s' instead of '%s', "
    - 		  "ignoring this remote"), remote_name, p->url, remote_url);
    + 	warning(_("known remote named '%s' but with URL '%s' instead of '%s'"),
    + 		remote_name, p->url, remote_url);
 4:  b602c1d5ad !  3:  56642a3c6a promisor-remote: clarify that a remote is ignored
    @@ Metadata
      ## Commit message ##
         promisor-remote: clarify that a remote is ignored
     
    -    In should_accept_remote() when a remote is ignored, we might tell users
    -    why it is ignored in a warning, but we don't tell them that the remote
    -    is actually ignored.
    +    In should_accept_remote() and parse_one_advertised_remote(), when a
    +    remote is ignored, we tell users why it is ignored in a warning, but we
    +    don't tell them that the remote is actually ignored.
     
         Let's clarify that, so users have a better idea of what's actually
         happening.
    @@ promisor-remote.c: static int should_accept_remote(enum accept_promisor accept,
      	}
      
      	if (!strcmp(p->url, remote_url))
    - 		return all_fields_match(advertised, config_info, 0);
    + 		return all_fields_match(advertised, config_info, p);
      
     -	warning(_("known remote named '%s' but with URL '%s' instead of '%s'"),
     -		remote_name, p->url, remote_url);
    @@ promisor-remote.c: static int should_accept_remote(enum accept_promisor accept,
      
      	return 0;
      }
    +@@ promisor-remote.c: static struct promisor_info *parse_one_advertised_remote(const char *remote_info
    + 	string_list_clear(&elem_list, 0);
    + 
    + 	if (!info->name || !info->url) {
    +-		warning(_("server advertised a promisor remote without a name or URL: %s"),
    +-			remote_info);
    ++		warning(_("server advertised a promisor remote without a name or URL: '%s', "
    ++			  "ignoring this remote"), remote_info);
    + 		promisor_info_free(info);
    + 		return NULL;
    + 	}
 -:  ---------- >  4:  859ba9d41c promisor-remote: reject empty name or URL in advertised remote
11:  c2b234a4ce !  5:  724f9bbc22 promisor-remote: refactor should_accept_remote() control flow
    @@ Metadata
      ## Commit message ##
         promisor-remote: refactor should_accept_remote() control flow
     
    -    In following commits, we are going to add URL-based acceptance logic
    -    into should_accept_remote().
    +    A previous commit made sure we now reject empty URLs early at parse
    +    time. This makes the existing warning() in case a remote URL is NULL
    +    or empty very unlikely to be useful.
     
    -    To prepare for the upcoming changes, let's restructure the control flow
    -    in should_accept_remote().
    +    In future work, we also plan to add URL-based acceptance logic into
    +    should_accept_remote().
    +
    +    To adapt to previous changes and prepare for upcoming changes, let's
    +    restructure the control flow in should_accept_remote().
     
         Concretely, let's:
     
    -     - Move the empty-URL check to the very top of the function, so that
    -       every acceptance mode, instead of only ACCEPT_KNOWN_URL, rejects
    -       remotes with a missing or blank URL early.
    +     - Replace the warning() in case of an empty URL with a BUG(), as a
    +       previous commit made sure empty URLs are rejected early at parse
    +       time.
    +
    +     - Move that modified empty-URL check to the very top of the function,
    +       so that every acceptance mode, instead of only ACCEPT_KNOWN_URL, is
    +       covered.
     
          - Invert the URL comparison: instead of returning on match and
            warning on mismatch, return early on mismatch and let the match
            case fall through. This opens a single exit path at the bottom of
    -       the function for following commits to extend.
    -
    -    Anyway the server shouldn't send any empty URL in the first place, so
    -    this shouldn't change any behavior in practice.
    +       the function for future commits to extend.
     
         Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
    @@ promisor-remote.c: static int should_accept_remote(enum accept_promisor accept,
      	const char *remote_name = advertised->name;
      	const char *remote_url = advertised->url;
      
    -+	if (!remote_url || !*remote_url) {
    -+		warning(_("no or empty URL advertised for remote '%s', "
    -+			  "ignoring this remote"), remote_name);
    -+		return 0;
    -+	}
    ++	if (!remote_url || !*remote_url)
    ++		BUG("no or empty URL advertised for remote '%s'; "
    ++		    "this remote should have been rejected earlier",
    ++		    remote_name);
     +
      	if (accept == ACCEPT_ALL)
      		return all_fields_match(advertised, config_info, NULL);
 5:  c51bed2fe6 !  6:  80cfbccba9 promisor-remote: refactor has_control_char()
    @@ Metadata
      ## Commit message ##
         promisor-remote: refactor has_control_char()
     
    -    In a following commit we are going to check if some strings contain
    -    control character, so let's refactor the logic to do that in a new
    +    In a future commit we are going to check if some strings contain
    +    control characters, so let's refactor the logic to do that in a new
         has_control_char() helper function.
     
    +    It cleans up the code a bit anyway.
    +
         Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
 6:  b063f4596a !  7:  3f2d6f8a50 promisor-remote: refactor accept_from_server()
    @@ Metadata
      ## Commit message ##
         promisor-remote: refactor accept_from_server()
     
    -    In a following commit, we are going to add more logic to
    +    In future commits, we are going to add more logic to
         filter_promisor_remote() which is already doing a lot of things.
     
         Let's alleviate that by moving the logic that checks and validates the
 7:  1e378b33c0 !  8:  dff4d339c8 promisor-remote: keep accepted promisor_info structs alive
    @@ Commit message
         protocol reply, apply advertised filters, and mark remotes as
         accepted, rather than iterating three separate structures.
     
    -    This refactoring also prepares for a following commit that will add a
    +    This refactoring also prepares for a future commit that will add a
         'local_name' member to 'struct promisor_info'. Since struct instances
         stay alive, downstream code will be able to simply read both names
         from them rather than needing yet another parallel strvec.
 8:  2304313704 =  9:  1fb08184c4 promisor-remote: remove the 'accepted' strvec
 9:  86d6a9e385 <  -:  ---------- promisor-remote: add 'local_name' to 'struct promisor_info'
12:  5c4461affc ! 10:  7cb0268075 t5710: use proper file:// URIs for absolute paths
    @@ Commit message
         (`file://D:/a/repo`). Standard URI parsers misinterpret this format,
         treating `D:` as the host rather than part of the absolute path.
     
    +    This is to be expected because RFC 8089 says that the `//` prefix with
    +    an empty local host must be followed by an absolute path starting with
    +    a slash.
    +
         While this hasn't broken the existing tests (because the old
    -    `promisor.acceptFromServer` logic relies entirely on strict `strcmp`
    +    `promisor.acceptFromServer` logic relies entirely on strict `strcmp()`
         without normalizing the URLs), it will break future commits that pass
    -    these URLs through `url_normalize()`.
    +    these URLs through `url_normalize()` or similar functions.
     
         To future-proof the tests and ensure cross-platform URI compliance,
         let's introduce a $PWD_URL helper that explicitly guarantees a leading
13:  294155978a <  -:  ---------- promisor-remote: introduce promisor.acceptFromServerUrl
14:  f17a3ed35b <  -:  ---------- promisor-remote: trust known remotes matching acceptFromServerUrl
15:  db503a285d <  -:  ---------- promisor-remote: auto-configure unknown remotes
16:  d92889efa9 <  -:  ---------- doc: promisor: improve acceptFromServer entry




> Christian Couder (10):
>   promisor-remote: try accepted remotes before others in get_direct()
>   promisor-remote: pass config entry to all_fields_match() directly
>   promisor-remote: clarify that a remote is ignored
>   promisor-remote: reject empty name or URL in advertised remote
>   promisor-remote: refactor should_accept_remote() control flow
>   promisor-remote: refactor has_control_char()
>   promisor-remote: refactor accept_from_server()
>   promisor-remote: keep accepted promisor_info structs alive
>   promisor-remote: remove the 'accepted' strvec
>   t5710: use proper file:// URIs for absolute paths
>
>  Documentation/gitprotocol-v2.adoc     |   4 +
>  promisor-remote.c                     | 207 +++++++++++++++-----------
>  t/t5710-promisor-remote-capability.sh | 122 ++++++++++++---
>  3 files changed, 223 insertions(+), 110 deletions(-)
