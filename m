Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417D017F505
	for <git@vger.kernel.org>; Thu, 22 Aug 2024 09:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724318263; cv=none; b=oQXN5o7PCWuBAboRpMXYQhb3QFRWNij3qbjHXmSXIPl4D3pH6f+5tPBGZfxQpTSNAkQ88+bz7THbdCMjMzqzgW//MqxThhnzTURDT9LbXFrHT7H5cQb7dUjqlya9lkBUrgqJFsqXr+vXsKJGayKtfcrAWqniHEcc1KSQMBMeJko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724318263; c=relaxed/simple;
	bh=y8K1KjuELFVbwthYQp2OWFJiyd6MN6eKlIY3ZWYPOlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NMOK/YQkIKIwpeZtf3JbSjQeLTtEjUkE27526O77VM7MRx2KQTCEvfdqc/IR7sZoge2xcOUZfAXyLuAOvYGGP3C51wVvlSuBX2AudJGzDLEc5StLtvkfc1ex7wVkWqz8rOr2J82vQGyYgXba/ngDUBFmf9toMd4APh743YSzDXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YQYTaq5v; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CDHHQURq; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YQYTaq5v";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CDHHQURq"
Received: from phl-compute-01.internal (phl-compute-01.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 723E41151BB5;
	Thu, 22 Aug 2024 05:17:41 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 22 Aug 2024 05:17:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724318261; x=1724404661; bh=O8QXy96Qtf
	R6mQErCqM+V1HmQQkJtD/I900UtsWbPr0=; b=YQYTaq5vwDYIt82QJDmmVUv6yc
	/1uDx5eSB3bKlS6NdNkWomrvlWsDvgl/BVYC2rLb06K2P/kIhqyqeoyvYUImOxad
	342gxvP2ekoYk0dVq8HeAcKoSxXGL273h+WiyktLq9Pk6zfWBF9KLgOV3JwwaobK
	ZeiLqwWzYUv8Y0BHGsR3SUmR4ZKkBLuPzh8dFUpBu+J/VB6+gOp5OoOSsStC/sjA
	88fnViRCxM8cE/7SFYUD0JzFFthuVrDIlZ/dOgM6tHYHTnWmLt/UiLx9ZFqR5QLo
	EIyuv8qWsmxtG3NLJdJZFnqGxdKNpWn5LMaleYZt7Dj191u+dsVbVvcM4WRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724318261; x=1724404661; bh=O8QXy96QtfR6mQErCqM+V1HmQQkJ
	tD/I900UtsWbPr0=; b=CDHHQURqz4JIJKM8GmeqrKXNxuFlcx1edEyMoH8XXKNw
	JFOnwCTNS3HyrGH2M3B1t5tKmZj6Swl/DvVnNb2k4RBAKjqQqv+WJfrDb3PpPPNO
	RY/9qVGm+EpPh7mmtfbEdc3lkzszk/sYXx6RXLmUhrzXeiy+gO6wEA5c9DFN2Tqv
	ugO8bdS6YB1q9czNTmfYoYydxJPhMeMH3bsQwEco4RqKnex95y+CydJ7xg13SS/4
	8+AMgkvam/UcGOInXEbwg8iA9GjSZMxn3L5Eo9KxaHOBwtTInuCjlcUzWvfCNLst
	4VNBPnQeMo3m4YhEwTh0iRIWeHZFNFrrZAoGkv5U3A==
X-ME-Sender: <xms:NQLHZv8fC-D1pxmC58L_IhXYUyhGNGDIKbvYciYPB5BdyVGqPjDgTQ>
    <xme:NQLHZrvVhUxusEgeDiJpUDCR21dK761Sr8CevAqmtQl9b9jqtEJK2GLQ6FafYrv2V
    PG5bjqrkCr6fozJIQ>
X-ME-Received: <xmr:NQLHZtBaxvy62FFTpsUdNSAh2F9lbNSSyzbC4HNSqOeis5UfXgpUcQOLAp9oEjO1LADPs6ejulxhY11QlwU3TmIX_hY1baEcR0B5JA-3O8TRwkI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvtddgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:NQLHZrf2rjJaWQpEaLPyURBc2kuy-516i-kfUm-QrJYudv1Cq7uHgg>
    <xmx:NQLHZkM6HyWg4GaFb-LA9gtz_pXwTUSkRdNuBW4sLysFa7A-tyh16Q>
    <xmx:NQLHZtmcTi3zvnoaqrdx3Oo9c9mabl6Gp1jbcmVwkpOnoa_mCTmVEw>
    <xmx:NQLHZutPDSSaSMrQhuJMO3z55WX00oUSDbQsK87GWXZdqD1s0V__Hw>
    <xmx:NQLHZtYssPNu0AU5GZKXBtlHVGQCXTMlEbmYIDZCE5VxuOpEbIr5_NEx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Aug 2024 05:17:40 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id cbf20266 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 22 Aug 2024 09:17:05 +0000 (UTC)
Date: Thu, 22 Aug 2024 11:17:38 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 10/20] t/helper: fix leaking multi-pack-indices in
 "read-midx"
Message-ID: <48b60279d18ced93614c15772a9344ab7e337b6f.1724315484.git.ps@pks.im>
References: <cover.1724159575.git.ps@pks.im>
 <cover.1724315484.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724315484.git.ps@pks.im>

Several of the subcommands of `test-helper read-midx` do not close the
MIDX that they have opened, leading to memory leaks. Fix those.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/helper/test-read-midx.c   | 8 +++++++-
 t/t5319-multi-pack-index.sh | 2 ++
 t/t7704-repack-cruft.sh     | 1 +
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/t/helper/test-read-midx.c b/t/helper/test-read-midx.c
index 69757e94fc2..438fb9fc619 100644
--- a/t/helper/test-read-midx.c
+++ b/t/helper/test-read-midx.c
@@ -86,6 +86,8 @@ static int read_midx_checksum(const char *object_dir)
 	if (!m)
 		return 1;
 	printf("%s\n", hash_to_hex(get_midx_checksum(m)));
+
+	close_midx(m);
 	return 0;
 }
 
@@ -102,10 +104,12 @@ static int read_midx_preferred_pack(const char *object_dir)
 
 	if (midx_preferred_pack(midx, &preferred_pack) < 0) {
 		warning(_("could not determine MIDX preferred pack"));
+		close_midx(midx);
 		return 1;
 	}
 
 	printf("%s\n", midx->pack_names[preferred_pack]);
+	close_midx(midx);
 	return 0;
 }
 
@@ -122,8 +126,10 @@ static int read_midx_bitmapped_packs(const char *object_dir)
 		return 1;
 
 	for (i = 0; i < midx->num_packs + midx->num_packs_in_base; i++) {
-		if (nth_bitmapped_pack(the_repository, midx, &pack, i) < 0)
+		if (nth_bitmapped_pack(the_repository, midx, &pack, i) < 0) {
+			close_midx(midx);
 			return 1;
+		}
 
 		printf("%s\n", pack_basename(pack.p));
 		printf("  bitmap_pos: %"PRIuMAX"\n", (uintmax_t)pack.bitmap_pos);
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index ce1b58c7323..fbbc218d04a 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='multi-pack-indexes'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-chunk.sh
 . "$TEST_DIRECTORY"/lib-midx.sh
diff --git a/t/t7704-repack-cruft.sh b/t/t7704-repack-cruft.sh
index 959e6e26488..5db9f4e10f7 100755
--- a/t/t7704-repack-cruft.sh
+++ b/t/t7704-repack-cruft.sh
@@ -2,6 +2,7 @@
 
 test_description='git repack works correctly'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 objdir=.git/objects
-- 
2.46.0.164.g477ce5ccd6.dirty

