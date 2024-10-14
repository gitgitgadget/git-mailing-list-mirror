Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850F5231C92
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 21:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728939858; cv=none; b=VnXInjmlB3ZiA4NOzkGSPiXnaZu3OZo5qZi+WJ8+oV3AgOlisCWMXKUVl7weNLRQL6n1g9G589h4SsJf5l/ANppfzlzWldFJq8Vwmaj0W7XsfMIeIr+xis+9lDHN0EP3gvBB64f5ivwQD6uXIoaLK4qbMZ1pxUc4WMzZa/RBlsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728939858; c=relaxed/simple;
	bh=ykBnKKL2F8uAnpnGeqRhy1U076tovdYG2UmB8yg72NM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aFx4m4ZrWv9My9RURrMbvHJfwPmKtIOQh4UrPfa77wGjEWVU9sfk2Si0XVNcp5khcFJIqMfCNOjR0Ge84tbVtVvKMU3aSIeCM/E3U9p1OsZbcVnfiwp2davoabeY3tUw/flhK8Z9ZAMxWeXr+HU3YV2Xc+Is1EJiGnAoFKpuY1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4Bxwpdmy; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4Bxwpdmy"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e2e5e376fcso90527137b3.2
        for <git@vger.kernel.org>; Mon, 14 Oct 2024 14:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728939853; x=1729544653; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cg/nogWYb5nPil0bmiIWIlTFZC1mG5ZylfVcIqjL9fI=;
        b=4BxwpdmyZlr4Vu5Lk2+CnHmMFQS4VG7DcxxMu0WTcoh9hQEzT4yFe5GcYeBeckfyU8
         /tyZl0Nh+N+DprCvZQ0TsyFQYFwzrapdjsUl3+/wePOcZJkcpdGGblrBlncrwTI13dx7
         2/2mQXsE5pOx/dictiu1iIs88PNWxu45MROAnrNvIe78FUNrgHOLewMoTLbQsDFxqAdu
         Q0Sz32mAaaSsWVg5xneZXfXKgzshTh+9gpAPhCq8BgxgFcQfOXEQHB5r3YJaoQKCgpy6
         y+p68ui+V2MmfNrXAxCRF1ax2O4qecp0pktA6uF+I7qzz+TBdgBxnPuyCuPBBxsyAsl1
         iBtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728939853; x=1729544653;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Cg/nogWYb5nPil0bmiIWIlTFZC1mG5ZylfVcIqjL9fI=;
        b=aILif7v9IgqrYDJbzSGXoUqqchcVMDw30MHqADCNzOR1HgugvkEg9IDVOtN7kbdey0
         rzv3ZrqPtLfYjZc6H3cYp/HuDSg7Prlc0qO0bJioJMycrjdlRFgo/YM2K4H2J0kKVuHH
         DkrYmY5j2M5nEK5ZYRx2g4sS/XgCSwbZf7ZJx/EY9r7/ChSzszncBcri0TpIJfA1y1of
         utfyz9sYqq6TkrGRbItjFW1uKxklnt+dHYgZus2nXfYvwKWg59jaTKpxqCWeT0fe8Yz6
         OFtz10sWGz6w3JYJtF7OBt4/jZuDiHCKjtMucIuSYWDSAqM9ji+cM6Ut4ah01vrtcEM2
         qBdg==
X-Gm-Message-State: AOJu0YyMRiEgj5ZOutik1BcJXYVD0kaCWjGfy/kfwgWK2D5KaNDV+gwd
	C2TDe1aE8wZa4yRFrFb5jnK+j2gyKnGYXdxAaY2DmwV0c3OJep6/+b8d5oNPkOH1G/F8kSKJytU
	s+ypBbikhNTdpmbNfHe/LlWfTloTRhSDI7xXsX1staxAw7MOCapvsZ3E59Ebd/sltRc4VYkY4/M
	rNAQlZY+XKlW3XEHl4fJpYDo9CaKeR2lZ2W4jukRU=
X-Google-Smtp-Source: AGHT+IFpogXHBrlHzgKKmsawX88CEeBjARVffdgehHGfvwm+pbSY/ey0KI3Fnh0JaugeGSWX0P5W29z+zJzgnQ==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:2a9b:d27f:d626:2e54])
 (user=steadmon job=sendgmr) by 2002:a5b:284:0:b0:e1a:9ed2:67f4 with SMTP id
 3f1490d57ef6-e2919c5ac92mr9299276.2.1728939853332; Mon, 14 Oct 2024 14:04:13
 -0700 (PDT)
Date: Mon, 14 Oct 2024 14:04:08 -0700
In-Reply-To: <cover.1728939687.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1728594659.git.steadmon@google.com> <cover.1728939687.git.steadmon@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <04225dd4214cf79256805055f1c52012e62b8e8b.1728939687.git.steadmon@google.com>
Subject: [PATCH v2 1/3] fuzz: port fuzz-credential-from-url-gently from OSS-Fuzz
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
 ci/run-build-and-minimal-fuzzers.sh        | 11 +++++++-
 oss-fuzz/.gitignore                        |  1 +
 oss-fuzz/fuzz-credential-from-url-gently.c | 32 ++++++++++++++++++++++
 4 files changed, 44 insertions(+), 1 deletion(-)
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
index af8065f349..631796ab8b 100755
--- a/ci/run-build-and-minimal-fuzzers.sh
+++ b/ci/run-build-and-minimal-fuzzers.sh
@@ -13,7 +13,16 @@ group "Build fuzzers" make \
 	LIB_FUZZING_ENGINE=3D"-fsanitize=3Dfuzzer,address" \
 	fuzz-all
=20
-for fuzzer in commit-graph config date pack-headers pack-idx ; do
+fuzzers=3D"
+commit-graph
+config
+credential-from-url-gently
+date
+pack-headers
+pack-idx
+"
+
+for fuzzer in $fuzzers; do
 	begin_group "fuzz-$fuzzer"
 	./oss-fuzz/fuzz-$fuzzer -verbosity=3D0 -runs=3D1 || exit 1
 	end_group "fuzz-$fuzzer"
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

