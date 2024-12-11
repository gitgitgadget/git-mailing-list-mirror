Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AAAA1FA8D7
	for <git@vger.kernel.org>; Wed, 11 Dec 2024 10:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733914397; cv=none; b=eOMNwix/CSncD3/Nw6h0QNANN4/FaK7RTaurIPfuxcy7lO3v+iunDu/nf53WY53r1WTVlm8DQuAqsQh1QHIzvJATjEIPWYiOG4k2LhObKwLFLICF+2rqSQknKl0As/lD5qV9o+enyUoyafrPX+GYSyK/T16UjWhyDACSZO5jvSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733914397; c=relaxed/simple;
	bh=AsqO3+IstYL7Qu2AEgwombzM8WvgchgVaQdInE5O/ns=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E25d7kCBH//hxe5IQMDPVPb4WWN0gF32Yuw9czBXtcf5nbP26RjNWfDmHVbF0bcHNwosrgXSLs8nFGBq31w2c/YJ6mMtB7zTJIoNpN7yv8afp1YNsbIq5SFMzT5pmuPCEUKm8cgnNPrrXjJE7sj/cYKEU41NVdF3Jklq5hKXpm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=T+MOzOQS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=maOfZft3; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="T+MOzOQS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="maOfZft3"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EEDB225401F7
	for <git@vger.kernel.org>; Wed, 11 Dec 2024 05:53:13 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 11 Dec 2024 05:53:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733914393;
	 x=1734000793; bh=eP8RwPqxfL+OutVoxXx+Zz8c0vzepC+Vb/djmfC04IA=; b=
	T+MOzOQSDiZYufs9GNE8Umhj7p2rg280Kw0iLvSNpV9zLOW21Nz9/P6UgTgZmbFl
	J9AGOaSGawq5Hyq5npLLjqhzdPUbVYb50Q33AckOQYEH0COmJHlSruuapYWxfmAm
	nARWL4SJDUQ0slAm41sDwv+lfC5IFJoAW0gacJK2hjahc3rsJwbiC3HlBPPtDBt7
	/Mn3MCsjAmvgA5tQQ4R505aby+x8kiAJiTCj6wM5iq137+zqITOHbpq/dUgFfCbh
	k8V9Akp3NuswHYVHafxIkX8vTet+SX/dX13TqbF4tK9FoNQ29yYRV5IgSuyYn1w8
	a3sCnlKkJrpkogGKQYReow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733914393; x=
	1734000793; bh=eP8RwPqxfL+OutVoxXx+Zz8c0vzepC+Vb/djmfC04IA=; b=m
	aOfZft3ffV9oGIs59RCNG+ef1MIpDBDSrvhafN8bwz5wDB7F2gem31gZzjU26Chn
	EnOQ81Lu/YfdjPg1liF6LaWhp5IQN3BapcIUVPakyJcQXxSbgalnsBI4OXJ3DL8j
	G4IXa6uRfIdv7ztb1RU1rRk60BQupmi5zySPl8FQ5d5C4DzlHCnnVwjxW7zVFBdS
	M+siOlSTFB8DjEC/EmMYGD3wM1Z3NhktzyMVNN/jg9YBIupa4wRaBXmHf4fZL7jQ
	zyOFBNBWn+ha4noy55xGBuBngQeeW4qQsVfP6gMXhBqNC+X7zunTFm2IKwAwZg7w
	HG5OI8b9k1xz6IOibrZ0A==
X-ME-Sender: <xms:GW9ZZ-DYDtmUcZNRnzXJ-OYwN-brG6C3fvPyekvd8xI5Nf-yes4sMg>
    <xme:GW9ZZ4izoThbwJHsXVzalsOlQDCEZNzaczzBgRDdfZ5woaMxwHXUe92Feqzy8QDAL
    dw_Xk8dEdYUtBEm2Q>
X-ME-Received: <xmr:GW9ZZxn55cw0Fy0LYsE7b-_Nyp8Ty4Jv-N1V81EciRaZmlceBmPc65WIwW3DsIpwhoOsGSAZ-ATcH7SnASci65O75-d0KJyziL4PHza8-wEj8w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkedtgddvudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffufggtg
    fgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvd
    ekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:GW9ZZ8zxpnG9p9TCmMkDzCmoZAS_r9zuN9NscjaWnTAFyeKZ84YMnQ>
    <xmx:GW9ZZzQApm08HHElA_DxrE2pfepqaQUdMUlhbSNvbEeuD9LKIuOFRw>
    <xmx:GW9ZZ3Zqs5w08TcHt99U6_acpVCGIlPHStHmEIQTMSzRAAiyiqPr9Q>
    <xmx:GW9ZZ8Tpb9WDT6UtZMddUMQ78cA0n3wc5phK5meEkAMGkv1DBWXGHA>
    <xmx:GW9ZZ6LqhRhdFidX9dc9gri8Hc1NlsOVNApSNlBD3C8btglq_3B5Ez8C>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 11 Dec 2024 05:53:12 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f91a7909 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 11 Dec 2024 10:51:35 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 11 Dec 2024 11:52:35 +0100
Subject: [PATCH 4/8] meson: detect missing tests at configure time
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-pks-meson-ci-v1-4-28d18b494374@pks.im>
References: <20241211-pks-meson-ci-v1-0-28d18b494374@pks.im>
In-Reply-To: <20241211-pks-meson-ci-v1-0-28d18b494374@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

It is quite easy for the list of integration tests to go out-of-sync
without anybody noticing. Introduce a new configure-time check that
verifies that all tests are wired up properly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/meson.build | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/t/meson.build b/t/meson.build
index 9e676e69363ed6311426500d98fe281e30d26bcb..f1fbc6ae179079f4d5d86f9a60956fad84d0495c 100644
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
+      error('Missing tests:\n\n - ' + '\n - '.join(missing_tests))
+    endif
+
+    superfluous_tests = [ ]
+    foreach integration_test : tests
+      if integration_test not in actual_tests
+        superfluous_tests += integration_test
+      endif
+    endforeach
+    if superfluous_tests.length() > 0
+      error('Superfluous tests:\n\n - ' + '\n - '.join(superfluous_tests))
+    endif
+  endif
+endforeach
+
 # GIT_BUILD_DIR needs to be Unix-style without drive prefixes as it get added
 # to the PATH variable. And given that drive prefixes contain a colon we'd
 # otherwise end up with a broken PATH if we didn't convert it.

-- 
2.47.1.447.ga7e8429e30.dirty

