Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4915B23185E
	for <git@vger.kernel.org>; Mon, 27 Oct 2025 08:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761553872; cv=none; b=ZiJRwbnSX4S8wrDgsZkuQpF5RSj8C6bqjXRFKfdxF1MaF8AySoE1eHaSZIyZCFQPBTUk6xbQo7mcNOrYGz7hUrmg6fmAcp06lh96zFVonRv7Rh7P+B4qYSTdWGsBpxtOlUzSQXQnckoDOkd5N/1rewwgyKuNu5uXfat6/Pjx5Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761553872; c=relaxed/simple;
	bh=tPWltyYhEhLgtO6v3rdhHXvl8iXJ2GLy0qnCQff/iC4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DP76hLmGZMzCsqgdrjWONoJqtrb8wOLcm6WIOG7xVhFt4nW0KUy8yQH6nHltYgtxYL5jo5XAsnGxiKK8rt74gDKOSPFmXkYSh3o+Yk3zSffB3dm/u4eFoKFqI/chJVDsfxvNW3w3Sc+8lVlepnfML1ck1BQdWoPb60RQr4AiRD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Tos9uXKi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tloDfiSi; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Tos9uXKi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tloDfiSi"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7838414001CD;
	Mon, 27 Oct 2025 04:31:09 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 27 Oct 2025 04:31:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1761553869;
	 x=1761640269; bh=hppa8lVhucS+ezYPZGQ3T4A7GL8uQJM8YLKwYmdUGhM=; b=
	Tos9uXKiKVo19e1QXoqJVaMDoJNqGkbbEGlW442DIylBdWMp4PP2ggoLTQ6uNnMC
	0Xm5rGsgo/DuPDPhZB8u5ucIiRM1gVpHEjXG9Qi7eDQRJBLTmep8tYBLZ2me/nBx
	JugBhhxrQGdHuz6ch5XKlW3GND8LDwYVVx+GuG9hJra7/lLhL1pReX+x6p8wSHV3
	Xj8LPe63mcIC1BxbYhkjZptulVpZNtiBoHtG42svbc+fbzMNugYEU56sufcYnI4f
	R93MOBC1XGQiOV1vEHBHeLHE2GKLzuWurHgipe5abT0rJNVX80K75+lPkEOsgSFM
	1NSE1aVIqTieXdC+aJR3oA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761553869; x=
	1761640269; bh=hppa8lVhucS+ezYPZGQ3T4A7GL8uQJM8YLKwYmdUGhM=; b=t
	loDfiSi/slK8Ow9HcQoasdVGiAReKkSMhAESXNluB9Neu1kQ16BnHZ3zRPA8vUts
	2tgCVwSrF8nerCu9VWYW4oDGqKoUdpb+nRtf7/r0iefaCdSKMNfRcYWJafRkOGdZ
	9fAP/ArD+vmkQKbxIRkOWtpnLC7JW8LIqwFw2NbajAoC9fYq2XIqer8bCdjvCta2
	fmWM40VP+x7Z3TyO0cSkw8TCfheEr0J0DiurJMDxkT4RIKrveKkjsmnkZ4lDX//C
	CLIm6qio1K8/7exWT9PxY+BLOI+9RrkvYQJNRQndqZCRRZyKFIXGP3DYpTYytKig
	914FWVkkklF3B9SWwfO4Q==
X-ME-Sender: <xms:zS3_aLdcPmx0XM9mMalCsoLvZsm3tZULzjQUrpXE4te-6pkQNkylRw>
    <xme:zS3_aIHKumN9uxPFyeQSzTA3PnMMP5m5mTGFv6WsAnA9Lx6DheJ-TIuHeDs7O5-id
    pF7SrRVhAjWXDPXrG6XDzhBy90CHr_Wvh5ViG78KhsZrJ6WUreaAQ>
X-ME-Received: <xmr:zS3_aM2xdngoxzI2mxkPNvflah5JJoiZT4XFZOmSL54nkzOBJWgdzmjOq-poUW3obXSLUQa3QtO4Z_Ks0h0UV4sN-j5uTJX7HfR-IlbQGw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheejhedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeekveejhffhjeevjeefjeegtdejffeltefgjefgfffhueeuueeivefgudefiedthfen
    ucffohhmrghinhepghgvohhmvghtrhhitgdqrhgvphgrtghkrdgruhhtohdprhgvfhhloh
    hgqdgvgihpihhrvgdrrghuthhonecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgt
    phhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomhdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:zS3_aIkM5SK8WuTyYFKzn3tD9nt8Psr_AzAtsLT4uvhqHQ7zTPrMVg>
    <xmx:zS3_aE8pKzbckic81kHR9FZQpHZ3_myT6X99elqfJmuMkCauYjjLtA>
    <xmx:zS3_aFrqTXI1bey7JUQ7vpn50Zl3KTRRJLg7pdLfTecFwEGM8FUmUw>
    <xmx:zS3_aFns6hjG4sUfKx_jyoQWMgMfP9UZEdvUO8f9UC3U1VL0AdBYfA>
    <xmx:zS3_aC8sdk9X6wZIg8JmgPJSzMNTf-zPo7p3B--flxHsC8wIb-5UKFgI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Oct 2025 04:31:08 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id df27d32a (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 27 Oct 2025 08:31:08 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 27 Oct 2025 09:30:54 +0100
Subject: [PATCH v4 04/10] builtin/maintenance: make the geometric factor
 configurable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251027-pks-maintenance-geometric-strategy-v4-4-18049e4a0adf@pks.im>
References: <20251027-pks-maintenance-geometric-strategy-v4-0-18049e4a0adf@pks.im>
In-Reply-To: <20251027-pks-maintenance-geometric-strategy-v4-0-18049e4a0adf@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Taylor Blau <me@ttaylorr.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.3

The geometric repacking task uses a factor of two for its geometric
sequence, meaning that each next pack must contain at least twice as
many objects as the next-smaller one. In some cases it may be helpful to
configure this factor though to reduce the number of packfile merges
even further, e.g. in very big repositories. But while git-repack(1)
itself supports doing this, the maintenance task does not give us a way
to tune it.

Introduce a new "maintenance.geometric-repack.splitFactor" configuration
to plug this gap.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/config/maintenance.adoc |  5 +++++
 builtin/gc.c                          |  9 ++++++++-
 t/t7900-maintenance.sh                | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/maintenance.adoc b/Documentation/config/maintenance.adoc
index 26dc5de423f..45fdafc2c63 100644
--- a/Documentation/config/maintenance.adoc
+++ b/Documentation/config/maintenance.adoc
@@ -86,6 +86,11 @@ maintenance.geometric-repack.auto::
 	objects that would be written into a new packfile. The default value is
 	100.
 
+maintenance.geometric-repack.splitFactor::
+	This integer config option controls the factor used for the geometric
+	sequence. See the `--geometric=` option in linkgit:git-repack[1] for
+	more details. Defaults to `2`.
+
 maintenance.reflog-expire.auto::
 	This integer config option controls how often the `reflog-expire` task
 	should be run as part of `git maintenance run --auto`. If zero, then
diff --git a/builtin/gc.c b/builtin/gc.c
index 2c9ecd464d2..fb1a82e0304 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1582,6 +1582,9 @@ static int maintenance_task_geometric_repack(struct maintenance_run_opts *opts,
 	struct child_process child = CHILD_PROCESS_INIT;
 	int ret;
 
+	repo_config_get_int(the_repository, "maintenance.geometric-repack.splitFactor",
+			    &geometry.split_factor);
+
 	existing_packs.repo = the_repository;
 	existing_packs_collect(&existing_packs, &kept_packs);
 	pack_geometry_init(&geometry, &existing_packs, &po_args);
@@ -1591,7 +1594,8 @@ static int maintenance_task_geometric_repack(struct maintenance_run_opts *opts,
 
 	strvec_pushl(&child.args, "repack", "-d", "-l", NULL);
 	if (geometry.split < geometry.pack_nr)
-		strvec_push(&child.args, "--geometric=2");
+		strvec_pushf(&child.args, "--geometric=%d",
+			     geometry.split_factor);
 	else
 		add_repack_all_option(cfg, NULL, &child.args);
 	if (opts->quiet)
@@ -1632,6 +1636,9 @@ static int geometric_repack_auto_condition(struct gc_config *cfg UNUSED)
 	if (auto_value < 0)
 		return 1;
 
+	repo_config_get_int(the_repository, "maintenance.geometric-repack.splitFactor",
+			    &geometry.split_factor);
+
 	existing_packs.repo = the_repository;
 	existing_packs_collect(&existing_packs, &kept_packs);
 	pack_geometry_init(&geometry, &existing_packs, &po_args);
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 842829879d8..8fda6b1a6f7 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -603,6 +603,38 @@ test_expect_success 'geometric repacking with --auto' '
 	)
 '
 
+test_expect_success 'geometric repacking honors configured split factor' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		git config set maintenance.auto false &&
+
+		# Create three different packs with 9, 2 and 1 object, respectively.
+		# This is done so that only a subset of packs would be merged
+		# together so that we can verify that `git repack` receives the
+		# correct geometric factor.
+		for i in $(test_seq 9)
+		do
+			echo first-$i | git hash-object -w --stdin -t blob || return 1
+		done &&
+		git repack --geometric=2 -d &&
+
+		for i in $(test_seq 2)
+		do
+			echo second-$i | git hash-object -w --stdin -t blob || return 1
+		done &&
+		git repack --geometric=2 -d &&
+
+		echo third | git hash-object -w --stdin -t blob &&
+		git repack --geometric=2 -d &&
+
+		test_geometric_repack_needed false splitFactor=2 &&
+		test_geometric_repack_needed true splitFactor=3 &&
+		test_subcommand git repack -d -l --geometric=3 --quiet --write-midx <trace2.txt
+	)
+'
+
 test_expect_success 'pack-refs task' '
 	for n in $(test_seq 1 5)
 	do

-- 
2.51.1.930.gacf6e81ea2.dirty

