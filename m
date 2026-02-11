Received: from mail-yw1-f193.google.com (mail-yw1-f193.google.com [209.85.128.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420F51CAA78
	for <git@vger.kernel.org>; Wed, 11 Feb 2026 23:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770853898; cv=none; b=j+gP5o/cpTZB4wVXB0VhUAtbXEF82b1rRdw8Alg/oBk/I1fcTUqdiW0ZziHo8kMDEPMVTX59bUf44WsWoZPgwSglVc4vaXJ6c1qE6yAwdzHgWZsPvcUpaN+tPMsw4+Mq1szt0P4y/HFGWOjUkYyzyeW/9XrOTEnUS7+1MLsHKgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770853898; c=relaxed/simple;
	bh=6xne07F0dNWlqeWRMgV3m6oYh4XXhn+hesiuR+ie5C4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MijNBq/5Swh/g3mlV04aYbpvAakbweetThkaKh2qFI3D/87cZZSkl4BvmKDtcnHtxVn2IjrOXJgYqX9z1ZcSlj3P5XsStdvFmtJNtcR0jjYxsCku73EXuuo/8Z3HC1MQ6SppjFRiIs6y0+RkbQJYpNJz2xC/w9kaGa8IvzKsSek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V5EG9eBv; arc=none smtp.client-ip=209.85.128.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V5EG9eBv"
Received: by mail-yw1-f193.google.com with SMTP id 00721157ae682-794fe698e36so28089887b3.2
        for <git@vger.kernel.org>; Wed, 11 Feb 2026 15:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770853896; x=1771458696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1AlytinJD7bQB8NwYz7fphScai3/FapMJ57noc9EwT8=;
        b=V5EG9eBvchIRH5pGRx7OyzRZVQpcrY9NOkRqKmZs91xX+gkNmLpTg8qhagI2t7vw1S
         6CGG/H2YdYjq9QBsHkaP5yOJx5eT3s0mRH37ZFEbFhDPiBq0a0voyCDI6+wEF7g3W5zt
         Fbwg3vtLL0E02CZWHv5BDLdMOZTm9qadZXgTBXJ6pSbrx8keYG9Q7Cip2SftxQ+oamy9
         r5/h0+5cGPft+ggWKPpTkuITEDlHwDgJgqOIVr4JrI+ApNymSHug1dkZB81cFF1UHxw6
         kFasgfoSZ08yM7xZaudKX18eBEkVcAYCxSUZC8CyUFaEpJx5iFNk7J1pwqmbqHNtuKfK
         0+FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770853896; x=1771458696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1AlytinJD7bQB8NwYz7fphScai3/FapMJ57noc9EwT8=;
        b=pgE6DKBypAyeEB9jrRA23OvMi37lWWSS2+33EdAQrRia2btBN3d6VNAs7t2QsRY7qG
         nUZe6PsaW+dgMlu5P/QjDnK73TZeX8oE4zQW5cW6oHOczYW6xZA1VWeex38LTDIhbybJ
         OrOlGkWYR3fn92W5hnLKB2fg9L+8waPHD15+UBOLtOaqzmXBxL0nGrJz/wKlCfvh/k9q
         BYcB18yeG99CrhcUc+FIC06oGtcimW9NdAFvojU8MnIfk7JsKqINrclIjw03NHg4DFBh
         6sMl6geuDIiXSWCOqW1TadhGwqdchcofSrgA9JKLOVGaLRdFVwO0+xy+gNsFhIaBsqAU
         CrMw==
X-Gm-Message-State: AOJu0Yzn2PtFYCzNy8wVNsBbkSqaMKJiZtlK08OAiJizgYYL70Q79vIt
	+bfxVDaPk2fCdqGQWTbyVQofyscp4r5X1HmezYeUinY4+NcQGp0alIqZG7nArhEA
X-Gm-Gg: AZuq6aJmIefH6RZoYeh730vcx9HqKcJXenQq/3dnidbgCrdLHoLb62GP8fY2IGxiRTN
	rO5xlskVgxJuKwI73as6xZEjm5ZPsqFQ4Z9aVN8K91AugZ5OswbrDsgHVoyDj/iVktVAYyMIsNX
	2X0zXMcNUa0DFuMnKYfdVKSokuS/C3zraM6lyyFshg/qwpDo31J+KKmLRwuwuFNkORtQJvtqHuO
	wx5gpzu+Wu4QZ+gE68wk/PhP5hc/BxmN+VYjlGFDewEw3SyvI3cK1tRNw0ZAT5EWwsQVlKLAM9M
	tzApAGy1nUiR8jL8e1GvaTf8GsObfjpSi6xeCAKgqJfb6291+cd+agq/GynbFaWmt8yDb3+ALkd
	8CXjBwyqcf1u7JbAEDX2kt6D/yAB8yMc4S/VBN9j5C2VA8wT4fCY7vbowS/DJBhEDbzrCKqU4im
	aPVjVVWsfqqxo0ZAjj4HaaJgIA/mXSM+WBp7NClkcxAiCXQKmXIbsUeQ5F3VDqMy6Yx9Tfb0cyk
	qzuNuW1MGvlmvsp
X-Received: by 2002:a05:690e:1502:b0:64a:dfe6:c387 with SMTP id 956f58d0204a3-64c08248540mr255269d50.66.1770853895903;
        Wed, 11 Feb 2026 15:51:35 -0800 (PST)
Received: from localhost.localdomain ([2605:a601:90eb:5600::9])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7966c18bd49sm30988187b3.16.2026.02.11.15.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 15:51:35 -0800 (PST)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>,
	Evan Martin <evan.martin@gmail.com>
Subject: [PATCH v3] meson: regenerate config-list.h when Documentation changes
Date: Wed, 11 Feb 2026 18:51:02 -0500
Message-ID: <0a344f1f3ee4a5d95c6f46df030b9936db4354a1.1770853297.git.ben.knoble+github@gmail.com>
X-Mailer: git-send-email 2.52.0.rc0.1058.g68d811a4ee.dirty
In-Reply-To: <c9ae171eed6bd5b0fa6671b10a5ad0da024f36d0.1770649805.git.ben.knoble+github@gmail.com>
References: <c9ae171eed6bd5b0fa6671b10a5ad0da024f36d0.1770649805.git.ben.knoble+github@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The Meson-based build doesn't know when to rebuild config-list.h, so the
header is sometimes stale.

For example, an old build directory might have config-list.h from before
4173df5187 (submodule: introduce extensions.submodulePathConfig,
2026-01-12), which added submodule.<name>.gitdir to the list. Without
it, t9902-completion.sh fails. Regenerating the config-list.h artifact
from sources fixes the artifact and the test.

Teach the meson build to depend on the Documentation files that
generate-configlist.sh reads by having it an additional output as a list
of dependency files, since Meson does not have (or want) builtin support
for globbing like Make.

Helped-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
---

Notes (benknoble/commits):
    Changes from v2 (<c9ae171eed6bd5b0fa6671b10a5ad0da024f36d0.1770649805.git.ben.knoble+github@gmail.com>):
    
    • Pick up (and tweak) Patrick's depfile proposal
    • Include the script itself as a dependency
    • Escape output paths (spaces, octothorpes, and backslashes) for Ninja
    
    I'm not 100% sure I've actually done the escaping correctly, though,
    since Ninja's source says that a space preceded by 2N backslashes
    represents 2N backslashes at the end of a filename, and
    
        λ printf '%s\n' 'foo\' | sed 's/[# \\]/\\&/g' | xxd
        00000000: 666f 6f5c 5c0a                           foo\\.
    
    So would they interpret that as the filename 'foo\\' instead of 'foo\' ?
    (Or, no because the 2N slashes aren't followed by a SP, but a NL?)

 generate-configlist.sh | 10 +++++++++-
 meson.build            |  4 +++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/generate-configlist.sh b/generate-configlist.sh
index 75c39ade20..091efd4564 100755
--- a/generate-configlist.sh
+++ b/generate-configlist.sh
@@ -2,10 +2,11 @@
 
 SOURCE_DIR="$1"
 OUTPUT="$2"
+DEPFILE="$3"
 
 if test -z "$SOURCE_DIR" || ! test -d "$SOURCE_DIR" || test -z "$OUTPUT"
 then
-	echo >&2 "USAGE: $0 <SOURCE_DIR> <OUTPUT>"
+	echo >&2 "USAGE: $0 <SOURCE_DIR> <OUTPUT> [<DEPFILE>]"
 	exit 1
 fi
 
@@ -36,3 +37,10 @@ print_config_list () {
 	echo
 	print_config_list
 } >"$OUTPUT"
+
+if test -n "$DEPFILE"
+then
+	printf "$OUTPUT: %s\n" "$0" "$SOURCE_DIR"/Documentation/*config.adoc \
+	    "$SOURCE_DIR"/Documentation/config/*.adoc |
+	    sed 's/[# \\]/\\&/g' >"$DEPFILE"
+fi
diff --git a/meson.build b/meson.build
index 3a1d12caa4..fb5d7367f5 100644
--- a/meson.build
+++ b/meson.build
@@ -720,11 +720,13 @@ endif
 
 builtin_sources += custom_target(
   output: 'config-list.h',
+  depfile: 'config-list.h.d',
   command: [
     shell,
-    meson.current_source_dir() + '/generate-configlist.sh',
+    meson.current_source_dir() / 'generate-configlist.sh',
     meson.current_source_dir(),
     '@OUTPUT@',
+    '@DEPFILE@',
   ],
   env: script_environment,
 )

base-commit: 19a08e0c02faf1c5b4efd1add85598cf8390ff7e
prerequisite-patch-id: 364ba1899740b93be5957262d3583348d030e8fa
-- 
2.52.0.rc0.1058.g68d811a4ee.dirty

