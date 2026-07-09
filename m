Received: from mail-pz2-f0.google.com (mail-pz2-f0.google.com [74.125.228.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5AE3B6BEB
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 19:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.0
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783625192; cv=none; b=YemQdtxuhM3gJ2VNh5TPTaiHlrQL5v86PHfLecmub9zGqSW5a58ymLPPhl/Lc57jpBYww8W/X6JypHnvf0kx9VkbubRcmxIFpSTQlodKBDvZrS6Zy64csWa+EZk2cTGU13p93ryFHYiUcW2C1eW5O2cLlfjgNYdinOoQkO74Tdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783625192; c=relaxed/simple;
	bh=SAin97xb98MdZFM0vOx8WiApHTcR2bsvDg3+khTlmH8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ibM+/Jk/WFVCX/uQ7kxlZVCZWB9ZD7WJ2ls2KT2XstKm9flmDfh94wwbvm3g0xdDKShdV9rPpaaA5WSY3aCXSBgU80qG/U8EW99+bnK9CgnptDuYdjG+mQxKObit7KjVUHkxQnrn7CzhvaYaE+pzKRme+rKl13GEvE3aosDwBBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aA/SIj8o; arc=none smtp.client-ip=74.125.228.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aA/SIj8o"
Received: by mail-pz2-f0.google.com with SMTP id 41be03b00d2f7-c96739a46acso101605a12.1
        for <git@vger.kernel.org>; Thu, 09 Jul 2026 12:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783625190; x=1784229990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XCO+fAUScsjaSJieUbfXMywe96bapiaN33NsYwXuz4g=;
        b=aA/SIj8oy6mEwk458uftuBvTpsVEKMV0gPYNP/D3oAmmIVIdxCMFfN9CUrmVlc7C1P
         3yTDvWXsAtYCTK3hcU1MppGLR8Uc+2as/baaJyx1XbWFbjjzcLqQlfbgJVQKFSbYsEpZ
         WKo+Ad2RlPiIKmeay5bKZpSkZl5DSqrv8Skg8bjwhNkfTs0vPpBqrwk9/fNt4YMhgefu
         v8MBuZNhTwN4J18dRrn9JYw1r2iqWw3kKuzEmg2F8fZDorjnRXUXDB1LTtPFs/yMI3m+
         LERO5XHAeO9xPhOqys5onRUIYVT5VQ3Rjsx1D9jxKjfJ0OKyycJSGpLgcfRl6F9sQwyM
         kwqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783625190; x=1784229990;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XCO+fAUScsjaSJieUbfXMywe96bapiaN33NsYwXuz4g=;
        b=M8e3uS6/YgcVyxLqe+2kZw0dAkdHhiqZeBfG5KEsOqWkmQ8MQbBHKAAdK4dQBSaCc6
         yWSpKEJOXQzRpStkKEVu60kQ+1RMAJfQBHT5jnlyIvWZKndQE/m/dAITR7cEwuhQJB7t
         3yGiPr2JohcEtFwBAcZSXF6TTmJcbn587RidLD5Moa/M0MtjLdEnEwn8lE0TLdJ612eL
         W7de6YkKJtzPfJDZYcIWQ7a7V4sjQs4hQ1S0k8CuSZc7uJZbstzMJ6IayE1mOEAEofNl
         UVP6RfmHcDx2flqX+6WWewz9pQG9GZXDq/ppFMBhzbQ8vCBGuZNC48dPQHJQQQdLQa67
         mTMg==
X-Gm-Message-State: AOJu0YzpA+SBGUAhVmJ3ZSsG5+HSVEmZdyj/lN7c05OaGnuXlYOpcr7K
	tGLt2FQPmA7gTVwy7Z5upfBUEx9I39zeFKSZYNVfKMk71BoWmYwcM87UmxgjkrD3bwI=
X-Gm-Gg: AfdE7cnzh4B+SGcq+p+RinrTkJdbJhWleWzXYTmmZNsov9C4gc3DtGGWJon/mF+7r2V
	a/qxc9YRhbQs7cofjkTHy7mMl8QCcSdP187BjQ1Vjdkr2+M8UAaCVXSgH4qb4fIMM5aOXVxw2mU
	FDSJeWJeb2ty3VLhyOpxdv38Qe7HnN53Ru99BY/F1DnVfPc1yecCms5W8B+KZbFGtFwD9ZZeek8
	SjH1rsbL/atvngrsEtua0IVoWXrXeyMZI7D6+nm/XuuEyqzmC/MUllofDdTTAnHfSi4dxCGN5uQ
	vy8QBmH//c1Jfu6fq+oZxRMcSO6BoQZtKqor46cWUyPbMfVzXppva5aAwb5WZ16RudQmm4TvuDu
	ecFgbg3wJcEesGjvYlEjRce4E5QblRR8iPDmLzEp2mhKVdAnkwJoAyjlDcNiAwLopucc/KhkdaS
	AoC6oGsjmo6RUASDiSX2Tpaaqm0jNxE18POLHxElcQ/BkifDGEgwlETb51rQ==
X-Received: by 2002:a05:6a21:7018:b0:3c0:9c19:6591 with SMTP id adf61e73a8af0-3c0bd027a40mr9726126637.75.1783625190414;
        Thu, 09 Jul 2026 12:26:30 -0700 (PDT)
Received: from localhost.localdomain ([45.117.66.208])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311838c9235sm26933121eec.21.2026.07.09.12.26.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 09 Jul 2026 12:26:29 -0700 (PDT)
From: Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com>
To: git@vger.kernel.org
Cc: Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com>
Subject: [PATCH] builtin/add.c: replace run_command() with direct apply_all_patches() call
Date: Fri, 10 Jul 2026 00:56:19 +0530
Message-ID: <20260709192619.46791-1-gatlavishweshwarreddy26@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the user runs "git add -e", the diff of the working tree changes
is written to a temporary file, opened in an editor, and then applied
back to the index. The application step was done by spawning a child
process running "git apply --recount --cached <file>", which is an
unnecessary subprocess since the apply machinery is available as a
native C API.

Replace the run_command() call with a direct call to apply_all_patches()
using an initialized apply_state with the cached and recount options set
appropriately. This avoids the overhead of forking a subprocess, keeps
the operation within the same process, and makes the intent of the code
clearer to the reader.

Remove the now-unused includes of "run-command.h" and "strvec.h" since
no other code in this file requires them after this change.

Signed-off-by: Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com>
---
 builtin/add.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index c859f66519..8172c0c935 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -13,7 +13,6 @@
 #include "dir.h"
 #include "gettext.h"
 #include "pathspec.h"
-#include "run-command.h"
 #include "object-file.h"
 #include "odb.h"
 #include "odb/transaction.h"
@@ -23,9 +22,9 @@
 #include "diff.h"
 #include "read-cache.h"
 #include "revision.h"
-#include "strvec.h"
 #include "submodule.h"
 #include "add-interactive.h"
+#include "apply.h"
 
 static const char * const builtin_add_usage[] = {
 	N_("git add [<options>] [--] <pathspec>..."),
@@ -187,7 +186,6 @@ static int edit_patch(struct repository *repo,
 		      const char *prefix)
 {
 	char *file = repo_git_path(repo, "ADD_EDIT.patch");
-	struct child_process child = CHILD_PROCESS_INIT;
 	struct rev_info rev;
 	int out;
 	struct stat st;
@@ -217,11 +215,15 @@ static int edit_patch(struct repository *repo,
 	if (!st.st_size)
 		die(_("empty patch. aborted"));
 
-	child.git_cmd = 1;
-	strvec_pushl(&child.args, "apply", "--recount", "--cached", file,
-		     NULL);
-	if (run_command(&child))
+	struct apply_state state;
+	const char *apply_argv[] = { file, NULL };
+
+	if (init_apply_state(&state, repo, prefix))
+		die(_("could not initialize apply state"));
+	state.cached = 1;
+	if (apply_all_patches(&state, 1, apply_argv, APPLY_OPT_RECOUNT))
 		die(_("could not apply '%s'"), file);
+	clear_apply_state(&state);
 
 	unlink(file);
 	free(file);
-- 
2.54.0

