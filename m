Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639351E47A3
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 21:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728594726; cv=none; b=qzsBaoTFssE0wc3gL3q7ZWdGzhzxkv9ImluZoUbZtqWQeiXECYBwR+P/sAXuZpt7u4J2tavQTwJb0q0QYngeyR0f3D57RJwMCUu5o+iSMDy6tmeaN7cab72xtUP6wncnsfcRmWI7U7bY6om4r/kvS0INPjW1hIVFpSVU17ruuPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728594726; c=relaxed/simple;
	bh=MEXVEtPwIIXHZDdp0ABonxaS7weLVIIfVUWgsXBJYOg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=c1o4Cc2dAgO1XwtbUyRg+Hs854gnNjwAKfH49Xfc9VeKmLO7Bnxnho2jOydm0CgskV9usFAWpM5sksUaB7tY9dPkEIkQtj95QvzDYIe3AO/P7vf+/6FIeWQ+ttMT5WKijGXGXinljUseFhVurGKmuSianAkIgG8Vchy2QnnfICk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J3rsN9Nb; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J3rsN9Nb"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e24b43799e9so1421876276.2
        for <git@vger.kernel.org>; Thu, 10 Oct 2024 14:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728594723; x=1729199523; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ITAwUM+BBZEk4BUg91KAA202UlRn8RI8CGRYLLaz4RM=;
        b=J3rsN9NbN1AwKP934e+m1NH69ycgil4wJ7G8KphAHudXs32/0vSzeo7bsrmCy5u6GT
         WrHCZ+YBtqJ5Nhr1pv7X0+UD4p3OfakaE+fYNZMLDzYxa8chdpt+U+ZO8JfC1trv998N
         saqfmOSr/0dQ3N2CgrTJvwdT/63b/xF6VF7u0/YetDiB4ss8lsrp4u8Y/hKHXng8ng1Q
         YSvumKwBy6Ff3aJ39QjQejyIZWbFft2iwgZH9j5vWahce+6dt7XTMmqbSQhMMUQ1kYir
         OKojOo3Nt0onPw8Sa4Z+eh31Q3w1lWn1X4nCaa4cM+ScF61TKhHUjixZ+Qzn6gNDITpr
         S8aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728594723; x=1729199523;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ITAwUM+BBZEk4BUg91KAA202UlRn8RI8CGRYLLaz4RM=;
        b=hY34U+o/tVNs1S/di/+YHbVXEb9c/EU5FrFEClsC9opcg6u2lbcfGXK88KHYOaONVE
         5LcHA7pbn4aofjpuE+6f/cPPqF53cEtgLYZdp4L14dBUH5hXE0jpeeAwom+WeIRAW0lE
         BJ0YmZfH8710FTxClmteBEcMDraE5A2/Sjz1SC3nZ9ATikJM3KNd6AZxOAoo8md61004
         bddBIoXtowxhN8HWUlzPI0z8Xr4mwVxjavz58hJZPrImvqjKDPbRX5NLL3I1iu0M1II4
         kujFX1e08Z5a8kgU+1odmZdBuINAxbqT4lYFnnMY6+Vwwx/bqJkDuwrpdi0KI5uSAGtc
         mPIw==
X-Gm-Message-State: AOJu0Yy0uTNO7KlbSNr47zQ/eHc+g/nCnTN6fo55kUV15vCCKb99rT7Q
	e4op1jpokoqj/MC/XMWADHnYSg+DSdqEzRa7PlUU7rszv6Pmz4QhkRhAIghYoXC+j76IiYvrnnH
	NASOIhJ4KL+nRTL99W8Q8zf3J/D5M2dAQ4WAox6zXBvPFUEwmGLIQEgmHo8ErAxFaBJiLg0sPqb
	m6Owx7j09xr2PNWEbBvu0HNpcLmpeQprDcrHwMB8Y=
X-Google-Smtp-Source: AGHT+IElw3uLkLZBWCcNmrb4WTBqtMzBIhBu++SKBEtjVLIKp33P1Tdoh25qWJUrNaIulLi2wMIfaTAiQJJuwQ==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:5a71:d442:305f:726f])
 (user=steadmon job=sendgmr) by 2002:a05:6902:504:b0:e16:4d66:982e with SMTP
 id 3f1490d57ef6-e2919de7e0bmr212276.5.1728594723167; Thu, 10 Oct 2024
 14:12:03 -0700 (PDT)
Date: Thu, 10 Oct 2024 14:11:55 -0700
In-Reply-To: <cover.1728594659.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1728594659.git.steadmon@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <4c9813313ccb620f2ac176ef9fe9223113523c75.1728594659.git.steadmon@google.com>
Subject: [PATCH 3/3] fuzz: port fuzz-url-decode-mem from OSS-Fuzz
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Cc: eric.sesterhenn@x41-dsec.de, jarlob@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: Eric Sesterhenn <eric.sesterhenn@x41-dsec.de>

Git's fuzz tests are run continuously as part of OSS-Fuzz [1]. Several
additional fuzz tests have been contributed directly to OSS-Fuzz;
however, these tests are vulnerable to bitrot because they are not built
during Git's CI runs, and thus breaking changes are much less likely to
be noticed by Git contributors.

Port one of these tests back to the Git project:
fuzz-url-decode-mem

This test was originally written by Eric Sesterhenn as part of a
security audit of Git [2]. It was then contributed to the OSS-Fuzz repo
in commit c58ac4492 (Git fuzzing: uncomment the existing and add new
targets. (#11486), 2024-02-21) by Jaroslav Loba=C4=8Devski. I (Josh Steadmo=
n)
have verified with both Eric and Jaroslav that they're OK with moving
this test to the Git project.

[1] https://github.com/google/oss-fuzz
[2] https://ostif.org/wp-content/uploads/2023/01/X41-OSTIF-Gitlab-Git-Secur=
ity-Audit-20230117-public.pdf

Co-authored-by: Jaroslav Loba=C4=8Devski <jarlob@gmail.com>
Co-authored-by: Josh Steadmon <steadmon@google.com>
Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 Makefile                            |  1 +
 ci/run-build-and-minimal-fuzzers.sh |  1 +
 oss-fuzz/.gitignore                 |  1 +
 oss-fuzz/fuzz-url-decode-mem.c      | 43 +++++++++++++++++++++++++++++
 4 files changed, 46 insertions(+)
 create mode 100644 oss-fuzz/fuzz-url-decode-mem.c

diff --git a/Makefile b/Makefile
index 141e194bf5..2cd7a6e003 100644
--- a/Makefile
+++ b/Makefile
@@ -2383,6 +2383,7 @@ FUZZ_OBJS +=3D oss-fuzz/fuzz-date.o
 FUZZ_OBJS +=3D oss-fuzz/fuzz-pack-headers.o
 FUZZ_OBJS +=3D oss-fuzz/fuzz-pack-idx.o
 FUZZ_OBJS +=3D oss-fuzz/fuzz-parse-attr-line.o
+FUZZ_OBJS +=3D oss-fuzz/fuzz-url-decode-mem.o
 .PHONY: fuzz-objs
 fuzz-objs: $(FUZZ_OBJS)
=20
diff --git a/ci/run-build-and-minimal-fuzzers.sh b/ci/run-build-and-minimal=
-fuzzers.sh
index 60fe8b0dfc..08c556c818 100755
--- a/ci/run-build-and-minimal-fuzzers.sh
+++ b/ci/run-build-and-minimal-fuzzers.sh
@@ -21,6 +21,7 @@ date \
 pack-headers \
 pack-idx \
 parse-attr-line \
+url-decode-mem \
 "
=20
 for fuzzer in $fuzzers ; do
diff --git a/oss-fuzz/.gitignore b/oss-fuzz/.gitignore
index ec185f061c..f2d74de457 100644
--- a/oss-fuzz/.gitignore
+++ b/oss-fuzz/.gitignore
@@ -5,3 +5,4 @@ fuzz-date
 fuzz-pack-headers
 fuzz-pack-idx
 fuzz-parse-attr-line
+fuzz-url-decode-mem
diff --git a/oss-fuzz/fuzz-url-decode-mem.c b/oss-fuzz/fuzz-url-decode-mem.=
c
new file mode 100644
index 0000000000..2342aa993b
--- /dev/null
+++ b/oss-fuzz/fuzz-url-decode-mem.c
@@ -0,0 +1,43 @@
+#include "git-compat-util.h"
+#include <stddef.h>
+#include <stdlib.h>
+#include <stdint.h>
+#include <string.h>
+#include <stdio.h>
+#include "url.h"
+
+int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size);
+
+int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
+{
+	char *buf;
+	char *r;
+	const char *pbuf;
+
+	buf =3D malloc(size + 1);
+	if (!buf)
+		return 0;
+
+	memcpy(buf, data, size);
+	buf[size] =3D 0;
+
+	// start fuzzing
+	r =3D url_decode(buf);
+	free(r);
+
+	r =3D url_percent_decode(buf);
+	free(r);
+
+	pbuf =3D (const char*) buf;
+	r =3D url_decode_parameter_name(&pbuf);
+	free(r);
+
+	pbuf =3D (const char*) buf;
+	r =3D url_decode_parameter_value(&pbuf);
+	free(r);
+
+	// cleanup
+	free(buf);
+
+	return 0;
+}
--=20
2.47.0.rc1.288.g06298d1525-goog

