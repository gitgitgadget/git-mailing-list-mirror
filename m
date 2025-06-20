Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8A728B509
	for <git@vger.kernel.org>; Fri, 20 Jun 2025 14:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750429188; cv=none; b=oK5GR8IaRPpwHG9nH3J4cKHxG42UtHeRVypu2wASK22jAYQpr3uK8D9279T0jepgTURm24ieyag6eP/ZA2F04ci1xoXq1qqEZFbWGKqTZsEFlT/M+TV+c2vCSa3zgWNDhNOUrLkhm8NWk7FPn7sXwl892frLyO7GZie0QWkubkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750429188; c=relaxed/simple;
	bh=mqMzXULNopwJSWtvZvgfUZN7p2fD4q4OiqSq2/CyfsM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IkoUvMPmvG2ulyMJdZF/8n7L9xtsheSOk26ur4o13s5Qxc/yiGWd9pHF8+Ubvuq0N0Kdxos8pG1v0vvcoaTLZBvbu/2gWDF1PvoAkCqKVLNmi8zb9nB1EhL14F9YA+HhOdHf9bWlTJSR1agv6CIVQ160LHdePVP+gL1XD2Q8MvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XEUnXW2e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SAYH0vgt; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XEUnXW2e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SAYH0vgt"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 9CA1313803EE;
	Fri, 20 Jun 2025 10:19:43 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Fri, 20 Jun 2025 10:19:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1750429183; x=1750515583; bh=JRlG6A2kK6
	lllGYCSqj1wcV/vBtmtHKmvH84Tx17wR8=; b=XEUnXW2eOG6ROclGTG1cOHOXAA
	9bH6Eb07rOl/s7x0CZ74dCwPLrmQs2k1f+rYlo2V/SCFIem0qoN5JRYc7Ps3R4F4
	GC0/jV2u/4ZU4tkc2CLPVghzEkTlAVI/6I8o3mjFMmoZyilCUmnNO0EgNrmEMTB9
	c80oN3oibWxdHyT0b1B9/W1Akpo+N3bKjLseEmmcc+R2682NPaEpbC+Xc5MNnagK
	JvkhItkhzQudVpzBtzFOO3JHRHxGgnXTcjZB8wEcq08Hv57QgoRbQIe6j2slLE7B
	uCU57kgD+tRh/OyqEdp5Kls2wylOj8EHPBH0JgyzBv+eAKhkE5oU6LJRdE3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1750429183; x=1750515583; bh=JRlG6A2kK6lllGYCSqj1wcV/vBtmtHKmvH8
	4Tx17wR8=; b=SAYH0vgtzhultJskVcyEFwhjFatNW8oX5TxykFxsulQNjNUwsAL
	wjKTAF6HpC+hPf0UQVFsQkLaM90QRcAUADqJWJOzVBm5/iFwqDfd1l8UkV9zEFcf
	ey1xrT1P9/dVs7PKzFzcSz7GrWdSYQxXB0or/s7vgijRDFDkOoyV2U/Q3KQP+NPA
	cD0c9HQd4TwyE9pow25hCbvG23ey8ofoZaZp7dvX5JYFynWpgQlWpZRdk/CVU95L
	W0/rHlBfhqBIUAFU8Pd2Wy4f2Y1bUXnXXFhus4j5V6J+4YQLd7y5tuGh6p9W/Ra1
	yRzR7JAZ6F4JAbtPMLGHM/EJ4Zgph1E9rgw==
X-ME-Sender: <xms:_21VaIB419z_g6-cBkg59gV0Am9355htvdBgwai7vT9ABVkfCNRnuQ>
    <xme:_21VaKhq9_sTrWZKCyjyNetqTBmKkEb2J-P4LVvvsbAEFmMc3QstJPbRnRd2O2pKc
    6TbFUjFKoSTRKiZ1g>
X-ME-Received: <xmr:_21VaLmxa4ySoTw4Lt19BC6wLuAl2-ydbuvx6q3dGoCHp7Lma0XjOcuosNnVbHAnvnRtdQA4xYkz8iDlKBV1YY87fATJlHlQgs00>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdekiedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnheptedttdevffeuieeilefffedtiefgfeekveetveevuedtlefhtddugfeltdejledu
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhn
    sggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsrghnug
    grlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:_21VaOxN9hQOddhI_MuX1C5q1vuPgk3yjSB-dAWR5dA-a0dzMjZ8RA>
    <xmx:_21VaNT5tPAsSx7fQnjQJ6S5fYXv24YInM33nZjbpDuVeR-MidQNWw>
    <xmx:_21VaJZz2b0qdb_8QMMSyx3-sJab7KqP4VicPNp3LXMA7dek7zmLmQ>
    <xmx:_21VaGSMVEiAGmd26-xuYjUwY5xPlVxBZ1TvvxKfb7g3M1OCczkuEw>
    <xmx:_21VaOdlhD8ml3aBzjH408u1f4nWTpwWCqg57etQD4eH_zHd10ViSJtE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Jun 2025 10:19:42 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 03/10] builtin: use default hash when outside a repository
In-Reply-To: <20250620011943.586596-4-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Fri, 20 Jun 2025 01:19:35 +0000")
References: <20250620011943.586596-1-sandals@crustytoothpaste.net>
	<20250620011943.586596-4-sandals@crustytoothpaste.net>
Date: Fri, 20 Jun 2025 07:19:41 -0700
Message-ID: <xmqqikkq7awy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> We have some commands that can operate inside or outside a repository.
> If we're operating outside a repository, we clearly cannot use the
> repository's hash algorithm as a default since it doesn't exist, so
> instead, let's pick the default instead of specifically SHA-1.  Right
> now this results in no functional change since the default is SHA-1, but
> that may change in the future.

Nicely explained and this step shows why having GIT_HASH_DEFAULT
makes sense very well.

>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  builtin/apply.c       | 2 +-
>  builtin/diff.c        | 2 +-
>  builtin/hash-object.c | 2 +-
>  builtin/index-pack.c  | 2 +-
>  builtin/ls-remote.c   | 2 +-
>  builtin/patch-id.c    | 2 +-
>  builtin/shortlog.c    | 2 +-
>  builtin/show-index.c  | 2 +-
>  8 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/builtin/apply.c b/builtin/apply.c
> index a1e20c593d..d642a40251 100644
> --- a/builtin/apply.c
> +++ b/builtin/apply.c
> @@ -29,7 +29,7 @@ int cmd_apply(int argc,
>  	 * cf. https://lore.kernel.org/git/xmqqcypfcmn4.fsf@gitster.g/
>  	 */
>  	if (!the_hash_algo)
> -		repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
> +		repo_set_hash_algo(the_repository, GIT_HASH_DEFAULT);
>  
>  	argc = apply_parse_options(argc, argv,
>  				   &state, &force_apply, &options,
> diff --git a/builtin/diff.c b/builtin/diff.c
> index c6231edce4..eebffe36cc 100644
> --- a/builtin/diff.c
> +++ b/builtin/diff.c
> @@ -483,7 +483,7 @@ int cmd_diff(int argc,
>  	 * configurable via a command line option.
>  	 */
>  	if (nongit)
> -		repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
> +		repo_set_hash_algo(the_repository, GIT_HASH_DEFAULT);
>  
>  	init_diff_ui_defaults();
>  	git_config(git_diff_ui_config, NULL);
> diff --git a/builtin/hash-object.c b/builtin/hash-object.c
> index 6a99ec250d..213a302e05 100644
> --- a/builtin/hash-object.c
> +++ b/builtin/hash-object.c
> @@ -104,7 +104,7 @@ int cmd_hash_object(int argc,
>  		prefix = setup_git_directory_gently(&nongit);
>  
>  	if (nongit && !the_hash_algo)
> -		repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
> +		repo_set_hash_algo(the_repository, GIT_HASH_DEFAULT);
>  
>  	if (vpath && prefix) {
>  		vpath_free = prefix_filename(prefix, vpath);
> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> index bb7925bd29..352ce7f88a 100644
> --- a/builtin/index-pack.c
> +++ b/builtin/index-pack.c
> @@ -2034,7 +2034,7 @@ int cmd_index_pack(int argc,
>  	 * choice but to guess the object hash.
>  	 */
>  	if (!the_repository->hash_algo)
> -		repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
> +		repo_set_hash_algo(the_repository, GIT_HASH_DEFAULT);
>  
>  	opts.flags &= ~(WRITE_REV | WRITE_REV_VERIFY);
>  	if (rev_index) {
> diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
> index 01a4d4daa1..df09000b30 100644
> --- a/builtin/ls-remote.c
> +++ b/builtin/ls-remote.c
> @@ -112,7 +112,7 @@ int cmd_ls_remote(int argc,
>  	 * depending on what object hash the remote uses.
>  	 */
>  	if (!the_repository->hash_algo)
> -		repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
> +		repo_set_hash_algo(the_repository, GIT_HASH_DEFAULT);
>  
>  	packet_trace_identity("ls-remote");
>  
> diff --git a/builtin/patch-id.c b/builtin/patch-id.c
> index cdef2ec10a..26f04b0335 100644
> --- a/builtin/patch-id.c
> +++ b/builtin/patch-id.c
> @@ -254,7 +254,7 @@ int cmd_patch_id(int argc,
>  	 * the code that computes patch IDs to always use SHA1.
>  	 */
>  	if (!the_hash_algo)
> -		repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
> +		repo_set_hash_algo(the_repository, GIT_HASH_DEFAULT);
>  
>  	generate_id_list(opts ? opts > 1 : config.stable,
>  			 opts ? opts == 3 : config.verbatim);
> diff --git a/builtin/shortlog.c b/builtin/shortlog.c
> index fe15e11497..60adc5e7a5 100644
> --- a/builtin/shortlog.c
> +++ b/builtin/shortlog.c
> @@ -419,7 +419,7 @@ int cmd_shortlog(int argc,
>  	 * git/nongit so that we do not have to do this.
>  	 */
>  	if (nongit && !the_hash_algo)
> -		repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
> +		repo_set_hash_algo(the_repository, GIT_HASH_DEFAULT);
>  
>  	git_config(git_default_config, NULL);
>  	shortlog_init(&log);
> diff --git a/builtin/show-index.c b/builtin/show-index.c
> index 9d4ecf5e7b..2c3e2940ce 100644
> --- a/builtin/show-index.c
> +++ b/builtin/show-index.c
> @@ -47,7 +47,7 @@ int cmd_show_index(int argc,
>  	 *       the index file passed in and use that instead.
>  	 */
>  	if (!the_hash_algo)
> -		repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
> +		repo_set_hash_algo(the_repository, GIT_HASH_DEFAULT);
>  
>  	hashsz = the_hash_algo->rawsz;
>  
