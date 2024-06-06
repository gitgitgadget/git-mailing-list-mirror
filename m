Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2740D198E78
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 15:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717688919; cv=none; b=oDOaJn/+P+W01k/1bS4QmCxs088EEa5A3M7owWoC/G/L0saz/wdOqT6akbXqvKEE1RDc8QhwGW1+ij6i67yl1iMN5eLEqfWYp1mmdQlifjk1XuZ7jLchVxbX/9VKQEa9ymmlyA0kLf0RclPuqHhDOuQZ1fRSrLyW3i1VKSwIEU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717688919; c=relaxed/simple;
	bh=M3NmnPJY+UewlcIXn2gNvLekbAtEtQCb1WnANKxJPUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sefUT69GZ/CsFmODN//VJE9v4YVy+xDqmbnU0h8T0hKsk0eS8+69XfxMzVQtny/9MdhOvTJRAuY9dXXrDSkE18MOjpiBpf7hNHOZajivnH3KEqsubYbzz7GNeBLGKZARFBb0br1epAwc3gfm9Y6U8dGe3NeSc3dDhB8lAwVQ37Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A6hpE2eI; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A6hpE2eI"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1f61f775738so10175265ad.2
        for <git@vger.kernel.org>; Thu, 06 Jun 2024 08:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717688917; x=1718293717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RTbXFHflckCzDT75U/jzwQ6rjk8DD6Zkca0vVmURxp8=;
        b=A6hpE2eIxAbX3vjMnlLbQunqaUNNouUys78NIedeQ8GHn+vE84Qqf19csbcClI6P8o
         0OZSp9Fm/0NHn4KHQBQeyJWzJDeKH7Rz8Qyppn5pAm00rL4CXdfqie0Ta79D5hrDQEJO
         YrCW1ych7fe+IGHqXk8SMuoTbde6OA3Ry+QO8PlTOPT3q3BhQAySYEHkCUn0iHFYGw14
         humo3CPnr13czTaBx9XKLirE9I5cQo6wJ2oIU8fnDNdlGNGf08fCNghbxYCT1ILHmIpM
         U1ATOYpBlojF9+/SfluVlqo2Xiw0bmwVERcIu8Pr2LGE6dhvdR/HdkZJaFLK81O4WE+l
         UcaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717688917; x=1718293717;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RTbXFHflckCzDT75U/jzwQ6rjk8DD6Zkca0vVmURxp8=;
        b=E0R/yl4Ba3gXV2tyPGoCXm8CSdljK0V7YEGc/MqIaFxav9NLD/RlreTzrYZxvM13Ln
         qpdBQGDvYb/2ce/VBsY50n9qxH6Pjh02IBulpVTPKQXi/n1H4OO96KG+zqCL0JIMipdX
         VAgZHV0jXBP2i90zRNx1/Ek/WrpvFwdrNflU0NK4HFwn795MqG4sbfN+4ZkoDrzn2G5I
         SM43jOJpWKaFXaeQUzZZVOVHe5ogT9CYnYQWHEkVGI+zch8PlBqtamgVKEQI+FxqMg6a
         fuRRs3RSq8j4dRmPSG0nyELiM6d753iVEDTZEY+nysSdrW3Uph7QdF2gUAEyslUalXyL
         kOjA==
X-Gm-Message-State: AOJu0YyJPmyA5zG9vi5K3bjhrD5zteWlmbtKmnqPCgG3SR+Etnc4NL6b
	2WtBUTQouwvPsL27gToGh524ze+9vDsoJb7cBCt8OH9UX/IZ37sDHKNDm1R3L+c=
X-Google-Smtp-Source: AGHT+IGvZ4kFPZxjVIquFtVUyJtHQqRPvb3rx76lURFoYRGjuMWKjGwP+/vHnzzgB+r5gCDe5mx12Q==
X-Received: by 2002:a17:903:32c7:b0:1f6:7e02:6ae0 with SMTP id d9443c01a7336-1f6a5a5c816mr70655765ad.44.1717688917198;
        Thu, 06 Jun 2024 08:48:37 -0700 (PDT)
Received: from Ubuntu.. ([223.176.20.76])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1f6bd76fa8fsm16937405ad.100.2024.06.06.08.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 08:48:36 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [GSoC][PATCH v2 6/6] t-reftable-pq: add tests for merged_iter_pqueue_top()
Date: Thu,  6 Jun 2024 20:53:42 +0530
Message-ID: <20240606154712.15935-7-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.2.404.g9eaef5822c
In-Reply-To: <20240606154712.15935-1-chandrapratap3519@gmail.com>
References: <20240606075601.6989-1-chandrapratap3519@gmail.com>
 <20240606154712.15935-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

merged_iter_pqueue_top() as defined by reftable/pq.{c, h} returns
the element at the top of a priority-queue's heap without removing
it. Since there are no tests for this function in the existing
setup, add tests for the same.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-pq.c | 49 ++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/t/unit-tests/t-reftable-pq.c b/t/unit-tests/t-reftable-pq.c
index e114a8cb0f..0e93cc97b1 100644
--- a/t/unit-tests/t-reftable-pq.c
+++ b/t/unit-tests/t-reftable-pq.c
@@ -18,6 +18,11 @@ static void merged_iter_pqueue_check(const struct merged_iter_pqueue *pq)
 	}
 }
 
+static int pq_entry_equal(struct pq_entry *a, struct pq_entry *b)
+{
+	return !reftable_record_cmp(a->rec, b->rec) && (a->index == b->index);
+}
+
 static void test_pq_record(void)
 {
 	struct merged_iter_pqueue pq = { 0 };
@@ -45,9 +50,11 @@ static void test_pq_record(void)
 	} while (i != 1);
 
 	while (!merged_iter_pqueue_is_empty(pq)) {
+		struct pq_entry top = merged_iter_pqueue_top(pq);
 		struct pq_entry e = merged_iter_pqueue_remove(&pq);
 		merged_iter_pqueue_check(&pq);
 
+		check(pq_entry_equal(&top, &e));
 		check(reftable_record_type(e.rec) == BLOCK_TYPE_REF);
 		if (last)
 			check_int(strcmp(last, e.rec->u.ref.refname), <, 0);
@@ -82,9 +89,11 @@ static void test_pq_index(void)
 	}
 
 	for (i = N - 1; !merged_iter_pqueue_is_empty(pq); i--) {
+		struct pq_entry top = merged_iter_pqueue_top(pq);
 		struct pq_entry e = merged_iter_pqueue_remove(&pq);
 		merged_iter_pqueue_check(&pq);
 
+		check(pq_entry_equal(&top, &e));
 		check(reftable_record_type(e.rec) == BLOCK_TYPE_REF);
 		check_int(e.index, ==, i);
 		if (last)
@@ -97,10 +106,50 @@ static void test_pq_index(void)
 	merged_iter_pqueue_release(&pq);
 }
 
+static void test_merged_iter_pqueue_top(void)
+{
+	struct merged_iter_pqueue pq = { 0 };
+	struct reftable_record recs[14];
+	size_t N = ARRAY_SIZE(recs), i;
+
+	for (i = 0; i < N; i++) {
+		reftable_record_init(&recs[i], BLOCK_TYPE_REF);
+		recs[i].u.ref.refname = xstrdup("refs/heads/master");
+	}
+
+	for (i = 0; i < N; i++) {
+		struct pq_entry e = {
+			.rec = &recs[i],
+			.index = i,
+		};
+
+		merged_iter_pqueue_add(&pq, &e);
+		merged_iter_pqueue_check(&pq);
+	}
+
+	for (i = N - 1; !merged_iter_pqueue_is_empty(pq); i--) {
+		struct pq_entry top = merged_iter_pqueue_top(pq);
+		struct pq_entry e = merged_iter_pqueue_remove(&pq);
+
+		merged_iter_pqueue_check(&pq);
+		check(pq_entry_equal(&top, &e));
+		check(reftable_record_equal(top.rec, &recs[i], GIT_SHA1_RAWSZ));
+		for (size_t j = 0; i < pq.len; j++) {
+			check(pq_less(&top, &pq.heap[j]));
+			check_int(top.index, >, j);
+		}
+	}
+
+	for (i = 0; i < N; i++)
+		reftable_record_release(&recs[i]);
+	merged_iter_pqueue_release(&pq);
+}
+
 int cmd_main(int argc, const char *argv[])
 {
 	TEST(test_pq_record(), "pq works with record-based comparison");
 	TEST(test_pq_index(), "pq works with index-based comparison");
+	TEST(test_merged_iter_pqueue_top(), "merged_iter_pqueue_top works");
 
 	return test_done();
 }
-- 
2.45.2.404.g9eaef5822c

