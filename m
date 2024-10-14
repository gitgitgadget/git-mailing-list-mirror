Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4671D0E3E
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 21:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728939860; cv=none; b=hKvgOepgmBO31PDF82vdJXJuc1ODe6dHfj0HTPqVFezcLrN3hH7jhuoxy72HviSUSlVDHfEgIh/keKAzIMEgqnb1jkFJ3jZh2izX+90lK2ccFvFPWh+8oB7Ee2/ppPdw90SojgLm8nE5mbBrB1K2XXiIHcBuPUh14NeCLaVchjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728939860; c=relaxed/simple;
	bh=Oh2rKeJs/f2GOCblCDbwi8nvzm95ktUkkgHT0tPEL1s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lkfN+bFBxtu9lem4cNAOpjEZEvVqeq9+jENCH9GEMAtQ1N8pXPdp1v+rujfB3JeCBl6ZJHOT9Mojt/k0CQlgeSBdxj0/FrLChwB8tAAMJeSCHnWBVWqYNlt8SoNVRJA1q6AfiXCb7vg29mUeFcFUUVM7pUYy5q00vw0wJuPRzIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EPES9nud; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EPES9nud"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e32e8436adso57802837b3.0
        for <git@vger.kernel.org>; Mon, 14 Oct 2024 14:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728939857; x=1729544657; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AiCo2Zi8ZxXe7ZtaIUYwsA/jlrRXEnMgwf1QEHUXiCo=;
        b=EPES9nudtnchIyyJcXokZ+QIcMTbiKCj2S9OIXdVMlgdqmmBVEbD0RG4pr63WqSXhB
         pGd5MGWYFn3Jv/doQQdeOfnwNRLenu50r8Amk7hBOr3iEm+YNaZgmGV8bNS9w7hrvYw2
         55C4KXJpSKPhR/9WzhTJWwqNhcBaBMcdiePrRMWkJWX6JFhUk2L5PaV4GKKN7wqlyVFp
         bwqIynObZItScPY5ZhwvwugCtW+bKfkubaa2rV3iZn0T/Z7uwpcrDUXrNS3WyBcp7pQu
         +2FRbYfLAKLMN42mfgS4RCFcyAUNGLT2FZ5WVzSc7AQLpaiUBojiH6iTtE8gPpKPIsc7
         wHMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728939857; x=1729544657;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AiCo2Zi8ZxXe7ZtaIUYwsA/jlrRXEnMgwf1QEHUXiCo=;
        b=X/01BXRxR1ZQy/eI3dZX5y4+0Uk+zGSSG9x9FytQFDzg8GIlZ2xgtpvsqMc5joZH6f
         Oh6QkNt2hiMDN4TZCNZ1ty+qADqWNbafUuwPPzY87evEMipMb0xEUHORUYNFlWmCwS0w
         OLYkBaqEyXZ/r6oRviKCYdFAmwolnKccm7VglPinkfdfAf4YyVUdZQrpRVskbeBC5azv
         s1atOmz4wbpwOdHP+6HKRrhW8M34eAdnf0tg2wc02FtBjgHyHD1/wdH8rTTwoPKmJVQQ
         63ChGBGf3XRi1i3z5pPBj6p1O+zXzPX3/L428HBbOHSoxPTK7jP+QEagTcXnCrdgRz3H
         fT7g==
X-Gm-Message-State: AOJu0YwniapovDdU61n4WzL8/hAAWO5t//0nBlUqtogfoC7RYyLZa/NI
	58vmK9xuazbjbf0xivD6ilrMNmeyHKc8oLasemgNe/W4hdHfw09blVbOVodoiBErUMLKdVBisOs
	93AxFUleBToa1vT4mvFveDXsdgMj/BsB3X1Eo0JJgfzhbkHM24xtj6JqZd9nSnlnPyAluVSkhd5
	0XM6hbxWpjN0bCGU1vhN75VusqmAunCUy9pMC1/2I=
X-Google-Smtp-Source: AGHT+IFOl5UJzwqMNwba490OOxgAEcf+/xz4bPgQXbc7hqXdC5OvpHlod+5eFrUe7E++cX/tbCvvJC7ZPqiyxQ==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:2a9b:d27f:d626:2e54])
 (user=steadmon job=sendgmr) by 2002:a05:690c:7007:b0:6e3:eab:18b1 with SMTP
 id 00721157ae682-6e3477bf11emr5121977b3.1.1728939856944; Mon, 14 Oct 2024
 14:04:16 -0700 (PDT)
Date: Mon, 14 Oct 2024 14:04:10 -0700
In-Reply-To: <cover.1728939687.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1728594659.git.steadmon@google.com> <cover.1728939687.git.steadmon@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <ec6b5eed712e89c31e0d3348fffa04ea2100ef6c.1728939687.git.steadmon@google.com>
Subject: [PATCH v2 3/3] fuzz: port fuzz-url-decode-mem from OSS-Fuzz
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Cc: eric.sesterhenn@x41-dsec.de, jarlob@gmail.com, oswald.buddenhagen@gmx.de
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
index 13c85320d6..e7b97952e7 100755
--- a/ci/run-build-and-minimal-fuzzers.sh
+++ b/ci/run-build-and-minimal-fuzzers.sh
@@ -21,6 +21,7 @@ date
 pack-headers
 pack-idx
 parse-attr-line
+url-decode-mem
 "
=20
 for fuzzer in $fuzzers; do
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

