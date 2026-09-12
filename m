Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689F437A856
	for <git@vger.kernel.org>; Sat, 12 Sep 2026 19:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789240538; cv=none; b=g6DDb2xEEj5CiBTF5YJBNID5iYrgk3SKYsQHezKPkvVq7eth9BnOOK/2ARbKOp7m8um/UGz+bGZOCQ1xU6SeAzE/Z90havO9yXL0n+8FIFkJtXVxTbNiJmHuzNEpJdgWrI9Z3tUyiKk8igKMk2zUyjXYP3o4Msn4URa0x+BlNro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789240538; c=relaxed/simple;
	bh=Vn2kdfcS4g27Z6t6OF3zehDnkD6JpiJKP0cFiHcjZpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DYcQ2msLRbfIX+ufiEZCyXBOgFCQWuMlj3yuINVyapxcRvT5M2j9QuM/qbCoFraWCERDTk72MTV7btGCMkSc7CdmLulzAlGZKx9i3suYslV+OgoEtpQ746/LYdCF+pwWJGlsGSYRtna544EIhcDtmYkv7SU3Q/s1OsWlqAiBYy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bvKzlUzL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xyXtv+F7; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bvKzlUzL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xyXtv+F7"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id B74461D000B2;
	Sat, 12 Sep 2026 15:15:35 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Sat, 12 Sep 2026 15:15:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1789240535; x=
	1789326935; bh=CC9Bq6eg4MgsyxCGl8n9t5tddR8yjnRgU54Jxg9NAk0=; b=b
	vKzlUzLRjVB9qaDIhHv+Yp0APrssq/erC0B8dsBY60KnjA9lcZHJJBvDAIGf29zk
	+GsegwoVFReZGFipYUga5TB3/AtK94Ja78zaZASoZW8DPXOR+6C95rQRN24ltfDd
	igwHV9IKNV61XCKEDJSoEoM7YGHYVWyGMV1zBAd3U7EOmmVcy9EyIheavq7YPJlm
	U14xfxm0X0EZ1ezxoeleBr/nps6irVBUEuVIfiNocbZKae9MCvalOYWHPezXzpP9
	8VJFbQ+Lz74uW0QBjtsW4zxg2RdvW9Kfq6DVWs/x3YOK5fBH3MVQwFJEgR8cg/Zi
	PcgvKhOBkGmHn+hNK2+Gg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1789240535; x=1789326935; bh=C
	C9Bq6eg4MgsyxCGl8n9t5tddR8yjnRgU54Jxg9NAk0=; b=xyXtv+F7RBQ6lji9t
	Ka7l1D8+eVGasy0ux6iV7EQr9uX5ZWuQYLDrh+C8NRGgGZg0zw0OkRwVEPTKY0ql
	DTj3y01JEMMHuH52+8VWRF4umr283Duy6NtIe30ZV4BzTKJNR+PtH9Dduo+7oq/a
	ApLYig7FpHqZSopKJhip+dboGHwCr1fBe1j2VhyDYel9CRRQ1S3KqJcfEQTtBaJw
	EqzV34pErscNc+OtwhuGJ48wSiHgAStmG1rhyMwG4FglXN9D30aEPastyASEWPYo
	EWgbSFt/FNy7klufnsdeDb9FJHWMRq2LLxZB1PZ7ZjnaDm7v8skqs/QDe/HEJLPO
	V5wSQ==
X-ME-Sender: <xms:16SlatSdLbMvKLou1DerAt9lEelz2ION3HKzei7bkwJSNXhuRStO6A>
    <xme:16SlasxKPHb5-RDMTv1I805FBsN0xH_Sj5eltMZnJaOKyOUBuvI2x6L3dHwi5dwJa
    kK57p3XkWuaFrEM1i9L6jz68NSlssIRlG7H3QpzaFmY4FMGjjPUcQI>
X-ME-Received: <xmr:16SlagcXOJN7ALJ4BUBt4qZLTu5Frix8YnpjYaF-Os2JzjHYudksK2sFW743Z9sj6pf-pRSaEjBQBfqFCTWxDUjjVBL70nM35YS3HneAmrDz01C-lW-SIHzi5QsAj_1xz9hRvFxOkpzDVR9A>
X-ME-Proxy-Cause: dmFkZTGgyrv9fjfBch5r9WuS8+zty/bjEUQ6PaD63JJ4DuNno0NbLlCnET6SGYjDe3R38f
    6/RwmRC12sygsP78n6IjBBPYMkex2sawFiCauIIYRGPN/5Zzi/IJtwGP0zBTOYnLIPO9V2
    tJ/Ef8xZMhJZ5N9VgGKVtI4IOw5zHhPqMAlTJoq2ZwO/GSdBcd3o7AtWm4P+U6O7rbDp9p
    jNBn6lzp2udmip570jZPEyu2h9XBwUlqXOq/g7WSuBICk03YEh+OE5Iqp/HHtmhuiYWLMt
    03xAZlbtGUQG0t50uGh3bDzJxf2urZfK8452c84rTg6QtaNuAUMFi7uyIxgK01qeAIr+Yw
    6tHLxbRhe5kve772dWtj0oEK47axRcADK7XhgpyvnFR0WJNlf1xByhNygaHqJiz8uDBmhA
    J/oW5l9O9WL6beL3+cLpdB7FBpLPQHH5NPIQ22B8LGUx2nr4+TLalj71a2JJz2yo92vbQi
    vklViKeRAuJOt77H7XH+Nz3G/m+NxDETwk1IuBK3S9PhWZJx0YOoWrEy3b6rjkEMgP4At3
    9hr6kpwCACAHQxrq5qGfn+MFDWLKBjJTLV+aJ5jN7gcutn48rnzNfIHuUf65DeWDVzhd4Q
    gUhGJ93JcxLGpUMCDhmwiGyeLJ292gFzvmUUPBRTgAkvlLayguIIf1rgPnSQ
X-ME-Proxy: <xmx:16SlagJh4IeGJwGNUrM0-grxT7cRKLxJSUsMBwZiDlSUo_hcuEUaeg>
    <xmx:16SlapGXT4Wfnb6h2JdID7S8OAZSkbFGRFeD0M2LE_Yeu3QSL5nd8A>
    <xmx:16Slaiq6U1rH-6oVXbj7GQp7TrCm3XJvJnWSuyXViUMxLBeln0j87Q>
    <xmx:16SlaqSyNJWtUs0DMzgPYcfvTYcS2t7BW2H0sbX1xkHXBspazilVkQ>
    <xmx:16Slagom6uVT3pws-a0vycOnDR4HV_BQbUTVXiPPAn2UqKmyxtzC4hEe>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 12 Sep 2026 15:15:35 -0400 (EDT)
From: Todd Zullinger <tmz@pobox.com>
To: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Cc: git@vger.kernel.org
Subject: [PATCH 2/3] doc/pack-refs: convert synopsis and options to new style
Date: Sat, 12 Sep 2026 15:15:01 -0400
Message-ID: <20260912191509.844954-3-tmz@pobox.com>
X-Mailer: git-send-email 2.56.0.rc0
In-Reply-To: <20260912191509.844954-1-tmz@pobox.com>
References: <20260912191509.844954-1-tmz@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace [verse] with [synopsis] in the SYNOPSIS block and remove
single-quote formatting from the command name.

Backtick-quote all option terms in the OPTIONS section and convert
the standalone placeholder _<branch>_ in prose.

Update the included pack-refs-options.adoc to backtick-quote all
configuration key terms.

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
 Documentation/git-pack-refs.adoc     |  8 ++++----
 Documentation/pack-refs-options.adoc | 10 +++++-----
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-pack-refs.adoc b/Documentation/git-pack-refs.adoc
index fde9f2f294..69e018d07e 100644
--- a/Documentation/git-pack-refs.adoc
+++ b/Documentation/git-pack-refs.adoc
@@ -7,8 +7,8 @@ git-pack-refs - Pack heads and tags for efficient repository access
 
 SYNOPSIS
 --------
-[verse]
-'git pack-refs' [--all] [--no-prune] [--auto] [--include <pattern>] [--exclude <pattern>]
+[synopsis]
+git pack-refs [--all] [--no-prune] [--auto] [--include <pattern>] [--exclude <pattern>]
 
 DESCRIPTION
 -----------
@@ -52,8 +52,8 @@ BUGS
 ----
 
 Older documentation written before the packed-refs mechanism was
-introduced may still say things like ".git/refs/heads/<branch> file
-exists" when it means "branch <branch> exists".
+introduced may still say things like ".git/refs/heads/_<branch>_ file
+exists" when it means "branch _<branch>_ exists".
 
 
 GIT
diff --git a/Documentation/pack-refs-options.adoc b/Documentation/pack-refs-options.adoc
index 0b11282941..2263648b39 100644
--- a/Documentation/pack-refs-options.adoc
+++ b/Documentation/pack-refs-options.adoc
@@ -1,4 +1,4 @@
---all::
+`--all`::
 
 The command by default packs all tags and refs that are already
 packed, and leaves other refs
@@ -8,12 +8,12 @@ This option causes all refs to be packed as well, with the exception
 of hidden refs, broken refs, and symbolic refs. Useful for a repository
 with many branches of historical interests.
 
---no-prune::
+`--no-prune`::
 
 The command usually removes loose refs under `$GIT_DIR/refs`
 hierarchy after packing them.  This option tells it not to.
 
---auto::
+`--auto`::
 
 Pack refs as needed depending on the current state of the ref database. The
 behavior depends on the ref format used by the repository and may change in the
@@ -29,7 +29,7 @@ future.
 	  maintains the property that N is at least twice as big as N+1. Only
 	  tables that violate this property are compacted.
 
---include <pattern>::
+`--include <pattern>`::
 
 Pack refs based on a `glob(7)` pattern. Repetitions of this option
 accumulate inclusion patterns. If a ref is both included in `--include` and
@@ -38,7 +38,7 @@ tags from being included by default. Symbolic refs and broken refs will never
 be packed. When used with `--all`, it will be a noop. Use `--no-include` to clear
 and reset the list of patterns.
 
---exclude <pattern>::
+`--exclude <pattern>`::
 
 Do not pack refs matching the given `glob(7)` pattern. Repetitions of this option
 accumulate exclusion patterns. Use `--no-exclude` to clear and reset the list of
-- 
2.56.0.rc0

