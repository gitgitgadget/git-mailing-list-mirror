Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E453A226CE4
	for <git@vger.kernel.org>; Wed, 11 Jun 2025 06:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749623233; cv=none; b=U0PtrfDvJXtcs4aysgrnweWJPIPODZCGFFLhwUf0UjBeRMWs/9NZY52VH3OwhlLJ/pUB6Kuv0bACsEJHig3o9U+9rgefPW3pqG73eEfA8PDaxqVcY45LgZl3fSQV9OYIfNsBLhXu7ThP0Nt3xEgAM1k6SNIfImIsLUNtR9ONehE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749623233; c=relaxed/simple;
	bh=44M8UsInRS3s/XAOjTV9YEqSbvHF/BhTf3kKHPwjAHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DBpFfKrix3G6Rq6Ue1tjmXQNqtuLLLdj4fRrCEKANg+KbrNfCWc0Sb9BhcVx296M5b06eE1vEl/piSGi+3PRf1Bj6jIMh+qY9tCvJJSUe9Q56KxoQ8DWkyTL+fud88ydwTXLabOzUsu3N1DFPYcNqFI/aWE1nZirnZdpFXEZ98k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V8omW7RR; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V8omW7RR"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-234d366e5f2so71506145ad.1
        for <git@vger.kernel.org>; Tue, 10 Jun 2025 23:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749623231; x=1750228031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kDwJGfhGJIMY2v+dyXeptk3yS+fSrHpZA4ZTB9JuMP8=;
        b=V8omW7RR4jteNJDUAeoCyacBtSryES2JEkUMraMAoOLlvYy1SW2goh7C/9gDjW2fsh
         bhIc8rbqo/4/NzPuCZkWsikixL2jN1bxXr9SSUmoCdNU/DMyONtmxdhvwosVr/UEcBtc
         jSJMvJdf0mUViGdi+vyVI/LjN3nC6PlentEQs5nYR7h95iTyonrEM07d3E5nhTEj6LVX
         tp3pt3dOuX3nA7NRjY23Cgb5hz3nX+F42fBifCnip4uC/pLW0nZx7gYmOeY9mmW50B+Y
         hOMslIFzKuTFKUrQePvc5T/jtLOBcQ6d4IvaMPYnDD72yqJVAsGkIN6WOHviQm+kmiCn
         NQng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749623231; x=1750228031;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kDwJGfhGJIMY2v+dyXeptk3yS+fSrHpZA4ZTB9JuMP8=;
        b=j28Y2daiCaCfxF9qUAtpgtYNYknuwwTRXhhdhaSwwMnehV/NVo/4ZKbuNLdx68kvDr
         K92U0vojkkb1EiuNaTs+5ssN/pxDLUZtnC9Xcy1FgkOiGS5fIWwMN24k7XJN+Qc0VCU2
         iziF59x5WDuhfuE90h+pDj+t97E94nRwlVjw0zUUDIQthOzg+dlywR6OXCkMNQVT7Dos
         54zFNCH4VOrDCvwOk//PpcrPyimsSOcB9ZCVOyJh5MK4oEmh2iGlpKIzgK4dWrKQs0MQ
         3B5QFTc2fX4LJatlyGrxfSaCbIKNJKkyH87P/eZSMXx5w2lrenoDiSyCYQiLYRlwv13f
         2ziQ==
X-Gm-Message-State: AOJu0YwDj5uBgbWyt3+UlzYidh9w7pVh0tsHJoxzBT0RI8fMwOJyIWlr
	1NxXxFRNE5aaLzs/HNiHtP8z7tyq9kaZSqxhRlGAWYtPsaCQr2nRrCYoqWsvZEtZ
X-Gm-Gg: ASbGncsIvevLA0tLgYZFaGH7OQ7SpUPk46uz4K98grqjsizYoXXrOhSymqQVeU1pSRJ
	+9HPLF1bUglgEDSh6B+8mJBzhHnQN+Z76lkHmjqrsN031eh6Yq4hQxYmhI15lHAwu7rY5hutTM4
	wCow43S1dCNVPljn8ETLa8CILqE8fz4VXNk/FvaFGAbC3Z5orSxctrrO0nVvyoeH3mUwOBwk6N0
	IA/UXH6br8H5xSVqrDWlZqoB1MEN0WZKaEbJGgaLdxPh0IGolh8hHsTS3CkB/grPec7gidLpB36
	WGfg6EdM0tT6wgHQHuFz1enu8VL3AxcCrAcG5oJtV/Bqzb+c+Y59bFgw6O+GZpU/AW9uUR6AvfD
	uV0pZm4b31LQrkILsoTSvbj13+QFR
X-Google-Smtp-Source: AGHT+IEPc2gtbfIYyYzmpPID92us023Z0PFVK0MbpKh9UpTSYJgJXx0ejHbDHqX9CS5QQ+KUEzQItA==
X-Received: by 2002:a17:903:32c1:b0:235:a9b:21e7 with SMTP id d9443c01a7336-23641b2654bmr30856555ad.48.1749623230700;
        Tue, 10 Jun 2025 23:27:10 -0700 (PDT)
Received: from Mac.lan ([2409:40e3:18f:923d:dca7:5965:4e63:d2ee])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236032fcea0sm81084455ad.103.2025.06.10.23.27.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Jun 2025 23:27:10 -0700 (PDT)
From: siddharthasthana31@gmail.com
To: git@vger.kernel.org
Cc: siddharthasthana31@gmail.com,
	christian.couder@gmail.com,
	viakliushin@gitlab.com,
	johncai86@gmail.com,
	gitster@pobox.com
Subject: [PATCH] cat-file: fix mailmap application for different author and committer
Date: Wed, 11 Jun 2025 11:56:43 +0530
Message-ID: <20250611062643.8639-1-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Siddharth Asthana <siddharthasthana31@gmail.com>

The git cat-file command with --mailmap option fails to apply mailmap
transformations to the committer field when the author and committer
identities are different. This occurs due to a missing newline handling
in apply_mailmap_to_header() after processing each identity line.

When rewrite_ident_line() processes an identity, it stops at the end
of the identity data (e.g., "Author Name <email> timestamp"), but
doesn't account for the trailing newline. The current code adds the
identity length to buf_offset but fails to advance past the newline
character. This causes the next iteration to start parsing from the
newline instead of the beginning of the next header line, making it
impossible to match subsequent headers like "committer".

Additionally, rewrite_ident_line() may reallocate the buffer during
its operation. Any code using pointers into the old buffer would be
using invalid memory after such a reallocation.

Let's fix this by addressing both issues:
1. After processing an identity line, we now check if we're at a
   newline and advance past it, ensuring the next header line is
   parsed correctly.
2. We recompute the buffer position after rewrite_ident_line() to
   handle potential buffer reallocation.

This ensures that all identity headers in commit and tag objects are
consistently processed regardless of whether the author and committer
are the same person.

Reported-by: Vasilii Iakliushin <viakliushin@gitlab.com>
Reviewed-by: Christian Couder <christian.couder@gmail.com>
Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
---
 ident.c            |  4 ++++
 t/t4203-mailmap.sh | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/ident.c b/ident.c
index 967895d885..281e830573 100644
--- a/ident.c
+++ b/ident.c
@@ -412,6 +412,10 @@ void apply_mailmap_to_header(struct strbuf *buf, const char **header,
 				found_header = 1;
 				buf_offset += endp - line;
 				buf_offset += rewrite_ident_line(person, endp - person, buf, mailmap);
+				/* Recompute endp after potential buffer reallocation */
+				endp = buf->buf + buf_offset;
+				if (*endp == '\n')
+					buf_offset++;
 				break;
 			}
 
diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
index 4a6242ff99..98dd0ae12f 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -1133,4 +1133,37 @@ test_expect_success 'git cat-file --batch-command returns correct size with --us
 	test_cmp expect actual
 '
 
+test_expect_success 'git cat-file --mailmap works with different author and committer' '
+	test_when_finished "rm .mailmap" &&
+	cat >.mailmap <<-\EOF &&
+	Mailmapped User <mailmapped-user@gitlab.com> C O Mitter <committer@example.com>
+	EOF
+	git commit --allow-empty -m "different author/committer" \
+		--author="Different Author <different@example.com>" &&
+	cat >expect <<-\EOF &&
+	author Different Author <different@example.com>
+	committer Mailmapped User <mailmapped-user@gitlab.com>
+	EOF
+	git cat-file --mailmap commit HEAD >log &&
+	sed -n "/^author /s/\([^>]*>\).*/\1/p; /^committer /s/\([^>]*>\).*/\1/p" log >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git cat-file --mailmap maps both author and committer when both need mapping' '
+	test_when_finished "rm .mailmap" &&
+	cat >.mailmap <<-\EOF &&
+	Mapped Author <mapped-author@example.com> <different@example.com>
+	Mapped Committer <mapped-committer@example.com> C O Mitter <committer@example.com>
+	EOF
+	git commit --allow-empty -m "both author and committer mapped" \
+		--author="Different Author <different@example.com>" &&
+	cat >expect <<-\EOF &&
+	author Mapped Author <mapped-author@example.com>
+	committer Mapped Committer <mapped-committer@example.com>
+	EOF
+	git cat-file --mailmap commit HEAD >log &&
+	sed -n "/^author /s/\([^>]*>\).*/\1/p; /^committer /s/\([^>]*>\).*/\1/p" log >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.49.0

