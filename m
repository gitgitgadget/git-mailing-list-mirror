Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F361420CA
	for <git@vger.kernel.org>; Fri, 17 May 2024 23:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715987768; cv=none; b=MR0aebhcbkQb8U367nEkKbMj7gkTz2Yu6lEnzXFuwdO9gSxKO8nzMPLzgQ4no1SBriCFuIa6frfrsxbjckqETXboRPd/iPoiolADtis//XvHunbAHlIRmLFgELUBhM9DI1D01tNAC6KGV7pNnpPLfl91czRWRnnkIiIdnMlJMR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715987768; c=relaxed/simple;
	bh=n7MPB3Yvwj0N0Axbnfuy8N0vscrlDLsglxhBURZJPzM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=gBsJXUc1H2rKgzwND6lGsA19KMW6mKmSPIduf7Bsr0KUPmfA+Ct8J77XKbHGxqsq4oipPLIE6eaaEVy/m+IXKPX9w6Y4JnNLP2qTdLi05aeaiYBv1739Shg3kJ64bLWYnI5PMBXIsR0gCEtNBYS/muJkI2pXXxzHvPnWa+CVDg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aTc62NSz; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aTc62NSz"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-34db6a29a1eso577062f8f.1
        for <git@vger.kernel.org>; Fri, 17 May 2024 16:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715987764; x=1716592564; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=koHUvA8eJNO5OQFX3tXjLOzxg5r3bjv9BMWXzC/1gqg=;
        b=aTc62NSz8Y9oSXm+oxuni6P9xtcZFMYk35ZL/gHGG7fGDL5XBAm0bOIJPZMjs0NBrx
         sbjzIXtqokCdDjLZ/oLPAGJaXCRdm/7iQx34zKLHz/VZEQHMLSEFtD7vxrYlRuJEvfJM
         7e4gl51GBYF3QmHlQmWL5/bCvJMptrhaqRKLz+ReYOA6pbBqklLTpxgycJFj8H6KoKcI
         hhm07+h0cRWtmK4HhAuTpK8JQxIZ4IXbcw0jH8TsNTNR+MyYwldB+v7hdUBdoAWjpZlD
         /B7dn2JaVHDy518r577DjLDcXqi7jyfrwGERLc9RHr1PGeF8Z7Jv2HSEgNrmvPyOSfJU
         8hpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715987764; x=1716592564;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=koHUvA8eJNO5OQFX3tXjLOzxg5r3bjv9BMWXzC/1gqg=;
        b=cA4xdFk4MB35nhNU529RyQeA4UKUKoF11Wh7z9SZLobmslSHCrrEnqMo7l5lnbrPbu
         3jbvtvmFelcMiLDJQXi20Y6+RlFr+cKAQXwVMT9WVZlFQKAMKA8NDXr09wRO7a30qqSi
         Tg0lVxAYMKr25zh1hfW1WSWwNhhKkLb1oc5ly/hKfpVtZ3LgSVc4Crw+txQBgTP4ME43
         aLnXqim3r5iUJkrB2mCmemad8Jd/GQYHJCENztAOe0P55hRbar0dkondA4bsWFPFgNJk
         UHwSDyz4Zo1tKh/+wfB1EjHvr83HI1NV6jVZrfFNGz3Edw4+WMJJJy1T0NvIPE62m1FA
         9bww==
X-Gm-Message-State: AOJu0YwdHdIJiSjAqigj/lbi47dYBfDOQnIQnX+EEexexHTDhCK/i8qS
	/s2AjvsGJBUSYzC+cbENXfm12xaigZ4vxvEvJ4Ys4uJKUOmCQZZkPxosaA==
X-Google-Smtp-Source: AGHT+IE49PN48HaFXNHfwndYFr7XHAN6Idznbh/xFfJamMOufRUAySPOmS7Ubt3uSdRWISUmWtGLsw==
X-Received: by 2002:adf:ec4d:0:b0:34e:ad5c:cccd with SMTP id ffacd0b85a97d-3504a73bd75mr13948118f8f.31.1715987764195;
        Fri, 17 May 2024 16:16:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41f87b2648fsm356086765e9.7.2024.05.17.16.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 16:16:03 -0700 (PDT)
Message-Id: <98465797e72cf039ace4138ab1e03e4fc7465ea2.1715987756.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1732.git.1715987756.gitgitgadget@gmail.com>
References: <pull.1732.git.1715987756.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 17 May 2024 23:15:54 +0000
Subject: [PATCH 6/8] hooks(clone protections): special-case current Git LFS
 hooks
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

A notable regression in v2.45.1 and friends (all the way down to
v2.39.4) has been that Git LFS-enabled clones error out with a message
indicating that the `post-checkout` hook has been tampered with while
cloning, and as a safety measure it is not executed.

A generic fix for benign third-party applications wishing to write hooks
during clone operations has been implemented in the parent of this
commit: said applications are expected to add `safe.hook.sha256` values
to a protected config.

However, the current version of Git LFS, v3.5.1, cannot be adapted
retroactively; Therefore, let's just hard-code the SHA-256 values for
this version. That way, Git LFS usage will no longer be broken, and the
next Git LFS version can be taught to add those `safe.hook.sha256`
entries.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 hook.c          | 11 +++++++++++
 t/t1800-hook.sh | 20 ++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/hook.c b/hook.c
index a2479738451..f810ee133be 100644
--- a/hook.c
+++ b/hook.c
@@ -75,6 +75,17 @@ static int is_hook_safe_during_clone(const char *name, const char *path, char *s
 	if (get_sha256_of_file_contents(path, sha256) < 0)
 		return 0;
 
+	/* Hard-code known-safe values for Git LFS v3.4.0..v3.5.1 */
+	if ((!strcmp("pre-push", name) &&
+	     !strcmp(sha256, "df5417b2daa3aa144c19681d1e997df7ebfe144fb7e3e05138bd80ae998008e4")) ||
+	    (!strcmp("post-checkout", name) &&
+	     !strcmp(sha256, "791471b4ff472aab844a4fceaa48bbb0a12193616f971e8e940625498b4938a6")) ||
+	    (!strcmp("post-commit", name) &&
+	     !strcmp(sha256, "21e961572bb3f43a5f2fbafc1cc764d86046cc2e5f0bbecebfe9684a0b73b664")) ||
+	    (!strcmp("post-merge", name) &&
+	     !strcmp(sha256, "75da0da66a803b4b030ad50801ba57062c6196105eb1d2251590d100edb9390b")))
+		return 1;
+
 	if (!safe_hook_sha256s_initialized) {
 		safe_hook_sha256s_initialized = 1;
 		git_protected_config(safe_hook_cb, &safe_hook_sha256s);
diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
index 0f74c9154d0..af66999aff3 100755
--- a/t/t1800-hook.sh
+++ b/t/t1800-hook.sh
@@ -192,4 +192,24 @@ test_expect_success '`safe.hook.sha256` and clone protections' '
 	test "called hook" = "$(cat safe-hook/safe-hook.log)"
 '
 
+write_lfs_pre_push_hook () {
+	write_script "$1" <<-\EOF
+	command -v git-lfs >/dev/null 2>&1 || { echo >&2 "\nThis repository is configured for Git LFS but 'git-lfs' was not found on your path. If you no longer wish to use Git LFS, remove this hook by deleting the 'pre-push' file in the hooks directory (set by 'core.hookspath'; usually '.git/hooks').\n"; exit 2; }
+	git lfs pre-push "$@"
+	EOF
+}
+
+test_expect_success 'Git LFS special-handling in clone protections' '
+	git init lfs-hooks &&
+	write_lfs_pre_push_hook lfs-hooks/.git/hooks/pre-push &&
+	write_script git-lfs <<-\EOF &&
+	echo "called $*" >fake-git-lfs.log
+	EOF
+
+	PATH="$PWD:$PATH" GIT_CLONE_PROTECTION_ACTIVE=true \
+		git -C lfs-hooks hook run pre-push &&
+	test_write_lines "called pre-push" >expect &&
+	test_cmp lfs-hooks/fake-git-lfs.log expect
+'
+
 test_done
-- 
gitgitgadget

