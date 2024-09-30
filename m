Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B37C186E39
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 09:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727687628; cv=none; b=o5tz2d01ugpsuReOqnu1eok4l5WlCWmhRHR7rY7ICI4z51VAmJD3WuS1c+QP46xWrPXdJ+XPrw3ex+tZQjcvD0n44rnEEu2is5J28Drm82XGkI+1y5+VVOVRHK+V0BgoWlW/ka8alPE9bm+KYI/12kxesTE7OurSXhBTYbXSN2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727687628; c=relaxed/simple;
	bh=+DZeLpfnFIJnxA7zZrVmwqd6sJl2CBAIZ4tTSvLPWJA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pBF6Ggl4LOYwn7n2FLuq67c4bog+d8HQ+731GdbSfwwA3EJ6XoCLPA0dIzf5/Pc8TpsG8TbJCRbsD/CSu1Wo0CIbFAGJEgw0xNuVQUQrmvVZL4UESf0OaXTyCNJf4tt+OWysAIPtwuWv4HtKgsvBiDLGH3kx1do1g5/NZiaGTs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZJahBWbN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=II9qaFFE; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZJahBWbN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="II9qaFFE"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8E87C1140260
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 05:13:46 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 30 Sep 2024 05:13:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727687626; x=1727774026; bh=rClL9CX3mV
	RJPnEM1h71xOM6qF8QQaIApqNSzKmtjuk=; b=ZJahBWbNa5hcPZuGnjBY3BbiTd
	tWvsSVj9p1MZo9jV4EwWiOMlSQbEhHE/rg7MH9nifh1PL4g4GmqyboQDtd9DYic7
	+Wh9HNkS1P6lipy5Q15aK/Fe0jAw0sdGgr5rOBMWGqqfh3n+/XEq9iOV0orGngS1
	2RFmVlaHyrhxE8GGQoXbBFe3dMbT5X2YeTpmKWAnC8/joeaOmJfosH9kHbV6SSb0
	PSnEMvA6WorBF6tKVdFAvDxURvq9c3ALg8FQtdk3j+LUyc+e21wLvcoEh8kiX/wh
	mNjLDjy8ovi+LE5FeIU6yWDWWnC8XwdaEc7GbtgK6m7Zb6Jpd8th37Ie9aUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727687626; x=1727774026; bh=rClL9CX3mVRJPnEM1h71xOM6qF8Q
	QaIApqNSzKmtjuk=; b=II9qaFFEaWQwAHZ0Us7o/LXkpj5FHOUMfqrJYT6hLddy
	LbHwkc6XW7IyUuwJ+SkLS6XxZ3ikmPevnVqO1C6KDS6egbxh6m+Kp8UusNUhDm8o
	KfShjeiVvRgiTCV9Rjvb8F+2T6dk6QVUWH825QP8brQoeVczUv7LxEbP0Q6IO1p0
	JeNz0G9OtbnfzpjX96Nvz89gyejCchETUIyD8HIX1GXJBEHNbraLsc5i5iE3hF/P
	2Xo+88kdYjgFrOZheqeslQRdBV6uQ8AZDem/EmJFdExzv9RMWm/x4n3MJ95WiOIx
	uY2fonfqUzgWThmMeakta7/Pgs5DjUt2FWK5rDqhQA==
X-ME-Sender: <xms:ymv6ZnvCjUgSICHBq5LEagoqTQdaf5awZxD7yRAvDR5XQvnUjrBqnQ>
    <xme:ymv6ZodscHyktDIiBXqXy7muubU_Q0QzJVuYGSyW6NZEPSXs2QcyQDxXHfLJykJCK
    9ktMNTc_knOFNPtJQ>
X-ME-Received: <xmr:ymv6ZqzXMxP3z_gOXt9HbfNB2OBk_hBcKCarySpQTOmEsrDvjg4x3QjpJpMCUmaJw5E79H81190mv7izQFKr-2YCRR5so_eznfm5GeUjgXsJfaM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduhedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvd
    egvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ymv6ZmPISgDJrxdcCJaNa5T1noY2CQ3qZSbWZ3wptY5-0WIV7MSATw>
    <xmx:ymv6Zn8IaCECnrc1zrWWLS0_j1xckbUzZUYgojGsG6YnBHXVmmuQyw>
    <xmx:ymv6ZmVU6CivWpMcAypB7BjMpd56Wd-nurs9qf8RdZaQ77QLqh-FUg>
    <xmx:ymv6Zoc-ePxC3608D3aTrJIt4C5owurn4gj0Am_tCA8G4muhhEzPSA>
    <xmx:ymv6Zhldvwq3jqr1_mtE6lAT8WyAKKMWouNGgE4JqhJ1RxwycEpPvo50>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 30 Sep 2024 05:13:45 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9d56d597 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 30 Sep 2024 09:12:59 +0000 (UTC)
Date: Mon, 30 Sep 2024 11:13:43 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 11/23] builtin/revert: fix leaking `gpg_sign` and `strategy`
 config
Message-ID: <3177c449206c802239720479bc070df7a22b0d0e.1727687410.git.ps@pks.im>
References: <cover.1727687410.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727687410.git.ps@pks.im>

We leak the config values when `gpg_sign` or `strategy` options are
being overridden via the command line. To fix this we need to free the
old value, which requires us to figure out whether the value was changed
via an option in the first place. The easy way to do this, which is to
initialize local variables with `NULL`, doesn't work because we cannot
tell the case where the user has passed e.g. `--no-gpg-sign`. Instead,
we use a sentinel value for both values that we can compare against to
check whether the user has passed the option.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/revert.c                  | 17 +++++++++++++----
 t/t3514-cherry-pick-revert-gpg.sh |  1 +
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 55ba1092c5..b7917dddd3 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -110,6 +110,9 @@ static int run_sequencer(int argc, const char **argv, const char *prefix,
 	const char * const * usage_str = revert_or_cherry_pick_usage(opts);
 	const char *me = action_name(opts);
 	const char *cleanup_arg = NULL;
+	const char sentinel_value;
+	const char *strategy = &sentinel_value;
+	const char *gpg_sign = &sentinel_value;
 	enum empty_action empty_opt = EMPTY_COMMIT_UNSPECIFIED;
 	int cmd = 0;
 	struct option base_options[] = {
@@ -125,10 +128,10 @@ static int run_sequencer(int argc, const char **argv, const char *prefix,
 		OPT_CALLBACK('m', "mainline", opts, N_("parent-number"),
 			     N_("select mainline parent"), option_parse_m),
 		OPT_RERERE_AUTOUPDATE(&opts->allow_rerere_auto),
-		OPT_STRING(0, "strategy", &opts->strategy, N_("strategy"), N_("merge strategy")),
+		OPT_STRING(0, "strategy", &strategy, N_("strategy"), N_("merge strategy")),
 		OPT_STRVEC('X', "strategy-option", &opts->xopts, N_("option"),
 			N_("option for merge strategy")),
-		{ OPTION_STRING, 'S', "gpg-sign", &opts->gpg_sign, N_("key-id"),
+		{ OPTION_STRING, 'S', "gpg-sign", &gpg_sign, N_("key-id"),
 		  N_("GPG sign commit"), PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
 		OPT_END()
 	};
@@ -240,8 +243,14 @@ static int run_sequencer(int argc, const char **argv, const char *prefix,
 		usage_with_options(usage_str, options);
 
 	/* These option values will be free()d */
-	opts->gpg_sign = xstrdup_or_null(opts->gpg_sign);
-	opts->strategy = xstrdup_or_null(opts->strategy);
+	if (gpg_sign != &sentinel_value) {
+		free(opts->gpg_sign);
+		opts->gpg_sign = xstrdup_or_null(gpg_sign);
+	}
+	if (strategy != &sentinel_value) {
+		free(opts->strategy);
+		opts->strategy = xstrdup_or_null(strategy);
+	}
 	if (!opts->strategy && getenv("GIT_TEST_MERGE_ALGORITHM"))
 		opts->strategy = xstrdup(getenv("GIT_TEST_MERGE_ALGORITHM"));
 	free(options);
diff --git a/t/t3514-cherry-pick-revert-gpg.sh b/t/t3514-cherry-pick-revert-gpg.sh
index 5b2e250eaa..133dc07217 100755
--- a/t/t3514-cherry-pick-revert-gpg.sh
+++ b/t/t3514-cherry-pick-revert-gpg.sh
@@ -5,6 +5,7 @@
 
 test_description='test {cherry-pick,revert} --[no-]gpg-sign'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-gpg.sh"
 
-- 
2.46.2.852.g229c0bf0e5.dirty

