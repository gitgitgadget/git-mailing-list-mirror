Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D152913A416
	for <git@vger.kernel.org>; Fri, 16 Aug 2024 09:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723799176; cv=none; b=n/h4JovMPqAiScvBn9BQ7huRVy2N4mqkHhqMHgTiJ/Xlw9TVtnkIrq9zX7A48DcHr5FuejbwNcgThQX+WR0dE+5cMIjDGgjq/c+A+XQ3ezv/ptSpFuTa4AyBfQVxUlqqRHqzVStqqlzzjBZWgfYZriVDh82Hxrj2N7iCVrITaUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723799176; c=relaxed/simple;
	bh=vHbON6DJuratdtZPtnxXFhnY2EJKNntpkUDMlQ4pBWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sgla1ikPVcAeczKK0JSitJFZ/G5K27sLeAHohjUuSlbWjqGZZ2bPxuhFUGT+LzH4lXmcPegLkHLF6GtbX2++T7HlZ3LJqzcCeHRb+iF9fQDh5YjoJKIuAuvLfnwUzCD8GyiYKxOAdQOtsEFv14Bajzx57zkEa6y2PoZmrCZWaxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gV6xg9ac; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rhzj5lBY; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gV6xg9ac";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rhzj5lBY"
Received: from phl-compute-08.internal (phl-compute-08.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 90976114AB11;
	Fri, 16 Aug 2024 04:56:55 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Fri, 16 Aug 2024 04:56:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723798615; x=1723885015; bh=hBcrE6obeU
	l8UAzwXmG1mqpoG637vytBkeS2Sr/rE5M=; b=gV6xg9acngbEQ+Z+9QX4R8WpKE
	bu7NoZ3hWFeKEBd8XI3GfhCUs9PSVoxdcLgF3q5GuZTZlpEGIRf0oxD3Xg8qPji9
	D4ic6BH2SZStdb1gZuRZpwClMdyQhp/b2eVkyskZWkvwU6B+r8NQ8wCnbvvrt3CQ
	njumAhlfDl80wGDsouoOQlWA+MaxsjpquBZU372AC02y66Jlv/pGeJe95rF1C/ea
	d5/nh168ysc33NfDMMUEnYvEmz13pPeeDUE3KgtfpHldCzzFBiuPaY4sznXOY/OX
	khHO/vnGvYOKlQa+S74W0rl0RyeFSVqsrCL8uqp9oH5pT+eBUFmcyyO4kGOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723798615; x=1723885015; bh=hBcrE6obeUl8UAzwXmG1mqpoG637
	vytBkeS2Sr/rE5M=; b=rhzj5lBYHwtJhaF9JrgInucJTECyCvEFGkuUCQ6sqQgZ
	Xw2eGMUXT5ddAyH7YP47aYwSML3niuL0qES/on97zecEWRbf+tQX3yhbBUHUP36x
	xhgTiEstOzBTHveIsoXm9fYDWhYlUhN77s5nDGbfj7PGH/gZlhxATuqO+ztSEy1c
	74ZqFnR83pjla81WnyNJ+7Nci2g3v4tLuDV1fm1BrjQdiwRX0MXJ8vn+JYi6uSoW
	UAydyduv+KOo3fvqqRZvTSGHYWns6ICa4m6H5P29wYTQW2SyjdSnYm053tULBoAN
	gyd81YKLf/rNQ9N2nEOJ34K4eZPMg18bWVIQZupnWQ==
X-ME-Sender: <xms:VxS_Zltd1ywJySHAhA4JCQkuOltVYpglgu7bSj1m006A8lRJywnKfg>
    <xme:VxS_ZuedbNfsi9uumeaIWYLV6vEHmEtQU8OHYbuEbMmWTJGU7SKf7WrIq479oWn4y
    z7cz2L766PpyoKpfA>
X-ME-Received: <xmr:VxS_ZowdcSkAqvN46HRKzWDgJyLiO0v03mSNBcY2HxMHLH8tuglYjrpMWp_Am0Kl2npLbdr0S-K9hpwnlZHEXlYQWKtuaXswurtjcPlOtsH8NeY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtkedgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprg
    hsthgvrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhstg
    hhuhgsvghrthhhsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehg
    mhgrihhlrdgtohhm
X-ME-Proxy: <xmx:VxS_ZsPIqC9rw7fXSITjkrP37NE8Q0xmLVixgZw9HMQMMCDDafAKAg>
    <xmx:VxS_Zl9xRFkriwc7N-YEoeBHXAe1OYKIE1fzBtpWJ7E5owIZWQaYyA>
    <xmx:VxS_ZsU7euZHP1nyvfRGaRrCQfAClOJZpGxZZtG1BiBVTqHxM_chSg>
    <xmx:VxS_ZmcC-FWpcC5fsNuJ_T9s3mcI0Z02JaL7muIFMbwQvBmK1bSFEw>
    <xmx:VxS_ZolOrM4lj-sB1I_9Nf8sTOMo8PeLNohGk7rwaFM-zCLffEADHDqm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Aug 2024 04:56:54 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 11c66138 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 16 Aug 2024 08:56:31 +0000 (UTC)
Date: Fri, 16 Aug 2024 10:56:53 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Sebastian Schuberth <sschuberth@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/5] t0001: exercise initialization with ref formats more
 thoroughly
Message-ID: <0d3844db32237983a1d85ced1a3b1b25fcd1d6eb.1723798388.git.ps@pks.im>
References: <cover.1723708417.git.ps@pks.im>
 <cover.1723798388.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723798388.git.ps@pks.im>

While our object format tests for git-init(1) exercise tests with all
known formats in t0001, the tests for the ref format don't. This leads
to some missing test coverage for interesting cases, like whether or not
a non-default ref storage format causes us to bump the repository format
version. We also don't test for the precedence of the `--ref-format=`
and the `GIT_DEFAULT_REF_FORMAT=` environment variable.

Extend the test suite to cover more scenarios related to the ref format.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t0001-init.sh | 48 +++++++++++++++++++++++++++++++++++-------------
 1 file changed, 35 insertions(+), 13 deletions(-)

diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 49e9bf77c6..2093f5c1ee 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -558,15 +558,6 @@ test_expect_success DEFAULT_REPO_FORMAT 'extensions.refStorage with unknown back
 	grep "invalid value for ${SQ}extensions.refstorage${SQ}: ${SQ}garbage${SQ}" err
 '
 
-test_expect_success DEFAULT_REPO_FORMAT 'init with GIT_DEFAULT_REF_FORMAT=files' '
-	test_when_finished "rm -rf refformat" &&
-	GIT_DEFAULT_REF_FORMAT=files git init refformat &&
-	echo 0 >expect &&
-	git -C refformat config core.repositoryformatversion >actual &&
-	test_cmp expect actual &&
-	test_must_fail git -C refformat config extensions.refstorage
-'
-
 test_expect_success 'init with GIT_DEFAULT_REF_FORMAT=garbage' '
 	test_when_finished "rm -rf refformat" &&
 	cat >expect <<-EOF &&
@@ -576,15 +567,46 @@ test_expect_success 'init with GIT_DEFAULT_REF_FORMAT=garbage' '
 	test_cmp expect err
 '
 
-test_expect_success 'init with --ref-format=files' '
+backends="files reftable"
+for format in $backends
+do
+	test_expect_success DEFAULT_REPO_FORMAT "init with GIT_DEFAULT_REF_FORMAT=$format" '
+		test_when_finished "rm -rf refformat" &&
+		GIT_DEFAULT_REF_FORMAT=$format git init refformat &&
+
+		if test $format = files
+		then
+			test_must_fail git -C refformat config extensions.refstorage &&
+			echo 0 >expect
+		else
+			git -C refformat config extensions.refstorage &&
+			echo 1 >expect
+		fi &&
+		git -C refformat config core.repositoryformatversion >actual &&
+		test_cmp expect actual &&
+
+		echo $format >expect &&
+		git -C refformat rev-parse --show-ref-format >actual &&
+		test_cmp expect actual
+	'
+
+	test_expect_success "init with --ref-format=$format" '
+		test_when_finished "rm -rf refformat" &&
+		git init --ref-format=$format refformat &&
+		echo $format >expect &&
+		git -C refformat rev-parse --show-ref-format >actual &&
+		test_cmp expect actual
+	'
+done
+
+test_expect_success "--ref-format= overrides GIT_DEFAULT_REF_FORMAT" '
 	test_when_finished "rm -rf refformat" &&
-	git init --ref-format=files refformat &&
-	echo files >expect &&
+	GIT_DEFAULT_REF_FORMAT=files git init --ref-format=reftable refformat &&
+	echo reftable >expect &&
 	git -C refformat rev-parse --show-ref-format >actual &&
 	test_cmp expect actual
 '
 
-backends="files reftable"
 for from_format in $backends
 do
 	test_expect_success "re-init with same format ($from_format)" '
-- 
2.46.0.46.g406f326d27.dirty

