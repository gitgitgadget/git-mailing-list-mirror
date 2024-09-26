Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495EA17BEBD
	for <git@vger.kernel.org>; Thu, 26 Sep 2024 11:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727351177; cv=none; b=A3yNl40DzhR4jUBG6Vp8/cweL2qlifsjBf+z0c/AVMQ7mCA3Vpl35469n9MxWtyrT9xdsgLf62rJjzz7U8LDBcv1JVc9qUHRXIDk/tQGMVqr06v5LWopHysMf5OPh45ryEN5rx/1vNQIyNJFHIcKURyuEIFMnbYP7RhE2Umc3M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727351177; c=relaxed/simple;
	bh=YJegBarcpHygr7d7rWW6JdWTzpnGPQxeargJYD5ckZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IGxaWHpRw7gbXTejFXH/W0opeYtU5cnifwBUP7Wsxhx76VMusZsos3AqqBzEN//VV0rjYYhDCdqOV4cb5J9m97k54pBQ9UyJr69OU01+hssOacscPGLTzKIG+ekgYPyMG/mjic4SizfzFlonMIeQ17lPxZQtzFL02MNjFn+p6u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=L9j5eurl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JCVSHQO2; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="L9j5eurl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JCVSHQO2"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5E90B1140242;
	Thu, 26 Sep 2024 07:46:15 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Thu, 26 Sep 2024 07:46:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727351175; x=1727437575; bh=3nBpF8mtMZ
	zcF2o5nsFgKOIIC63o3U3tDzdMuOhD1rQ=; b=L9j5eurlnm8bpnYiUKOKhx+5Pr
	bpfwDhwUyPpoPaCg0FQv6hjTXJDHS6DL46taWAclbpo9YFhBKRX3baxGTcd7rtS6
	GZhnV+NrqC3+42FvSldJVqr4p981hw67ybkt2ZASXeNBJK+o+L3Cyc0K7wi7I6C3
	tcdINCaMsOSvN/biLWWv0R+LSokKSpuCFyy4cJmoRDgfGSJ1yiEhu/RX01y5jtng
	Bj9MDHBYElqBwziTdaaYKoF6anK9i+ZXo5Zp4wTqwRFCAUQCIPCik1Jd6vdznsEI
	YGk2S09IAJSKj9QlEInDWeWzcNf24BMsSItpjoqChKZ38F6C8GQiXPk7bPTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727351175; x=1727437575; bh=3nBpF8mtMZzcF2o5nsFgKOIIC63o
	3U3tDzdMuOhD1rQ=; b=JCVSHQO2KrNTLse9GxSBmbNa9WtnmIw7quFRfPmC82wg
	8dD5f8xFLe3eSbA9ccZBeS4/X8rBrikCIwbCs9KKY6Pdp0+iawTuegSrkLmBp/P4
	zjUtHxyAeKKahfrTvBTY7n8L3s6ibxxV/bA3N71IjOqmVcL11JDvFbqgjz8Wifub
	ARUwT9GEqCErY/gRl1N1yzgp/358keiHtIItSVJ4NCVBPNWoZiTzEjb1jE6lZHs8
	oaNmcytT1yB3yrRhq5kQiqGtg0lXUBP5T1WLZROkT0GUy7IjoqWJqgcDjiY1QPZT
	C9v9zfHwpFvXi6dKlm1msrLfHrKkNzW9QBkn63zvUg==
X-ME-Sender: <xms:h0n1Zm8HGqC8Wz0pJSCkDryo6tU1zbZzhVHN_FTed_Uv2UHf2BXccQ>
    <xme:h0n1ZmsADfIOxQGoT9T3m3vWQnVrVmmJBVtvR5dZLC2RAw72TAsMCtiw3X6R3TZh9
    DojitiivQIvoPYCcg>
X-ME-Received: <xmr:h0n1ZsCn7eGnaNHNLqYihkzQxQJ7ENQKMIdtVJHqsrBOcV0WCqSXtV0vNlXELcZFeuTdLr5A9RoCp3oCzuLccFz0DpAHS3-ZpLa4kno5wa1VYQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtjedggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepjhhlthho
    sghlvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:h0n1ZudYyiCXoLAgsAs322GbjxtdK9jwJyuJNVMlvd4wDN6qaokB1w>
    <xmx:h0n1ZrMoP0UgDrtip1nmClTtZcBPeXw7SnfgPGnnyDUFV0XMnidwIA>
    <xmx:h0n1ZonCX3oVTNER7eak3vBZwEBjXQ70phdtpIGQNzGb7OVvTBK6Kw>
    <xmx:h0n1Ztt7drqd4jo_CmXHVJryNQ_x8cwroVaO9wqEIfjjTbKDyk-dsw>
    <xmx:h0n1ZkqQoFqm8EG4LKloay40HToJwQ3WRfLJgj6E0VgCqvcFllNBsEdl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Sep 2024 07:46:14 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f683e52f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 26 Sep 2024 11:45:36 +0000 (UTC)
Date: Thu, 26 Sep 2024 13:46:11 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 05/23] builtin/submodule--helper: clear child process when
 not running it
Message-ID: <0d0964a2bec7c6e6375a65a5ea9dc79a18ad325c.1727351062.git.ps@pks.im>
References: <cover.1726484308.git.ps@pks.im>
 <cover.1727351062.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727351062.git.ps@pks.im>

In `runcommand_in_submodule_cb()` we may end up not executing the child
command when `argv` is empty. But we still populate the command with
environment variables and other things, which needs cleanup. This leads
to a memory leak because we do not call `finish_command()`.

Fix this by clearing the child process when we don't execute it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/submodule--helper.c  | 10 +++++++---
 t/t7407-submodule-foreach.sh |  1 +
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index ed05dc5134..fd1b679408 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -363,9 +363,13 @@ static void runcommand_in_submodule_cb(const struct cache_entry *list_item,
 	if (!info->quiet)
 		printf(_("Entering '%s'\n"), displaypath);
 
-	if (info->argv[0] && run_command(&cp))
-		die(_("run_command returned non-zero status for %s\n."),
-			displaypath);
+	if (info->argv[0]) {
+		if (run_command(&cp))
+			die(_("run_command returned non-zero status for %s\n."),
+			    displaypath);
+	} else {
+		child_process_clear(&cp);
+	}
 
 	if (info->recursive) {
 		struct child_process cpr = CHILD_PROCESS_INIT;
diff --git a/t/t7407-submodule-foreach.sh b/t/t7407-submodule-foreach.sh
index 8d7b234beb..9f68893261 100755
--- a/t/t7407-submodule-foreach.sh
+++ b/t/t7407-submodule-foreach.sh
@@ -12,6 +12,7 @@ that are currently checked out.
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 
-- 
2.46.2.852.g229c0bf0e5.dirty

