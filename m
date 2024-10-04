Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1311E3DD1
	for <git@vger.kernel.org>; Fri,  4 Oct 2024 15:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728055950; cv=none; b=gHlFCqVWQM1Bw3ijGy0ayUQrcuO9HC8LtiLx1AfFf3HkiHLARPlVmML6/lv/jeRLTpsF5JLtoldM4SzNkounEqLBYn3EBJOzE3JMks+0nbbhBxrAU39nXIKbqV5EISp53Pgmlwl10eJ4cFI7Twj4fjpBC0ha+q2TKkICqitwKrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728055950; c=relaxed/simple;
	bh=b2TYwpgjA9b6S02IRfPDDV+nV55gnctoBbMZL9xjlgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oIAstCOTbJxTUh+TZtutqHgZLsZY2D4eFp8lwuZiqsygITuHVCjea8qN8FaeJcVRi9Op4e+IsMcJnuoYswBTkqDSDakef0DXIlo21oWhWuaY/TPO9jgUqhP7frBsxqgaBaEcgORDRw2CyTnqQiy1sDbEcn8ipWA6y7BTvNlsSzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CWXnp51s; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bCGv45t9; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CWXnp51s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bCGv45t9"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 7E0B41380151;
	Fri,  4 Oct 2024 11:32:27 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 04 Oct 2024 11:32:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728055947; x=1728142347; bh=qDFCLKdPrT
	4o2M7ntTYpMYtX9CPcJKTOHW9z6UqQ8ZE=; b=CWXnp51sTnkVJdz1mae+1F5N/3
	Lde1Bg+Mi2w4VG/nWSL7GIKb3ltBX/yGsVpRH2gK/+rwslTK3kpCkk6Z9Fwr8LmI
	H15oT4fkuEOD5ddo6Tux5NNIozFN4ucKSDdrWOq1GDi/nYDqHUspRkzJXVrpMdQu
	eV/+4md8kQygyMTDM+IqUjYZDDHhMPhmyOfapGihQGEfNJe8DJ0tHan/I1fqS+fr
	8A19OJKTggjVQ8b+yOQZMGlez/WpZXfZz+0kgA2AvlDBQDOgl3QCtgY0lvNAMYMy
	Bim/iGA5AZGDnoKB89ZuVFmo+z/iXAE1Fpm3iRJcpxkrKoWBLsRu/2gAR6uw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728055947; x=1728142347; bh=qDFCLKdPrT4o2M7ntTYpMYtX9CPc
	JKTOHW9z6UqQ8ZE=; b=bCGv45t9JjdjidOo1dpjmKeSUw6Y12vemlUDHQfERg0j
	U8KS6BPmZONQO017H2XMD6W2OqwCncwVO1QmhhDQWsBj5In39tSXuxOIBqEMgzHG
	5spwUzHA25uQOKFZY7Mb9A0OUd3uPlmm8wXKecOuwgbocGOlip09YBQe8Y4DIn+l
	pMAio6GNImD1JLnWarTCK3Fx1czXO9V5tUaSCk7WOc+CKouEkSYnAhywPxdRkpWy
	yxV0xJE14q7OBnPId5nSAigG4ApMdRdSYb0RM1tXyxx+ys15h88Qu94AL4LEouuI
	zu5fUU5z7rEs1Os8cvmSmqgmu9S0eB7rGynqxYbQag==
X-ME-Sender: <xms:igoAZ6Y7n96DfXblNWzWg-K6j37yGk6C5kbylGWdwh_6KOwmy4Uh6Q>
    <xme:igoAZ9alYRKchJCOrXcvM4_yfhFsy4SK8L3Sb4s__1mFzhpBChqvJ2lFCRhAjhmRS
    uODUrfmiiQvKPWNkA>
X-ME-Received: <xmr:igoAZ084Ovvbq-s5YS5rS0V7OVTvJOH2HhSf6Q6kkEvmaLPC33VNqv1jiy4hB-nk9SvXeWG9wtyWUJifPSqb6MVDq5fNZM01cwuLwZBGMKoFditP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvfedgkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhope
    hsthgvrggumhhonhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghs
    rdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtoheprhgrmhhsrgihsehrrg
    hmshgrhihjohhnvghsrdhplhhushdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:igoAZ8pfGPZXq-uc7Kpx0FqSWeTKML2b__pgmfK1TNZU5YHM9U1maA>
    <xmx:igoAZ1oJ7GRuo4xguFfLJm2UZh0vu5vp6cM0r76dnFu0ng7jBB2YSQ>
    <xmx:igoAZ6RzxTSDAiJgcX8yyVMWGCT0I6CqFA01PBT4EX0OUU0AybNg0w>
    <xmx:igoAZ1omxSMdqai69ytG8wVlnXlHYHc0u-qevZiMwDktND5I6i_xTQ>
    <xmx:iwoAZ2fWirezkQF7pvaQ5dmhOppyv9iBnGXlbzPO0Hfy9i93ulCAVjyk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Oct 2024 11:32:25 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4d4468b2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 4 Oct 2024 15:31:31 +0000 (UTC)
Date: Fri, 4 Oct 2024 17:32:16 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, Josh Steadmon <steadmon@google.com>
Subject: [PATCH v2] t0610: work around flaky test with concurrent writers
Message-ID: <f3874c7e923846e453499e89f00dd4f8862e4c40.1728055880.git.ps@pks.im>
References: <b1b5fb40-f6c2-4621-b58c-9b7c8c64cc01@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1b5fb40-f6c2-4621-b58c-9b7c8c64cc01@ramsayjones.plus.com>

In 6241ce2170 (refs/reftable: reload locked stack when preparing
transaction, 2024-09-24) we have introduced a new test that exercises
how the reftable backend behaves with many concurrent writers all racing
with each other. This test was introduced after a couple of fixes in
this context that should make concurrent writes behave gracefully. As it
turns out though, Windows systems do not yet handle concurrent writes
properly, as we've got two reports for Cygwin and MinGW failing in this
newly added test.

The root cause of this is how we update the "tables.list" file: when
writing a new stack of tables we first write the data into a lockfile
and then rename that file into place. But Windows forbids us from doing
that rename when the target path is open for reading by another process.
And as the test races both readers and writers with each other we are
quite likely to hit this edge case.

This is not a regression: the logic didn't work before the mentioned
commit, and after the commit it performs well on Linux and macOS, and
the situation on Windows should have at least improved a bit. But the
test shows that we need to put more thought into how to make this work
properly there.

Work around the issue by disabling the test on Windows for now. While at
it, increase the locking timeout to address reported timeouts when using
either the address or memory sanitizer, which also tend to significantly
extend the runtime of this test.

This should be revisited after Git v2.47 is out.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t0610-reftable-basics.sh | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
index 2d951c8ceb..babec7993e 100755
--- a/t/t0610-reftable-basics.sh
+++ b/t/t0610-reftable-basics.sh
@@ -450,15 +450,22 @@ test_expect_success 'ref transaction: retry acquiring tables.list lock' '
 	)
 '
 
-test_expect_success 'ref transaction: many concurrent writers' '
+# This test fails most of the time on Windows systems. The root cause is
+# that Windows does not allow us to rename the "tables.list.lock" file into
+# place when "tables.list" is open for reading by a concurrent process.
+test_expect_success !WINDOWS 'ref transaction: many concurrent writers' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	(
 		cd repo &&
-		# Set a high timeout such that a busy CI machine will not abort
-		# early. 10 seconds should hopefully be ample of time to make
-		# this non-flaky.
-		git config set reftable.lockTimeout 10000 &&
+		# Set a high timeout. While a couple of seconds should be
+		# plenty, using the address sanitizer will significantly slow
+		# us down here. So we are aiming way higher than you would ever
+		# think is necessary just to keep us from flaking. We could
+		# also lock indefinitely by passing -1, but that could
+		# potentially block CI jobs indefinitely if there was a bug
+		# here.
+		git config set reftable.lockTimeout 300000 &&
 		test_commit --no-tag initial &&
 
 		head=$(git rev-parse HEAD) &&

Interdiff against v1:
  diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
  index 86a746aff0..babec7993e 100755
  --- a/t/t0610-reftable-basics.sh
  +++ b/t/t0610-reftable-basics.sh
  @@ -453,23 +453,18 @@ test_expect_success 'ref transaction: retry acquiring tables.list lock' '
   # This test fails most of the time on Windows systems. The root cause is
   # that Windows does not allow us to rename the "tables.list.lock" file into
   # place when "tables.list" is open for reading by a concurrent process.
  -#
  -# The same issue does not happen on Cygwin because its implementation of
  -# rename(3P) is emulating POSIX-style renames, including renames over files
  -# that are open.
  -test_expect_success !MINGW 'ref transaction: many concurrent writers' '
  +test_expect_success !WINDOWS 'ref transaction: many concurrent writers' '
   	test_when_finished "rm -rf repo" &&
   	git init repo &&
   	(
   		cd repo &&
   		# Set a high timeout. While a couple of seconds should be
   		# plenty, using the address sanitizer will significantly slow
  -		# us down here. Furthermore, Cygwin is also way slower due to
  -		# the POSIX-style rename emulation. So we are aiming way higher
  -		# than you would ever think is necessary just to keep us from
  -		# flaking. We could also lock indefinitely by passing -1, but
  -		# that could potentially block CI jobs indefinitely if there
  -		# was a bug here.
  +		# us down here. So we are aiming way higher than you would ever
  +		# think is necessary just to keep us from flaking. We could
  +		# also lock indefinitely by passing -1, but that could
  +		# potentially block CI jobs indefinitely if there was a bug
  +		# here.
   		git config set reftable.lockTimeout 300000 &&
   		test_commit --no-tag initial &&
   

base-commit: 111e864d69c84284441b083966c2065c2e9a4e78
-- 
2.47.0.rc0.dirty

