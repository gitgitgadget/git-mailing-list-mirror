Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B803F1802C7
	for <git@vger.kernel.org>; Tue, 14 May 2024 18:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.110.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715710610; cv=none; b=EUqDadzK6cas1yU0/I4Zz46Mk7j+6oFR0hzqrsEjyisTol0JfmMI/p9r+d2ncwNOaI4ddExsOugdCFNotDh/GjC3CXGjZqv0TsxnAZ57stn0YK9uMeQNRUi8IbYbH90v751aoQD93U2yv7x/TkeId7BDKQn7tz2r8DregI/kPqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715710610; c=relaxed/simple;
	bh=jL8ZQSKLZ7nYlUNMf72Dcm9zJfI2omU/tTO2udlWAI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cuR6Bhm1IaGf6nTIjXbqNl+m2Jf/0P3EJbakow13kZOWAobhPTI4U3AFkGWQdqT7ksCUUXsr/DrU6VqasrFaSMBES8mrxICF434TXxCoAJWxPrN9VBn9iXNCHhnqeA+ixazyDYUwsoksDTe0+j7tdCgtUZFZ9LvdfPtgIl8RIKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=Xh906nhL; arc=none smtp.client-ip=172.105.110.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Xh906nhL"
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:5e4a:89fa:93b9:2058])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id B42285DA89;
	Tue, 14 May 2024 18:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1715710605;
	bh=jL8ZQSKLZ7nYlUNMf72Dcm9zJfI2omU/tTO2udlWAI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=Xh906nhLqaUNvaWFBnmwGDQNp9wMD8I3EPeyirksj2rYPOPDsgEPZ6BTNFUGsWSN6
	 DXGvviJsqbjocQv0MhlwHL8TwI8dYTwubujh5NH1FPiw36zsn4DvzcuXwYFi9dKzlF
	 5lwS6fDSBi25N6AmQ3+y8i/HmAKnFhPFxrIg9z8i3cNyyqzs7o9cpeSxhm3AwbuB/C
	 eCsMmb9Jy5mrv1T0jFzA8GprJJFEODmpmzT05/Ha6XU7stF11cCKP71Vu239cgVm8T
	 EmMRk2dfVhsm3Gcko0ujaDoDraM4opxrYItiodzWtBoVNPeT/I9pfXq4V/w1IqSbWg
	 +5uVbMA78eIqYz7JZ37sfaaYbDkfKZGkHOT3M0EM8IqjwAuXGLycBSHA3EwUz9nKwQ
	 OS9lkXqG3pWb+vkyN7rM86FdknffQUIIa2H7VTIypspqXk2OtHhXxVssEdoFten2UO
	 0MNjVdVqYOaX8w5AhEHOYO0aF06LnQ7byiyb2bAGcMY7D5CtU9w
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 2/2] Revert "core.hooksPath: add some protection while cloning"
Date: Tue, 14 May 2024 18:16:41 +0000
Message-ID: <20240514181641.150112-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.43.0.381.gb435a96ce8
In-Reply-To: <20240514181641.150112-1-sandals@crustytoothpaste.net>
References: <20240514181641.150112-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "brian m. carlson" <bk2204@github.com>

The original commit breaks Git LFS, which installs hooks when it is
invoked during the smudge process as part of checkout.  This is required
to install a post-checkout hook that causes files which are set as
lockable (which are typically large binary assets that cannot be merged)
to be read-only unless they've been locked.  In addition, Git LFS
requires the pre-push hook to be installed so that LFS objects can be
pushed as part of the invocation of git push.

Without the ability to install these hooks, the locking functionality
would not work until the user invoked Git LFS again and did a completely
new checkout with all files changed, since Git LFS optimizes for only
changed files.  In addition, an invocation of git push might not push
anything LFS files all to the remote, potentially causing data loss.

Note that this affects all clone operations with a repository with Git
LFS files in it, even if they are configured not to smudge data by
default, so it breaks all automated clones (which will see "die" called)
without the relevant environment variable specified.

Revert this change to restore functionality.

This reverts commit 20f3588efc6cbcae5bbaabf65ee12df87b51a9ea.

Signed-off-by: brian m. carlson <bk2204@github.com>
---
 config.c        | 13 +------------
 t/t1800-hook.sh | 15 ---------------
 2 files changed, 1 insertion(+), 27 deletions(-)

diff --git a/config.c b/config.c
index 77a0fd2d80..ae3652b08f 100644
--- a/config.c
+++ b/config.c
@@ -1416,19 +1416,8 @@ static int git_default_core_config(const char *var, const char *value,
 	if (!strcmp(var, "core.attributesfile"))
 		return git_config_pathname(&git_attributes_file, var, value);
 
-	if (!strcmp(var, "core.hookspath")) {
-		if (ctx->kvi && ctx->kvi->scope == CONFIG_SCOPE_LOCAL &&
-		    git_env_bool("GIT_CLONE_PROTECTION_ACTIVE", 0))
-			die(_("active `core.hooksPath` found in the local "
-			      "repository config:\n\t%s\nFor security "
-			      "reasons, this is disallowed by default.\nIf "
-			      "this is intentional and the hook should "
-			      "actually be run, please\nrun the command "
-			      "again with "
-			      "`GIT_CLONE_PROTECTION_ACTIVE=false`"),
-			    value);
+	if (!strcmp(var, "core.hookspath"))
 		return git_config_pathname(&git_hooks_path, var, value);
-	}
 
 	if (!strcmp(var, "core.bare")) {
 		is_bare_repository_cfg = git_config_bool(var, value);
diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
index 1894ebeb0e..8b0234cf2d 100755
--- a/t/t1800-hook.sh
+++ b/t/t1800-hook.sh
@@ -185,19 +185,4 @@ test_expect_success 'stdin to hooks' '
 	test_cmp expect actual
 '
 
-test_expect_success 'clone protections' '
-	test_config core.hooksPath "$(pwd)/my-hooks" &&
-	mkdir -p my-hooks &&
-	write_script my-hooks/test-hook <<-\EOF &&
-	echo Hook ran $1
-	EOF
-
-	git hook run test-hook 2>err &&
-	test_grep "Hook ran" err &&
-	test_must_fail env GIT_CLONE_PROTECTION_ACTIVE=true \
-		git hook run test-hook 2>err &&
-	test_grep "active .core.hooksPath" err &&
-	test_grep ! "Hook ran" err
-'
-
 test_done
