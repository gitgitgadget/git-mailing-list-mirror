Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFAB190661
	for <git@vger.kernel.org>; Mon, 20 Jan 2025 07:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737358991; cv=none; b=aKJhkkyiJE4B0yt7rMZOJc3g/H2Croo5U4/EL+0GRZ6yBT4UgY8SIYTeDzMzMrmIzV4GqHNutlPydavE7tNVYq3BwryS4brgf0p9SjgbPnIdJDbxRilVpgqJxvyIx7zoV29H347ZaNT4jRrZVvh85Lp7Li+5cRk6DHitoYJA1b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737358991; c=relaxed/simple;
	bh=XtNR9wbCs+Ft8wv2+FJQeRMNAbwog9O4l1TsvD3XYcc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kUoKkRXW3c2N0j4kisDjP/ElN0ZFb4QQhdhIwDl+/1MNO7urLru7EA3Bdf4Cid9cHAIW3lF/hyedtssE0NoZavPlFMXUkT7cFaf9xVbH3z5fiNfhsw1LBwFaE4k/UXunGUpka4K0VCeFNSA79OZE9d2oxSYdFTkKK5MjrPVUVEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bmOYWmRI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZhFpVR5h; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bmOYWmRI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZhFpVR5h"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id BF7CF11400E9;
	Mon, 20 Jan 2025 02:43:08 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 20 Jan 2025 02:43:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1737358988;
	 x=1737445388; bh=al5TDJwcza0Bw8WO6mBxdWU+wjhueVgZehckO+HZnJs=; b=
	bmOYWmRIqCaPdtywdPFgU7TVTSSSJhl3Jz+MqBwf5N0jXBX9qftHmAcWkDG3c/z5
	lXOjO214v5vtp48KBZCWo7rk+LKByzYINixg+YipAZUxuIsfDi8/8UiWstuAY/vS
	RpzBMwMd8c3PHq+4SdaZNDxH5Ys+doMKSIEjdr0SdumXIfY6uPTUvpI99WJOQyyq
	VNOn3Xgr1SZ3nYkurP/wqT2rNeDnxfnUK/j7l9u0DAAwJwpWUoTpf3nGJVUob4U3
	IgAUyssoHwbw6hecy7cLAK5Xo/P0J7DbQk7Zf35PiFIl9qeESMdmRuZZxuLBnb1m
	eY0HIYWyvGctQLUcf/gGuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1737358988; x=
	1737445388; bh=al5TDJwcza0Bw8WO6mBxdWU+wjhueVgZehckO+HZnJs=; b=Z
	hFpVR5hzcERin1U+l8xStXZxaUn7V4gAHi3YA/t3erDPHCf6G7XAy2oI/zOfot+d
	yHhp6PpOttde8uT7pv1KXeLQ0AQ7/nYMqBt5aSRddTISdILkX/A5/OllEGyAt3f5
	JXxKHra2A8frizurSsOCvPt7aeitzYtcMyOKTfmd/zJ+W0rTj2nKO1d/kd80Ks6/
	XVQpLh1oMRjk2w7oVdU6YdTdP/8jyfGBLsi9f3jE7k5038s066yGtaW+3V66hiaY
	0/TBqSEv172vvJ7NDDttWICMRLJIWImbutyjTKPkV2XMPrhGWrYcd1dQpmeo5tjn
	x7PYCtFUSYMWlUJlZpfhg==
X-ME-Sender: <xms:jP6NZxbgOq2xHUAcpiqi42wjVHz6AGi0DeORzrSmkzy3FX_cSxXPIg>
    <xme:jP6NZ4ZJo5fsr87ZZTY6PH32by06H0H7i174K5pm5099u0t309deHchx4q1bK137a
    4lQsyDaugpqczI08A>
X-ME-Received: <xmr:jP6NZz8KfTeojkW4WA8LPTX5qbyRYWfq3rvfaeA0-un6_OlFsNn95qwJOvb1UaT9MfTJKzIK2fC5zHddN-iwkn9w9Pfn0xPzXswGqNhYagO3dA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeikedguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehrohgsvghrthdrtghouhhpsehkohhorhguihhnrghtvghsrdgtohhmpdhrtghpthhtoh
    eprhgrnhgurghllhdrsggvtghkvghrsehnvgigsghrihgughgvrdgtrgdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtoheptghhrhhishgtohholh
    esthhugihfrghmihhlhidrohhrgh
X-ME-Proxy: <xmx:jP6NZ_piaVBu_eZM65ho0vInY4BmMtC7WiOSyBDyUQEd1VIkGQmdOQ>
    <xmx:jP6NZ8qEhzIUkoKLDOYLBzxQBhGK2kMuQV6KsMTg-BDcYDP4OQBKWw>
    <xmx:jP6NZ1SiH1yuFD_Nuin2f4x2hN-uavOf0dggArJcHgVpMRegYhp8xA>
    <xmx:jP6NZ0onXZUoQIAz8uyhMTghT77kvSQWcn9A3T3j-dk9HDQaR7_CWA>
    <xmx:jP6NZ9d2GOeRH8GYaUntjzSu88sBsFDH7Mlb2sVgUezE4dt5tWp8ssEn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Jan 2025 02:43:07 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 24286d73 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 20 Jan 2025 07:43:04 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 20 Jan 2025 08:43:01 +0100
Subject: [PATCH v3 4/5] builtin/pack-redundant: remove subcommand with
 breaking changes
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250120-pks-remote-branches-deprecation-v3-4-c7e539b6a84f@pks.im>
References: <20250120-pks-remote-branches-deprecation-v3-0-c7e539b6a84f@pks.im>
In-Reply-To: <20250120-pks-remote-branches-deprecation-v3-0-c7e539b6a84f@pks.im>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Robert Coup <robert.coup@koordinates.com>, 
 Christian Couder <chriscool@tuxfamily.org>, 
 "Randall S. Becker" <randall.becker@nexbridge.ca>
X-Mailer: b4 0.14.2

The git-pack-redundant(1) subcommand has been announced for removal with
53a92c9552 (Documentation/BreakingChanges: announce removal of
git-pack-redundant(1), 2024-09-02). Stop compiling the subcommand in
case the `WITH_BREAKING_CHANGES` build flag is set.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Makefile                  | 2 ++
 git.c                     | 2 ++
 t/t5323-pack-redundant.sh | 6 ++++++
 3 files changed, 10 insertions(+)

diff --git a/Makefile b/Makefile
index dc3c980aa7..e6b0d85980 100644
--- a/Makefile
+++ b/Makefile
@@ -1278,7 +1278,9 @@ BUILTIN_OBJS += builtin/mv.o
 BUILTIN_OBJS += builtin/name-rev.o
 BUILTIN_OBJS += builtin/notes.o
 BUILTIN_OBJS += builtin/pack-objects.o
+ifndef WITH_BREAKING_CHANGES
 BUILTIN_OBJS += builtin/pack-redundant.o
+endif
 BUILTIN_OBJS += builtin/pack-refs.o
 BUILTIN_OBJS += builtin/patch-id.o
 BUILTIN_OBJS += builtin/prune-packed.o
diff --git a/git.c b/git.c
index 46b3c740c5..a13c32bcdc 100644
--- a/git.c
+++ b/git.c
@@ -589,7 +589,9 @@ static struct cmd_struct commands[] = {
 	{ "name-rev", cmd_name_rev, RUN_SETUP },
 	{ "notes", cmd_notes, RUN_SETUP },
 	{ "pack-objects", cmd_pack_objects, RUN_SETUP },
+#ifndef WITH_BREAKING_CHANGES
 	{ "pack-redundant", cmd_pack_redundant, RUN_SETUP | NO_PARSEOPT },
+#endif
 	{ "pack-refs", cmd_pack_refs, RUN_SETUP },
 	{ "patch-id", cmd_patch_id, RUN_SETUP_GENTLY | NO_PARSEOPT },
 	{ "pickaxe", cmd_blame, RUN_SETUP },
diff --git a/t/t5323-pack-redundant.sh b/t/t5323-pack-redundant.sh
index 8dbbcc5e51..688cd9706c 100755
--- a/t/t5323-pack-redundant.sh
+++ b/t/t5323-pack-redundant.sh
@@ -36,6 +36,12 @@ relationship between packs and objects is as follows:
 
 . ./test-lib.sh
 
+if ! test_have_prereq WITHOUT_BREAKING_CHANGES
+then
+	skip_all='skipping git-pack-redundant tests; built with breaking changes'
+	test_done
+fi
+
 main_repo=main.git
 shared_repo=shared.git
 

-- 
2.48.0.257.gd3603152ad.dirty

