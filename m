Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8B920DD4B
	for <git@vger.kernel.org>; Thu, 13 Feb 2025 09:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739437254; cv=none; b=cJaPnmjqA1XECf2tHRY20KMRqMC5F+yuYfdC7cCTANL+LKpfJC6BswUwKcfxDYNlITpA19BHhRz+U2yScUeUFqNC1ZAZ3fpNdL/sUsEMwlKtAOceij0zuESvPjkvrKiuFk7qiFZ1fukiiKr5oQUlRzCKDC2XT+unHdEhT3MF+Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739437254; c=relaxed/simple;
	bh=EdZxRC/H11fOK9PRW9o3Nc9KeYotOgk/nWKRindpwnM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pN0HeykHSOeadw3zHeqvEO5izf9iacR+5xbWp3KGqdsAVjTRqIpM69VSK02Jxz5IO5YIVIRjBscyydVwxGANhrhqvUp9xq+zz2FrgwUKYRnyA9sZ3+0glz7ZYDL9zuE32NWONgzd38nf7Xu+XsAxyQQpyXwDYZ5tP1eiz4GRrdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mz2X502W; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mz2X502W"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-220d601886fso5414605ad.1
        for <git@vger.kernel.org>; Thu, 13 Feb 2025 01:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739437252; x=1740042052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Q99YMSWdEJKUpI5jRrEpBSi7wKPyhWmpo1wNX9hGdQ=;
        b=Mz2X502W0SSe9+Gq2hmFd1oLb+4xhk9Pg5LXgDXUiWSZCem5TewQpxLNP7RU+UQx36
         f8gEOQtGt8WHU2waMm1O3Dan2r33FQGL7oPJjyxuQneXxqBFf9KzLRQ1K/KqYdsEYoS1
         eWCT2hFRh/DNZQbVZEk9mZV2zeWH8q4YWy9SVp5LSg1+p4C5gZEhOITi166DsL+JeDxy
         7KPi8sLQrN+fI7NpA0H1JwVrg6QAezGBS6pAPNp8Q5TlHDVlF4dp4SYq1Bnto0a9rBPt
         lRDbyRDSpLp+HE8aV57jZogmg5c7bwRYGROapqMY8Tye4dpi1xl7/PWxBChXrSA56W5j
         T7Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739437252; x=1740042052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Q99YMSWdEJKUpI5jRrEpBSi7wKPyhWmpo1wNX9hGdQ=;
        b=n50ffy+waNy1JflMBJiOLN359kFg2TIPvY8NzLxQyV8m+wKkvYh2SjZnlwx+31GSMf
         vXi+Clr0824A7CQBTmP+YXtwP8/TUUGmPlHpuUE9eDRXfzIip30twXF8TNBB8dt+syxo
         jMxXYBib+tAPx+Qcq/HcVjHH89W+ivn9qDKnbkRUiv6hnyWYYk27T4/3wtYr/r2StjyE
         iIg3edVv9AIR7/9QFozl/U/7WZdjg/Yqc28jRb7o2JApnyQBZVq37fiCPM5nRY9Tkd6V
         1avkTutdAivvFVkqStvsXko05rUfuJ4Q6TNbwIJcxa92ZDDhpZr4ln7ndUhE19oxUsww
         /b9Q==
X-Gm-Message-State: AOJu0YxJ89FqhT6KFNDXE1iVJYHS9NjjM6ldvnF0JA5cZrhFatVoYQc2
	Mngfv5lvmhtZFuYgPSvbk7RE10ytq5N8sQp/sCFz5jSUerxb0Gml6syZkQ==
X-Gm-Gg: ASbGncuZQZRd4YaOk5k1kXqRj4vh6AhpVjgpCBAne8oZVuS+9JIkdYs1D9WnaBrrcLJ
	35UcR3AFC9StPhV2JJ6wgZ3+V16AtKy/EllIS01YHZxYL3uIZKYMrmhBG0PsFR2JXGf7saJXsaq
	yLKGdIVvwZn51HQRbAqL7MPiEuUyuVfTRN8V6lWn0Xm6ZJ2Tw0aKLx+eeteJouuP3qfXGI5PQVE
	VnNT1LZ/bthNTyDybGMokNoy2uo64Xt8t5ICCfhPZz8RvMVwlY0qvUuUrcyMpp9zUA2q9UUmRD6
	Pp/tBtgxeB1tKw==
X-Google-Smtp-Source: AGHT+IFmXfUcVTH4c5zpDOIaRmHpP+kBrOf+CZ3rLi6Y4yV0Q9WeG+EniKE/8xLqx9afVW/U795jnA==
X-Received: by 2002:a17:902:cf0d:b0:21f:71a8:f669 with SMTP id d9443c01a7336-220d2110cecmr44349895ad.38.1739437252051;
        Thu, 13 Feb 2025 01:00:52 -0800 (PST)
Received: from meet.. ([103.240.170.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d536733fsm8086265ad.77.2025.02.13.01.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 01:00:51 -0800 (PST)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: Meet Soni <meetsoni3017@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [RFC PATCH 2/2] merge-recursive: optimize time complexity for get_unmerged
Date: Thu, 13 Feb 2025 14:30:40 +0530
Message-Id: <20250213090040.16133-3-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250213090040.16133-1-meetsoni3017@gmail.com>
References: <20250211194334.20710-1-meetsoni3017@gmail.com>
 <20250213090040.16133-1-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously, `get_unmerged()` used `string_list_insert()`, which has an
O(n^2) complexity due to shifting elements on each insertion. It also
called `string_list_lookup()` before insertion, which performs a binary
search in O(log n). This combination made insertion costly, especially
for large index states, as each new entry required both a search and
potentially shifting many elements.

Replace `string_list_insert()` with `string_list_append()` to achieve
O(n) insertion. After all entries are added, sort the list in O(n log n)
and remove duplicates in O(n), reducing the overall complexity to
O(n log n). This improves performance significantly for large datasets
while maintaining correctness.

Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
---
 merge-recursive.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 884ccf99a5..6165993429 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -547,15 +547,15 @@ static struct string_list *get_unmerged(struct index_state *istate)
 		if (!ce_stage(ce))
 			continue;
 
-		item = string_list_lookup(unmerged, ce->name);
-		if (!item) {
-			item = string_list_insert(unmerged, ce->name);
-			item->util = xcalloc(1, sizeof(struct stage_data));
-		}
+		item = string_list_append(unmerged, ce->name);
+		item->util = xcalloc(1, sizeof(struct stage_data));
+
 		e = item->util;
 		e->stages[ce_stage(ce)].mode = ce->ce_mode;
 		oidcpy(&e->stages[ce_stage(ce)].oid, &ce->oid);
 	}
+	string_list_sort(unmerged);
+	string_list_remove_duplicates(unmerged, 1);
 
 	return unmerged;
 }
-- 
2.34.1

