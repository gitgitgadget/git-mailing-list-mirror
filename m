Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3AD3C3C0E
	for <git@vger.kernel.org>; Fri,  3 Jul 2026 12:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783083539; cv=none; b=jdar/bNyAu00tR1mV2G/WT+TZ2jlt58Znv9/RgA1+ZRK0eQgVyGYApR0GqXTsdm+ON9CycEfq2ZMZ8Qf7/P0MyXshiImNETArU7abGksFnas3S60cg6VUrkwVl88Dd+vEKHgp5qAcDARUBBN5M6E9zFqQhHFd1x11zC87tmNTDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783083539; c=relaxed/simple;
	bh=/uu3qx8+mbqUr0ebkMERnInfSwJAYlSxrKy1p15+ivg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EOJAz0ggJqsnyYqpSZW9+snPru05KpXR7HL3gi4QzWS5gtruFCgzI9xW48UCqFp9E4pt2pw5xWAyg9CizfKMs+qgUaKetUkthMZBzlMbfMRvd9U4weasVJDymFMspUgh2NeR5w+0A8XT/XzmTw46Vzadl/tLvdPQkDbu6QXRakM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Qcph4sxw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Fjgp9yPd; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Qcph4sxw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Fjgp9yPd"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 697471D000B5;
	Fri,  3 Jul 2026 08:58:57 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 03 Jul 2026 08:58:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783083537;
	 x=1783169937; bh=8WcqqZ2k9dC81IYhfwj8f/C4fkqllpviCQBgKfLjW/U=; b=
	Qcph4sxwTzrkE5uMD60iCqSOu8mQ9o42ZLBQXGWmEyfA+WZYAtrD9g4+PEOLu98a
	XQZkCgpV/JadNg4EWnwGi69hpe6DOSDWLlka2YKrBZTePGK3TI93l7waJZR2tl5h
	A8ChlXKzgWkmMblj5UOnHJUv2sYEGksM5ZuXQOVsZL7u8SN9lpsq4gT9HobIDkEw
	sUHW+xYc3aj/VRmogjsVI96io+m5WcTJ2bN/zYZ6jEdka1e+tSfObRU7deT8NR6k
	SUzCFuV7sq4PYH+4K/HjD5v3GVvrILyIb0iJXfhs7yTxY7H8U4amUBNa1RZxe5wA
	j43I5CwyXhqtYNrZb6p5hw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783083537; x=
	1783169937; bh=8WcqqZ2k9dC81IYhfwj8f/C4fkqllpviCQBgKfLjW/U=; b=F
	jgp9yPdjRv0zZ2t99TH5JqxNQddnBeQzLIzYnjuXRFZipjPnBiKKHalfLhvS7+4h
	49We3Y1uJjpRUMTBneAB2zjLXwLtBxOBx9c2PO38BR94+jCYvm638CUsK4KZuOYF
	XJHTqx9k+f7uIN9sRIjmG9RH2NQE4UGHQ3nVtFzveCOj11D3TvuQt/iwQ0apX/3Y
	Phd+B/pH3eHn7bPJisxcUStWmu3boDyWyKUG1HaiD+/5j/pgQt5xv6/Zj1lUAh7z
	0AJLQpOmLrwYu50DWNcdnZM+n1HwrMH4LKsYVyPctjcSbGCeD2Dm8q0oz/VnIcOQ
	wh9thPO7k/56VwJi3QALA==
X-ME-Sender: <xms:ELJHas3InwptKlLIcqikbpZyt2A_UKp7u2DEaUBd04YkRBAC_rXs1Q>
    <xme:ELJHauFtm1qcVcb9rK50I9wvMt9WIsQ19bVmti6783LxHQzX2IFbUCVVOtM2lO23r
    tI3jHl6mhO_LvEQo3WMDAIBm7-7X5jnQkyZ8Dd9Pd04BZAt54_E>
X-ME-Received: <xmr:ELJHap78OxCSB32aBXbgygb3TznmMtptRS_k9NnukdZRKqgw2LArJmHZlwIs1IpRQQmF66-gVhpB8nWfo2qPRp6BFY0Dw0-tbYtRF0zsJA>
X-ME-Proxy-Cause: dmFkZTEnwvHVL/02oA1h2uWNRZvjgjI9BD+dkxtOdLwJ8hgL6Y0qLSdb2NnWfTr6UNt0dl
    rwcoArYQ53f/0Y1FZHpBSRkzqgsnWJdFO56zP44BeEklSg+tOlFA8QUvWfYVi08L7JDXBX
    C0xy2B23fAAi9AWPhME0flDA5F0trsEpHLxNt21heC4fvk20kF/9jy081ZaZO/gfwY3ch9
    2xOOalj33Pq3zJIZLRyMR9G4D6StkfivX9t6bDBrNuxuuWSBUGXjxloUjOXAUCWNsmPY7p
    s+5SDmDTgvFsrgvtN+2U/UQp4QGAIPVCHjlaeXB5lhP/4PP+T0wy8yw7e67gBqEG1EgqDB
    JZt5NtBe1o1iJv/hyzBBLMkdJbIJG3evF9Ac0LzbNmBvoYd2rx6HLXzj9V7SEslYDJq3oR
    +l4iLpcxkXHnoffssnj2iB1CSHfs68RsRo/2lozz3AmmuR/78FTTfVGvWEjNaZ1ymQZ/ku
    6qMAme0V4DBhz5u91KPj0E1m9cuW1L6YMqKUSH2w+3Av5oTlGQ0bmSEfcgF5P8XsjAmFdH
    K6movRYk/hQUEtbf1jG8yhdEAyT7OiTwyPShRIc4hbKGx15wnWU8gBfiV4VlDkHYjR3j5B
    jAkS5uDOGmsB8G5I8tEEfAC18Lt9NSzoDIIR+ceq360rlo+YVgvAla8kLdQw
X-ME-Proxy: <xmx:ELJHakuRSI2KMVmgIZg3j8Lm_4V0kq7HiK7NdLDe0b8XtC0-_givIA>
    <xmx:ELJHaq501ALYBYnWCBt0PHMBhwRL3B_5-8Enq6TVauWkKqBl8tbRRg>
    <xmx:ELJHavVPSNhwWRnlWw1dD31liAaG3t2uYdr9YfudfU7BwUo6yqRq_A>
    <xmx:ELJHas88Z8KkbypYygV224ZeR9gJag8U2m5Zo6n3ahrHjzBJTahpvQ>
    <xmx:EbJHavMQduOK6STcV3QYsQifoAqLRepaFtzdfTdSGi6f_-eNugY0lYuz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jul 2026 08:58:55 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id aaf97b0e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 3 Jul 2026 12:58:55 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 03 Jul 2026 14:58:44 +0200
Subject: [PATCH v3 01/12] meson: support building fuzzers with libFuzzer
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-pks-reftable-hardening-v3-1-b87c555b9920@pks.im>
References: <20260703-pks-reftable-hardening-v3-0-b87c555b9920@pks.im>
In-Reply-To: <20260703-pks-reftable-hardening-v3-0-b87c555b9920@pks.im>
To: git@vger.kernel.org
Cc: oxsignal <awo@kakao.com>, Toon Claes <toon@iotcl.com>, 
 Christian Couder <chriscool@tuxfamily.org>
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
2.55.0.795.g602f6c329a.dirty

