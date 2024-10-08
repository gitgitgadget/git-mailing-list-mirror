Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1301E485
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 12:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728389759; cv=none; b=KKdlwsPpujWveJqRuCZT/kX1kNaK0eBvTt1FFKYp6vxTvpzAGz39ydnz32kt0R/9jukw8TsTawMTTU3MsDhseSzwKgd6GIekIxNYZWK8N345C+Ca9KYPE9px4vH7zaDn3IX6diEwQCVEJQLj9/8HQGQpRQ9cyr6CaJBxKcrkQqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728389759; c=relaxed/simple;
	bh=fU6mPHrjx0ag+yEHfBlyiTYHmXEx5lbBEVcF2PZOOgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RoqSoUzuyRbGYaRTGWtgz38Qya3v8FM6OAEtKMEtWMPtI/Mi0zuIOf1JGpn2aQ6k3nk2LpIfEhQMepmaNVIkBc1ixAg7RqOC4G27KMNbnhz0Kw0Gn9R7kVqXlDM91PunOaWsE3gBXHqQ4g3aRGzsP2c/CDTg7pETgtacFgMp4Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=C0Ogk4CN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MWh4NYzx; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="C0Ogk4CN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MWh4NYzx"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 8B0C313806F7;
	Tue,  8 Oct 2024 08:15:56 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Tue, 08 Oct 2024 08:15:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1728389756;
	 x=1728476156; bh=pgm+4PTl1oqzh+qy53/PXfG5bIjPOqCWAtYWARbcG1c=; b=
	C0Ogk4CNo/ODRZwdVgjViEuOr3B68hKkDagHxzEbD4hiRRyvczzRoKOIu+11SeMJ
	Wu1jhRJu4ZSoifv5qQIhmYCctAsRtw5bUt9ce50auH1ykXrRNKRytw7oDiRrK7qK
	SG4XjnUzCoy15vDXcKMXzSwEMNZMCMIVnKxNdKJATI5bYRptveXYMuXmWIZ8b3is
	OyUk1pJFvpIZ5xaHd7AQA6G2fbJpT2qQFh1PXAp7V5MX5/yOlILFOA3o+aUnGOA0
	fUiIiwzDvrgZacVdg53gSPiOUW8NOM+rqiP/iUjvYUJt3uuu1ztXyJcZ1zLjluRK
	pGCWMmaQb8RjLauZr3pZgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728389756; x=
	1728476156; bh=pgm+4PTl1oqzh+qy53/PXfG5bIjPOqCWAtYWARbcG1c=; b=M
	Wh4NYzxmc/fyKjtDW8ZW3jf8AUv2ape2vHsRcHcKT4oBV4xPGmZBU1uEwQjUBkzX
	iMWK4cbqeEAUjy2bubqPKPx4G1Jm0BRpD5acnRhG3mPzsyy6PEjIWOaqalUPlItA
	nfu4+N7Rv6esGXL3OIOs0WYAnFmDqeNegZFUctu2AIApnzeaK7kYvJ83eArfugR+
	QRo8ne1kroxjUzqIRtmSTVpXCEeYYSySdWVzvFQGm55IF8Zh+2VwGcZcLjVgXCMl
	XE4R8W2If4/si/HRLkJEQyn4ReVlTKhMLIr2/a3ggWhRR9Pcr4BBFVopnWRbU2MX
	VMU/Yc8S/LvQuPixAFXyg==
X-ME-Sender: <xms:fCIFZxAsEjL9tljJbG6lD4ozStEy2SUyEt_l5c4taYDbuFESKai3Gg>
    <xme:fCIFZ_g-CWzB_skqYSIYoA2NrR2MSSguah_XzwyI19ALJT6TGQK9HKwfvOqdJ3f8Z
    SW6w5uz-F29VRVqWg>
X-ME-Received: <xmr:fCIFZ8n3gmI3D7R-ltsuhakeSITiCQg_QTEwRiMeje09ON4ndTSvxmbuG_ZQq-4LR1mpGx0-DZW3ZC0SCvWrRluvK70BAYH6YjV8qzYMEVnBijs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefuddggeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedvveet
    ffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehshhhusghhrghmrdhkrghnohguihgruddtsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:fCIFZ7yCkZwSbyGb4N3kXbboA_ilpS5cRo_1O77HvOjh3ZGqYbGWgw>
    <xmx:fCIFZ2RW_S4fk7Tf8SYC8wc9rxboUoYQGK7Xna_Gtiq-CD3qYOfQ2A>
    <xmx:fCIFZ-Y8knpyqvcsyJS1wMcnJy_m9w3vXHwH24Vb_drURNIs77xHfw>
    <xmx:fCIFZ3QjoJ2VsiMkM5-Vb5ahlpqCYsztpm2-OXso2C3K0oxbAQy4yQ>
    <xmx:fCIFZxdMj7wr18F4INnZ-EZcuuKLhuikVaEUWWQnHExxgWr0yBplZRBW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Oct 2024 08:15:55 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 864f72ca (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 8 Oct 2024 12:14:53 +0000 (UTC)
Date: Tue, 8 Oct 2024 14:15:53 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Shubham Kanodia <shubham.kanodia10@gmail.com>
Subject: [PATCH] builtin/gc: fix crash when running `git maintenance start`
Message-ID: <976c97081af7c62960bd71d1b70039657e7cb711.1728389731.git.ps@pks.im>
References: <CAG=Um+0mJW-oAH+YLC3dWEU64JwS-zMkkTiFWYBe4g6HMbe-iA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG=Um+0mJW-oAH+YLC3dWEU64JwS-zMkkTiFWYBe4g6HMbe-iA@mail.gmail.com>

It was reported on the mailing list that running `git maintenance start`
immediately segfaults starting with b6c3f8e12c (builtin/maintenance: fix
leak in `get_schedule_cmd()`, 2024-09-26). And indeed, this segfault is
trivial to reproduce up to a point where one is scratching their head
why we didn't catch this regression in our test suite.

The root cause of this error is `get_schedule_cmd()`, which does not
populate the `out` parameter in all cases anymore starting with the
mentioned commit. Callers do assume it to always be populated though and
will e.g. call `strvec_split()` on the returned value, which will of
course segfault when the variable is uninitialized.

So why didn't we catch this trivial regression? The reason is that our
tests always set up the "GIT_TEST_MAINT_SCHEDULER" environment variable
via "t/test-lib.sh", which allows us to override the scheduler command
with a custom one so that we don't accidentally modify the developer's
system. But the faulty code where we don't set the `out` parameter will
only get hit in case that environment variable is _not_ set, which is
never the case when executing our tests.

Fix the regression by again unconditionally allocating the value in the
`out` parameter, if provided. Add a test that unsets the environment
variable to catch future regressions in this area.

Reported-by: Shubham Kanodia <shubham.kanodia10@gmail.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/gc.c           |  7 +++++--
 t/t7900-maintenance.sh | 16 ++++++++++++++++
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 6a7a2da006..d52735354c 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1832,7 +1832,7 @@ static const char *get_extra_launchctl_strings(void) {
  *     | Input |                     Output                      |
  *     | *cmd  | return code |       *out        | *is_available |
  *     +-------+-------------+-------------------+---------------+
- *     | "foo" |    false    | NULL              |  (unchanged)  |
+ *     | "foo" |    false    | "foo" (allocated) |  (unchanged)  |
  *     +-------+-------------+-------------------+---------------+
  *
  *   GIT_TEST_MAINT_SCHEDULER set to “foo:./mock_foo.sh,bar:./mock_bar.sh”
@@ -1850,8 +1850,11 @@ static int get_schedule_cmd(const char *cmd, int *is_available, char **out)
 	struct string_list_item *item;
 	struct string_list list = STRING_LIST_INIT_NODUP;
 
-	if (!testing)
+	if (!testing) {
+		if (out)
+			*out = xstrdup(cmd);
 		return 0;
+	}
 
 	if (is_available)
 		*is_available = 0;
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index a66d0e089d..4008e4e45e 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -646,6 +646,22 @@ test_expect_success !MINGW 'register and unregister with regex metacharacters' '
 		maintenance.repo "$(pwd)/$META"
 '
 
+test_expect_success 'start without GIT_TEST_MAINT_SCHEDULER' '
+	test_when_finished "rm -rf crontab.log script repo" &&
+	mkdir script &&
+	write_script script/crontab <<-EOF &&
+	echo "\$*" >>"$(pwd)"/crontab.log
+	EOF
+	git init repo &&
+	(
+		cd repo &&
+		sane_unset GIT_TEST_MAINT_SCHEDULER &&
+		PATH="$(pwd)/../script:$PATH" git maintenance start --scheduler=crontab
+	) &&
+	test_grep -- -l crontab.log &&
+	test_grep -- git_cron_edit_tmp crontab.log
+'
+
 test_expect_success 'start --scheduler=<scheduler>' '
 	test_expect_code 129 git maintenance start --scheduler=foo 2>err &&
 	test_grep "unrecognized --scheduler argument" err &&
-- 
2.47.0.rc1.33.g90fe3800b9.dirty

