Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4736E231C9F
	for <git@vger.kernel.org>; Fri, 16 Jan 2026 13:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768569802; cv=none; b=nTPnlt3DFQ+pFvBQC2uU6C+MvsqbWmLbqc1wYsLUHbN8N/V0yunTHxuXdBoOhX3VOABGSk5NFStQNadCm8swx+/r4oHi5p4krzDQ09Fs1l4jK0CPRoq8lL0CXivPJrjw9Uh4HS2Fx+3i3oCNx2qOE4K2HcRkxJo/3SfwjXGqVJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768569802; c=relaxed/simple;
	bh=IV7Q7FCcK4gFzHxgqwDjPBOTdfdITjmeuaPXQjVuSFw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jxqhNtzclWvmWIXlyy++rNUtoLVeVtlL5Nw+aRtWQK1+sqDXTGeFXZ8zUeFpQ5aMWiwuUGP0U8G/xFg/qUrTfA+hwSW3TSlGL6Ha66WlP5igP94AqXr6CMwt5eCKrH9AwjYyxWUesP7G5cjAa61ziKK6LKN5nSgpIJJNx0mmcZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=fXaNLop6; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="fXaNLop6"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1768569796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dPV8WYZVbMdLYKA/Fmg0SaD/+IONGqpHMoaie/gwNXw=;
	b=fXaNLop6luuOpnOmcQcpVPy9NXRneJxYc4xSeTn6OFtLQe/HSkvsWvXQ+e2Ttp4PNVZUYo
	O9HwvlrjqnhNY5rl9TMw6QKsgi6ED9Ikm5vdFptKs2Kp5DBtAo6izkBByUxC1kPQUZwpiV
	GjgiKKyd8ahQrONfsjT3tzdDN5DoB9o=
From: Toon Claes <toon@iotcl.com>
Date: Fri, 16 Jan 2026 14:22:51 +0100
Subject: [PATCH v2 3/5] last-modified: document option --max-depth
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260116-toon-last-modified-zzzz-v2-3-79e44f2806fe@iotcl.com>
References: <20260116-toon-last-modified-zzzz-v2-0-79e44f2806fe@iotcl.com>
In-Reply-To: <20260116-toon-last-modified-zzzz-v2-0-79e44f2806fe@iotcl.com>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Gusted <gusted@codeberg.org>, Toon Claes <toon@iotcl.com>
X-Migadu-Flow: FLOW_OUT

Option --max-depth is supported by git-last-modified(1), because it was
added to the diff machinery in a1dfa5448d (diff: teach tree-diff a
max-depth parameter, 2025-08-07).

This option is useful for everyday use of the git-last-modified(1)
command, so document it's existence in the man page.

Signed-off-by: Toon Claes <toon@iotcl.com>
---
 Documentation/git-last-modified.adoc | 8 +++++++-
 builtin/last-modified.c              | 2 +-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-last-modified.adoc b/Documentation/git-last-modified.adoc
index 2e5f370c15..a3992db3f2 100644
--- a/Documentation/git-last-modified.adoc
+++ b/Documentation/git-last-modified.adoc
@@ -9,7 +9,7 @@ git-last-modified - EXPERIMENTAL: Show when files were last modified
 SYNOPSIS
 --------
 [synopsis]
-git last-modified [--recursive] [--show-trees] [-z]
+git last-modified [--recursive] [--show-trees] [--max-depth=<depth>] [-z]
 		  [<revision-range>] [[--] <path>...]
 
 DESCRIPTION
@@ -33,6 +33,12 @@ OPTIONS
 	Show tree entries even when recursing into them. It has no effect
 	without `--recursive`.
 
+`--max-depth=<depth>`::
+	For each pathspec given on the command line, descend at most `<depth>`
+	levels of directories. A negative value means no limit.
+	Setting a positive value implies `--recursive`.
+	Cannot be combined with wildcards in the pathspec.
+
 `-z`::
 	Terminate each line with a _NUL_ character rather than a newline.
 
diff --git a/builtin/last-modified.c b/builtin/last-modified.c
index 0d73384e45..324363b5ca 100644
--- a/builtin/last-modified.c
+++ b/builtin/last-modified.c
@@ -511,7 +511,7 @@ int cmd_last_modified(int argc, const char **argv, const char *prefix,
 	struct last_modified lm = { 0 };
 
 	const char * const last_modified_usage[] = {
-		N_("git last-modified [--recursive] [--show-trees] [-z]\n"
+		N_("git last-modified [--recursive] [--show-trees] [--max-depth=<depth>] [-z]\n"
 		   "                  [<revision-range>] [[--] <path>...]"),
 		NULL
 	};

-- 
2.52.0

