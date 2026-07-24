Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074B82561A7
	for <git@vger.kernel.org>; Fri, 24 Jul 2026 00:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784853660; cv=none; b=ADWSy0QG9F2KQVf4AckZ7OZsAM0TFEdQfT2hqujw5wkJ6Rk2QKaIJ34dE6jCZzBFRVplq6jHRKrxPs/3oRlSu5LTrj+JBZalamxkaDSiAdBup1yQCnxXyl2zBdp3z6xf2EF2W3KWm359K76gH72eFbG4vvSFKCuxnJ7mbdDXERc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784853660; c=relaxed/simple;
	bh=Lh3x19G9V4rpHFa/ZZFP4UlD8BVBIS6/di19E7CES0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cmcu5iZTPKFYPJ3jCUBx7YOIcN8OZZm+eji+59/an+SSEftBgyuMRvF3iC5WR+QYMq17UxVk4p/pebwhaHijbuAox9yEQjW2QkaarbEu5LnCfWdO8DC+R1VL90FbFSm2sE/hwEE2WnL0JEZQna30UBT/DM2vqPzHckVgNfz2Hws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=wUB/Z5pb; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=PjooR0Pk; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="wUB/Z5pb";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="PjooR0Pk"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4h5q0m4lkhzMlKH;
	Fri, 24 Jul 2026 02:40:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1784853656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PmdPj8mRPDP0MrGA1CB5Hen8LjKS1uYN0wChqAQd8Wo=;
	b=wUB/Z5pbpOxzr1Q/Z/Hycoad0CcyPZq3EsQ0HpO9HH7Z0YH02wYbnROD2eFBisYAdVtRvc
	uYysaoM0Y5AYWPWCLweM48WejJQVk1nWe/IBLXwql3wLxgW+cgSSQhL3bogMjy19mWmytb
	0jvCn4EXVQDcnJ2iJY37OTWDlhM5GcFlMcsn6bLWc3cRb07mO9y+n+Y387Q8T1THJOAZF2
	kgO3b16dRaXhdawMXP8MQWux4nC4MEuVvgGuIOMHBAHOV+bXaVAyMXq/UzV5FAXoJeiCQ0
	mq1vVrxOUwLSqebnKwNjsGCV+XgAKmP4mkngCTElYSbdeEEQKAnaPnflAdoJdQ==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=PjooR0Pk;
	spf=pass (outgoing_mbo_mout: domain of fpottbaecker+git@mailbox.org designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=fpottbaecker+git@mailbox.org
From: =?UTF-8?q?Fabian=20Pottb=C3=A4cker?= <fpottbaecker+git@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1784853654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PmdPj8mRPDP0MrGA1CB5Hen8LjKS1uYN0wChqAQd8Wo=;
	b=PjooR0PkXMYyt8m3HCeV4xdjrpc3PFoUE5gBNb0Bs7CjGyhqT6gZB7+FO6b73ojxTrVXWj
	8FC/CNoCSLr7iPHPCGU8XyJ5a6Q/6DLMDMSoOor1oNrj2u3OboRCIH1v0am9ihZPF7D9Mm
	F7ZEPyeoT1B4RaYxdF76fuQWnQ8MgjYzNuDhtHbh1n5BOdGLN2oDHbXrrQ8Bl6ZIgZjzZe
	cM4efDXQb6QLoqI6O89N0kZ0KX8ZcAgfwU8wpctGzIKtXlut6eljK+H9nuZFtFoKl9E8mX
	o3PatwC2sjLbRdAs2tvJRLt9tDFeeRjewB6bS+2nhGIaZ4nz5FgrevN/IVW5oQ==
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	=?UTF-8?q?Fabian=20Pottb=C3=A4cker?= <fpottbaecker+git@mailbox.org>
Subject: [PATCH 2/3] t1300: cover --url for some --get-urlmatch tests
Date: Fri, 24 Jul 2026 02:40:10 +0200
Message-ID: <20260724004011.41795-3-fpottbaecker+git@mailbox.org>
In-Reply-To: <20260724004011.41795-1-fpottbaecker+git@mailbox.org>
References: <20260724004011.41795-1-fpottbaecker+git@mailbox.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: d3d8f08cdf5e217de38
X-MBO-RS-META: wzhx5kfpswckyubtdxhuykofu4royxtm
X-Rspamd-Queue-Id: 4h5q0m4lkhzMlKH

Signed-off-by: Fabian Pottbäcker <fpottbaecker+git@mailbox.org>
---
 t/t1300-config.sh | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index b99f782d5d..8310fe6a65 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -2028,22 +2028,32 @@ test_expect_success 'urlmatch with wildcard' '
 
 	test_expect_code 1 git config --bool --get-urlmatch doesnt.exist https://good.example.com >actual &&
 	test_must_be_empty actual &&
+	test_expect_code 1 git config get --bool --url=https://good.example.com doesnt.exist >actual &&
+	test_must_be_empty actual &&
 
 	echo true >expect &&
 	git config --bool --get-urlmatch http.SSLverify https://example.com >actual &&
 	test_cmp expect actual &&
+	git config get --bool --url=https://example.com http.SSLverify >actual &&
+	test_cmp expect actual &&
 
 	echo true >expect &&
 	git config --bool --get-urlmatch http.SSLverify https://good-example.com >actual &&
 	test_cmp expect actual &&
+	git config get --bool --url=https://good-example.com http.SSLverify >actual &&
+	test_cmp expect actual &&
 
 	echo true >expect &&
 	git config --bool --get-urlmatch http.sslverify https://deep.nested.example.com >actual &&
 	test_cmp expect actual &&
+	git config get --bool --url=https://deep.nested.example.com http.sslverify >actual &&
+	test_cmp expect actual &&
 
 	echo false >expect &&
 	git config --bool --get-urlmatch http.sslverify https://good.example.com >actual &&
 	test_cmp expect actual &&
+	git config get --bool --url=https://good.example.com http.sslverify >actual &&
+	test_cmp expect actual &&
 
 	{
 		echo http.cookiefile /tmp/cookie.txt &&
@@ -2051,9 +2061,13 @@ test_expect_success 'urlmatch with wildcard' '
 	} >expect &&
 	git config --get-urlmatch HTTP https://good.example.com >actual &&
 	test_cmp expect actual &&
+	git config get --url=https://good.example.com HTTP >actual &&
+	test_cmp expect actual &&
 
 	echo http.sslverify >expect &&
 	git config --get-urlmatch HTTP https://more.example.com.au >actual &&
+	test_cmp expect actual &&
+	git config get --url=https://more.example.com.au HTTP >actual &&
 	test_cmp expect actual
 '
 
-- 
2.50.1 (Apple Git-155)

