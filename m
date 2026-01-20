Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064EF3D3318
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 21:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768945656; cv=none; b=Yp6UEloq3iSNTXZoWyn6eeoq34EbLf7hpsD6wpCzR/WvZxQRuaW2PsP+oHITlHW9I7Y1jSXb+yWiH3T4bzP8lK9+fxAwWa2dRDelvt529yhYts2ZCbmg3St6hMEw7zXlDVXBGqIwLZskTLYcCVrvrO+Ra0u6qxBQN8eJiOe/SQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768945656; c=relaxed/simple;
	bh=eW5S/e2fYtKa2N/PUY8JYGc+tQzg8iTjvI0m3E+xZLA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LKB23/avYbcEDZsjMxlqmz1ia+vr9fEs4e1yC2YvckWnBYVDLkxDvMJ3Pw8eWuIdT7nLxud3XITLfw9XKl19MIgx7GSnVud6rgHX2ISPuRAOMOUg9JGHrlNGNiAPjCuKGyKodXc380yqTT0AVdSvelvuzEz90Ge0aLN/jnoDgkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=AbGgIOQf; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="AbGgIOQf"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1768945651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1zUSicRv+VpJRhne++S0zu+KfU2nTzbqSRsbm8y+DVM=;
	b=AbGgIOQfcUXu2ShqsT9GhwfoO6t9Qp9TJceEt/0aN7/fL1N8m20gPvBoGSvibxYVlNhEFp
	OsaYDZKTk4g5wP2/Lpzow0wc0y2Gjbn7MX6JDy3PFsYXZgXdJknCr2+xKVRDutoUCVUueU
	VfASfGDjvj5ZOI0Hjaw+hZqmq25y0pE=
From: Toon Claes <toon@iotcl.com>
Date: Tue, 20 Jan 2026 22:47:08 +0100
Subject: [PATCH v3 1/4] last-modified: clarify in the docs the command
 takes a pathspec
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260120-toon-last-modified-zzzz-v3-1-9bffd4968b0e@iotcl.com>
References: <20260120-toon-last-modified-zzzz-v3-0-9bffd4968b0e@iotcl.com>
In-Reply-To: <20260120-toon-last-modified-zzzz-v3-0-9bffd4968b0e@iotcl.com>
To: git@vger.kernel.org
Cc: Gusted <gusted@codeberg.org>, Toon Claes <toon@iotcl.com>
X-Migadu-Flow: FLOW_OUT

The documentation mentions git-last-modified(1) takes `<path>...`, but
that argument actually accepts a pathspec. Reword the documentation to
reflect that.

Signed-off-by: Toon Claes <toon@iotcl.com>
---
 Documentation/git-last-modified.adoc | 11 ++++++-----
 builtin/last-modified.c              |  4 ++--
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-last-modified.adoc b/Documentation/git-last-modified.adoc
index 602843e095..7c3fd844b8 100644
--- a/Documentation/git-last-modified.adoc
+++ b/Documentation/git-last-modified.adoc
@@ -9,7 +9,8 @@ git-last-modified - EXPERIMENTAL: Show when files were last modified
 SYNOPSIS
 --------
 [synopsis]
-git last-modified [--recursive] [--show-trees] [<revision-range>] [[--] <path>...]
+git last-modified [--recursive] [--show-trees]
+		  [<revision-range>] [[--] <pathspec>...]
 
 DESCRIPTION
 -----------
@@ -39,10 +40,10 @@ OPTIONS
 	spell `<revision-range>`, see the 'Specifying Ranges' section of
 	linkgit:gitrevisions[7].
 
-`[--] <path>...`::
-	For each _<path>_ given, the commit which last modified it is returned.
-	Without an optional path parameter, all files and subdirectories
-	in path traversal the are included in the output.
+`[--] <pathspec>...`::
+	Show the commit that last modified each path matching _<pathspec>_.
+	If no _<pathspec>_ is given, all files and subdirectories are included.
+	See linkgit:gitglossary[7] for details on pathspec syntax.
 
 SEE ALSO
 --------
diff --git a/builtin/last-modified.c b/builtin/last-modified.c
index c80f0535f6..e38e0bc4ca 100644
--- a/builtin/last-modified.c
+++ b/builtin/last-modified.c
@@ -510,8 +510,8 @@ int cmd_last_modified(int argc, const char **argv, const char *prefix,
 	struct last_modified lm = { 0 };
 
 	const char * const last_modified_usage[] = {
-		N_("git last-modified [--recursive] [--show-trees] "
-		   "[<revision-range>] [[--] <path>...]"),
+		N_("git last-modified [--recursive] [--show-trees]\n"
+		   "                  [<revision-range>] [[--] <pathspec>...]"),
 		NULL
 	};
 

-- 
2.52.0

