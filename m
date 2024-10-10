Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6501E2315
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 21:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728594722; cv=none; b=ukySlkgGC8wqpOmhaRJGxqsbwwM9gxOFUvhaVWnPO0yxNlP82cXI3Wkp5RxzTTF3RiL0Tlpx6PvVhmhmQ73lrQMwa56ia0kxoudgUH9oGY3BG7tOCvpSxE7I3jdW2OHEGOP4FabT/j9S+yDPjI+TmYqt/NhuBA8JrYqlS6hP3PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728594722; c=relaxed/simple;
	bh=KulEEbaV0HTGEOEbX0KggXUnVwkChhh4XAxvkDzM91A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QTL2J4lm6jwkZFejpSXuPlHXScBey3276eHjNiPnWiYUEM2iRpxoPYY4UpgG/Gum2PvF4valpFGp+3s7XobY9DVwnFFZbIahlQWeKs+gZyahdfDz4C+R/W4hnlX+2f9owWDAS/7yHCNTOqlwS0RwdKsKTnKUl1z6jSH3KCuw7nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XkSRAlzh; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XkSRAlzh"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e25b39871fso30574677b3.0
        for <git@vger.kernel.org>; Thu, 10 Oct 2024 14:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728594720; x=1729199520; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jkpDN0ASGCaFBdGD5u+61y9sC9BD5O+m/n6Vk0yMjGE=;
        b=XkSRAlzhSukVF7U9tMkqGTY6QGLXkvQEpdvjppBzEKvnaJJIDrjiuufxuLdh2GnDdN
         VbPQVrK4ce6VE8z1EvPwNwlSyImuXdVcYeNQqPr7CkMTpyRUNCTM2GKe/zK/9miln7NV
         CUmrJLgIqjj9DhUwZDEhSFxf5wT9rYSqjRZoA//1upE22CaySffoVWucWyPUjYrseGID
         cROvYOi8VwBdDcjenO1D4sKdpmhu93fy0BC3NZgihWfksDh1r57Z9uCMJZBnfS2mdnjr
         8wRESrGKQDX4QDSe0JY17r92WqymeAY699Mrr9BOFiTGvcb50J4rblUg5uZ79DME1XHd
         +i6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728594720; x=1729199520;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jkpDN0ASGCaFBdGD5u+61y9sC9BD5O+m/n6Vk0yMjGE=;
        b=s0nyP/F+RsbsIR2SeFFPs+birSVUBr2d6gRisnQNZO+w2eIn4MECyIq4IBW57xfRVg
         RmvCoW9e8MMdpBsL6m9p2LS7bG08zajDWsOyHzbghRQ0AVsrotED+Ykh5JpOgyF0cC2D
         YexwfxpJTiwJJD+veIR8TcwaDjYarBspV/ynMGf5KJS+JCPvc6w8Jhg8wF4Fdo6rLAbr
         1EUHOUO3hCh/bGioUvuXe/jnmLzECuTWO86Pb63JsVpJOgQvkKP/Lc8zrhMj8QA0yNkW
         gORcnePYsAYXVpMdBBsYiSpth+7gBV0XBSCdOHnUgSseCOKAiFZNzEyHejqeG/fR+1LF
         nXlg==
X-Gm-Message-State: AOJu0Yx/D23Wobbcgf8v+sEIE7/651DBkk3GOtnb+AtFRnX+2CVQ+WcT
	MrT2xf1i7i3rWfNgaXSW5WBh19zw5lsbu7hcPt1RTRsG8ovs1EZWRwLhtCDe8ISt5wkc13YGpIy
	5uGU6s8f5Ddrq9ZBfYiY1Fmc4pv+gsXbKyHuSkmrid50dvsUNOximVj0u0Fxq99mq8FwsNUOQ0J
	20AiLPecqDwO4eo43MiIcbF2Pt39+0SDEigPIoWTc=
X-Google-Smtp-Source: AGHT+IEXh/9Qu+HPKFsHPyQLEoMbOPKjjgBJHi0NJ1fEf21ySmW3RIqIApRoMAxVhYf2xpjWWokfVfhu58JumA==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:5a71:d442:305f:726f])
 (user=steadmon job=sendgmr) by 2002:a05:690c:3190:b0:6e2:120b:be57 with SMTP
 id 00721157ae682-6e347b4aec8mr7297b3.5.1728594719597; Thu, 10 Oct 2024
 14:11:59 -0700 (PDT)
Date: Thu, 10 Oct 2024 14:11:53 -0700
In-Reply-To: <cover.1728594659.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1728594659.git.steadmon@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <625b8d607ed2c95e396e7794616d9f290f23d15c.1728594659.git.steadmon@google.com>
Subject: [PATCH 1/3] fuzz: port fuzz-credential-from-url-gently from OSS-Fuzz
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
fuzz-credential-from-url-gently

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
 Makefile                                   |  1 +
 ci/run-build-and-minimal-fuzzers.sh        | 13 +++++++--
 oss-fuzz/.gitignore                        |  1 +
 oss-fuzz/fuzz-credential-from-url-gently.c | 32 ++++++++++++++++++++++
 4 files changed, 45 insertions(+), 2 deletions(-)
 create mode 100644 oss-fuzz/fuzz-credential-from-url-gently.c

diff --git a/Makefile b/Makefile
index e298c8b55e..3ce391062f 100644
--- a/Makefile
+++ b/Makefile
@@ -2378,6 +2378,7 @@ endif
 FUZZ_OBJS +=3D oss-fuzz/dummy-cmd-main.o
 FUZZ_OBJS +=3D oss-fuzz/fuzz-commit-graph.o
 FUZZ_OBJS +=3D oss-fuzz/fuzz-config.o
+FUZZ_OBJS +=3D oss-fuzz/fuzz-credential-from-url-gently.o
 FUZZ_OBJS +=3D oss-fuzz/fuzz-date.o
 FUZZ_OBJS +=3D oss-fuzz/fuzz-pack-headers.o
 FUZZ_OBJS +=3D oss-fuzz/fuzz-pack-idx.o
diff --git a/ci/run-build-and-minimal-fuzzers.sh b/ci/run-build-and-minimal=
-fuzzers.sh
index af8065f349..d9d3ad23c7 100755
--- a/ci/run-build-and-minimal-fuzzers.sh
+++ b/ci/run-build-and-minimal-fuzzers.sh
@@ -13,8 +13,17 @@ group "Build fuzzers" make \
 	LIB_FUZZING_ENGINE=3D"-fsanitize=3Dfuzzer,address" \
 	fuzz-all
=20
-for fuzzer in commit-graph config date pack-headers pack-idx ; do
+fuzzers=3D"
+commit-graph \
+config \
+credential-from-url-gently \
+date \
+pack-headers \
+pack-idx \
+"
+
+for fuzzer in $fuzzers ; do
 	begin_group "fuzz-$fuzzer"
-	./oss-fuzz/fuzz-$fuzzer -verbosity=3D0 -runs=3D1 || exit 1
+	echo ./oss-fuzz/fuzz-$fuzzer -verbosity=3D0 -runs=3D1 || exit 1
 	end_group "fuzz-$fuzzer"
 done
diff --git a/oss-fuzz/.gitignore b/oss-fuzz/.gitignore
index a877c11f42..2cfc845b20 100644
--- a/oss-fuzz/.gitignore
+++ b/oss-fuzz/.gitignore
@@ -1,5 +1,6 @@
 fuzz-commit-graph
 fuzz-config
+fuzz-credential-from-url-gently
 fuzz-date
 fuzz-pack-headers
 fuzz-pack-idx
diff --git a/oss-fuzz/fuzz-credential-from-url-gently.c b/oss-fuzz/fuzz-cre=
dential-from-url-gently.c
new file mode 100644
index 0000000000..c872f9ad2d
--- /dev/null
+++ b/oss-fuzz/fuzz-credential-from-url-gently.c
@@ -0,0 +1,32 @@
+#include "git-compat-util.h"
+#include <stddef.h>
+#include <stdlib.h>
+#include <stdint.h>
+#include <string.h>
+#include <stdio.h>
+#include "credential.h"
+
+int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size);
+
+int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
+{
+	struct credential c;
+	char *buf;
+
+	buf =3D malloc(size + 1);
+	if (!buf)
+		return 0;
+
+	memcpy(buf, data, size);
+	buf[size] =3D 0;
+
+	// start fuzzing
+	credential_init(&c);
+	credential_from_url_gently(&c, buf, 1);
+
+	// cleanup
+	credential_clear(&c);
+	free(buf);
+
+	return 0;
+}
--=20
2.47.0.rc1.288.g06298d1525-goog

