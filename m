Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7603C374162
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 16:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770656191; cv=none; b=eiTnMbT71u2y3p8kjxJMXsuVvCGLEQJLzYfJnkTW4hlf9XQux3XnJV3LI23LudjXc2AIpMU5UQAc7eX4K3oKRfaJom6502qm961k70NM6TS/QFnBFS3Azqtfe9ZRNdpnucYnx94JlCmyfCtIl3AiCyyXteovF7VfA63za9AC4AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770656191; c=relaxed/simple;
	bh=wcgY9JKe8Drsnh0m74DCcSPvvMFb9TqY+0z6LRrEUSQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=evUE3v8QH9lMs0WqIqFWycTQVJq4CpdyMAK0yq3m1UY15xzmiTDh0HV+dOcu+d/xe/ML0HtmYTu/4ch1xwFXYqx8kNskzZ6pZtKOXwzvvEDnbHEja7w2c8tr5LNptXzYDKLYwnXIzdlooZBwUiDEN0L+iV2wH5I7DNVtPq5jfjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cobKmSwa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TC/q5hpI; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cobKmSwa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TC/q5hpI"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id E3EB61D00177
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 11:56:30 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Mon, 09 Feb 2026 11:56:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770656190;
	 x=1770742590; bh=bwgqFZgsuqcWG8ioK2EHHYHRsqedeU3wRG6xjCwePpw=; b=
	cobKmSwaQ+GcbI/VJRcOsD4axRdPitPNpHoYt3mLqWo2OHMWlI6OAf426ycV0rMs
	ogrznKfetfTKVA6Fa6SbK/5vpIbEnKOchVJ8ABusI9ZOiaXVubge2rlB6lfzuRLl
	eYoa1oSo+8f6Ov8NyPdthXPHPcJAf3FOj/pATVUubkEJdbrzUeXn7c1I2uL7i3w5
	APLUioUFhm1pLPv9zOvr1ccFST6bwoKMmf0zNurJr8SRVYb4ASBU7wBoUDW4vtYb
	DMtUVtA9kaGh49indFSY43QGAMOnnm4RY3tDfZydj+vOMZzS2Cdzv+JCnef5OJIR
	AzVximhvSHpOBAU09+UHSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770656190; x=
	1770742590; bh=bwgqFZgsuqcWG8ioK2EHHYHRsqedeU3wRG6xjCwePpw=; b=T
	C/q5hpIXjHV+aBak+iUI+Z3/BO8v0ZXLKGPE7zCnja0iT4ddPa4+YPXl6fjEmwR9
	kPclr2rY7mvFR+FGk4t0xwObmuq6/K+LOa6UJvv7NxvkpWaE2l6JoJBWvb8pkhul
	fv5tTSL8Nue1kqKfhDvIte8XH8YDY9T7k3B4tdEHj8EGebi95+jkszK+CaOmhRUv
	QJo3P7lBnVk3uo/K6bNBXYJ1IuzXpSW9MSHNApXoeBGHp3TVMEKkTkKCJE48tFKF
	RIry9SjA7wtbmQkKgHzy16zXg/9xRgp4anUBUjuFvoMxNJVC7KsdsQOV5YEfIBvK
	ZAKzjY0WJVsJlV1XGfs/w==
X-ME-Sender: <xms:vhGKacqW-lpkDMlY0NNc6HeumD6553lxOCzcyXaUxqISpbtpbffj0w>
    <xme:vhGKaZnEA7XeCU1kIiXqxHcJzJ9M0BQDleeaf-vr_SQdud8Tv8dD0sjEK4uFP8OZO
    E3RhBhXFajk5H0F8HJTGI8cTPvNEh2NZG3lnMDRFPPu-RluLWNXDA>
X-ME-Received: <xmr:vhGKaW2WatzguzKui58C0Um7zojEy8iMbbB3Yb5zJeU-2p_HIjawTPUKrqSvoti-y8pmk9e0Hdhl_oyOubC2jOl82PCz420r0JDZ83RmLoE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleejfeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:vhGKaZB7eTe_MFmfyVt3a06-T0Nt-29s3NRY_eJxNqTXkjqEFRKexw>
    <xmx:vhGKabzxoS0LJpdqUnk6suj4gdyadzUhY_UosS4nY2vQ3awvq5NFNA>
    <xmx:vhGKafnBHZD2VJ40-l1SrSRXPVC0JGPcSpD-AtfIlZXbuBNSC10FwQ>
    <xmx:vhGKaYFWfOeSeNbiI1tLTz_fHvXMhRQiT89bT57bBIwvYoWMl8PcLA>
    <xmx:vhGKaQLPA2j5eWpjvo6FsIcwsQLGkVEgzjPNUzlpYlC7QvWNOuAu2FhJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 9 Feb 2026 11:56:30 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5445a518 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 9 Feb 2026 16:56:29 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 09 Feb 2026 17:56:12 +0100
Subject: [PATCH 2/5] ci: don't skip smallest test slice in GitLab
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260209-b4-pks-ci-meson-improvements-v1-2-38444dec4874@pks.im>
References: <20260209-b4-pks-ci-meson-improvements-v1-0-38444dec4874@pks.im>
In-Reply-To: <20260209-b4-pks-ci-meson-improvements-v1-0-38444dec4874@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

The "ci/run-test-slice.sh" script can be used to slice up all of our
tests into N pieces and then run each of them on a separate CI job.
This is used by both GitLab and GitHub CI to speed up Windows tests,
which would otherwise be painfully slow.

The infra itself is fueled by `test-tool path-utils slice-tests`. This
tool receives as input an "offset" and a "stride" that can be combined
to slice up tests. This framing can be misleading though: you are
expected to pass a zero-based index as "offset", and the complete number
of slices to the "stride". The latter makes sense, but it is somewhat
surprising that the offset needs to be zero-based. And this is in fact
biting us: while GitHub passes zero-based indices, GitLab passes
`$CI_NODE_INDEX`, which is a one-based indice.

Ideally, we should have verification that the parameters make sense.
And naturally, one would for example expect that it's an error to call
the binary with an offset larger than the stride. But with the current
framing as "offset" it's not even wrong to do so, as it is of course
well-defined to start at a larger offset than the stride.

This means that we get this wrong on GitLab's CI, as we pass a one based
index there, and this causes us to skip one of the tests. Interestingly,
it's not the lexicographically first test that we skip. Instead, as we
sort tests by size before slicing them, we skip the _smallest_ test.

Reframe the problem to instead talk about "slice number" and "total
number of slices". For all of our use cases this is semantically
equivalent, but it allows us to perform some verifications:

  - The total number of slices must be greater than 1.

  - The selected slice must be between 1 <= nr <= slices_total.

As the indices are now one-based it means that GitLab's CI is fixed.
The GitHub workflow is updated accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .github/workflows/main.yml |  2 +-
 t/helper/test-path-utils.c | 18 ++++++++++++------
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index f2e93f5461..2b175dc5c6 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -150,7 +150,7 @@ jobs:
     - uses: git-for-windows/setup-git-for-windows-sdk@v1
     - name: test
       shell: bash
-      run: . /etc/profile && ci/run-test-slice.sh ${{matrix.nr}} 10
+      run: . /etc/profile && ci/run-test-slice.sh ${{ matrix.nr + 1 }} 10
     - name: print test failures
       if: failure() && env.FAILED_TEST_ARTIFACTS != ''
       shell: bash
diff --git a/t/helper/test-path-utils.c b/t/helper/test-path-utils.c
index f5f33751da..874542ec34 100644
--- a/t/helper/test-path-utils.c
+++ b/t/helper/test-path-utils.c
@@ -477,14 +477,20 @@ int cmd__path_utils(int argc, const char **argv)
 
 	if (argc > 5 && !strcmp(argv[1], "slice-tests")) {
 		int res = 0;
-		long offset, stride, i;
+		long slice, slices_total, i;
 		struct string_list list = STRING_LIST_INIT_NODUP;
 		struct stat st;
 
-		offset = strtol(argv[2], NULL, 10);
-		stride = strtol(argv[3], NULL, 10);
-		if (stride < 1)
-			stride = 1;
+		slices_total = strtol(argv[3], NULL, 10);
+		if (slices_total < 1)
+			die("there must be at least one slice, got '%s'",
+			    argv[3]);
+
+		slice = strtol(argv[2], NULL, 10);
+		if (1 > slice || slice > slices_total)
+			die("slice must be in the range 1 <= slice <= %ld, got '%s'",
+			    slices_total, argv[2]);
+
 		for (i = 4; i < argc; i++)
 			if (stat(argv[i], &st))
 				res = error_errno("Cannot stat '%s'", argv[i]);
@@ -492,7 +498,7 @@ int cmd__path_utils(int argc, const char **argv)
 				string_list_append(&list, argv[i])->util =
 					(void *)(intptr_t)st.st_size;
 		QSORT(list.items, list.nr, cmp_by_st_size);
-		for (i = offset; i < list.nr; i+= stride)
+		for (i = slice - 1; i < list.nr; i+= slices_total)
 			printf("%s\n", list.items[i].string);
 
 		return !!res;

-- 
2.53.0.295.g64333814d3.dirty

