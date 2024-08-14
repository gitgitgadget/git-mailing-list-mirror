Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D690613CFAD
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 06:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723618380; cv=none; b=qGXsGv5o+6xqIWGma0raP88ROJkn8HchQDUhLIw9lpOONlx6zE11q4VSpYWXyQkEoThK3PXEH1Qeup6naVN/rl3fxQzXni7GEDOuMZQztGOrWAvMzO7HQhu9L4K6Fch9eZ0sHEaUOjnNxgHG9eFHhk+9BJ79g7J/hB0e28owLTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723618380; c=relaxed/simple;
	bh=bvWcGfcSixWsFSNcgd9tHk8PRZAxdnx8ad846E7MxrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s0E758080x6aAhPyr9C3+MKdColmqXYmBeghPKkAiRTQENVpoi3JsDBMzk+JDVXe26EfsH18zgE5PD8ly8O6VXEHrRJ3H5haBoMpbRN9TNhU3vMo0sVU5UDGxTLMlEw45Cu7jaVEft/18/7Sus5QrTFrH1M8VL6TiLz6wDWLWzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=j3GqbeR1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TQsxSq+o; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="j3GqbeR1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TQsxSq+o"
Received: from phl-compute-07.internal (phl-compute-07.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 250EB138FC5F;
	Wed, 14 Aug 2024 02:52:58 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Wed, 14 Aug 2024 02:52:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723618378; x=1723704778; bh=1wPwXeOjBn
	5/xJdtr8fUs0WTFnPMLFaLxNRBCAIJRNk=; b=j3GqbeR1Fdiy6PShASZG38VsyR
	yq2gIN8SHmjPRj0lV6EAmleeVlXb1JfhNPHhaJrTl/41ats8hCpzWqZhge1waUWx
	4QnLBt4YO6mimoU2fBTyJN+VgCegBb3JDxdF32LiS2widLDwyjy9HQgOL7XyRPRz
	+8Oi9bjT+t69GbV4BojdwQHCjPUAcO7XjL01kZtH4UCyyx4m1scC5xILAU+YUdq2
	gMyzQVEjNRWf+FqEhKSDVfsQo87qPO1gie6+5xFG1dXxSCrKEmuGkVjLJIQHmCj2
	wl1Hp9uKI3qEi/q+Fsc/aJrZOPyvNGGMIZ+8K/VWeop9TrX4+Qn5zDDSgFrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723618378; x=1723704778; bh=1wPwXeOjBn5/xJdtr8fUs0WTFnPM
	LFaLxNRBCAIJRNk=; b=TQsxSq+orhVdgs4E8aqswdQ7aR+Oit3cdcgUmI/DUz7w
	ef/EUz4CuabWGu7qi0bixNVdYhKYt9oQRRFYiL7fCvdYpyWdCFFPzlM2iki57r8p
	fTkp/45nwg2P4JnIjx0hAZBhvQ0MsgyX+JNe5rhcdfHI4Y7Ma5yyWwimjS8lpzfQ
	ynyEjD0/91MR/FmyYZXmIBEHhd0kIZNFTaK0RG31D1Cvc80ERpNufE8psqmoO/qL
	W/JMwsM2uMuuDuez5KjEgP0vVYCByGg+L5JS+qYVVF9ydKxQfIuqlou+xiW+EUKc
	17yr29W//pDi4scTuokYKaQKpIABl7pW8/zr2G1N4w==
X-ME-Sender: <xms:SVS8ZkTHj9BcqyQkooRjnmU2oqeGQuSxHvrF03-NKXWkAXj7hmePVw>
    <xme:SVS8ZhwM5ezYYc46np7k8XDN0UQUEnOSd6HTiukwFsOBs5En2_T3_iYbzmRlN-PoT
    eRhMM9vGrWB5_udbA>
X-ME-Received: <xmr:SVS8Zh2olw8luVt6MpDqxIqc3eyV1MbWYG3P_2sogMgFcIV-oVBnJ23m0Xv-9Eww2hYPno0dTPRU5VCwe5N5x39n5KoIl6yhmgGAvLGTGDm3CQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtfedgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehphhhi
    lhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhgrmhgvsh
    esjhgrmhgvshhlihhurdhiohdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:SlS8ZoAOPEpVvWIolxNfd-UVR_bkz6e_05px8NXhoLRGmZDlyNBNbQ>
    <xmx:SlS8Ztjw3Crl2jbpbDNpg6qE6TzmX3lXPFhQ21WG6TMqh462gQIr6Q>
    <xmx:SlS8Zko4e5gSc5-l2SIPOqy_6ifyQm120jp5CvzXEdSVR0-idUdk6A>
    <xmx:SlS8ZggF3yPtg76HWWMrQEyyYs2220AymbUOmDfIUBllXmxsCiYkAQ>
    <xmx:SlS8ZoWFTYpiyg95w6h6zFs1bBzcSkmDizOoD8BGUELfC6zV8I-yZMx1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Aug 2024 02:52:56 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6e0b1a76 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 14 Aug 2024 06:52:38 +0000 (UTC)
Date: Wed, 14 Aug 2024 08:52:55 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: James Liu <james@jamesliu.io>, karthik nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v4 21/22] diff: free state populated via options
Message-ID: <9faffa7a62c05a83e4669a01c74da7853a1d7379.1723614263.git.ps@pks.im>
References: <cover.1722933642.git.ps@pks.im>
 <cover.1723614263.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723614263.git.ps@pks.im>

The `objfind` and `anchors` members of `struct diff_options` are
populated via option parsing, but are never freed in `diff_free()`. Fix
this to plug those memory leaks.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 diff.c                   | 10 ++++++++++
 t/t4064-diff-oidfind.sh  |  2 ++
 t/t4065-diff-anchored.sh |  1 +
 t/t4069-remerge-diff.sh  |  1 +
 4 files changed, 14 insertions(+)

diff --git a/diff.c b/diff.c
index 9251c47b72..4035a9374d 100644
--- a/diff.c
+++ b/diff.c
@@ -6717,6 +6717,16 @@ void diff_free(struct diff_options *options)
 	if (options->no_free)
 		return;
 
+	if (options->objfind) {
+		oidset_clear(options->objfind);
+		FREE_AND_NULL(options->objfind);
+	}
+
+	for (size_t i = 0; i < options->anchors_nr; i++)
+		free(options->anchors[i]);
+	FREE_AND_NULL(options->anchors);
+	options->anchors_nr = options->anchors_alloc = 0;
+
 	diff_free_file(options);
 	diff_free_ignore_regex(options);
 	clear_pathspec(&options->pathspec);
diff --git a/t/t4064-diff-oidfind.sh b/t/t4064-diff-oidfind.sh
index 6d8c8986fc..846f285f77 100755
--- a/t/t4064-diff-oidfind.sh
+++ b/t/t4064-diff-oidfind.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='test finding specific blobs in the revision walking'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup ' '
diff --git a/t/t4065-diff-anchored.sh b/t/t4065-diff-anchored.sh
index b3f510f040..647537c12e 100755
--- a/t/t4065-diff-anchored.sh
+++ b/t/t4065-diff-anchored.sh
@@ -2,6 +2,7 @@
 
 test_description='anchored diff algorithm'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success '--anchored' '
diff --git a/t/t4069-remerge-diff.sh b/t/t4069-remerge-diff.sh
index 07323ebafe..888714bbd3 100755
--- a/t/t4069-remerge-diff.sh
+++ b/t/t4069-remerge-diff.sh
@@ -2,6 +2,7 @@
 
 test_description='remerge-diff handling'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # This test is ort-specific
-- 
2.46.0.46.g406f326d27.dirty

