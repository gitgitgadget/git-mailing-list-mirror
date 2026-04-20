Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F57D388393
	for <git@vger.kernel.org>; Mon, 20 Apr 2026 08:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776673380; cv=none; b=r3HHilOw6+F9M4T+Vf2kiq4BswrRnsqLtiMohQ96YQN8z0P6N98/AfmIcPxe6xC7mzds7X1FMp6NwW/cYWOzL0v4MkibWosHKD8RQKCNE4nbd0JEYjCGbPioE6/UR4UnTDyy7mpSL0El1B+iHSnk3VryjJ9erIqjWCSSBYFkTxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776673380; c=relaxed/simple;
	bh=KaBk/wOsF7Ogyp9XS3Anbhk5YTyFs/unA5AXWQ6xZp8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=druT4hq1NlaW3jetG3SXzTHRSJhRvGAGm44Q/jExketMnJRlC0zXl/c9+K7vhdhhI1mP5x6VjD3MimHojleluIEu7Ie7HxDeUJnJTNAaIY2f2TdlUvlFQOrKZ8D8c+wK/LxkixB3XpFxcow3lxCdLHRyOLbwCpzJV6ZuhXBAtxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=x8ZRyRse; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NjZV2+no; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="x8ZRyRse";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NjZV2+no"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 8D3C3EC019B;
	Mon, 20 Apr 2026 04:22:58 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 20 Apr 2026 04:22:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776673378;
	 x=1776759778; bh=1+TpecJLtDjQsPdTUD9M2Bf8qWSVvbMTESF0ftIh/gA=; b=
	x8ZRyRse9PFjN06g6IC0uENT3yZRO6NCVqZro+9lh+SLr6a2JAEaMVr05nWmnNea
	8Jpo/jmnw0h3soFOGFSoZML1xcIinNY15rYsgP3c42GxY7OuSlLFjxO9lKi82piq
	pqThhfP5+N7Fa1ROipRqi2x7zQINxFzVHCDsNkCQjLZx+m2noAn6f49bwT9KHOWk
	5eafvVgcX1FG7X3X/BUDRJuLmi6QuwspcRTnQYGQshV+PWQVgdd+12fuJ1je3klc
	78h/2JorNXwq4/fZGqaFMSgvJTfGuRC9NU3MJguxBi4y3mYRYC2sjE9NVsELhIj5
	IR/37lPTqzWYz62QGuBBzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776673378; x=
	1776759778; bh=1+TpecJLtDjQsPdTUD9M2Bf8qWSVvbMTESF0ftIh/gA=; b=N
	jZV2+noXER5ISN65DdPRNBYse/x8yCyS3a/9atw1Kk40b+Hxopj8dC9DYqQgDs28
	UT9PLB6iiITvmxBUKF8mjoitjsBrQ3XjVdsJNP9zrTrP0V1YG2ltcHAiVoH/Vh3A
	IyBLH6Dbt3ZeDb+tmhemnhLsiHeQgcyryphuOIEYwM+1BioqKY3rIhOQ8FIdif3Q
	PftkcuK9yueCR1xsCGQ4Md7Dpl10A3Npekbi5Bv5eL8AgHXj7+I+u15gLxukDmYL
	PHiOc2j3m3t0Sgom6nye7mcENZJnRRZo5Osf6Jg2fmvlFKFMdwatEaOE89kV9ot6
	YeB/pOUfVGAHJmK1kdbew==
X-ME-Sender: <xms:YuLlafvZEDebc1du2CBhw9JHGpSkPFtxIsqkUxWhozE7GbATM7VYsQ>
    <xme:YuLlaXcSl5YiPJpHi1bh6RZFvX6ILff2fKGRz7ALKtAklrFiwtO5ZzHWn7vuem09L
    Mv8FxvkKxOABAv3wogWRa1WjUDLstgHIcVxNfUnZYmg7DsNq0aQ_g>
X-ME-Received: <xmr:YuLlaXzUh34kua3JagWJ5BGeZr9S-vNnWFjXBrlxnxkO-1TovQJrXvkPHyR2WuM8pjpESFvv139CNmMuKnnoH6ByqFXPG1Ch3a7kpEB9JdkV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehkedtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehnvgifrhgvnhesgh
    hmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:YuLladHuLCxfBR91tlxwOrB-x-ChTkDvWs7NVrcZXXKbH1W7ecvOaQ>
    <xmx:YuLlabyqnkGU4GCFw3OrnBtt_K8WfHrp8jn5Il1J5zzlLTy4ZCsMkw>
    <xmx:YuLlaevn2TlMZaZi7JXmYeIFxYZcbp9nznZQG-ribMFNpkUb03NLMg>
    <xmx:YuLlaY30s4ZgUjnPtbeljMz-nMEoc2QGInwDf-7cO5mBDL-EoRnK-g>
    <xmx:YuLladtr-4peqQuY8r6b7FzkI2IIjCbi4wKfJOnUL-KcE2mUU7LRK-rx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Apr 2026 04:22:57 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8e7f92f2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 20 Apr 2026 08:22:57 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 20 Apr 2026 10:22:35 +0200
Subject: [PATCH 05/18] setup: stop using `the_repository` in
 `path_inside_repo()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260420-pks-setup-wo-the-repository-v1-5-f4a81c4988e8@pks.im>
References: <20260420-pks-setup-wo-the-repository-v1-0-f4a81c4988e8@pks.im>
In-Reply-To: <20260420-pks-setup-wo-the-repository-v1-0-f4a81c4988e8@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Elijah Newren <newren@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.1

Stop using `the_repository` in `path_inside_repo()` and instead accept
the repository as a parameter. The injection of `the_repository` is thus
bumped one level higher, where callers now pass it in explicitly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/diff.c | 4 ++--
 setup.c        | 4 ++--
 setup.h        | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/diff.c b/builtin/diff.c
index 0b23c41456..7ddebce2ac 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -471,8 +471,8 @@ int cmd_diff(int argc,
 		 * as a colourful "diff" replacement.
 		 */
 		if (nongit || ((argc == i + 2) &&
-			       (!path_inside_repo(prefix, argv[i]) ||
-				!path_inside_repo(prefix, argv[i + 1]))))
+			       (!path_inside_repo(the_repository, prefix, argv[i]) ||
+				!path_inside_repo(the_repository, prefix, argv[i + 1]))))
 			no_index = DIFF_NO_INDEX_IMPLICIT;
 	}
 
diff --git a/setup.c b/setup.c
index 331ea86a40..6cfb05c527 100644
--- a/setup.c
+++ b/setup.c
@@ -160,10 +160,10 @@ char *prefix_path(struct repository *repo, const char *prefix, int len, const ch
 	return r;
 }
 
-int path_inside_repo(const char *prefix, const char *path)
+int path_inside_repo(struct repository *repo, const char *prefix, const char *path)
 {
 	int len = prefix ? strlen(prefix) : 0;
-	char *r = prefix_path_gently(the_repository, prefix, len, NULL, path);
+	char *r = prefix_path_gently(repo, prefix, len, NULL, path);
 	if (r) {
 		free(r);
 		return 1;
diff --git a/setup.h b/setup.h
index 24034572b1..c3247d7fc8 100644
--- a/setup.h
+++ b/setup.h
@@ -146,7 +146,7 @@ void verify_filename(const char *prefix,
 		     const char *name,
 		     int diagnose_misspelt_rev);
 void verify_non_filename(const char *prefix, const char *name);
-int path_inside_repo(const char *prefix, const char *path);
+int path_inside_repo(struct repository *repo, const char *prefix, const char *path);
 
 void sanitize_stdfds(void);
 int daemonize(void);

-- 
2.54.0.rc2.529.gd9106f7525.dirty

