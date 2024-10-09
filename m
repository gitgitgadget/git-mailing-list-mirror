Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE4D1A2647
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 14:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728485790; cv=none; b=CGdzBAdMJCTjzU6Wb0luOv6P0KDdo4bNuePUAYrq9wClCVeWd2XFJC9hHOF34fihk3rTtqTTJC7NBpb+99lARMskfCnYRmRp6woJfQrn0mB0B289CG9qT8MFYg+6MRz5iX5T0Zu+N7ARXT1nQkkzrOE8LkmIpI0iHbg4LNzm8mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728485790; c=relaxed/simple;
	bh=o3Y4WEpOf5cdm6Q2Kon9j36WNtSmqqXHdQ2Mm/m8gW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t09Agt94c/jsKjoUeKPLkmS5ymJnHPZIRN/ZP0YnIXdWMjEtWhUEb8nEk0E9KCqwqDNtC/X9HMfO6pMR5Cs0RE67DwSqnjkJcR4x3ATALtra2t6+Lk8ABnoxSSKNM/vI1J5QzaV7beHDzbYsxkbL/WuV2VobpVd6AbtUSVUjh5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EuSPFY+l; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LKyKY9Nl; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EuSPFY+l";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LKyKY9Nl"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 90BBD13801BD;
	Wed,  9 Oct 2024 10:56:27 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 09 Oct 2024 10:56:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728485787; x=1728572187; bh=8l9Vkk3ZmM
	s26mq7mQ/a/atpOUk0D1/v+dXlOkrBt9g=; b=EuSPFY+lZ0Qdg8pYgFf+kVBvLt
	7BL89jGvNf2e/5VxKKxV+wbOd48RCLfRYCF8OXs90iXqgqAnwvHPUmAwN7d69+JT
	ZUiJ9NWSIRaqvmdN7j6k2Z2A9rmW/77C/xfgxNHqwKdNWFW8azmP+SKDXQbsGwlI
	WfUs3MbXgYuiIrfCplTJuULhX3wpsSACmrL5XMRJQERsdb8hPkBrgs9tlf5JgF10
	tejMxlh22tLZtFyreKjQjGr6UsGWCiEd8k96iPhUDYtlGtjEQ4ltx8QDkX27FQlK
	+xgl9SJYj3LY90qHyqNRNLy5yO9yoivrtSCBF5Y7H7GRXNjnTCueSHhV0y2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728485787; x=1728572187; bh=8l9Vkk3ZmMs26mq7mQ/a/atpOUk0
	D1/v+dXlOkrBt9g=; b=LKyKY9Nl9S1M/3Em3QR88dj6glBQiLbau+/2hn/BfzMB
	fOqhlQyi8KTmAQUphWQbciTCrjfFzeAT0myPh7trSoqMwLyOtkxy6bRGbyAEdsCe
	sQKpQ5ySqpHQ/+c2qWfyDuimJH23f6pJ1JZZX4hLVaGyHTlMZnxFt3BA3ZbpTdJi
	RYIOhBKEiPpCbsXTsn7JjQZ/OSJR0J/0rgof7Z0ff4YIoVnqDGGHn5oUBDiithGJ
	h4Yo/wJsmokm+YLpH0hq33/mUUGEu+vSySut01SzLrZd7rYx+XmXcCxQKE1lHsj7
	ZG6CcAzJg6+GcW2crpXFw3LE1d8GiMHMHZGbeNyQoA==
X-ME-Sender: <xms:m5kGZwVe9RXolPPMttSV5zJ2m9BY5OF1Hv2cIFF-SInjhwPnXPy23w>
    <xme:m5kGZ0migxZ7UVe_PFLjcf25RLpu7Wm73_7N05qp8_sX7BLoeFrcLpgFpdRqQrUVg
    WkQNGKYLS5-ZGglnA>
X-ME-Received: <xmr:m5kGZ0YHhrrY3zjV5TAQPd2Hhn9k8rqFwhPF5GhXn7A6dBgYQR7J-S2tq091aT_JnRnVpExNcC5ZAsbiytgnQpvK6rskI5iJkp5oLFmd1ik23g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeffedgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthht
    ohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepvghstghhfigrrhhtiies
    ghgvnhhtohhordhorhhg
X-ME-Proxy: <xmx:m5kGZ_VoBYOHGay_8Yw943Byz5RmhiT_zNiJ-3uKaCMedThUwk3shA>
    <xmx:m5kGZ6mSuRl61DCYrTkshgwWAtLPT5p7xMCrmznc9M4SQQj6yQ1ehg>
    <xmx:m5kGZ0fkefDzFTdvRPBF2jtgNk52ECzzIaS2FHG-0ORHhFWx7gvXbg>
    <xmx:m5kGZ8GND11Q4F5smgI9_w23jvOdoPMcYo2-kPm-Wown_B2cR6OrMw>
    <xmx:m5kGZxuYfwBtNV3t4jwWhpmLMeGJTchgZ2tx4NqArgb2knqYwgGsMA6Y>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Oct 2024 10:56:26 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8dc5d4ad (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 9 Oct 2024 14:55:23 +0000 (UTC)
Date: Wed, 9 Oct 2024 16:56:22 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [RFC PATCH v2 06/24] t3404: work around platform-specific behaviour
 on macOS 10.15
Message-ID: <bada3a82fdd433351b007ee2691d1b3bfb1597dc.1728485139.git.ps@pks.im>
References: <cover.1727881164.git.ps@pks.im>
 <cover.1728485139.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1728485139.git.ps@pks.im>

Two of our tests in t3404 use indented HERE docs where leading tabs on
some of the lines are actually relevant. The tabs do get removed though,
and we try to fix this up by using sed(1) to replace leading tabs in the
actual output, as well. But macOS 10.15 uses an oldish version of sed(1)
that has BSD lineage, which does not understand "\t", and thus we fail
to strip those leading tabs and fail the test.

Address this issue by using `q_to_tab` such that we do not have to strip
leading tabs from the actual output.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t3404-rebase-interactive.sh | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index f171af3061d..7ce75237803 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1917,18 +1917,17 @@ test_expect_success '--update-refs updates refs correctly' '
 	test_cmp_rev HEAD~1 refs/heads/third &&
 	test_cmp_rev HEAD refs/heads/no-conflict-branch &&
 
-	cat >expect <<-\EOF &&
+	q_to_tab >expect <<-\EOF &&
 	Successfully rebased and updated refs/heads/update-refs.
 	Updated the following refs with --update-refs:
-		refs/heads/first
-		refs/heads/no-conflict-branch
-		refs/heads/second
-		refs/heads/third
+	Qrefs/heads/first
+	Qrefs/heads/no-conflict-branch
+	Qrefs/heads/second
+	Qrefs/heads/third
 	EOF
 
 	# Clear "Rebasing (X/Y)" progress lines and drop leading tabs.
-	sed -e "s/Rebasing.*Successfully/Successfully/g" -e "s/^\t//g" \
-		<err >err.trimmed &&
+	sed "s/Rebasing.*Successfully/Successfully/g" <err >err.trimmed &&
 	test_cmp expect err.trimmed
 '
 
@@ -2178,19 +2177,18 @@ test_expect_success '--update-refs: check failed ref update' '
 	test_must_fail git rebase --continue 2>err &&
 	grep "update_ref failed for ref '\''refs/heads/second'\''" err &&
 
-	cat >expect <<-\EOF &&
+	q_to_tab >expect <<-\EOF &&
 	Updated the following refs with --update-refs:
-		refs/heads/first
-		refs/heads/no-conflict-branch
-		refs/heads/third
+	Qrefs/heads/first
+	Qrefs/heads/no-conflict-branch
+	Qrefs/heads/third
 	Failed to update the following refs with --update-refs:
-		refs/heads/second
+	Qrefs/heads/second
 	EOF
 
 	# Clear "Rebasing (X/Y)" progress lines and drop leading tabs.
 	tail -n 6 err >err.last &&
-	sed -e "s/Rebasing.*Successfully/Successfully/g" -e "s/^\t//g" \
-		<err.last >err.trimmed &&
+	sed "s/Rebasing.*Successfully/Successfully/g" <err.last >err.trimmed &&
 	test_cmp expect err.trimmed
 '
 
-- 
2.47.0.rc1.33.g90fe3800b9.dirty

