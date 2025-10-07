Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1D42DF129
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 12:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759840616; cv=none; b=LAw0t2pyZ/9K6GAPZCI0ShnCtYp7wuOCmm27D1fu5D26MLLDo8lnsLwSby+/BcGepx4wgMkTl/airpHZpIh3obldDCbxS5e+Hil6DF3vb/uoDtdah4nNAgOPTvuZgFSRs6ijV9d9wukxloZnBXn/QbHvXD82oNfEO5zKRBkDwE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759840616; c=relaxed/simple;
	bh=Eh49vDRAonKJhyQwwmll6foKOHeg7cUSlT3gDrTyZY8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KPviermhLH9ieaBE2cZmHaxa8Dc+ATf19vUJOL+VVR0/pNxAsZwOfQPucxG4pxTzHKmqitFPP8nDtvoISR9fqTafM8bvtc332XkLPdmyGVian4xz6Z0o7i7rGCgXI7XPIXzv5fuwk/qimc6wRl9AFO15gBaEyG7jkezA9qw4hso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Klg+IRV9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j98DNTLo; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Klg+IRV9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j98DNTLo"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 5AB5BEC0368;
	Tue,  7 Oct 2025 08:36:52 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 07 Oct 2025 08:36:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759840612;
	 x=1759927012; bh=ugKjPWzpLlUTKPkrKuICWOoKx8md+kbbPlY2pwSbYVw=; b=
	Klg+IRV9ZomKkw7+u1I5JFSKgWKBN2mwQ9mSauhVedg39Ul/LOVmMT/j0NtXWqry
	Hvfe60cz3T9ptV14XO2w/QYvNWKQNmwKh5Q6ltPKB2tJHdWk7/g0f8e36sHqoZUP
	Hz1NVngEttjS7EMgjRHKjCcYMBJQ9UhyVUruZ5uoJjj03D09MXynJSdCVDZo02Q0
	diFsRIqlBLMGk5Aj8HmZArOu5dMi3C5/efFjruD0zDz+44CRzKmrakMsYBM4IxKD
	t3hUvOeZQFIkfmDLumk2Cf4ubkfuvli/Fl39x9NYyfeLuZuvAosxj9JfxaGbtUF1
	33EN8ahZ/EYidcWoDVRZeg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759840612; x=
	1759927012; bh=ugKjPWzpLlUTKPkrKuICWOoKx8md+kbbPlY2pwSbYVw=; b=j
	98DNTLoCK/WNO6TrekXQuovbOdkaFPVn2r74bUmCT8SoHDy1UH80MwbzQIMAdCWX
	z4bMn6eU4rEaJjjcN4ZUXFj1qY9ExOneG5cLrouG5bzlOrDOhCcgcQtQ4IjU9/qT
	vMJe55iv57hG84lnkdN22gCLTCYf/1+gd2Z+Sm3g9gkFARYfl5itscK6bYZGYsAg
	Yv5u2uwVp93Ho2pPHAirvGMcnernp39ychDsa0NcJGVPMbrMkVo3JoZt1set0Lmg
	1bqwjWd9CNsOd74e18SbpNIqfo/JIbziId7fWKfttYR74k0Td+phlhspcRAXuVqC
	3fHpGTmgtoiySuz26y0+w==
X-ME-Sender: <xms:ZAnlaHA2Q-u0CqaNSKZUV10_AzWWIKIGzWyXwCe_CYLChjqAILdRcA>
    <xme:ZAnlaEiO9UA7SWzgY5yaqFCmopZF0wQBtT1qumQ-rAiLCAxLiL1S4IAMyAlX5Rne8
    gLnGGMkqhe4Wnmxc0H2tjtEZEnELrghe1jZ4J8q1YILcmiC1N5V>
X-ME-Received: <xmr:ZAnlaHlSrE5R3UiEBRvRAtwkqeHQuX0tFwQ4SsDEQXT_Vk7c1tGUJjSL3Q4M8THU6m0UuzXOKaMnQGFgbbI12vOlNoV1mH_ZN6YajtRPOuU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutddtgeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgiivghkih
    gvlhhnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehsrghnuggrlhhssegt
    rhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehjohhhrghnnhgvsh
    drshgthhhinhguvghlihhnsehgmhigrdguvg
X-ME-Proxy: <xmx:ZAnlaIrhIyAegDR7Z1L7DnLoW8WOWImhoNzZkj1XsaauaxZXQ3YyBg>
    <xmx:ZAnlaIE5YjDAdZ6VUrnN9NoK0jCmi9h7ANGuy5r-BQO5rKoMTnIYaA>
    <xmx:ZAnlaMyv_gglFoA5hP4tiuJsoVdevs6t_mKXWExVoSnNuzZr4X6mAg>
    <xmx:ZAnlaFo1XSYag0kglMG5Sug7VvDN_ofJn8pEEMaKZBsKytngku20ow>
    <xmx:ZAnlaPwNrOBnb6wbMdJMgEDEf2anfQF6fL65zfvVxN7vSvp4drRHuo7_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Oct 2025 08:36:51 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5882aa41 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 7 Oct 2025 12:36:50 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 07 Oct 2025 14:36:32 +0200
Subject: [PATCH 4/6] ci: check for common Rust mistakes via Clippy
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251007-b4-pks-ci-rust-v1-4-394502abe7ea@pks.im>
References: <20251007-b4-pks-ci-rust-v1-0-394502abe7ea@pks.im>
In-Reply-To: <20251007-b4-pks-ci-rust-v1-0-394502abe7ea@pks.im>
To: git@vger.kernel.org
Cc: Ezekiel Newren <ezekielnewren@gmail.com>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: b4 0.14.3

Introduce a CI check that uses Clippy to perform checks for common
mistakes and suggested code improvements. Clippy is the official static
analyser of the Rust project and thus the de-facto standard.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/install-dependencies.sh | 2 +-
 ci/run-rust-checks.sh      | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index a24b07edff..dcd22ddd95 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -129,7 +129,7 @@ StaticAnalysis)
 RustAnalysis)
 	sudo apt-get -q -y install rustup
 	rustup default stable
-	rustup component add rustfmt
+	rustup component add clippy rustfmt
 	;;
 sparse)
 	sudo apt-get -q -y install libssl-dev libcurl4-openssl-dev \
diff --git a/ci/run-rust-checks.sh b/ci/run-rust-checks.sh
index 082eb52f11..fb5ea8991b 100755
--- a/ci/run-rust-checks.sh
+++ b/ci/run-rust-checks.sh
@@ -9,4 +9,9 @@ then
 	RET=1
 fi
 
+if ! group "Check for common Rust mistakes" cargo clippy --all-targets --all-features -- -Dwarnings
+then
+	RET=1
+fi
+
 exit $RET

-- 
2.51.0.764.g787ff6f08a.dirty

