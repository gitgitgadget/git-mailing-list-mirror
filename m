Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6AB54BF7
	for <git@vger.kernel.org>; Mon, 18 Mar 2024 17:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710781421; cv=none; b=ll6krvTptaMsZTp1woaogA2ctlBYfog86IUNJqiZHBMPfvLc9ENbBufeVEWoQvE5OkHqKfQ58XGAO12tTonhSUC2K2z2XqkD5Kbp1puqhtBNtVp6FbPW1/aCbfkcgSR9HbfxqHDWy1L+9iaQDg0CL0xGgHDNUdc2BcGHBL4sjlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710781421; c=relaxed/simple;
	bh=J80MmsINZwivdHM8PnHdDpgF2emOYX4ct5zqM6ppZUA=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HODFNxunjh1mx4Z2rmGGoYQVhkzo9gj7v+MkTOgF1EhVjo6YGhR/oPbKhJGJj2AyOeoDtPPhfU2MMCwYfEZvAanFuwxydzS8ZG5/kh/sA5n5sIW1zSSuO/gKCuS1Xcv2hbIvIiFUO+AINm9xbf91cMCrs/eC4sW4lRglO+CF53E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=Cr65mK7q; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="Cr65mK7q"
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1710781411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YklGguCgfPO+/t9bR07jXoGH6HplMVGLdZqDw0OpJYg=;
	b=Cr65mK7qXeU+AX/mMuGFXjzlVsXFeMvKnLKVkqga0Cc2bnEpdizOcvyywp/s5W3Wq4Tcks
	ZYFwyRWB3mtxOD3+7t3YU+US9Zpm+JxbmHHLg/+zMFh22ajJU9YOywSxlnjAGwcMF4wG+R
	VgJkdzrY26HcP+LDBeJ23hYptuU4lptoZGgR0sEptBPaIFwNfqdZt5qtY9mGL6CVFA8Fhu
	cX1uqZ0vQFV3h539zUyx4nDCmKMeCx942wylH1bkUfuK/m81J6b1oNwR3WuuzO7i2+1aOL
	5mNk9+8U9ZfuWOJwpWn1Cz5KCogHO0apfzW0uM4bVFE8LmMSyW/0GC4IR0KMEQ==
To: git@vger.kernel.org
Subject: [PATCH 3/5] grep docs: describe --no-index further
Date: Mon, 18 Mar 2024 18:03:23 +0100
Message-Id: <3e6136028ca3327b027d57c46fb8155ef3c0d6c5.1710781235.git.dsimic@manjaro.org>
In-Reply-To: <cover.1710781235.git.dsimic@manjaro.org>
References: <cover.1710781235.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Describe the dependency between --no-index and either of the --cached and
--untracked options, which cannot be used together.

As part of that, shuffle a couple of the options, to make the documentation
flow a bit better;  it makes more sense to describe first the options that
have something in common, and to after that describe an option that has some
dependency on the already described options.

Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---
 Documentation/git-grep.txt | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index ade69f00ebdd..b377523381bb 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -28,7 +28,7 @@ SYNOPSIS
 	   [-f <file>] [-e] <pattern>
 	   [--and|--or|--not|(|)|-e <pattern>...]
 	   [--recurse-submodules] [--parent-basename <basename>]
-	   [ [--[no-]exclude-standard] [--cached | --no-index | --untracked] | <tree>...]
+	   [ [--[no-]exclude-standard] [--cached | --untracked | --no-index] | <tree>...]
 	   [--] [<pathspec>...]
 
 DESCRIPTION
@@ -45,13 +45,15 @@ OPTIONS
 	Instead of searching tracked files in the working tree, search
 	blobs registered in the index file.
 
---no-index::
-	Search files in the current directory that is not managed by Git.
-
 --untracked::
 	In addition to searching in the tracked files in the working
 	tree, search also in untracked files.
 
+--no-index::
+	Search files in the current directory that is not managed by Git.
+	This option cannot be used together with `--cached` or `--untracked`.
+	See also `grep.fallbackToNoIndex` in CONFIGURATION below.
+
 --no-exclude-standard::
 	Also search in ignored files by not honoring the `.gitignore`
 	mechanism. Only useful with `--untracked`.
