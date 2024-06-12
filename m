Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC6C3716D
	for <git@vger.kernel.org>; Wed, 12 Jun 2024 05:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718171477; cv=none; b=pppK5D9tSIuwNX5bTqGBCTggeTEVdbW7tKMgVUCJr23okedxoBlNtyS30Xybv//CZN5amH3Nu+KEHqvFf5rH7ceXQ9Q4CFh5pKKn1iLj4S0QMeu1DuPtDYvhMwfh2HSfVU1jL652mp7/Oxb5Z5ne8QfPdKnuvah0KoQmwS/KRFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718171477; c=relaxed/simple;
	bh=OCBQ9tjRvoQr7HXZ8VMV3IU6S6ATeB1pR3zF0tokTtA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XLo7qIqxkFfjPOJNCOLBlRCXE2+lRoY3tPOOdhLyD2hrzqR/QW9raIGlvPjhWBvvJKVAzed/iwhBinhK8qIcghT09iyTeAAO1Lf88eTa5GhWE4P26PLYSmuh2Ywp/oTNxhX+zzDPq/qLry7QJBuytLWz6c0mHVrqTRqQ5N1/aDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LHm5QnVb; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LHm5QnVb"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6f855b2499cso3440817a34.1
        for <git@vger.kernel.org>; Tue, 11 Jun 2024 22:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718171474; x=1718776274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0KZcKIhlNgpm2MiNyCc2/Weo4ZRujP+9T59sCvV/69w=;
        b=LHm5QnVb2A12qWRgIhTHT8GJcGHoba4lk/thxZ9dM01N8txUZFwzifwLs6QCf0CyOZ
         ufR/h7LVxsmacEKEVh/5Vk2kuz5BaJVAsC9cxLC+t2a8+Cu6g35sOmfIbulHq7PRZqwT
         A8CHWADYU5S6ipSmeJ6InIw8xTrzCnBapUtpFEkTK94CwaJ8zTjwKgKhWkhoQVO0Yu8V
         MREA7My1Ho2yohTKUM4OhT8zUo0+IIEZbskpJg1E9Rew1JTwBoU500dQ/i7ecidYJOAg
         /QjBBPVqIIwKpjCJgYS29+xObh7PLGu7UybUwKzh93aOY8gaaYuAm0fztrut4GpZAIta
         oDWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718171474; x=1718776274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0KZcKIhlNgpm2MiNyCc2/Weo4ZRujP+9T59sCvV/69w=;
        b=WSEuv+IgBj6zypULz7t5Tc2sxVCocP82pCmEoL9SdzlSZtd3CRZBAGfDFvGtOdGDp1
         jNJMbbx0JgmCkC3a2p/g6h4nHA+dqSn/iXq94/LdtFXcm/2dB8QOtOLCSMShKfebE6LJ
         JdVdXU64fuJcwJfUGz7NKFlM1tj1dB26meXcqRspzVrWV6VzHtC8Z/ykNLRsWL8vEefa
         DXmTuPpzNGFf91LzMnlNS0fehnx0bOgfeA029DQ//dDCnNn4i+JRRZ58mQj4TGDrsQX8
         YlpMPKplUjnwQVlSqE8tun1ife5f9fHFy0WBaHWdIQwVMUsebQ+cKAQs6jwIivPUn6nW
         0OPg==
X-Gm-Message-State: AOJu0YxzuV+UX+5jEieAiBQtxht5gsUKf6YnVq1pZmzweeI8wkAx1ffJ
	xgyS56OVE2G/moXgf+CJvSw8s6j/1uk3gBHQ/NOuCjx/Ih+StboI6Dy8ZshD
X-Google-Smtp-Source: AGHT+IFoaevWxuFtexgeNDISneT50UOnRQ3iDoG3I8/Eb3QDT/UBmnDYHGhhwqbeuHG6WJkV6+DApQ==
X-Received: by 2002:a05:6830:16d6:b0:6f9:8000:53e5 with SMTP id 46e09a7af769-6fa1c222cbfmr957233a34.23.1718171473872;
        Tue, 11 Jun 2024 22:51:13 -0700 (PDT)
Received: from Ubuntu.. ([106.206.194.53])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-6f78b8336a7sm1934114a12.73.2024.06.11.22.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 22:51:13 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 4/5] t-reftable-tree: add test for non-existent key
Date: Wed, 12 Jun 2024 11:08:13 +0530
Message-ID: <20240612055031.3607-5-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.2.404.g9eaef5822c
In-Reply-To: <20240612055031.3607-1-chandrapratap3519@gmail.com>
References: <20240610131017.8321-1-chandrapratap3519@gmail.com>
 <20240612055031.3607-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the current testing setup for tree_search(), the case for
non-existent key is not exercised. Improve this by adding a
test-case for the same.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-tree.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/unit-tests/t-reftable-tree.c b/t/unit-tests/t-reftable-tree.c
index cb721b377a..f1adab4458 100644
--- a/t/unit-tests/t-reftable-tree.c
+++ b/t/unit-tests/t-reftable-tree.c
@@ -43,6 +43,7 @@ static void test_tree_search(void)
 		check_pointer_eq(nodes[i], tree_search(values + i, &root, &test_compare, 0));
 	}
 
+	check(!tree_search(values, &root, &test_compare, 0));
 	tree_free(root);
 }
 
-- 
2.45.2.404.g9eaef5822c

