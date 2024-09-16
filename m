Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632D014F9E2
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 12:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726489703; cv=none; b=GDUvJfQ57I/h9m5eP0B0qp3jmK/mke8AfJ0TJ7lYcD2tadJDlBYXCUGD7nfJYEoh3SoW7jfy5DFxl684HjKvT1YHsJ5EHK9iY7tnEC8Fisl/FgqAc+RRO063oKhD1wD9X8tOd3gowd3DsQFBup1P3JC3g6jDexhGz9cjLn4mhm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726489703; c=relaxed/simple;
	bh=+DOZSTq/i4U7orj7fVwQw1eq3QJNrXkFYb3D1nF6/Ls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OYphtJG2ZZlyZblHND4ByNdHLHD3Q7Fdizho6Wzjikuikka+OC0MJDbM0yzR0HPKiwdyuEIpHMYiDtlxqmMYW7sQtI+Z7fh3R3Nf0NsGL0J6xP3uJKquLxi8YcWDQGkJ5arK00K5jQ+4dRJLpEZ5VIM7uFCbvq5JYdov+97pQkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Lt8dYi9A; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CWHjo4Bl; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Lt8dYi9A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CWHjo4Bl"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 7904113801DC;
	Mon, 16 Sep 2024 08:28:20 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 16 Sep 2024 08:28:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726489700; x=1726576100; bh=mDSWjPlscf
	zkzslwa+67kg5MWIFBL/Wc0iV116EuAnw=; b=Lt8dYi9ABqES9D2LnlguMWvKje
	Hc/R4Ccu7tdrDTPo8peSZhS1Kp9/2SWPzvZ4kgeLoW2qxgKkkn2vJAr68w0HKnCg
	ZYdV9Ub4M8TV4lB49xpagWch+O0B4WAtSb5Bd4SosKAijq0bB81jkuYi4wjLJeyq
	b6KfYs4+XZ7aS5QL4IyDsVl8w6waxCp0AdpLMRkYy2NzvS73u76Q4X0oE49a6Cpq
	ZEuK0q5yVecT/b2O8UKUznYMz254jZlUiEfkn5TYaBx4nh9jD0hY+IJDZHvX9Zwz
	Zam+WPbez3oTxQkPlhYjgNrgkwkr6BNEknVXa2T20b5qZa1V4HZ2WmKvu3vA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726489700; x=1726576100; bh=mDSWjPlscfzkzslwa+67kg5MWIFB
	L/Wc0iV116EuAnw=; b=CWHjo4BlR3hpoRvIPMdvhbL81oAtEQa532wGxSgtjZpt
	7lM9BVdI5sl7YGjwAGDIpDaaExwa0eY4fXRiAq+Q5xZcxc8dBnyAxfsi8en6PA1C
	RZXonFyEQqbqVg3QqcuWmt3eGCaw76S+En1agrO1MUeX/lIJREnoryT8HqIoGzJl
	UB/xzoQZOa/kweaa5RbB7msngyljkDqCu79iAdNoIIzALluDNrtPJ3WSzF3kzdel
	r9quqMXmczc1IGR8m+0KvRTMq3zck38+LB3XphEUU/nXPkEePcu60yKK7fpF8J8J
	dijzA0vdkezzvZYTdKAtnfltg6Y3r6EQ8Nh8LVq6Xg==
X-ME-Sender: <xms:ZCToZloPR4YF06_F8arw9e-elOwEi3Javqk6Mzrl5z0QtI92rDJtFA>
    <xme:ZCToZnqB-n6TzKekjYZuMKQvSoQNHMXsogljTIgw3vEp5-eyCKJNJy4V9iEUWlgDq
    ezI6E0VXr2NKp8Zsw>
X-ME-Received: <xmr:ZCToZiMV1UDrrkva3k5lcbSEQDIe3MCnOaywPiXFQQSnngG3FhPWYfP8QqK02YdmEdeD8Tccmyr0xsDHsRPFsV2F6tft5fhGKWeGrAqpDwF_4DqM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekhedgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegvthhhohhmshhonhesvggufigrrhguthhhohhmshhonhdrtghomh
X-ME-Proxy: <xmx:ZCToZg7e3iZYXs5XoewM8PDrT6lQGEVhuNVRsU5iEPMmalefX5P5Ag>
    <xmx:ZCToZk7kkN3OJ2RAyvdJqo9952VM_Jb2RgeSfIV-67PAL4pWAK8V0g>
    <xmx:ZCToZojlnSCbLJYwacmYztckNJBLgLXrMQdJAtIJnyZXgCXCL_-Y8g>
    <xmx:ZCToZm58cLu-ibLWisqSCNHRXIwBAxbuIBeLjVWgaM0rizln-Y1Z9g>
    <xmx:ZCToZkHtirtep07mxW3TxAKXjInO2gu5-RWZVfbLcdrwXt1dWILKUV0h>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Sep 2024 08:28:19 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6f756a41 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Sep 2024 12:28:01 +0000 (UTC)
Date: Mon, 16 Sep 2024 14:28:18 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>
Subject: [PATCH 01/22] reftable/error: introduce out-of-memory error code
Message-ID: <8c99ecc3255b1b10cdec047da01804dc23a7d287.1726489647.git.ps@pks.im>
References: <cover.1726489647.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1726489647.git.ps@pks.im>

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

