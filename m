Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F72F18DF9E
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 21:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728594724; cv=none; b=O0OgCqpQHubmeQ2sfMD8ozAuN8pNkBxltstVnCNQPa1EfWhWT9J+0gwgnsRKCSJP2eUOS2ohmioTSoWf0t4qgnVLzMuphYnd/IG0ykwFNQlrgJ+78otTAUzwANsxPRK/0ztoISgtua4EuVC8ZAPg+iodvSjlY+NZeln3ym8NrB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728594724; c=relaxed/simple;
	bh=SksNYFhgOmMcSUC6Nc0a+z8yZGuwRwsmlbf60jF4T0c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aH1skK1iiNaVOoAKXVERzQxWqkLF03uNLjXA8F3LQflVP/jDi6A5EwmFOJNSYFUMra1iHR1Jo/8uj4n6+h3X8Tlm6LTfy+FqY0jPDBJuM9U8du3kRlFsqGR94F4wBOYJvWwFbhI3Qsjq7XZHy26L0nCUKSTsZPGSctmIyw5EMlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lpy326JN; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lpy326JN"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e315a5b199so27092167b3.2
        for <git@vger.kernel.org>; Thu, 10 Oct 2024 14:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728594721; x=1729199521; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oQZQbRoNRBxHmUuDOufrZ/vTZykZqe0/hdNVXod1fR8=;
        b=lpy326JNxe/ymQ1Zn91RnKRR3zXHk7inyg7bBuy9VsnKP6ExX/ScU1xtzyyyU6WrVR
         doJVXS8G3ZvlazA99OQYY4ykgrvUEf4GgrnpLjVB4ATEwBvyNcc0nArSa4N5uAgKYmTa
         wDqFnlcU5+ooKq1kURmE1yKAcbLDQ0hJR03siAwhu+sehvu1OmIkAFok4+CLK7qbHZiv
         hkwESVCmJq/F4h4/BU3DRP5fbAvTdFFEYlUmz+xaCRPceahNDAggYC1c31Ro45jdPEmK
         5xT1iQY9HGSaGb8EzgJdGFAmaqizqkHoHh+kPGlOWHfFMEDGeODcAQl2i9H45a2WyY+A
         Y07A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728594721; x=1729199521;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oQZQbRoNRBxHmUuDOufrZ/vTZykZqe0/hdNVXod1fR8=;
        b=eZwC7ZRZsWRpvsBzn14rI0Kg24+inNkM8FqctySKGb8f1GL4Af0LvbeP6NiNTENgoz
         x/taFMOigrxHTwL0yC3/yJgYg3w0JniPh4qQqW7Cy+U55nv3l5YnjHNa9OZJPcEpIDLF
         oiItiLdDd0Ao6FTIsStS4OYHw/JnivaPGmI0iPv1BI7nUqFcYdsAk8wxkzNWf+jLQlQI
         cbFwnavMZoQVO6MNQ28KMDSDboy8LE3BUAgcHhC3T6ExbYFM7Lu+WcA2ykBIKeMEPmnc
         aO8fHRT7QgwKt5Vp97REG6IxVlAzdMcGfgOCC141ra3aaeMot9vipKaXzwf3cz5hBJwl
         bj3g==
X-Gm-Message-State: AOJu0YxfPZP6ODTk09i8NdG1xQIdU8sf8xaJF6QvMfI4Ie9s/lYwIk3N
	8c72PTz3Cq5jGD73198/F1yro61ypAt1q9L69m56wi03ADkIjg894EDEZG4wfmq6pJZtQNtBFVO
	Cl6ZUllJ3XHAV5qSJdHz/vr+CzSGCPtrrKGIWUglqHEchlbITcBBg0Izid+nCm5X1ZV9BVUc2Hy
	XXtwjUCU1B7M7ICdQe68zoJp6Nt9MDAqNqlQ9MwzI=
X-Google-Smtp-Source: AGHT+IF/PNrPmoTIhDT/7G1/XMMcim2IxH77p7vshqJHKsRtGqk/llzWuhUcn8pidXcHPsE12g7S7XhEbyO5PQ==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:5a71:d442:305f:726f])
 (user=steadmon job=sendgmr) by 2002:a25:74ce:0:b0:e24:a00a:518e with SMTP id
 3f1490d57ef6-e291a202b4fmr258276.7.1728594721344; Thu, 10 Oct 2024 14:12:01
 -0700 (PDT)
Date: Thu, 10 Oct 2024 14:11:54 -0700
In-Reply-To: <cover.1728594659.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1728594659.git.steadmon@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <770fe27c67638c315daf03412d0ce935d5e9bee5.1728594659.git.steadmon@google.com>
Subject: [PATCH 2/3] fuzz: port fuzz-parse-attr-line from OSS-Fuzz
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
fuzz-parse-attr-line

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
 attr.c                              | 38 +------------------------
 attr.h                              | 43 +++++++++++++++++++++++++++++
 ci/run-build-and-minimal-fuzzers.sh |  1 +
 oss-fuzz/.gitignore                 |  1 +
 oss-fuzz/fuzz-parse-attr-line.c     | 39 ++++++++++++++++++++++++++
 6 files changed, 86 insertions(+), 37 deletions(-)
 create mode 100644 oss-fuzz/fuzz-parse-attr-line.c

diff --git a/Makefile b/Makefile
index 3ce391062f..141e194bf5 100644
--- a/Makefile
+++ b/Makefile
@@ -2382,6 +2382,7 @@ FUZZ_OBJS +=3D oss-fuzz/fuzz-credential-from-url-gent=
ly.o
 FUZZ_OBJS +=3D oss-fuzz/fuzz-date.o
 FUZZ_OBJS +=3D oss-fuzz/fuzz-pack-headers.o
 FUZZ_OBJS +=3D oss-fuzz/fuzz-pack-idx.o
+FUZZ_OBJS +=3D oss-fuzz/fuzz-parse-attr-line.o
 .PHONY: fuzz-objs
 fuzz-objs: $(FUZZ_OBJS)
=20
diff --git a/attr.c b/attr.c
index 06b5b5e55e..f7898285c5 100644
--- a/attr.c
+++ b/attr.c
@@ -259,42 +259,6 @@ const struct git_attr *git_attr(const char *name)
 	return git_attr_internal(name, strlen(name));
 }
=20
-/* What does a matched pattern decide? */
-struct attr_state {
-	const struct git_attr *attr;
-	const char *setto;
-};
-
-struct pattern {
-	const char *pattern;
-	int patternlen;
-	int nowildcardlen;
-	unsigned flags;		/* PATTERN_FLAG_* */
-};
-
-/*
- * One rule, as from a .gitattributes file.
- *
- * If is_macro is true, then u.attr is a pointer to the git_attr being
- * defined.
- *
- * If is_macro is false, then u.pat is the filename pattern to which the
- * rule applies.
- *
- * In either case, num_attr is the number of attributes affected by
- * this rule, and state is an array listing them.  The attributes are
- * listed as they appear in the file (macros unexpanded).
- */
-struct match_attr {
-	union {
-		struct pattern pat;
-		const struct git_attr *attr;
-	} u;
-	char is_macro;
-	size_t num_attr;
-	struct attr_state state[FLEX_ARRAY];
-};
-
 static const char blank[] =3D " \t\r\n";
=20
 /* Flags usable in read_attr() and parse_attr_line() family of functions. =
*/
@@ -353,7 +317,7 @@ static const char *parse_attr(const char *src, int line=
no, const char *cp,
 	return ep + strspn(ep, blank);
 }
=20
-static struct match_attr *parse_attr_line(const char *line, const char *sr=
c,
+struct match_attr *parse_attr_line(const char *line, const char *src,
 					  int lineno, unsigned flags)
 {
 	size_t namelen, num_attr, i;
diff --git a/attr.h b/attr.h
index bb33b60880..2319ef31e3 100644
--- a/attr.h
+++ b/attr.h
@@ -240,4 +240,47 @@ int git_attr_system_is_enabled(void);
=20
 extern char *git_attr_tree;
=20
+/*
+ * Exposed for fuzz-testing only.
+ */
+
+/* What does a matched pattern decide? */
+struct attr_state {
+	const struct git_attr *attr;
+	const char *setto;
+};
+
+struct pattern {
+	const char *pattern;
+	int patternlen;
+	int nowildcardlen;
+	unsigned flags;		/* PATTERN_FLAG_* */
+};
+
+/*
+ * One rule, as from a .gitattributes file.
+ *
+ * If is_macro is true, then u.attr is a pointer to the git_attr being
+ * defined.
+ *
+ * If is_macro is false, then u.pat is the filename pattern to which the
+ * rule applies.
+ *
+ * In either case, num_attr is the number of attributes affected by
+ * this rule, and state is an array listing them.  The attributes are
+ * listed as they appear in the file (macros unexpanded).
+ */
+struct match_attr {
+	union {
+		struct pattern pat;
+		const struct git_attr *attr;
+	} u;
+	char is_macro;
+	size_t num_attr;
+	struct attr_state state[FLEX_ARRAY];
+};
+
+struct match_attr *parse_attr_line(const char *line, const char *src,
+					  int lineno, unsigned flags);
+
 #endif /* ATTR_H */
diff --git a/ci/run-build-and-minimal-fuzzers.sh b/ci/run-build-and-minimal=
-fuzzers.sh
index d9d3ad23c7..60fe8b0dfc 100755
--- a/ci/run-build-and-minimal-fuzzers.sh
+++ b/ci/run-build-and-minimal-fuzzers.sh
@@ -20,6 +20,7 @@ credential-from-url-gently \
 date \
 pack-headers \
 pack-idx \
+parse-attr-line \
 "
=20
 for fuzzer in $fuzzers ; do
diff --git a/oss-fuzz/.gitignore b/oss-fuzz/.gitignore
index 2cfc845b20..ec185f061c 100644
--- a/oss-fuzz/.gitignore
+++ b/oss-fuzz/.gitignore
@@ -4,3 +4,4 @@ fuzz-credential-from-url-gently
 fuzz-date
 fuzz-pack-headers
 fuzz-pack-idx
+fuzz-parse-attr-line
diff --git a/oss-fuzz/fuzz-parse-attr-line.c b/oss-fuzz/fuzz-parse-attr-lin=
e.c
new file mode 100644
index 0000000000..45a4c4e53c
--- /dev/null
+++ b/oss-fuzz/fuzz-parse-attr-line.c
@@ -0,0 +1,39 @@
+#include "git-compat-util.h"
+#include <stddef.h>
+#include <stdlib.h>
+#include <stdint.h>
+#include <string.h>
+#include "attr.h"
+
+int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size);
+
+int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
+{
+	struct match_attr *res;
+	char *buf;
+
+	buf =3D malloc(size + 1);
+	if (!buf)
+		return 0;
+
+	memcpy(buf, data, size);
+	buf[size] =3D 0;
+
+	res =3D parse_attr_line(buf, "dummy", 0, 0);
+
+	if (res) {
+		int j;
+		for (j =3D 0; j < res->num_attr; j++) {
+			const char *setto =3D res->state[j].setto;
+			if (ATTR_TRUE(setto) || ATTR_FALSE(setto) ||
+				ATTR_UNSET(setto))
+				;
+			else
+				free((char *)setto);
+		}
+		free(res);
+	}
+	free(buf);
+
+	return 0;
+}
--=20
2.47.0.rc1.288.g06298d1525-goog

