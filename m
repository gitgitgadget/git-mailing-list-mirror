Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FADB236454
	for <git@vger.kernel.org>; Sun, 24 Aug 2025 19:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756062424; cv=none; b=GL81T6FP50EzRmqvuYHIiUH5Sx+JGA7Ek0Fn57wzNEDqeOzz8LOzYviP+XqEjh1KV+OrLBEg1jn8jxYfy/HBCVc7Y8uBRKxJfEEnp3UjRUMmcz0sDdHVcrCGI/I3Xhhxu8P+7Y4qzU/6WPsJcJ2ifA5+ciCyca1ujWiHmRqyXZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756062424; c=relaxed/simple;
	bh=4a0XYkk1QHtLx7bmTQ5Pi7iyHH9Sm6NdPd7SJVspuc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C6pBGrqQcT7HrG1yFuDUB0VoVkS1XnxYN6YIoM76H1GKCQpLkzs5a9u33xX/l4W1ZLgxiNffPkqS5giDkQhu4Ahkc9xwfMYVjQgr4ze7hFloV82Td4fWNe0atPX57e2FDdZ206Sg+zD4t+1u2hmFoy3ORxYPr2KIJh65uUecxoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O818bThB; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O818bThB"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45b49f7aaf5so21763365e9.2
        for <git@vger.kernel.org>; Sun, 24 Aug 2025 12:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756062421; x=1756667221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aQ8fW/g2aEm9/ZdTizZrEAEZtciErqWeJyotMROTzPM=;
        b=O818bThBzbjPlXNMOeVp85TX5XYt5ErIOyH/EpuTNXiUrkB/QidVact45ZZiJQU8lt
         Epw0Z36u926mDJHWAQLNqN/zHrlv9VyCl4MCIfPrhm12JrR/uM7n8yyCD+941exJ9K0e
         q5I/Nnk+zGy6uc9tb/06HKieiA71cv63YAUx8mwz7BaP7KxwLYJAX47fi3EHHm/CYTtj
         Hc4nQGdi+Jk0JtkMZ/vL7TEETbDClwOyy2ina8JDxEyPGpDOrXO93abHwVV/0ssGxkrZ
         1dwxBbpGOC8vgENwUjlYotAL7DcL7XwHwD9j7bwIgvI1tq7YWFKr92IHnL9ltENJw7M4
         A4rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756062421; x=1756667221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aQ8fW/g2aEm9/ZdTizZrEAEZtciErqWeJyotMROTzPM=;
        b=L3fXbU6GaVG45knn07h7rw7ayd+z5FKoCTelN2POaReQzP5/CG8ViAQYtPsZcIbfs9
         7RYd4xAU6FPK5b5fwNANRYWgDNWoLJkO9VUazTtkz1KJSmMtsh8VtIzT4g2LVJZVbx1E
         W4N0Lxz3N0+BL6RjJ7UETbRes0xLG5zIObHe81OMIOJSWjUUgZNbllJ8KcGNSz3hOY6C
         kttpkB7jzc6L/qHZrbz+l7DABrC8KIKUYSQDpye1SoIHiakpYsPrBTJXN1POH3pLPcbh
         f3KoHFHD9pi5RVqYc88yMcH58Gjn+2kf4IiZPufbnDAlGz99W0Mi+w7Le/Vu08We9nRy
         9e9A==
X-Gm-Message-State: AOJu0Yy37zwwdaARJd/Z60+hc03MO54hCicoLto8Pa02qxY5YKzpSQX+
	C0cqYB7kbZLUAMrXmDctRR36r+F4CEqwG/Mj9a/K4P+01acMit1V4zxTgjnr4Q==
X-Gm-Gg: ASbGncuvdVPaiey0ORoDKHLyRI9Ad0Cmum0ZW3Ztv73H3rZO4nB1/izL91nMHNTB+Ig
	hmiy4H6eW4UFwvXIfQLvqxdugyPz9fgtUL3NUNDDC0M7USRm1WNiaDhPmKvUkn2245KhqT2Hji5
	ZX931r8qYxKJq+SbYtCUNhv90eRApw5nsrqH87RnVkXvnM7yvLUbawyISnDVgSONrb06yPdd62J
	DOG77PCaLgwA5l1707HM9vU83EDpGpuskyim/MP4fXMACI9RyLnDqW9IuM9g3xU4x5PzcrMMWP2
	4MSQF/sRtpZncqS39g3gPXgisDkE91/9FnEiCbrbVwJ7QLvF2N6GuHQjwkcP8ndw8PDRUPdGprp
	+uIuyr8W13Q2U4ZoIX9S6cMpFN6m/FEfm+0w4v6GSENtuIuL0Axdv
X-Google-Smtp-Source: AGHT+IH2Ck2gjrk1BQz10Gb9O8Nw6iaFlKFGN+48TXVpHO7CAQruZzd2YqGtgqLaO5e/eZw/msS/Kg==
X-Received: by 2002:a05:600c:4695:b0:456:26a1:a0c1 with SMTP id 5b1f17b1804b1-45b517cb8e5mr103958355e9.17.1756062421431;
        Sun, 24 Aug 2025 12:07:01 -0700 (PDT)
Received: from localhost (78-131-14-231.pool.digikabel.hu. [78.131.14.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b57487910sm79104855e9.15.2025.08.24.12.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 12:07:01 -0700 (PDT)
From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 4/4] line-log: simplify condition checking for merge commits
Date: Sun, 24 Aug 2025 21:06:44 +0200
Message-ID: <20250824190644.2573279-5-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.51.0.433.g1a66b3fb12
In-Reply-To: <20250824190644.2573279-1-szeder.dev@gmail.com>
References: <20250824190644.2573279-1-szeder.dev@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In process_ranges_arbitrary_commit() the condition deciding whether
the given commit is not a merge, i.e. that it doesn't have more than
one parent, is head-scratchingly backwards, flip it.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 line-log.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/line-log.c b/line-log.c
index 71fa857ee8..188d387d40 100644
--- a/line-log.c
+++ b/line-log.c
@@ -1273,10 +1273,10 @@ int line_log_process_ranges_arbitrary_commit(struct rev_info *rev, struct commit
 			struct line_log_data *prange = line_log_data_copy(range);
 			add_line_range(rev, commit->parents->item, prange);
 			clear_commit_line_range(rev, commit);
-		} else if (!commit->parents || !commit->parents->next)
-			changed = process_ranges_ordinary_commit(rev, commit, range);
-		else
+		} else if (commit->parents && commit->parents->next)
 			changed = process_ranges_merge_commit(rev, commit, range);
+		else
+			changed = process_ranges_ordinary_commit(rev, commit, range);
 	}
 
 	if (!changed)
-- 
2.51.0.433.g1a66b3fb12

