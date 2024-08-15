Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7121198E78
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 08:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723708808; cv=none; b=JJEbfuKtY5FHi9l1rMk2KxqR7CO1FKrLDcsk4A5Us5xlm64BPO1nsMb5j55CmHFVKOJLC4n69j2aAOlBhXdUSlWPddNlOlSoY4iM7+ebcHv4v1m1yfyhm5uGYXwVNK9NskpGzn0cCX2FPGMDZJgVXhtAm/7M4w31REGWiTizqKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723708808; c=relaxed/simple;
	bh=HeduqKlyUIKFPDoQ8QA3Jph3jSzrJp6YcurxKNYy2OI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iwxJW5vZFKS528MHKBXhoY3sjdEZVMN2G5mcPSviSjCXJx1LwuzgUFV994iYS/IcQOhGr/FgsakwLt/BnbzAhWJoPqA7DUEFjaW3GqqEjJpSrAVMegZcJHkb6NlboNCJqUkMalEFpFJ0W8e8SOx2qAbzRG59uwKICMaUH5dcbiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RPDQakXd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MOV+qnTr; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RPDQakXd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MOV+qnTr"
Received: from phl-compute-06.internal (phl-compute-06.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id BE9531151D14;
	Thu, 15 Aug 2024 04:00:05 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 15 Aug 2024 04:00:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723708805; x=1723795205; bh=3wbx7NAwlx
	Czy0OTfl0tDedytPb7CUdUJ6W28XxBQgo=; b=RPDQakXdE7nISPeNfjAXnfshBu
	Qcg5QLVPjGwETyL487IW4BoCdpjHGULR3I9Co4hCjd6l3yGGS8F+sOENPKZJfyZU
	QLSqIagKxMNFlZF9EQ13hPR4QzdM4A0INEGBxf9cxQfVv6DNfsL/f3qS0HJBEIqr
	PPuosFYOzhMUmde5r9l8S5vuZqZ3hUclv+SdVRbaKH/CY37bpDa6Y7Gu7ygAUBuV
	w4HGwuJWIyWaqDQAQpoiY77DDRlGj6nf8f6wR6egIlZuerztEUm4j+SXHCRHlDp6
	9yKNL5vD777wuZZjXc0cAfEDFFqqWstG8M3Z+EJvMqk4i+bx4jacCYe25NmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723708805; x=1723795205; bh=3wbx7NAwlxCzy0OTfl0tDedytPb7
	CUdUJ6W28XxBQgo=; b=MOV+qnTrSzScwMw4nvflt8+SjbXh0/7exz/1fSl2vLhI
	aDbaQoMqHNpzy/sykOAFKAh1pUuwrnlY5UokA/rl/wMA+6Yn9/drqSiEs3VxUYaj
	6DD1jOEjHA9DLKDVlcVNpR/Q+Z0C2y+eKnfsnhiMmszxY5tIRGpE+XEqHnXqVGsN
	2m9TwYiVMKYUmHqY35yMhEesnrt933VoRHkCfygjv7vooJO6PFy2FTR/+kXPcwbK
	HA1qTtPVgF+0aVg4M52l7tCmuaGlX4qKtI1K+HQP4bQvpIBndOabmLDtx1g9ZGoM
	kLpaMdoeiRn6cArYeZG/DFMCQU7oClyFtjE97bORdA==
X-ME-Sender: <xms:hbW9ZlTfSs3rNrJicUknT0O2osXaHOtHwKECYB0e1fvOrGTRRgflGA>
    <xme:hbW9Zuyq7K5PE-5uQ1pbQqE3Oe9BL7jyYUMfirqqj6erpWhJSBFgsnLHPnDwnFLNf
    HPcbg-apXUZ8j4TSA>
X-ME-Received: <xmr:hbW9Zq0mRU060gNErsdxVjdf7oHRqYpYjf7yq9ukdBCe8jHpxYtgkJqyOgfKfoYFAPbsXsDq73JCChQnBWNBVhTlbb7e2oV6SQTay0OHFf8TIw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddthedguddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepshhstghhuhgsvghrthhhsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:hbW9ZtBRkPmCKAdconcvukoDZqHXrRiC5vYR04gd674pbKT6A7NE4Q>
    <xmx:hbW9Zuh59_M0bIXhqHNas9yZ1t6EwyFZHNS6vd2iFce9d5jlvZ0_jA>
    <xmx:hbW9Zhr0q0qroJQ4g8Ol4HhteYtQRfG1Yzn0iliDojrJIDq8U6Y08w>
    <xmx:hbW9ZpjcG0_uVs4-81L2uQKgX1PeuEBhs9wD7yFCgeMWKvwWetPRhQ>
    <xmx:hbW9Zhvc8Jqatqv7h-EwFZUHSBzoJNXUD4CThDZA5aVFtjsroEVmc_R7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Aug 2024 04:00:04 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6cf40be6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 15 Aug 2024 07:59:44 +0000 (UTC)
Date: Thu, 15 Aug 2024 10:00:03 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Sebastian Schuberth <sschuberth@gmail.com>
Subject: [PATCH 3/5] setup: merge configuration of repository formats
Message-ID: <16f52b75d8972343776adb269da305e7406ff385.1723708417.git.ps@pks.im>
References: <cover.1723708417.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723708417.git.ps@pks.im>

The configuration of repository formats is split up across two functions
`validate_hash_algorithm()` and `validate_ref_storage_format()`. This is
fine as-is, but we are about to extend the logic to also read default
values from the config. With the logic split across two functions, we
would either have to pass in additional parameters read from the config,
or read the config multiple times. Both of these options feel a bit
unwieldy.

Merge the code into a new a new function `repository_format_configure()`
that is responsible for configuring the whole repository's format. Like
this, we can easily read the config in a single place, only.

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

