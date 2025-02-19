Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A491D8DFE
	for <git@vger.kernel.org>; Wed, 19 Feb 2025 13:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739970845; cv=none; b=W4qdtkdTrTFRLGySjlGuD/1vqBHz5TDz/470A01R1dU+kly0eBjC85IC1gPRYYtOo5q+/IwTfp2pt6mGawNjCZ4zoAVyo6b4sHl8EzukKpKT85MLkFf4xzX8vQnTCuh7wGeiRufwpi1uOagEl49bb50UZNxUMAvoQ7yru9ZBRro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739970845; c=relaxed/simple;
	bh=HFQWyZjRhwHglC3UhVOgAr7YOWEKQdQgU17NhNA0iyM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=owJGxdLsB+AtTioMCd1M2Z4VaoVEdqHNVfL53ofMkU4EqLfwKlcDQJmypYF0qsVPRqHuCu/JBIK77l66hwRxbAf2skQ18xXgi6seBXB/uNkrfKKGw//XMZCR3juQKNWnso17ht9kNofkYx+7vu4VPb5Swnh1LX4JVpz7GMlF9Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=V4+A0its; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Dm5iDcOZ; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="V4+A0its";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Dm5iDcOZ"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id B1F9C1140095;
	Wed, 19 Feb 2025 08:14:02 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 19 Feb 2025 08:14:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1739970842;
	 x=1740057242; bh=vgt4wMFS1iiz6IOHy6D6csP0Vz64K+GXFckqy38ABfE=; b=
	V4+A0itskzka8v8rzUR+SN1eEhR1DVzz0wVcHd8oSbBEE4EGZXol5hiedrJMyn1S
	4peBErvTvfETnnRl4/mRhJap7f+Wa1RxLhOTZCg2OZyehaKpE9zzE+28/Glw/kpf
	orycz0EPUXyIcx8l+WbahVo+GmXS+xPaXggRIEcCDSDGtjuq2jN45lquuLro8LsL
	g3tdSDq9UCHBZPBFFk8nJIhsELaRNt6cZURl1PWhhfgAwFFVlLhnHODGoHm6aVov
	mX9Bf6522tqSv3x2Ftb57QlYA0SOcL7hDfyFH+SD3jADU06P0dnbJCqvYP5B5wO7
	1MWm4Radrl8rc/sIPOa+kA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739970842; x=
	1740057242; bh=vgt4wMFS1iiz6IOHy6D6csP0Vz64K+GXFckqy38ABfE=; b=D
	m5iDcOZb/Us0mPKSNmALjBNpGCJiQ4+UU4oyOe8nRk7xFW78POiRdCBKgNGM9qsv
	HpEpLhKgdlcjC1pIMc1kcwnbb/WjpPqsP65kxsDVN1Ft2J55OHqPlkKboPhgwSZC
	7EStpVdyhsLBhiveA9Rqrba6avWXNtv7871esAvDVMzQE8sZ4k74SxlxmFf+qc1B
	xfIQDJsjvr9Ny/T/s63BTh9bzw9lxHuzimK6NXaviKnOPCbeRorH0ryvBBF4dLbs
	uOnZ3ThHJBVj5CSKZKBkpTQUaCAeCq6TIZT9bCDrNWc2kYc6Jb1wj3pEQWTTEUWI
	Lb22O3+qFeJ4xX8OUDYZw==
X-ME-Sender: <xms:Gtm1Z91C-W9EBtOrg1Skdo2TajVvPAUvpSROm2LrqE1afhhYSkpKUQ>
    <xme:Gtm1Z0Ei5jDuLU0sfdlyMOo1TMtl3g-QO2rzjaus3kerinfTbBaNeUBqTPnmWagk7
    ljRvEqoLHURCkXe5Q>
X-ME-Received: <xmr:Gtm1Z95TD35KwIFtP2hpqsQYLmO7242J-PxkNHlo_R7zoOMUKxSQKebPAkr0IT7xbbQk6xqb9aBVq9dEC18eKGXoEjtqg7aa92Y9H3RdvVxPcAY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeigeeffecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepmhhirhhthhdrhhhitghkfhhorhgusehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepjheitheskh
    gusghgrdhorhhg
X-ME-Proxy: <xmx:Gtm1Z62Va4udjSOhP4CI7jSKUtYWVdw_nWoz1N23FhvNMdopxneEcQ>
    <xmx:Gtm1ZwHtB0NuPUvG_fVzBocaT4O6FCJKhh8FSS_vD3Y5-9ayEO7gdQ>
    <xmx:Gtm1Z79rIYXTgDXjWgjANObB5uF-F99d_gES9eIGDREzBXZuCJlKsQ>
    <xmx:Gtm1Z9kLuh5JtRyVQOuhcxICz8YroY3cyjOni2Hl73vyXHB4W0Xywg>
    <xmx:Gtm1Z8jcpVWQFG90ND-9DLNxLa5_Hk07HaDmekJLoQQgkQZDl4NS0pBc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Feb 2025 08:14:01 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0d2ce53b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 19 Feb 2025 13:13:59 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 19 Feb 2025 14:13:42 +0100
Subject: [PATCH v2 02/10] contrib/credential: fix "netrc" tests with
 out-of-tree builds
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250219-b4-pks-meson-contrib-v2-2-1ba5d7fde0b9@pks.im>
References: <20250219-b4-pks-meson-contrib-v2-0-1ba5d7fde0b9@pks.im>
In-Reply-To: <20250219-b4-pks-meson-contrib-v2-0-1ba5d7fde0b9@pks.im>
To: git@vger.kernel.org
Cc: M Hickford <mirth.hickford@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>
X-Mailer: b4 0.14.2

Tests of the "netrc" credential helper aren't prepared to handle
out-of-tree builds:

  - They expect the "test.pl" script to be located relative to the build
    directory, even though it is located in the source directory.

  - They expect the built "git-credential-netrc" helper to be located
    relative to the "test.pl" file, evne though it is loated in the
    build directory.

This works alright as long as source and build directories are the same,
but starts to break apart with Meson.

Fix these first issue by using the new "GIT_SOURCE_DIR" variable to
locate the test script itself. And fix the second issue by introducing a
new environment variable "CREDENTIAL_NETRC_PATH" that can be set for
out-of-tree builds to locate the built credential helper.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 contrib/credential/netrc/t-git-credential-netrc.sh | 2 +-
 contrib/credential/netrc/test.pl                   | 7 ++++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/contrib/credential/netrc/t-git-credential-netrc.sh b/contrib/credential/netrc/t-git-credential-netrc.sh
index bf2777308a5..1b7b8b3a9aa 100755
--- a/contrib/credential/netrc/t-git-credential-netrc.sh
+++ b/contrib/credential/netrc/t-git-credential-netrc.sh
@@ -15,7 +15,7 @@
 
 	export PERL5LIB="$GITPERLLIB"
 	test_expect_success 'git-credential-netrc' '
-		perl "$GIT_BUILD_DIR"/contrib/credential/netrc/test.pl
+		perl "$GIT_SOURCE_DIR"/contrib/credential/netrc/test.pl
 	'
 
 	test_done
diff --git a/contrib/credential/netrc/test.pl b/contrib/credential/netrc/test.pl
index c0fb3718b28..67a0ede5644 100755
--- a/contrib/credential/netrc/test.pl
+++ b/contrib/credential/netrc/test.pl
@@ -15,10 +15,11 @@ BEGIN
 
 my @global_credential_args = @ARGV;
 my $scriptDir = dirname rel2abs $0;
-my ($netrc, $netrcGpg, $gcNetrc) = map { catfile $scriptDir, $_; }
+my ($netrc, $netrcGpg) = map { catfile $scriptDir, $_; }
                                        qw(test.netrc
-                                          test.netrc.gpg
-                                          git-credential-netrc);
+                                          test.netrc.gpg);
+my $gcNetrc = $ENV{CREDENTIAL_NETRC_PATH} || catfile $scriptDir, qw(git-credential-netrc);
+
 local $ENV{PATH} = join ':'
                       , $scriptDir
                       , $ENV{PATH}

-- 
2.48.1.666.gff9fcf71b7.dirty

