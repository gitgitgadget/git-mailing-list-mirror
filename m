Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DF63CBE66
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 06:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783319067; cv=none; b=IwMGhXfQE2l3JkXYaYUgBfw9ERwSLB5bwEt7eaFTVLuIc9LEafDwK+XMjTOIoeQiwuDHWVLyCZuRoNwi4K0rcMwonGf/ZGavOGq7qlbDfokLBUruxQ7YsTsaE2OfP5dLjkE+sNdv+5BLCMlKSV2BT7x+bE2DKRbWYMQhTJ7072Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783319067; c=relaxed/simple;
	bh=sLwjvmafoDo5UaowhNntjxfWTFcn54ClAuNuhJKwGPE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TdECTXTjqmt5bqlwaAf2mE2cPiywQpNwvp3NJptTNd7oO1AVErmXOOrCcyB2ktGySccb7bHkDTkDSK6qjEitd4oynaiO9M8hyiNjT1SrDT8SpHBvTrHsl+SDrX3mvRCH5/oCCeP/56j3wzdmpVIr/9tZw2lfMeZ+2w7ZJOuelg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lTsWNtkf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mPo/UUZp; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lTsWNtkf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mPo/UUZp"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7426C7A00DD;
	Mon,  6 Jul 2026 02:24:18 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 06 Jul 2026 02:24:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783319058;
	 x=1783405458; bh=fiFrhafz6OObCTYSBJtLK2LjjZtkJuNknazpaNjGclw=; b=
	lTsWNtkfUkr6jK3BCttiKOIHmcKElR+vmGrmPgripwwAATrb83i3YXiBtXCD3CWN
	YlAKgLr0nq40XNuygmpJeNrlrw4MEr8O4785cIRbIp74Na0GZEIiW5EUIGK/WI6F
	xY8LQfR9i1xVB4ZHVBXT7+HqRl75Y5fgvb1BGRMITgjguMsRkw6apax9t1Z76Uai
	xJqlUOnqNehs2MlUSu9rmwZWwZGo6DIqCB01a5cHeXrcXPAwTOFQr1PfSZ/0Ap8A
	MmiPLG65RIr4s+vgk/FQstwOQTu1pD43+D9ARVoQX4iXC39MPKo3F2lBw61OOQKt
	Uhg1SX0tD61KAiAeVahPTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783319058; x=
	1783405458; bh=fiFrhafz6OObCTYSBJtLK2LjjZtkJuNknazpaNjGclw=; b=m
	Po/UUZpDruFhXq2XPhMdQdZ2OwJN99yRaRdcw22jh5f6fwTEn55QM+16N9oFWNO6
	gQh/YVotJcNPANNV9JESXHld1pQ2Ul/668YoE4kZg+JVumnHLUsZBMFO7Cnu3ia+
	3aXjQyedaEQqU4uHZcwSJwY9rrQAfSELb0E0OFKQRoaiBAZNDlZER5GfJXpgzvOe
	2enQMWiapdr9zjXHN3zRf8E3teLLrQEwsySZYR73ZzSeg43fiGCBbomRQ+m0XQT3
	E5ChRH8JS8pT1TrJNg+silXpFoLtfaBmRubVEAsRd5NTUXKUoXVa0mMU5RmC3WPo
	rLm7bhblk0KBcBgAXPV2w==
X-ME-Sender: <xms:EkpLauU7sWgd2H1ypxeqQMAoeTZqIe4vM7cHtRviPC2hDwpgRqJq1A>
    <xme:EkpLahclj7et5wS2Ur_ZzV0GOow2tcbcPI8Ejjhn7pU1A6H2VyompSZwvq4RVqOCK
    IfYKestUTvXMLO4dz8x25VBKKAKhEXhZygR7iEIgxp18Jw_sg3mNJ8>
X-ME-Received: <xmr:EkpLaqsHjIkaVKXkD26-kUjXCvNXIQDc52WGq2vxmcocWOKbiIv652Ov2tHXfkk4omHmrSXcRkmNOC_gdWDk5MYfOcS6Q7FZjaEqXLcFEe4>
X-ME-Proxy-Cause: dmFkZTFexpsNN8+D1iB4kmccXHNXSwz7Jj2Jci0dIahDOLBK3JR9GzpNXmk8ZjVQMNuAiz
    NbxPUSm/PPCoV5/3Ush0TGdOppTlxnJBxvn7l+1vf0sw9WBdKEtSWeUoeOI8fST8Mn4Nhv
    qjSftjyM2Tm9bdl+gmtQ8CVkJ6YNokwW2zLSkH4xJ27EzwvUZ/SzWJEQ6+9g2PMn/YNd1X
    gwXl+0oCzj2ubEWj5XVNiCl0luAzOyh3YEPf/A72yEFJNE0KGPybhEUrD1QNfTKFPzlhBL
    Oz6CorBRX/mF1rpMTmdXsbloSzqKJjGhncv6qKPHwGyHHt4/5bePAsn+WRPDLz0/8nkCKB
    DbYESTworNIFDLrIpOPJ0N6zGvYW5emkfyEiT2YUJx9hzor/BT2qr5N8ZrhdCvJ4glqs8g
    m5T38uL7ZI0Tk/2a1Fa0/NFKkqZIg2WjCOK3Ncn0z2kecafCz/Y4bDw4+1T7XZGd3QFvkN
    4yLO/zsGi6Wxlfw+XfBMLKUJYsgEOMlkgVmkJ1G6mKer0unJTOa7m4wlbIBpTmD5CRQdIm
    h/EZAMHphvfh0sejQ0GLNXDzM6L8hRn19SgStdyZuz05Pn8RtcXRi+Ut5Bu2YOF6I9zEAM
    n/vRxHoG5wLZsjNzbulwdPtb2CIW3JdDCYBlrQVbxP8Ov5pvvpwng3PktnrQ
X-ME-Proxy: <xmx:EkpLag8QyEAkq42VTpL9puvKnqi0EPsQR4NNvWMqP3pa8LhZ6yndWw>
    <xmx:EkpLal0NhlggOfMZdtklkzb2cwnJlizSnRPunVyDVVCKH5dM8H6flA>
    <xmx:EkpLalCYzRykRAtZNMODD4ZABFpeHs5UnrPlGhFZonqFrzSN4-T3gg>
    <xmx:EkpLahcCWxr1TSCispLhTsprxxAgo8ZLnaOVuuBwnnIDulZK2unDSw>
    <xmx:EkpLaiZqfpfLVnSbK789lDER6pxwNkssxtwiHzyDNWNyHf8LXtU7ewtZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jul 2026 02:24:17 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0eeb71c1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 6 Jul 2026 06:24:16 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 06 Jul 2026 08:24:01 +0200
Subject: [PATCH v3 6/9] t7900: clean up large EXPENSIVE repository
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-b4-pks-t-fixes-for-GIT-TEST-LONG-v3-6-4f6c5a37fd1f@pks.im>
References: <20260706-b4-pks-t-fixes-for-GIT-TEST-LONG-v3-0-4f6c5a37fd1f@pks.im>
In-Reply-To: <20260706-b4-pks-t-fixes-for-GIT-TEST-LONG-v3-0-4f6c5a37fd1f@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Jeff King <peff@peff.net>
X-Mailer: b4 0.15.2

One of the tests in t7900 is marked with EXPENSIVE because we create a
repository with 2GB of data that we end up repacking. We never clean up
that repository though, so we occupy the full 2GB of data until the end
of the test suite.

Besides clogging our disk, having an EXPENSIVE test that alters the
repository's state used by subsequent tests is also a bad idea, as it
can easily have an impact on the heuristics used by other maintenance
tasks.

Adapt the test so that we create the data in a standalone repository
that we clean up at the end of the test. While at it, also disable
auto-maintenance so that it does not race with our manual maintenance.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t7900-maintenance.sh | 56 ++++++++++++++++++++++++++++----------------------
 1 file changed, 31 insertions(+), 25 deletions(-)

diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index d7f82e1bec..8a7e1306d0 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -461,36 +461,42 @@ test_expect_success 'incremental-repack task' '
 '
 
 test_expect_success EXPENSIVE 'incremental-repack 2g limit' '
-	test_config core.compression 0 &&
+	test_when_finished rm -rf expensive-repo &&
+	git init expensive-repo &&
+	(
+		cd expensive-repo &&
+		git config set core.compression 0 &&
+		git config set maintenance.auto false &&
 
-	for i in $(test_seq 1 5)
-	do
-		test-tool genrandom foo$i $((512 * 1024 * 1024 + 1)) >>big ||
-		return 1
-	done &&
-	git add big &&
-	git commit -qm "Add big file (1)" &&
+		for i in $(test_seq 1 5)
+		do
+			test-tool genrandom foo$i $((512 * 1024 * 1024 + 1)) >>big ||
+			return 1
+		done &&
+		git add big &&
+		git commit -qm "Add big file (1)" &&
 
-	# ensure any possible loose objects are in a pack-file
-	git maintenance run --task=loose-objects &&
+		# ensure any possible loose objects are in a pack-file
+		git maintenance run --task=loose-objects &&
 
-	rm big &&
-	for i in $(test_seq 6 10)
-	do
-		test-tool genrandom foo$i $((512 * 1024 * 1024 + 1)) >>big ||
-		return 1
-	done &&
-	git add big &&
-	git commit -qm "Add big file (2)" &&
+		rm big &&
+		for i in $(test_seq 6 10)
+		do
+			test-tool genrandom foo$i $((512 * 1024 * 1024 + 1)) >>big ||
+			return 1
+		done &&
+		git add big &&
+		git commit -qm "Add big file (2)" &&
 
-	# ensure any possible loose objects are in a pack-file
-	git maintenance run --task=loose-objects &&
+		# ensure any possible loose objects are in a pack-file
+		git maintenance run --task=loose-objects &&
 
-	# Now run the incremental-repack task and check the batch-size
-	GIT_TRACE2_EVENT="$(pwd)/run-2g.txt" git maintenance run \
-		--task=incremental-repack 2>/dev/null &&
-	test_subcommand git multi-pack-index repack \
-		 --no-progress --batch-size=2147483647 <run-2g.txt
+		# Now run the incremental-repack task and check the batch-size
+		GIT_TRACE2_EVENT="$(pwd)/run-2g.txt" git maintenance run \
+			--task=incremental-repack 2>/dev/null &&
+		test_subcommand git multi-pack-index repack \
+			--no-progress --batch-size=2147483647 <run-2g.txt
+	)
 '
 
 run_incremental_repack_and_verify () {

-- 
2.55.0.795.g602f6c329a.dirty

