Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94F53F86E1
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 09:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782723745; cv=none; b=QAZt+zkSFHTBywS3GhS6geHwroSHo2IaufEOZJukgi7G8IlsDJy4sFcYqt/faweeH5cb4G6zqhnxwi4xdE/v78ZWIcWB9YSR2N1aN8wzMWIbEMdu/jHgzKe10iQ/n6uQIM1w3NmFLjMKcx53Aq+sSXFBz43kI5r9L+yhUERD1X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782723745; c=relaxed/simple;
	bh=dPGgrlMqP9RMvsoh3kOgkc2kTsiDerWNk+xL1Oj+Dvs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hxfy9QNFeifWFCD6FUDZB2CKOz0nBf9KxPFEyDrYqaU+cAw6BYamDUtr4s/ZR6q8K8D6T5wrz8cqVKpmVigVrUXZjZ9D8Mw/R6PDCGUTCm728Y9oOOBFvqNJhTtgPNsfxja72H0e29jlMbJMkX5lpEgydiwkI82E+yl4EILGur0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=R4d6di4z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Pi2IRNzx; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="R4d6di4z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Pi2IRNzx"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 511037A0069;
	Mon, 29 Jun 2026 05:02:23 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 29 Jun 2026 05:02:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782723743;
	 x=1782810143; bh=xP1/vMR5JXuVnvD5a2/AZcftKk9+anFhxuuLAxSi8r8=; b=
	R4d6di4zPFpTXZo3KTb2t+MQyc12NYLXg0EXhJjB5N4AygHnPqelPJQNbjg/KC+0
	1ZUkzEv7JvCHWyo410IZwzGA8TM623cragPwGMzMFK6uBT4zWHM27H7rhaM8Mso1
	rnJPtCTuEMFMYTLjA4Dh5ZLRXVtG7Snhn3pCrQk70IWhrtivOo75oAi9s6MhB0km
	1i78Gn8kBBRQbPX1UyR5Qz3nO1H9mKTkXVhIgoi5b+zLoBB3wJZ0ws25f+d+d6Ar
	ObGVGDqZ2ze5lvD0d8nGyaRlUMrziYGPbTS6u5qyqpFIrEleVSdIqLGiOjln5iNN
	3Hdm5L5s9imh7696HVg8sA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782723743; x=
	1782810143; bh=xP1/vMR5JXuVnvD5a2/AZcftKk9+anFhxuuLAxSi8r8=; b=P
	i2IRNzxxWbDsEXg2/ikHksQnJQiwz7z+nvYvusss5Y5bwZQToDENLXaOl266/i5B
	fM/0Bf1zKz52zjrgQqsSTmB24jC00nPGclhrNizmPm4prEf7RCQczb0X++WORe4G
	0N1hEVIL7KwM0JI2iq78cxVQRQ1fBo231gf+Iz86k5J3e1bYoKwuuGHt0mUvGY9U
	KP1f7YkzyDOO/cVLAvjjcSiAOc9Ukod2edE7O3CF0PNkkx4hLl43OFqGtKYtOdrL
	sOOovyKX/82mw413G5nkWVnWdeocngw2VRbtyuFxQBr/8m0YIRwfJIFGsUIFfBSi
	5Vv5KQeAu2Lo77DM965hA==
X-ME-Sender: <xms:nzRCao2hV3SvlR1wVIBJpg7QitQYy8uBhR64yhim8lu9fU-y1Oq92g>
    <xme:nzRCaqhuQirsEQ5CvIz_B3y8rOTKmvfIjue2X3KbozNpGTE3bIU86Ezt8uEwSb6d3
    Z2PCw4hysJ8e5QOit8zz7iG-KZDiW0TlSAfhbW5xILDFX9HEYOBNw>
X-ME-Received: <xmr:nzRCauQVEpUHSVs355FDs8PIgjqL6FQq-nAaEnCGyalkMgtF5cGqb_iPeM0I_B32_aBgj5r12aGctXl6it_sqKUglGfMtm5is1MW8_g2weFk>
X-ME-Proxy-Cause: dmFkZTFf78gZ4U0pV8g2y1IIGqqh2NaGrNkO7MwAw/Ul/PxXTDFsYY7TBS+5vpiy2xQ7kz
    hAKYtnO2uhrhKcBaCsJJYq2jPVxR8LLd87L7SpRvAxRPUIAFt+csN8nCQNTB5FmR62wCIP
    IbJQKlONF1vyW4B5TCQR+975Kr/6uN3lyeUY3bP4uI4r6V72gBE5za4Zgdo2EjWI2Z4+23
    zL+T+fL+VvnGSI7bzahZX0xa2GHAlT1G1LqqdC7L/nx7VON0p+oUNkhLwRzgAwDZGCVh/D
    QUao3LF4tlWzI0Yx+HzylfSpnzpnJRbJ6/5juiKS6UrTXnw6cxhucNlBjxqpyBz4ETehle
    xkzWlNqshniCSRA4YgOtx1qEC3RSmZmblLoRyL1RrfcDMBpWksYap7PlmJ8ah4VTURCi7d
    WA+iUNxkzVqKPSwNevVatUBeStMDfy/kPN/gnCQoV6xGV1dC7RTPUVF823+PzOrKpHS4uV
    JtJH9ttIB2RC32e+Ov85kE4KRk8hNSnYzHFw0iyfuKdDnOyKLrwWmqm5tTRbU5KF37P4pQ
    gucLYvvHzeMte7lrjB+y9yOB1ofKf3XBEunmV6vG44EJiiL9ju3+74H67qdkMioije29mf
    MdZZvJu3nf14Ho3CWvnkMQILKkqpQ6c6hovj4wAft+qDQCbfFNIMfLRwHHUw
X-ME-Proxy: <xmx:nzRCaritWIcYAADPkRJuwSfokKjA1vm9ApPXUYIZqMVLJtKaTYgl3g>
    <xmx:nzRCau7C1mw5VAg-Ypm5GIf-Zz9pIiXps-knYXfl5-dz7fvNS7LCWA>
    <xmx:nzRCaoBUjGyvonCsL2qhHbdJ4iBJdDJcz3aiowXIw0lQY097L26m4g>
    <xmx:nzRCalYEfp-3W9iaLXiubX2doj07rYEc2PGHJc-sbsQ8zOcNdQdz9A>
    <xmx:nzRCapcQeqkXLbPRFGIVsZVhZOaMsq9cfMbgIM8Nh8Jyb6l9SB8yoVqH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jun 2026 05:02:22 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id cc8936e2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 29 Jun 2026 09:02:20 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 29 Jun 2026 11:02:14 +0200
Subject: [PATCH v2 01/12] meson: support building fuzzers with libFuzzer
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-pks-reftable-hardening-v2-1-b0228e7d908d@pks.im>
References: <20260629-pks-reftable-hardening-v2-0-b0228e7d908d@pks.im>
In-Reply-To: <20260629-pks-reftable-hardening-v2-0-b0228e7d908d@pks.im>
To: git@vger.kernel.org
Cc: oxsignal <awo@kakao.com>, Christian Couder <chriscool@tuxfamily.org>
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
2.55.0.rc2.803.g1fd1e6609c.dirty

