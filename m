Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7D536B07A
	for <git@vger.kernel.org>; Tue, 17 Feb 2026 13:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771336726; cv=none; b=IRsWpcHfaxEaE267ubvjoPMPCdZta6H0rkFSSfFhAxJKd0B2DeS7PAeDxLM3wEaE/uhJXBu6NrMpyY/eck3op65SttHUrRl9cW42NC1H3Z2R/ab4qFnRftHqnycj0rlsPdwhphnAK11bS4dtQoU6V5AAYSboDL50xO60ceM9GHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771336726; c=relaxed/simple;
	bh=VhZm8Sx/tsuMqchy2mAtFP/TbG/Mt4bNBrfIstpicY4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dKTuey/AkyUvO0gijM61XpxJvIDcSOUOFwcdHoVzsr/eQJ3DsZBusS6sx4OxX+Ur6oJ2JdhWA+acOgk6DFxQKxWDckvj3I/zr/1PT3uP67sqPPxp6kHZhzAjK9wRxzmrES4A1VuZ2RGHYca1IhWMfBjoZcogKBuX2nzFuNL5Q+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=M/4XKnd/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ICDFTxFp; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="M/4XKnd/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ICDFTxFp"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 308841400152;
	Tue, 17 Feb 2026 08:58:44 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 17 Feb 2026 08:58:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771336724;
	 x=1771423124; bh=Ruwi/vEbh6mw1xCWW/gdbQAaJqCRSE+S8V+MhLjkmzQ=; b=
	M/4XKnd/2gXQdUf2EBUndcSqRwPdec+u5ml4Vbk5Jr44oEgrXJxDhcaXUkPQdb4C
	7s4wQXw5atbkLzeGSyVQuk/xN3KlUAGKRyL8JqdkmqU14sZvB/ZBSVpFjWOvvfKk
	x0L0sWKk0eF0ETlGiXRGu3tpEbz4j11y2nQPXhZIrOXH/0urcVSjjh3cxesdwbwQ
	UcbJenOYYd71n3gkenABzb0W+mBX6vGA8koEsUOtivDtg43oItnOZi1PNPHiMqxu
	DJz0/G4FJnedCcWVo3PwcrF22wUFFkiykBKQVCpNJr7EF0ahb5SpMzaqULgVpxGZ
	CHOTmkvxz3SeXg6aXiSr5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771336724; x=
	1771423124; bh=Ruwi/vEbh6mw1xCWW/gdbQAaJqCRSE+S8V+MhLjkmzQ=; b=I
	CDFTxFpaSK4VzrJKy0c+fPNJCk30WGbZCdwZ5aUeHPjbNYaF6BAS8boH3Jo0OTLT
	sp9FEXNLOFKfOcdroKCTFtyVm3E7dENVlW3Pr8QRw5LQFLGVhuLQyYb1RVaAcjlp
	lebnINpGooDmoRndYIi7UrE1Qv7npV5od+jq50XOAKxG5Ria9mSFTui3aCRKzTeO
	EqOFQMY79PVOoQuUlBRZxH/JtzkCQPG1EGVwoDB6vS3YFQrkEm/EDUHuFPW8m1gh
	YCAWcdaDmC1AOEnN+PAEwzQZ6REPt6F/UKA6d1huKlwyGmzT7sjqtFfkP6ZZKrGq
	gRtptOqCIcDQ4a9iG9x8Q==
X-ME-Sender: <xms:FHSUaZUnFrjaUHZRs3b1DPGExtShvwCaLXqkbLbdBaQZcZ4BTiaZtg>
    <xme:FHSUaflX7tSmecxLI6dgXBnifougX4IaSHxByUqDnXEdyisnYshk2bEbqMDghNVGd
    PV865qexx2TKLce7X4i4eDGW2AeVUB9aUAGPtIlHQ6VOpaancXdsQ>
X-ME-Received: <xmr:FHSUaTAhWghwg-UUwF6TVJP3Fo4Aep6YmZduxsuOfFoyYpMzgfplehJ3uvCyJQonk5dnZDokTiZn0wFNorF6qe0k680u5sAwLIM_6c4vwQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvudelleegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthekre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepfefhueegleehfeejkedtffehvdfhvdetfe
    fgtdduffduveevteegueeutdekhfegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhg
X-ME-Proxy: <xmx:FHSUaXeKS-gqF9849aBYGlrXqPAiLsrGjhE68p_Eols8qJznlAMk-w>
    <xmx:FHSUaWJcC4ihDhimjfK-3r1P7-3y8Qv8DVFETMaMKmiVjJJ4ta6aWQ>
    <xmx:FHSUaSdNxuVbpLcZmSbkP5Rl4eDO3gbh36yLpE-FReTop887tfgE_A>
    <xmx:FHSUaV2WSMxFWm-CXLHnHLIV3rsxSj_oeEo12rVI1LLnEe7rgSmajw>
    <xmx:FHSUaUukh1vK1zzjFyVYEds-mfOzBD1CoLNLz8q9L9zgnL4iGMqnw8HG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Feb 2026 08:58:43 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4001dab3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 17 Feb 2026 13:58:42 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 17 Feb 2026 14:58:30 +0100
Subject: [PATCH v2 4/4] t6006: don't use iconv(1) without ICONV prereq
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260217-b4-pks-ci-msvc-iconv-fixes-v2-4-25491bc8dbf8@pks.im>
References: <20260217-b4-pks-ci-msvc-iconv-fixes-v2-0-25491bc8dbf8@pks.im>
In-Reply-To: <20260217-b4-pks-ci-msvc-iconv-fixes-v2-0-25491bc8dbf8@pks.im>
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
2.53.0.352.gd1286b26eb.dirty

