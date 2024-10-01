Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E65A2B9B0
	for <git@vger.kernel.org>; Tue,  1 Oct 2024 09:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727775713; cv=none; b=CZSwXp8Jm3t9jWxmM4tkIPdFVkIoKy+h+AGIIqR5eWg11XOxDqQPZKD/AOTwv+n1dWJBPPVrAJ1C7So0Qwb4IeECTUgvB5+LMNmBa5tTAvWVjM2f8BVSw0YtkxvgDQv8siPBa9BI/LxQFbO2kKmBmF89Ay2WVnsBnb5W1fWzfoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727775713; c=relaxed/simple;
	bh=r/wNwOqsurCUQapI5uCBonlpAYPKOJda2FJDht6aSDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bQxKTeIZKlu0S5CXCIltECVeNlFtAq5ab5H4GLZsW/X8KTh0ebM5PlCcre+2qDNZ259ct+w1IwynMk+xlKFyNO6qSdc0/si1KYuSLBxTCQ/SQsdj/eNqfFFcUbcmUIXk+IePifQS5P60JHNvkxR6VVfQmDUgICHBgRHcLaR4qE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gG8d+jLo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dVUy78/B; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gG8d+jLo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dVUy78/B"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id EDE171380F24;
	Tue,  1 Oct 2024 05:41:49 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Tue, 01 Oct 2024 05:41:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727775709; x=1727862109; bh=KfSspmcjDG
	ZrR6/wFCt+5RT2Kk+oo/sOeOkgThDD4pI=; b=gG8d+jLooPzvFpfvPE3XPgph40
	zPgU+GeFA4pKdl4vY7RPm3O0I0oIrLk6q/HbOWbLMWnD8znTMTIUa/G5eHignwhw
	OIb71o0ro/j7L2eg7RWm4qQ431GftCwYqM4gaxIM1SzVYrD2lPhJaFnOR5goi8Ed
	NymjGldEWeqDKapit6ugl8k/gdo9CkeoDAgGtpujci0/QE4edgqDF8Q4bmYS1GEZ
	1rPstITVV0jLpsz3mn6Abx/VsVTsQbK1L6TExe1c8XqgGqsKx69fYgY1Iz7hWVAh
	G5t3Lum/b2N+Fynalw4HIpnxbTPcR88q0ZWkiQJwJLsSO7clJTOYr1FhC2rw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727775709; x=1727862109; bh=KfSspmcjDGZrR6/wFCt+5RT2Kk+o
	o/sOeOkgThDD4pI=; b=dVUy78/BDTq4/hvNcPnZPDYRG+nQ8FUBkgMdjuoDBCOG
	p9N06Hey8qVbomSw6D6jKbi5KM8e/03PVGe+xSh23mHfuOc4D0jqKrpfEV0CGJ/q
	tWrA0JGWE++i0Jdr/XxrWWNoYbh1py8CSlPb/CNp4UOPJu+AWu1VPVDpIqcrrJsH
	2yInOYyxW8zMTxCV/O5BHg0aVCGu1TXGL/RLP2KhTU52WxUlMOx0zw4TTcyN4ndY
	cf8EZQ1G4fgS7djgXglyPitlhHGVih9hjkQMOKFLkDmyy7wBNA+GICDSnuLgrgcl
	m+8uKc5RJowlhAfk2BGd/LqaN860FRtdxIHrwVqqYA==
X-ME-Sender: <xms:3cP7ZsTmScikONYDbcHLn8YSDpnJgVOQmLaM-AnntmEJV2mTmx_hEg>
    <xme:3cP7Zpx1cala-bdxaGz1G67gl9WKI7omqfCQ-PgDHxXNwQ6FiVuPYSPTURY5qc3bC
    Y4GoEjHpcPOPkXamg>
X-ME-Received: <xmr:3cP7Zp2TKcCFFKHqTihIyFbl3XyWJ4JH45YO9H4TYDJVyLrw7BrZGR1-qLvnWWKN1KXgq5ECIFI-LjrRgh8chVuOsEXUOA1iMR4drZWfBLXw_w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddujedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegvthhhohhmshhonhesvggufigrrhguthhhohhmshhonhdrtghomhdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtoheplhdrshdrrh
    esfigvsgdruggv
X-ME-Proxy: <xmx:3cP7ZgBU8quFA0Y3H5EqDJqZ95Z0j5W-2GItw0asQ20_2UKyTE6kRA>
    <xmx:3cP7ZliI6ZkHdW6TXdPdcP4ccB864UYPkC0yT9ej0U7BL7DhFF8cvg>
    <xmx:3cP7Zsq59NqJFgR8pwR3FuhhF1L-ICGOBlncmotT2x0kW7DRi-Sjfw>
    <xmx:3cP7Zogo9P2aWct3sCH3O3GN2VRToq6FBy0ZVsn90VAl8j7XzSLHDg>
    <xmx:3cP7ZldAPwo4tZXY9pfN0iUhyYiu77efChC97NdxQmN7w4bOcGXgqi89>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Oct 2024 05:41:48 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4caa2296 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 1 Oct 2024 09:41:00 +0000 (UTC)
Date: Tue, 1 Oct 2024 11:41:45 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v4 01/25] reftable/error: introduce out-of-memory error code
Message-ID: <94eaef3ae5ee008b5140272e4ce572c041f9c5a2.1727774935.git.ps@pks.im>
References: <cover.1726489647.git.ps@pks.im>
 <cover.1727774935.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727774935.git.ps@pks.im>

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
index a25f28a43e..660d029617 100644
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
index 6368cd9ed9..f404826562 100644
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
2.47.0.rc0.dirty

