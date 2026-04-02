Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515103537FE
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 02:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775098733; cv=none; b=a074T6ut9HjyWCY9XZZqJ7ewPeJcx7/RyC2YgcKV3Xn8mSLbHuPfi0NYxQ8gj22NPxhePBA3aI96B2kB0PWmlMKvx2B2oljE/BzI+wpfETD3aVtKdk7rqKvDSg50GZqTGoSOPGpNhzwJ3+dEl4LOXQJpwXjD5Vf0NJwk1JLMex4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775098733; c=relaxed/simple;
	bh=BSDYjtb1h+m/usDZgF6rikJsumeGWT0iqkwxE+JMZQY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BS2TQv/OHWSKioPGLcNuakZ1kmJdRYLNROTXRVl8siy70XE1d8+9GSODmqZ8l30zDvCunSg4pvyzpZ6r8MFDl/DRH9QB/4P5x3mUpToUo1AQY2XkxLXQ/KVgjX7vEze/UBHcSNQR4Hhesi1YkfaTYoBnlco2Kpvicton4Cy7pY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bo35s/LO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bo35s/LO"
Received: by smtp.kernel.org (Postfix) with ESMTPS id BBD27C19421;
	Thu,  2 Apr 2026 02:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775098732;
	bh=BSDYjtb1h+m/usDZgF6rikJsumeGWT0iqkwxE+JMZQY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=bo35s/LO4GXmO4aWMB/uWYVMx9Jw7QMpJkqZQxXxuAkj7DgiUzeknS56wd7YypZJE
	 pzUg37PWd/BiNhcbf/Cg5za91WRP/rtSYCCOR7o+GBq0KjJ6nZIn0qfqFBCsALNpfV
	 YJg0IVdCPE/+om7lQ57aB6KUaPOD+BgcbD/L0sQEVN6qlgF3sZ8ibmqC+BTKEUa7qf
	 U5RKn/BNsoD5S2qH4Mz++T9xWFynmkTqRVsaSr84h/JT7J245Zm444FqC5nD7EPQN2
	 u66P1ERxSRQHGNRKLyEaneQDce7X+ehYSwYXLy/V10qF5/MQdAXPwoRJpDWEY8IAqg
	 28thJBv4cLFwQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF10111227C;
	Thu,  2 Apr 2026 02:58:52 +0000 (UTC)
From: Chen Linxuan via B4 Relay <devnull+me.black-desk.cn@kernel.org>
Date: Thu, 02 Apr 2026 10:58:46 +0800
Subject: [PATCH v2 2/3] Documentation/config: add includeIf "worktree"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260402-includeif-worktree-v2-2-36e339b898d7@black-desk.cn>
References: <20260402-includeif-worktree-v2-0-36e339b898d7@black-desk.cn>
In-Reply-To: <20260402-includeif-worktree-v2-0-36e339b898d7@black-desk.cn>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Chen Linxuan <me@black-desk.cn>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3781; i=me@black-desk.cn;
 h=from:subject:message-id;
 bh=zfh+NnWYAj57s0ozy1ENumYmupgrV5OfohMuGYGADP8=;
 b=owEBbQKS/ZANAwAKAXYe5hQ5ma6LAcsmYgBpzdtpyUE9Q3izWzaoqr16r0xS8U5NVdeqQDK+2
 W5Xx8UcqziJAjMEAAEKAB0WIQTO1VElAk6xdvy0ZVp2HuYUOZmuiwUCac3baQAKCRB2HuYUOZmu
 i2MGEACsDGZSLoKLrehnCA+CANG9ST3VHL9zIXKZn/nyIWA/JDpUUkppxAijFSjiv5bGUjuuIit
 hSpmBhtsyq0RUqCtJnIdaWKV+VaV/j8Q0QJOm/p76tUVxsR+AsE/XewwJBS0MP+KjBuoAVgr0yM
 jiXT6Sx/njgjt8NCOPshgsgLtL1mRoFb1CWrjl73+KGJ8h/qZcALyQk49AuhjIk7BlkSSYn21Di
 Ir/+RAX+2o7nAJhWZ3rHezLJW5JZVOW1eNK9w6XcOthEjq+H/BHnAlvJTadYQzSN62RpO5wgAKe
 pt0nIKgv4RxHvwy8+eN76D3vi6ssKeqAXqdvKwTtFFy4QmgWZVdssP+vHbNgh6yYvrcECloqSXd
 +rqPZWZ1BMoW5VKxPI3lSE7+k/ovogxxLTjpIiHgu/xHZ11qnQCnXOESANg466IbiucijYG6A/b
 O6BOmv6uPgEl3EXKMZ6xVrtTxNEXXm09ih20+jHT3cxDZDP1M4ihr3FVuy5mRxnhvCzCPgvxO+T
 tUZudIacClYjktum7y6QzsppthKY2P3J8KRFIg6tb6o6D7JDAkmF52eethIAILMEPp4wRw2XDmS
 +zWDFNES7Vzohbf/CfW/8MW8IrBHmri+nUVC0G+fBlhJdS9jyvlydQa0T9nEyQfVSUyEc4tPrVy
 IPvC3kNuwqYZ+tg==
X-Developer-Key: i=me@black-desk.cn; a=openpgp;
 fpr=D818ACDD385CAE92D4BAC01A6269794D24791D21
X-Endpoint-Received: by B4 Relay for me@black-desk.cn/default with
 auth_id=573
X-Original-From: Chen Linxuan <me@black-desk.cn>
Reply-To: me@black-desk.cn

From: Chen Linxuan <me@black-desk.cn>

Add documentation for the newly introduced `worktree` and `worktree/i`
conditional include keywords.  Describe how they differ from `gitdir`
(matching the working tree checkout path instead of the `.git`
directory path), and list the supported pattern features: glob
wildcards, `**/` and `/**`, `~` expansion, `./` relative paths, and
trailing-`/` prefix matching.  Note that the condition never matches
in a bare repository.  Also add usage examples alongside the existing
`gitdir` examples.

Signed-off-by: Chen Linxuan <me@black-desk.cn>
---
 Documentation/config.adoc | 50 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/Documentation/config.adoc b/Documentation/config.adoc
index 62eebe7c5450..a4f3ec905098 100644
--- a/Documentation/config.adoc
+++ b/Documentation/config.adoc
@@ -146,6 +146,48 @@ refer to linkgit:gitignore[5] for details. For convenience:
 	This is the same as `gitdir` except that matching is done
 	case-insensitively (e.g. on case-insensitive file systems)
 
+`worktree`::
+	The data that follows the keyword `worktree` and a colon is used as a
+	glob pattern. If the working directory of the current worktree matches
+	the pattern, the include condition is met.
++
+The worktree location is the path where files are checked out (as returned
+by `git rev-parse --show-toplevel`). This is different from `gitdir`, which
+matches the `.git` directory path. In a linked worktree, the worktree path
+is the directory where that worktree's files are located, not the main
+repository's `.git` directory.
++
+The pattern can contain standard globbing wildcards and two additional
+ones, `**/` and `/**`, that can match multiple path components. Please
+refer to linkgit:gitignore[5] for details. For convenience:
+
+ * If the pattern starts with `~/`, `~` will be substituted with the
+   content of the environment variable `HOME`.
+
+ * If the pattern starts with `./`, it is replaced with the directory
+   containing the current config file.
+
+ * If the pattern does not start with either `~/`, `./` or `/`, `**/`
+   will be automatically prepended. For example, the pattern `foo/bar`
+   becomes `**/foo/bar` and would match `/any/path/to/foo/bar`.
+
+ * If the pattern ends with `/`, `**` will be automatically added. For
+   example, the pattern `foo/` becomes `foo/**`. In other words, it
+   matches "foo" and everything inside, recursively.
++
+This condition will never match in a bare repository (which has no worktree).
++
+This is useful when you need to use different `user.name`, `user.email`, or
+GPG keys in different worktrees of the same repository. While
+`extensions.worktreeConfig` also allows per-worktree configuration, it
+requires changes inside each repository. This condition can be set in the
+user's global configuration file (e.g. `~/.config/git/config`) and applies
+to multiple repositories at once.
+
+`worktree/i`::
+	This is the same as `worktree` except that matching is done
+	case-insensitively (e.g. on case-insensitive file systems)
+
 `onbranch`::
 	The data that follows the keyword `onbranch` and a colon is taken to be a
 	pattern with standard globbing wildcards and two additional
@@ -244,6 +286,14 @@ Example
 [includeIf "gitdir:~/to/group/"]
 	path = /path/to/foo.inc
 
+; include if the worktree is at /path/to/project-build
+[includeIf "worktree:/path/to/project-build"]
+	path = build-config.inc
+
+; include for all worktrees inside /path/to/group
+[includeIf "worktree:/path/to/group/"]
+	path = group-config.inc
+
 ; relative paths are always relative to the including
 ; file (if the condition is true); their location is not
 ; affected by the condition

-- 
2.53.0


