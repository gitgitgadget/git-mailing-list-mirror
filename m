Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF8A1A8410
	for <git@vger.kernel.org>; Wed, 11 Dec 2024 10:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733914395; cv=none; b=jAaGQTON3fyqY+Qlr47TQBupedxGhqtf8v+DPl9py4d0+0cgSDro8JxjGObmkxG10AJau5zMm29lTIr7cY7iaMs0MAjosUyyG07fqpJkm86vR18BuDnjeRCnkC22OW1T0LACU/sxJUGbXKVxVSaOrlpEYGk1hUdwBOOnkOYfT+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733914395; c=relaxed/simple;
	bh=cHbvpJqkh/AezI2BJTet2V3CTXisrLIKE1V3Ok8Tyrk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lDcilnFVUPzbwSEnQHI6Pr39aE9+HWY7ps4FVfeJaRYxr73sN76aY4y6/x15PNWGf2oJmdtDD0KAfSXMvQ8UPBuvYYsEkKFvYFyWERapxLrczbVdO8N4cHtAyBXvt1LZCE1nu8NsPiTYqEOxvsNjVnBzBV4YfWQbQCEH9XbI+c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Vj66AQWA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TPJwguGV; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Vj66AQWA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TPJwguGV"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 66373114026F
	for <git@vger.kernel.org>; Wed, 11 Dec 2024 05:53:11 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Wed, 11 Dec 2024 05:53:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733914391;
	 x=1734000791; bh=Wb81SKAlylxOhqw+0F7gG0BMGEpS87kNjGxaZagH7Q8=; b=
	Vj66AQWAS9GGwHjPZcVHC3J5N9NCyILMPdOs8xk+cbb9v1PpPGRE2/k6Djr1Vyi1
	WIgQiMVJpUt6fLNWWtQJmKJm+crdUSXGEQ8dFDyilvRu0Fgk9yEdHelNt97WiGKt
	I/1EjYaZleoTyetMz/53mJyBjdhEFKSBA7OREUGFNwtUvnAlFUoQDZk/MIOLoG43
	CP2Cjm/lROSyGFoS4+eBSqUCU7rrK6B+Ge7JxPgMr4si5AT57Bwlr+1oD0XrYS5q
	ATbEJrOfjt6BJ6sign2QLQIixti1QSR82Nw/ljRGDnDvW5RtOYpv3zZcu7N1XcqQ
	nw/SPvkN9dLwiS0TQHiemg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733914391; x=
	1734000791; bh=Wb81SKAlylxOhqw+0F7gG0BMGEpS87kNjGxaZagH7Q8=; b=T
	PJwguGVt9ZuE8KmCnaIo5gCvBWiDUR/Nsz6X9jUNsCCTlq7pMIHrvMnDAWTUMUJ4
	o5sZO9NEB1fNqWmfWn5Io9op628jCqPB3IPZEoEdVet9pwSMizqGPthNWfNMGKAF
	SFtOT5rlWp1WbsAB155Rah4OR/SmnPhddEIUQnm4bb2TUh44R1HBsLhw8mmJ3Qbf
	0P8xmM1wwoDpsVtOrn+LdMB1Up1iCd5DplP9/t3IK7fHJwnG+LZ79L+fIH+qevmX
	2TREL0XeMAEhJ4xeoALzGFnjCFEKLJr1Xir9L1Th5x4+U8YHcrXrcBvqvQ8TY9dz
	bph89BHtod3hzZ1YMaBAw==
X-ME-Sender: <xms:F29ZZ2EXrvKXtxRPMmVPCCjV7F5_9a6-Cua79qUNFKbcP9j8M6bZYQ>
    <xme:F29ZZ3U2g7AKNfsNAjkvRhZT1BLWWYlrqHKTJVhpuwcDWFqn9apI-5R4NvAD1R7Gg
    9o-ejTc3L5UnPeubA>
X-ME-Received: <xmr:F29ZZwKmB6xqJ0oG6Nxy5-BoFXBFuBMrP8wEoKx9jKwmEWzVzpEblCViPKPKCbIvUpmilGWGheUghxHFvppdf8XvDoSuTG0q1uAtaiesNfOvSw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkedtgddvudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffufggtg
    fgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvd
    ekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:F29ZZwHnIikeOE3mQaZq6brmsbKmbltJPGD258TlIILiEz-M1O_SlA>
    <xmx:F29ZZ8UFl-51Hy7WYI-yyxYifoFmBWEX2somALDxJCCAK6ceDxcXtg>
    <xmx:F29ZZzMP_-2raRXCPEbBeqPEy3FA4rRCHzDh_NkBuKDb0Mo27JmrNw>
    <xmx:F29ZZz3c4iyT64xjffWaJgxFwHF7_KauS3BU9Q4uhjtUx7jNlKOn6g>
    <xmx:F29ZZ3dxdRiIHh8CSg5tc1s69bUCrTJEqGOxK6tmlmtgrm0bUBtb_rbw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 11 Dec 2024 05:53:10 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id cd515867 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 11 Dec 2024 10:51:32 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 11 Dec 2024 11:52:32 +0100
Subject: [PATCH 1/8] ci/lib: support custom output directories when
 creating test artifacts
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-pks-meson-ci-v1-1-28d18b494374@pks.im>
References: <20241211-pks-meson-ci-v1-0-28d18b494374@pks.im>
In-Reply-To: <20241211-pks-meson-ci-v1-0-28d18b494374@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

Update `create_failed_test_artifacts ()` so that it can handle arbitrary
test output directories. This fixes creation of these artifacts for
macOS on GitLab CI, which uses a separate output directory already. This
will also be used by our out-of-tree builds with Meson.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/lib.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index 930f98d7228166c37c236beb062b14675fb68ef3..2e7a5f0540b66f24bd0f5744311c2c48b472d63d 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -180,9 +180,9 @@ handle_failed_tests () {
 }
 
 create_failed_test_artifacts () {
-	mkdir -p t/failed-test-artifacts
+	mkdir -p "${TEST_OUTPUT_DIRECTORY:-t}"/failed-test-artifacts
 
-	for test_exit in t/test-results/*.exit
+	for test_exit in "${TEST_OUTPUT_DIRECTORY:-t}"/test-results/*.exit
 	do
 		test 0 != "$(cat "$test_exit")" || continue
 
@@ -191,11 +191,11 @@ create_failed_test_artifacts () {
 		printf "\\e[33m\\e[1m=== Failed test: ${test_name} ===\\e[m\\n"
 		echo "The full logs are in the 'print test failures' step below."
 		echo "See also the 'failed-tests-*' artifacts attached to this run."
-		cat "t/test-results/$test_name.markup"
+		cat "${TEST_OUTPUT_DIRECTORY:-t}/test-results/$test_name.markup"
 
-		trash_dir="t/trash directory.$test_name"
-		cp "t/test-results/$test_name.out" t/failed-test-artifacts/
-		tar czf t/failed-test-artifacts/"$test_name".trash.tar.gz "$trash_dir"
+		trash_dir="${TEST_OUTPUT_DIRECTORY:-t}/trash directory.$test_name"
+		cp "${TEST_OUTPUT_DIRECTORY:-t}/test-results/$test_name.out" "${TEST_OUTPUT_DIRECTORY:-t}"/failed-test-artifacts/
+		tar czf "${TEST_OUTPUT_DIRECTORY:-t}/failed-test-artifacts/$test_name.trash.tar.gz" "$trash_dir"
 	done
 }
 

-- 
2.47.1.447.ga7e8429e30.dirty

