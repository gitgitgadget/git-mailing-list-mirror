Received: from mail-yx1-f66.google.com (mail-yx1-f66.google.com [74.125.224.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31ED5236A73
	for <git@vger.kernel.org>; Mon, 16 Feb 2026 22:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771280953; cv=none; b=gZyggPK/P31i41jH5z9lXaLQaBjc/9vXhUoaCxxTNfIQMJVTVN31ox7K4CeGPYKPY7RxnqlSua8m5FwDbrXCQhqlquFWmtMsiIZSo296gODYmUeJBIzG1L2o8NqYXWD03CXR5SR5TG/Vjsa8iyF2bca6UzK1rq8TjFa1VW8DlAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771280953; c=relaxed/simple;
	bh=uXqSgei+An2/LDp1xAxnxWTzrGAB5p3Gf44F32I4WGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ofo2+CSIfXah8e8x05fc1kNn1ttKZtSU4+5KZsCjN8yGm7/FynCv1u+wqdH6BfjzGNFDiug+xwh6hrc6UE6WdcMDiArt6f3OAUcTNaHpdPOYZYUtwPy3dgDadl/FXsJUSAU440veIGTnK0S1S8fyskXBH531ffmE4f3CNFwch50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eDBXKFl0; arc=none smtp.client-ip=74.125.224.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eDBXKFl0"
Received: by mail-yx1-f66.google.com with SMTP id 956f58d0204a3-64a28af2f4cso4814534d50.1
        for <git@vger.kernel.org>; Mon, 16 Feb 2026 14:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771280951; x=1771885751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rG5NxY4M+Vh6FFdYcw/zy9KbGzMt+kcWJffGzwunCZA=;
        b=eDBXKFl0HPa8AJIv0dOQDvt2rh1MdCvz06dyCBKeMUwTecmCi5eNFgWT0hT+9louYy
         QaTUEs6VMBcUo5kRwoXCEWpV8VpB3Fxgy+ZQP7X/JeAJXMocD1JP7tA7V6bYCT7mWETw
         48byMGMVyhsFV/VgwO3RhLEM+wawWRHtkil9UNoUfTRcoC8emDicDfCUipEf6+QrETnS
         dNM3FekjF3vbM4ot9p9Y9yNOBJZ0tPjEHWVuFYneO7bYjsG5ZX8/ElsU6b5hMM/rYfsA
         /ah6z7Qwf8ZnENVrsu5tF9c8rzzq9ZHdUtwWdIbBtOXmATPPNjVg0mlXNMs/ugo0/I9K
         O5Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771280951; x=1771885751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rG5NxY4M+Vh6FFdYcw/zy9KbGzMt+kcWJffGzwunCZA=;
        b=SxnOzKXB3uBsq1UC02VbnHwnFGUq1y+z+qPwpiGtqdfJwdxaUjF7+JdljDGrz5t2W9
         D3LbQdg55eZyzjTjwLC6hDVk7Lqo2o8/BGwEKRv0Bjs/ZbeZndrXYMDM+9JjMFEqyW6h
         s+dk6SWhOInHC/AFHxSJ+G+gqE9a+kEMJkfjeG6F3N8HP/SIKTVkw9hRI7TdlJFA/qNl
         eUhQaFllwq4JHlGW4TwYvHLnDfMbtQ2S5NlPDJr9/d58jhR+FdNxVTR4KUmiEvMMGISP
         r4RHOQ/EPpmh9nPlwPsiGvP/5ObOrxY17ItmKuMWbNdyb9XNAhFkAIN2ZW/AO5bgk9L2
         DOcQ==
X-Gm-Message-State: AOJu0YyKGNweh2WJojM7ilF6PZFFMxL4LRfdrsgItZNCfGGocqaDxhDR
	YmiRfZ+0bKMnkw7FKw8OoJWjxj5+iVqERY6V4Zti8cPxvMJaknvjV+HoPfOBxopU
X-Gm-Gg: AZuq6aIBcUEohFGlMeVe5XupfO3jdqHgqDeiuJr8Gn9gn/tAlKuapcWTDAKA1dO1DBj
	xjpnxwBy6t+TBRmhnP1CxQpA4N6HVqUuDQTg841Q56I+BlFzSzhqWXqxsaCK15G+ykQI5XxSnme
	xo/pxzOFV7aaNb9IsvyISbAEwzcadIxQ6YSyX/d/hhDuSrnW1NsoEfaXuGtbZRW56L/hcRiLCHX
	0nPqclUcLEc50s5aAAxK+ctrxPkKW/QWsezQxTu4AiCbF+dfXxGInHhfQhzsea0H4bktzGbdmz0
	u81B/tmWa3k/OQ2cTpQ/jsjrCWUSCKm4sOaWn5eB8MBIThaGz5CCXGX6BPA4uiSV9lJOiQIC4lq
	lGmJaFje1Jd1x73oRFldOeoC7rnQRBr1JvioTX9xvrNGUvM3j9sA6NWCnVckJ+hmvOU2wHMWog0
	5pr0RKleiycxll+455FU9PFSBr0O9MFPFXAR5WrFAlf/aiWPrl6EsrRphVQVohnjXeHdcdr9/TC
	384Gm2Sz1ZqPN3cs90RbW7Oa4Jco671l9xY+nmfJW8=
X-Received: by 2002:a05:690e:c4d:b0:64a:db63:99e9 with SMTP id 956f58d0204a3-64c20270399mr7786028d50.23.1771280950577;
        Mon, 16 Feb 2026 14:29:10 -0800 (PST)
Received: from macaroon.lan ([2605:a601:90eb:5600:bd86:3f2a:ab6:399a])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64c22f875b7sm4063073d50.13.2026.02.16.14.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 14:29:10 -0800 (PST)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Patrick Steinhardt <ps@pks.im>,
	Evan Martin <evan.martin@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4] meson: regenerate config-list.h when Documentation changes
Date: Mon, 16 Feb 2026 17:28:57 -0500
Message-ID: <9cdcc9de04f0f8fff657f0474b31c063466ed808.1771280837.git.ben.knoble+github@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <0a344f1f3ee4a5d95c6f46df030b9936db4354a1.1770853297.git.ben.knoble+github@gmail.com>
References: <0a344f1f3ee4a5d95c6f46df030b9936db4354a1.1770853297.git.ben.knoble+github@gmail.com>
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
for globbing like Make. We assume that if a user adds a new file under
Documentation/config then they will also edit one of the existing files
to include that new file, and that will trigger a rebuild.

Also mark the generator script as a dependency.

Combining the following commands helps debug dependencies:

    ninja -C <builddir> -t deps config-list.h
    ninja -C <builddir> -t browse config-list.h

The former lists all the dependencies discovered from our output ".d"
file (the config documentation) and the latter shows the dependency on
the script itself, among other useful edges in the dependency graph.

Helped-by: Patrick Steinhardt <ps@pks.im>
Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
---

Notes (benknoble/commits):
    Changes from v3 (<0a344f1f3ee4a5d95c6f46df030b9936db4354a1.1770853297.git.ben.knoble+github@gmail.com>):
    
    • Include the script itself as a dependency via depfile
    • Fix output path escaping (spaces, octothorpes; drop backslashes) for
      Ninja (I've used a loop because I couldn't find a portable construct
      that could escape only the remainder of the lines in the way I
      wanted).
    • Mention our assumptions about Documentation updates triggering
      rebuilds
    • Also include some debugging information in the commit message

 generate-configlist.sh | 12 +++++++++++-
 meson.build            |  5 ++++-
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/generate-configlist.sh b/generate-configlist.sh
index 75c39ade209..63a2e8b6938 100755
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
 
@@ -36,3 +37,12 @@ print_config_list ()
 	echo
 	print_config_list
 } >"$OUTPUT"
+
+if test -n "$DEPFILE"
+then
+	for doc in "$SOURCE_DIR"/Documentation/*config.adoc \
+		"$SOURCE_DIR"/Documentation/config/*.adoc
+	do
+		printf "$OUTPUT: %s\n" "$(printf '%s\n' "$doc" | sed 's/[# ]/\\&/g')"
+	done >"$DEPFILE"
+fi
diff --git a/meson.build b/meson.build
index 3a1d12caa4b..e4b8f1e33d2 100644
--- a/meson.build
+++ b/meson.build
@@ -720,11 +720,14 @@ endif
 
 builtin_sources += custom_target(
   output: 'config-list.h',
+  depfile: 'config-list.h.d',
+  depend_files: [ 'generate-configlist.sh' ],
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

Diff-intervalle contre v3 :
1:  0a344f1f3ee ! 1:  9cdcc9de04f meson: regenerate config-list.h when Documentation changes
    @@ Commit message
         Teach the meson build to depend on the Documentation files that
         generate-configlist.sh reads by having it an additional output as a list
         of dependency files, since Meson does not have (or want) builtin support
    -    for globbing like Make.
    +    for globbing like Make. We assume that if a user adds a new file under
    +    Documentation/config then they will also edit one of the existing files
    +    to include that new file, and that will trigger a rebuild.
    +
    +    Also mark the generator script as a dependency.
    +
    +    Combining the following commands helps debug dependencies:
    +
    +        ninja -C <builddir> -t deps config-list.h
    +        ninja -C <builddir> -t browse config-list.h
    +
    +    The former lists all the dependencies discovered from our output ".d"
    +    file (the config documentation) and the latter shows the dependency on
    +    the script itself, among other useful edges in the dependency graph.
     
         Helped-by: Patrick Steinhardt <ps@pks.im>
    +    Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
     
     
      ## Notes (benknoble/commits) ##
    -    Changes from v2 (<c9ae171eed6bd5b0fa6671b10a5ad0da024f36d0.1770649805.git.ben.knoble+github@gmail.com>):
    +    Changes from v3 (<0a344f1f3ee4a5d95c6f46df030b9936db4354a1.1770853297.git.ben.knoble+github@gmail.com>):
     
    -    • Pick up (and tweak) Patrick's depfile proposal
    -    • Include the script itself as a dependency
    -    • Escape output paths (spaces, octothorpes, and backslashes) for Ninja
    -
    -    I'm not 100% sure I've actually done the escaping correctly, though,
    -    since Ninja's source says that a space preceded by 2N backslashes
    -    represents 2N backslashes at the end of a filename, and
    -
    -        λ printf '%s\n' 'foo\' | sed 's/[# \\]/\\&/g' | xxd
    -        00000000: 666f 6f5c 5c0a                           foo\\.
    -
    -    So would they interpret that as the filename 'foo\\' instead of 'foo\' ?
    -    (Or, no because the 2N slashes aren't followed by a SP, but a NL?)
    +    • Include the script itself as a dependency via depfile
    +    • Fix output path escaping (spaces, octothorpes; drop backslashes) for
    +      Ninja (I've used a loop because I couldn't find a portable construct
    +      that could escape only the remainder of the lines in the way I
    +      wanted).
    +    • Mention our assumptions about Documentation updates triggering
    +      rebuilds
    +    • Also include some debugging information in the commit message
     
      ## generate-configlist.sh ##
     @@
    @@ generate-configlist.sh: print_config_list ()
     +
     +if test -n "$DEPFILE"
     +then
    -+	printf "$OUTPUT: %s\n" "$0" "$SOURCE_DIR"/Documentation/*config.adoc \
    -+	    "$SOURCE_DIR"/Documentation/config/*.adoc |
    -+	    sed 's/[# \\]/\\&/g' >"$DEPFILE"
    ++	for doc in "$SOURCE_DIR"/Documentation/*config.adoc \
    ++		"$SOURCE_DIR"/Documentation/config/*.adoc
    ++	do
    ++		printf "$OUTPUT: %s\n" "$(printf '%s\n' "$doc" | sed 's/[# ]/\\&/g')"
    ++	done >"$DEPFILE"
     +fi
     
      ## meson.build ##
    @@ meson.build: endif
      builtin_sources += custom_target(
        output: 'config-list.h',
     +  depfile: 'config-list.h.d',
    ++  depend_files: [ 'generate-configlist.sh' ],
        command: [
          shell,
     -    meson.current_source_dir() + '/generate-configlist.sh',

base-commit: 19a08e0c02faf1c5b4efd1add85598cf8390ff7e
prerequisite-patch-id: 364ba1899740b93be5957262d3583348d030e8fa
-- 
2.48.1

