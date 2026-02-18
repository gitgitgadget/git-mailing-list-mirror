Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9532F3C1D
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 04:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771389543; cv=none; b=gRi9yvhXxgN163ro7QWo9S+bfyzM+l0Xo6Gisuj4sO6hce1Zw41kmbgDLVMeTQ05Y7IW7WeVOsWHHifSSeFof/3OmFfBqOn/HiFcMnnIz1UOUqWG6QXY6T6Ugy9ybq/YWXgZrfKZFAylfzpWLgfvULosrqL3xo2h3OBaTk3TLaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771389543; c=relaxed/simple;
	bh=J8Cg1qnjv0DT2grQA+mnBW7/LHNDWgeLveRy+pUX44o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BGFPAAfeHF/96jxSY+UdBwa2BNwhq8afHEX6KuoU+k1f72HvlgQx8g8PzzR0R5AL27FpaxK8aCdFzqm7bja34wy2V3uXJdGNbgO6wrBouIbdUTqbey/Y1KF0qAZc7a7zHtA8aWLZvlaPAEKHByJa7IQ4jPRyddeCunDnkptJQUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EwSTaawE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GD8guugZ; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EwSTaawE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GD8guugZ"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 958D0EC0303;
	Tue, 17 Feb 2026 23:39:01 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Tue, 17 Feb 2026 23:39:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771389541;
	 x=1771475941; bh=J6Q0f03DpYPLSSeBtAq7wro9f+tLAx1tztAM/1wL1DQ=; b=
	EwSTaawEfO5b7kOn383II13KJJ2TJym3hLFzyOYafh5S9zoamaypTnkuX7l7XZFT
	uXl88Bcfgm4uKh2mu+cwpxT0xiEzJJOHXT1sTmfUyyGa5Eu6btr90pNAmeEZUJM0
	o7NJxf1gdvNdPzbqg4vopakQUn1vBIEW8Gf7f5X+kTeCeaNM8LkOookew35X2RUB
	RuQr1e3eoWAehGYJlowG++TUfNQCEuaQXVEIYaYHGuaTEpkCFVxsMl8reXkyAtMO
	WL+1ov8utaP5now0hALPCYnBf6ke7GvWJAD7DAvs10sBtn7aFRlOd/aBj5Jqpr3E
	FegPwaFiS2RNwQ/p8Ejmlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771389541; x=
	1771475941; bh=J6Q0f03DpYPLSSeBtAq7wro9f+tLAx1tztAM/1wL1DQ=; b=G
	D8guugZ2dNNwGRxerGwKqPFauP9/lMwJt7x4vlQI4W11TA50oU6I/5a7CdaOnaxU
	36qHx5Vu1CgngJfkO4jTRq3Ad7VYUOOixReCF+cg4LFiM1u0AKDfYmwdLNIyJO9E
	Fron3+f//4ZaD+iCfKCIe3voDmcCF5JHEvg0wCK7hp6pyj55AcTXJPYXKGaVFYeC
	/44nx871fIW83QjbEgBmDDbW6pZ8EDQaEr/6nbS6PR7Mhf9/sctXsnvcSCEtsY4V
	OWqkWLD3LYPmGZ8hzet7GGnXha2Hum98MIEjx9vLTunA6OnihcLkIjYgvlgwC0L+
	OwYS7f+pHtW+n4HNP5aWA==
X-ME-Sender: <xms:ZUKVaZ1vA8Rco9lDXOLwl7VJ5w1_w99Zgfd42Snv5jz1UW_QRrBLpw>
    <xme:ZUKVaWEzDW9gee3KDf01dtdkU4O9HUf_zsHHZbaNG3y_TcfO9CJbC6rFAnMpZZHzD
    Y0YrGUNd9pHPYIvUqveLj5Z-Ulx7nLhFwoXmZf1XYr-WGLSJAr0fDo>
X-ME-Received: <xmr:ZUKVaXj8fNSNRM87Z666ZCjj-RCD3Wek_SiMMnplnz7tizybd8zV8wh6rNgeVBoNxmgF2V5qYz7HCTyG3YbM6Scoaq1KCCBzvTZrhFs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvddujedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthekre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepfefhueegleehfeejkedtffehvdfhvdetfe
    fgtdduffduveevteegueeutdekhfegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghm
    ihhlhidrohhrghdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:ZUKVaR-YhbqPyZqvD4zClZF9L2hWEodGQx1sUSsCRcZeLj_fThXAXA>
    <xmx:ZUKVaeoc6Hnb1vQyEEdiiKuXSL_YKm_MaItSNoYvVk-JTlrBxZ3O9Q>
    <xmx:ZUKVaQ93HqNDekWbFcRdNjK1UR63Sw5srh43k2nsGDWDhBR-OqhQLw>
    <xmx:ZUKVaSXeWHIT74eg8svyE-JqvInGPXJsZAderDIko_5_jcvykXSfaA>
    <xmx:ZUKVaVOQIeegIUzlZiQ2TW8fIHQphcYCYWf1ic9gTZzLrYaWr0QY9EZK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Feb 2026 23:39:00 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9f64fc9b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 18 Feb 2026 04:38:59 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 18 Feb 2026 05:38:42 +0100
Subject: [PATCH v3 5/5] t6006: don't use iconv(1) without ICONV prereq
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260218-b4-pks-ci-msvc-iconv-fixes-v3-5-08c1ff3ffc9a@pks.im>
References: <20260218-b4-pks-ci-msvc-iconv-fixes-v3-0-08c1ff3ffc9a@pks.im>
In-Reply-To: <20260218-b4-pks-ci-msvc-iconv-fixes-v3-0-08c1ff3ffc9a@pks.im>
To: git@vger.kernel.org
Cc: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.3

Two tests in t6006 depend on the iconv(1) prerequisite to reencode a
commit message. This executable may not even exist though in case the
prereq is not set, which will cause the tests to fail.

Fix this by using UTF-8 instead when the prereq is not set.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t6006-rev-list-format.sh | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index eb93d68d7d..581984467d 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -378,15 +378,23 @@ test_expect_success 'rev-list %C(auto,...) respects --color' '
 	test_cmp expect actual
 '
 
-iconv -f utf-8 -t $test_encoding > commit-msg <<EOF
-Test printing of complex bodies
+test_expect_success 'setup complex body' '
+	message=$(cat <<-EOF
+	Test printing of complex bodies
 
-This commit message is much longer than the others,
-and it will be encoded in $test_encoding. We should therefore
-include an ISO8859 character: ¡bueno!
-EOF
+	This commit message is much longer than the others,
+	and it will be encoded in $test_encoding. We should therefore
+	include an ISO8859 character: ¡bueno!
+	EOF
+	) &&
+
+	if test_have_prereq ICONV
+	then
+		echo "$message" | iconv -f utf-8 -t $test_encoding >commit-msg
+	else
+		echo "$message" >commit-msg
+	fi &&
 
-test_expect_success 'setup complex body' '
 	git config i18n.commitencoding $test_encoding &&
 	echo change2 >foo && git commit -a -F commit-msg &&
 	head3=$(git rev-parse --verify HEAD) &&
@@ -448,7 +456,12 @@ test_expect_success 'setup expected messages (for test %b)' '
 	commit $head2
 	commit $head1
 	EOF
-	iconv -f utf-8 -t $test_encoding expected.utf-8 >expected.ISO8859-1
+	if test_have_prereq ICONV
+	then
+		iconv -f utf-8 -t $test_encoding expected.utf-8 >expected.ISO8859-1
+	else
+		cp expected.utf-8 expected.ISO8859-1
+	fi
 '
 
 test_format complex-body %b <expected.ISO8859-1

-- 
2.53.0.414.gf7e9f6c205.dirty

