Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2F41E50B
	for <git@vger.kernel.org>; Tue, 20 May 2025 19:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747769730; cv=none; b=PzRCaWhNe2VFLd35+G/Mb6AKuAux/HVo0xWJyx6pvNclzvqXhg2JvwCt9aHO9z3/a58VvmXsMbhBs7lFCAR4ixLpVRRePGr3dtsBOsyzvEEaihwirZ0sTDgWLPFBTul+zL+ShF0JzSGmH6VFGKLGJRNU+TRGa4ZNVGiBEhDDMFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747769730; c=relaxed/simple;
	bh=8ngQG+O0w2o7BQKnwpDQmkTaCU35hUO8VzvOuElW6dk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b0eaxdLjAOfRd1k/dDIeFgOv8JpQwld6qlSSNkGCt5ouxDFZDUHh74I2/B0cwz/UCb7cN8NZT/7Hu+nXBgEO4vUEgSRsS8QFu/1K+hPTZrmN/MyJwC/HSrfYOARLMeEyyBZY4d1BCug1aV7Lkvfon67GtOcy7RvyYYviLZq+Cc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B+7TOQjc; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+7TOQjc"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e694601f624so4470818276.1
        for <git@vger.kernel.org>; Tue, 20 May 2025 12:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747769727; x=1748374527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EhxJWcyARUJOZM9s1El+6RBDOWT2ch2IBDPBrV1RYPE=;
        b=B+7TOQjcu684xk6rBklrXPyAQQWdWtzWWyXZFhokfBoRfoQfIegh1Xm41gc+oUPOH2
         9I47gnB5jGRltPkzCzG7l//uN98FRJQpIqyhaHub7nyGdWhJoftmQNgoSQIqXIWUVfDm
         E8Vsudxyybyjq/qpsF2XcB0hrBh+9TV0UeK70FRI91tx9lW9FmC6HRVahg1tGnnyIt74
         sMKhIuC7jlf7W6TpEKK2JlUcPDYbZ3g671quLZVO8DD0T6cEu+X+N0kInVhxWk1wzFMd
         gnnPU9Gv64s++Z+76UoOHH+loSDqBmRHH4ScVhdqzgRIRVl7iZgj6m8YHPma2G67eAuD
         RLDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747769727; x=1748374527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EhxJWcyARUJOZM9s1El+6RBDOWT2ch2IBDPBrV1RYPE=;
        b=H6TYS6S8ovHz8//U+Wf+VczZiixtvTX0Zdj25ryMegSip6g/MJQt9rJB7vXjuuA7Zs
         w2ODh/XXRAmC3luYWODSiTkR/N5wcJ5jSnQb4JR7oKapU0LTeImmsy0uVuVOwKUZQAj4
         yRX91eoIXlRkDF16YoBJEb2F7qvFZpqWIqAVeMqhdE+QQBpNmkuf/PNpgcsl+7fCjRsl
         blWxNXSM5xoI5+Dmjb94JY+DdRhmPchIJeKvkDkrwxMOFjkJg6VvYmmtM72TWJcN6+H+
         vc0E+Pmrbib+3Bz0WZI60DxQLW5U9J1Fswr5QB8pqtuJ5QBeShroIAKmIJX4qS/N4u3G
         aHSA==
X-Gm-Message-State: AOJu0Ywo3iYZBANlrTms8ottti58mahVo0gMReicOriIsgsBp+/vKkGF
	q8CaJeksSehQyVpJAL3LEz1nsvtHC01M5ns9Lk7+wz071+IMIX3CMckdMmdA4mRz
X-Gm-Gg: ASbGncs3JnqDdpXhDGk8K6RVdRfVuWLANrLjjE6wYkFHo+f/3TQVZ0T0pGB9WYO9yeR
	yGI2SZ40paJM8OqukUTpp3v9cxf5deku6+1Yo2rOuIEuYfE6mcPsrMfGn2G9PBFKlz8jvej3/Rz
	GSE9zEzqjgQoLJm9fNLrAHCJJdmAINKzn2cEYy/laPL2v6jI+8a4hENQpW9AVHeXdSVc6qQcm2P
	x2xRhACeTgZJvvWM94JukLR48qQ9ctEG1E6he1O2jvoURAqZEdpKJzz7DG8MHy1Rd7s8IsP/vV0
	5BDp0irGGy7Vjjv/HwkxcWUrD2ZRvIbbpy6El6w6HQ6UtNJk1n8jz5EwP85SWz1r6I19Njl6jg2
	Y4seFtuwZHwnxyJuVk/PTQxe3qQ==
X-Google-Smtp-Source: AGHT+IF2SL9FAf+be4DpddtshzwAGNOnB1/rbg7CfD4Ess8abxWbdZ6TrypsEJxYoc8XjqXU0wA0eg==
X-Received: by 2002:a05:6902:1401:b0:e78:e637:5c9 with SMTP id 3f1490d57ef6-e7b6a0856a5mr25300359276.22.1747769726734;
        Tue, 20 May 2025 12:35:26 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:90a6:1600:41e8:72c5:601a:7e86])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e7d597dd6e0sm131664276.26.2025.05.20.12.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 12:35:26 -0700 (PDT)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/4] t7005: sanitize test environment for subsequent tests
Date: Tue, 20 May 2025 15:34:55 -0400
Message-ID: <20250520193506.95199-2-ben.knoble+github@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250520193506.95199-1-ben.knoble+github@gmail.com>
References: <20250520193506.95199-1-ben.knoble+github@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some of the editor tests manipulate the environment or config in ways
that affect future tests (because they test a sequence of overrides),
but those modifications are visible to future tests and create a footgun
for them. Use test_config and undo environment modifications once
finished.

Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
---
 t/t7005-editor.sh | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/t/t7005-editor.sh b/t/t7005-editor.sh
index 5fcf281dfb..06fa1ecd91 100755
--- a/t/t7005-editor.sh
+++ b/t/t7005-editor.sh
@@ -111,6 +111,8 @@
 	'
 done
 
+unset EDITOR VISUAL GIT_EDITOR
+git config --unset-all core.editor
 test_expect_success 'editor with a space' '
 	echo "echo space >\"\$1\"" >"e space.sh" &&
 	chmod a+x "e space.sh" &&
@@ -119,13 +121,10 @@
 
 '
 
-unset GIT_EDITOR
 test_expect_success 'core.editor with a space' '
-
-	git config core.editor \"./e\ space.sh\" &&
+	test_config core.editor \"./e\ space.sh\" &&
 	git commit --amend &&
 	test space = "$(git show -s --pretty=format:%s)"
-
 '
 
 test_done
-- 
2.48.1

