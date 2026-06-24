Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECD03AC0C2
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 08:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782289415; cv=none; b=nRsfokJOy+YwvkoDTqIj0EmQL442tOYxP1tnMq5Dh/EDUq20XD3xXuUgz/DCnBsPaTvCl2y76cgZwZ2aN1YRBg2UmMkO0yIcaOgHIR3KRz/QxFBCkA2kk98LzP8lCjGHLLAzsAJA2aRlYSmUhx4NjvFS7Wgg9g0NUCtXdWh3oRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782289415; c=relaxed/simple;
	bh=kUJ5qejvVJ7UUkbE87KV4D8IUO2R8PWyfAQ/kXYeYyM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xocd0MKQm1y7EEgfaj/4MXcgbHGnwD+U/t9+Iwbil5P+w+qHk4gg8mGSHC0/B5Vq2Xhobn3yL0GacQUSetEsQJwMx8yydcmlvzB8i06m2xMNEyrr8Oa5C3fNUsyxmmIS2JLt2jsPAh2haRs5QkO9fkSqk+2H1Id7BO8KtRmVu/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=T54BByrx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IEGrNPsv; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="T54BByrx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IEGrNPsv"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8FA9F7A01CD;
	Wed, 24 Jun 2026 04:23:32 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 24 Jun 2026 04:23:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782289412;
	 x=1782375812; bh=dBB7lrqxrA1ppXqZBZRpdFyHTWqAY0VVSyp2nliZlWw=; b=
	T54BByrxugu0jppqfRY66ZM3aEkliyFcckoyfV5aVhJIRZUM02J9VYTaWJM/9MeA
	RRbtB4uYgO2DpEjhYqyEbDDfV8BNpF5SS6ogxRl9yAd0IPkuPLUHZbon8i/ImVpS
	uUtpgL9rRPG1+9i7z/9du6mO/0YhzoMpp51IEJSdeCXJIgadZl5wqP1tCPFsg75U
	aamaurp1x/oJCphFi7vhlnWj21HTbX+uxciseyENfYRmPxDGLcwGLKwfHa6+z5zd
	TTGQadPE2qvMPbY12STgHWs1UcfzWMzEDM6xk5EahIlcJ44NMiU1mtcuWnk5mE5e
	17DUlXtLwLZeqi2S8XPQpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782289412; x=
	1782375812; bh=dBB7lrqxrA1ppXqZBZRpdFyHTWqAY0VVSyp2nliZlWw=; b=I
	EGrNPsvTlzTVakFl3JtSRch/ianTDyb+ANNG8dfPnNxWBIv13obwRHOTvb8EdJlW
	KEJqdcTYyQW5VC6K+7nXaKJctbK1O2ieajZFFCayR/2G74x2wdiDfupeXai/qODF
	cBW/ey1LCOHi/ByoKS6jZjq1m+HXf/9isnVbOYm0pvmOTjsHMUkO8HiYTOcoBEyP
	CgHSffISZP6fqHbKuLad3HEBx0pDD6bvlp2w7WzVGXHC9SbSOPrSKd2fcb/B7boy
	pwoDwwEtkmCB58Ie7I53V2wd4AQ0+zE2vtICUR8s2KS/1WwIGMr897V6XRj1vnbO
	3kUHYhOF5fWUSl1AjKVFA==
X-ME-Sender: <xms:BJQ7ajRuGSVDprHmerNeq0-9eJll0ybpDFmiwWaoOkrJWy9ht0cjSg>
    <xme:BJQ7aqxDWi1iwWPt7_ZjAQl_DSbXwdPCiIJumJytmUtkqDZTzSAYbqOgcZ5JZgM00
    oRMiDfM-L1Tu4EMw9PhoQyeDPSO2UKZ0k7l3RfY3BaF94f6iqy6>
X-ME-Received: <xmr:BJQ7amdOFCeC7I3NvfM57hjhcwpSKLNjfv3Q_C1h8n2L5np-m7HEDyOmqKKIJs5ms8nzWl0NErP7NJvmEwamnrp2KyWVKWCfecZWMAQO>
X-ME-Proxy-Cause: dmFkZTFTscqWTzOgOVM/4h4ujciNGkBDY0kDO0Jobz36NHnUpRxOxioedCPyL7xWpOQw3l
    jeETOFwa/qNaB9LTKJz+KOPAwg0TQnLAPBhWGEV0aANZMT2e+K2pZ2mucHNoI+yNJoefVi
    Qwu0XNTRUD95z8teh8/Tjx5/DjYDKfwL3x79bg2/Cb56q7qrGP6pqoT1wOcuounxmPsCqh
    LqWbDbnxbVYa1rS6yOPp7WFUt2jOL38SLXOkW50bowX305d0iyzxINuQFJR5GsAtOiUqds
    OPuNR7NpO1+GA2KWIwAO2JhHE9z4Xyxgp27UVzFsLE86cntwOv8mZEUCU8vz1LjbZcfdIJ
    h35vO+sLWaPhFdIP8Gzq+cULRhQ69XPDoQCTTmMTVQxz3gHEIOJjucmIo+8QkK6E3TNUIF
    foeM4v4hoxDFqQK+pB1Dld2sdzvsOddek4lF4oKP/iPb07NGELObCG07PcnfEbPgI5V79A
    wDfEA+SXRoPu7IZBvfkkVdiu6kYhCQXVU2kt/2IoH3L9YqS8wUSPbjUUAb7oBaeik8tsnl
    ZnHzNkIUXeCDNOfCpxlwfDKyu3glO81wUt+bxdFac1BHTWZ4t5tThQgYXNIHmTSboAhv2Y
    tD2X/ZanVCoB8psogv5HhnaQvIU956nEach/Ft8N0u+cyhiUyqJRNDJIOpuQ
X-ME-Proxy: <xmx:BJQ7auI05KIObnRcS-Xq9Zg-Xjc3xUUiAtX4h3K0A_7UfMHVZRNVjg>
    <xmx:BJQ7avENzAhbIZIp3F4RTMlY3dRk5To4CvrQdHrf9ItZMXRTLTBgEA>
    <xmx:BJQ7agphLImmkzGP3UCZJvjuHW6M9eyvWohO-hDtICbcXP1LSoFp4w>
    <xmx:BJQ7agQA4UN-OFU_OqOAoE-JJrjyOnC3YMGTOlIo8zwOlXLR5BCGeA>
    <xmx:BJQ7ahu5H6GuTpnkS2mLRBAtsfTUbOCRTp3lrxU4G2rMWSZtvOqzbYEJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jun 2026 04:23:31 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a05811b9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 24 Jun 2026 08:23:30 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 24 Jun 2026 10:23:04 +0200
Subject: [PATCH 01/11] meson: support building fuzzers with libFuzzer
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260624-pks-reftable-hardening-v1-1-66e4ce87c6b9@pks.im>
References: <20260624-pks-reftable-hardening-v1-0-66e4ce87c6b9@pks.im>
In-Reply-To: <20260624-pks-reftable-hardening-v1-0-66e4ce87c6b9@pks.im>
To: git@vger.kernel.org
Cc: oxsignal <awo@kakao.com>
X-Mailer: b4 0.15.2

To support fuzzing via libFuzzer one has to pass a couple of compiler
options:

  - It is mandatory to enable the "fuzzer-no-link" sanitizer for
    coverage feedback.

  - It is recommended to enable at least one more sanitizer to catch
    issues, like the "address" sanitizer.

  - The fuzzing executables need to be linked with "-fsanitize=fuzzer"
    to wire up libFuzzer itself.

The first two items can already be achieved via the "-Db_sanitize="
option. But the last item cannot easily be achieved, as we can only
configure global link arguments.

Introduce a new "-Dfuzzers_link_args=" build option to plug this gap.
Add documentation so that users know how to set up libFuzzer.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 meson.build          | 15 +++++++++++++++
 meson_options.txt    |  2 ++
 oss-fuzz/meson.build |  1 +
 3 files changed, 18 insertions(+)

diff --git a/meson.build b/meson.build
index 3247697f74..9df6fbb0a5 100644
--- a/meson.build
+++ b/meson.build
@@ -161,6 +161,21 @@
 # These machine files can be passed to `meson setup` via the `--native-file`
 # option.
 #
+# Fuzzing
+# =======
+#
+# Meson supports building the fuzzing targets by setting `-Dfuzzers=true`. By
+# default, the targets will be built without libFuzzer and thus won't be usable
+# for fuzzing. You have to configure a couple of options to properly wire up
+# libFuzzer:
+#
+#   $ meson setup build-fuzzers \
+#       -Db_sanitize=address,fuzzer-no-link \
+#       -Dfuzzers=true \
+#       -Dfuzzers_link_args=-fsanitize=fuzzer
+#   $ meson compile -C build-fuzzers
+#   $ ./build-fuzzers/oss-fuzz/fuzz-config <args>
+#
 # Cross compilation
 # =================
 #
diff --git a/meson_options.txt b/meson_options.txt
index d936ada098..dc88f130d7 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -131,3 +131,5 @@ option('test_utf8_locale', type: 'string',
   description: 'Name of a UTF-8 locale used for testing.')
 option('fuzzers', type: 'boolean', value: false,
   description: 'Enable building fuzzers.')
+option('fuzzers_link_args', type: 'array', value: [],
+  description: 'Linker arguments used to link fuzzers. Use -fsanitize=fuzzer for fuzzing.')
diff --git a/oss-fuzz/meson.build b/oss-fuzz/meson.build
index 878afd8426..10bcac2f6d 100644
--- a/oss-fuzz/meson.build
+++ b/oss-fuzz/meson.build
@@ -16,5 +16,6 @@ foreach fuzz_program : fuzz_programs
       fuzz_program,
     ],
     dependencies: [libgit_commonmain],
+    link_args: get_option('fuzzers_link_args'),
   )
 endforeach

-- 
2.55.0.rc1.745.g43192e7977.dirty

