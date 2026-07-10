Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77CE38F64E
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 19:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783713599; cv=none; b=G34wGdvB39nEyeljX+wMizvTuP8ALWVeDDC42Z4hd0Bs5Du16ZB5mGOhDk/XrlWXSoiLzt7PKRGxR5xnl7R5ALBqLAx+pHzQtD+zzkngOBLryFt+ewiUKXlHFbgM+JUD5SfXnDZ2+k1t33I/foKHN7mxX41jecYn50TDiftlFxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783713599; c=relaxed/simple;
	bh=m+uYuOIEjIJkNSVghvCrxmkjQ1Z12/IaVhtyNHnCNrw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hkCMmBcwPqBR0fRvKjFYG0GYBPAZRIpfmEHgRYTXw8ZBSSrMNcKdr+YW097RanU6yRhnOYrhkdpN0U2MPTsgx1wrRTX2r++oQR1bhi7oiguRjrPUphyILDnNJGyBd7V+fPFKPtvjbECLxz1UUcEHezFYUMMiwFVNY02sUnkIqcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e/TBB1Sf; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e/TBB1Sf"
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-c9c26a5fb98so851177a12.0
        for <git@vger.kernel.org>; Fri, 10 Jul 2026 12:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783713597; x=1784318397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OCwZYVgHAsIllQ4a4V4EgJPR2HeOr06An1xWynDHdMg=;
        b=e/TBB1SfqbePrDSBMpUkbjmokLgfwmDOItuexmF8S2aAuXDdqPIdWZU932LMI5bLWh
         JNyELNLrLnT5HVZ7JBlWwYrMSmhhxUNt/ybYTaYb1+QRCNp0RLDbhelGuY7Xu5k2/X+2
         PCVrcGE3l167ImvsmfKzIgXOM+2HxxuRcQBJ8d97DNj93BDHRaaa+IYluDoLv4mJmcXV
         wbi/bW5zGMlm0751zc/IrX49vsRNZxei2E/1EqPc3Fs8vOVHcysLAOJeKysQjQisznu5
         bHNqUYmcDHWTNu75eqISz0YThDDe8wEAfptMk3mq41kc3mdxHAJ3PgQxXQvTKZZGAxSK
         4F8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783713597; x=1784318397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OCwZYVgHAsIllQ4a4V4EgJPR2HeOr06An1xWynDHdMg=;
        b=XY5fsIFoOpC0Ef92CmPggK+dphj4+NSbSbYWWH7ZILUYtVF9Lc91w6r24GUkAvZFM3
         RQDNqrM9d3jhGhezT8/ngeF3FRAqHjzGDpDpeai1JtRyjYiGIlow/2JUzNLNf2CHu2Hq
         mw+2pnlZiy9m9gnQvd9kRk6kjZqNSp9AXCWvx3c0KVqDIv/VmLj7+USrmM16zQH0vupP
         O45mG41ndXClVRlMizjKjQLovY81F5vucv0T7R5TyybqE+A/YdnLnHzB9Zflq/FyBqyC
         QyxJgq5NSQsbBDZjy0j2alOIPmHz0fGOpMraw7/91VD+chL899tg4ccRAyG5c0wSZ65Y
         a2zA==
X-Gm-Message-State: AOJu0YxuTYKju0zsl6kenNtHuAU4t19/29Mu4DIu6BeS284ZYEMuTxex
	gzffC6+HOdEZdT8rn/SQCN53JoNBrlqERYAKFndx4IeOb/DEEZXCdnZs3ODBoxqONXA=
X-Gm-Gg: AfdE7cmS5tA9UDnO58oVyLJASwf1rcZoWp+OYx6tdmMJNbmXWRxerRIC9PSzXXZUbBD
	uwyIbFX5IQfs/Dx9pGd4Dv68L7ZG35VqRWEp35ds2fuCRCzLKFaqMUpnuqW81/c4LUD8eOItJKY
	lJC7M7JvAfVMmQ+iDZQF3kEnrD15UXtXX7NSdV/eu8IcSDS0DIAWJMaO/JLoRq6xkclISoYqKat
	Y7DoPljRBtPZVB9dboAnA/KzyIv2rcQAZC426ECt6M7uJ8Ctcg+F7Pri/yCvbHFVLfaqeBFjuMf
	NRLCgz75DwW/IQ/eWJM+L/cY4LABv+3YwmgOfPrs60ZEL+6DLBtW0wAerU85i/EBlb7JZjWdCJ8
	8fEmyMw1OmwOi5OYAJ5yodm49tk+pplMYPgmB32kv1Bq83JnuK/TivakaiVW5ze9A3be1SjeChs
	F0HSLruznWxo4EDU5sN5Yaek/Aldgj/qcpPFxxD/viEylCF7VqskpLT0TamA==
X-Received: by 2002:a05:6a21:9cc8:b0:3b4:7459:85a0 with SMTP id adf61e73a8af0-3c0f0ae846fmr5483125637.18.1783713596927;
        Fri, 10 Jul 2026 12:59:56 -0700 (PDT)
Received: from localhost.localdomain ([45.117.66.208])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311747f596asm43766879eec.2.2026.07.10.12.59.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 10 Jul 2026 12:59:56 -0700 (PDT)
From: Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com>
To: git@vger.kernel.org
Cc: Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com>
Subject: [PATCH v3] builtin/add.c: replace run_command() with direct apply_all_patches() call
Date: Sat, 11 Jul 2026 01:28:20 +0530
Message-ID: <20260710195949.54928-1-gatlavishweshwarreddy26@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <xmqqechad6g9.fsf@gitster.g>
References: <xmqqechad6g9.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the user runs "git add -e", the diff of the working tree changes
is written to a temporary file, opened in an editor, and then applied
back to the index. The application step is done by spawning a child
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

Changes in v3:
- Moved struct apply_state and apply_argv declarations to the top of
  the function to fix -Wdeclaration-after-statement violations

In response to review:
- repo_git_path() returns an absolute path built from gitdir.
  prefix_filename() in apply_all_patches() explicitly skips absolute
  paths (see abspath.c lines 271-272 where is_absolute_path(arg)
  causes the prefix to be skipped). Running "git add -e" from a
  subdirectory is therefore safe.
- A dedicated test for "git add -e" from a subdirectory would be
  valuable. I looked but found no existing "add -e" tests in the test
  suite to use as a reference. I would appreciate guidance on the
  preferred approach, or I can attempt to write one if you can point
  me to a similar test pattern.

 builtin/add.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index c859f66519..1858adf289 100644
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
@@ -187,7 +186,8 @@ static int edit_patch(struct repository *repo,
 		      const char *prefix)
 {
 	char *file = repo_git_path(repo, "ADD_EDIT.patch");
-	struct child_process child = CHILD_PROCESS_INIT;
+	struct apply_state state;
+	const char *apply_argv[2];
 	struct rev_info rev;
 	int out;
 	struct stat st;
@@ -217,11 +217,16 @@ static int edit_patch(struct repository *repo,
 	if (!st.st_size)
 		die(_("empty patch. aborted"));

-	child.git_cmd = 1;
-	strvec_pushl(&child.args, "apply", "--recount", "--cached", file,
-		     NULL);
-	if (run_command(&child))
+	apply_argv[0] = file;
+	apply_argv[1] = NULL;
+	if (init_apply_state(&state, repo, prefix))
+		die(_("could not initialize apply state"));
+	state.cached = 1;
+	if (check_apply_state(&state, 0))
+		die(_("could not check apply state"));
+	if (apply_all_patches(&state, 1, apply_argv, APPLY_OPT_RECOUNT))
 		die(_("could not apply '%s'"), file);
+	clear_apply_state(&state);

 	unlink(file);
 	free(file);
--
2.54.0

