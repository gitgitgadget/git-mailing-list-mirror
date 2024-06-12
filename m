Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D7816F828
	for <git@vger.kernel.org>; Wed, 12 Jun 2024 11:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718193042; cv=none; b=MdQ/iNaPNgjFqWtoCvSMp9qaAkpPE7JiQ/N1hhVDAyN2/JnzP1lZwKhDs3BaSijIPkp1q+hbhTpl73cfVy3qlPRsGhSHO7geaoQ5nP0x9WDfIx547muClU4+yBRvHEXzk8ETS9kR1uzd4ng13nbVsRGtStgFS/ozZP+rtNujOLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718193042; c=relaxed/simple;
	bh=u6rH9cXUJ4mH/yaXWfYXvx9dQWnVUISLySxnyp/SHHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I5a2+VQMSdkRJdqzt4/4JX3SCRf11CixJ4TayMkns5itrPBU9Lxkl5qeKOYMCXzc9MW1VK3lpFVS1dQ0XEUB/CFgK/jbnFqxh0+y5mCfhIZoubO6qMahP7Z/3gb2JHg0I2t3Z9896BC5rt+Zi0Gue+sRUp3z662T3mLZFrqzlwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dwim.me; spf=pass smtp.mailfrom=dwim.me; dkim=pass (2048-bit key) header.d=dwim.me header.i=@dwim.me header.b=QtS7zguf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WlhuKi12; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dwim.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dwim.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dwim.me header.i=@dwim.me header.b="QtS7zguf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WlhuKi12"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id D26B113801D2;
	Wed, 12 Jun 2024 07:50:39 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 12 Jun 2024 07:50:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dwim.me; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1718193039;
	 x=1718279439; bh=QC6/AqqzppyBFgICUDal1pPMJFDweIpY2y4CbylzbuE=; b=
	QtS7zgufeFp8e66Xo3XJAGL+NXZw335/GPlaHAsP4mjgMsnNeTqFZI4Mlc10nLxL
	FHTLMOCfBpLczKwx0dM9osf638xhV5zwHwx1q7tkCqfHSbT/LbGqIkR2PJIS/SKu
	Vxilq1hRptUVdvEbHHnPVxXMqthDkGVWOnUOmtIt/xn+6VRs/B201SxtfHLWB9Q2
	3/kEgCibBlmAAuJGKr8E7ugZwVVftUkknmm8/jOPlZPWLiRaMjDiO6/SGU26SR9t
	CzRTSziDssZrroOpXnLRaYCrQBr3kWCrPjq28mHfC05k8bU5yvJuwDBRaGvvmJKS
	+O8w2bPURxsIhbZcUgv2fQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1718193039; x=
	1718279439; bh=QC6/AqqzppyBFgICUDal1pPMJFDweIpY2y4CbylzbuE=; b=W
	lhuKi12XLGOSkkM2+uspDzZ8h8Ngnn61oJE3/nJHTzwgsH8ksehPJNPIAdyayiqa
	vNrs2cCtwG0WhhX85fhNqJ5V7J9j3J2HzQ2u5miFUuRwaxnScGA/JKO3oyJUv1FQ
	Zkki5VqIWkCHyjbmWTkyrczyx3gbV2hYAW6amp44t2Hq9IBcADsEiqUA3wqDYyZX
	TPjLR4WlFU0d1N/BuLKXHF8L2mhXrIccPtccg0iBmQTxRfY9rez513mqshLsKJPM
	bQTTh0DrXT269JUKUZZdPpDg8eLV60wd7FvzSToezTczRmGAmsav3M5I4c1b/FjI
	T6cqNu9+/QJ757/pg1qFw==
X-ME-Sender: <xms:j4tpZqwb-dr1oKSADZVueVRCWjS31CTFBb3SEFkFVymB-KkPEMpe8w>
    <xme:j4tpZmRsc_2d6tP53lcLTIrB2yjD79--XE08A4VMIIk1QVcyjaWFn1JILF2R-lUe2
    CpNBu0w_uUQU-_G0g>
X-ME-Received: <xmr:j4tpZsVWFzmgo4URweUSLjDTZU-FCxhgtqsHgCghy9jMwS6VvcGUNIzNFJKO3yrXe4DEbabGpzjUVcDR0ncF2o1XeqfHvNvrOLtKDlaQ4CBABNfo0A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedugedggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfgggtgfesth
    ekredtredtjeenucfhrhhomhepvegrrhhlohhsucforghrthovnhcupfhivghtohcuoegt
    mhhnsegufihimhdrmhgvqeenucggtffrrghtthgvrhhnpeelheehgfelkeevveegheetve
    eutddthfehieefjeelieeugfelvdeggfdvieduffenucffohhmrghinhephhhtthhpugdr
    shhhpdhhthhtphgupghrohhothgpphgrthhhghhithdqshgvrhhvvgdrphhiugdphhhtth
    hprdhshhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pegtmhhnsegufihimhdrmhgv
X-ME-Proxy: <xmx:j4tpZghcZF86E9Vbzwfo7zgUM-cSdadJQRxXW9BCGri6qnnO7L8bjQ>
    <xmx:j4tpZsAjDszLGzlH0GTGcuQvQS7NmsOI-EfVU09_06TFYLNCJtxKkA>
    <xmx:j4tpZhJVCoxAoZHDpCthrCD2QrfA76qQSEuRjytuE7kHPTv-yhJIJg>
    <xmx:j4tpZjD2CWQBgepnrWIYLa2HSNpaWD4KvNdpKywKzX2G1BZtZyDtXw>
    <xmx:j4tpZvPokT35lrZShCuarNVUUknLnTGS8QrkLXpxo0IX8HhkfV9ZRI5w>
Feedback-ID: ifc4b4307:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Jun 2024 07:50:39 -0400 (EDT)
Received: (nullmailer pid 1169209 invoked by uid 1000);
	Wed, 12 Jun 2024 11:50:29 -0000
From: =?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@dwim.me>
To: git@vger.kernel.org
Cc: =?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@dwim.me>
Subject: [PATCH 2/4] t/lib-http.sh: add functions related to serve-git.py
Date: Wed, 12 Jun 2024 13:50:26 +0200
Message-ID: <20240612115028.1169183-3-cmn@dwim.me>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240612115028.1169183-1-cmn@dwim.me>
References: <20240612115028.1169183-1-cmn@dwim.me>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

These functions manage the custom git serving script for use in tests.

Signed-off-by: Carlos Martín Nieto <cmn@dwim.me>
---
 t/lib-httpd.sh | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index d83bafeab32..6454300a041 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -94,6 +94,8 @@ esac
 LIB_HTTPD_PATH=${LIB_HTTPD_PATH-"$DEFAULT_HTTPD_PATH"}
 test_set_port LIB_HTTPD_PORT
 
+test_set_port LIB_GIT_SERVE_PORT
+
 TEST_PATH="$TEST_DIRECTORY"/lib-httpd
 HTTPD_ROOT_PATH="$PWD"/httpd
 HTTPD_DOCUMENT_ROOT_PATH=$HTTPD_ROOT_PATH/www
@@ -250,6 +252,24 @@ stop_httpd() {
 		-f "$TEST_PATH/apache.conf" $HTTPD_PARA -k stop
 }
 
+start_serve_git() {
+	test_atexit stop_serve_git
+
+	"$TEST_DIRECTORY"/lib-httpd/serve-git.py \
+		--document-root "$HTTPD_ROOT_PATH"/www \
+		--port "$LIB_GIT_SERVE_PORT" &
+
+	mkdir -p "$HTTPD_ROOT_PATH"
+	echo $! >"$HTTPD_ROOT_PATH"/git-serve.pid
+
+	GIT_SERVE_DEST=127.0.0.1:$LIB_GIT_SERVE_PORT
+	GIT_SERVE_URL=http://$GIT_SERVE_DEST
+}
+
+stop_serve_git() {
+	kill -9 $(cat "$HTTPD_ROOT_PATH"/git-serve.pid)
+}
+
 test_http_push_nonff () {
 	REMOTE_REPO=$1
 	LOCAL_REPO=$2
-- 
2.43.0

