Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F88D383C61
	for <git@vger.kernel.org>; Wed,  1 Apr 2026 07:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775028859; cv=none; b=exwxAHm3FboPnxuRuTjOAseFG4GNjiz1OtHUR4Dzy8NYMxyRLqku2NmFrqOi43ex78d+ug2qqdmDGOxpBFSvBJQzH58VzAW2XUSJWtw7L5iDD+jNn5Tqare0CAxpjOFiv9/b6y+zfwX2nU8752aZo/shIlcZM5jlVoDydNTCUI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775028859; c=relaxed/simple;
	bh=qAjs+Z/6AanWOZIE6x1o3N1mXo34gBYHFIglqMC7XMY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=McV1W8Nj1ANfDXab5fRFwIJkhatIDcrmtPmEV24kLlbB8sR2NAjNUEFphtC+VEK/qXWFk9evimym8MakWyM+6h1g5MEg77WfE3Ym3Ibh3OQqXrq6Z9dX2d+fL6ySi0fJSniTxG4lJc7Whx5QNZrKXpqlVwrgY1Okm3ptJozV2a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O8ed/Lve; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O8ed/Lve"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E170BC2BCB2;
	Wed,  1 Apr 2026 07:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775028858;
	bh=qAjs+Z/6AanWOZIE6x1o3N1mXo34gBYHFIglqMC7XMY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=O8ed/Lve3gQa9Oxb3//V3DvHIdG/AZhLEylY5UuDOFJc2sy9LLLAUeKMQCLQIeQ+h
	 KTTzs2kJFgVSL3zJX4RotxlbifKa0HIrlGc45kDqj4jbP+a9pvRE3iqXAuu5hqkfXY
	 7j6h/FKGOlIZXkRzoKyGj00YeLC1yAt0/wXLcNWFEBWAfmTh3maXIwFjBh6NndmV+3
	 X2DKYHsVKNzcPw/598lf6+GEs5deI6WAFT/nfWxbSONmrRfuzmZkwi46gPHsLqBVMX
	 X4BsnAR88ozHXZpZ9HcLWkej5fARadidhJDNMQt//ZdaLCrYX0wBW88Sp7bJ6zS7/B
	 H5mBkUr/eKwZw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D80FFD3514E;
	Wed,  1 Apr 2026 07:34:18 +0000 (UTC)
From: Chen Linxuan via B4 Relay <devnull+me.black-desk.cn@kernel.org>
Date: Wed, 01 Apr 2026 15:33:42 +0800
Subject: [PATCH 2/3] Documentation/config: add includeIf "worktree"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260401-includeif-worktree-v1-2-906db69f2c79@black-desk.cn>
References: <20260401-includeif-worktree-v1-0-906db69f2c79@black-desk.cn>
In-Reply-To: <20260401-includeif-worktree-v1-0-906db69f2c79@black-desk.cn>
To: git@vger.kernel.org
Cc: Chen Linxuan <me@black-desk.cn>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3731; i=me@black-desk.cn;
 h=from:subject:message-id;
 bh=K3ImsrVJ2Up2HpuPWgWiJNoMH+njSosuW+4tnuNrhzg=;
 b=owEBbQKS/ZANAwAKAXYe5hQ5ma6LAcsmYgBpzMp38nLlcN/5lZ+kidZrf9fRvmPw1h3d65NF7
 J2HVmthST6JAjMEAAEKAB0WIQTO1VElAk6xdvy0ZVp2HuYUOZmuiwUCaczKdwAKCRB2HuYUOZmu
 i0xpD/0SbQ5hZ1K5gEa7NPRtn9ikFRr8T7U3Z/ewgnpfZHK4anKl3uaz9OqFYLiJ1foTIUU8s7d
 T3YPtgU+Y68pCnhikPVfXWrC0JucBXls8VIJsnnanueDhtqmnOrLp+OdaQpS0mOXO3VKURa0eGw
 LHPvaznCst/anQ9ev+GztmsdX6qfYuceL3MhxwhNbF3mUeNEZFriktniG9i0RPGe5beR2dAg3W/
 hAbzqZxIEN6pqezISwMzgmIFjv5ocNbepOuGNgh26qmFekx2G9GX5JPrHd9t37EjxqJq/3xRjtO
 AcTSKMcY5yjvEMQyVPbJONQUgmyjyiGe++pEnTmqxiYPaXXp/6KFdW8rHaXLXiasdQPIyaXWUd5
 MwsW4a0i98EELsSEtYCdx/0bC+LUbpsp4qi2olIhJLY1nEZGADPNfHah77YwkL1eDuc5LPwhd2p
 GiUuqWZRycwPAo142wJpU+piHiXr7HBYPDWrA7xWWfhd8CBLPqLSP1TAe45Xxcl0RQVjz75NBVB
 tUhmVuFFvLmfE90RnpRA1QV6RSUDWyJZB8PtxrI/EG20T99n3VdcNIcWMAqjFgh+HRTANuWEyIs
 HZ2BQRa/EaG9MhArwniPHaHImVp+cVGRn6QVsCyIu+HYZz/PrPSVebAhTsPsXNoYn7DdkNrHAqc
 7W6XqcYCL4l6W6Q==
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


