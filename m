Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151B2275AE6
	for <git@vger.kernel.org>; Fri, 13 Jun 2025 11:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749815892; cv=none; b=gMaH0JGOfLk4jlkGnxwWFfb3Zvo5au5q/hkBToc051myDDbuQNo40eDIxg0KhfUKqnq2fVvRnE7ULOqBoSR/lXbOzfyfPbMB8ob0O2SLV0fqgIHn6KB8kXm/1s84Arxxs1u3QKVLsA8/HQiNnznamGaxeSQA7dz9elUESLKW9lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749815892; c=relaxed/simple;
	bh=reOGn6Eqy/Te5Qytb2tc1MAQMLkA3vwuCIP32SUFKOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sw7N+6oqZLZzpbWqHbdredJNghmZ6X0idUoSRC59QjCrrSmnFIlM4PvUHpwK+Mq0cGuH7WKAs2SXmi3p8XRSyyfSTI8mLXHoY3LwVmJGSjcLAcLFLIACFozIqZiqr9yN2OzkCCSjtER3t6AV+vk89YeRxxu0NNLUTOaHOrV89iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AWRi1fvY; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AWRi1fvY"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-742caef5896so1872310b3a.3
        for <git@vger.kernel.org>; Fri, 13 Jun 2025 04:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749815890; x=1750420690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KFr5j0lFT6vocegsk+PaL5LpczIBHc7A9Jxn5AghiNU=;
        b=AWRi1fvYkumadshBkdJJGeKEiRagZyjpHTNDbUtPWzvBxnhTbmOWGCZoNTUcptG917
         2TPKkky1Ts9lHkzeh1PxaSqyoqX0UMQ74W9H7d1rqCuJ5niWp5d99kEREDpuG5rFqL2q
         KOzuFpQ7Q0fdZ5K5pDX86Ut14sO3kXuRWPfCovmXc1ht8dd4jKvTYDOKhZLB0tADSSkC
         M1oOO4nL9cIWrQepokpjygVEaG6YoeZeXCUdlPn5AJ63wEladx1LDpW1/uRrRxKkZFFT
         pq9AdHmZBAaLOcF8pufnzns3e6GF6iESCwFiKBta29Auf+KPVUppuasq5vqkscHJ01YJ
         fZWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749815890; x=1750420690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KFr5j0lFT6vocegsk+PaL5LpczIBHc7A9Jxn5AghiNU=;
        b=eMiBhhqd2l801auQCYT4jvSAPHvBGmxJwtBlpcMsMVqYhyu6FBiD2BeDQ+ToIEmEp7
         IogCpY4N47zBs+6yGoPpVMlrqqWGqWz6c5yT1czP4wnP60L4ZdzhajyTbv6SLxhCynu1
         nKvnLuBU8RnCu4jB/XJXTWaRqU4sPHTbr1DBiq8oME81m5o0sO1s5+0crs7SrbtjJO1M
         QAaGv6kLXY9BB5M6DnZ/M2ECVV6xaDQhK9GuZX75RAaKK+RAMcqFvrbJ1qw0jNLI5Bjc
         GgHHbBoeJXCsfffWXdsymdjTcqs3v+TcWKHIVcnuIiKGfg6/Vl0K8RoVZL1jX8Vhh9xq
         8bDA==
X-Gm-Message-State: AOJu0YyS+HqdA18UbD9QDzlGRMP476JwTVcBQ0mT/JZIKQKN78/jBjyG
	UWgIiM/S0tB9UpMAO2+ojpSrBvy1/TGDYDaGHJrvwrtJnrOAbnhzTRDGUgKCgEZ2
X-Gm-Gg: ASbGncsj+qkkjqt/MjTbgI3LC1YZzbEG6l+crnRE581klnxZ7U2dRfA5HaY4xWhVj3+
	5cCKGcuFvBZLxpCKO4tHDtAlw9m8TJHCIaQfca6DZDMpn8H1OIn4ZlnZOideTxlixM0pCcLDTq3
	DwK2q4es8xvUqQfaEqoP3GodgM1Rcq6bOPgTyv+lwTZpRtGdlr5YY6/ANF+o3w9NVcsWWEgHEXB
	OUF7z++7mHRQmfcjxMz3yOU7kll30RuzWYYAvEfa8meeJV4WG1ab8SHXYF9tiWXbGq6CwdbniFF
	BCuMx9MYjrJ47Z5hevbPNR0LDseS1VuamLNCAs7QiuazqG/p8hV7gUN6fq8l5QbxEuJnse10/3j
	BlGvK1Bmb0KPhPh1U5Q==
X-Google-Smtp-Source: AGHT+IFcK753a7uHqVND1OvIzWRA4S2OENx/AvxBf3+5ble9wIJzVTLPLFac+/013PmCmiQmct6HEg==
X-Received: by 2002:a05:6a00:3c95:b0:748:3964:6177 with SMTP id d2e1a72fcca58-7488f71eb8dmr4255097b3a.19.1749815889942;
        Fri, 13 Jun 2025 04:58:09 -0700 (PDT)
Received: from Mac.lan ([2409:40e3:18f:923d:783d:9594:9008:776e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748900d0d90sm1378077b3a.155.2025.06.13.04.58.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 13 Jun 2025 04:58:09 -0700 (PDT)
From: siddharthasthana31@gmail.com
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	viakliushin@gitlab.com,
	johncai86@gmail.com,
	gitster@pobox.com,
	Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: [PATCH v2] cat-file: fix mailmap application for different author and committer
Date: Fri, 13 Jun 2025 17:27:17 +0530
Message-ID: <20250613115750.41205-1-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250611062643.8639-1-siddharthasthana31@gmail.com>
References: <20250611062643.8639-1-siddharthasthana31@gmail.com>
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

This bug was introduced in e9c1b0e3 (revision: improve
commit_rewrite_person(), 2022-07-19) when the much simpler version of
commit_rewrite_person() that worked on one "person header" at a time
was rewritten to use the current apply_mailmap_to_header() function.
The original implementation processed author and committer separately,
but the rewrite introduced this loop-based approach that failed to
properly handle the transition between identity lines.

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
index 4a6242ff99..74b7ddccb2 100755
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
+	sed -n -e "/^author /s/>.*/>/p" -e "/^committer /s/>.*/>/p" log >actual &&
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
+	sed -n -e "/^author /s/>.*/>/p" -e "/^committer /s/>.*/>/p" log >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.49.0

