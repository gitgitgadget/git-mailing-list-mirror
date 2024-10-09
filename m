Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E676F51C4A
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 14:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728485775; cv=none; b=mBvNH43Qn6tzAafxaVhUrEfdqv5u+I2LIa0jJ/hSIsLMxNY+Dr9HdEBbzEy4wLOdAUR2Wadw1RlFrwvnM041kYO9P21RKQVMhQibJYMFIgK2ZETNxzA5nqreiP28+HxpxTQgq/0b5akANkStLt9WydQLrJcwL2C+F4VK9hPRYOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728485775; c=relaxed/simple;
	bh=paSFZ05liBNpHKqAvhgdsyM2GqWzxE5voV3vahklk7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZEd281+gwkNc80WLQz0Y1f9km5J6CgrrfzW6gpN2jkNfQYE681P0I5VxpOWAMFUMpVgUGqRHJAJRxxnosS9jCfaKT7VTCrbRCjrjdGUa4pOKL2x2FaJt96Dw5iCbh5Oni/Q6vbZFhCbdOzDHeLloS7cRE0nZp1pZH/q4sZN50sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AG2kZxvX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BPdOM1f6; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AG2kZxvX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BPdOM1f6"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id E34F213802D7;
	Wed,  9 Oct 2024 10:56:12 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Wed, 09 Oct 2024 10:56:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728485772; x=1728572172; bh=m2QGW9uE9Q
	RP9oajWG1llf+ZNnW+hp9n375a1EkXJw0=; b=AG2kZxvXPPOIXw5DpUvzuY+5l8
	fqGUMJKz/bK9/VVd04cLaiebuIunWzpyt1EPnTgUrxfQ6SCqZt13AxhNS8JgZpga
	VvqLxmrQ6rNTa82VJcuIFzKWHGymwTCHXPRBNBhGIB6FweFs1sWxgcn6i6K/ZaQW
	u/XCi8/0XpclxZdnRHfxLll7tEw01ULl6cAIGp94DXvBiqAMgDUF7JqGTB1v2rKi
	cZlZ6n7T5Fdfj1jeSS5yyZOrINKwV/VsrdHrdb98VlCc7yreKdIORKvHuXqhCiwo
	XxRjbVinh+Q1a0wCsWGI1V2HryCsM+kcVZllHN8ryWcJonLPaUfckJe5xj0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728485772; x=1728572172; bh=m2QGW9uE9QRP9oajWG1llf+ZNnW+
	hp9n375a1EkXJw0=; b=BPdOM1f6sJ/A405RCep7pcT72GzFko0rsVXalm1lrJmY
	g7UVM2ItUuhruoyFmecw1mzwe0/ZmB4KkcP8x/vzEHyNWB3eKmyI+BVlw9XXCM68
	aUALAEBEN1L1BBi1ug076dyj4BOx9EGZF1T3IdKPvBzawT8/UORUZxZek0dbI0fX
	nnFrhDZLW966X/tyUtsv7PmHIaNoOI/ZUJq1uZI2Bzm19B2Rf/DHkUWhqNAI2fEt
	NiD0EmTNoJzJ9OU+VNan8EkGnXn/1P9UBHxE/N3g9fkC9rnc+wF734Ucflur9KCN
	CPUYYbmlENNHPB5DnVrcg6SU7ydb35oSlfeTeqRIfQ==
X-ME-Sender: <xms:jJkGZwyrPmQSpU49nvu65upVKhMarqCz0USRyI3Bkd653jQ3KtdMBQ>
    <xme:jJkGZ0S4YVv5Mw5a3nq5aa2bouus4SWSG1lflYaZ2i2To9-x_RnDTchgFFT_jgx15
    3vqMN4m0V_0z8NaUw>
X-ME-Received: <xmr:jJkGZyXlOIJ4Foju0q3IsPT_rRjZGWdmCOErl7lhBcX9nAKmYUPhpQftokUm05m-7pIslwuNFttIXjP1FehHn0JBYAbPSQTkvGi3Z66vxc5u3A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeffedgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvghstghh
    figrrhhtiiesghgvnhhtohhordhorhhgpdhrtghpthhtohepphhhihhllhhiphdrfihooh
    guuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhs
    hhhinhgvtghordgtohhm
X-ME-Proxy: <xmx:jJkGZ-g6GCkpjdIGyDexSExyW21gs2mZDU-pqpfdkRnxR4p4WZ4paQ>
    <xmx:jJkGZyBJYf5u44tZ5xZWI4LlTb-3NL5S2onAw9t-dc5P48K1uZ3vJA>
    <xmx:jJkGZ_J-hWFTGj9YJ7E40FnzP_h6Uqe-lf77vp3Eg_eDb1HKxeFIwA>
    <xmx:jJkGZ5AKmsvHVm8J7qS0LpaKQb8E5gf6ZSo-_Wtg5yarm6bGs7qISA>
    <xmx:jJkGZ5431ymvHCT0S_JNPPD2v1brgljMULBy1_xcxckmxly2JAmnOFuu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Oct 2024 10:56:11 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id fc26a518 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 9 Oct 2024 14:55:08 +0000 (UTC)
Date: Wed, 9 Oct 2024 16:56:09 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [RFC PATCH v2 01/24] t/test-lib: fix quoting of TEST_RESULTS_SAN_FILE
Message-ID: <6dd59db9b2b0aed6a5156a7bb4098776b1d4cb88.1728485139.git.ps@pks.im>
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

When assembling our LSAN_OPTIONS that configure the leak sanitizer we
end up prepending the string with various different colon-separated
options via calls to `prepend_var`. One of the settings we add is the
path where the sanitizer should store logs, which can be an arbitrary
filesystem path.

Naturally, filesystem paths may contain whitespace characters. And while
it does seem as if we were quoting the value, we use escaped quotes and
consequently split up the value if it does contain spaces. This leads to
the following error in t0000 when having a value with whitespaces:

    .../t/test-lib.sh: eval: line 64: unexpected EOF while looking for matching `"'
    ++ return 1
    error: last command exited with $?=1
    not ok 5 - subtest: 3 passing tests

The error itself is a bit puzzling at first. The basic problem is that
the code sees the leading escaped quote during eval, but because we
truncate everything after the space character it doesn't see the
trailing escaped quote and thus fails to parse the string.

Properly quote the value to fix the issue while using single-quotes to
quote the inner value passed to eval. The issue can be reproduced by
t0000 with such a path that contains spaces.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/test-lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index b1a8ee5c002..241198ba95f 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1572,7 +1572,7 @@ then
 
 	prepend_var LSAN_OPTIONS : dedup_token_length=9999
 	prepend_var LSAN_OPTIONS : log_exe_name=1
-	prepend_var LSAN_OPTIONS : log_path=\"$TEST_RESULTS_SAN_FILE\"
+	prepend_var LSAN_OPTIONS : log_path="'$TEST_RESULTS_SAN_FILE'"
 	export LSAN_OPTIONS
 
 elif test "$GIT_TEST_PASSING_SANITIZE_LEAK" = "check" ||
-- 
2.47.0.rc1.33.g90fe3800b9.dirty

