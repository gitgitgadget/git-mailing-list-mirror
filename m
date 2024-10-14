Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD1E4683
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 21:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728939858; cv=none; b=aQFmt/0J7UZnveRYF/tIraoRuWsKYxrTBOUic174d50iN6kSjbuwnGbxyutLnsZsHZFflI5RcLChK7SwhwOfBWR/rnY9fLDJSL2U53i0yR60wFwiu0Mr0m94RYRg7aaaI4mSgiLnFa3AlxxkJ8lxucREgsrf15ysXJt2t3OJJHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728939858; c=relaxed/simple;
	bh=oa8b3rlK1UycChk0hJauvVi5IVdQ0QMER2Pel62MEw8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EXYrpcRS56HVqyXvFv5HykMbBCRR+mwEsWPMErZgBCT8e+9b8sZb/N1SDy3hmbeMFAW0g6CDZgNQfrU8/3g9NvPpbKfmlkfOuVSrTQpzqVbsu3AosYVj0M8yPAktUBXohnSOOzyZaPnWewh46+MJctvlg8T7vQEpQkkBbu97t+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vwjztWMW; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vwjztWMW"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e387c4dca2so24775607b3.2
        for <git@vger.kernel.org>; Mon, 14 Oct 2024 14:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728939855; x=1729544655; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YNlGfi/ZeJ8EWRmH8dOS39wdm1/3PK9+itYjq0GRxcY=;
        b=vwjztWMWmrYZdVBcaMONQPi5z8Vp6mi2i7QVQRBJL9WrBLkGYGtCs9KtQd8PD6kN3X
         HMpn3hSN5B660erz9Qn/imnaTH3z9w6Sm8bMxoRk0pZCFIMvLImV+zQSUJKN4A+GbB2J
         OAd5QrISr1z9qK070X4gzatiFak82L2YB1MAUFH2Lrmogt2B/Vy2K1D7P5KFvMEBqOFw
         Fl6knRJRUPt0vwPEOQmcv4EbBWv340lyyk7WoityTIpKByY1VbXh7ao3HDUWdF8l0zU/
         nJm62jTnaZV73jr5Vbbf4vTif4xwJ4C6/lG6uxCNEZ1yOHRAICvJSDgF8aMj0yiuQzrZ
         s9/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728939855; x=1729544655;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YNlGfi/ZeJ8EWRmH8dOS39wdm1/3PK9+itYjq0GRxcY=;
        b=K9VnXWL4W22uGJ7t4MVNJZ/4i4hHj7cuR83zp/gs/UH+SwLIQsfevrYQ8j67k2jSgo
         a5H3gwwu46swhSDRd55exyLHPZptfNa+le8AD6OjPlbN5keWFliyYWDgLNjTo3Pd4E/p
         SW5+YOng4tCaaLgcln7br133jvARJQEvcdbdb5HeASvi7bdubV8PPe2LlJoDHr4JQExh
         RuismpfmP1OTk4lngce2xyQRn24a0SlIhgjxeZbl3LloLvA34RBVotvOOVWiNwNMkLZT
         GZqBb+yJ8WegXYucS64O1wHDCDMS5Aoxx7m5PxB6LLnx6Ft54YJblzGnbElfe5ptZIiD
         Qw9Q==
X-Gm-Message-State: AOJu0Yw2yUB31m6QZDcT+Wc+JhlYwTfwP1B2HMIjTXhqBzbEaPALm9aI
	dZdlcu1hi23kppcAFKI3Joaxy2RC41i6YOJ2tGOXZ/qCugur/DwfGVrAGGEM+3z86SvteYQWQVc
	TeFzzBTwp1kJZcbAiCUw4Ht4kgR48AXH9VI9iYB0SIiXlbCiVynH7yVwd3mgkqLOyX3m+l8y7IQ
	cxrdzHrrtEAxtX5sPtripGcTx8DojckE5J3hCMgCE=
X-Google-Smtp-Source: AGHT+IFPBM25p7CRnF4AfdBCdkbIFjfutgkR38+CMaq6zG4Yls/NnQNyMbHT6SSU12IYfA3REzsGdJqAamEXvg==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:2a9b:d27f:d626:2e54])
 (user=steadmon job=sendgmr) by 2002:a25:740b:0:b0:e28:ee84:e4d8 with SMTP id
 3f1490d57ef6-e2919dd29fbmr8291276.3.1728939854986; Mon, 14 Oct 2024 14:04:14
 -0700 (PDT)
Date: Mon, 14 Oct 2024 14:04:09 -0700
In-Reply-To: <cover.1728939687.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1728594659.git.steadmon@google.com> <cover.1728939687.git.steadmon@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <16c6573190e0289eb1f38330796177fb1a066804.1728939687.git.steadmon@google.com>
Subject: [PATCH v2 2/3] fuzz: port fuzz-parse-attr-line from OSS-Fuzz
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
 attr.c                              | 40 ++-------------------------
 attr.h                              | 43 +++++++++++++++++++++++++++++
 ci/run-build-and-minimal-fuzzers.sh |  1 +
 oss-fuzz/.gitignore                 |  1 +
 oss-fuzz/fuzz-parse-attr-line.c     | 39 ++++++++++++++++++++++++++
 6 files changed, 87 insertions(+), 38 deletions(-)
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
index 06b5b5e55e..b0073c5277 100644
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
@@ -353,8 +317,8 @@ static const char *parse_attr(const char *src, int line=
no, const char *cp,
 	return ep + strspn(ep, blank);
 }
=20
-static struct match_attr *parse_attr_line(const char *line, const char *sr=
c,
-					  int lineno, unsigned flags)
+struct match_attr *parse_attr_line(const char *line, const char *src,
+				   int lineno, unsigned flags)
 {
 	size_t namelen, num_attr, i;
 	const char *cp, *name, *states;
diff --git a/attr.h b/attr.h
index bb33b60880..a04a521092 100644
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
+				   int lineno, unsigned flags);
+
 #endif /* ATTR_H */
diff --git a/ci/run-build-and-minimal-fuzzers.sh b/ci/run-build-and-minimal=
-fuzzers.sh
index 631796ab8b..13c85320d6 100755
--- a/ci/run-build-and-minimal-fuzzers.sh
+++ b/ci/run-build-and-minimal-fuzzers.sh
@@ -20,6 +20,7 @@ credential-from-url-gently
 date
 pack-headers
 pack-idx
+parse-attr-line
 "
=20
 for fuzzer in $fuzzers; do
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

