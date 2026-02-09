Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8844E23A566
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 12:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770640966; cv=none; b=JQim3nrFuz68SfhXdD+D6m8i8vp9ubqmcqP73ot12RYmf3IohAyqeByKkLluPHAWCsLkGjrx8QlMG342DBKauXs8HGegvzR6+4RH+OkMrLeeMAFYkYYYGnE6Y+TmoweQP/KIA58VvQwFalfHS46rb2MHKCz5nLgaUtvl4Jdawpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770640966; c=relaxed/simple;
	bh=pSWaW6K5mSCkYQLOU5AHTaQ+V2MK8t3hn/sxA+zXCuM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CkYfY7Bl+zvZF/qO0vy/oB/HKZygs+2oV0/gnzIHv+Q7oe66eylCfDijlA4KQGOLSz/Qk7y5YaaRYaFZyA/jBqVv5hmT3BRUuGr7H9rPbqFPCqlaMXqP2dJke6dVU5Wy7VPY60T/6F//DMQFvDysEopsSie+YG9ZLGA1+YK6DGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Is0VMcyJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bMIWEA0l; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Is0VMcyJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bMIWEA0l"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DEBC67A00F7;
	Mon,  9 Feb 2026 07:42:45 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 09 Feb 2026 07:42:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770640965;
	 x=1770727365; bh=pObfoc9F7kcZ87kuPVmASy7rkBho+LAHnOa87NY6cuQ=; b=
	Is0VMcyJx6ce+ERrHBPi6WnVx6mZ+UxgiRsCbfMoEx9zM4mwrGpE+bSMGuZgf3TI
	JCm0gQBi9cyX3lAkYNYDMuu/VVkKVgH4jyZtNZHciu/L4SNE4ZIZXwoXGLWZhAp3
	qvcfH5DQXWf4Gcu+Zz3SJqgfZucCUUg6xHNrHjrYYIeD65WSf640FmxTjZKoJ+H2
	aVD68vb6uWsbfzVtW4YzoycoDB9hL++QvnfyzmEcmRJ50mKyCTcZ73DHFovxK8Aa
	HvL+WTa4LzdlVcJty4I4gOBNZw8PQIflBSSGhoZdX2bRedC23yi25nd5QT5gaOTf
	V/JMxggZQ8Le5an9eU+FnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770640965; x=
	1770727365; bh=pObfoc9F7kcZ87kuPVmASy7rkBho+LAHnOa87NY6cuQ=; b=b
	MIWEA0ln+/+qhCT6mt/7Sp2WqKPpONAMTtD4AZDAinfiQ/pioot0B1BEzrNNIXuc
	jkh154B0FUB4LBqGxirW5v+FZpciIYEKGOYpUZk1emD6w8EDy/0Ds07yrFWPYoqd
	pxjvZzciScnPDhVpmqkHu1i4GECWX9jU20nBV3rN4Lw92L6DAtczebGqFq/obvSQ
	e3qjoifMFb2c73Zjc4Yv0HjCwSeHjxbggJo65KB6FYEbNUUr+2+A2bct9b7ELpU5
	yXz7UeU5VC7dQ67hWIGneoq+8KNq472x3/JiQcx4DQRzQLZbRJMMrp3BdrpcRJn5
	jUsWEYDDwibC7DDgxWWxg==
X-ME-Sender: <xms:RdaJaSvKv6CRwQlNduw895yyfNs4E3SdhSGQQ31uVIF6bplFEGCHuw>
    <xme:RdaJaddVg0P-yDeC4UKXGXyqtKMcRw-C8W-LagNXBN4e70igEMrO9y34duX6EIdpL
    jZBnnTaiUAc9q-cShma41oTxb-TiGxFpjUXcWXxooWalM6d0mvMTw>
X-ME-Received: <xmr:RdaJabash4br6yoBwEAIL8B4lpreEyRWV1rIhv2O_KqztuM2ZbRXJyzEYQo7pvRTgMRaeX5Pdmjt4ippl745JyWcGW9_lpdqkHuYqZyk2zM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleeikeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthekre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepfefhueegleehfeejkedtffehvdfhvdetfe
    fgtdduffduveevteegueeutdekhfegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghm
    ihhlhidrohhrghdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:RdaJaYVWkmDiTjhqxOz96L5n5pKsGGv1DXi-DJ6EP-3LeACuzzbXMg>
    <xmx:RdaJaVjSbJqnE3IfvhLfJTzvXPpIbq5WFPp_qTGImIKbV6ECGZ_Rcw>
    <xmx:RdaJaeWKCFxl7NnzThZPIL_Xb2w53cSrtu-XLJO8UV3O8HZva9rv-A>
    <xmx:RdaJaUOUHVmEpd2FRn1qj97Ll173MOtG6FeF2ZofUCYws4m8HlseHw>
    <xmx:RdaJaeFJlLqyOx2z9NrO92dsZBE7_87QBEesK-JT2jnIAA4hjtMJYOzj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Feb 2026 07:42:44 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 533d4794 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 9 Feb 2026 12:42:44 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 09 Feb 2026 13:42:07 +0100
Subject: [PATCH 4/4] t6006: don't use iconv(1) without ICONV prereq
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260209-b4-pks-ci-msvc-iconv-fixes-v1-4-1e3167cd8828@pks.im>
References: <20260209-b4-pks-ci-msvc-iconv-fixes-v1-0-1e3167cd8828@pks.im>
In-Reply-To: <20260209-b4-pks-ci-msvc-iconv-fixes-v1-0-1e3167cd8828@pks.im>
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
2.53.0.295.g64333814d3.dirty

