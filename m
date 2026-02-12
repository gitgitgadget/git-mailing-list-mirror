Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D642882B2
	for <git@vger.kernel.org>; Thu, 12 Feb 2026 07:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770880815; cv=none; b=LA29wp8vesrGdx1QB9e8LiIiilR9yJMNUa8KjQatRZjZ1DwT8u7hjN6DLyrkkiXJ/xsPJv4K1Bl2vy7UW0G7zSJs9MsEt5da/WXG+x1PGG1i1B8aEZ5W5W/AOdQu9jB9WTXHnDy4GcQORwngS/EMWPnXBdschAWOGyBgQHQX39Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770880815; c=relaxed/simple;
	bh=hiZCKWFDVAVfUnH23YOX3a0X+STkPZayZ2sRc1I7/0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a8Uw8pLm98gzsS1rNhH3iK9RfkmBuuUy7tycIatAfClLBNBEHOCBE96HaTUGKBjKom4b1Mck9Y8cyRPgTRGXaYTi6V5naSjj5HHoxQB+alxWcDBdV2bA/2DmixB90XkIHrrKOczN3wSLtj48I0LGKM09g4yNeZC3xMz+qhvKE9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=faL4m/gc; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="faL4m/gc"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-82318b640beso1530546b3a.0
        for <git@vger.kernel.org>; Wed, 11 Feb 2026 23:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1770880813; x=1771485613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c2vP6KWIFTp0Tl+57wzTQrKD5O/8arbdgofgR+N5XTs=;
        b=faL4m/gcIQmWbrd2DJqvPIY61n5v2aKG7Sz4tzO52YwR50Ddr6SIByD7ptZZxy0I6T
         DVyQlYaG00eHSb+t1eeNzJ7wE+BhW4kj2jbTEeoRe/xryQpgGvRcu2exhtv2NjxQXLUw
         t4O2u04dhUOLDYcZ2spVgg0vbu8r2miSu9jrnRy4YxJqF9XGEmlHe8jC6gi/KEFj+gT6
         j/ZbpbHnQ6H9I0Th3KQQZyRS/8tbDHkNuu9Z3jqYvdgg30cVtPjDIjqdDjDjuQem2Wh2
         4TAncY9oqoul1BjIyw44LaFVFBcwfB/bfOQJVVWZ5i8SQaV6Afek0pHdw5YK9o9Y+mg5
         cZVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770880813; x=1771485613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c2vP6KWIFTp0Tl+57wzTQrKD5O/8arbdgofgR+N5XTs=;
        b=o++4zjSbLOowwBFqASjD+c5cevK3v3QkzuiGKWMoICkZgNjuGfIH+I7VcNaThkb94E
         U7j2LJcuyeTV8hOZu8S2iyGhifm1ROEWE4CGPwDJE0SPKggosFssSDczL+ZcgRzcg/St
         vptDiFQXlTxNfszkp6PxUEpoalQstf6VV/uT7Q0vIJhCWE/3BAjtZnNfuR7EtKZqN9Vp
         3m/wpKj7Crtu3hbkNNkc5fvXj5YQLZC1jquy9MN+rwoMIVZ8odWUKoeHJbffys9aGhMv
         Y7RYw2MiSN+4kkPZjG3BvohgYIpGciuId/O/7ugOUCnmGxOvM86lD6a8DBOUhQCy+PEP
         VHoQ==
X-Gm-Message-State: AOJu0YwPmUclaLnaaZRW2SsdW0a9ZTF/rkNXJ60JFIk4J+drekpCtLya
	KtFWyIum8RF08z5zKacPPNR1H73a4MxhQun7HLGjJMuztL3MDWKNKl3TleMf8/oABgSycn1gRtQ
	S/erv/LU=
X-Gm-Gg: AZuq6aLDddmMJkFD7saZswMP82TRvxhg3/4P+vej3nU5GW37rTmjIYDY9i/ElgcnNnd
	nRUXFYojBN5QxVn9Pvl+rUIG2PxXpT604o1oT8/YK6FUBa13HnvJUjJ/yONXLelUnGYWEeNCev4
	0uwWFe02kbQinSAxfXE7JKWOJeZVZW3T1q2/fQjCEa7NqWARtyNj3r55/wKjkV4NM4kUOttB8z5
	MQHA+uvqtLLhhe/JvsXZMnnDRChkHkrO6tBUtf3j1t9mInpZq5M+Hs1DuCPzgH8ieo05IWNBZM7
	aAY3SocrQztGoI3XXieztk4MFa1bigkIqEcCPRTVbywWxa6m82Nb8Etz2NJBB2eeKEsenJN2ldo
	wv255IDG7PePl+QbL3+TYUppeU5ba63NSGst7Uw2ekRrTEJM2ZvvhaVv1oGbypAtFd6o7nUdWC5
	Yd9jUHxRD4e3tUYSKeY1mpeq2UhukMz3ORtw+mJWtyqjQMrcLk9QDZvtNxTdcT6hPW
X-Received: by 2002:a05:6a00:2d12:b0:7b9:4e34:621b with SMTP id d2e1a72fcca58-824b2da6e00mr1262316b3a.12.1770880812956;
        Wed, 11 Feb 2026 23:20:12 -0800 (PST)
Received: from LTY2K703JV.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8249e3bd8cbsm4311761b3a.24.2026.02.11.23.20.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Feb 2026 23:20:12 -0800 (PST)
From: Han Young <hanyang.tony@bytedance.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	Han Young <hanyang.tony@bytedance.com>
Subject: [PATCH v2 1/1] diffcore-break: prevent dangling pointer
Date: Thu, 12 Feb 2026 15:20:02 +0800
Message-ID: <20260212072002.2347-2-hanyang.tony@bytedance.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260212072002.2347-1-hanyang.tony@bytedance.com>
References: <20260211041128.48412-1-hanyang.tony@bytedance.com>
 <20260212072002.2347-1-hanyang.tony@bytedance.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After we have freed the file pair, we should set the queue reference to null.
This prevents us from encountering a dangling pointer later on.

The test uses git reset to trigger prefetching after break-rewrites have freed
the file pair.

Signed-off-by: Han Young <hanyang.tony@bytedance.com>
---
 diffcore-break.c              |  1 +
 t/t4067-diff-partial-clone.sh | 30 ++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/diffcore-break.c b/diffcore-break.c
index c4c2173f30..9b11fe2fa0 100644
--- a/diffcore-break.c
+++ b/diffcore-break.c
@@ -222,6 +222,7 @@ void diffcore_break(struct repository *r, int break_score)
 				free(p); /* not diff_free_filepair(), we are
 					  * reusing one and two here.
 					  */
+				q->queue[i] = NULL;
 				continue;
 			}
 		}
diff --git a/t/t4067-diff-partial-clone.sh b/t/t4067-diff-partial-clone.sh
index 72f25de449..a980cd30a0 100755
--- a/t/t4067-diff-partial-clone.sh
+++ b/t/t4067-diff-partial-clone.sh
@@ -132,6 +132,36 @@ test_expect_success 'diff with rename detection batches blobs' '
 	test_line_count = 1 done_lines
 '
 
+test_expect_success 'diff succeeds even if prefetch triggered by break-rewrites' '
+	test_when_finished "rm -rf server client trace" &&
+
+	test_create_repo server &&
+	echo xyz >server/foo &&
+	mkdir server/bar &&
+	test_seq -f "line %d" 1 100 >server/bar/baz &&
+	git -C server add -A &&
+	git -C server commit -m x &&
+
+
+	echo xyzz >server/foo &&
+	rm server/bar/baz &&
+	test_seq -f "line %d" 90 190 >server/bar/baz &&
+	git -C server add -A &&
+	git -C server commit -m x &&
+
+	test_config -C server uploadpack.allowfilter 1 &&
+	test_config -C server uploadpack.allowanysha1inwant 1 &&
+	git clone --filter=blob:limit=0 "file://$(pwd)/server" client &&
+
+	# Fetch bar/baz without fetching foo.
+	git -C client checkout HEAD~1 bar &&
+	# Ensure baz has diff
+	git -C client reset --hard HEAD &&
+
+	# reset's break-rewrites detection will trigger prefetch
+	git -C client reset HEAD~1
+'
+
 test_expect_success 'diff succeeds even if entries are removed from queue' '
 	test_when_finished "rm -rf server client trace" &&
 
-- 
2.52.0

