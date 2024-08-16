Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74D0139579
	for <git@vger.kernel.org>; Fri, 16 Aug 2024 09:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723799175; cv=none; b=CdddvGq74YRBHB4qbHQpYFTkbiy9xRdo8JD2ZPHAIwi6SLJFDyxZS1Ij85ltpMpVhggoUGjMCKa4ZY7ui/duc8okHu6VKyQF+yRNlnfc17FQcfe9nwfx2rFq/FL06BWVZmWElyfza3j6sI1UXm17HXnGJKG7JhI/zFn70w3fAzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723799175; c=relaxed/simple;
	bh=BERRG9L3o+DkmkqkBYapbhoBSMonMkPYwTsIvB8ZNn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TxH5Mxk1+znxtT1ss7zZBerIoJV+ieX4cp5/VV1lJJ+R+m33M5BvOxAe61qZMkHGKGW4T6ROo2zY6oLlyZ+uaSs10pbKwKPDW/cmVZpE3Toa2gb5lLxGYmEelqDxWldHqOdzWu2a8p2WS8hU3mjLIvBu9jM3WZgySI1AUP3Y1dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=X+9wMx+g; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qva+K6C+; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="X+9wMx+g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qva+K6C+"
Received: from phl-compute-02.internal (phl-compute-02.nyi.internal [10.202.2.42])
	by mailfout.nyi.internal (Postfix) with ESMTP id 88844138FD03;
	Fri, 16 Aug 2024 04:57:01 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 16 Aug 2024 04:57:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723798621; x=1723885021; bh=O/dSDskehd
	U9PTFhzAP+imJaQ9KSgiFubE51dMB3BZQ=; b=X+9wMx+gNCO7gZsoPcOnjK/mf0
	Vgxg0q/8i/KCN//jTDjZJcEAac4HqB/znbQZTWVxgs338tPdI1E6Gjc4wg9nSFFb
	WbJfoDo+92TzmDzJji0oq6fke0rUN0xrI1j/XwcNcV1ff9YbrL5tdymWlZT8502q
	mvcxAy1iM33jbCsaNq+XYsPiQPK8mF9fI8IKdWqDpuKPuMBe7eJVOSdeam9jLXgz
	0fDZEpgGn0LCsCyQojyssqFoEX524ClMKILVWy6tLatn5IhjC/o/GxcMTU5eC2vH
	3hfySpoewTqJzX1+Qsai30lYWoUouSrhPKsxP/O0seGVeEKmgG/CbXzEhuzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723798621; x=1723885021; bh=O/dSDskehdU9PTFhzAP+imJaQ9KS
	giFubE51dMB3BZQ=; b=qva+K6C+0WmMhg7ouR7f3ylAAyo4yBYlohfwF6RnREMl
	kqHy3V2Syon9xFxElo1ncg1JmK9SUyT2S8gX3iLZXDFB10LiErzpMAFOywuZ3ERx
	7QRgV4wtCl1Tf8y+UUo3qhLWEq99k+QQO6sE8gk8nHYFW5tBlPYKoD3YR1oC9AZ+
	7doAp5tHkSy0Yo/Kxv7Tlq03VAx8MVB+eB0qs5v1UXmvuhvlvzGTMv7auNVfTJYI
	8AqzDUJMHur7tnE8dkFDs2o4ezGrdcy9fMujn7WYWTNQDr9n5rHXo5ER3hsD9GBD
	/wZamA6hWQKrZJFN5nltBZOX8xFO6CV2x8KcLsAPVw==
X-ME-Sender: <xms:XRS_Zp7raWtQyWd6OflxyEUZzS9kVgdnRba9-u1WemdxwAFlPBrfRA>
    <xme:XRS_Zm5iZ2c1LleAhWXJgxxtgp3Cpe2x18KXwPmXB-X_LRF75Ffqi-ewueOODiVH8
    F_p-yuJXXzKK6ANKA>
X-ME-Received: <xmr:XRS_ZgcVPALHi9sblVZc0tBq76FW7SvIy24Ahgkhgkh-tx9WGesihlnFAp6NEAskHqatS41sqo218eGwARcbdBDBn_PeFZ9UN4kf7VwXYNfKd2k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtkedgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehsrghnuggr
    lhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhstghhuhgsvghrthhhsehg
    mhgrihhlrdgtohhm
X-ME-Proxy: <xmx:XRS_ZiKq0KeiVP9dctG7YomEyOdlokhHETqMqmJRm8YqvycpugMxTw>
    <xmx:XRS_ZtLATnz2qJubCIwSpJC8jftnfy5hBzGJARDu3_pxzYIa5NNbFw>
    <xmx:XRS_ZrxhQw2TJ5nQv3elWjxB-N6PYow_U6FlyKHn_8ltmVPGHrKDWg>
    <xmx:XRS_ZpIWbcPU9DR0KLkObalVeQ_pGyB_grrBbiGWa-OUw407XvSgAA>
    <xmx:XRS_ZrihM0on72Ds7Pp5TSVCeG_2dLUHqsiO5eVA4mRb48JsWNJ16CLx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Aug 2024 04:57:00 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1f7800e5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 16 Aug 2024 08:56:37 +0000 (UTC)
Date: Fri, 16 Aug 2024 10:56:58 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Sebastian Schuberth <sschuberth@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/5] setup: merge configuration of repository formats
Message-ID: <ce0fad88bb819c1dfa206e7327522ce625c32e65.1723798388.git.ps@pks.im>
References: <cover.1723708417.git.ps@pks.im>
 <cover.1723798388.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723798388.git.ps@pks.im>

The configuration of repository formats is split up across two functions
`validate_hash_algorithm()` and `validate_ref_storage_format()`. This is
fine as-is, but we are about to extend the logic to also read default
values from the config. With the logic split across two functions, we
would either have to pass in additional parameters read from the config,
or read the config multiple times. Both of these options feel a bit
unwieldy.

Merge the code into a new function `repository_format_configure()` that
is responsible for configuring the whole repository's format. Like this,
we can easily read the config in a single place, only.

Furthermore, move the calls to `repo_set_ref_storage_format()` and
`repo_set_hash_algo()` into this new function as well, such that all the
logic to configure the repository format is self-contained here.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 setup.c | 47 ++++++++++++++++++++---------------------------
 1 file changed, 20 insertions(+), 27 deletions(-)

diff --git a/setup.c b/setup.c
index d458edcc02..5dfcdc99dd 100644
--- a/setup.c
+++ b/setup.c
@@ -2284,14 +2284,17 @@ static void separate_git_dir(const char *git_dir, const char *git_link)
 	write_file(git_link, "gitdir: %s", git_dir);
 }
 
-static void validate_hash_algorithm(struct repository_format *repo_fmt, int hash)
+static void repository_format_configure(struct repository_format *repo_fmt,
+					int hash, enum ref_storage_format ref_format)
 {
-	const char *env = getenv(GIT_DEFAULT_HASH_ENVIRONMENT);
+	const char *env;
+
 	/*
 	 * If we already have an initialized repo, don't allow the user to
 	 * specify a different algorithm, as that could cause corruption.
 	 * Otherwise, if the user has specified one on the command line, use it.
 	 */
+	env = getenv(GIT_DEFAULT_HASH_ENVIRONMENT);
 	if (repo_fmt->version >= 0 && hash != GIT_HASH_UNKNOWN && hash != repo_fmt->hash_algo)
 		die(_("attempt to reinitialize repository with different hash"));
 	else if (hash != GIT_HASH_UNKNOWN)
@@ -2302,25 +2305,22 @@ static void validate_hash_algorithm(struct repository_format *repo_fmt, int hash
 			die(_("unknown hash algorithm '%s'"), env);
 		repo_fmt->hash_algo = env_algo;
 	}
-}
-
-static void validate_ref_storage_format(struct repository_format *repo_fmt,
-					enum ref_storage_format format)
-{
-	const char *name = getenv("GIT_DEFAULT_REF_FORMAT");
+	repo_set_hash_algo(the_repository, repo_fmt->hash_algo);
 
+	env = getenv("GIT_DEFAULT_REF_FORMAT");
 	if (repo_fmt->version >= 0 &&
-	    format != REF_STORAGE_FORMAT_UNKNOWN &&
-	    format != repo_fmt->ref_storage_format) {
+	    ref_format != REF_STORAGE_FORMAT_UNKNOWN &&
+	    ref_format != repo_fmt->ref_storage_format) {
 		die(_("attempt to reinitialize repository with different reference storage format"));
-	} else if (format != REF_STORAGE_FORMAT_UNKNOWN) {
-		repo_fmt->ref_storage_format = format;
-	} else if (name) {
-		format = ref_storage_format_by_name(name);
-		if (format == REF_STORAGE_FORMAT_UNKNOWN)
-			die(_("unknown ref storage format '%s'"), name);
-		repo_fmt->ref_storage_format = format;
+	} else if (ref_format != REF_STORAGE_FORMAT_UNKNOWN) {
+		repo_fmt->ref_storage_format = ref_format;
+	} else if (env) {
+		ref_format = ref_storage_format_by_name(env);
+		if (ref_format == REF_STORAGE_FORMAT_UNKNOWN)
+			die(_("unknown ref storage format '%s'"), env);
+		repo_fmt->ref_storage_format = ref_format;
 	}
+	repo_set_ref_storage_format(the_repository, repo_fmt->ref_storage_format);
 }
 
 int init_db(const char *git_dir, const char *real_git_dir,
@@ -2353,22 +2353,15 @@ int init_db(const char *git_dir, const char *real_git_dir,
 	}
 	startup_info->have_repository = 1;
 
-	/* Check to see if the repository version is right.
+	/*
+	 * Check to see if the repository version is right.
 	 * Note that a newly created repository does not have
 	 * config file, so this will not fail.  What we are catching
 	 * is an attempt to reinitialize new repository with an old tool.
 	 */
 	check_repository_format(&repo_fmt);
 
-	validate_hash_algorithm(&repo_fmt, hash);
-	validate_ref_storage_format(&repo_fmt, ref_storage_format);
-
-	/*
-	 * Now that we have set up both the hash algorithm and the ref storage
-	 * format we can update the repository's settings accordingly.
-	 */
-	repo_set_hash_algo(the_repository, repo_fmt.hash_algo);
-	repo_set_ref_storage_format(the_repository, repo_fmt.ref_storage_format);
+	repository_format_configure(&repo_fmt, hash, ref_storage_format);
 
 	/*
 	 * Ensure `core.hidedotfiles` is processed. This must happen after we
-- 
2.46.0.46.g406f326d27.dirty

