Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFD225A33A
	for <git@vger.kernel.org>; Mon, 22 Sep 2025 21:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758575475; cv=none; b=hO3bThSeNWhRnG4ubSMkM2yfZZ2jx2skh9XeyPccOYA/qxnKD+23i9NSfxgivxXDgkQcuijjIrHSxzTZ/LRRfU2cmvqJnXJI2K7DrPwfsPNH2YCv/dzOQRzX2oFqnRtGORwV2TXJBokUaWt68IYTR+UOtGv1NdjNmir3IGZLU/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758575475; c=relaxed/simple;
	bh=uRppxbSgADG4zYR4f6Ppdtmf7VYFryKaOTvS8u2zh2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CWjIFs8BnJ8LIwSsAPfENe/w6HIhvG7BTYBQOa+JxgxUG0QBtlPqyS3hO24ktg7BAmNDMp5MQQjoANlsNA23fEh/LxhfngES36exiWKSGeWx0EB9/kdvHOSjiN72Jma3eAmzA9lSbfboqJDErwbCo1M7kHTGVslBqtSiV79vVxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=kzP44Lkr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JsPPR3JM; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="kzP44Lkr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JsPPR3JM"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9AEB37A020D;
	Mon, 22 Sep 2025 17:11:11 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 22 Sep 2025 17:11:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758575471;
	 x=1758661871; bh=fOkszYes+DPn7PaSQy0EEEQW+SKjyURTQe2aDo+Yj9k=; b=
	kzP44Lkrkw8F0tDznLjQKLGPAHFDocFrAUjskOMW/mjoOaH1D9eA5YhmmCSqEGq4
	RbF0wZAhlV3Wua46CGq+GF7xNobmJaI1dVWFXT2Fx+UeQTvmPt7yqL/13xE6ZX/E
	HCz/Kujf7kPOaHGh5/vhrPv+ndPWWaG+EwPBLa4RRxZXV3E8Jqp7zsjdvZ7OZZPE
	q8VUE7Rjb9tf5g00rd8OcxRQACzCdDTm5+JiPYQDQtgHCX0LpPByCrDDS7MyuQIy
	0cBsiAI4vK3fNLYZfwlnXGhg29U2iFX0emVdZs1OMKjr3dYFvDhAhqFzYcYxwmC9
	zpxFk7WY5JCJWaX6f7Rf6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758575471; x=
	1758661871; bh=fOkszYes+DPn7PaSQy0EEEQW+SKjyURTQe2aDo+Yj9k=; b=J
	sPPR3JM+pj/TGI02md6kJc4AJPYB+rkSOf3vGZur7ehLctgDApQaXvnw5WgMZne0
	R2TTi8QyQUPdDW1W1c8kKiWsUiTNF/vRlS1icY6KBhxs9Xv5nbQcMjljt7d5pubJ
	ThCSAnVWHmqF0qDOS5SmnNhdgXGqbuRrPPey/bPRIZhbxLzJdRY5zxwmCw8Ssi61
	2UJxZMzEkyHZeHOXQHEyt9u51oM4v0iEt/kG7vBv4ENaZ7/Qhsrg090CdyGnl/Q0
	0KcLsrGf0HQGMyLez32xnBugoHyBPuVCgfr/J18zEeHxh4IHCS3F2YeikGUDlieV
	6+yrkSyBu+P3rfELRM/xg==
X-ME-Sender: <xms:b7vRaEupoNO36hNNLNZdTRcnTZJwTtVV78uq3v6T_N6NMXXo4QAhuSE>
    <xme:b7vRaHcWOWfTWpjuvCsUNwUwWUZobvS3fbKu-thJnt309zo8mVfmxj6Z_P4Oy7CAJ
    eufGe1cdL8r3TGhXXSfHi4ps5G6b616kFOOcWNNKmBiVcb4PqFMug>
X-ME-Received: <xmr:b7vRaNZwelkQ6XzFRt0to8trUDFUVUWTlJCzJ3pRPitT9V196cziXXUydZt1ziRdCGLdwyLsFJu8lOdDyge-qPtnPYX0Eg4zGkw5fLeULq832cReo42aecne4Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehkeeklecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhggtgfgsehtkeigtd
    ertdejnecuhfhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhm
    rghilhdrtghomhenucggtffrrghtthgvrhhnpeetffelieejgfeuieelhfegudffvefgvd
    evjeevudekkefhffejvefffedtffdtfeenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrg
    hsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    gtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:b7vRaCWYpNutJYH1_ZOO3FpE13Hcjp78Zofv5LuTdnHJ7cNfc2183g>
    <xmx:b7vRaHiDqKceRdx1-IK0UCy42k2e1_jzsjKKNvXo5foU52GZAMGjMw>
    <xmx:b7vRaIW1FamsHuTERWSzbMmXAd-uurvSpLAJnvzLIrk7DK943E2EyA>
    <xmx:b7vRaGN6hAcN-7zDH8nuZvKC0VFmBUfX56ly0nlwZz2rxE1MnFzKsg>
    <xmx:b7vRaAE5879qj4r6OBAlNdr_Ta8Ket-kFED0zjmSqnqXGgG9c8cZZd2Q>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Sep 2025 17:11:10 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH 2/2] format-patch: handle range-diff on notes correctly for single patches
Date: Mon, 22 Sep 2025 23:10:23 +0200
Message-ID: <7f2487af433.1758574974.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.51.0.270.gdb73cbc1bc1
In-Reply-To: <cover.1758574974.git.code@khaugsbakk.name>
References: <cover.1758574974.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

No `--[no-]notes` options are sent to the range-diff subprocess in
`range-diff.c` when making a single patch.  This means that you can get
different Git notes below the commit message and in the range-diff
part.  (See the previous commit for elaboration.)

Use the struct member that we introduced and populated in the
previous commit.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    I’ve tried to conform to 6caa96c2 (t3206: test_when_finished before
    dirtying operations, not after, 2024-08-06) in the test here.

 log-tree.c            |  3 ++-
 t/t3206-range-diff.sh | 16 +++++++++++++++-
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 73d21f71764..831284288f9 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -718,7 +718,8 @@ static void show_diff_of_diff(struct rev_info *opt)
 			.creation_factor = opt->creation_factor,
 			.dual_color = 1,
 			.max_memory = RANGE_DIFF_MAX_MEMORY_DEFAULT,
-			.diffopt = &opts
+			.diffopt = &opts,
+			.other_arg = &opt->rdiff_other_arg
 		};
 
 		memcpy(&dq, &diff_queued_diff, sizeof(diff_queued_diff));
diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
index e091df6d01d..1e812df806b 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -707,7 +707,7 @@ test_expect_success 'format-patch --range-diff does not compare notes by default
 	! grep "note" 0000-*
 '
 
-test_expect_success 'format-patch --notes=custom --range-diff only compares custom notes' '
+test_expect_success 'format-patch --notes=custom --range-diff --cover-letter only compares custom notes' '
 	test_when_finished "git notes remove topic unmodified || :" &&
 	git notes add -m "topic note" topic &&
 	git notes add -m "unmodified note" unmodified &&
@@ -721,6 +721,20 @@ test_expect_success 'format-patch --notes=custom --range-diff only compares cust
 	! grep "## Notes ##" 0000-*
 '
 
+# --range-diff on a single commit requires --no-cover-letter
+test_expect_success 'format-patch --notes=custom --range-diff on single commit only compares custom notes' '
+	test_when_finished "git notes remove HEAD unmodified || :" &&
+	git notes add -m "topic note" HEAD &&
+	test_when_finished "git notes --ref=custom remove HEAD unmodified || :" &&
+	git notes add -m "unmodified note" unmodified &&
+	git notes --ref=custom add -m "topic note (custom)" HEAD &&
+	git notes --ref=custom add -m "unmodified note (custom)" unmodified &&
+	git format-patch --notes=custom --range-diff=$prev \
+		-1 --stdout >actual &&
+	test_grep "## Notes (custom) ##" actual &&
+	test_grep ! "## Notes ##" actual
+'
+
 test_expect_success 'format-patch --range-diff with --no-notes' '
 	test_when_finished "git notes remove topic unmodified || :" &&
 	git notes add -m "topic note" topic &&
-- 
2.51.0.270.gdb73cbc1bc1

