Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858003B2FFF
	for <git@vger.kernel.org>; Fri,  3 Jul 2026 09:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783070676; cv=none; b=QOBSQjIDKVlSDyYeBpVB7iUOCcgsPxfTOmONaWDZuF8KwQFH9zAzLryW02F+q1nHerTBQjJyBJkm1Xnh/b6EY3+VS09QojRoUnCHoqsmrnnSatDxlaW+M9se3uiVumMXrlj6Uh08ZyNQ2aNSglb1D0eHqXmiEkLfC6+HQ0MahUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783070676; c=relaxed/simple;
	bh=Jl3GJIY7/9cDbfjCrlNi2BHzibY3HLXyycIm+bl+j9I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RNUaviDIS7fAH5zKFWnqloNst5pHSzEE72hfM7d1nfYDEvCO4aWjfObPN+7+xsUgczNFf+HCeoAEhdQ22OOc7fZY47rVtHZWfxXJm6YWd1IYGHVLbXP9dKOM1YpOIFS95r0qWvBI1FhEoH4ihtNgwwuBXX22D7eoU644Ed1HCLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OFjXE9st; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I20BCmHe; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OFjXE9st";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I20BCmHe"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id DD8901D00104;
	Fri,  3 Jul 2026 05:24:34 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 03 Jul 2026 05:24:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783070674;
	 x=1783157074; bh=Bi22qJ+c5ZltwLA6XIbB/YqHsWgC1UX0IgyRBEk6Oz4=; b=
	OFjXE9stfXDsoKi1RfpMvZn199Mp1O8Bt5z4Y/7aDbQn+t9tFtjuvz7RW35dHDjC
	1rGjRIIYbWHipRcrovsBNwLhqGSnByg+J12fRv1OjR9JjEQdyHtxH5AL0iDvKscD
	ZJMfc2wmgKkxjyPxtd4Y399doDa4J2mXdFe1k3ipKnVaVZ9PLikTSEvtcY2jyjs4
	WE8AM+KzwTkAVoRwCc2OVgb7IqqvXtGgCVK+RQOVCjaJQoljYtX+NGduEAshWCmD
	CspKPIn+XYjx7NA70Yvx9+qBpUAN7kwUP27Twtra/1cKMbbL/Hkj4tzGsKcU0lqS
	VtOhkRUB6TiT6/MX3ZlIxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783070674; x=
	1783157074; bh=Bi22qJ+c5ZltwLA6XIbB/YqHsWgC1UX0IgyRBEk6Oz4=; b=I
	20BCmHebmMC2S7o8bJi54jk/iiPFJrKE6Ko6LSq86nfYIpAPlpmGETNqAhzzAx1M
	s200sEder05cFbMyDMFIcBHS+FXbexKym3A6NewmiUNKneR8ioZbJEnD87+hS0UI
	4aegxUjkVhKhm8ZkyUvvkNnPE652znZil5EVna/i/dgpgM79eOuBb9wIZ0Vm5w2j
	jXN4f6TgNDflEFPuvLZheYL1eDNpc2+GCDT8MGY6log3rmNP45lXg1YO5mWipiWs
	yiiwxnwXqMy8QRbxHGiMRrSBmx8Eob2Z4qHcbliFgTiqChlZEUEDajGTG8DY9aaC
	Z0EokeA3tQZ1bx4uINnJg==
X-ME-Sender: <xms:0n9HagPjcK9jHAJZPnmLyvu87dmT2uEApiql9V8TFHcwazHK9exxUg>
    <xme:0n9Hat1A9hoK079FUBGbhmnLAipkTiArtQJtnOBFLl4WfyhyoVMU1Fy19c3qDqR7w
    bdBE3vJy7Xs_PuCJ8TLFKhtBFKhMz7oqLGUySjpaITJWSVumIq2-w>
X-ME-Received: <xmr:0n9Havm-7s1bmNEl5JBXKD2rkruecfpsj4mR90nAIuMKvChp13PvKKEYDC45eVq0tsvoaSIaVHtNgOrZTN9-7ElvsTJSZbK1MdSe9HZPEQ>
X-ME-Proxy-Cause: dmFkZTFabOOUVHYlTeQsMyAH9bXrP5tP4g7TtI3YXPU6qVJW4xybcjXGcBB/d8YFFD7PDR
    GTJjJMQxG1Ep7ek5Q1B6kLNCuwqHXKZCZWD+f1ToEimbdsAr40LcQqtlyZ/JP74GDKow+/
    0P4OGksevwqrp91fLzDIejw9a76MnFa/K8dWxX8sI/E8Kbm9p11kbry+Y0hW3sEUidMCgC
    VgnC8Dd36aIefh/M+PX4rviAZjFZBP8NdGjxQVD7ISek+/7q5NmRWLoh9GoDXr1NaZFkkE
    WlA0826UkfsEvcde54s5mb+xh9UY3S2PlDRow5BPBzMzn8O68BFXw6a3WVlDwlIYNlekKn
    hhlpbahzQRCaT9C1Z27U4v8tWt1AH6BwPgxSzWnVeDL417GPFgiWHwJPcrYLxRh5KCqHkk
    /NyBcWyF08ZhjxnvsmNKcwerchsx0JtwzRU0jeSZ19dp7UjCZV+PgHcQ88bwqJPRcCuMuw
    3N1FXiKieRIJSv52cGmOrmQJqP4KbHHFoU+ChrmKdUK9oS1Ox+8R4kCXX7OvGsg/ArSeZT
    qSHzKLN6UVwPy1mK6MlA1vUjpE2afg9U8VuQRsyoCFBAcnvims7IC+CqsqoDhHeaFag4+w
    FEu3b1beNlMnoLi2Ut3w+vcULYQpCILQoVtPcjnc7VdfW547gJgLP8CVcIhg
X-ME-Proxy: <xmx:0n9HakUwaK-lqAg38moRf2Z4RHctJpztvoMwDjfpAGgxsgWQR8_IaQ>
    <xmx:0n9HaltIbNWbeBws9Q-3N1Z-lvF7Jlv25OoqfFQzCGxov9Arp2B9VA>
    <xmx:0n9Hanbq_MlsS35TdS-y64dlXCLxxaSiZ4hg5uCgxE52WjNn-1EmDg>
    <xmx:0n9HakUgVwqLKT0gVBK34PSjUZE6ZuJjF6PaiGsnX3QuzEGuHi8gbw>
    <xmx:0n9HamR1Vq93gmznxEeNAs5wcJ6-6G7OaP1zdk-7i46cyDVld5r6QZ8l>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jul 2026 05:24:33 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id dd03851f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 3 Jul 2026 09:24:32 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 03 Jul 2026 11:24:10 +0200
Subject: [PATCH v2 7/9] t: use `test_bool_env` to parse GIT_TEST_LONG
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-b4-pks-t-fixes-for-GIT-TEST-LONG-v2-7-79076a7e0c62@pks.im>
References: <20260703-b4-pks-t-fixes-for-GIT-TEST-LONG-v2-0-79076a7e0c62@pks.im>
In-Reply-To: <20260703-b4-pks-t-fixes-for-GIT-TEST-LONG-v2-0-79076a7e0c62@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Jeff King <peff@peff.net>
X-Mailer: b4 0.15.2

It's currently hard to explicitly disable GIT_TEST_LONG by setting it to
`false`. Fix this by using `test_bool_env` instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/lib.sh     | 2 +-
 t/test-lib.sh | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index b939110a6e..01a0bc6b75 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -321,7 +321,7 @@ export SKIP_DASHED_BUILT_INS=YesPlease
 # enable the long tests for pushes to the integration branches as well.
 case "$GITHUB_EVENT_NAME,$CI_BRANCH" in
 pull_request,*|push,*next*|push,*master*|push,*main*|push,*maint*)
-	export GIT_TEST_LONG=YesPlease
+	export GIT_TEST_LONG=true
 	;;
 esac
 
diff --git a/t/test-lib.sh b/t/test-lib.sh
index ceefb99bff..623fcfb747 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -210,7 +210,7 @@ parse_option () {
 	-i|--i|--im|--imm|--imme|--immed|--immedi|--immedia|--immediat|--immediate)
 		immediate=t ;;
 	-l|--l|--lo|--lon|--long|--long-|--long-t|--long-te|--long-tes|--long-test|--long-tests)
-		GIT_TEST_LONG=t; export GIT_TEST_LONG ;;
+		GIT_TEST_LONG=true; export GIT_TEST_LONG ;;
 	-r)
 		mark_option_requires_arg "$opt" run_list
 		;;
@@ -1849,7 +1849,7 @@ test_lazy_prereq AUTOIDENT '
 '
 
 test_lazy_prereq EXPENSIVE '
-	test -n "$GIT_TEST_LONG"
+	test_bool_env GIT_TEST_LONG false
 '
 
 test_lazy_prereq EXPENSIVE_ON_WINDOWS '

-- 
2.55.0.795.g602f6c329a.dirty

