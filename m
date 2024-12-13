Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6301B415F
	for <git@vger.kernel.org>; Fri, 13 Dec 2024 10:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734086497; cv=none; b=q+BENnKK2MvD2+C4r4Oq3VRdUpxOzNb+C96qkEhjQ/B22RI0KFbSZUH57jKUxwoa5mvOi13XYaiVwEXszRPUMrsAVbdlUUmiEacfQAoDru3w1XYGFLTeb3EbNNGjQgjUlEcO5391MF+QttZAFlFUZAUTi834bEZU2cj4oeh3Fy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734086497; c=relaxed/simple;
	bh=KrDAZdCwVeWN39rSDZ/gUVt7Wx928VmE4ZVvBgyAMl8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j2dYj42Kx+da32iQfXRGzx5rYOeJ/zHiKnhEql1k5ytgq0OGoJAtx39Z6z0YS5inLAD9YFM5WYkn/36KsULsOYXiA3jZz+xEpDwSPGVui+d13/ncQf/fhLmIHOGWOIEvT8ARIhicZYxD+4ppB9sMXxNCkrvh+oc4CeWBJZLdy+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qR/aRzWh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a6lxxLVl; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qR/aRzWh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a6lxxLVl"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0139C2540113;
	Fri, 13 Dec 2024 05:41:34 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 13 Dec 2024 05:41:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1734086494;
	 x=1734172894; bh=7ek473Fs/fmP3pcaWxjMjtFCAgpnaE9VUbgeqRtB8io=; b=
	qR/aRzWh6SCjhB/RmMp4GRb8g7xXRPTxnd4DagJc0MShj/oAzg8dTroB25PG49Qr
	Ok8PYdjcAyc8Ls99iu7Yw+h/ZRygpD4q3gdZp6nS3b4GgeM42fklry/ZlRG/QFrN
	3cEBnsNYfrDOXllj/povWjsDSM+4h7If8UeGbfnMbMekNZV/AZTeTLfwKa8r4aCQ
	qupN3ukZAIb35qeITnkmgZovC3FShsDfo3imDK0pM33eevnWHTSdiXt4nwrSux94
	26W0oaGeLhnP1LSpeZWqRkMtAo3wnuU7EKsksb2yLzvcfM3n5m0IwV42+YePr9Tz
	ulhuswIkeBaoaQexJbZonw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1734086494; x=
	1734172894; bh=7ek473Fs/fmP3pcaWxjMjtFCAgpnaE9VUbgeqRtB8io=; b=a
	6lxxLVlhrVrgehHbiDUp+69KYyphpwrV7kkNl6pU/1w0E96SSeEKxh76ykR6ppG8
	S9mfpwtIPYfJ/iKyJ0wF4siV7Jl7ncdkR1hXD/sotlvPpGtUjbwxhu10mnjE87cw
	fu/IDAvd8s5jhNw/Q6bCkDDpT/eLiYTfosUe3mYePNZ+VR5f3IXlh7k2MQb0pEdi
	L/PKPzw7ym+NGOTV3uoAKkGIX8nGcH+OlqVHBoC+XC7wxIIbfJOdwPk32eO4BZGF
	ZVvRgrY7Hr5/1IodjwF4SdkwE61FuHCBTymNSrdVLLZOHNgjyngjBgq1sm+U/EH1
	6E38g34dJomEsqXoq/8Vg==
X-ME-Sender: <xms:Xg9cZ6lHGApNIhgAMZZtZQMncpM4qOamxjRhh3BQL-q08l3_GVjFhw>
    <xme:Xg9cZx11egJwErWnWq_oOL_fDSE7YQ92ZcTkCQLNuafU64YiYmMSLoHzHJZcQkUqB
    dS_SIW8LNYMLYbFHw>
X-ME-Received: <xmr:Xg9cZ4pDeCdM79FzoG5AcgGiih25PTxr_IY7DBU6NytB0bYNAfHoCWywtGs2vY8m_4sZoQtdLmcS8_LfLr6qF6v6MsWOukFszebtl5PJ533Ato0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkeejgddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Xg9cZ-kp_g7fCukRu8-T_eJr8xen9q5dqbk3LOfYs5d3fuQYSvtKNQ>
    <xmx:Xg9cZ43y7qj-gdJcgWwKRKhAflVEd_TEsjMzEJm_Q15JfzgzQWbg7g>
    <xmx:Xg9cZ1uQivx5uDssT597YnzKqOLIP19ZLo_RHoxemNUJhpGNGcrAPA>
    <xmx:Xg9cZ0XKMnU9DxD9VHuNewyO_SXgsCxTukGx3-dy1lnIXC3JfM7AeA>
    <xmx:Xg9cZ1yGVOUsoXV5SY61KChfcRcK2bsULA2ztKAb4cannCa_ZUCF4OMY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Dec 2024 05:41:33 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a6c89d08 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 13 Dec 2024 10:39:53 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 13 Dec 2024 11:41:16 +0100
Subject: [PATCH v2 1/8] ci/lib: support custom output directories when
 creating test artifacts
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241213-pks-meson-ci-v2-1-634affccc694@pks.im>
References: <20241213-pks-meson-ci-v2-0-634affccc694@pks.im>
In-Reply-To: <20241213-pks-meson-ci-v2-0-634affccc694@pks.im>
To: git@vger.kernel.org
Cc: karthik nayak <karthik.188@gmail.com>, Toon Claes <toon@iotcl.com>
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
2.47.1.668.gf74b3f243a.dirty

