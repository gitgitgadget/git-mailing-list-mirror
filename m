Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FAE227C15C
	for <git@vger.kernel.org>; Wed, 14 May 2025 13:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747230814; cv=none; b=JttbNc1tuOy6FW7SHl4gg0Q/jGU5c72X3fEe5h1zMVN2A0ezgUOM2c1l5By6q4a0IMp6102/2Qco3N2KeD/B2cflH7F5EN2B6AWkjRhBNV1KG8KQ1tgCnQZYB1gFVqdX2irIj6DkhEeHCf0N7hKC1tCFiwGCuo3IRXOHoBrUpq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747230814; c=relaxed/simple;
	bh=L42gZ5GdmuFrtm9M5k3dmuCmwAyTTsRLJqwqgHIXujg=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=ZN4m+W5MkNtDgFzobMbg/69TTnfkTlhg1JYUUKC1MHVQyInczYYT5MNNayZiXo/O9K0db+HrD9jYtnWp3RQsIUAQrMhPaew9NFmTLhPSsfeBQAWdpR6YrINzaxFV503CnLtrCGs/wvLTntgzXiiTpC+NlUjO8Sl7flPd9qlZcB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VLxR7YvN; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VLxR7YvN"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a0b646eff7so5915461f8f.2
        for <git@vger.kernel.org>; Wed, 14 May 2025 06:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747230810; x=1747835610; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FCVUOI1OjwbHbVVebihv21XSLHm04EBJQICxnZ9JmZU=;
        b=VLxR7YvNtTRX7sIsO0KtPsBkIWG6bCU6oU/nXCv/zuAbhRvf69Vmn5GDeIFj6qN8S3
         6zZmqv4bmTJu0aHgOk0YbyMrzPBqi1mY5LoxDtnIsySrfAhdV05eEtzrBv22dfnKpVg7
         HZSWHLg3AyNR1dL9Sh6e/vwgA9vatEOLqTod44BTrp8cHeO5MZ5ZxGZlKwdrWCxMgWen
         zCykuC7jb+CSMtBN2K5G0Hxbp+uJADqpWPoIDmhNdZWIV5g3kj1JoU1d3OdftdHQK5Fp
         Na9Lsr6KV6lMW4+OPnbCpmGKIpj73P69+8K47N0YIYj41N1zuHGaP2Hnd2LgLPQC8a2D
         aDHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747230810; x=1747835610;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FCVUOI1OjwbHbVVebihv21XSLHm04EBJQICxnZ9JmZU=;
        b=TjGK//PZPdbGYX0QSY7FpCU5+5hhwpBy+Xk4DAz+3Prv7W2NQ/WKLOqm6wsLFxMnhc
         NizqA6zkYda47x+8by63qlXLw9oi18CXluhQFx7m9uaAYAJ3TKVbBAUT84f13dkA6C51
         OISvW7fWzEWOFCgapfLbqUAIOZE4dLpb5Mu1hpXaF9SVAT33Mngy4RepX9hvhlG7IhZR
         Bi6UWlxlnAegT+zsFLomPbdDkgBjwhrsvLDyyc7Gsybp38M/YHoPIvQBA+NyuNS4VKw+
         yvqK6wadp3kpMl4NDeQZtYEsB6WwGMU7askz+YzmSZaMV35oa/ED6ETDXp4DVv537HZN
         BZSw==
X-Gm-Message-State: AOJu0YzFJVy8pIujCE01VCkBHkctYI0LF6MgUiYNxMsg82TyXnFVpfBz
	sRd8opG0GSJovwWqfRCxyV0CqTT4eTQ+YUJiXgIKLtjnitomLY1uq6Hbow==
X-Gm-Gg: ASbGncuI+sH14gO147Og+dNPgj9rNEDOximgFX6sR3WNVdrUaqlPI1OQrXqMiDAGvQn
	j05Cyoee1LPrsR8B+Lmo98gAyBk3KDF5PlV9G9Q4O+JNy4/sN0M5D+Ixe0z6SOklJRD9PFhrZ8X
	ukWmXyvLWo2Uq17NST4TAI4yxKJb+0gyGOwz0tziAI44RNXnAqTT2QqfifFt2Ed1+xAFBqr0GZx
	pCBmz/D+hcWnt/XOWpEteS0YGCLIG+1zPGCqpXUwpsH6RhXqHArNUk3G7WnDS3N3Z7les1uUZrl
	aYyb9SqWP6LCywQ1mMW2tU/NQ6aRvrlOMnNzy6vmbnFMlKO2zQqr
X-Google-Smtp-Source: AGHT+IHY6efdFKCiZesbLLKnJyBf36oBr+B+cH2KyABLaOWzW3Y+b4MbJN3gDFvJYDF349jSAof4ww==
X-Received: by 2002:a5d:64eb:0:b0:3a0:b635:ea43 with SMTP id ffacd0b85a97d-3a3496bfc96mr3053639f8f.33.1747230809896;
        Wed, 14 May 2025 06:53:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f3951854sm30735675e9.24.2025.05.14.06.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 06:53:29 -0700 (PDT)
Message-Id: <pull.1965.git.git.1747230808770.gitgitgadget@gmail.com>
From: "Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 14 May 2025 13:53:28 +0000
Subject: [PATCH] sequencer: fix memory leak if `todo_list_rearrange_squash()`
 failed
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Lidong Yan <502024330056@smail.nju.edu.cn>,
    Lidong Yan <502024330056@smail.nju.edu.cn>

From: Lidong Yan <502024330056@smail.nju.edu.cn>

In sequencer.c:todo_list_rearrange_squash, if it fails, memory
allocated in `next`, `tail`, `subjects` and `subject2item` will leak.
Jump to cleanup label before return could fix this leak problem.

Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
---
    sequencer: fix memory leak if todo_list_rearrange_squash() failed
    
    In sequencer.c:todo_list_rearrange_squash, if it fails, memory allocated
    in next, tail, subjects and subject2item will leak. Jump to cleanup
    label before return could fix this leak problem.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1965%2Fbrandb97%2Ffix-sequencer-todo-leak-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1965/brandb97/fix-sequencer-todo-leak-v1
Pull-Request: https://github.com/git/git/pull/1965

 sequencer.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index b5c4043757e..5fb7b68a7ab 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -6596,6 +6596,7 @@ int todo_list_rearrange_squash(struct todo_list *todo_list)
 	char **subjects;
 	struct commit_todo_item commit_todo;
 	struct todo_item *items = NULL;
+	int ret = 0;
 
 	init_commit_todo_item(&commit_todo);
 	/*
@@ -6626,8 +6627,8 @@ int todo_list_rearrange_squash(struct todo_list *todo_list)
 		}
 
 		if (is_fixup(item->command)) {
-			clear_commit_todo_item(&commit_todo);
-			return error(_("the script was already rearranged."));
+			ret = error(_("the script was already rearranged."));
+			goto cleanup;
 		}
 
 		repo_parse_commit(the_repository, item->commit);
@@ -6729,6 +6730,7 @@ int todo_list_rearrange_squash(struct todo_list *todo_list)
 		todo_list->items = items;
 	}
 
+cleanup:
 	free(next);
 	free(tail);
 	for (i = 0; i < todo_list->nr; i++)
@@ -6738,7 +6740,7 @@ int todo_list_rearrange_squash(struct todo_list *todo_list)
 
 	clear_commit_todo_item(&commit_todo);
 
-	return 0;
+	return ret;
 }
 
 int sequencer_determine_whence(struct repository *r, enum commit_whence *whence)

base-commit: 6f84262c44a89851c3ae5a6e4c1a9d06b2068d75
-- 
gitgitgadget
