Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEBF2C0272
	for <git@vger.kernel.org>; Wed,  5 Nov 2025 06:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762323588; cv=none; b=FNaJ03gGeu47f1qHpLiU0g1677AY0j3Od2yDn+QuH5QQ6lfDqCQhvDHapWY3t8CLqR94VKIzZzGV9YP4+qO6l25BNUE8ZJl3TBXHMmefLjxcZwusNTZ09YEKyDXfcyHx3t8Ew5jO8O4ljdPYcKdnVCTzUVATu3JGzoD6NoiDAe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762323588; c=relaxed/simple;
	bh=CML+OazW4bma2Zs8AE9EpNyGQtxscRRJJiy6LriZf84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PHOC02wv+DK0T2oFjdOVEGwRpODNGW2jD02NBR8jPwngS2Qv19rxnjyBpeGNrTPeKzUPc/oFxZaXuGImmBFOL7iSrFQJqV/1Ak5mhhLD5kpoOcbt8KuypyTle2huj4im3rx4qnksMvIapBD9GhF3Pf+qCsgVRxKL9e/t9s4zg7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VTPkcjKd; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VTPkcjKd"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4775e891b5eso781555e9.2
        for <git@vger.kernel.org>; Tue, 04 Nov 2025 22:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762323584; x=1762928384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VZV/1/TSudoTTlWNyVdE9WolviA7Erfj4uezQ5MeypE=;
        b=VTPkcjKd1ub2W6sceOHztg/eDTgJkSgc5Dk50ZC8HmfPTCeouAVKPF9ur2IR+tzgTv
         oTPddKLthXZG70mS2XlQTuLuyxLAWiV4+gCmzO4+U3+lLgsU/afzF2m2zTQPoyppXEwP
         DLUG1FP/eCkrwBrRe7DKqzOb3wqOZWt5TWGSNW1YxYdvtcLeMvzhjN0q7T79Adw8ofzJ
         MWySxZvwzLAsRnXA+o7FF1k7VsGpdVjJCKayhmM7Pj9WH9rtMlZlizTncZbB7TgXfGs9
         BufUEhxU3jYg2Tdl3YBYpSu84Gc7QAjLP6fWGMEj9eSPDgCGemxxJN0NrMKIL6F0qwM1
         Skxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762323584; x=1762928384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VZV/1/TSudoTTlWNyVdE9WolviA7Erfj4uezQ5MeypE=;
        b=rJbFjpPeodkk9KECIu108etbuZDJgER0elbEiBZNGemL+YV351q4v3Wi5gUjlqx5aL
         xGGijM3DLE5BEu9DTqYga3goGpT+zxTSRFidcZc1Sf3UUbkuBsApm2UIzIqaqOAQMa0Y
         5FFVVFR4rOj6yhMXuTioRMKuQBfpW1f7G5F/6tTlcq/hOy71AbzpMal3Fs8s9ei6zl61
         Ynrc6XkGhAs0x8j4h9BouTtR4ezoX4ZpwgJBPMMbNkxH7L9/85DwpglzxFs+SbFbSfyF
         0v4eDZNw4e81AXHlfPhnp7+hNZoO3aNubpvNobMNxoVzY4zNU82R4Zh5UoRWVDSNpGEG
         wKdw==
X-Gm-Message-State: AOJu0Yx9A96lPbW0YtSbD3/ZbnqYIfxd4gHrjAs21anttqI174OqqNSx
	cXjtTMgU0oh9TO+fIUZOJBVHGgr7zEEU00GCrwrpH0PILcvvUrlAYmpKQq1Ppw==
X-Gm-Gg: ASbGncunR4AC7rv6WvLtzNAnUEyT17yONBGd57XoUxmWl951DjHbefO8+U3iyWhDE7F
	UzHaxjnCqEFcRYnr/77U46pSi9xAf8pcLpW2UEzni20PnVgf+MLMTpyKFmdG/muzwzGK7CT6VDF
	ZJOjTZsfXj78xi4bC+IQUa32qH//ikm364QZz90MhyFVfPjLn8UbaRr7lb/2OJ3JhtCLXg1Josl
	wJnvs45bWGL1Qd30fl+jc9e115b1faqAOKAetHfH02mtOxv8xtOoesdhyr/QMoEMaIFAmgbxHNO
	vOL9H2tzskna8J6mf9VkZCSLb8WN+VfFSBH8DtyGFRT+wLCQjSPedTWUZUXkCfh8G6MpxN4yEfr
	lYXD3Yi84RTpChfsfplNhyqJV9rZNrvf5bLTg/ckmnJbHvGEEm/1VB3S8ukDLLWEus4qe27TddH
	syEyKklDl4KO8MkIbyr+X1llT6LRk=
X-Google-Smtp-Source: AGHT+IHfXR8oAfpa5k8q9VKIAHwJQiSR/NNeFOvK1BTbWEEni+Vzq+IvnwbHgyW13huaGTC6yhxgWQ==
X-Received: by 2002:a05:600c:4687:b0:46e:4925:c74f with SMTP id 5b1f17b1804b1-4775cde59bdmr16467755e9.20.1762323583542;
        Tue, 04 Nov 2025 22:19:43 -0800 (PST)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc1f5f8csm8225944f8f.23.2025.11.04.22.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 22:19:42 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 2/3] commit: refactor verify_commit_buffer()
Date: Wed,  5 Nov 2025 07:19:17 +0100
Message-ID: <20251105061918.3688870-3-christian.couder@gmail.com>
X-Mailer: git-send-email 2.52.0.rc0.3.gf264cd25e5
In-Reply-To: <20251105061918.3688870-1-christian.couder@gmail.com>
References: <20251105061918.3688870-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In a following commit, we are going to check commit signatures, but we
won't have a commit yet, only a commit buffer, and we are going to
discard this commit buffer if the signature is invalid. So it would be
wasteful to create a commit that we might discard, just to be able to
check a commit signature.

It would be simpler instead to be able to check commit signatures
using only a commit buffer instead of a commit.

To be able to do that, let's extract some code from the
check_commit_signature() function into a new verify_commit_buffer()
function, and then let's make check_commit_signature() call
verify_commit_buffer().

Note that this doesn't fundamentally change how
check_commit_signature() works. It used to call parse_signed_commit()
which calls repo_get_commit_buffer(), parse_buffer_signed_by_header()
and repo_unuse_commit_buffer(). Now these 3 functions are called
directly by verify_commit_buffer().

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 commit.c | 17 +++++++++++++++--
 commit.h |  7 +++++++
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/commit.c b/commit.c
index 16d91b2bfc..709c9eed58 100644
--- a/commit.c
+++ b/commit.c
@@ -1315,7 +1315,8 @@ static void handle_signed_tag(const struct commit *parent, struct commit_extra_h
 	free(buf);
 }
 
-int check_commit_signature(const struct commit *commit, struct signature_check *sigc)
+int verify_commit_buffer(const char *buffer, size_t size,
+			 struct signature_check *sigc)
 {
 	struct strbuf payload = STRBUF_INIT;
 	struct strbuf signature = STRBUF_INIT;
@@ -1323,7 +1324,8 @@ int check_commit_signature(const struct commit *commit, struct signature_check *
 
 	sigc->result = 'N';
 
-	if (parse_signed_commit(commit, &payload, &signature, the_hash_algo) <= 0)
+	if (parse_buffer_signed_by_header(buffer, size, &payload,
+					  &signature, the_hash_algo) <= 0)
 		goto out;
 
 	sigc->payload_type = SIGNATURE_PAYLOAD_COMMIT;
@@ -1337,6 +1339,17 @@ int check_commit_signature(const struct commit *commit, struct signature_check *
 	return ret;
 }
 
+int check_commit_signature(const struct commit *commit, struct signature_check *sigc)
+{
+	unsigned long size;
+	const char *buffer = repo_get_commit_buffer(the_repository, commit, &size);
+	int ret = verify_commit_buffer(buffer, size, sigc);
+
+	repo_unuse_commit_buffer(the_repository, commit, buffer);
+
+	return ret;
+}
+
 void verify_merge_signature(struct commit *commit, int verbosity,
 			    int check_trust)
 {
diff --git a/commit.h b/commit.h
index 1d6e0c7518..5406dd2663 100644
--- a/commit.h
+++ b/commit.h
@@ -333,6 +333,13 @@ int remove_signature(struct strbuf *buf);
  */
 int check_commit_signature(const struct commit *commit, struct signature_check *sigc);
 
+/*
+ * Same as check_commit_signature() but accepts a commit buffer and
+ * its size, instead of a `struct commit *`.
+ */
+int verify_commit_buffer(const char *buffer, size_t size,
+			 struct signature_check *sigc);
+
 /* record author-date for each commit object */
 struct author_date_slab;
 void record_author_date(struct author_date_slab *author_date,
-- 
2.52.0.rc0.3.gf264cd25e5

