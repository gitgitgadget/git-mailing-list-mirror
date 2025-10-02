Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4382030E842
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 11:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759403105; cv=none; b=CvOn4o6zfQLuWmBP4j3OFhEFIxvEnFdCgoRmKJf37j9ZdA1idKchD96FyATZ81mN6uSFe8CcDRvsy9tDTY0lOjR5LWjg/7VKGHrWaHMigqa0SLIgvulNba7G1e4uTIePG8z7IiXuNPGpLtJhptkS2zNk1nRQQ62TK5AbkEaUu1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759403105; c=relaxed/simple;
	bh=3psQJrbZPSvX9tHULEaTzj3mNiVH2yQ21dukFnxpFK0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S3HUMEAjTGeS1T7COq1YYylprUI6U+LzrIk5LnvVXFvj4pAJIQa9Hvc4O7+UN4bH706nV3Qwnc+3zeZRC/A5+Mq5JuenO/qgngi5W/YMI2ISXcWnRC60Ih7sWZMT53pLHXuEnCoUJdbKHxCuNvQCIja7zYwhJfuHATgZswULTEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bso8XzWv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z8qrHUnt; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bso8XzWv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z8qrHUnt"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 80BBF7A085F;
	Thu,  2 Oct 2025 07:05:02 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 02 Oct 2025 07:05:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759403102;
	 x=1759489502; bh=8G6q8A7Tu1q479eU85VLFdooxNkNv+mnRy9JA2k3Bw4=; b=
	bso8XzWvibky4BfpAjstvQfNJ8nPsvZAHsQXzG7t5qSWwF1pdvLyAbNl2E8R/rX1
	RcdF0i4oO2teobmGj4C5fphNXxn2A8KmNDbM1weaKQ3CONDPA5YNBMKvCiCmU1pC
	E6cVCCSs7r3HEvaBTMZX0/8DZZ/0z2lgJhRqdsATzpYeydcakU9dZl1c1NkS7DvN
	nyU41ceW5OqHi7RcBL3eypIyncgsiLcyaIvcWKEz4DZcfA91aa4qP3hLqFuryJGo
	+MmbTCqJGw0fBqSOM/Lngip4ixv1Hx4bQ7NaopI8tnTF/X5IMxQTzadZz6dbIGOu
	qlQg08JobIik0IpjTWkKew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759403102; x=
	1759489502; bh=8G6q8A7Tu1q479eU85VLFdooxNkNv+mnRy9JA2k3Bw4=; b=Z
	8qrHUntng3t+ExLok6lqWAfrSuYEqm0uxhCRJ4ySCEuRo88AjQo1MJ5mVI+evtVd
	LEmnzRUCcnCVgpffr2iIqtBo1j71sugr06NUm+Aivy99FTOgxZr4Su38OWm82p2l
	gm3ucm2GZ0jVDaiFKeAZAsC4sRbncVrWyykmdh1EvyWs54GuNp/5d2tJ4Un024Fp
	pV0mVm6uhmJp3TPzVqu6loD/F26eWKPARKv3UCH5ag4nWdA9faPbBdkF8EocoomE
	ygMFZMRKbsmth4IDkqKJvLfmDeG7wzwQGF+Qhz/e6dUd/mk3rz9X15K4qaw1SELt
	KUCwI8jqx5OMBh99LCFdQ==
X-ME-Sender: <xms:XlzeaLcG5gYNCUm1GDeNH_2MoUE2t82EcicR-0x3FS1cMkeb1c5K5Q>
    <xme:XlzeaHPlQFWKytPbBveEcOHKYJH_m4UcrjUca9Ghg5U0Y6zQHJJ3XBmg6QXlZux7j
    1E_lwk9rmiEQlaoB6DDaRhe9bH7RqyKxGj-IjDqEfpWRG_ko10oXA>
X-ME-Received: <xmr:XlzeaCL6Ew8xJwwjhQl_Opg0SU4VQgmnr711RjfGEcUlEitLGd2kpt9E8Uv-x3OtVb_ra2KbX8Ke1JONfj0ZU6KU63I3vASTDVJaC0SyRw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekheekhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehtohhonhesih
    hothgtlhdrtghomh
X-ME-Proxy: <xmx:XlzeaIFVbpnblB4AOXoto1DkIy5WIai0mqVqBnxAFw7CDLJUQlk_Eg>
    <xmx:XlzeaKTLfg9wlm1CV6W1bcK1RoeJHoq10v4bsVYA8QYXg-IgSt0k0g>
    <xmx:XlzeaEH4uRRqmRRRo6QGJwP4x9PPw8qAVD8a9C8kj8hzXBLE7d9qNQ>
    <xmx:XlzeaG_Muf0CneLYIOJTHN_0sqwjb1wLJgcUohxZuqvdZZ2Iz3PesA>
    <xmx:XlzeaG28L7YMWaFL99uEUlbydF9OPSPHxy3clQLdS89J847ofkouHHcC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Oct 2025 07:05:00 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3abcf5b2 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 2 Oct 2025 11:05:00 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 02 Oct 2025 13:04:40 +0200
Subject: [PATCH 5/5] t8020: fix test failure due to indeterministic tag
 sorting
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251002-pks-gitlab-ci-windows-improvements-v1-5-6a8b6b45d728@pks.im>
References: <20251002-pks-gitlab-ci-windows-improvements-v1-0-6a8b6b45d728@pks.im>
In-Reply-To: <20251002-pks-gitlab-ci-windows-improvements-v1-0-6a8b6b45d728@pks.im>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.2

In e6c06e87a2 (last-modified: fix bug when some paths remain unhandled,
2025-09-18), we have fixed a bug where under certain circumstances,
git-last-modified(1) would BUG because there's still some unhandled
paths. The fix claims that the root cause here is criss-cross merges,
and it adds a test case that seemingly exercises this.

Curiously, this test case fails on some systems because the actual
output does not match our expectations:

    diff --git a/expect b/actual
    index 5271607..bdc620e 100644
    --- a/expect
    --- b/actual
    @@ -1,3 +1,3 @@
     km3 a
    -k2 k
    +km2 k
     1 file
    error: last command exited with $?=1
    not ok 15 - last-modified with subdir and criss-cross merge

The output we see is git-name-rev(1) with `--annotate-stdin`. What it
does is to take the output of git-last-modified(1), which contains
object IDs of the blamed commits, and convert those object IDs into the
names of the corresponding tags. Interestingly, we indeed have both "k2"
and "km2" as tags, and even more interestingly both of these tags point
to the same commit. So the output we get isn't _wrong_, as the tags are
ambiguous.

But why do both of these tags point to the same commit? "km2" really is
supposed to be a merge, but due to the way the test is constructed the
merge turns into a fast-forward merge. Which means that the resulting
does not even contain a criss-cross merge in the first place! A quick
test though shows that the test indeed triggers the bug, so the initial
analysis that the behaviour is triggered by such merges must be wrong.

And it is: seemingly, the issue isn't with criss-cross merges, but
rather with a graph where different files in the same directory were
modified on both sides of a merge.

Refactor the test so that we explicitly test for this specific situation
instead of mentioning the "criss-cross merge" red herring. As the test
is very specific to the actual layout of the repository we also adapt it
to use its own standalone repository.

Note that this requires us to drop the `test_when_finished` call in
`check_last_modified` because it's not supported to execute that
function in a subshell.

This refactoring also fixes the original tag ambiguity that caused us to
fail on some platforms.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t8020-last-modified.sh | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/t/t8020-last-modified.sh b/t/t8020-last-modified.sh
index e13aad1439..61f00bc15c 100755
--- a/t/t8020-last-modified.sh
+++ b/t/t8020-last-modified.sh
@@ -33,7 +33,6 @@ check_last_modified() {
 	done &&
 
 	cat >expect &&
-	test_when_finished "rm -f tmp.*" &&
 	git ${indir:+-C "$indir"} last-modified "$@" >tmp.1 &&
 	git name-rev --annotate-stdin --name-only --tags \
 		<tmp.1 >tmp.2 &&
@@ -128,20 +127,25 @@ test_expect_success 'only last-modified files in the current tree' '
 	EOF
 '
 
-test_expect_success 'last-modified with subdir and criss-cross merge' '
-	git checkout -b branch-k1 1 &&
-	mkdir -p a k &&
-	test_commit k1 a/file2 &&
-	git checkout -b branch-k2 &&
-	test_commit k2 k/file2 &&
-	git checkout branch-k1 &&
-	test_merge km2 branch-k2 &&
-	test_merge km3 3 &&
-	check_last_modified <<-\EOF
-	km3 a
-	k2 k
-	1 file
-	EOF
+test_expect_success 'subdirectory modified via merge' '
+	test_when_finished rm -rf repo &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit base &&
+		git switch --create left &&
+		mkdir subdir &&
+		test_commit left subdir/left &&
+		git switch --create right base &&
+		mkdir subdir &&
+		test_commit right subdir/right &&
+		git switch - &&
+		test_merge merge right &&
+		check_last_modified <<-\EOF
+		merge subdir
+		base base.t
+		EOF
+	)
 '
 
 test_expect_success 'cross merge boundaries in blaming' '

-- 
2.51.0.700.g236ee7b076.dirty

