Received: from mail-yx2-f42.google.com (mail-yx2-f42.google.com [74.125.224.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459EF1D416C
	for <git@vger.kernel.org>; Sat, 26 Sep 2026 12:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790425057; cv=none; b=JvQ4r1PKyg2a8WDmCLX1Mz9FLP1kx8L+8awAKstQfJCJkFdW2JSlF7otnU3IDSe3GRbv72aYMJC5qMqMI5R6ywSJpQPF308fQXQ+XkDP+A2/sN6BYpnR1O1FfmIpJEbIBx2uGb5FBlMwgqi9TUKOL7EUWXvQkIr5hCpSItESAD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790425057; c=relaxed/simple;
	bh=OZ+s8du0KFoxd2eJvaA0IHd0ufY3oybcVB1+iuC3g2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kVr2gkHKirM3W3oLwP9qaUM31iPKNf5kmCVCSgfUq7Up6KFdeino6CYrH8PBtREs9Tt3xYS/2cwXQfaPlL0EqMDX84oiksG+u0LMGXiiq/FqowU98RmOCQGEP5g2tbtvlXoPDvWQylgvxSddV6JnwLQCa4UJickwteDlH9IFea0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NtRVKf9e; arc=none smtp.client-ip=74.125.224.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NtRVKf9e"
Received: by mail-yx2-f42.google.com with SMTP id 956f58d0204a3-672f90fc533so1658633d50.0
        for <git@vger.kernel.org>; Sat, 26 Sep 2026 05:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790425055; x=1791029855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5j2hBrswZiTmOG7kXb4bKL+B5c79CylYMjcd4jkukAQ=;
        b=NtRVKf9eNQlkzLZYqRnpqdSQWD1jG1kZuG1E5+W+UeyuB/CSRYBrdmW8i0ezNMV6N+
         OpOmqoxZyBYHmO62w6Anrp5PhaDLzjCn8C26xfARqQEaL6y7sJOErB9j5hFsMq2jE8CO
         2l/To/DE4+pVH7sF7ydCxvhEvTwtA+DXaoNbgTVeElfxDdQBJvCECNbHcnputvpBlHHa
         RYw0cT0/VcYbZhQMmOTQY1PQxpUA4lWNc9QNSblYksc321SrYREwG/ZX878sxUUL6yNR
         bHL5rmayzss0NdqnFChKkPMg/32v2+/C6ybmkNCrsLAGcvymOuEVH3WPokL7q6z+d/hm
         0nfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790425055; x=1791029855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5j2hBrswZiTmOG7kXb4bKL+B5c79CylYMjcd4jkukAQ=;
        b=gzQfk0G+kAk8wUM5JTP9A6GrLZinXyhgzntpYQyRVmRUtFL9qbgLQTPSwFuIutC6X5
         ihBINp/GyQ1146SDMhIwnKuSQ/syNgYpzO/4GTSH96k9yYR9OnCuEvgM75c5eHxxuYUW
         gHTcFNBRJMxlySsQuDMyVJuxeI2moENWEIkU4YieRvBShHnsI/15aYOn/HgA94zHcNiD
         W0KnvkqJRJ8EguebwNu/cJ6v4Hz4mE80w38Q1M6VrUycuzmD6NMMGLziBT5RG3xCupgQ
         rSKBoy4f7j8nqbvLaxEg7Xi2WtXYyWoiyJRlpikXdJ8RItPi/F+xSe4VtqhUXq/0F5ux
         qIhw==
X-Gm-Message-State: AFq9FYLRxjf4gAfp5xIgoxs7nThMfyzIhN/F008luDc24Kce3YxXhbZR
	BpobhtGoBxKZIVgBrjdtnNE9BqUNH3SfLrk0GeO2MsSASMoZCWaFmAUAUQUl2jFw
X-Gm-Gg: AYBFou0KKfqhga4sbZQfW1kzK0N+kjKjT5Rwn0xe8vfbVR79ln7FvGPIOHS14tGoycP
	2vMrWIqLiWYyDnCn5F56Z6UbwbF9GkZ6n3HCPq8qz/K0oKdwMLzujlOhaj0qhzULuVfdT0APL+w
	AurtXVfiBepxKBLmuiRDGpdtRWIR3fMOYOnu7ibImHzletTwY7BNlRH5nSN32hjm21EzHY3lieC
	uq/2tUquaj4PRfACsdDqSqunZIpxbHyyPOzCzU50Y7UNwdb38JRlu4oR12yvOhrSTijsxEJJuWX
	nMcJH+uVsJgsa4vS0CJWlKnLq6obO0XJM+uTfkU06iUl6FwmzGcRF2lOMhv7q0l6RcuBfSmOCdG
	ePH6r2IOtUzSYw0r5SYGEGc9zhqnX9xBPpd17sOKXUKCPtQGN0M8oD6jFAP2QASTED3879VxAgM
	UodAjnBlKsqcgxm7ws+ucx55TPi2GC1UQl5c/w8VYrktQFoLHKF4kYAevnYkqmzSwYPbaD6GoSh
	a6NOuTkSmnZv3X0Yg1vJdiMy/kQnjMESmmjKe1M9gp4sohMetcic3sH3pNnLzGQFQvbwsy77rzk
	da9SLPIFdEvHJxCW+9HPHg==
X-Received: by 2002:a05:690e:1186:b0:672:9f72:7c04 with SMTP id 956f58d0204a3-672ed4db57cmr2921725d50.102.1790425055187;
        Sat, 26 Sep 2026 05:17:35 -0700 (PDT)
Received: from merguez.lyrebird-fence.ts.net ([2605:a601:9092:700::6])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6740ee9d17csm2179151d50.5.2026.09.26.05.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 05:17:33 -0700 (PDT)
From: "D. Ben Knoble" <ben.knoble@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
	Eli Barzilay <eli@barzilay.org>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Patrick Steinhardt <ps@pks.im>,
	Harald Nordgren <haraldnordgren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Antonin Delpeuch <antonin@delpeuch.eu>
Subject: [PATCH v3 2/5] stash: prepare merge options earlier
Date: Sat, 26 Sep 2026 08:16:45 -0400
Message-ID: <d9a9e18f3aa334e6e294b825d22df16830a1d616.1790425008.git.ben.knoble@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7.dirty
In-Reply-To: <cover.1790425008.git.ben.knoble@gmail.com>
References: <cover.1790168285.git.ben.knoble@gmail.com> <cover.1790425008.git.ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In a future commit, we will reuse these options for the index merge of
"apply --index", not just for the worktree.

Signed-off-by: D. Ben Knoble <ben.knoble@gmail.com>
---
 builtin/stash.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index dfea2d2c4c..043a38cc6d 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -664,6 +664,8 @@ static enum stash_apply_result do_apply_stash(const char *prefix,
 				repo_get_index_file(the_repository), 0, NULL))
 		return error(_("cannot apply a stash in the middle of a merge"));
 
+	init_ui_merge_options(&o, the_repository);
+
 	if (index) {
 		if (oideq(&info->b_tree, &info->i_tree) ||
 		    oideq(&c_tree, &info->i_tree)) {
@@ -695,8 +697,6 @@ static enum stash_apply_result do_apply_stash(const char *prefix,
 		}
 	}
 
-	init_ui_merge_options(&o, the_repository);
-
 	o.branch1 = label_ours ? label_ours : "Updated upstream";
 	o.branch2 = label_theirs ? label_theirs : "Stashed changes";
 	o.ancestor = label_base ? label_base : "Stash base";
-- 
2.56.0.rc1.315.gc6ed9934b7.dirty

