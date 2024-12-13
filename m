Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2D81C3BEE
	for <git@vger.kernel.org>; Fri, 13 Dec 2024 10:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734086501; cv=none; b=jOQWlhrEn3vx1ACx5MPR8RuCSGhaEzUhzJPSZtiKoNpTVdbjeYnPx5kgMY8EGp/hFUBL+ZBUMOhuakUZuGR6UdHd6iJtLkWc+uQgQ0vBeRk+WQ09khCM2NFYEhm1P+8hOOciejrUtzmqeTR1s/UVzzwaHbJFtwCXqyHcmeRbqFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734086501; c=relaxed/simple;
	bh=KOUC7fhPHQgcCZtFz0bOOvhhbGmqWBFtXGhYv002YcI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jt9rJ06+Q4dsX2d37LebxeVcnXMockMa0d8FCndMqrzL7G/cmh0AarOgHyBYr8GQPiUYdX42E+ppSviqv5e2wEogMWO/kOoZD+AJWpkx2wBRi/8rgqJ3eKD0o6xzQEQ/Y54Vh4sHaYVw3usprxmeRLROjsuU5hct5bBRrj5q+Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QXjtEj90; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Lpgtnqa9; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QXjtEj90";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Lpgtnqa9"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 69B3D254012D;
	Fri, 13 Dec 2024 05:41:39 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Fri, 13 Dec 2024 05:41:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1734086499;
	 x=1734172899; bh=HHGoKoUlaA1DCr1psJdTZ6LJQzlNbz4dcfCxp9vZ4BQ=; b=
	QXjtEj90HUpD6kbSbD8FC66R/Co1mXWW/6JaEW5lSrKPfHb1/2/XdxVYSnXSK79M
	yixeNp0odXXWpNjJraeSRNJ3HrJkqoGIBCuqdu0grayRfHZnakRYvclfp2gfo1Sw
	r1zcbiyP8paWLG1jGfFEGKrSl2lc9cQoTqy18EIScAIIIH75vu4/ghrudApe7RVy
	i+tdTpyApO8kf4JjMmtN9sNEuEyH+w61zE3CtmzDXXx91520OheWd0I9Keqvmz1b
	TgH87GGTjwteJ7qEVSNPpsgkoqFr6Kzj0ihk0zPCLMlHgd0LEU85QrEDNz6bEgW1
	x/KlRl+Wlw7fCFOmcFbTCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1734086499; x=
	1734172899; bh=HHGoKoUlaA1DCr1psJdTZ6LJQzlNbz4dcfCxp9vZ4BQ=; b=L
	pgtnqa9xFhDeDVd6nexvrSv93P4EdMFzxeSY90KtuHbpf2AxBXX5RBLdjz62/EPU
	2M/x22kU5W/IidMJqN9z/ziPeJNVcJxhV6k8btLb4CLyAZZ+HGXQxQcknsOc2r6w
	DiEeXBpZfCPiYjNvFcpHSYBXgTpd82bki/kBJcMgThUgDj2EcdGkx+/WOgK1v/a8
	rtfPc3a5ZtEF7u9BSSXHLww7bPrfqPc4VnfJEaSAnLnj+spW1egyb4GKPMykJSCK
	kOCUnc7gFE2WfE1YzUbVU14jd9Zh8VjLrw0C3TL6gi/hbaG3b24JvZU8JIb5nRbD
	gkCbVKJuKyVycl4wtkKrA==
X-ME-Sender: <xms:Yw9cZ5-IZxRTZAaFob7Wq4H93bcMKEEEbicWXrxSIo8hWyL5CqB7xg>
    <xme:Yw9cZ9shXtFmBL5TpJQsgjY0kV5q80t2SeHWbZl7F-CfPc-EkVXJxerJR8vG5zFhn
    oW9_LT5FvHgK0hdpA>
X-ME-Received: <xmr:Yw9cZ3CEw86anqiZt3EA46M2omYWTphMUeqcuV-CbVtp2MADTgaOefImB82IhVZsb7Wvhiu5XUFuQSmrwhZQulwdhszV23-TK9rg0RFLglG4M5M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkeejgddulecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehkrghrthhhihhk
    rddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:Yw9cZ9dvXy7NMcKmQ7PqeRsuZtrrZoW0QxaO_KYJwbbEUM8_tvCaQg>
    <xmx:Yw9cZ-OMlUXeFJ6qx36vTbkKTqqkN9zIgiYf13ZUwzedYIoomN4HlA>
    <xmx:Yw9cZ_mKazniASznb1j1OoD_Mpv2XxUiixjSWZrU4Oimu5fOsfJAGA>
    <xmx:Yw9cZ4tzz4-LEFUYrEtBjukE9lu_dqpnicvRUNB9wN32CfH2isBhGA>
    <xmx:Yw9cZ7r20tRlAsJ7Flg0y2UpA_Qzac5v1udA8d9Q-L7nv-vTmsb0f6DQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Dec 2024 05:41:38 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id eb26f2ea (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 13 Dec 2024 10:39:56 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 13 Dec 2024 11:41:19 +0100
Subject: [PATCH v2 4/8] meson: detect missing tests at configure time
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241213-pks-meson-ci-v2-4-634affccc694@pks.im>
References: <20241213-pks-meson-ci-v2-0-634affccc694@pks.im>
In-Reply-To: <20241213-pks-meson-ci-v2-0-634affccc694@pks.im>
To: git@vger.kernel.org
Cc: karthik nayak <karthik.188@gmail.com>, Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.2

It is quite easy for the list of integration tests to go out-of-sync
without anybody noticing. Introduce a new configure-time check that
verifies that all tests are wired up properly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/meson.build | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/t/meson.build b/t/meson.build
index 9e676e69363ed6311426500d98fe281e30d26bcb..602ebfe6a260211eb2083e5808058852ca86e7a0 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -1092,6 +1092,42 @@ integration_tests = [
   't9903-bash-prompt.sh',
 ]
 
+# Sanity check that we are not missing any tests present in 't/'. This check
+# only runs once at configure time and is thus best-effort, only. It is
+# sufficient to catch missing test suites in our CI though.
+foreach glob, tests : {
+  't[0-9][0-9][0-9][0-9]-*.sh': integration_tests,
+  'unit-tests/t-*.c': unit_test_programs,
+  'unit-tests/u-*.c': clar_test_suites,
+}
+  actual_tests = run_command(shell, '-c', 'ls ' + glob,
+    check: true,
+    env: script_environment,
+  ).stdout().strip().split('\n')
+
+  if tests != actual_tests
+    missing_tests = [ ]
+    foreach actual_test : actual_tests
+      if actual_test not in tests
+        missing_tests += actual_test
+      endif
+    endforeach
+    if missing_tests.length() > 0
+      error('Test files found, but not configured:\n\n - ' + '\n - '.join(missing_tests))
+    endif
+
+    superfluous_tests = [ ]
+    foreach integration_test : tests
+      if integration_test not in actual_tests
+        superfluous_tests += integration_test
+      endif
+    endforeach
+    if superfluous_tests.length() > 0
+      error('Test files configured, but not found:\n\n - ' + '\n - '.join(superfluous_tests))
+    endif
+  endif
+endforeach
+
 # GIT_BUILD_DIR needs to be Unix-style without drive prefixes as it get added
 # to the PATH variable. And given that drive prefixes contain a colon we'd
 # otherwise end up with a broken PATH if we didn't convert it.

-- 
2.47.1.668.gf74b3f243a.dirty

