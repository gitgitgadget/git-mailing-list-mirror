Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA1626AA91
	for <git@vger.kernel.org>; Fri, 24 Jul 2026 00:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784853661; cv=none; b=s2yuqDi7n+rkO3nLj2TQwlyuC33dTaQW/93XyeFL5+QtzXODlZS4m5wHA2t59ID02aApuXyFWOpfZFKoq/J7fLXmCq3vmh2ckaD7oOoLbCIy7MAAYtgoU5ztkm60iLMBRcYY5JyDkAmEZ4uYHQgUBBdOcjRkBo0EhhxEae2iDys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784853661; c=relaxed/simple;
	bh=xm+9oHIy+QzTZymZvhlVX6yf4Pk8AKaOdiLybdyv6og=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rp8kGD6jAKlPnFKn8Tr9GKZqF8wWUMYKlhtxRq3kBNA7VqLiJVRNlGIKS4TCRXAlXvZCUnWY8IAhGNTBmML6VhoE0eczO7MCwF+QcCWh7vvqbFImiJ96J4Gut69TRUM1L1zliZ29kgeHZF3gJLUaMESgdYlvRUfJnLMB8tKJ3/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=ODbL993N; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=beXvHpsl; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ODbL993N";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="beXvHpsl"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4h5q0n4CWszKmGs;
	Fri, 24 Jul 2026 02:40:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1784853657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=49Oh9B3S5OJEssCQZGzg53UEUKStnAgBaNfyq1Va4Xs=;
	b=ODbL993NqW2zYaxy1+mva2G/EVNkAoZ5fT1pGowWafcM0C5gs1s2ZfCwRvFaP6leZc/Rjd
	MVmUkWKVAVffgMhHXNGt5wLAu66uvRWJoj9NBAdYT7ptp4RcNSTQXT4P+XwRnn2jw0t96Z
	vv45FB+Ka9quGBeCgY8aTt77YOAFyNh16tKGHiUB8PT2E/XbJvvnPDwNDytQTRc4BzMpQJ
	LVTRGug87JcCSNJlp8G/Qx0xrlL2GlnyCFnGQyVn1lgNVMq/772oP+buPqXnTDvhryDGEv
	bTlyK58Tfox+jkFrzCg5eLescs6osej3LMwpEeSK1q/naeq1/j4cIb9PSAVsVg==
From: =?UTF-8?q?Fabian=20Pottb=C3=A4cker?= <fpottbaecker+git@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1784853655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=49Oh9B3S5OJEssCQZGzg53UEUKStnAgBaNfyq1Va4Xs=;
	b=beXvHpsleQ77SwbgiqTPKRyB5EVJFOQuG6Ejq0ltc2kHsvDJuK63zl2wb/bJqpZD9NQMzF
	ci1w7zP2v8VbsxVAhvgDjeLm53txUTmaRNXaOtBwxNdwHbjXIGdzJx1B2wal88fHf7l+Ib
	ps0YmVhVQ8G12mxU+Rzx09uq07IvrBv7MTm1OdAl77fQEStzBFRKD/W82SEJr9ZjGDiPZZ
	VIEuLjmR4VGbJvHQ5JEvGhDpgwesb5XbuptBs88HTahBpv9auYGZCy+MgU9R3RKGO21JXL
	Z1vj6Tl+sVpmuFYLoMzloQq+eeujSjGszYRF2NFicchHI1W4HpFr0JfbGgmPWw==
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	=?UTF-8?q?Fabian=20Pottb=C3=A4cker?= <fpottbaecker+git@mailbox.org>
Subject: [PATCH 3/3] config: use url_parse for --url
Date: Fri, 24 Jul 2026 02:40:11 +0200
Message-ID: <20260724004011.41795-4-fpottbaecker+git@mailbox.org>
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
X-MBO-RS-META: uezp8dg84cebq66j7hxh3tc65pxn4mei
X-MBO-RS-ID: 108d7999dcee6e332b4

This enables the use of the scp-style URL syntax for this option and
the depracated --get-urlmatch. Since URL matching was primarily used
for http(s) transports previously (with the potential exception of
promisor.acceptFromServerUrl), this has little internal effect and
mostly brings the behaviour of this URL argument in line with other
commands.

Signed-off-by: Fabian Pottbäcker <fpottbaecker+git@mailbox.org>
---
 Documentation/git-config.adoc |  5 ++++
 builtin/config.c              |  2 +-
 t/t1300-config.sh             | 44 +++++++++++++++++++++++++++++++++++
 3 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-config.adoc b/Documentation/git-config.adoc
index 57af010ade..a38d68512e 100644
--- a/Documentation/git-config.adoc
+++ b/Documentation/git-config.adoc
@@ -143,6 +143,11 @@ permitted).
 	<section>.<key> is used as a fallback).  When given just the
 	<section> as name, do so for all the keys in the section and
 	list them.  Returns error code 1 if no value is found.
++
+This option supports all URL formats (see linkgit:git-fetch[1]),
+unlike the config file URL syntax explained in the `http.<url>.*`
+options, which requires an explicitly specified scheme and does
+not support the scp-style URL syntax.
 
 --global::
 	For writing options: write to global `~/.gitconfig` file
diff --git a/builtin/config.c b/builtin/config.c
index 8d8ec0beea..b5488a9497 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -870,7 +870,7 @@ static int get_urlmatch(const struct config_location_options *opts,
 	config.cascade_fn = NULL;
 	config.cb = &values;
 
-	if (!url_normalize(url, &config.url))
+	if (!url_parse(url, &config.url))
 		die("%s", config.url.err);
 
 	config.section = section = xstrdup_tolower(var);
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 8310fe6a65..477e030cf3 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -1907,6 +1907,50 @@ test_expect_success 'urlmatch' '
 	test_cmp expect actual
 '
 
+test_expect_success 'urlmatch with scp syntax' '
+	cat >.git/config <<-\EOF &&
+	[section]
+		flag = false
+	[section "ssh://example.com"]
+		flag = true
+		key = value
+	EOF
+
+	echo "fatal: invalid URL scheme name or missing '"'"'://'"'"' suffix" >expect_err &&
+	test_expect_code 128 git config --bool --get-urlmatch section.flag example.com >actual 2>error &&
+	test_cmp expect_err error &&
+	test_must_be_empty actual &&
+	test_expect_code 128 git config get --url=example.com --bool section.flag >actual 2>error &&
+	test_cmp expect_err error &&
+	test_must_be_empty actual &&
+
+	test_expect_code 1 git config --bool --get-urlmatch doesnt.exist example.com: >actual &&
+	test_must_be_empty actual &&
+	test_expect_code 1 git config get --url=example.com: --bool doesnt.exist >actual &&
+	test_must_be_empty actual &&
+
+	echo true >expect &&
+	git config --bool --get-urlmatch section.flag git@example.com:path >actual &&
+	test_cmp expect actual &&
+	git config get --bool --url=git@example.com:path section.flag >actual &&
+	test_cmp expect actual &&
+
+	echo false >expect &&
+	git config --bool --get-urlmatch section.flag https://example.com >actual &&
+	test_cmp expect actual &&
+	git config get --bool --url=https://example.com section.flag >actual &&
+	test_cmp expect actual &&
+
+	{
+		echo section.flag true &&
+		echo section.key value
+	} >expect &&
+	git config --get-urlmatch section git@example.com:path >actual &&
+	test_cmp expect actual &&
+	git config get --url=git@example.com:path section >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'urlmatch with --show-scope' '
 	cat >.git/config <<-\EOF &&
 	[http "https://weak.example.com"]
-- 
2.50.1 (Apple Git-155)

