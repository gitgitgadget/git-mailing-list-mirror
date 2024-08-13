Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326DB18F2D4
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 07:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723533481; cv=none; b=nsl5hyLPcb5XtZ0PKcezQOV8vuDVosa1iiEb2fsFAxW59yCMB/Ba0i+7Mw+0zcSQZk1rcf8U/osNvNf6P8vjNPpALYhqPlbZ4OhnLbXp1Sm953vIVspYwuiqN6CItuuTR/0i77dtpRNNkWSZjnCAa1iFYruaujIekfRCnUUBsiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723533481; c=relaxed/simple;
	bh=KSWsfajIcUFRTvw5OXCvMJXWv8lmrp53J2EwVytGMyI=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SwJupUs4UNHUXpuCyxu3Va2tjstRJxzjKfXTlZkINZDS4Xl/cmw4YjKuqu8fxqgQ/af9IYGP48H+Ol+0HEn+CWw0/ZFWUBawNIUdYF4V82V7WIdOutsZV7rhc9AB0OvTHRlx684l150hSWl+TZ2sGM133Y7jDyzMq3HhSrdJguQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nCIu4jeA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NLM8GqLC; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nCIu4jeA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NLM8GqLC"
Received: from phl-compute-08.internal (phl-compute-08.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 4368F1151AFF
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 03:17:59 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Tue, 13 Aug 2024 03:17:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723533479; x=1723619879; bh=KgsNH8wJ5B
	XMfgoqLPY8FcTf3d+ImoI1XBkyOliaKJQ=; b=nCIu4jeAyuY4vCSJIxVbA880zg
	m5KmYjqyijYXson8gv5K80sy/InQE5lYT8zIE1fmjeHlCkkS1mqPM8I+dlU6KMPb
	o/h0l+C9pecPkIaah3SzJ1pi6XPOvjrPcFC4I50E0vQDNNLlfHiChylXCvyu+iAx
	OTH70SmOutM9sJQimQBmUabwy9UjASk4ms0J22Y8+MYCe7xdIex9pog3BZjOoYYj
	rroBIVukltJBZovsIAJzzgo+t+nNaKjbknnJ8iZV8burdk3Mh2b9naEJhTZ3ovFl
	rWG1Jgyh0OzYcptvKyjHsQKnfN8ljxUjrdOXaHYqU9u5kwLle7DHurdJBaxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723533479; x=1723619879; bh=KgsNH8wJ5BXMfgoqLPY8FcTf3d+I
	moI1XBkyOliaKJQ=; b=NLM8GqLC0UG8aKos+jhPDVylTFG8QYk6PV4CiRgYTohL
	MFUfJg7OcSDZhmfzYcBGeQQK/pcw1G9WYzaJswqNJnCFcZXAS9w9M4goefkG/yvt
	p8Cav5wYzVdtlI5Uzom0zSU4ZaFRVKJRASRFpkw5upXhNo7tN6XJjNVF7M1xAwZb
	kZtrfqSBuXsbzgj5uv4JbNa2NS/9FoFY7psIGDg3awv/AR3CacXaR6Edqgx2pRzJ
	GkASGKqBQWnngdA85ZTTJ5cEE6HsT+GhZlkeOKI2m0HEk2byGT3m1bOhDh352G36
	WLEb1J3WP7dC0Liq1MKKoH3MvfWhB1Hx8YYXxEJr+Q==
X-ME-Sender: <xms:pwi7ZuIfjEGY71eu540FT4rwQb9SnwDSlnrrkOJGkJnzc1JeHz-FOw>
    <xme:pwi7ZmK7nHXrHJtWq_wWudhxktiaVwRi6yZXs_aQrSXuyqcWAa1rfwNj4xsxZjv4f
    xA9_TzRPELeI33fYw>
X-ME-Received: <xmr:pwi7ZusszpWknByrk-y6e2tXjPXZLl4aI4M50zo7OpSHZepqU3yZEptu2e-vx975JmfhyutA1q3TRWNvhAQJ-wDsknSOyX9zo1PnnbTQZMhqLg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtuddguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeffuedvgeeuie
    fhkefgieefueffhfegkeevhefhtdfgteeuteevudegffehveevfeenucffohhmrghinhep
    lhhoohhsvgdqohgsjhgvtghtshdrrghuthhonecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohep
    uddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrgh
X-ME-Proxy: <xmx:pwi7Zjauq3wlo4817OGFbeCaOzrQKIT4bQpuQLX3C5IUWrCixg_cYg>
    <xmx:pwi7ZlZ1qf2mRcP2ffJgOJkBDsjSM6bk6pQhAiLQr5om5Cwse1Ptmw>
    <xmx:pwi7ZvDVwICy0CbtNyKXiJLX4VrpP5UQJa4MTWFHiMb4sDmknjeWDg>
    <xmx:pwi7ZrZILt5S902lFHQVeU9_pW68auAdvwq8g_wjTyNgHgBIDR2HmQ>
    <xmx:pwi7ZkwKeoYctB_dZESb_wWgg0jd02JQTZRSjdF4pzcXWP3lBR_ZT89r>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 13 Aug 2024 03:17:58 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8c4b2b0b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 13 Aug 2024 07:17:42 +0000 (UTC)
Date: Tue, 13 Aug 2024 09:17:57 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 6/7] builtin/maintenance: add a `--detach` flag
Message-ID: <06dbb73425f7df038dfdd9bc0d2b9a49edfe064e.1723533091.git.ps@pks.im>
References: <cover.1723533091.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723533091.git.ps@pks.im>

Same as the preceding commit, add a `--[no-]detach` flag to the
git-maintenance(1) command. This will be used in a subsequent commit to
fix backgrounding of that command when configured with a non-standard
set of tasks.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/gc.c           |  6 ++++++
 t/t7900-maintenance.sh | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/builtin/gc.c b/builtin/gc.c
index 269a77960f..63106e2028 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1426,6 +1426,10 @@ static int maintenance_run_tasks(struct maintenance_run_opts *opts,
 	}
 	free(lock_path);
 
+	/* Failure to daemonize is ok, we'll continue in foreground. */
+	if (opts->detach > 0)
+		daemonize();
+
 	for (i = 0; !found_selected && i < TASK__COUNT; i++)
 		found_selected = tasks[i].selected_order >= 0;
 
@@ -1552,6 +1556,8 @@ static int maintenance_run(int argc, const char **argv, const char *prefix)
 	struct option builtin_maintenance_run_options[] = {
 		OPT_BOOL(0, "auto", &opts.auto_flag,
 			 N_("run tasks based on the state of the repository")),
+		OPT_BOOL(0, "detach", &opts.detach,
+			 N_("perform maintenance in the background")),
 		OPT_CALLBACK(0, "schedule", &opts.schedule, N_("frequency"),
 			     N_("run tasks based on frequency"),
 			     maintenance_opt_schedule),
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 8595489ceb..771525aa4b 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -908,4 +908,43 @@ test_expect_success 'failed schedule prevents config change' '
 	done
 '
 
+test_expect_success '--no-detach causes maintenance to not run in background' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+
+		# Prepare the repository such that git-maintenance(1) ends up
+		# outputting something.
+		test_commit something &&
+		git config set maintenance.gc.enabled false &&
+		git config set maintenance.loose-objects.enabled true &&
+		git config set maintenance.loose-objects.auto 1 &&
+		git config set maintenance.incremental-repack.enabled true &&
+
+		# We have no better way to check whether or not the task ran in
+		# the background than to verify whether it output anything. The
+		# next testcase checks the reverse, making this somewhat safer.
+		git maintenance run --no-detach >out 2>&1 &&
+		test_line_count = 1 out
+	)
+'
+
+test_expect_success '--detach causes maintenance to run in background' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+
+		test_commit something &&
+		git config set maintenance.gc.enabled false &&
+		git config set maintenance.loose-objects.enabled true &&
+		git config set maintenance.loose-objects.auto 1 &&
+		git config set maintenance.incremental-repack.enabled true &&
+
+		git maintenance run --detach >out 2>&1 &&
+		test_must_be_empty out
+	)
+'
+
 test_done
-- 
2.46.0.46.g406f326d27.dirty

