Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5D833BBD7
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 10:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771582543; cv=none; b=RgDCQ+vo1aUxza5n992nAuCCFygxPVWSlOgtTw6t63n9uGYIjnQXwrpcOdlNO7wGGfsQmQXJEitERuakS1IHHiJyVYkIFF907CJ6n/uU41Wp+ttbT9p9ziyzuF0dUU2R7p6yVw46ejg2GWnTxjOMOqjOXXZtjG8kslOdPZgPBAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771582543; c=relaxed/simple;
	bh=P7M9NO3pE2RcQHIWol0f7dIi/sZBvHeOg+hQiD9h7xw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D01WfBZpU5DCkvWpYBr/dWuf7gJgXr9BN/E3IDmRsbx6XzhiYbIy1HCNRjDWEPW9XsHB8qhs65HpXeWfJz7JaBYkA1cF7pKK3IbmjzEaCBOrgH1tfAvt2UL3KBfq1aNk8om/WV+Y6egVZ4EdOT1UXjfJ4Rzl+AHMtyab6qEbWqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UWYCq5tZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=elQ9ufeN; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UWYCq5tZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="elQ9ufeN"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id A3A0A1D001C0;
	Fri, 20 Feb 2026 05:15:41 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 20 Feb 2026 05:15:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771582541;
	 x=1771668941; bh=VnrHo4AFQT8Ww2L9r1FO1GIipRukh2Zzi2fBPkmfrZU=; b=
	UWYCq5tZCWQjoonTpG0/c8FYCFGt99NNVVOWmp0oC3qWmitkVnqEiLwP8hzqsQ+D
	LjfoOClXVyAtrjaJax3W2sNrUHrOJ67ee+T+hKxBioiuJy55TH6IdJBZWbTvmYqi
	SOfz1Iby/jHy8CKC3xt0JFc//pcnnI+XkR6Hg4v8MEIqElcr3Ks8w8rCinm2tqVj
	9nMd3xCINSsHwQL+vfUttb/v2E0u3lX9loIggggbhdvlFsbTXmqg+EF8uHWO8BN6
	UEMckYMuyoNgcjL0fA0a0urnYY2gI7HGnsxDq0YPeOYWcTSrtEtGNn800LwiygPs
	MiMP72OvVdcxoJQxaiVujQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771582541; x=
	1771668941; bh=VnrHo4AFQT8Ww2L9r1FO1GIipRukh2Zzi2fBPkmfrZU=; b=e
	lQ9ufeNgmJ8o5SbL76WXYHe2J/MRJ9EdSoZ5i+EmJAF/EeW0u2G1GDWWIWA5So91
	Anz9ILQ40E464CttW7XGa/y6R9QSvIe8OaPsgjYn+8kIpAAwRrOEADsUJ+fKo4BT
	adhBA9EGgxXGD0aDnsIE7KkzVjBnukDuQOAvtbgyi1GOYk3TE9vC9y1GFHhlDPhU
	iINWJeqsSfqGRCN+/2BYoMjv30tMLsHrjitQtSy+XzHSnKsDtg+b8jxFXx/qnoUA
	9Ii9y0iO43epYqlq8p1Dqjs7+oA6Aylkcn+N0sl6QjM2i020+eIYwfQCHGVmPoGH
	4eSYx0gG7jf4UxWpzAQxg==
X-ME-Sender: <xms:TTSYaUV8RnY_atqFeWVgroo6sh-kkOz0TbtOV6jBOczM6FJ7NHQ3qw>
    <xme:TTSYaQDfFseboxZSQBsd71fm0Wob05Oq5AlvQXgpP3bTNqCP-H9SQlhPkYrYpuDv6
    aorIabyrKZEw49txMCeLJl6oeKUcf_e-KeJhwzGQOM9Hv_d-Ol73w>
X-ME-Received: <xmr:TTSYaVz7lBlfFwLcdtw3ImDKuIgla91uZRqSbvrmVMSBcHbZtcnS1eaxJSUW_ubxN_UVrDXyN9SXI3LwRUw19zqxC-6ej6UoAppw9mPZOk-N>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdekudeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeigfeggeethedvffeifeekudfgueelkeefhfduvdeigeektdekhfdtheeuledtieen
    ucffohhmrghinhepihhntghrvghmvghnthgrlhdqrhgvphgrtghkrdgruhhtohenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdr
    ihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:TTSYadAx3icHbR0oEL33sonN_Y174Uqe8b4oKyuA39ZX5vlS6U_sLw>
    <xmx:TTSYaSaRfVAtFdFi4eGpSsYPri0ShltdmU69Aw-IoS66oJUyKgTbnQ>
    <xmx:TTSYaVhyeOPJ6sSy0dQ6VN4fbTNbAYqkWKE7hsxGbUzBMlNrH_dZhw>
    <xmx:TTSYaU7J9jfv5rI_EBKrJbOBDnNEHbrCtNYSZ3WvLJIKLeGoDIXwFw>
    <xmx:TTSYaUefisq026Z7o0aBRycAW7O-DwtLAVSjyBzeyRd1mSacJkBkZGR3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Feb 2026 05:15:40 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 414d3f09 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Feb 2026 10:15:39 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 20 Feb 2026 11:15:11 +0100
Subject: [PATCH 7/8] t7900: prepare for switch of the default strategy
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-b4-pks-maintenance-default-geometric-strategy-v1-7-faeb321ad13b@pks.im>
References: <20260220-b4-pks-maintenance-default-geometric-strategy-v1-0-faeb321ad13b@pks.im>
In-Reply-To: <20260220-b4-pks-maintenance-default-geometric-strategy-v1-0-faeb321ad13b@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Taylor Blau <me@ttaylorr.com>
X-Mailer: b4 0.14.3

The t7900 test suite is exercising git-maintenance(1) and is thus of
course heavily reliant on the exact maintenance strategy. This reliance
comes in two flavors:

  - One test explicitly wants to verify that git-gc(1) is run as part of
    `git maintenance run`. This test is adapted by explicitly picking the
    "gc" strategy.

  - The other tests assume a specific shape of the object database,
    which is dependent on whether or not we run auto-maintenance before
    we come to the actual subject under test. These tests are adapted by
    disabling auto-maintenance.

With these changes t7900 passes with both "gc" and "geometric" default
strategies.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t7900-maintenance.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index d11d6f8f15..63276dcc5f 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -43,7 +43,8 @@ test_expect_success 'help text' '
 	test_grep "usage: git maintenance" err
 '
 
-test_expect_success 'run [--auto|--quiet]' '
+test_expect_success 'run [--auto|--quiet] with gc strategy' '
+	test_config maintenance.strategy gc &&
 	GIT_TRACE2_EVENT="$(pwd)/run-no-auto.txt" \
 		git maintenance run 2>/dev/null &&
 	GIT_TRACE2_EVENT="$(pwd)/run-auto.txt" \
@@ -497,6 +498,7 @@ test_expect_success 'maintenance.incremental-repack.auto' '
 	(
 		cd incremental-repack-true &&
 		git config core.multiPackIndex true &&
+		git config maintenance.auto false &&
 		run_incremental_repack_and_verify
 	)
 '
@@ -507,6 +509,7 @@ test_expect_success 'maintenance.incremental-repack.auto (when config is unset)'
 	(
 		cd incremental-repack-unset &&
 		test_unconfig core.multiPackIndex &&
+		git config maintenance.auto false &&
 		run_incremental_repack_and_verify
 	)
 '
@@ -617,6 +620,7 @@ test_expect_success 'geometric repacking with --auto' '
 	git init repo &&
 	(
 		cd repo &&
+		git config set maintenance.auto false &&
 
 		# An empty repository does not need repacking, except when
 		# explicitly told to do it.

-- 
2.53.0.414.gf7e9f6c205.dirty

