Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7408512BEBE
	for <git@vger.kernel.org>; Mon, 26 Aug 2024 07:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724656899; cv=none; b=s+KU2XXYyD/PzGK3pQUpVqKvZVyyHOPKrYKrDXfBh5LXu/xV+F+XqXEhD1QDdMOGy49xTQwiq247ByO2dHbEmPDn2F0UB1dnV+LYPynNOEy+6Vws07FhSlneJtDkGKVahAtU7CCYnplhsrOfsFxZHKYwCGSJ3/qCwMm03WDc4GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724656899; c=relaxed/simple;
	bh=A9npNwF/yRJLqELhzBSJ/Ubsla2v2Qw2CgevVYLQQ4s=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=reC7S5VKH4l+tFiZx1gaY630cu9xEZHJoGUZnxrMnjem4t7JVbxyKsivP4zpcjOw6TFuFXMKnJYUIS7Eg87HEkkmz6fmbF7iqdVAdnnvFqJuhATX4KcyN4xyId3bT5mzzDo554tlRpUNv6YmBzaKZTeDQIyd2U1yislk5CfV12A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pB2byqsm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ehq4/ghA; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pB2byqsm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ehq4/ghA"
Received: from phl-compute-02.internal (phl-compute-02.nyi.internal [10.202.2.42])
	by mailfout.nyi.internal (Postfix) with ESMTP id 8C3C1138D359
	for <git@vger.kernel.org>; Mon, 26 Aug 2024 03:21:36 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 26 Aug 2024 03:21:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724656896; x=1724743296; bh=Uar4YhMX+U
	YOZjWUqQbJ1jeFZP4xpYukUxlS5i1yG1s=; b=pB2byqsmNGhv6m07Ni+HfrxADG
	GGzcU3aSKDdQ3A/FkyRN2AKybP4hb/Iftpn4qlBQTvG1kfaLHUahAzsa5IQG85Hi
	Xj9ioxrTvacqELsAX9Y+/neJnMQHKzm7WfkGWf7Sm4WNQG4JfvxfLv27/jSrHy8P
	qDWOi5TJwUN46M6nsPB55qRF3I0MP7lw+AAzg6y9aXjPJDI9FLJC5bC2TMbwqZ5s
	ARp1askuEdN0HfWmaSB6vgp11HUunrfmDLjE9quCa82NGqjYef2mCP6PNV/jXBJe
	lrplG85WvzJhUkEGlOjMpA3osSjEPfB6NpFrU6qEuvLpYEPk/touIUvXYE/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724656896; x=1724743296; bh=Uar4YhMX+UYOZjWUqQbJ1jeFZP4x
	pYukUxlS5i1yG1s=; b=Ehq4/ghA8p9oPLoxqUAAPAv/KB7UQSu2D1aahpYpOV+Y
	Jl8hvOdT318tjTBIdLR05keNkAF/+tUg2RhkRL6nXblTLCQQkP8jc24qfA6iElMm
	PMLlPyzLZ9R40NIgoWeERJh7ueg3HGOmlW9mod8jF3kkjJ69Bcahcc60eRArks1O
	oP+x4LCUMuXdfiPlaFH7Jj/n5NWQ9yrYTXA0baYRaUMbjsqikSJJ8h9njqgWUfn7
	3Vol4HBVtwDKnV6aMdnpkReR9+3V6Qb0FH3VX+aPmXI8RdibxQ/3NjD2PrY/zcGJ
	w7dxERWMABiYYWNsaZlNsYoNHYJRAne2NUy53AHvcw==
X-ME-Sender: <xms:AC3MZhWn_RvxsC5X8wFQdBkymy2YtVhdHBxcPp8kEeoF08sHFZltcQ>
    <xme:AC3MZhkeb1RRNtDdNCXqQ9Ltp2vjaUkzm7M17lGeJbDxo85wivYCBZZdJmTkMSz6d
    nX97ZhKklgI9qjPNg>
X-ME-Received: <xmr:AC3MZtaexixA1jDq2pVdMrvHvvojyRd3oR7_n4iS4UTu9ExVJshfVRRPyjUASHv6BW_ril-Xl8Z_pgO-bkhC8PbrNr-VaUhQUbTuZm8FtBi4YIs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvjedguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeehkeeffeegge
    dvgedvfeefheettddtffejuefflefggfehfeelffeljedvfeehieenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:AC3MZkVRccm7u1d_LxGzW9Lzg9BYVJCVqXstE2MhbLXKDRr3eOZIMQ>
    <xmx:AC3MZrlcI5LAKrrpaKGEvHxWnSCK6Z8NctAuSVJqOdDbVDgXRYjVZg>
    <xmx:AC3MZhdNz2cg_FklF4LT66sVpEZWwUlj3TB7UVn3aFDY-GaWBxfn2A>
    <xmx:AC3MZlEOWOiRbuwVpZxvklZQcffiVgBiYD7EzE4OavmzqtGSDfXaTg>
    <xmx:AC3MZjtgZQ5txV7QyNORshqmGPuKRl_76pzNrTR5PLVrjnWo_9UmyLik>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 26 Aug 2024 03:21:35 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 88a2f1df (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 26 Aug 2024 07:21:34 +0000 (UTC)
Date: Mon, 26 Aug 2024 09:21:34 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 01/22] t/test-lib: allow skipping leak checks for passing
 tests
Message-ID: <7c158acadf40b44edb3cf186860a3f60818f76f0.1724656120.git.ps@pks.im>
References: <cover.1724656120.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724656120.git.ps@pks.im>

With `GIT_TEST_PASSING_SANITIZE_LEAK=check`, one can double check
whether a memory leak fix caused some test suites to become leak free.
It is somewhat slow to execute though because it runs all of our test
suites with the leak sanitizer enabled. It is also pointless in most
cases, because the only test suites that need to be checked are those
which _aren't_ yet marked with `TEST_PASSES_SANITIZE_LEAK=true`.

Introduce a new value "check-failing". If set, we will only check those
tests which are not yet marked as leak free.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/test-lib.sh | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 54247604cbc..64bd36531c1 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1558,8 +1558,16 @@ then
 		passes_sanitize_leak=t
 	fi
 
-	if test "$GIT_TEST_PASSING_SANITIZE_LEAK" = "check"
+	if test "$GIT_TEST_PASSING_SANITIZE_LEAK" = "check" ||
+	   test "$GIT_TEST_PASSING_SANITIZE_LEAK" = "check-failing"
 	then
+		if test "$GIT_TEST_PASSING_SANITIZE_LEAK" = "check-failing" &&
+		   test -n "$passes_sanitize_leak"
+		then
+			skip_all="skipping leak-free $this_test under GIT_TEST_PASSING_SANITIZE_LEAK=check-failing"
+			test_done
+		fi
+
 		sanitize_leak_check=t
 		if test -n "$invert_exit_code"
 		then
@@ -1597,6 +1605,7 @@ then
 	export LSAN_OPTIONS
 
 elif test "$GIT_TEST_PASSING_SANITIZE_LEAK" = "check" ||
+     test "$GIT_TEST_PASSING_SANITIZE_LEAK" = "check-failing" ||
      test_bool_env GIT_TEST_PASSING_SANITIZE_LEAK false
 then
 	BAIL_OUT_ENV_NEEDS_SANITIZE_LEAK "GIT_TEST_PASSING_SANITIZE_LEAK=true"
-- 
2.46.0.164.g477ce5ccd6.dirty

