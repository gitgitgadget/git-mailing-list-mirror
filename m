Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195E533F8D9
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 09:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783502706; cv=none; b=RnA+xaQSH2nECmWFUyAFqd5Abfg2FLGncNyOZDB5jP23GGmwCgJ29umKO/AaPf+D8Q43b15Ufj000ecWLg+zfDqaC6mtnd79tOwXpc9CldTrLZ5Yl0VLwOy93BPC5NtnS1DdOQJsAviTovPNmmZo3uPvmZHWs4Gl3mtr/qa1MEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783502706; c=relaxed/simple;
	bh=/6BjiebctukFfevXLlFrmIMrukDWr96DYCUVO5W2HMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=go0fRbTlsAjZ1YeR5wRyTmzMKuOWPGOfXW/IjEx00AOpHNfeBDY7zcIDw3Qqs9YlbKrkW4kZZtcsq07twPSwjWQUUTapaOCUCYvSUxHeWMYf6VEnEkMQZyRlOnzIz/s1p2aOGqEuwUSwwm+odCXr4YHMvlxjkxoHSd2fJf8As/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qEEkhoaj; arc=none smtp.client-ip=74.125.227.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qEEkhoaj"
Received: by mail-pj2-f1.google.com with SMTP id 98e67ed59e1d1-38108e5002eso176188a91.0
        for <git@vger.kernel.org>; Wed, 08 Jul 2026 02:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783502704; x=1784107504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4LFrYU8q5T5OzCF+9jozKgF/6UZL1RsknvERmD5rFOA=;
        b=qEEkhoajBrQaVmN8kIQlzVZTHQJArS5La067nFZn571F2++c/Q6IKaeB3f5G6ffGdc
         eWSWFIqUWkEZzxh3v1o8jID0HU6lZZmmrms/EIIbHsA/nzT+jj4eTqtG7HkyMieToqOr
         ljH7lAKlpF58OlB07KCgWEdSHN0W1LjIjFVZefbqSYaRF6ltD4QM6FsQDs9O6l4oiwxf
         CtI1U/GMGkw0RBEQq7JyJY9Ss9cJJXuhhVaBE9wMZwG73NeYbI5XwwZdoe9/IqDQu1gQ
         qGNQYsT5LPzun/+5q7WhaeOCF2QlhvNMFSzabgaTcKuGgSt+Q1KXu5E+OB3ROm+5raec
         gGQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783502704; x=1784107504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4LFrYU8q5T5OzCF+9jozKgF/6UZL1RsknvERmD5rFOA=;
        b=qLv6EhlzLEI7GadvHOH64VaBQ2BApQyKix6MCKBRvwqYJ6O6FeVCWqYmHHFjhjT8CE
         khAqMVjhffj7GBbbON5DTYWNphinUl8tVpSHTkSQa4tnlKaasb38tgks2g7ObRpdBgn7
         8629jSyHAxMMTVvNjJxECs7T+v6f8XmFWZpkv82MMHn5T/PX64VK3FeX4YCCNHLumCHX
         Ju1fVKbXMRE2nTUor9rM4qkZuDtS/T1gmpvgyicP/Fdqyj3ekXVAJF0Mr6Udmcs/OEHj
         RUf+rku0cKL5CpyocomWwRxXI3EDRT/0hcz8u4WbYhgCVN74P7WIHakn2l+GQLl5Erjj
         5bwg==
X-Gm-Message-State: AOJu0YxTkWLZn8RMsUVy4dvK1B6Lx+HrDgZxEEq4mye5CYv5iKqmFj0C
	brZjFMdRjE2GeBvbaWVgjEqPs2eJYcQ1Elr5GqgE+DJUHq/5PNFtfuN+pe5SZqHnJyg=
X-Gm-Gg: AfdE7cm+1c+E5zZVhpLkd92HU0Q7aNJGNenkHrV8I+zDJ5JegugVEbN+Vtqg1Io7wPr
	YvF+fZklF/h4HAv7bK3uACMMXquohwe9REgOlfwBlM0y02PjVNDvEDNqHwloBmm7vW5qdA/kN5I
	LVdwp5PMBOBkZ8ZhCQ2JqfNxtKTtZq+uXVjbDttrQkQKLWK/P4ISOGAobu53fx0zrPF826QC86Y
	XWOxw+jNmvMvc+/1TO3ZleD4bd0EPCSr39RGeoro6B/NR9jjUcI+ydhDMlU06B/NuYtph+vOFhq
	JCPtL8OqZs/r4rjPtEvzyzxQErCzANgU8gXZTHl4xdhavLIAZaTZ+5LUBfk3wn52K1rGcNl8Vfx
	VNqzOXE0A8zBy7n91fuKmsYVAz2UYdtyA096+NhXi8yTeRwKhNdmHXuJxMFKhw28SomGOQi1AR5
	gKvAwMD3yfqKLNiQNohkeMEsdiKpvciEnmuOV9jGug2vCJ2JCBd2tMiUmYqA==
X-Received: by 2002:a05:6a21:7a97:b0:3b2:924c:566e with SMTP id adf61e73a8af0-3c0bd0fa25bmr2034374637.36.1783502704247;
        Wed, 08 Jul 2026 02:25:04 -0700 (PDT)
Received: from localhost.localdomain ([45.117.66.208])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174a92eccsm16862740eec.23.2026.07.08.02.25.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 08 Jul 2026 02:25:03 -0700 (PDT)
From: Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com>
To: git@vger.kernel.org
Cc: Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com>
Subject: [PATCH v3] t1410-reflog.sh: avoid suppressing git's exit code in pipelines
Date: Wed,  8 Jul 2026 14:50:05 +0530
Message-ID: <20260708092448.35776-1-gatlavishweshwarreddy26@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <xmqqechf8ryu.fsf@gitster.g>
References: <xmqqechf8ryu.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Piping git commands directly to wc -l suppresses the exit code of
git, hiding potential failures from the test suite. Capture the
output to a temporary file first, then count the lines separately
to preserve the exit code. Where the expected count is known ahead
of time, use test_stdout_line_count instead.

Signed-off-by: Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com>
---

Changes in v3:
- Removed all variables (HEAD_entry_count, main_entry_count) entirely
- Removed all temporary file captures (reflog_output, reflog_main_output)
- Used test_stdout_line_count with hardcoded counts throughout
- The counts are known ahead of time: HEAD=5, main=5 initially,decreasing as entries are deleted

 t/t1410-reflog.sh | 27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
index ce71f9a30a..3f2e36cf33 100755
--- a/t/t1410-reflog.sh
+++ b/t/t1410-reflog.sh
@@ -244,30 +244,22 @@ test_expect_success 'delete' '
 	test_tick &&
 	git commit -m tiger C &&

-	HEAD_entry_count=$(git reflog | wc -l) &&
-	main_entry_count=$(git reflog show main | wc -l) &&
-
-	test $HEAD_entry_count = 5 &&
-	test $main_entry_count = 5 &&
-
+	test_stdout_line_count = 5 git reflog &&
+	test_stdout_line_count = 5 git reflog show main &&

 	git reflog delete main@{1} &&
+	test_stdout_line_count = 4 git reflog show main &&
+	test_stdout_line_count = 5 git reflog &&
 	git reflog show main > output &&
-	test_line_count = $(($main_entry_count - 1)) output &&
-	test $HEAD_entry_count = $(git reflog | wc -l) &&
 	! grep ox < output &&

-	main_entry_count=$(wc -l < output) &&
-
 	git reflog delete HEAD@{1} &&
-	test $(($HEAD_entry_count -1)) = $(git reflog | wc -l) &&
-	test $main_entry_count = $(git reflog show main | wc -l) &&
-
-	HEAD_entry_count=$(git reflog | wc -l) &&
+	test_stdout_line_count = 4 git reflog &&
+	test_stdout_line_count = 4 git reflog show main &&

 	git reflog delete main@{07.04.2005.15:15:00.-0700} &&
+	test_stdout_line_count = 3 git reflog show main &&
 	git reflog show main > output &&
-	test_line_count = $(($main_entry_count - 1)) output &&
 	! grep dragon < output

 '
@@ -319,13 +311,12 @@ test_expect_success 'git reflog expire unknown reference' '
 	test_must_fail git reflog expire does-not-exist 2>stderr &&
 	test_grep "error: reflog could not be found: ${SQ}does-not-exist${SQ}" stderr
 '
-
 test_expect_success 'checkout should not delete log for packed ref' '
-	test $(git reflog main | wc -l) = 4 &&
+	test_stdout_line_count = 4 git reflog main &&
 	git branch foo &&
 	git pack-refs --all &&
 	git checkout foo &&
-	test $(git reflog main | wc -l) = 4
+	test_stdout_line_count = 4 git reflog main
 '

 test_expect_success 'stale dirs do not cause d/f conflicts (reflogs on)' '
--
2.54.0

