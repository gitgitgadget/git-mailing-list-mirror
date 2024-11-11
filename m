Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6647F1AB52B
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 17:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731347400; cv=none; b=W47vxQ+QJEU4Xa6zRbECTpd/h8dnHuXhLiccXmFYQdLRUz9RnSryqaB1PyvVZ5uaFiVqX1eRJwTzOW1L+IVWx8iVtjhwyHZOzt7ExzMcBJzLNlKeEka/r1D+wBcvMJXPQOZoMK4LnphWkV2KaPj5cUOrBvHXqFhgTAdi36Xx3a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731347400; c=relaxed/simple;
	bh=avMvGef2LQtBfoO/8hk+0IB/GsJAHZUKOySXSk4nbgM=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=Df3wkB53kK6CQ0wHYMoia++wKpYapWLCHxeBtnEB/xQi2aVh3wKP8GyKuJNPjL+1/B0iNc/IGWgJuynb4MJLsVZim1PYR5rEmOGL5hD2dlL/IFqaOYrqIO7SQm34WMdd13i9zJHr3lJ+nl3BESDSaJxAB6+voqNzLxUeaHUJGjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LNAXdJ5i; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LNAXdJ5i"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37ed7eb07a4so3121990f8f.2
        for <git@vger.kernel.org>; Mon, 11 Nov 2024 09:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731347397; x=1731952197; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OwOf4/01K3tOgsjywvkTn6BfpEAclylqW+ejEj2vXSg=;
        b=LNAXdJ5iqhu+6j2WnF6bcOD0nBgqfF/IGkOm53uC6E1wd8QRoIO3BJ6EwZUw1tWrGA
         XjFYxYM+3j92e46GuAxINEe/hXDJ5SkfAugu9DPiF27TQjdNRwDl7SU8wbZgjVb5743A
         4VE6W2xhFm0IoHNg4yfg4uPNWGWPxNxd844j3IrKfWDuQx4Ah9zrA4ysJAvU9iboNZEU
         6TBNilFKRgKB7KXKTPoWtue4ZtzWnBxqofBJ/ka3m+dlOZtt1hbYntX7dyyoZoWl/I8u
         XkQN87K3rYD6R+xkk7TU3TUVDZcPlon4g30K1KZLgC1jvzW2LwfX03bD4Z8z5N8PfJuU
         EiSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731347397; x=1731952197;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OwOf4/01K3tOgsjywvkTn6BfpEAclylqW+ejEj2vXSg=;
        b=srO6RPf4VYqGvSzGja0VqnBUVYDMmUnyoiqnJzbUkdmm1dECXCFH21oi2fdDm3vezs
         rB+BAkyhuAF4vDI3g3jU+Vn8FX1yu6LHiY1nos3o/QOf0q0mP8tXwE6CmWsyQino/gCt
         WB4IM8HHIVjG0+rtYeFRfBj3n4hANLWamxIgdGis3BhxYmjYvDgjoZ6/Vxfu0XiNRmkB
         DZG92VMWZ1ki2pJN8c/gv+LPCeyVJJjEgd6aamvVg+XFAcp7x2OD4pDDJweIGw82S9mg
         9/Giw1R8r8yxWEBnR/HxLm0kEfpbU0d6pu7rNknh0hIlb5bHW7j2iHLVGw/JPXJcg4RE
         mkYA==
X-Gm-Message-State: AOJu0Yx8wcxIimt8aGJ2BTEOPqjkPXnx9zij9KpRZLZuGfzzbbNJTWns
	Uv1LBR9PetT/sdWVcG+u9i1Lbc2IaIlhW4eTcc3ojKsgEMzIOwiypxSazA==
X-Google-Smtp-Source: AGHT+IEu+sJe3gA6ShDIj90FabRczgxAWJUCjStsAJzUOfKzSa42T98Jk53WMudBEJJuZ4xJU2CEKQ==
X-Received: by 2002:a05:6000:2a5:b0:381:d88b:21a7 with SMTP id ffacd0b85a97d-381f18472afmr11728120f8f.49.1731347397330;
        Mon, 11 Nov 2024 09:49:57 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432cc2086f8sm2473075e9.1.2024.11.11.09.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 09:49:56 -0800 (PST)
Message-Id: <pull.1828.git.git.1731347396097.gitgitgadget@gmail.com>
From: "Usman Akinyemi via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 11 Nov 2024 17:49:55 +0000
Subject: [PATCH] diff: update conflict handling for whitespace to issue a
 warning
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
Cc: Usman Akinyemi <usmanakinyemi202@gmail.com>,
    Usman Akinyemi <usmanakinyemi202@gmail.com>

From: Usman Akinyemi <usmanakinyemi202@gmail.com>

Modify the conflict resolution between tab-in-indent and
indent-with-non-tab to issue a warning instead of terminating
the operation with `die()`. Update the `git diff --check` test to
capture and verify the warning message output.

Suggested-by: Phillip Wood <phillip.wood123@gmail.com>
Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
    diff: update conflict handling for whitespace to issue a warning

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1828%2FUnique-Usman%2Fmaster-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1828/Unique-Usman/master-v1
Pull-Request: https://github.com/git/git/pull/1828

 t/t4015-diff-whitespace.sh | 3 ++-
 ws.c                       | 7 +++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 851cfe4f32c..ada3f90b288 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -808,7 +808,8 @@ test_expect_success 'ditto, but tabwidth=1 (must be irrelevant)' '
 test_expect_success 'check tab-in-indent and indent-with-non-tab conflict' '
 	git config core.whitespace "tab-in-indent,indent-with-non-tab" &&
 	echo "foo ();" >x &&
-	test_must_fail git diff --check
+	git diff --check 2>error &&
+	test_grep "warning: cannot enforce both tab-in-indent and indent-with-non-tab, removing tab-in-indent" error
 '
 
 test_expect_success 'check tab-in-indent excluded from wildcard whitespace attribute' '
diff --git a/ws.c b/ws.c
index 9456e2fdbe3..2c11715177e 100644
--- a/ws.c
+++ b/ws.c
@@ -6,6 +6,7 @@
 #include "git-compat-util.h"
 #include "attr.h"
 #include "strbuf.h"
+#include "gettext.h"
 #include "ws.h"
 
 unsigned whitespace_rule_cfg = WS_DEFAULT_RULE;
@@ -70,8 +71,10 @@ unsigned parse_whitespace_rule(const char *string)
 		string = ep;
 	}
 
-	if (rule & WS_TAB_IN_INDENT && rule & WS_INDENT_WITH_NON_TAB)
-		die("cannot enforce both tab-in-indent and indent-with-non-tab");
+	if (rule & WS_TAB_IN_INDENT && rule & WS_INDENT_WITH_NON_TAB) {
+		warning(_("cannot enforce both tab-in-indent and indent-with-non-tab, removing tab-in-indent"));
+		rule &= ~WS_TAB_IN_INDENT;
+	}
 	return rule;
 }
 

base-commit: facbe4f633e4ad31e641f64617bc88074c659959
-- 
gitgitgadget
