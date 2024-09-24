Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80C29479
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 06:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727159519; cv=none; b=rnP38DvYxxUwcoeKXL59TYV1TnfVkTYCmMNvoA0v5JncJ89wneftVwvrFV8pcw+tsSQz0lAZL/G0k5eq7/Z6JBHXcu9lzH6s/PgtXno4ZgDSkTEmAFLVAabHe1HiZ/vSZkEI03UXF2mzWTLqKWQrFWQ/lTdrgaf69Y2pa7iA/G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727159519; c=relaxed/simple;
	bh=+DOZSTq/i4U7orj7fVwQw1eq3QJNrXkFYb3D1nF6/Ls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=orGbOmdNnCm6OaCuTPKABl6y29Y1BOqDKzOBbCdHEGEUEEd/TYi03uKYLm+QkJqabDKmu0U9oM6h2/qazekcEW3QydSZOSPTjMkGWoR1tcU4hj+0BmQVctGg/PUw9n+58aw+L+CuoenKYx+1vHoUoKCMEDMfxnW6hqpvx7Ts4bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=apO9v/pJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PFc5Rcrt; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="apO9v/pJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PFc5Rcrt"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id BBEBC138023D;
	Tue, 24 Sep 2024 02:31:56 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Tue, 24 Sep 2024 02:31:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727159516; x=1727245916; bh=mDSWjPlscf
	zkzslwa+67kg5MWIFBL/Wc0iV116EuAnw=; b=apO9v/pJPGA6S2NkNFKe9tLnPP
	G95VY7QFudJMRlZnG2VThbkFCJWJgPLXDan/f5z6sFdV4INgbC3hBZbiRsirag/b
	8AlaXwgKJGS6ilkOGveMNaUGPmc/14DQsBf9lAv06cto+MwMbTYEd83jAWf1fxl5
	0MMvcS7i0gKTwtWbWNtBeSSZrt6ArkxyeUDHKc+OC7s6b9EuApvZmG9E1ujNOBou
	frN0dHwachGVEmlv4CJcj1vbpboATaDJXWqp/RKMqYeUIQAw7Wb2nybZ7CiQ2C68
	H41sf4Xsaw7T/wvzexnOGywgB6yn+2xVVVEShode2bB1hf5hnKFG8uaKoaPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727159516; x=1727245916; bh=mDSWjPlscfzkzslwa+67kg5MWIFB
	L/Wc0iV116EuAnw=; b=PFc5RcrtRUEOg17lui4TQ21b1tnENNG+FDex0CIwwfSR
	OJRKJg6tFl5tihrV9Ur8FShC3RtfuHG0d9Q9MZ824NNRFdpwIPyw9iF/jTNjjlbz
	1V3GP45NLMkgH8SWvvzFF7aAKrOQqTpifs6881LBGjEd7sGTeGfKzQUYlj3OYqCs
	rexCG1rEVnzxTcsUP7AQfDOwhGowwUorbaBA50TplPY1snnBcrg5mH92dEBW6Qf2
	XmMooRBzYjouddWm56OqU89RyuxgtPNyVDYu/cQbUNQvf1vQvPNKirhsvjflPM9x
	uC+zH+KhGbBg44QyIPd6W0iYSpOACZzTYKqNGqL7xg==
X-ME-Sender: <xms:3FzyZhU1JvO5mK17qoF8igpOlk4yG9PBVMrIC_ZrIJmKJFzTmhXzuA>
    <xme:3FzyZhmUR0iTFcBz_H-2GSxGeiSUDKp1ODsGDh_fgw1fEjckzakagU8Bnw9JVls3H
    cntPNIMVxs7jgYMPg>
X-ME-Received: <xmr:3FzyZtbc9EH_BUS9-HpmnfukjjamuL_m2QLxWPut4kqc0p5jqtOkoBcGH2bcISP6dCx524DW1l4aSyo41dZh-KNg1UFtlMxpxfimiJy272KtMg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtuddgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvghthhho
    mhhsohhnsegvugifrghrughthhhomhhsohhnrdgtohhm
X-ME-Proxy: <xmx:3FzyZkW31YEHXiU1B2_pYdaUk_rsEJ80f9-I6SRY3BVcbevzItP5hQ>
    <xmx:3FzyZrnKhlA2t1PlDImdaijUKk8HlW9euged_piiJbJN4fPgjM3kMQ>
    <xmx:3FzyZhcj-TRMhSQfR8AiZ19YE9ab643RpqPIRo2RtFNt8CZUxPV4zg>
    <xmx:3FzyZlEsbCHoFjIIUHqv9N6eE3sT12rbkzu6CpMmGxv_otSRqBTYJA>
    <xmx:3FzyZpg05NFlp7ZIuGu3E82CkpNFFadV17AZi9uhsqTOyfbvZTQwhWM_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Sep 2024 02:31:55 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ddaa90f5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Sep 2024 06:31:22 +0000 (UTC)
Date: Tue, 24 Sep 2024 08:31:52 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 01/22] reftable/error: introduce out-of-memory error code
Message-ID: <8c99ecc3255b1b10cdec047da01804dc23a7d287.1727158127.git.ps@pks.im>
References: <cover.1726489647.git.ps@pks.im>
 <cover.1727158127.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727158127.git.ps@pks.im>

The reftable library does not use the same memory allocation functions
as the rest of the Git codebase. Instead, as the reftable library is
supposed to be usable as a standalone library without Git, it provides a
set of pluggable memory allocators.

Compared to `xmalloc()` and friends these allocators are _not_ expected
to die when an allocation fails. This design choice is concious, as a
library should leave it to its caller to handle any kind of error. While
it is very likely that the caller cannot really do much in the case of
an out-of-memory situation anyway, we are not the ones to make that
decision.

Curiously though, we never handle allocation errors even though memory
allocation functions are allowed to fail. And as we do not plug in Git's
memory allocator via `reftable_set_alloc()` either the consequence is
that we'd instead segfault as soon as we run out of memory.

While the easy fix would be to wire up `xmalloc()` and friends, it
would only fix the usage of the reftable library in Git itself. Other
users like libgit2, which is about to revive its efforts to land a
backend for reftables, wouldn't be able to benefit from this solution.

Instead, we are about to do it the hard way: adapt all allocation sites
to perform error checking. Introduce a new error code for out-of-memory
errors that we will wire up in subsequent steps.

This commit also serves as the motivator for all the remaining steps in
this series such that we do not have to repeat the same arguments in
every single subsequent commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/error.c          | 2 ++
 reftable/reftable-error.h | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/reftable/error.c b/reftable/error.c
index a25f28a43eb..660d0296170 100644
--- a/reftable/error.c
+++ b/reftable/error.c
@@ -35,6 +35,8 @@ const char *reftable_error_str(int err)
 		return "entry too large";
 	case REFTABLE_OUTDATED_ERROR:
 		return "data concurrently modified";
+	case REFTABLE_OUT_OF_MEMORY_ERROR:
+		return "out of memory";
 	case -1:
 		return "general error";
 	default:
diff --git a/reftable/reftable-error.h b/reftable/reftable-error.h
index 6368cd9ed9d..f4048265629 100644
--- a/reftable/reftable-error.h
+++ b/reftable/reftable-error.h
@@ -57,6 +57,9 @@ enum reftable_error {
 
 	/* Trying to write out-of-date data. */
 	REFTABLE_OUTDATED_ERROR = -12,
+
+	/* An allocation has failed due to an out-of-memory situation. */
+	REFTABLE_OUT_OF_MEMORY_ERROR = -13,
 };
 
 /* convert the numeric error code to a string. The string should not be
-- 
2.46.0.551.gc5ee8f2d1c.dirty

